// SPDX-License-Identifier: Apache-2.0
// Author: Ko Fujimura <ko@fujimura.com>

pragma solidity ^0.8.9;

import "./TCTC.sol";

contract MyToken is TCTC {
    event ErcRefImplDeploy(uint256 version, string name, string url);
    constructor (uint256 _version) TCTC(
        "MyToken",
        "MTK",
        // See the contract (ERC5679RefImpl.sol) deployed in the Goerli Testnet
        0x8965B739DF91eB621D9FF06af4A48198f711BbD9, // ContractID of the token minter must have. Need to be modfied
        0x8965B739DF91eB621D9FF06af4A48198f711BbD9, // ContractID of the token holder must have. Need to be modfied
        0x8965B739DF91eB621D9FF06af4A48198f711BbD9  // ContractID of the token burner must have. Need to be modfied
    ) {
        emit ErcRefImplDeploy(_version, "MyToken", "<tbd>");
    }
}
