// SPDX-License-Identifier: MIT

pragma solidity 0.6.6;

contract BEC_Target {

    mapping(address => uint) balances;

    function batchTransfer(address[] memory _receivers, uint256 _value) public payable returns (bool) {
        uint cnt = _receivers.length; // get the length of the array
        uint256 amount = uint256(cnt) * _value;
        require(cnt > 0 && cnt <= 20);
        require(_value > 0 && balances[msg.sender] >= amount); // check if the sender has enough balance to transfer
        
        balances[msg.sender] = balances[msg.sender] - amount; // deduct the total amount from the sender's balance
        for (uint i = 0; i < cnt; i++) {
            balances[_receivers[i]] = balances[_receivers[i]] + _value; // add the value to each receiver's balance  
            //Transfer(msg.sender, _receivers[i], _value); // emit the Transfer event
        }
        return true;
    }

    function deposit() public payable  {
        balances[msg.sender] += msg.value;
    }

    function getBalance() public view returns(uint) {
        return balances[msg.sender];
    }
}

