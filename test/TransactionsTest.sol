// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test} from "forge-std/Test.sol";
import "forge-std/Vm.sol";
// import "forge-std/console.sol";
import {Transactions} from "../src/Transactions.sol";

/*//////////////////////////////////////////////////////////////
                        Test of Transactions 
//////////////////////////////////////////////////////////////*/
contract transactionsTest is Test {
    Transactions public transactions;

    function setUp() public {
        transactions = new Transactions(msg.sender, 100);
    }

    // Get balance > 0 ETher
    function TestGetAmountEther() public {
        uint16 expectedValue = transactions.getAmountEther();
        assertEq(expectedValue, 100, "Amount ether should match initial value");
    }

    function testAddRegistred() public {
        //transactions = new Transactions(msg.sender, 100);
        //address alice = address(1);
        //transactions.addRegistred(alice, 10, "Hello");
    }

    // Change quantities of ETH > 100 ETH to 200 ETH
    function testSetAmountEther() public {
        //transactions = new Transactions(msg.sender, 0);
        uint16 expectedValue = transactions.getAmountEther();
        assertEq(expectedValue, 100, "Amount ether should match initial value");

        // Defines a non-owner address.
        address nonOwner = address(0x1);

        // Simulates a transaction from the non-owner address.
        vm.prank(nonOwner); 
        bool didRevert = false;
        
        // Attempts to withdraw from the EtherWallet as a non-owner.
        try transactions.setAmountEther(200) {
            // This block should not execute as the transaction should revert.
        } catch {
            // Sets the flag to true if the transaction reverts, indicating the test passed.
            didRevert = true;
        }
       
        assertTrue(didRevert, "");

        vm.startPrank(address(msg.sender));
        transactions.setAmountEther(200);
        vm.stopPrank();
        uint16 newAmount = transactions.getAmountEther();
        assertEq(newAmount, 200, "Amount ether should match initial value");
    }

    function testGetRegister() public {}

    function testGetAllTransactions() public {}

    function testDeleteTransaction() public {}
}
