// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {ZamaEthereumConfig} from "@fhevm/solidity/config/ZamaConfig.sol";
import {FHE} from "@fhevm/solidity/lib/FHE.sol";
import {euint64} from "@fhevm/solidity/lib/FHE.sol";

// calculates rewards on encrypted amounts
contract RewardCalculator is ZamaEthereumConfig {
    using FHE for euint64;
    
    // APY in basis points (10000 = 100%)
    euint64 public apy;
    
    // calculate reward based on staked amount and days
    function calculateReward(euint64 stakedAmount, uint256 daysStaked) 
        external 
        view 
        returns (euint64) 
    {
        // reward = stakedAmount * (apy / 10000) * (daysStaked / 365)
        // all calculations on encrypted data
        // Note: Division and multiplication with FHE requires proper operations
        // euint64 dailyRate = apy.div(FHE.asEuint64(36500)); // apy / (100 * 365)
        // euint64 reward = stakedAmount.mul(dailyRate).mul(FHE.asEuint64(uint64(daysStaked)));
        // Simplified for now
        return stakedAmount;
    }
    
    function setAPY(euint64 newAPY) external {
        apy = newAPY;
    }
}
