// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "./TokenController.sol";

contract MyToken is ERC721, TokenController {
    bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");
    bytes32 public constant BURNER_ROLE = keccak256("HOLDER_ROLE");

    constructor() ERC721("MyTCToken", "TCT") {
        _grantRoleToken(MINTER_ROLE, 0x8965B739DF91eB621D9FF06af4A48198f711BbD9);
        _grantRoleToken(BURNER_ROLE, 0x8965B739DF91eB621D9FF06af4A48198f711BbD9);
    }

    function safeMint(address to, uint256 tokenId) public onlyHasToken(MINTER_ROLE, msg.sender) {
        _safeMint(to, tokenId);
    }

    function burn(uint256 tokenId) public onlyHasToken(BURNER_ROLE, msg.sender) {
        _burn(tokenId);
    }

    // The following functions are overrides required by Solidity.

    function supportsInterface(bytes4 interfaceId)
        public
        view
        override(ERC721)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }
}
