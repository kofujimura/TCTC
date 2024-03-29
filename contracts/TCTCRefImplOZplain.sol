// SPDX-License-Identifier: Apache-2.0
// Author: Ko Fujimura <ko@fujimura.com>
// Open source repo: https://github.com/kofujimura/TCTC

pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "./ERC7303.sol";

contract MyToken is ERC721, ERC721URIStorage, ERC7303 {
    bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");
    bytes32 public constant BURNER_ROLE = keccak256("BURNER_ROLE");

    constructor() ERC721("MyToken", "MTK") {
        // Specifies the deployed contract ID of the control token.
        // This sample contract is deployed on Goerli.
        _grantRoleByERC721Token(MINTER_ROLE, 0xF1e33c646a12F68bC8015b4AED29BB316fA2D593);
        _grantRoleByERC721Token(BURNER_ROLE, 0xcDc6fD5F29E2641f25c90235eDA984f99aA3a1DD);
        _grantRoleByERC1155Token(MINTER_ROLE, 0x11d43325044f7f06727cb374aE78C3A3494F4b26, 1);  // TypeID = 1
        _grantRoleByERC1155Token(BURNER_ROLE, 0x11d43325044f7f06727cb374aE78C3A3494F4b26, 2);  // TypeID = 2
    }

    function _baseURI() internal pure override returns (string memory) {
        return "https://kofujimura.github.io/sample-NFT-metadata/assets/";
    }

    function safeMint(address to, uint256 tokenId, string memory uri)
        public onlyHasToken(MINTER_ROLE, msg.sender)
    {
        _safeMint(to, tokenId);
        _setTokenURI(tokenId, uri);
    }

    function burn(uint256 tokenId) 
        public onlyHasToken(BURNER_ROLE, msg.sender) 
    {
        _burn(tokenId);
    }

    // The following functions are overrides required by Solidity.
    function _burn(uint256 tokenId) internal override(ERC721, ERC721URIStorage) {
        super._burn(tokenId);
    }

    function tokenURI(uint256 tokenId)
        public
        view
        override(ERC721, ERC721URIStorage)
        returns (string memory)
    {
        return super.tokenURI(tokenId);
    }

    function supportsInterface(bytes4 interfaceId)
        public
        view
        override(ERC721, ERC721URIStorage)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }

}
