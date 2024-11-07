// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.25;

import {ERC1155} from "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";

contract CarbonProject is ERC1155 {
    
    uint256 public _id;
    string public _nameNumber;
    string public _proposer;
    string public _activity;
    string public _location;
    string public _status;
    uint256 public _startDate;
    uint256 public _endDate;
    uint256 public _period;
    string public _areaSize;

    constructor(string memory uri_) ERC1155(uri_) {
        _setURI(uri_);
    }

}