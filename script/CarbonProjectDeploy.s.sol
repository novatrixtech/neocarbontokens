// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.25;

import {Script, console} from "forge-std/Script.sol";
import {CarbonProject} from "../src/CarbonProject.sol";

contract CarbonProjectDeployScript is Script {
    CarbonProject public cp;

    function setUp() public {}

    function run() public {
        vm.startBroadcast();

        cp = new CarbonProject("https://www.neocarbon.com.br/br/registro/projeto?id={id}");

        vm.stopBroadcast();
    }
}