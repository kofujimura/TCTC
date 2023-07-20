// SPDX-License-Identifier: Apache-2.0

pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

abstract contract ERC7303 {
    mapping (bytes32 => address []) private _controlTokens;

    modifier onlyHasToken(bytes32 r, address u) {
        require(_checkHasToken(r,u), "TokenController: not has a required token");
        _;
    }

    /**
     * @notice Grant a role to user who owns a control token specified by the contract ID. 
     * Multiple calls are allowed, in this case the user must own at least one of the 
     * specified token.
     * @param r byte32 The role which you want to grant.
     * @param c address The address of contract ID of which token the user required to own.
     */
    function _grantRoleByToken (bytes32 r, address c) internal {
        require(
            IERC165(c).supportsInterface(type(IERC721).interfaceId),
            "TokenController: provided contract does not support ERC721 interface"
        );
        _controlTokens[r].push(c);
    }

    function _checkHasToken (bytes32 r, address u) internal view returns (bool) {
        address[] memory controlTokens = _controlTokens[r];
        for (uint i = 0; i < controlTokens.length; i++) {
            if (IERC721(controlTokens[i]).balanceOf(u) > 0) return true;
        }
        return false;
    }
}
