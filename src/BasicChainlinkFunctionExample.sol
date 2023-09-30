// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract BasicChainlinkFunctionExample {
    uint256 public number;

    function setNumber(uint256 newNumber) public {
        number = newNumber;
    }

    function increment() public {
        number++;
    }
}
