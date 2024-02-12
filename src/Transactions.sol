// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "../lib/openzeppelin-contracts/contracts/access/Ownable.sol";
/*
    Smart Contract para obtener registros de transacciones en la blockchain.
*/
contract transactions is Ownable(msg.sender) {
    error transactionError(string Error);

    uint private transactionCount;

    struct Register {
        address sender;
        address receiver;
        uint amount;
        string messager;
    }

    Register[] register;

    event Transaction(
        address indexed from,
        address indexed receiver,
        uint amount,
        string messager
    );

    function addRegistred(
        address _receiver,
        uint _amount,
        string memory _messager
    ) public {
        transactionCount += 1;
        register.push(Register(msg.sender, _receiver, _amount, _messager));
        emit Transaction(msg.sender, _receiver, _amount, _messager);
    }

    function getRegister(uint8 _index) public view returns (Register memory) {
        require(_index < register.length, "Invalid index");
        return register[_index];
    }

    function getRegistreAll() public view returns (Register[] memory) {
        require(_index < register.length, "Invalid index"); 
        return register;
    }

    function deleteArrayElement(uint8 _index) public onlyOwner {
        require(_index < register.length, "Invalid index");

        for (uint i = _index; i < register.length - 1; i++) {
            register[i] = register[i + 1];
        }
        register.pop();
    }

    function deleteArrayElementAll() public onlyOwner {
        require(_index < register.length, "Invalid index");
        delete register;
    }
}
