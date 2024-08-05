// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

contract CrowdFunding {
    uint256 public targetFund;
    uint256 public totalContribution;
    address public beneficiary;
    string public name;
    bool public isComplete;
    bool public isFunded;
    uint public deadline;

    constructor(uint256 _targetFund, string memory _name) {
        beneficiary = msg.sender;
        targetFund = _targetFund * 1 ether;
        name = _name;
        isComplete = false;
        isFunded = false;
        deadline = block.timestamp + 7 days;
    }
}