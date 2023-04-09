// SPDX-License-Identifier: Apache-2.0
// Author: Ko Fujimura <ko@fujimura.com>
// Open source repo: <tbd>

pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "./ERC5679.sol";

abstract contract TCTC is ERC5679Ext721, ERC721 {
    address private _minterTokenContract;
    address private _holderTokenContract;
    address private _burnerTokenContract;

    constructor(
        string memory _name,
        string memory _symbol,
        address minterTokenContract,
        address holderTokenContract,
        address burnerTokenContract
    ) ERC721(_name, _symbol) {
        _minterTokenContract = minterTokenContract;
        _holderTokenContract = holderTokenContract;
        _burnerTokenContract = burnerTokenContract;
    }
    
    modifier onlyMinter(address u) {
        require(IERC721(_minterTokenContract).balanceOf(u) >= 1, "TCTC: not minter");
        _;
    }

    modifier onlyHolder(address u) {
        require(IERC721(_holderTokenContract).balanceOf(u) >= 1, "TCTC: not holder");
        _;
    }

    modifier onlyBurner(address u) {
        require(IERC721(_burnerTokenContract).balanceOf(u) >= 1, "TCTC: not burner");
        _;
    }    

    function safeMint(
        address _to,
        uint256 _id,
        bytes calldata // _data (unused)
    ) public virtual onlyMinter(_msgSender()) onlyHolder(_to) {
        _safeMint(_to, _id); // ignoring _data in this simple reference implementation.
    }

    /**
     * @dev See {IERC721-transferFrom}.
     */
    function transferFrom(
        address _from,
        address _to,
        uint256 _id
    ) public virtual override onlyHolder(_from) onlyHolder(_to){
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
    ) public virtual override {
        safeTransferFrom(_from, _to, _id, "");
    }    

     /**
     * @dev See {IERC721-safeTransferFrom}.
     */
    function safeTransferFrom(
        address _from,
        address _to,
        uint256 _id,
        bytes memory data
    ) public virtual override onlyHolder(_from) onlyHolder(_to) {
        require(_isApprovedOrOwner(_msgSender(), _id), "TCTC: caller is not token owner or approved");
        _safeTransfer(_from, _to, _id, data);
    }

    function burn(
        address _from,
        uint256 _id,
        bytes calldata // _data (unused)
    ) public virtual  onlyBurner(_msgSender()) onlyHolder(_from) {
        // Depends on applicaton whether
        // require(_isApprovedOrOwner(_msgSender(), _id), "TCTC: caller is not token owner or approved");
        _burn(_id); // ignoring _data in this simple reference implementation.
    }

    function supportsInterface(bytes4 interfaceId)
        public
        view
        override(ERC5679Ext721, ERC721)
        returns (bool)
    {}

}
