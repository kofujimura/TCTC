// SPDX-License-Identifier: Apache-2.0
// Author: Ko Fujimura <ko@fujimura.com>
// Open source repo: https://github.com/kofujimura/TCTC

pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract TokenController {
    mapping (bytes32 => address []) private _controlTokens;

    modifier onlyHasToken(bytes32 r, address u) {
        require(_checkHasToken(r,u), "TokenController: not has a required token");
        _;
    }

    // Specifies the contract ID of the token that must be owned by a user with the 
    // specified role. Multiple calls are allowed, in this case the user must own at 
    // least one of the specified token.
    function _grantRoleByToken (bytes32 r, address c) internal {
        _controlTokens[r].push(c);
    }

    function _checkHasToken (bytes32 r, address u) internal view returns (bool) {
        for (uint i = 0; i < _controlTokens[r].length; i++) {
            if (IERC721(_controlTokens[r][i]).balanceOf(u) > 0) return true;
        }
        return false;
    }
}
