// SPDX-License-Identifier: MIT OR Apache-2.0
pragma solidity >=0.8.13;

import {IInterchainSecurityModule} from "node_modules/@hyperlane-xyz/core/contracts/interfaces/IInterchainSecurityModule.sol";
import {AbstractAggregationIsm} from "node_modules/@hyperlane-xyz/core/contracts/isms/aggregation/AbstractAggregationIsm.sol";
import {Message} from "node_modules/@hyperlane-xyz/core/contracts/libs/Message.sol";
import {MetaProxy} from "node_modules/@hyperlane-xyz/core/contracts/libs/MetaProxy.sol";
import {PackageVersioned} from "node_modules/@hyperlane-xyz/core/contracts/PackageVersioned.sol";

/**
 * @title HyperlaneISM
 * @notice A custom Hyperlane Interchain Security Module (ISM) implementation
 * @dev Inherits from IInterchainSecurityModule and PackageVersioned
 */
contract HyperlaneISM is AbstractAggregationIsm, PackageVersioned {
    using Message for bytes;

    /**
     * @notice Returns the modules and threshold required for verification
     * @param _message The message to verify
     * @return modules The array of ISM modules
     * @return threshold The number of modules that must verify for success
     */
    function modulesAndThreshold(
        bytes calldata _message
    ) public view virtual override returns (address[] memory, uint8) {
        return abi.decode(MetaProxy.metadata(), (address[], uint8));
    }
}
