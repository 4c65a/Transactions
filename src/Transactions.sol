// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "../lib/openzeppelin-contracts/contracts/access/Ownable.sol";

/*//////////////////////////////////////////////////////////////
                Transactions Solidity Ethereum 
//////////////////////////////////////////////////////////////*/

/**
 * @author  Leandro.
 * @title   Transactions in Blockachain.
 * @notice  Practice project.
 */
contract Transactions is Ownable {

    // Count the quantity of transaction.
    uint private transactionCount;
    uint16 public amountEther;

    constructor(address _proprietor, uint16 _amountEther) Ownable(_proprietor) {
        amountEther = _amountEther;
    }

    // Register structure of each transactions
    struct Register {
        address sender;
        address receiver;
        uint amount;
        string messager;
    }

    Register[] register;

    // Event log transaction between two addresses with amount and message.
    event Transaction(
        address indexed from,
        address indexed receiver,
        uint amount,
        string messager
    );

    // Add a new transaction to the register
    function addRegistred(
        address _receiver,
        uint _amount,
        string memory _messager
    ) public {
        transactionCount += 1;
        register.push(Register(msg.sender, _receiver, _amount, _messager));
        require(_amount >= amountEther, "Insufficient amount of ether");
        emit Transaction(msg.sender, _receiver, _amount, _messager);
    }

    // Get a specific transaction by index
    function getRegister(uint8 _index) public view returns (Register memory) {
        require(_index < register.length, "Invalid index");
        return register[_index];
    }

    // Get all transactions
    function getAllTransactions() public view returns (Register[] memory) {
        return register;
    }

    // Delete a transaction by index
    function deleteTransaction(uint8 _index) public onlyOwner {
        require(_index < register.length, "Invalid index");
        for (uint i = _index; i < register.length - 1; i++) {
            register[i] = register[i + 1];
        }
        register.pop();
    }
}