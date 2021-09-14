// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract WavePortal {
    uint totalWaves;
    string lastWaver;
    uint private seed;

    event NewWave(address indexed from, uint timestamp, string message);

    struct Wave {
        address waver;
        string message;
        uint timestamp;
    }

    Wave[] waves;

    mapping(address => uint) public lastWavedAt;

    constructor() payable{
        console.log("if we have a decentralized web, how is mr. spider going to catch bugs");
    }

    function wave(string memory _message) public {
        require(lastWavedAt[msg.sender] + 15 minutes < block.timestamp, "Wait 15m");
        lastWavedAt[msg.sender] = block.timestamp;

        totalWaves += 1;
        lastWaver = toAsciiString(msg.sender);
        console.log("%s waved w/ %s!", msg.sender, _message);

        waves.push(Wave(msg.sender, _message, block.timestamp));

        uint randomNumber = (block.difficulty + block.timestamp + seed) % 100;
        console.log("number is", randomNumber);
        seed = randomNumber;

        if(randomNumber < 50) {
            console.log("%s is paid", msg.sender);
            uint prizeAmount = 0.00001 ether;
            require(prizeAmount <= address(this).balance, "Oops no more conceptual bucks");
            (bool success,) = (msg.sender).call{value: prizeAmount}("");
            require(success, "Failed to send te moonies");
        }

        emit NewWave(msg.sender, block.timestamp, _message);
    }

    //tkeber on stack exchange
    function toAsciiString(address x) internal pure returns (string memory) {
        bytes memory s = new bytes(40);
        for (uint i = 0; i < 20; i++) {
            bytes1 b = bytes1(uint8(uint(uint160(x)) / (2**(8*(19 - i)))));
            bytes1 hi = bytes1(uint8(b) / 16);
            bytes1 lo = bytes1(uint8(b) - 16 * uint8(hi));
            s[2*i] = char(hi);
            s[2*i+1] = char(lo);            
        }
        return string(s);
    }
    //tkeber on stack exchange
    function char(bytes1 b) internal pure returns (bytes1 c) {
        if (uint8(b) < 10) return bytes1(uint8(b) + 0x30);
        else return bytes1(uint8(b) + 0x57);
    }

    function getTotalWaves() view public returns (uint) {
        console.log("We have %d total waves", totalWaves);
        return totalWaves;
    }

    function getLastWaver() view public returns (string memory) {
        console.log("%s waved last", lastWaver);
        return lastWaver;
    }

    function getAllWaves() view public returns (Wave[] memory){
        return waves;
    }
}