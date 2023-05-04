// SPDX-License-Identifier: Apache-2.0
// Author: Ko Fujimura <ko@fujimura.com>
// Open source repo: https://github.com/kofujimura/TCTC

pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

import "./ERC5679.sol";
import "./TokenController.sol";

contract TCTCRefImpl is TokenController, ERC5679Ext721, ERC721 {
    event ErcRefImplDeploy(uint256 version, string name, string url);

    bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");
    bytes32 public constant HOLDER_ROLE = keccak256("HOLDER_ROLE");
    bytes32 public constant BURNER_ROLE = keccak256("BURNER_ROLE");

    constructor (uint256 _version) ERC721(
        "TCTCRefImpl",
        "TCT"
    ) {
        // ContractID of the token minter must have. Need to be modfied
        _grantRoleByToken(MINTER_ROLE, 0x8965B739DF91eB621D9FF06af4A48198f711BbD9);
        // ContractID of the token minter must have. Need to be modfied
        _grantRoleByToken(HOLDER_ROLE, 0x8965B739DF91eB621D9FF06af4A48198f711BbD9);
        // ContractID of the token burner must have. Need to be modfied
        _grantRoleByToken(BURNER_ROLE, 0x8965B739DF91eB621D9FF06af4A48198f711BbD9);
 
        emit ErcRefImplDeploy(_version, "TCTCRefImpl", "https://github.com/kofujimura/TCTC");
    }

    // The following functions are overrides required by Solidity.
    function safeMint(
        address _to,
        uint256 _id,
        bytes calldata // _data (unused)
    ) external override onlyHasToken(MINTER_ROLE,_msgSender()) onlyHasToken(HOLDER_ROLE, _to) {
        _safeMint(_to, _id); // ignoring _data in this simple reference implementation.
    }

    /**
     * @dev See {IERC721-transferFrom}.
     */
    function transferFrom(
        address _from,
        address _to,
        uint256 _id
    ) public override onlyHasToken(HOLDER_ROLE, _from) onlyHasToken(HOLDER_ROLE, _to){
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
    ) public override onlyHasToken(HOLDER_ROLE, _from) onlyHasToken(HOLDER_ROLE, _to) {
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
    ) public override onlyHasToken(HOLDER_ROLE, _from) onlyHasToken(HOLDER_ROLE, _to) {
        require(_isApprovedOrOwner(_msgSender(), _id), "TCTC: caller is not token owner or approved");
        _safeTransfer(_from, _to, _id, data);
    }

    function burn(
        address _from,
        uint256 _id,
        bytes calldata // _data (unused)
    ) external override onlyHasToken(BURNER_ROLE, _msgSender()) onlyHasToken(HOLDER_ROLE, _from) {
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
