// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Owner {

    // Variable to store the owner's address
    address public _owner;

    // Constructor to initialize the owner variable with the address of the deployer
    constructor() {
        assembly {
            // Using inline assembly to store the caller's address in the slot 0 of storage
            sstore(0, caller())
        }
    }

    // Function to set a new owner
    function setNewOwner(address user) public {
        assembly {
            // Using inline assembly to update the owner's address in storage
            sstore(_owner.slot, user)
        }
    }

    // Function to check if the caller is the owner
    function isCallerOwner() public view returns(bool a) {
        assembly {
            // Using inline assembly to load the owner's address from storage
            let b := sload(_owner.slot)
            // Comparing the loaded address with the caller's address and returning the result
            a := eq(b, caller())
        }
    }

}
