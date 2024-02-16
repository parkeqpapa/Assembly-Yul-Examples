// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "forge-std/console.sol";

import { SecretNumber } from "../src/SecretNumber.sol";

contract Contract is Test {
    SecretNumber con;
    address alice = vm.addr(1);
    address bob = vm.addr(2);

    function setUp() public {
        vm.prank(alice);
        con = new SecretNumber(256);
    }  

    function testConstructorArgumentWorks() public {
        assertEq(con.getSecretNumber(), 256);
    }  

    function testOwnerCanChangeSecretNumber() public {
        uint256 oldNumber = con.getSecretNumber();
        vm.prank(alice);
        con.setSecretNumber(255);
        assertNotEq(oldNumber, con.getSecretNumber());
        
    }

    function testAddGuess() public {
        vm.prank(bob);
        con.addGuess(244);
    }

    function testOnlyOwnerCanChangeSecretNumber() public {
       vm.expectRevert();
        vm.prank(bob);
        con.setSecretNumber(1);
    
    }
}
