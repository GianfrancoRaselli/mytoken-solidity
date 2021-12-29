const MyCoinContract = artifacts.require("MyCoinContract");
const MyCoinSaleContract = artifacts.require("MyCoinSaleContract");

module.exports = async function (deployer) {
  await deployer.deploy(MyCoinContract);
  const myCoinContract = await MyCoinContract.deployed();
  await deployer.deploy(MyCoinSaleContract, 1000000000000000, myCoinContract.address);
};
