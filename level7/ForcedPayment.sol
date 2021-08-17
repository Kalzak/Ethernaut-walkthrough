pragma solidity ^0.8.0;

contract ForcedPayment {
    // Self destructs and directs funds to a target address
    function forcePaymentToContract(address _targetAddress) public {
        address payable targetAddressPayable = payable(_targetAddress);
        selfdestruct(targetAddressPayable);
    }
    
    // Fallback funnction to load funds into this contract
    fallback() external payable {
        
    }
}
