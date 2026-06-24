CONTRACT_ADDRESS = 0xF37257424E1bf2047E6639323841D6456aaA3230
PRIVATE_KEY = 850f116d3c8f323eb7d0b868c83d18cb9fdd7a878c3e7f1a11f67d994caf1123
SEPOLIA_RPC_URL = https://eth-sepolia.g.alchemy.com/v2/uP8ZreJtln_XGvuxTX14F
API_KEY_ETHERSCAN = TRZ9F23392ANNCDYGWTSAB3IU5A2PIK6QP

AUX = --rpc-url $(SEPOLIA_RPC_URL) --private-key $(PRIVATE_KEY) --broadcast 
AUX_ETHERSCAN = --rpc-url $(SEPOLIA_RPC_URL) --private-key $(PRIVATE_KEY) --broadcast --verify --etherscan-api-key $(API_KEY_ETHERSCAN) 

deploy: 
	forge script script/DeployMoodNFT.s.sol:DeployMoodNFT $(AUX_ETHERSCAN)
mint:
	forge script script/Interactions.s.sol:MintMoodNFT $(AUX)
flip:
	forge script script/Interactions.s.sol:FlipMoodNFT $(AUX)