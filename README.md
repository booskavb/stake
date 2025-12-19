# Stake

Staking platform where stake amounts aren't visible publicly. Protects large stakers from attacks.

Uses `euint64` for bigger amounts since staking can get pretty large.

## Basic usage

```bash
npm install
npm run compile
npm run test
```

## Notes

Rewards are calculated on encrypted amounts. Only decrypt when you want to withdraw. Pretty neat privacy feature.
