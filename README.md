# Token-Controlled Token Circulation (TCTC)
This is the concept of a general-purpose token circulating system for circulating various types of rights such
as tickets, vouchers, coupons, and licenses as tokens on the blockchain. The circulation of tokens comprises three types
of principal transactions: mint, transfer, and burn. Depending on the application, various conditions
must be satisfied to execute these transactions, e.g., only qualified shops can mint the tokens and only a certain agent
can transfer the tokens. The token circulating system mints, transfers, or burns a token only if the control
tokens are owned by the participants of the transaction. The circulation control tokens themselves can be any type of
token, e.g., a driver's license or a membership certificate of a certain group, and recursively circulated in the token
circulating system. This scheme eliminates the need to write complex circulation control in smart contracts for each
application, improving the security of the system and reducing development costs. The idea of using tokens for token
circulation was already presented in a paper by the authors in 1999, but with the spread of modern smart contracts and
token wallets, it has become a practical and feasible technology.

## Reference Implementation
https://goerli.etherscan.io/address/0x0324a7b0b5f984a15fb6b2df20118c22624168e8#code

## Source Code on Remix
https://remix.ethereum.org/address/0x0324A7b0B5F984a15Fb6B2DF20118C22624168E8

## White Paper
https://ssrn.com/abstract=4297719
