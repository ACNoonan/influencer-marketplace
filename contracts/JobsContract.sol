// SPDX-License-Identifier: MIT
pragma solidity ^0.8.6;

contract JobsContract {
  address owner;
  
  enum Status {OFFERED, ACCEPTED, AWAIT_THRESHOLD, THRESHOLD_MET, COMPLETED}

  uint numJobs;

  //create struct to store job details
  struct jobStruct  {
    uint256 job_id;
    address influencer;
    uint256 amount;
    uint256 metric_threshold;
    uint256 metric_status;
    bool locked;
    bool complete;
    Status status;
  }
  
  // create mapping to store jobs by Brand & job_id
  mapping(address => mapping(uint256 => jobStruct)) public jobMap;

  modifier onlyOwner  {
    require(msg.sender == owner, "Only owner can unlock escrow.");
    _;
  }

  constructor() {
    owner = msg.sender;
  }

  // brand offers influencer a job
  function offer_job(
      
      address _influencer, 
      uint256 _amount, 
      uint256 _metric_threshold
      ) public returns (uint256 job_id){
    job_id = numJobs++;


    //jobStruct memory j = jobMap[msg.sender][job_id];
    jobMap[msg.sender][job_id].influencer = _influencer;
    jobMap[msg.sender][job_id].amount = _amount;
    jobMap[msg.sender][job_id].locked = true;
    jobMap[msg.sender][job_id].complete = false;
    jobMap[msg.sender][job_id].metric_threshold =_metric_threshold;
    jobMap[msg.sender][job_id].status;

  }

  // retrieve current state of job
  function get_job_status(address _brand, uint256 _job_id) external view returns (
      address,
      uint256,
      uint256,
      uint256,
      bool,
      bool,
      Status
      ) {
    return (
      jobMap[_brand][_job_id].influencer,
      jobMap[_brand][_job_id].amount,
      jobMap[_brand][_job_id].metric_threshold,
      jobMap[_brand][_job_id].metric_status,
      jobMap[_brand][_job_id].locked,
      jobMap[_brand][_job_id].complete,
      jobMap[_brand][_job_id].status
    );
  }


//INFLUENCER ONLY
  // influencer accepts a job, erc20 tokens
  // get moved to the escrow (this contract)
  function accept_job(address _brand, uint256 _job_id) external returns (uint256) {
 
  }

  // influencer withdraws unlocked tokens from completed job
  function withdraw_payment(address _brand, uint256 _job_id) external returns(bool) {
    
  }



////ADMINISTRATIVE - OWNER ONLY
//  // owner can send funds to brand if dispute resolution is in brand's favor
//  function resolveToBrand(address _influencer, address _job_id) onlyOwner external returns(bool) {
//
//  }
// // owner unlocks tokens in escrow for a job
//  function release(address _brand, uint256 _job_id) onlyOwner external returns(bool) {
//    
//  }
}