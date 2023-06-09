// We require the Hardhat Runtime Environment explicitly here. This is optional
// but useful for running the script in a standalone fashion through `node <script>`.
//
// You can also run a script with `npx hardhat run <script>`. If you do that, Hardhat
// will compile your contracts, add the Hardhat Runtime Environment's members to the
// global scope, and execute the script.
const hre = require("hardhat");

async function main() {
  const signers = await ethers.getSigners();
  console.log("address of the deployer is " + signers[0]);

  const Token = await hre.ethers.getContractFactory("BRTtoken");
  const token = await Token.deploy(1000);
  

  const Dex = await hre.ethers.getContractFactory("DEX");
  const dex = await Dex.deploy(token.address, 100);
  console.log(dex.address, dex.interface.format());

  await token.deployed();
  await dex.deployed();
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
