// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

import "forge-std/Test.sol";
import {Simple_Storage} from "../src/Simple_Storage.sol";
import {Test, console} from "forge-std/Test.sol";

contract SimpleStorageTest is Test {
    Simple_Storage simpleStorage;

    function setUp() public {
        simpleStorage = new Simple_Storage(); 
    }

    function testStoreAndRetrieveGasUsage() public {
        uint256 startingGas = gasleft();

        simpleStorage.addPerson("Alice", 123);

        uint256 gasAfterStore = gasleft();

        uint256 gasUsed = startingGas - gasAfterStore;

        console.log("Store function consumed: %d gas", gasUsed);

        // Assert
        uint256 retrievedValue = simpleStorage.nameToFavoriteNumber("Alice");

        assertEq(retrievedValue, 42);
    }

    function testAddPersonGasUsage() public {
        uint256 startingGas = gasleft();

        simpleStorage.addPerson("Alice", 123);

        uint256 gasAfterAddPerson = gasleft();
        uint256 gasUsed = startingGas - gasAfterAddPerson;

        console.log("AddPerson function consumed: %d gas", gasUsed);

        uint256 favoriteNumber = simpleStorage.nameToFavoriteNumber("Alice");
        assertEq(favoriteNumber, 123);
    }

    function testPrintStorageData() public {
        simpleStorage.addPerson("Alice", 123);
        console.log("Valor almacenado en myFavoriteNumber:", simpleStorage.nameToFavoriteNumber("Alice"));

        simpleStorage.addPerson("Alice", 123);
        console.log("Numero de personas almacenadas:", simpleStorage.numberOfPeople());
        console.log("Numero favorito de Alice:", simpleStorage.nameToFavoriteNumber("Alice"));

        for (uint256 i = 0; i < 3; i++) {
            bytes32 value = vm.load(address(simpleStorage), bytes32(i));
            console.log("Valor en la ubicacion", i, ":");
            console.logBytes32(value);
        }
    }
}