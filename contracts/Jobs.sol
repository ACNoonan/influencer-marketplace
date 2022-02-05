// SPDX-License-Identifier: MIT
pragma solidity ^0.8.6;

contract Jobs {
  address owner;
  
  enum Status {OFFERED, ACCEPTED, AWAIT_THRESHOLD, THRESHOLD_MET, COMPLETED}

  //create struct to store job details
  struct Job {
    address influencer;
    uint256 amount;
    uint256 metric_threshold;
    uint256 metric_status;
    bool locked;
    bool complete;
    Status status;
  }
  
  // create mapping to store jobs by Brand & job_id
  mapping(address => mapping(uint256 => Job)) public jobs;

  modifier onlyOwner  {
    require(msg.sender == owner, "Only owner can unlock escrow.");
    _;
  }

  constructor() {
    owner = msg.sender;
  }

  // brand offers influencer a job
  function offer_job(
      uint256 _job_id,
      address _influencer, 
      uint256 _amount, 
      uint256 _metric_threshold
      ) public {

    jobs[msg.sender][_job_id].influencer = _influencer;
    jobs[msg.sender][_job_id].amount = _amount;
    jobs[msg.sender][_job_id].locked = true;
    jobs[msg.sender][_job_id].complete = false;
    jobs[msg.sender][_job_id].metric_threshold =_metric_threshold;
    jobs[msg.sender][_job_id].status;
  }

  // retrieve current state of job
  function get_job_status(address _brand, address _job_id) external view returns (uint256, bool, address) {
    
  }


//INFLUENCER ONLY
  // influencer accepts a job, erc20 tokens
  // get moved to the escrow (this contract)
  function accept_job(uint256 _job_id, address _brand) external returns (uint256) {
 
  }

  // influencer withdraws unlocked tokens from completed job
  function withdraw_payment(address _brand, uint256 _job_id) external returns(bool) {
    
  }



//ADMINISTRATIVE - OWNER ONLY
  // owner can send funds to brand if dispute resolution is in brand's favor
  function resolveToBrand(address _influencer, address _job_id) onlyOwner external returns(bool) {

  }
 // owner unlocks tokens in escrow for a job
  function release(address _brand, uint256 _job_id) onlyOwner external returns(bool) {
    
  }
}