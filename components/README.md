## architecture workflow
- l1_hardhat( mock / testnet)
- deployer
- dtl
- l2_geth
- gas-oracle
- batch_submitter
- integration_test

## run module
rebuild image, run 

`BUILD=true PathToScript/ComponentScript.sh Params` 

restart container, run

`PathToScript/ComponentScript.sh PathToProject`

## run module formula with BUILD flag

```
BUILD=true ./1_l1mock.sh PROJECT_PATH
BUILD=true ./2_deployer.sh PROJECT_PATH L1_CONTRACTS_OWNER_KEY L1_RPC_URL
BUILD=true ./3_dtl.sh PROJECT_PATH
BUILD=true ./4_l2geth.sh PROJECT_PATH
BUILD=true ./5_gasoracle.sh PROJECT_PATH
BUILD=true ./6_batch_submitter.sh PROJECT_PATH
BUILD=true ./7_integration_test.sh PROJECT_PATH
```

## restart module formula without BUILD flag
```
./1_l1mock.sh PROJECT_PATH
./2_deployer.sh PROJECT_PATH L1_CONTRACTS_OWNER_KEY L1_NETWORK(local/georli)
./3_dtl.sh PROJECT_PATH
./4_l2geth.sh PROJECT_PATH
./5_gasoracle.sh PROJECT_PATH
./6_batch_submitter.sh PROJECT_PATH
./7_integration_test.sh PROJECT_PATH
```

## run module example

```
BUILD=true ./1_l1mock.sh ~/workspace/projects/bitnetwork/
BUILD=true ./2_deployer.sh ~/workspace/projects/bitnetwork/ local ac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80 0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266
BUILD=true ./3_dtl.sh ~/workspace/projects/bitnetwork/
BUILD=true ./4_l2geth.sh ~/workspace/projects/bitnetwork/
BUILD=true ./5_gasoracle.sh ~/workspace/projects/bitnetwork/
BUILD=true ./6_batch_submitter.sh ~/workspace/projects/bitnetwork/
BUILD=true ./7_integration_test.sh ~/workspace/projects/bitnetwork/
```
