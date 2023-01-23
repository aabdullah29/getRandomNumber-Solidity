const {
  loadFixture,
} = require("@nomicfoundation/hardhat-network-helpers");
const { anyValue } = require("@nomicfoundation/hardhat-chai-matchers/withArgs");
const { expect } = require("chai");

describe("Lock", function () {
  async function deployOneYearLockFixture() {
    const [owner, otherAccount] = await ethers.getSigners();

    const Lock = await ethers.getContractFactory("Lock");
    const lock = await Lock.deploy();

    return { lock, owner, otherAccount };
  }

  describe("Deployment", function () {
    it("call randomTop50Array", async function () {
      const { lock, unlockTime } = await loadFixture(deployOneYearLockFixture);
      await lock.findWinners(500,150);

      const solidityPublicArrayToJsArray = async(contract, arrayName) => {
        let err = undefined;
        let array= [];
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

      console.log("Result: ", await solidityPublicArrayToJsArray(lock, "randomTop50Array"));
      // console.log("\nResult single index: ", (await lock["randomTop50Array"](10)).toString());

    });

    // it("Should set the right owner", async function () {
    //   const { lock, owner } = await loadFixture(deployOneYearLockFixture);

    //   expect(await lock.owner()).to.equal(owner.address);
    // });
  });
});
