// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "../lib/openzeppelin-contracts/contracts/access/Ownable.sol";

/*//////////////////////////////////////////////////////////////
                Transactions Solidity Ethereum 
//////////////////////////////////////////////////////////////*/

/**
 * @title   Transactions in Blockchain.
 * @notice  Practice project.
 * @author  Leandro
 */
contract Transactions is Ownable {
    // Count the quantity of transactions.
    uint256 private transactionCount;

    // Amount of ether allowed per transaction.
    uint16 private amountEther;

    /**
     * @dev Constructor to initialize the contract.
     * @param _proprietor The address of the contract proprietor.
     * @param _amountEther The initial amount of ether allowed per transaction.
     */
    constructor(address _proprietor, uint16 _amountEther) Ownable(_proprietor) {
        amountEther = _amountEther;
    }

    // Register structure for each transaction.
    struct Register {
        address sender;
        address receiver;
        uint256 amount;
        string messager;
    }

    Register[] register;

    // Event for logging transactions between two addresses with amount and message.
    event Transaction(address indexed from, address indexed receiver, uint256 amount, string messager);

    /**
     * @notice Get the current amount of ether allowed per transaction.
     * @return The amount of ether as a uint16.
     */
    function getAmountEther() public view returns (uint16) {
        return amountEther;
    }

    /**
     * @notice Set the amount of ether allowed per transaction.
     * @param _amountEther The new amount of ether as a uint16.
     * @dev Only callable by the owner of the contract.
     */
    function setAmountEther(uint16 _amountEther) public onlyOwner {
        amountEther = _amountEther;
    }

    /**
     * @notice Add a new transaction to the register.
     * @param _receiver The address of the transaction receiver.
     * @param _amount The amount of ether sent in the transaction.
     * @param _messager The message associated with the transaction.
     */
    function addRegistred(address _receiver, uint256 _amount, string memory _messager) public {
        transactionCount += 1;
        register.push(Register(msg.sender, _receiver, _amount, _messager));
        require(_amount >= amountEther, "Insufficient amount of ether");
        emit Transaction(msg.sender, _receiver, _amount, _messager);
    }

    /**
     * @notice Get a specific transaction by index.
     * @param _index The index of the transaction to retrieve.
     * @return The transaction details as a Register struct.
     */
    function getRegister(uint8 _index) public view returns (Register memory) {
        require(_index < register.length, "Invalid index");
        return register[_index];
    }

    /**
     * @notice Get all transactions.
     * @return An array containing all transactions.
     */
    function getAllTransactions() public view returns (Register[] memory) {
        return register;
    }

    /**
     * @notice Delete a transaction by index.
     * @param _index The index of the transaction to delete.
     * @dev Only callable by the owner of the contract.
     */
    function deleteTransaction(uint8 _index) public onlyOwner {
        require(_index < register.length, "Invalid index");
        for (uint256 i = _index; i < register.length - 1; i++) {
            register[i] = register[i + 1];
        }
        register.pop();
    }
}
