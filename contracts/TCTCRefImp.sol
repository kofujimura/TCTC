// SPDX-License-Identifier: Apache-2.0
// Author: Ko Fujimura <ko@fujimura.com>

pragma solidity ^0.8.9;

import "./TCTC.sol";

contract MyToken is TCTC {
    event ErcRefImplDeploy(uint256 version, string name, string url);
    constructor (uint256 _version) TCTC(
        "MyToken",
        "MTK",
        0xf8e81D47203A594245E36C48e151709F0C19fBe8, // ContractID of the token minter must have. Need to be modfied
        0xf8e81D47203A594245E36C48e151709F0C19fBe8, // ContractID of the token holder must have. Need to be modfied
        0xf8e81D47203A594245E36C48e151709F0C19fBe8  // ContractID of the token burner must have. Need to be modfied
    ) {
        emit ErcRefImplDeploy(_version, "MyToken", "<tbd>");
    }
}
