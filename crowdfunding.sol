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

    event hasContributed(address indexed contributor, uint256 indexed contributedAmount);
    event hasWithdrawn(address indexed withdrawer, uint indexed withdrawnAmount);
    event isRefunded(address indexed refundee, uint256 indexed refundedAmount);

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

    modifier onlyBeneficiary() {
        require(beneficiary == msg.sender, "only beneficiary can call this function");
        _;
    }

    function withdraw() public onlyBeneficiary() {
        require(block.timestamp >= deadline, "withdraw can only be initiated after deadline.");
        require(totalContribution >= targetFund, "you can only withdraw when the target funds is realized.");
        require(!isComplete, "the crowdfunding is not over");
        isComplete = true;
        uint withdrawValue = address(this).balance; // withdraw the entire funds from the smart contract.
        (bool success, ) = (beneficiary).call{value: withdrawValue}("");
        require(success, "unable to withdraw.");
        withdrawValue = 0;
        emit hasWithdrawn(beneficiary, withdrawValue);
    }

    function getBalance() public view returns(uint) {
        return address(this).balance;
    }
}