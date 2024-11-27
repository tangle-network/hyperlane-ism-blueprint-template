// SPDX-License-Identifier: MIT OR Apache-2.0
pragma solidity >=0.8.13;

import {IInterchainSecurityModule} from "@hyperlane-xyz/core/contracts/interfaces/IInterchainSecurityModule.sol";
import {Address} from "@openzeppelin/contracts/utils/Address.sol";
import {Message} from "@hyperlane-xyz/core/contracts/libs/Message.sol";
import {Mailbox} from "@hyperlane-xyz/core/contracts/Mailbox.sol";
import {PackageVersioned} from "@hyperlane-xyz/core/contracts/PackageVersioned.sol";

contract MpcIsm is IInterchainSecurityModule, PackageVersioned {
    using Message for bytes;

    uint8 public immutable moduleType = uint8(Types.NULL);
    Mailbox public immutable mailbox;
    address public mpcAddress;

    event MpcAddressUpdated(address indexed oldAddress, address indexed newAddress);

    constructor(address _mailbox, address _initialMpcAddress) {
        require(
            _initialMpcAddress != address(0),
            "MpcIsm: invalid MPC address"
        );
        require(
            Address.isContract(_mailbox),
            "MpcIsm: invalid mailbox"
        );
        mailbox = Mailbox(_mailbox);
        mpcAddress = _initialMpcAddress;
    }

    function setMpcAddress(address _newMpcAddress) external {
        require(msg.sender == mpcAddress, "MpcIsm: only current MPC can update");
        require(_newMpcAddress != address(0), "MpcIsm: invalid MPC address");
        
        address oldAddress = mpcAddress;
        mpcAddress = _newMpcAddress;
        
        emit MpcAddressUpdated(oldAddress, _newMpcAddress);
    }

    function verify(
        bytes calldata,
        bytes calldata message
    ) external view returns (bool) {
        return mailbox.processor(message.id()) == mpcAddress;
    }
}
