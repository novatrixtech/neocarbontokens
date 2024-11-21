// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.25;

import {CarbonProject} from "../src/CarbonProject.sol";
import {Test, console} from "forge-std/Test.sol";

contract CarbonProjectTest is Test {
    string public uri = "https://www.neocarbon.com.br/br/registro/projeto?id={id}";
    address public owner = address(0x123);

    CarbonProject public carbonProject;

    function setUp() public {
        carbonProject = new CarbonProject(uri, owner);
    }

    function test_CarbonProject() public view {
        console.log("CarbonProject: ", address(carbonProject));
        console.log("URI: ", carbonProject.uri(5451));
        console.log("Owner: ", carbonProject.owner());
        assertEq(carbonProject.uri(5451), uri);
        assertEq(carbonProject.owner(), owner);
    }

    function testFail_SetDataNotOwner() public {
        setDataTest();
    }

    function test_SetData() public {
        vm.prank(owner);
        setDataTest();
        (uint256 id,
        string memory nameNumber,
        string memory proposer,
        string memory activity,
        string memory location,
        string memory status,
        uint256 startDate,
        uint256 endDate,
        uint256 period,
        string memory areaSize,
        bool projectDataSet) = carbonProject.getProjectData();
        console.log("Project Data: ", projectDataSet);
        // assertEq(projectDataSet, true);
        assertEq(id, 4561);
        assertEq(nameNumber, "MTALT20230003");
        assertEq(proposer, "AGROPECUARIA J L LTDA");
        assertEq(activity, "Unidade de Carbono Florestal - ARR + REDD");
        assertEq(location, "Alto Taquari/MT/BRA");
        assertEq(status, "Registrado");
        assertEq(startDate, 1691971200);
        assertEq(endDate, 1723593600);
        assertEq(period, 315360000);
        assertEq(areaSize, "2102.83 hectares");
    }

    function testFail_SetDataTwice() public {
        vm.prank(owner);
        setDataTest();
        vm.prank(owner);
        setDataTest();
    }

    function setDataTest() public {
        bool executed = carbonProject.setProjectData(
            4561,
            "MTALT20230003",
            "AGROPECUARIA J L LTDA",
            "Unidade de Carbono Florestal - ARR + REDD",
            "Alto Taquari/MT/BRA",
            "Registrado",
            1691971200,
            1723593600,
            315360000,
            "2102.83 hectares");

        console.log("CarbonProject: ", address(carbonProject));
        console.log("Executed setProjectData: ", executed);
        assertEq(executed, true);
    }
}
