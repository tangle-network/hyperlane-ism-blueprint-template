// SPDX-License-Identifier: MIT OR Apache-2.0
pragma solidity >=0.8.0;

import {Test} from "forge-std/Test.sol";
import "forge-std/console.sol";

import {TypeCasts} from "node_modules/@hyperlane-xyz/core/contracts/libs/TypeCasts.sol";
import {TestSendReceiver} from "node_modules/@hyperlane-xyz/core/contracts/test/TestSendReceiver.sol";
import {TestMailbox} from "node_modules/@hyperlane-xyz/core/contracts/test/TestMailbox.sol";
import {MpcIsm} from "../src/MpcIsm.sol";
import {TestInterchainGasPaymaster} from "node_modules/@hyperlane-xyz/core/contracts/test/TestInterchainGasPaymaster.sol";
import {TestMerkleTreeHook} from "node_modules/@hyperlane-xyz/core/contracts/test/TestMerkleTreeHook.sol";
import {Message} from "node_modules/@hyperlane-xyz/core/contracts/libs/Message.sol";

contract MpcIsmTest is Test {
    using Message for bytes;
    using TypeCasts for address;

    uint32 internal constant TEST_ORIGIN_DOMAIN = 1;
    uint32 internal constant TEST_DESTINATION_DOMAIN = 2;
    bytes internal constant TEST_MESSAGE_CONTENT = bytes("Bonjour");

    TestMailbox mailbox;
    MpcIsm ism;
    TestInterchainGasPaymaster igp;
    TestSendReceiver testSendReceiver;
    uint256 internal gasPayment;
    bytes internal testMessage;
    address mpc = address(0x1234);

    function setUp() public {
        mailbox = new TestMailbox(TEST_ORIGIN_DOMAIN);
        ism = new MpcIsm(address(mailbox), mpc);
        igp = new TestInterchainGasPaymaster();
        TestMerkleTreeHook requiredHook = new TestMerkleTreeHook(
            address(mailbox)
        );
        mailbox.initialize(
            address(this),
            address(ism),
            address(igp),
            address(requiredHook)
        );
        testSendReceiver = new TestSendReceiver();

        gasPayment = mailbox.quoteDispatch(
            TEST_DESTINATION_DOMAIN,
            address(testSendReceiver).addressToBytes32(),
            TEST_MESSAGE_CONTENT
        );
        testMessage = mailbox.buildOutboundMessage(
            TEST_DESTINATION_DOMAIN,
            address(testSendReceiver).addressToBytes32(),
            TEST_MESSAGE_CONTENT
        );
    }

    function testInitialState() public {
        assertEq(ism.mpcAddress(), mpc);
        assertEq(address(ism.mailbox()), address(mailbox));
    }

    function testCannotSetZeroMpcAddress() public {
        vm.prank(mpc);
        vm.expectRevert("MpcIsm: invalid MPC address");
        ism.setMpcAddress(address(0));
    }

    function testCannotSetMpcAddressIfNotCurrentMpc() public {
        vm.prank(address(0xdead));
        vm.expectRevert("MpcIsm: only current MPC can update");
        ism.setMpcAddress(address(0xbeef));
    }

    function testSetMpcAddress() public {
        address newMpc = address(0xbeef);
        
        vm.prank(mpc);
        vm.expectEmit(true, true, false, false);
        emit MpcIsm.MpcAddressUpdated(mpc, newMpc);
        ism.setMpcAddress(newMpc);

        assertEq(ism.mpcAddress(), newMpc);
    }
}
