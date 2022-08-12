## architecture workflow
- l1_hardhat( mock / testnet)
- deployer
- dtl
- l2_geth
- gas-oracle
- batch_submitter
- integration_test

## run script
run 
`BUILD=true PathToScript/1_l1mock.sh Params` params inclouding: PathToProject, OwnerKey, etc...
if you need to rebuild image

run
`PathToScript/1_l1mock.sh PathToProject`
to restart container

## run module details, additional modules append here
```

```


# tips:
If meet the `deploy-config` error , run:
```shell
yarn clean
yarn install
yarn build
```
