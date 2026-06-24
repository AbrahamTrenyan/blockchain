// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Script} from "forge-std/Script.sol";
import {ManualToken} from "../src/ManualToken.sol";

contract DeployManualToken is Script {
    function run() external returns (ManualToken) {
        vm.startBroadcast();
        ManualToken token = new ManualToken();
        vm.stopBroadcast();
        return token;
    }
}
