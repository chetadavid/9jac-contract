const NigerianContract = artifacts.require('NigerianContract');
const chai = require('chai');
const expect = chai.expect;

contract('NigerianContract', () => {
  let contract;
  let owner;
  let nftTokenId;

  beforeEach(async () => {
    contract = await NigerianContract.new();
    owner = accounts[0];
    nftTokenId = await contract.mintAndBecomeEligible(owner);
  });

  describe('mintAndBecomeEligible', () => {
    it('should mint an NFT and mark the owner as eligible', async () => {
      expect(await contract.eligibleCitizens(owner)).to.be.true;
    });
  });

  describe('withdrawFunds', () => {
    it('should allow eligible citizens to withdraw funds', async () => {
      await contract.withdrawFunds(owner);
      expect(await contract.balanceOf(owner)).to.equal(1000);
    });

    it('should not allow non-eligible citizens to withdraw funds', async () => {
      const nonEligibleOwner = accounts[1];
      await expect(contract.withdrawFunds(nonEligibleOwner)).to.be.revertedWith('You are not eligible for funds');
    });
    it('should not allow eligible citizens to withdraw funds twice', async () => {
      await contract.withdrawFunds(owner);
      await expect(contract.withdrawFunds(owner)).to.be.revertedWith('You have already withdrawn funds');
    });
  });
});
