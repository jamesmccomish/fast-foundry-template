// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.8.0 <0.8.20;

import { PRBTest } from "../../lib/prb-test/src/PRBTest.sol";
import { StdCheats } from "../../lib/forge-std/src/StdCheats.sol";
import { console2 } from "../../lib/forge-std/src/console2.sol";

// Config to import addresses to other tests
abstract contract BasicTestConfig is PRBTest, StdCheats {
    // Create addresses for users
    bytes32 internal nextUser = keccak256(abi.encodePacked("user address"));

    address internal alice;
    address internal bob;
    address internal carl;
    address internal dave;
    address internal eve;

    // Some basic addresses
    address internal constant ZERO_ADDRESS = address(0);
    address internal constant ONE_ADDRESS = address(1);
    address internal constant DEAD_ADDRESS = address(0xDEAD);

    /// -----------------------------------------------------------------------
    /// Setup
    /// -----------------------------------------------------------------------

    constructor() {
        // Create and assign the first 5 users commonly used in tests
        address payable[] memory users = createUsers(5);

        alice = users[0];
        bob = users[1];
        carl = users[2];
        dave = users[3];
        eve = users[4];
    }

    function getNextUserAddress() public returns (address payable) {
        //bytes32 to address conversion
        address payable user = payable(address(uint160(uint256(nextUser))));
        nextUser = keccak256(abi.encodePacked(nextUser));
        return user;
    }

    //create users with 100 ether balance
    function createUsers(uint256 userNum) public returns (address payable[] memory) {
        address payable[] memory users = new address payable[](userNum);
        for (uint256 i = 0; i < userNum; i++) {
            address payable user = this.getNextUserAddress();
            vm.deal(user, 100 ether);
            users[i] = user;
        }
        return users;
    }
}
