const MyCoinContract = artifacts.require("MyCoinContract");
const MyCoinSaleContract = artifacts.require("MyCoinSaleContract");

contract("MyCoinContractsTest", () => {

  before(async () => {
    this.myCoinContract = await MyCoinContract.deployed();
    this.myCoinSaleContract = await MyCoinSaleContract.deployed();
  });

  it("sale successfully", async () => {
    const account1 = '0x99548bB46fBA051883a17b8654637686518BbF1b';
    const account2 = '0x89531Ab32b2130E89f053c12e716C5f42cAfd63B';

    await this.myCoinContract.transfer(this.myCoinSaleContract.address, 950, { from: account1 });
    await this.myCoinSaleContract.buy(900, { from: account2, value: 1000000000000000 * 900 });
    await this.myCoinSaleContract.endSold({ from: account1 });

    const tokensAccount1 = await this.myCoinContract.balanceOf(account1);
    const tokensAccount2 = await this.myCoinContract.balanceOf(account2);

    assert.equal(tokensAccount1.toNumber(), 100);
    assert.equal(tokensAccount2.toNumber(), 900);
  });

});
