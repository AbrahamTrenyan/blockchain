// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;
contract Simple_Storage{
    mapping(string => uint256) public nameToFavoriteNumber;
    // Creo un mapeo para asociar con el indice
    mapping(string=>uint256) public nameToIndex;
    
    struct Person{
        string name;
        uint256 favoriteNumber;
    }
    Person[] public people;
    function addPerson(string memory _name, uint256 _favoriteNumber) public{
        people.push(Person({name: _name, favoriteNumber: _favoriteNumber}));
        nameToFavoriteNumber[_name] = _favoriteNumber;
        nameToIndex[_name] = people.length - 1;
    }
    function getPerson(uint256 index) public view returns (Person memory){
        return people[index];
    }
    function numberOfPeople() public view returns(uint256){
        return people.length;
    }
}