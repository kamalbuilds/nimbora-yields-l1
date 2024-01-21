import { ethers, network } from "hardhat";
import { readConfigs } from "./utils";

async function main() {
  const configs = readConfigs();
  const addresses = configs[network.name];

  const poolingManager = await ethers.getContractAt(
    "PoolingManager",
    addresses.l1PoolingManager
  );

  try {
    console.log("Set new l2 pooling manager");
    await poolingManager.setPoolingManager(addresses.l2PoolingManager);
  } catch (error) {
    console.error("Error:", error);
  }
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
