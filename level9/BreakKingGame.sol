pragma solidity ^0.8.0;

contract BreakKingGame {
    function sendFunds(address payable _recipient) public payable {
        (bool success, ) = _recipient.call{value:msg.value}("");
        require(success, "Transfer failed.");
    }
}
