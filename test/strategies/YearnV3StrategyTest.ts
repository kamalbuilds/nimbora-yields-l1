import { ethers } from "hardhat";
import { expect } from "chai";
import { Signer } from "ethers";

describe("YearnV3Strategy Tests", function () {
    let yearnV3Strategy: any;
  let deployer: Signer;
  let user: Signer;

  beforeEach(async function () {
    [deployer, user] = await ethers.getSigners();

    // Deploy MockYearnV3Vault
    const MockYearnV3VaultFactory = await ethers.getContractFactory("MockYearnV3Vault");
    const mockYearnV3Vault = await MockYearnV3VaultFactory.deploy();

    const erc20MintableMockFactory = await ethers.getContractFactory('ERC20Mock');
    const underlyingToken = await erc20MintableMockFactory.deploy();
    const underlyingTokenAddress = await underlyingToken.getAddress()

    // Deploy YearnV3Strategy with the mock vault
    const YearnV3StrategyFactory = await ethers.getContractFactory("YearnV3Strategy");
    yearnV3Strategy = await YearnV3StrategyFactory.deploy(
      await deployer.getAddress(),
      mockYearnV3Vault.address
    );
  });

  it("should deposit assets into the Yearn V3 Vault", async function () {
    const depositAmount = ethers.parseEther("1");
    await yearnV3Strategy.deposit(depositAmount);
  });

  it("should withdraw assets from the Yearn V3 Vault", async function () {
    const withdrawAmount = ethers.parseEther("0.5");
    await yearnV3Strategy.withdraw(withdrawAmount);
    // todo Verify withdrawal logic, e.g., balance checks or event emissions
  });

});
