// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

// Uncomment this line to use console.log
import "hardhat/console.sol";

contract Lock {

    uint counter =1;
  function random() public returns (uint) {
        counter++;
        // sha3 and now have been deprecated
        return uint(keccak256(abi.encodePacked(block.difficulty, block.timestamp, counter)));                
    }

    // 50 
    // 1st  = random() % 100000 // 9560
    // 2nd  = random() % 100000 - 1
    // 3rd  = random() % 100000 - 2
    // 50th = random() % 100000 - 50





    mapping (uint=>uint) randomTop50;
    mapping (uint=>bool) test;
    uint[] public randomTop50Array;

    function randomWinners() public {
        uint maxRange = 500;
        uint winnersCount = 150;
        for (uint256 i=0; randomTop50Array.length < winnersCount; i++) {
            uint maxRangeDecrees = maxRange-i;
            uint newWinner = random() % maxRangeDecrees;
            console.log(i, ": 1::===> ", newWinner);
                console.log("randomTop50[newWinner]", randomTop50[newWinner]);
            if(randomTop50[newWinner] != 0){
                if(randomTop50[maxRangeDecrees]==0){
                    // randomTop50Array[i] = randomTop50[newWinner];
                    randomTop50Array.push(randomTop50[newWinner]);
                    randomTop50[newWinner] = maxRangeDecrees;
                    console.log("===if===", randomTop50[newWinner]);
                }
            }
            else{
                if(randomTop50[maxRangeDecrees]==0){
                    randomTop50[newWinner]= maxRangeDecrees;
                    // randomTop50Array[i] = newWinner;
                    randomTop50Array.push(newWinner);
                    console.log("===else===" , randomTop50[newWinner]);
                }
            }
            // console.log(i, ": 2::===> ", randomTop50Array[i]);
            // console.log(i, ": 3::===> ", randomTop50Array[i]==newWinner);
        }

        console.log("\n\n\nprint loop\n\n\n");
        for (uint256 i=0; i<randomTop50Array.length; i++) {
            if(test[randomTop50Array[i]]){
                console.log(i, "=====>rupeet ", randomTop50Array[i]);
            }
            else{
                test[randomTop50Array[i]] = true;
            }
            console.log(i, test[i], "::===> ", randomTop50Array[i]);
        }
    }



    // mapping (uint=>uint) randomTop50;
    // uint[] public randomTop50Array;

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
