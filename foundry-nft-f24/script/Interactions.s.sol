// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Script} from "forge-std/Script.sol";
import {MoodNft} from "../src/MoodNFT.sol";

contract MintMoodNFT is Script {
    function run() external {
        address MOOD_NFT_ADDRESS = 0xF37257424E1bf2047E6639323841D6456aaA3230;
        mintMoodNftOnContract(MOOD_NFT_ADDRESS);
    }
    function mintMoodNftOnContract(address moodNftAddress) public {
        MoodNft moodNft = MoodNft(moodNftAddress);
        vm.startBroadcast();
        moodNft.mintNft();
        vm.stopBroadcast();
    }
}
contract FlipMoodNFT is Script {
    uint256 public constant TOKEN_ID = 0;
    function run() external {
        address MOOD_NFT_ADDRESS = 0xF37257424E1bf2047E6639323841D6456aaA3230;
        flipMoodNftOnContract(MOOD_NFT_ADDRESS);
    }
    function flipMoodNftOnContract(address moodNftAddress) public {
        MoodNft moodNft = MoodNft(moodNftAddress);
        vm.startBroadcast();
        moodNft.flipMood(TOKEN_ID);
        vm.stopBroadcast();
    }
}
