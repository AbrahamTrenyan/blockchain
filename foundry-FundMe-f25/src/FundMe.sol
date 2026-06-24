// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;
import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";
/* import {AggregatorV3Interface} from "lib/chainlink-brownie-contracts/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol"; */
import {PriceConverter} from "./PriceConverter.sol";

error FundMe__NotOwner();

contract FundMe {
    // Type Declarations
    using PriceConverter for uint256;

    // State variables
    uint256 public constant MINIMUM_USD = 5 * 10 ** 18;
    address private immutable I_OWNER;
    address[] private sFunders;
    mapping(address => uint256) private sAddressToAmountFunded;
    AggregatorV3Interface private sPriceFeed;

    // Modifiers
    modifier onlyOwner() {
        // require(msg.sender == I_OWNER);
        if (msg.sender != I_OWNER) revert FundMe__NotOwner();
        _;
    }

    constructor(address priceFeed) {
        sPriceFeed = AggregatorV3Interface(priceFeed);
        I_OWNER = msg.sender;
    }

    function fund() public payable {
        require(
            msg.value.getConversionRate(sPriceFeed) >= MINIMUM_USD,
            "You need to spend more ETH!"
        );
        // require(PriceConverter.getConversionRate(msg.value) >= MINIMUM_USD, "You need to spend more ETH!");
        sAddressToAmountFunded[msg.sender] += msg.value;
        sFunders.push(msg.sender);
    }

    function withdraw() public onlyOwner {
        for (
            uint256 funderIndex = 0;
            funderIndex < sFunders.length;
            funderIndex++
        ) {
            address funder = sFunders[funderIndex];
            sAddressToAmountFunded[funder] = 0;
        }
        sFunders = new address[](0);
        // payable(msg.sender).transfer(address(this).balance);
        (bool success, ) = I_OWNER.call{value: address(this).balance}("");
        require(success);
    }

    function cheaperWithdraw() public onlyOwner {
        address[] memory funders = sFunders;
        for (
            uint256 funderIndex = 0;
            funderIndex < funders.length;
            funderIndex++
        ) {
            address funder = funders[funderIndex];
            sAddressToAmountFunded[funder] = 0;
        }
        sFunders = new address[](0);
        // payable(msg.sender).transfer(address(this).balance);
        (bool success, ) = I_OWNER.call{value: address(this).balance}("");
        require(success);
    }

    /** Getter Functions */

    /**
     * @notice Gets the amount that an address has funded
     *  @param fundingAddress the address of the funder
     *  @return the amount funded
     */
    function getAddressToAmountFunded(
        address fundingAddress
    ) public view returns (uint256) {
        return sAddressToAmountFunded[fundingAddress];
    }

    function getVersion() public view returns (uint256) {
        return sPriceFeed.version();
    }

    function getFunder(uint256 index) public view returns (address) {
        return sFunders[index];
    }

    function getOwner() public view returns (address) {
        return I_OWNER;
    }

    function getPriceFeed() public view returns (AggregatorV3Interface) {
        return sPriceFeed;
    }
}
