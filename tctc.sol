// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "hardhat/console.sol";
contract TCTC is ERC721 {
   address private _issuerTokenContract;
   address private _holderTokenContract;
   address private _collectorTokenContract;
 
   constructor(
       string memory name,
       string memory symbol,
       address issuerTokenContract,
       address holderTokenContract,
       address collectorTokenContract
   ) ERC721(name, symbol) {
       _issuerTokenContract = issuerTokenContract;
       _holderTokenContract = holderTokenContract;
       _collectorTokenContract = collectorTokenContract;
   }
 
   modifier onlyIssuer(address u) {
      IERC721 m = IERC721(_issuerTokenContract);
      require(m.balanceOf(u) >= 1, "not issuer");
      _;
   }
 
   modifier onlyHolder(address u) {
      IERC721 m = IERC721(_holderTokenContract);
      require(m.balanceOf(u) >= 1, "not holder");
      _;
   }
 
   modifier onlyCollector(address u) {
      IERC721 m = IERC721(_collectorTokenContract);
      require(m.balanceOf(u) >= 1, "not collector");
      _;
   }
 
   function issue(address _to, uint256 tokenId) public onlyIssuer(msg.sender) onlyHolder(_to) {
      _safeMint(msg.sender, tokenId);
      safeTransferFrom(msg.sender, _to, tokenId);
   }
}
 
contract MyToken is TCTC {
   constructor() TCTC(
       "MyToken",
       "MTK",
       0xB57ee0797C3fc0205714a577c02F7205bB89dF30, // ContractID of MemberCert. Must be modefied
       0xB57ee0797C3fc0205714a577c02F7205bB89dF30, // ContractID of MemberCert. Must be modefied
       0xB57ee0797C3fc0205714a577c02F7205bB89dF30  // ContractID of MemberCert. Must be modefied
   ) {}
}
 
contract MemberCert is ERC721, Ownable {           // Assume that this contract ID is above.
   constructor() ERC721("ShopMember", "ASHP") {}
   function mintAndTransfer(address _to, uint256 tokenId) public onlyOwner {
      _safeMint(msg.sender, tokenId);
      safeTransferFrom(msg.sender, _to, tokenId);
   }
}
