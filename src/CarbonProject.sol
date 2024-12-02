// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.25;

import {ERC1155} from "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import {ERC1155Burnable} from "@openzeppelin/contracts/token/ERC1155/extensions/ERC1155Burnable.sol";
import {ERC1155URIStorage} from "@openzeppelin/contracts/token/ERC1155/extensions/ERC1155URIStorage.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

contract CarbonProject is ERC1155, Ownable, ERC1155Burnable, ERC1155URIStorage  {
    
    struct Project {
        bool projectDataSet;
        uint256 id;
        string nameNumber;
        string proposer;
        string activity;
        string location;
        string status;
        uint256 startDate;
        uint256 endDate;
        uint256 period;
        string areaSize;
    }
    
    mapping (uint256 => Project) public projects;

    event NewProject(uint256 id, 
        string nameNumber, 
        string proposer, 
        string activity, 
        string location, 
        string status, 
        uint256 startDate, 
        uint256 endDate, 
        uint256 period, 
        string areaSize);

    constructor(string memory uri_, address owner_) ERC1155(uri_) Ownable(owner_) {
        _setURI(uri_);
        _setBaseURI(uri_);
    }

    function setProjectData(
        address projectOwner,
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
        string memory uri_
    ) public onlyOwner returns (bool) {
        require(balanceOf(projectOwner, id)>0, "Tokens not minted");
        require(!projects[id].projectDataSet, "Project already exists");
        projects[id] = Project({
            projectDataSet: true,
            id: id,
            nameNumber: nameNumber,
            proposer: proposer,
            activity: activity,
            location: location,
            status: status,
            startDate: startDate,
            endDate: endDate,
            period: period,
            areaSize: areaSize
        });
        emit NewProject(id, 
        nameNumber, 
        proposer, 
        activity, 
        location, 
        status, 
        startDate, 
        endDate, 
        period, 
        areaSize);
        _setURI(id, uri_);
        return true;
    }

    function getProjectData(uint256 id_) public view returns (
        bool projectDataSet,
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
    ) {
        Project memory project = projects[id_];
        return (
            project.projectDataSet,
            project.id,
            project.nameNumber,
            project.proposer,
            project.activity,
            project.location,
            project.status,
            project.startDate,
            project.endDate,
            project.period,
            project.areaSize);
    }


    function mint(address account, uint256 id, uint256 amount, bytes memory data) public onlyOwner {
        _mint(account, id, amount, data);
    }

    function uri(uint256 tokenId) public view override(ERC1155, ERC1155URIStorage) returns (string memory) {
        return ERC1155URIStorage.uri(tokenId);
    }

}