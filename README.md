# BRT-token
Name - BRIHAT  
Symbol - BRT
## DEX Contract  
This is a decentralized exchange (DEX) smart contract written in Solidity. It allows users to buy and sell tokens at different prices determined by the contract owner.

## Prerequisites  
Solidity ^0.8.0  
IERC20 contract interface  
## License  
This project is licensed under the terms of the GPL-3.0 license. See the LICENSE file for more information.  

## Features  
Users can sell tokens at a desired price.   
The contract maintains a list of best prices in increasing order.  
Each price in the list is mapped to the address of the seller offering that price.  
Users can buy tokens at the best available price.  
QuickSort algorithm is used to sort the list of prices.  
## Installation  
Clone the repository.  
Install Solidity compiler.  
Import the IERC20 contract.  
## Usage  
Deploy the DEX contract with the following parameters:  
_token: The address of the ERC20 token contract.  
_price: The initial price set by the owner.  
## Use the following functions to interact with the DEX contract:  
getBalance(address _add): Returns the token balance of the specified address.  
sell(uint _tokens, uint _price): Allows a user to sell tokens at the desired price.  
getBestPrice(uint _tokens): Returns the best available price for buying the specified number of tokens.  
buy(uint _tokens): Allows a user to buy tokens at the best available price.  
## Modifiers  
onlyOwner: Ensures that a function can only be called by the contract owner.  

## Contributing  
Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.  

## License  
This project is licensed under the terms of the GPL-3.0 license. See the LICENSE file for more information.  





