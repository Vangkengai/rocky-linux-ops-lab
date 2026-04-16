Rocky Linux 9 云原生运维实战实验室 (Ops-Lab)
项目概述
本项目记录了在 Rocky Linux 9 环境下，从传统 Linux 运维向容器化及云原生架构演进的全过程。项目涵盖了自动化部署、集群编排及深度业务监控的完整链路。

技术栈
操作系统: Rocky Linux 9 (RHEL 兼容)
容器引擎: Docker & Docker Compose
集群编排: K3s (Lightweight Kubernetes)
监控系统: Zabbix 6.0+ (LTS)
网络插件: Traefik (Ingress) / Cloudflare WARP (Network Optimization)

核心组件说明

容器化监控底座 (`/docker-compose.yml`)
基于 Docker Compose 快速构建 Zabbix 监控环境。
解决容器环境下的 MySQL 依赖、端口冲突及 Nginx 反向代理配置。
实现了 Web 端、Server 端与数据库的解耦与稳定通信。

K3s 集群与业务编排 (`/k8s-nginx-app.yaml`)
在 Rocky Linux 上完成 K3s 集群初始化及环境变量优化。
资源编排: 实现了 Nginx 业务的 Deployment 配置，设置了合理的 Resource Limits (CPU/MEM)。
流量接入: 通过 Service 和 Ingress (Traefik) 实现业务的外部访问。

3. 自动化监控脚本 (`/scripts/check_nginx_k8s.sh`)
监控自愈逻辑: 编写自定义 Shell 脚本，通过 `kubectl top` 实时采集 Pod 指标。
关键指标: 
   `cpu`: 监测容器计算资源消耗。
   `mem`: 实时获取内存占用，防止 OOM。
   `port`: 监控 Service 端口存活状态。
集成方式: 脚本可直接作为 Zabbix 的 UserParameter，实现业务级告警自动化。

生产实战经验 (Lesson Learned)
环境隔离: 处理了 sudo 环境下 k3s 路径失效的问题，通过环境变量持久化确保了脚本的自动化运行。
性能优化: 针对外网环境优化了镜像拉取策略，并研究了使用 WARP 优化跨地域节点访问的稳定性。
故障排查: 深入定位并解决了 Nginx 502 Bad Gateway 报错，修正了 Unix Socket 与 TCP 监听地址不匹配的问题。
