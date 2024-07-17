//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract NgnToken is ERC20 {
    address private _minter; // address of the minter

    constructor(
        string memory _name,
        string memory _symbol,
        uint8 _decimals,
        uint256 _totalSupply
    ) ERC20(_name, _symbol, _decimals, _totalSupply) {
        _minter = msg.sender; // set the minter to the contract creator
    }

    function mint(address to, uint256 amount) public {
        require(msg.sender == _minter, "Only the minter can mint");
        _mint(to, amount);
    }
}
