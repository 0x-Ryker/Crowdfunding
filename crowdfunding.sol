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
    mapping(address => uint) public contributors;

    event hasContributed(address contributor, uint256 contributedAmount);
    event hasWithdrawn(address withdrawer, uint withdrawnAmount);
    event isRefunded(address refundee, uint256 refundedAmount);

    constructor(uint256 _targetFund, string memory _name) {
        beneficiary = msg.sender;
        targetFund = _targetFund * 1 ether;
        name = _name;
        isComplete = false;
        isFunded = false;
        deadline = block.timestamp + 7 days;
    }

    function contribute() public payable {
        uint256 contributeAmount = msg.value;
        contributeAmount = contributors[msg.sender];
        require(block.timestamp < deadline, "cannot contribute after deadline.");
        require(totalContribution <= targetFund, "no more contribution after target amount is reached.");
        require(contributors[msg.sender] > 0, "enter an amount bigger than zero");
        totalContribution += contributeAmount;
        isFunded = true;
        if (totalContribution >= targetFund) {
            isComplete = true;
        }
        emit hasContributed(msg.sender, contributeAmount);
    }
}