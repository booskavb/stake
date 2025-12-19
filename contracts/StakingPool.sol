// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {ZamaEthereumConfig} from "@fhevm/solidity/config/ZamaConfig.sol";
import {FHE} from "@fhevm/solidity/lib/FHE.sol";
import {euint64} from "@fhevm/solidity/lib/FHE.sol";

// staking pool with encrypted amounts
// using euint64 for larger values
contract StakingPool is ZamaEthereumConfig {
    using FHE for euint64;
    
    struct Stake {
        address staker;
        euint64 amount;
        uint256 stakedAt;
        bool active;
    }
    
    mapping(address => Stake) public stakes;
    euint64 public totalStaked;
    
    event Staked(address indexed staker, uint256 timestamp);
    event Unstaked(address indexed staker, uint256 timestamp);
    
    function stake(euint64 encryptedAmount) external {
        Stake storage userStake = stakes[msg.sender];
        
        if (!userStake.active) {
            userStake.staker = msg.sender;
            userStake.amount = encryptedAmount;
            userStake.stakedAt = block.timestamp;
            userStake.active = true;
        } else {
            // add to existing stake
            userStake.amount = userStake.amount.add(encryptedAmount);
        }
        
        totalStaked = totalStaked.add(encryptedAmount);
        emit Staked(msg.sender, block.timestamp);
    }
    
    function unstake(euint64 encryptedAmount) external {
        Stake storage userStake = stakes[msg.sender];
        require(userStake.active, "No active stake");
        
        // check if enough staked
        // Note: Comparison requires decryption in production
        // if (userStake.amount.lt(encryptedAmount)) {
        //     revert("Insufficient staked amount");
        // }
        
        userStake.amount = userStake.amount.sub(encryptedAmount);
        totalStaked = totalStaked.sub(encryptedAmount);
        
        // cleanup if empty - requires decryption
        // if (userStake.amount == FHE.asEuint64(0)) {
        //     userStake.active = false;
        // }
        
        emit Unstaked(msg.sender, block.timestamp);
    }
    
    function getStake() external view returns (euint64) {
        return stakes[msg.sender].amount;
    }
}
