// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "forge-std/console.sol";

import { Owner } from "../src/Owner.sol";

contract OwnerTest is Test {
    Owner owner;
    address alice = vm.addr(1);
    address bob = vm.addr(2);

    function setUp() public {
        vm.prank(alice);
        owner = new Owner();
    }

    function testAliceIsOwner() public {
    assertEq(alice, owner._owner());
}

    function testFailBobIsNotOwner() public {
    assertEq(bob, owner._owner());
    }

    function testChangeOwner() public {
        vm.prank(alice);
        owner.setNewOwner(bob);
        assertEq(bob, owner._owner());
    }
}
