pragma solidity ^0.8.0;

contract Caster {
    bytes16 public recentResult;
    
    function cast(bytes32 _input) public {
        recentResult = bytes16(_input);
    }
}
