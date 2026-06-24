// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract ManualToken {
    mapping(address => uint256) private _balances;
    uint256 public constant TOTAL_SUPPLY = 1_000_000 ether;
    function totalSupply() public pure returns (uint256) {
        return TOTAL_SUPPLY;
    }
    function name() public pure returns (string memory) {
        return "Manual Token";
    }
    function decimals() public pure returns (uint8) {
        return 18;
    }
    function symbol() public pure returns (string memory) {
        return "MTK";
    }
    function balanceOf(address account) public view returns (uint256) {
        return _balances[account];
    }
    function transfer(address recipient, uint256 amount) public returns (bool) {
        uint256 senderBalance = _balances[msg.sender];
        require(
            senderBalance >= amount,
            "ERC20: transfer amount exceeds balance"
        );
        _balances[msg.sender] = senderBalance - amount;
        _balances[recipient] += amount;
        return true;
    }
}
/* 
link al contrato: https://sepolia.etherscan.io/address/0x788fdA44087d9b36f9247895546CFa70A41A9327


foundry-erc20-f25 git:(main) ✗ source .env && forge script script/DeployOurToken.sol --rpc-url $SEPOLIA_RPC_URL --broadcast --private-key $PRIVATE_KEY
[⠊] Compiling...
[⠒] Compiling 17 files with Solc 0.8.33
[⠑] Solc 0.8.33 finished in 554.00ms
Compiler run successful!
Script ran successfully.

== Return ==
0: contract OurToken 0x788fdA44087d9b36f9247895546CFa70A41A9327

## Setting up 1 EVM.

==========================

Chain 11155111

Estimated gas price: 2.227736544 gwei

Estimated total gas used for script: 1237137

Estimated amount required: 0.002756015304834528 ETH

==========================

##### sepolia
✅  [Success] Hash: 0x353d7cfc49734acf7d9ccfaed0c7c4bc46c201f2521728327b471877b9c8db3d
Contract Address: 0x788fdA44087d9b36f9247895546CFa70A41A9327
Block: 10888811
Paid: 0.001045855596897608 ETH (951644 gas * 1.098998782 gwei)

✅ Sequence #1 on sepolia | Total Paid: 0.001045855596897608 ETH (951644 gas * avg 1.098998782 gwei)
                                                                                                                      

==========================

ONCHAIN EXECUTION COMPLETE & SUCCESSFUL.

Transactions saved to: /Users/solvd/blockchain/foundry-erc20-f25/broadcast/DeployOurToken.sol/11155111/run-latest.json

Sensitive values saved to: /Users/solvd/blockchain/foundry-erc20-f25/cache/DeployOurToken.sol/11155111/run-latest.json

➜  foundry-erc20-f25 git:(main) ✗  */
