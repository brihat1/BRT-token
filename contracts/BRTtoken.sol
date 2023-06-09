// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

import "contracts copy/token/ERC20/ERC20.sol";

contract BRTtoken is ERC20{
    constructor(uint init_supp) ERC20("BRIHAT","BRT"){
        _mint(msg.sender, init_supp);
    }
}