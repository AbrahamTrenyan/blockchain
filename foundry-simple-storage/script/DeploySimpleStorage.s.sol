// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;
import "forge-std/Script.sol";
import {Simple_Storage} from "../src/Simple_Storage.sol";

contract DeploySimpleStorage is Script {
    function run() public returns (Simple_Storage) {
        vm.startBroadcast();
        Simple_Storage simpleStorage = new Simple_Storage();
        vm.stopBroadcast();
        return simpleStorage;
    }
}