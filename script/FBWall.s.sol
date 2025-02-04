// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Script, console} from "forge-std/Script.sol";
import {FBWall} from "../src/FBWall.sol";

contract FBWallScript is Script {
    FBWall public fbwall;

    function setUp() public {}

    function run() public {
        vm.startBroadcast();

        fbwall = new FBWall();

        vm.stopBroadcast();
    }
}
