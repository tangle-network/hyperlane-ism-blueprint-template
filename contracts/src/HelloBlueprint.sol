// SPDX-License-Identifier: MIT OR Apache-2.0
pragma solidity >=0.8.13;

import "tnt-core/BlueprintServiceManagerBase.sol";

/**
 * @title HelloBlueprint
 * @dev This contract is an example of a service blueprint that provides a single service.
 * @dev For all supported hooks, check the `BlueprintServiceManagerBase` contract.
 */
contract HelloBlueprint is BlueprintServiceManagerBase {
    /**
     * @dev Hook for service operator registration. Called when a service operator
     * attempts to register with the blueprint.
     * @param operator The operator's details.
     * @param registrationInputs Inputs required for registration.
     */
    function onRegister(
        ServiceOperators.OperatorPreferences calldata operator,
        bytes calldata registrationInputs
    )
    external
    payable
    override
    onlyFromMaster
    {
        // Do something with the operator's details
    }

    function onRequest(
        uint64 requestId,
        address requester,
        ServiceOperators.OperatorPreferences[] calldata operators,
        bytes calldata requestInputs,
        address[] calldata permittedCallers,
        uint64 ttl
    )
    external
    payable
    override
    onlyFromMaster
    {
        // Do something with the service request
    }

    function onJobResult(
        uint64 serviceId,
        uint8 job,
        uint64 jobCallId,
        ServiceOperators.OperatorPreferences calldata operator,
        bytes calldata inputs,
        bytes calldata outputs
    )
    external
    payable
    override
    onlyFromMaster
    {
        // Do something with the job call result
    }

    /**
     * @dev Converts a public key to an operator address.
     * @param publicKey The public key to convert.
     * @return operator address The operator address.
     */
    function operatorAddressFromPublicKey(bytes calldata publicKey) internal pure returns (address operator) {
        return address(uint160(uint256(keccak256(publicKey))));
    }
}
