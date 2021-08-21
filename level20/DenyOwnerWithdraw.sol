pragma solidity ^0.8.0;

contract DenyOwnerWithdraw {
    fallback() payable external {
        uint i = 0;
        while(i == 0) {
            i = 0;
        }
    }
}
