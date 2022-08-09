# dev 环境搭建

### 项目文件
- start_by_makeup.sh： 通过默认的官方 docker-compose 配置拉起服务
- DepositDemo: 从L1向L2质押一定eth 测试案例，更多测试见optimism/integration-test
- SplitDemo: 一个容器一个容器启动op集群，快速掌握背后细节

### 执行顺序

##### docker-compose demo
```shell

# 下载项目，目前为ethereum-optimism,后面会切换为bitnetwork
source download_project.sh 

# 启动docker-compose
source start_bycompose.sh
```

docker-compose会自动拉起`integration-test`容器，该容器会将项目下所有测试用例运行一次。

当集群完全启动后，可以运行一个Deposit例子
```shell
cd DepositDemo
yarn
yarn script
```

### 容器单独启动实例
相应的代码在SplitDemo中，其中`docker`文件夹下是单独的Dockerfile文件，envs是启动所需要的初始环境变量。
```shell
# 下载项目
source 0_get_project.sh

# 启动l1 hardhat 容器
source 1_l1mock.sh

# 编译l2geth容器，并启动
source 2_l2geth.sh

# 编译deployer，并启动
source 3_deployer.sh

# 编译dtl，并启动
source 4_dtl.sh

# 编译gasoracle,并启动
source 5_gasoracle.sh

# 编译batch_submitter，并启动
source 6_batch_submitter.sh

# 编译integration_test,并启动
source 7_integration_test.sh

```


当容器全部拉起后，可以运行一个Deposit例子
```shell
cd DepositDemo
yarn
yarn script
```
