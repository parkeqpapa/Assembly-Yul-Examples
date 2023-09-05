// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Owner {

    address public _owner;

    constructor() {
        assembly {
            sstore(0, caller())
        }
    }

    function setNewOwner(address user) public {
        assembly {
           
            sstore(_owner.slot, user)
        }
    }
   
    function isCallerOwner() public view returns(bool a) {
        assembly {
            let b := sload(_owner.slot)
            a := eq(b, caller())
        }
    }

}