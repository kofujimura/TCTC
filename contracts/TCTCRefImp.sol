// SPDX-License-Identifier: Apache-2.0
// Author: Ko Fujimura <ko@fujimura.com>

pragma solidity ^0.8.9;

import "./TCTC.sol";

contract TCTCRefImpl is TCTC {
    event ErcRefImplDeploy(uint256 version, string name, string url);

    constructor (uint256 _version) TCTC(
        "TCTCRefImpl",
        "TCT"
    ) {
        // ContractID of the token minter must have. Need to be modfied
        _addControlToken(Role.MINTER, 0x8965B739DF91eB621D9FF06af4A48198f711BbD9);
        // Comment out the following line so that the condition doesn't apply:
        // _addControlToken(Role.HOLDER, 0x8965B739DF91eB621D9FF06af4A48198f711BbD9);
        // ContractID of the token burner must have. Need to be modfied
        _addControlToken(Role.BURNER, 0x8965B739DF91eB621D9FF06af4A48198f711BbD9);
 
        emit ErcRefImplDeploy(_version, "TCTCRefImpl", "https://github.com/kofujimura/TCTC");
    }
}
