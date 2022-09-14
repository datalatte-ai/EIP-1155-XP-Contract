// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/token/ERC1155/extensions/ERC1155Burnable.sol";
import "./nft_explorer.sol";

contract XpToken is ERC1155, ERC1155Burnable {
    uint256 public constant XP = 0;
    address public _accountZero = 0x55f58b0241728459aC1F26613d4EE6D439A9e7A2; //wallet which tokens dump at
    address public _nftExplorerAddress; //nft_explorer address

    constructor() ERC1155("") {}

    function assign_xp(address to, uint256 amount) public onlyOwner {
        _mint(to, XP, amount, "");
    }

    function assign_xp_toNFT(
        address account,
        uint256 nftID,
        uint256 amount
    ) public onlyOwner {
        require(amount <= balance_xp(account), "XP amount exceeds balance");
        nft_explorer(_nftExplorerAddress).xpToNFT(account, nftID, XP);
        transfer(account, amount);
    }

    function balance_xp(address account) public view returns (uint256 amount) {
        return balanceOf(account, XP);
    }

    function transfer(address account, uint256 amount) public onlyOwner {
        safeTransferFrom(account, _accountZero, XP, amount, "");
    }

    ////////////////////////////////////////////THIS FUNCTION IS JUST FOR TEST PURPOSES
    function setAdress(address nft_tracker_address) public onlyOwner {
        _nftExplorerAddress = nft_tracker_address;
    }
    //////////////////////////////////////////////////////////////////////////////////
}
