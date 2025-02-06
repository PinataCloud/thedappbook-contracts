## thedappbook - Contracts

![cover](https://dweb.mypinata.cloud/ipfs/bafkreih24voz7rvhcugw66ulsl7lpmk7sekq2s52anuezuaykb7qt4swo4)

A simple blockchain application using smart contracts and IPFS

## Overview

thedappbook allows users to connect their wallet and write posts on the decentralized wall. This happens through several components:

- [Smart Contracts](https://github.com/PinataCloud/thedappbook-contracts) - Works like a decentralized database that stores the messages and the address of the user who posted them. Blockchain data is too expensive to store full res images, so instead it stores an IPFS CID that points to the content offchain.
- [Server](https://github.com/PinataCloud/thedappbook-server) - Handles generating temporary Pinata API Keys to upload images and JSON content that can be consumed by the client.
- [Client](https://github.com/PinataCloud/thedappbook-client) - The hosted web UI that the end user connects their wallet with and writes a message to the smart contract.

## The Contracts

This particular repo is responsible for writing, testing, and deploing the smart contracts that will  be used by the [client](https://github.com/PinataCloud/thedappbook-client). It's composed on just one main contract under `src` called `FBWall.sol`

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract FBWall {
    // The state that will store the total number of posts
    uint256 totalPosts;

    // A smart contract event that is fired off when triggered.
    // This create logs onchain that can be indexed later on or
    // be used like webhooks you can subscribe to.
    event NewPost(address indexed from, uint256 timestamp, string message);

    // A type struct for a new object
    struct Post {
        address poster;
        string message;
        uint256 timestamp;
    }

    // The state array that will hold the posts
    Post[] posts;

    // A contructor that is used to pass in any environment
    // variables we might need. There are none for this
    // contract so it is blank.
    constructor() {}

    // The main function to create a message. It's public so anyone can use it,
    // and it takes a single param of `_message`. When used it will
    // increase the totalPosts by one, then push a new Post object
    // into the posts array with the sender's address, the _message,
    // and the timestampe of the post. It will finally emit a new event.
    function createPost(string memory _message) public {
        totalPosts += 1;
        posts.push(Post(msg.sender, _message, block.timestamp));
        emit NewPost(msg.sender, block.timestamp, _message);
    }

    // A function to return all the posts that are stored on
    // on the contract state
    function getAllPosts() public view returns (Post[] memory) {
        return posts;
    }

    // Returns the total number of posts from totalPosts state
    function getTotalPosts() public view returns (uint256) {
        return totalPosts;
    }
}
```

## Development

First make sure you have Foundry installed. [Follow the instructions here](https://book.getfoundry.sh/getting-started/installation).

Clone the repo and install the dependencies

```bash
git clone https://github.com/PinataCloud/thedappbook-contracts
cd thedappbook-server
forge install
```

Once the dependencies are installed try running the test function

```bash
forge test
```

## Deployment

In order to deploy these contracts to a blockchain or testnet blockchain you will need two things:
- A wallet
- Some test ether

To do this try running this command in your terminal

```bash
cast wallet new
```

This should generate an `Address` and `Private Key`. The `Address` is public, but the `Private Key` must be kept secret at all times!

> [!DANGER]
> DO NOT SHARE YOUR PRIVATE KEY WITH ANYONE

To keep it secure we'll use cast to store it in an encrypted file. Run the following command to begin the import process

```bash
cast wallet import mywallet --interactive
```

It will them prompt you to paste in the `Private Key` we made earlier, then it will ask for a password you want to protect the key with. Once this is done your key is secured and we can use it later on without directly interacting with the private key.

Now that you have your wallet you will need to send the public `Address` some testnet funds. [Here's a few places you can try](https://docs.base.org/docs/tools/network-faucets/)

Now you're ready to deploy. You would do it with the following command:

```bash
forge create src/FBWall.sol:FBWall --rpc-url https://sepolia.base.org --account mywallet --broadcast
```

Make sure to update `mywallet` with the name you gave your wallet just a moment ago!


## Questions?

Feel free to reach out over [Discord](https://discord.gg/pinata) or [Email](mailto:steve@pinata.cloud)!
