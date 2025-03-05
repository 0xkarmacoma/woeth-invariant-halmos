// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

import {ERC20} from "openzeppelin/contracts/token/ERC20/ERC20.sol";

import {Test} from "forge-std/Test.sol";
import {SymTest} from "halmos-cheatcodes/SymTest.sol";

import {OETH} from "origin-dollar/contracts/contracts/token/OETH.sol";
import {WOETH} from "origin-dollar/contracts/contracts/token/WOETH.sol";

contract FuzzSetup is Test, SymTest {
    uint256 internal constant DEAD_AMOUNT = 1e16;
    address internal constant DEAD_ADDRESS = address(0xDEAD);

    OETH oeth;
    WOETH woeth;

    function setUp() external {
        // Deploy OETH
        oeth = new OETH();
        oeth.initialize(address(this), 1e26);

        // Deploy WOETH
        woeth = new WOETH(oeth);
        woeth.initialize();

        // Mint starting wOETH to dead address
        oeth.approve(address(woeth), DEAD_AMOUNT);
        oeth.mint(address(this), DEAD_AMOUNT);
        woeth.deposit(1e16, DEAD_ADDRESS);
    }
}
