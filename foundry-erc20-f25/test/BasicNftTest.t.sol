//SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Test} from "forge-std/Test.sol";
import {BasicNFT} from "../src/BasicNFT.sol";
import {DeployBasicNFT} from "../script/DeployBasicNFT.s.sol";

contract BasicNftTest is Test {
    BasicNFT public basicNFT;
    address public USER = makeAddr("USER");
    string public constant EXPECTED_TOKEN_URI = "ipfs://example-token-uri";
    function setUp() public {
        DeployBasicNFT deployBasicNFT = new DeployBasicNFT();
        basicNFT = deployBasicNFT.run();
    }
    function testNameAndSymbolAreCorrect() public {
        string memory expectedName = "BasicNFT";
        string memory expectedSymbol = "BNFT";
        string memory actualName = basicNFT.name();
        string memory actualSymbol = basicNFT.symbol();
        assert(
            keccak256(abi.encodePacked(actualName)) ==
                keccak256(abi.encodePacked(expectedName))
        );
        assert(
            keccak256(abi.encodePacked(actualSymbol)) ==
                keccak256(abi.encodePacked(expectedSymbol))
        );
    }
    function testCanMintAndHaveBalance() public {
        vm.prank(USER);
        basicNFT.mintNft(EXPECTED_TOKEN_URI);
        assert(basicNFT.balanceOf(USER) == 1);
        assert(
            keccak256(abi.encodePacked(basicNFT.tokenURI(1))) ==
                keccak256(abi.encodePacked(EXPECTED_TOKEN_URI))
        );
    }
}
