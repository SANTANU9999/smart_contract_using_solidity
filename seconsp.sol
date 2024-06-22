// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8;

contract lotery{
    address public manager;
    address payable[] public participants; 
    constructor() {
      manager=msg.sender;
    }
    receive() external payable {
        require(msg.value >=2 ether);
        participants.push(payable(msg.sender));
     }
     function getbel() public view returns(uint){
      require(msg.sender==manager);
        return address(this).balance;
     }
     function rendoom() internal view returns (uint){
       return uint(keccak256(abi.encodePacked(block.prevrandao,block.timestamp,participants.length)));
     }
     function winer() public{
      require(msg.sender==manager);
      require(participants.length>=3);
      address payable wine;
      uint r=rendoom();
      uint index =r%participants.length;
      wine=participants[index];
      wine.transfer(getbel());
      participants=new address payable [](0);
     }
}