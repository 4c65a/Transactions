// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test} from "forge-std/Test.sol";
import "forge-std/Vm.sol";
// import "forge-std/console.sol";
import {Transactions} from "../src/Transactions.sol";

/*//////////////////////////////////////////////////////////////
                    Test of Transactions 
//////////////////////////////////////////////////////////////*/
contract TransactionsTest is Test {
    Transactions public transactions;

    function setUp() public {
        transactions = new Transactions(msg.sender, 100);
    }

    // Get balance > 0 ETher
    function TestGetAmountEther() public {
        uint16 expectedValue = transactions.getAmountEther();
        assertEq(expectedValue, 100, "Amount ether should match initial value");
    } 

    function testAddTransactions() public {
        transactions = new Transactions(msg.sender, 10);
        address lucy = address(1);
        address jonh = address(2);
        address alice = address(3);

        vm.startPrank(jonh);
        vm.expectRevert("Insufficient amount of ether");
        transactions.addTransactions(jonh,lucy, 0, "Hello Lucy");
        vm.stopPrank();

       
        

        vm.startPrank(alice);
        vm.expectEmit(true, true, true,true);
        emit Transactions.transactionEvent(alice, lucy, 100, "Hello Lucy");
        transactions.addTransactions(alice,lucy, 100, "Hello Lucy");
        vm.stopPrank();

    }

    // Change quantities of ETH > 100 ETH to 200 ETH
    function testSetAmountEther() public {
        //transactions = new Transactions(msg.sender, 0);
        uint16 expectedValue = transactions.getAmountEther();
        assertEq(expectedValue, 100, "Amount ether should match initial value");

        // Defines a non-owner address.
        address lucy = address(0x1);

        // Simulates a transaction from the non-owner address.
        vm.prank(lucy); 
        bool didRevert = false;
        
        try transactions.setAmountEther(200) {
            // This block should not execute as the transaction should revert.
        } catch {
            // Sets the flag to true if the transaction reverts, indicating the test passed.
            didRevert = true;
        }
       
        assertTrue(didRevert, "The function should revert");

        vm.startPrank(address(msg.sender));
        transactions.setAmountEther(200);
        vm.stopPrank();
        uint16 newAmount = transactions.getAmountEther();
        assertEq(newAmount, 200, "Amount ether should match initial value");
    }

    function testGetTransactions() public {

    }

    function testGetAllTransactions() public {}

    function testDeleteTransaction() public {}
}
