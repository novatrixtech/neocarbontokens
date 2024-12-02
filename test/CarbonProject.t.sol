// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.25;

import {CarbonProject} from "../src/CarbonProject.sol";
import {Test, console} from "forge-std/Test.sol";

contract CarbonProjectTest is Test {
    string public uri = "";
    address public owner = address(0x123);
    uint256 public initialTokenAmount = 42338179;
    uint256 public additionalTokenAmount = 7661821;

    CarbonProject public carbonProject;

    function setUp() public {
        carbonProject = new CarbonProject(uri, owner);
    }

    function test_CarbonProject() public view {
        console.log("CarbonProject: ", address(carbonProject));
        console.log("Owner: ", carbonProject.owner());
        assertEq(carbonProject.owner(), owner);
    }

    function testFail_SetDataNotOwner() public {
        setDataTest();
    }

    function test_SetData() public {
        vm.startPrank(owner);
        carbonProject.mint(owner, 4561, initialTokenAmount, "");
        setDataTest();
        ( bool projectDataSet,
        uint256 id,
        string memory nameNumber,
        string memory proposer,
        string memory activity,
        string memory location,
        string memory status,
        uint256 startDate,
        uint256 endDate,
        uint256 period,
        string memory areaSize) = carbonProject.getProjectData(4561);
        vm.stopPrank();
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
        assertEq(carbonProject.uri(id), "https://www.neocarbon.com.br/br/registro/projeto?id=4561");
    }

    function testFail_SetDataTwice() public {
        vm.startPrank(owner);
        carbonProject.mint(owner, 4561, initialTokenAmount, "");
        setDataTest();
        setDataTest();
        vm.stopPrank();
    }

    function test_OwnerBalance() public {
        vm.prank(owner);
        carbonProject.mint(owner, 1, initialTokenAmount, "");
        uint256 balance = carbonProject.balanceOf(owner, 1);
        console.log("Owner Balance: ", balance);
        assertEq(balance, initialTokenAmount);
    }

    function test_Mint() public {
        vm.prank(owner);
        carbonProject.mint(owner, 1, initialTokenAmount, "");
        uint256 balance = carbonProject.balanceOf(owner, 1);
        console.log("Owner Balance: ", balance);
        assertEq(balance, initialTokenAmount);
    }

    function test_AdditionalMint() public {
        vm.prank(owner);
        carbonProject.mint(owner, 1, initialTokenAmount, "");
        uint256 balance = carbonProject.balanceOf(owner, 1);
        console.log("Owner Balance: ", balance);
        assertEq(balance, initialTokenAmount);
        vm.prank(owner);
        carbonProject.mint(owner, 1, additionalTokenAmount, "");
        balance = carbonProject.balanceOf(owner, 1);
        console.log("Second Owner Balance: ", balance);    
        assertEq(balance, initialTokenAmount + additionalTokenAmount);

    }

    function setDataTest() public {
        bool executed = carbonProject.setProjectData(
            owner,
            4561,
            "MTALT20230003",
            "AGROPECUARIA J L LTDA",
            "Unidade de Carbono Florestal - ARR + REDD",
            "Alto Taquari/MT/BRA",
            "Registrado",
            1691971200,
            1723593600,
            315360000,
            "2102.83 hectares",
            "https://www.neocarbon.com.br/br/registro/projeto?id=4561");

        console.log("CarbonProject: ", address(carbonProject));
        console.log("Executed setProjectData: ", executed);
        assertEq(executed, true);
    }
}
