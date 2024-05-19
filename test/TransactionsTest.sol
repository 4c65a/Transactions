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

    event transactionEvent(
        address indexed from,
        address indexed receiver,
        uint256 amount,
        string message
    );

    function setUp() public {
        transactions = new Transactions(msg.sender, 100);
    }


    function TestGetAmountEther() public {
        uint16 expectedValue = transactions.getAmountEther();
        assertEq(expectedValue, 100, "Amount ether should match initial value");
    }

    function testAddTransactions() public {
        transactions = new Transactions(msg.sender, 10);
        address lucy = address(0x1);
        address jonh = address(0x2);
        address alice = address(0x3);

     
        vm.expectRevert("Insufficient amount of ether");
        transactions.addTransactions(jonh, lucy, 0, "Hello Lucy");



        vm.expectEmit(true, true, true, true);
        emit transactionEvent(alice, lucy, 100, "Hello Lucy");
        transactions.addTransactions(alice, lucy, 100, "Hello Lucy");

    }

  
    function testSetAmountEther() public {
        uint16 expectedValue = transactions.getAmountEther();
        assertEq(expectedValue, 100, "Amount ether should match initial value");


        address lucy = address(0x1);

        vm.prank(lucy);
        bool Revert = false;

        try transactions.setAmountEther(200) {
        } catch {
            Revert = true;
        }

        assertTrue(Revert, "The function should revert");

        vm.startPrank(address(msg.sender));
        transactions.setAmountEther(200);
        vm.stopPrank();
        uint16 newAmount = transactions.getAmountEther();
        assertEq(newAmount, 200, "Amount ether should match initial value");
    }

    function testGetTransactions() public {
        address lucy = address(0x1);
        address alice = address(0x2);
        uint16 amount = 100;
        string memory message = "Hello Lucy";

        transactions.addTransactions(alice, lucy, amount, message);
        transactions.getTransactions(0);

        vm.expectRevert("Invalid index");
        transactions.getTransactions(1);
    }

    function testGetAllTransactions() public {
        address lucy = address(0x1);
        address alice = address(0x2);
        uint16 amount = 100;
        uint16 amount1 = 100;
        string memory message = "Hello Lucy";

        transactions.addTransactions(alice, lucy, amount, message);
        transactions.addTransactions(alice, lucy, amount1, message);

        transactions.getAllTransactions();

      

    }

    function testDeleteTransaction() public {
        address lucy = address(0x1);
        address alice = address(0x2);
        uint16 amount = 100;
        string memory message = "Hello Lucy";

        transactions.addTransactions(alice, lucy, amount, message);

        vm.startPrank(address(msg.sender));
        transactions.deleteTransaction(0);
        vm.stopPrank();

        vm.startPrank(address(msg.sender));
        vm.expectRevert("Invalid index");
        transactions.deleteTransaction(1);
        vm.stopPrank();


        vm.prank(lucy);
        
        bool Revert = false;

        try transactions.deleteTransaction(0) {
        } catch {
            Revert = true;
        }

        assertTrue(Revert, "The function should revert");

    }
}
