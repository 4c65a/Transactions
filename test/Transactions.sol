// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console2} from "forge-std/Test.sol";
import {Transactions} from "src/Transactions.sol";

contract transactionsTest is Test {
    Transactions public transactions;
    Register register;

    function setUp() public {
        transactions = new transactions();

        register.sender = msg.sender;
        register.receiver = address(0xb498951524f87a4162e447e6eea3879b244e31efdbb399b2416d903a17ad5a5f);
        register.amount = 55;
        register.messager = "Test of smart contract";
    }

    function testAddRegistred() public {
        transactions.addRegistred(address(),55,"Test add Registred");
        assertEq(a, b);
    }

    function testGetRegistreAll() public {}

    function testDeleteArrayElement() public {}
    
}
