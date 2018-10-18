## run-scripts
this is a java scripts file

## 背景

脚本文件出现的背景是spring-boot的可执行jar方案
为解决java -jar xxx.jar这样的部署策略
特地写的shell脚本，用来在linux环境中启动、关闭服务

## 介绍

1. process.sh  

核心脚本，启动、关闭、状态监测、help实现都写在这里

2. pass.sh

针对linux环境写的脚本

3. pass.bat

针对window环境写的脚本

## 使用

option: start|stop|status|help

例子： 

./pass.sh start
./pass.sh status
./pass.sh help
