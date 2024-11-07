// SPDX-License-Identifier: MIT OR Apache-2.0
pragma solidity >=0.8.0;

// ============ Internal Imports ============
import {MpcIsm} from "../src/MpcIsm.sol";
import {StaticThresholdAddressSetFactory} from "node_modules/@hyperlane-xyz/core/contracts/libs/StaticAddressSetFactory.sol";

contract MpcAggregationIsmFactory is StaticThresholdAddressSetFactory {
    function _deployImplementation()
        internal
        virtual
        override
        returns (address)
    {
        return address(new MpcIsm());
    }
}
