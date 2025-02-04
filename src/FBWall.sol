// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract FBWall {
    uint256 totalPosts;

    event NewPost(address indexed from, uint256 timestamp, string message);

    struct Post {
        address poster;
        string message;
        uint256 timestamp;
    }

    Post[] posts;

    constructor() {}

    function createPost(string memory _message) public {
        totalPosts += 1;
        posts.push(Post(msg.sender, _message, block.timestamp));
        emit NewPost(msg.sender, block.timestamp, _message);
    }

    function getAllPosts() public view returns (Post[] memory) {
        return posts;
    }

    function getTotalPosts() public view returns (uint256) {
        return totalPosts;
    }
}
