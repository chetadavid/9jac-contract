//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import  "./NgnNft.sol";
import "./NgnToken.sol";

contract NigerianContract {
NgnNft public ngnNft; // address 0
NgnToken public  ngnToken; // address 0

    constructor(address _ngnNft, address _ngnToken){
        ngnNft = NgnNft(_ngnNft);
        ngnToken = NgnToken(_ngnToken);
    }

    mapping(address => bool) public eligibleCitizens;

    function mintAndBecomeEligible(address owner) public {
         require(msg.sender == address(this), "Only the contract owner can mint NFTs");
         require(eligibleCitizens[owner], "You are not eligible for funds");
             ngnNft.mint(owner);
             eligibleCitizens[owner] = true;
         emit NftMinted(owner); // emit an event when an NFT is minted
}



    function withdrawFunds(address owner) public {
        require(eligibleCitizens[owner], "You are not eligible for funds"); //good 
        require( ngnNft.balanceOf(owner) == 0, "You have already withdrawn funds");
       
        ngnToken.transfer(owner, 1000); 

        

    }
}