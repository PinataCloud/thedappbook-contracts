deploy:
	forge create src/FBWall.sol:FBWall --rpc-url https://eth-sepolia.g.alchemy.com/v2/K8AznK0811Gm8Nq2ba8amq45kEvI-2Sr --account stevedylandev --broadcast

verify:
	forge verify-contract $(ADD) src/FBWall.sol:FBWall --chain-id 11155111 --api-key $(shell op read op://Personal/etherscan-sepolia/credential)
