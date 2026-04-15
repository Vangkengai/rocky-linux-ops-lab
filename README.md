Rocky Linux 运维实战实验室

项目概述
本项目记录了我在 Rocky Linux 9 环境下从传统运维向云原生架构演进的实战过程。

技术栈
OS: Rocky Linux 9
Container: Docker & Docker Compose
Orchestration: K8s (k3s)
Monitoring: Zabbix 6.0+

核心成果
Zabbix 容器化部署：解决代理环境下的镜像拉取及端口冲突问题。
k3s 集群搭建：成功实现单机版 K8s 集群初始化，节点状态 Ready。

排障记录 (Lesson Learned)
Issue: sudo 环境下找不到 k3s 命令。
Solution: 定位到 `/usr/local/bin` 路径，通过绝对路径及环境变量配置解决。
