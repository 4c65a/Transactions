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
contract transactions is Ownable{

    /// Count the quantity of transaction.
    uint private transactionCount;
    uint16 public amountEther;
    


    constructor(address _proprietor, uint16 _amountEther) Ownable(_proprietor){
        amountEther = _amountEther;
    }


    /// Register structure of each transactions
    struct Register {
        address sender;
        address receiver;
        uint amount;
        string messager;
    }

    Register[] register;

    /// Event log transaction between tow addresses with amount and menssage.
    event Transaction(
        address indexed from,
        address indexed receiver,
        uint amount,
        string messager
    );


    /**
     * @notice  .
     * @dev     .
     * @param   _receiver  .
     * @param   _amount  .
     * @param   _messager  .
     */
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

    /**
     * @notice  .
     * @dev     .
     * @param   _index  .
     * @return  Register  .
     */
    function getRegistre(uint8 _index) public view returns (Register memory) {
        require(_index < register.length, "Invalid index");
        return register[_index];
    }

    /**
     * @notice  .
     * @dev     .
     * @param   _index  .
     * @return  Register[]  .
     */
    function getRegistreAll(
        uint8 _index
    ) public view returns (Register[] memory) {
        require(_index < register.length, "Invalid index");
        return register;
    }

    /**
     * @notice  .
     * @dev     .
     * @param   _index  .
     */
    function deleteArrayElement(uint8 _index) public onlyOwner {
        require(_index < register.length, "Invalid index");

        for (uint i = _index; i < register.length - 1; i++) {
            register[i] = register[i + 1];
        }
        register.pop();
    }

    /**
     * @notice  .
     * @dev     .
     * @param   _index  .
     */
    function deleteArrayElementAll(uint8 _index) public onlyOwner {
        require(_index < register.length, "Invalid index");
        delete register;
    }
}
