// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console2} from "forge-std/Test.sol";
import {Transactions} from "../src/Transactions.sol";

contract transactionsTest is Test {
    Transactions public transactions;

    function setUp() public {
        transactions = new Transactions();
    
    }
}
