// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.25;

import {Script, console} from "forge-std/Script.sol";
import {CarbonProject} from "../src/CarbonProject.sol";

contract CarbonProjectDeployScript is Script {
    CarbonProject public cp;
    

    function setUp() public {}

    function run() public {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);
        address owner = address(0x7aC722a69CDb106127f1f2cC86761B28176E5379);
        cp = new CarbonProject("https://www.neocarbon.com.br/br/registro/projeto?id={id}", owner, 1);        
        bool executed = cp.setProjectData(
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
        require(executed, "Failed to set project data");

    }

}

/*
forge script script/CarbonProjectDeployScript.s.sol:CarbonProjectDeployScript --rpc-url $RPC_POLYGON_MAINNET --broadcast --verify --chain polygon --etherscan-api-key $POLYGONSCAN_API_KEY -vvvv
forge script script/CarbonProjectDeployScript.s.sol:CarbonProjectDeployScript --rpc-url $RPC_POLYGON_TEST --broadcast --verify --chain polygon --etherscan-api-key $POLYGONSCAN_API_KEY -vvvv
forge script .\script\CarbonProjectDeployScript.s.sol:CarbonProjectDeployScript --rpc-url %RPC_POLYGON_TEST% --broadcast --verify --chain polygon --etherscan-api-key %POLYGONSCAN_API_KEY% -vvvv
echo %RPC_POLYGON_TEST% %POLYGONSCAN_API_KEY% %PRIVATE_KEY%
forge script .\script\CarbonProjectDeploy.s.sol --rpc-url %RPC_POLYGON_TEST% --broadcast 
forge script .\script\CarbonProjectDeploy.s.sol --rpc-url %RPC_POLYGON_TEST% --broadcast --verify --chain 80002 --etherscan-api-key %POLYGONSCAN_API_KEY% -vvvv
echo %RPC_POLYGON_TEST% %POLYGONSCAN_API_KEY% %PRIVATE_KEY%
*/