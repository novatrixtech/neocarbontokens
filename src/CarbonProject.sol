// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.25;

import {ERC1155} from "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import {ERC1155Burnable} from "@openzeppelin/contracts/token/ERC1155/extensions/ERC1155Burnable.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

contract CarbonProject is ERC1155, Ownable, ERC1155Burnable  {
    
    bool public _projectDataSet;
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

    constructor(string memory uri_, address owner_, uint256 tokenAmount_) ERC1155(uri_) Ownable(owner_) {
        _setURI(uri_);
        _projectDataSet = false;
        _mint(owner_, 1, tokenAmount_, "");
    }

    function setProjectData(
        uint256 id,
        string memory nameNumber,
        string memory proposer,
        string memory activity,
        string memory location,
        string memory status,
        uint256 startDate,
        uint256 endDate,
        uint256 period,
        string memory areaSize
    ) public onlyOwner returns (bool) {
        require(!_projectDataSet, "Project data already set");
        _id = id;
        _nameNumber = nameNumber;
        _proposer = proposer;
        _activity = activity;
        _location = location;
        _status = status;
        _startDate = startDate;
        _endDate = endDate;
        _period = period;
        _areaSize = areaSize;
        _projectDataSet = true;
        return true;
    }

    function getProjectData() public view returns (
        uint256 id,
        string memory nameNumber,
        string memory proposer,
        string memory activity,
        string memory location,
        string memory status,
        uint256 startDate,
        uint256 endDate,
        uint256 period,
        string memory areaSize,
        bool projectDataSet
    ) {
        return (_id, _nameNumber, _proposer, _activity, _location, _status, _startDate, _endDate, _period, _areaSize, projectDataSet);
    }


    function mint(address account, uint256 id, uint256 amount, bytes memory data) public onlyOwner {
        _mint(account, id, amount, data);
    }

    function mintBatch(address to, uint256[] memory ids, uint256[] memory amounts, bytes memory data) public onlyOwner {
        _mintBatch(to, ids, amounts, data);
    }
}