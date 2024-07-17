//SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract NgnNft is ERC721 {
    constructor(string memory name, string memory symbol)
        ERC721(name, symbol)
    {
    }

    uint256 tokenId;
    mapping(uint256 => string) public tokenURIs;

    function mint(address owner) public {
        tokenId += 1;
        _safeMint(owner, tokenId);
        tokenURIs[tokenId] = "(link unavailable)" + tokenId; 
    }

    function setTokenURI(uint256 id, string memory uri) public {
        require(
            _isApprovedOrOwner(msg.sender, id),
            "Only the owner or approved operator can set the token URI"
        );
        tokenURIs[id] = uri;
    }
    function tokenURI(uint256 id) public view returns (string memory) {
        return tokenURIs[id];
    }
}

