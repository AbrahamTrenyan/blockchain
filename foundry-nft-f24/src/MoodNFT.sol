// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "openzeppelin/contracts/token/ERC721/ERC721.sol";
import "openzeppelin/contracts/utils/Base64.sol";
import {Ownable} from "openzeppelin/contracts/access/Ownable.sol";
contract MoodNft is ERC721, Ownable {
    error MoodNft_URIQueryForNonexistentToken();
    error MoodNft_FlipMoodNotOwner();
    enum Mood {
        HAPPY,
        SAD
    }
    mapping(uint256 => Mood) private s_tokenIdToMood;
    event CreatedNFT(uint256 indexed tokenId, Mood mood);
    uint256 private s_tokenCounter;
    string private s_sadSvgUri;
    string private s_happySvgUri;

    constructor(
        string memory sadSvgUri,
        string memory happySvgUri
    ) ERC721("Mood NFT", "MN") Ownable(msg.sender) {
        s_tokenCounter = 0;
        s_sadSvgUri = sadSvgUri;
        s_happySvgUri = happySvgUri;
    }

    function mintNft() public {
        _safeMint(msg.sender, s_tokenCounter);
        s_tokenCounter++;
        emit CreatedNFT(s_tokenCounter, Mood.HAPPY);
    }
    function flipMood(uint256 tokenId) public {
        require(
            _ownerOf(tokenId) != address(0),
            "URI query for nonexistent token"
        );
        require(
            getApproved(tokenId) == msg.sender ||
                ownerOf(tokenId) == msg.sender,
            "Only owner can flip mood"
        );

        if (s_tokenIdToMood[tokenId] == Mood.HAPPY) {
            s_tokenIdToMood[tokenId] = Mood.SAD;
        } else {
            s_tokenIdToMood[tokenId] = Mood.HAPPY;
        }
    }
    function _baseURI() internal pure override returns (string memory) {
        return "data:application/json;base64,";
    }
    function tokenURI(
        uint256 _tokenId
    ) public view override returns (string memory) {
        if (_ownerOf(_tokenId) == address(0)) {
            revert MoodNft_URIQueryForNonexistentToken();
        }

        string memory imageUri = s_happySvgUri;
        if (s_tokenIdToMood[_tokenId] == Mood.SAD) {
            imageUri = s_sadSvgUri;
        }

        return
            string(
                abi.encodePacked(
                    _baseURI(),
                    Base64.encode(
                        bytes(
                            abi.encodePacked(
                                '{"name":"',
                                name(),
                                '", "description":"An NFT that changes based on the mood of the owner.", "attributes":[{"trait_type": "moodiness", "value": 100}], "image":"',
                                imageUri,
                                '"}'
                            )
                        )
                    )
                )
            );
    }
    function getMood(uint256 tokenId) public view returns (Mood) {
        if (_ownerOf(tokenId) == address(0)) {
            revert MoodNft_URIQueryForNonexistentToken();
        }
        return s_tokenIdToMood[tokenId];
    }
    function getSvgImageByMood(Mood mood) public view returns (string memory) {
        if (mood == Mood.HAPPY) {
            return s_happySvgUri;
        } else {
            return s_sadSvgUri;
        }
    }
}
