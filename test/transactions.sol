// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console2} from "forge-std/Test.sol";
import {Transaction} from "../src/Transaction.sol";

contract transactionTest is Test {
    Counter public counter;

    function setUp() public {
        counter = new Counter();

    }


}
