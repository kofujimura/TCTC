// SPDX-License-Identifier: Apache-2.0
// Author: Ko Fujimura <ko@fujimura.com>
// Open source repo: https://github.com/kofujimura/TCTC

pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "./ERC5679.sol";

contract TCTC is ERC5679Ext721, ERC721 {

    enum Role {MINTER, HOLDER, BURNER}

    mapping (Role => address []) controlTokens;

    constructor(string memory _name, string memory _symbol) ERC721(_name, _symbol) {}
    
    modifier onlyHasToken(Role r, address u) {
        for (uint i = 0; i < controlTokens[r].length; i++) {
            require(IERC721(controlTokens[r][i]).balanceOf(u) > 0, "TCTC: not own a required token");
        }
        _;
    }

    function _addControlToken (Role r, address c) internal {
        controlTokens[r].push(c);
    }

    function safeMint(
        address _to,
        uint256 _id,
        bytes calldata // _data (unused)
    ) external virtual override onlyHasToken(Role.MINTER,_msgSender()) onlyHasToken(Role.HOLDER, _to) {
        _safeMint(_to, _id); // ignoring _data in this simple reference implementation.
    }

    /**
     * @dev See {IERC721-transferFrom}.
     */
    function transferFrom(
        address _from,
        address _to,
        uint256 _id
    ) public virtual override onlyHasToken(Role.HOLDER, _from) onlyHasToken(Role.HOLDER, _to){
        //solhint-disable-next-line max-line-length
        require(_isApprovedOrOwner(_msgSender(), _id), "TCTC: caller is not token owner or approved");
        _transfer(_from, _to, _id);
    }

    /**
     * @dev See {IERC721-safeTransferFrom}.
     */
    function safeTransferFrom(
        address _from,
        address _to,
        uint256 _id
    ) public virtual override onlyHasToken(Role.HOLDER, _from) onlyHasToken(Role.HOLDER, _to) {
        require(_isApprovedOrOwner(_msgSender(), _id), "TCTC: caller is not token owner or approved");
        _safeTransfer(_from, _to, _id, "");
    }

     /**
     * @dev See {IERC721-safeTransferFrom}.
     */
    function safeTransferFrom(
        address _from,
        address _to,
        uint256 _id,
        bytes memory data
    ) public virtual override onlyHasToken(Role.HOLDER, _from) onlyHasToken(Role.HOLDER, _to) {
        require(_isApprovedOrOwner(_msgSender(), _id), "TCTC: caller is not token owner or approved");
        _safeTransfer(_from, _to, _id, data);
    }

    function burn(
        address _from,
        uint256 _id,
        bytes calldata // _data (unused)
    ) external virtual override onlyHasToken(Role.HOLDER, _msgSender()) onlyHasToken(Role.HOLDER, _from) {
        // Depends on applicaton whether
        // require(_isApprovedOrOwner(_msgSender(), _id), "TCTC: caller is not token owner or approved");
        _burn(_id); // ignoring _data in this simple reference implementation.
    }

    function supportsInterface(bytes4 interfaceId)
        public
        view
        override(ERC721, ERC5679Ext721)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }

}
