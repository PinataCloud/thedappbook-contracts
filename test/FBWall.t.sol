// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Test, console} from "forge-std/Test.sol";
import {FBWall} from "../src/FBWall.sol";

contract FBWallTest is Test {
    FBWall public fbWall;

    function setUp() public {
        fbWall = new FBWall();
    }

    function test_CreatePost() public {
        fbWall.createPost("test message");
        FBWall.Post[] memory posts = fbWall.getAllPosts();
        assertEq(posts.length, 1);
        assertEq(posts[0].poster, address(this));
        assertEq(posts[0].message, "test message");
        assertEq(fbWall.getTotalPosts(), 1);
    }

    function test_GetAllPosts() public {
        fbWall.createPost("test-1");
        fbWall.createPost("test-2");
        fbWall.createPost("test-3");

        FBWall.Post[] memory posts = fbWall.getAllPosts();
        assertEq(posts.length, 3);
        assertEq(posts[0].message, "test-1");
        assertEq(posts[1].message, "test-2");
        assertEq(posts[2].message, "test-3");
        assertEq(fbWall.getTotalPosts(), 3);
    }

    function test_TotalPosts() public {
        assertEq(fbWall.getTotalPosts(), 0);
        fbWall.createPost("test-1");
        assertEq(fbWall.getTotalPosts(), 1);
        fbWall.createPost("test-2");
        assertEq(fbWall.getTotalPosts(), 2);
    }
}
