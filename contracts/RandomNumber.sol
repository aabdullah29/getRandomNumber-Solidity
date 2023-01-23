// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "hardhat/console.sol";

contract RandomNumber {

    function random() public view returns (uint) {
        return uint(keccak256(abi.encodePacked(block.difficulty, block.timestamp)));        
    }

    mapping (uint=>uint) randomTop50;
    uint[] public randomTop50Array;

    function findWinners(uint maxRange, uint winnersCount) public {
        delete randomTop50Array;
        for (uint256 i=0; randomTop50Array.length < winnersCount; i++) {
            uint maxRangeDecrees = maxRange-i;
            uint newWinner = random() % maxRangeDecrees;
            if(randomTop50[newWinner] != 0){
                if(randomTop50[maxRangeDecrees]==0){
                    randomTop50Array.push(randomTop50[newWinner]);
                    randomTop50[newWinner] = maxRangeDecrees;
                }
            }
            else{
                if(randomTop50[maxRangeDecrees]==0){
                    randomTop50[newWinner]= maxRangeDecrees;
                    randomTop50Array.push(newWinner);
                }
            }
        }
    }
}
