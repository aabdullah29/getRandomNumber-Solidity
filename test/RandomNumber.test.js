const {
  loadFixture,
} = require("@nomicfoundation/hardhat-network-helpers");
const { anyValue } = require("@nomicfoundation/hardhat-chai-matchers/withArgs");
const { expect } = require("chai");

describe("RandomNumber", function () {
  async function deploy() {
    const [owner, otherAccount] = await ethers.getSigners();

    const RandomNumber = await ethers.getContractFactory("RandomNumber");
    const randomNumber = await RandomNumber.deploy();

    return { randomNumber, owner, otherAccount };
  }

  describe("Deployment", function () {
    it("call randomTop50Array", async function () {
      const { randomNumber, owner } = await loadFixture(deploy);
      await randomNumber.findWinners(500, 150);

      const solidityPublicArrayToJsArray = async (contract, arrayName) => {
        let err = undefined;
        let array = [];
        while (err === undefined) {
          try {
            const item = await contract[arrayName](array.length);
            array.push(item.toString());
          } catch (e) {
            err = e;
          }
        }
        console.log("\nResult length is: ", array.length, "\n");

        return array;
      }

      console.log("Result: ", await solidityPublicArrayToJsArray(randomNumber, "randomTop50Array"));
      // console.log("\nResult single index: ", (await randomNumber["randomTop50Array"](10)).toString());

    });
  });
});
