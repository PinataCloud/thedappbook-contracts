deploy:
	forge create src/FBWall.sol:FBWall --rpc-url https://sepolia.base.org --account <YOUR ACCOUNT> --broadcast

verify:
	forge verify-contract $(ADD) src/FBWall.sol:FBWall --chain-id 84532 --api-key $(shell op read op://prod/etherscan-api-key/credential)
