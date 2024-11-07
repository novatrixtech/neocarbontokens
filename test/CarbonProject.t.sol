// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.25;

import {CarbonProject} from "../src/CarbonProject.sol";
import {Test, console} from "forge-std/Test.sol";

contract CarbonProjectTest is Test {
    string public uri = "https://www.neocarbon.com.br/br/registro/projeto?id={id}";

    CarbonProject public carbonProject;

    function setUp() public {
        carbonProject = new CarbonProject(uri);
    }

    function test_CarbonProject() public view {
        console.log("CarbonProject: ", address(carbonProject));
        console.log("URI: ", carbonProject.uri(5451));
        assertEq(carbonProject.uri(5451), uri);
    }
}
