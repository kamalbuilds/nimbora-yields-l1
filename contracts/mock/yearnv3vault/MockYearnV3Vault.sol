// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "../interfaces/IVault.sol";

contract MockYearnV3Vault is IVault {
    mapping(address => uint256) private _balances;

    // Simplified deposit: 1:1 ratio for assets to shares
    function deposit(uint256 assets, address receiver) external override returns (uint256 shares) {
        _balances[receiver] += assets;
        return assets;
    }

    // Simplified withdraw: 1:1 ratio for shares to assets
    function withdraw(uint256 assets, address receiver, address owner, uint256 maxLoss) external override returns (uint256 shares) {
        require(_balances[owner] >= assets, "Insufficient balance");
        _balances[owner] -= assets;
        payable(receiver).transfer(assets);
        return assets;
    }

    // Mock implementations for interface compliance
    function totalAssets() external view override returns (uint256) {
        
    }

    function convertToShares(uint256 assets) external pure override returns (uint256 shares) {
        
    }

    function convertToAssets(uint256 shares) external pure override returns (uint256 assets) {
        
    }

    function maxDeposit(address) external pure override returns (uint256) {
        
    }

    function maxMint(address) external pure override returns (uint256) {
        
    }

    function maxWithdraw(address owner) external view override returns (uint256) {
        return _balances[owner];
    }

    function maxRedeem(address owner) external view override returns (uint256) {
        
    }

    function previewDeposit(uint256 assets) external pure override returns (uint256) {
        
    }

    function previewMint(uint256 shares) external pure override returns (uint256) {
        
    }

    function previewWithdraw(uint256 assets) external pure override returns (uint256) {
        
    }

    function previewRedeem(uint256 shares) external pure override returns (uint256) {
        
    }

}
