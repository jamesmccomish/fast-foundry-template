// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.8.20;

import { StdCheats } from "forge-std/StdCheats.sol";

// Create addresses for tests
abstract contract AddressTestConfig is StdCheats {
    // Used to create addresses for users beyond first 5
    bytes32 internal nextUser = keccak256(abi.encodePacked("user address"));

    // Commonly used addresses & private keys
    address internal alice;
    address internal bob;
    address internal carl;
    address internal dave;
    address internal eve;

    uint256 internal alicePk;
    uint256 internal bobPk;
    uint256 internal carlPk;
    uint256 internal davePk;
    uint256 internal evePk;

    // Some basic addresses
    address internal constant ZERO_ADDRESS = address(0);
    address internal constant ONE_ADDRESS = address(1);
    address internal constant DEAD_ADDRESS = address(0xDEAD);

    /// -----------------------------------------------------------------------
    /// Setup
    /// -----------------------------------------------------------------------

    constructor() {
        // Create labeled addresses for most commonly used accounts
        (alice, alicePk) = makeAddrAndKey("alice");
        (bob, bobPk) = makeAddrAndKey("bob");
        (carl, carlPk) = makeAddrAndKey("carl");
        (dave, davePk) = makeAddrAndKey("dave");
        (eve, evePk) = makeAddrAndKey("eve");

        deal(alice, 100 ether);
        deal(bob, 100 ether);
        deal(carl, 100 ether);
        deal(dave, 100 ether);
        deal(eve, 100 ether);
    }

    function getNextUserAddress() public returns (address payable) {
        // Bytes32 to address conversion
        address payable user = payable(address(uint160(uint256(nextUser))));
        nextUser = keccak256(abi.encodePacked(nextUser));
        return user;
    }

    // Create users with 100 ether balance
    function createUsers(uint256 userNum) public returns (address payable[] memory) {
        address payable[] memory users = new address payable[](userNum);
        for (uint256 i = 0; i < userNum; i++) {
            address payable user = this.getNextUserAddress();
            deal(user, 100 ether);
            users[i] = user;
        }
        return users;
    }
}
