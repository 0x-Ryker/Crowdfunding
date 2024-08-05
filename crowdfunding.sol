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
}