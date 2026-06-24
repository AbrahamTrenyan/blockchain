// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Script} from "forge-std/Script.sol";
import {MoodNft} from "../src/MoodNFT.sol";
import "openzeppelin/contracts/utils/Base64.sol";
contract DeployMoodNFT is Script {
    function run() external {
        vm.startBroadcast();
        string memory sadSvg = vm.readFile("./img/sad.svg");
        string memory happySvg = vm.readFile("./img/happy.svg");
        string memory sadSvgImageUri = svgToImageURI(sadSvg);
        string memory happySvgImageUri = svgToImageURI(happySvg);
        new MoodNft(sadSvgImageUri, happySvgImageUri);
        vm.stopBroadcast();
    }
    function svgToImageURI(
        string memory svg
    ) public pure returns (string memory) {
        string memory baseURI = "data:image/svg+xml;base64,";
        string memory svgBase64Encoded = Base64.encode(
            bytes(string(abi.encodePacked(svg)))
        );
        return string(abi.encodePacked(baseURI, svgBase64Encoded));
    }
}
