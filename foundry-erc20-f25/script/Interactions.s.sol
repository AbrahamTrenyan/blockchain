// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Script} from "forge-std/Script.sol";
import {BasicNFT} from "../src/BasicNFT.sol";

contract MintBasicNFT is Script {
    string public URI = "ipfs://example-token-uri";
    function run() external {
        address BASIC_NFT_ADDRESS = 0xCb76A8baa8A70Bddef540F9341e3e4345133d9A9;
        mintNftOnContract(BASIC_NFT_ADDRESS);
    }
    function mintNftOnContract(address basicNftAddress) public {
        BasicNFT basicNFT = BasicNFT(basicNftAddress);
        vm.startBroadcast();
        basicNFT.mintNft(URI);
        vm.stopBroadcast();
    }
}
