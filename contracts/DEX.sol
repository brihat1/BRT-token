// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

import "contracts copy/token/ERC20/IERC20.sol";

contract DEX{
    IERC20 private token;
    address owner;
    uint price; // price decided by owner
    uint[] public bestPrice;  // prices in increasing order
    mapping(uint=>address) private sellingPrices;  // prices mapped to seller addresses
    uint private totalSupply;

    constructor(IERC20 _token, uint _price){
        token = _token;
        owner = msg.sender;
        price = _price;
        totalSupply = token.totalSupply();
        bestPrice = quickSort(bestPrice);
    }

    modifier onlyOwner{
        require(msg.sender == owner);
        _;
    }

    function getBalance(address _add) public view returns(uint){
        return token.balanceOf(_add);
    }

    function sell(uint _tokens, uint _price) public{
        require(token.balanceOf(msg.sender) >= _tokens, "balance of your account is not sufficient");
        token.approve(address(this), _tokens);
        bestPrice.push(_price);
        bestPrice = quickSort(bestPrice);
        sellingPrices[_price] = msg.sender;
    }
    
    function getBestPrice(uint _tokens) public view returns(uint){
        uint t;
        for(uint i=0; i<bestPrice.length; i++){
            if(token.allowance(sellingPrices[bestPrice[i]], address(this)) >= _tokens){
                t =  bestPrice[i];
                break;
            }
        }
        return t;
    }

    function buy(uint _tokens) public payable{
        uint _bestPrice = 12;   // getting best price available
        uint _payableAmount = _bestPrice*_tokens;
        require(msg.value >= _payableAmount, "not enough eth sent");
        address from = sellingPrices[_bestPrice];
        token.transferFrom(from, msg.sender, _tokens);

        payable(sellingPrices[_bestPrice]).transfer(_payableAmount); // transfering money to seller
        payable(msg.sender).transfer(msg.value - _payableAmount); // transfering refund to buyer

    }
    function quickSort(uint[] memory arr) public pure returns (uint[] memory) {
        if (arr.length <= 1) {
            return arr;
        }
        
        uint pivotIndex = arr.length - 1;
        uint pivot = arr[pivotIndex];
        
        uint smallerCount;
        uint equalCount;
        
        for (uint i = 0; i < pivotIndex; i++) {
            if (arr[i] < pivot) {
                smallerCount++;
            } else if (arr[i] == pivot) {
                equalCount++;
            }
        }
        
        uint[] memory smaller = new uint[](smallerCount);
        uint[] memory equal = new uint[](equalCount + 1);
        uint[] memory larger = new uint[](arr.length - smallerCount - equalCount - 1);
        
        smallerCount = 0;
        equalCount = 0;
        
        for (uint i = 0; i < pivotIndex; i++) {
            if (arr[i] < pivot) {
                smaller[smallerCount] = arr[i];
                smallerCount++;
            } else if (arr[i] == pivot) {
                equal[equalCount] = arr[i];
                equalCount++;
            } else {
                larger[i - smallerCount - equalCount] = arr[i];
            }
        }
        
        equal[equalCount] = pivot;
        
        smaller = quickSort(smaller);
        larger = quickSort(larger);
        
        return concatenate(smaller, equal, larger);
    }
    
    function concatenate(uint[] memory arr1, uint[] memory arr2, uint[] memory arr3) private pure returns (uint[] memory) {
        uint[] memory result = new uint[](arr1.length + arr2.length + arr3.length);
        
        uint index = 0;
        
        for (uint i = 0; i < arr1.length; i++) {
            result[index] = arr1[i];
            index++;
        }
        
        for (uint i = 0; i < arr2.length; i++) {
            result[index] = arr2[i];
            index++;
        }
        
        for (uint i = 0; i < arr3.length; i++) {
            result[index] = arr3[i];
            index++;
        }
        
        return result;
    }
    function getarr() public view returns(uint[] memory){
        return bestPrice;
    }
}