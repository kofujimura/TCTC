// SPDX-License-Identifier: Apache-2.0
// Author: Ko Fujimura <ko@fujimura.com>
// Open source repo: https://github.com/kofujimura/TCTC

pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "./ERC7303.sol";

contract MyComplexToken is ERC721, ERC721URIStorage, ERC7303 {
    bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");
    bytes32 public constant BURNER_ROLE = keccak256("BURNER_ROLE");
    bytes32 public constant MEMBER_ROLE = keccak256("MEMBER_ROLE");

    constructor() ERC721("MyComplexToken", "MCT") {
        // Minter must own at least one of the tokens below (OR semantics):
        // typeId 1 = MinterCert, typeId 3 = PartnerMinterCert.
        _grantRoleByERC1155(MINTER_ROLE, 0x12342A7F0190B3AF3F4b47546D34006EDA54eE0B, 1);
        _grantRoleByERC1155(MINTER_ROLE, 0x12342A7F0190B3AF3F4b47546D34006EDA54eE0B, 3);
        // Minter also must own the membership token below (AND across roles):
        _grantRoleByERC721(MEMBER_ROLE, 0x4223260CEf7cbA173C227b1B11E8a6a8Ce2E388a);

        // Burner must own the token below:
        _grantRoleByERC1155(BURNER_ROLE, 0x12342A7F0190B3AF3F4b47546D34006EDA54eE0B, 2);
    }

    function _baseURI() internal pure override returns (string memory) {
        return "https://kofujimura.github.io/sample-NFT-metadata/assets/";
    }

    function safeMint(address to, uint256 tokenId, string memory uri)
        public onlyHasToken(MINTER_ROLE, msg.sender) onlyHasToken(MEMBER_ROLE, msg.sender)
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
        return interfaceId == type(IERC7303).interfaceId || super.supportsInterface(interfaceId);
    }
}
