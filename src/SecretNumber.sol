// SPDX-License-Identifier: MIT
pragma solidity 0.8.15;

contract SecretNumber {

    // Address of the contract owner
    address public owner;

    // Private variable to store the secret number
    uint private secretNumber;

    // Mapping to store guesses made by different addresses
    mapping(address => uint) public guesses;

    // Constructor to initialize the contract with an initial secret number
    constructor(uint256 _secretNumber) {
        assembly {
            // Store the contract deployer's address in storage slot 0
            sstore(0, caller())
            // Store the initial secret number in storage slot 1
            sstore(1, _secretNumber)
        }
    }

    // Function to get the current secret number
    function getSecretNumber() external view returns(uint) {
        assembly {
            // Load the secret number from storage slot 1
            let _secretNumber := sload(1)
            // Create a memory pointer at the free memory location
            let ptr := mload(0x40)
            // Store the secret number at the memory location pointed by ptr
            mstore(ptr, _secretNumber)
            // Return the memory pointer and its length (0x20)
            return(ptr, 0x20)
        }
    }

    // Function to set a new secret number, only callable by the owner
    function setSecretNumber(uint _number) external {
        assembly {
            // Check if the caller is the owner of the contract
            // Revert if the caller is not the owner
            if iszero(eq(caller(), sload(owner.slot))) { revert(0x00, 0x00) }

            // Store the new secret number in storage slot corresponding to the secretNumber variable
            let slot := secretNumber.slot
            sstore(slot, _number)
        }
    }

    // Function to add a guess made by the caller
    function addGuess(uint _guess) external {
        assembly {
            // Create a memory pointer at the free memory location
            let ptr := mload(0x40)
            // Store the caller's address at the memory location pointed by ptr
            mstore(ptr, caller())
            // Store the storage slot corresponding to the guesses mapping at the next 0x20 bytes in memory
            mstore(add(ptr, 0x20), guesses.slot)
            // Calculate the keccak256 hash of the memory region pointed by ptr and size 0x40
            let slot := keccak256(ptr, 0x40)
            // Store the guess in the computed storage slot
            sstore(slot, _guess)
        }
    }
}
