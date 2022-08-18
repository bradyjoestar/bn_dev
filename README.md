# dev 环境搭建

### 项目文件
- quick_build_and_start.sh： 编译镜像启动服务
- quick_restart.sh: 快速重启容器
- quick_stop.sh: 快速关闭所有容器

### 容器单独启动实例
BUILD flag 指定重新编译镜像，如需重启容器则去掉改环境变量即可
```shell
# 启动l1 hardhat 容器
BUILD=true ./1_l1mock.sh PROJECT_PATH

# 编译l2geth容器，并启动
BUILD=true ./2_deployer.sh PROJECT_PATH L1_CONTRACTS_OWNER_KEY L1_RPC_URL

# 编译deployer，并启动
BUILD=true ./3_dtl.sh PROJECT_PATH

# 编译dtl，并启动
BUILD=true ./4_l2geth.sh PROJECT_PATH

# 编译gasoracle,并启动
BUILD=true ./5_gasoracle.sh PROJECT_PATH

# 编译batch_submitter，并启动
BUILD=true ./6_batch_submitter.sh PROJECT_PATH

# 编译integration_test,并启动
BUILD=true ./7_integration_test.sh PROJECT_PATH
```