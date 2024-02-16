// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts-upgradeable/utils/PausableUpgradeable.sol";
import "../StrategyBase.sol";
import "../../interfaces/IVault.sol"; // Yearn v3's vault interface
import {ErrorLib} from "../../lib/ErrorLib.sol";

contract YearnV3Strategy is StrategyBase {
    IVault public yearnVault;

    function initialize(
        address _poolingManager,
        address _underlyingToken,
        address _yearnVaultAddress
    ) public initializer {
        super.initializeStrategyBase(_poolingManager, _underlyingToken, _yearnVaultAddress);
        yearnVault = IVault(_yearnVaultAddress);
        IERC20(_underlyingToken).approve(_yearnVaultAddress, type(uint256).max);
    }

    function _deposit(uint256 amount) internal override {
        IERC20(underlyingToken).transferFrom(msg.sender, address(this), amount);
        yearnVault.deposit(amount, address(this));
    }

    function _withdraw(uint256 amount) internal override returns (uint256) {
        return yearnVault.withdraw(amount, address(this), 1); // The `1` here is a placeholder for the maxLoss parameter, adjust as needed
    }

    function _yieldToUnderlying(uint256 amount) internal view override returns (uint256) {
        return yearnVault.withdrawalQueue(amount); // This is a placeholder, replace with the correct conversion method
    }

    function _underlyingToYield(uint256 amount) internal view override returns (uint256) {
        return yearnVault.pricePerShare().mul(amount).div(1e18); // Adjust for the correct decimals
    }
}
