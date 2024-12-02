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
        cp = new CarbonProject("", owner);        
    }

}

/*
forge script script/CarbonProjectDeployScript.s.sol:CarbonProjectDeployScript --rpc-url $RPC_POLYGON_MAINNET --broadcast --verify --chain polygon --etherscan-api-key $POLYGONSCAN_API_KEY -vvvv
forge script script/CarbonProjectDeployScript.s.sol:CarbonProjectDeployScript --rpc-url $RPC_POLYGON_TEST --broadcast --verify --chain polygon --etherscan-api-key $POLYGONSCAN_API_KEY -vvvv
forge script .\script\CarbonProjectDeployScript.s.sol:CarbonProjectDeployScript --rpc-url %RPC_POLYGON_TEST% --broadcast --verify --chain polygon --etherscan-api-key %POLYGONSCAN_API_KEY% -vvvv
echo %RPC_POLYGON_TEST% %POLYGONSCAN_API_KEY% %PRIVATE_KEY%

https://polygonscan.com/address/0x28ab77381038dec2f31cf1c3f2a5c77055339a11#code

forge script .\script\CarbonProjectDeploy.s.sol --rpc-url %RPC_POLYGON_TEST% --broadcast --verify --chain 137 --etherscan-api-key %POLYGONSCAN_API_KEY% -vvvv
echo %RPC_POLYGON_TEST% %POLYGONSCAN_API_KEY% %PRIVATE_KEY%
*/