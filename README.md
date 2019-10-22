# run-scripts

run-scripts is a script-run file project.it is build for spring-boot project(*.jar).

eg. ./tool.sh start  
eg. ./tool.sh stop

## 背景

脚本文件出现的背景是spring-boot框架的可执行jar部署方案，为解决java -jar xxx.jar这样的部署策略，特地写的shell脚本，用来在linux环境中启动、关闭服务。

## 介绍

1. proc.sh  

核心脚本，启动、关闭、状态监测、help实现都写在这里

2. tool.sh

针对linux环境写的脚本

3. tool.bat

针对window环境写的脚本

# 使用

## 格式

`sh tool.sh option`

option: start|stop|status|help

例子： 

./tool.sh start
./tool.sh status
./tool.sh help

## 部署目录格式

> 以 hello-1.0.jar 为例（可执行jar文件）

    --  hello-deploy/  
    --  bin/
    --  --  proc.sh  
    --  hello-1.0.jar  
    --  tool.sh
    --  tool.bat
    --  run.log
    --  run.pid
    --  README.md

* hello-deploy ：为最父级文件夹，所有文件都在这里面。  
* hello-1.0.jar ：为生成的可执行jar包。
* run.log ：自动生成的console级日志，每次重启清零。
* run.pid ：自动生成的process id(linux系统级)，**不能手动修改**。 