# Rocky Linux 9 云原生运维实战实验室 (Ops-Lab)

##  项目概述
本项目记录了在 Rocky Linux 9 环境下，从传统 Linux 运维向容器化及云原生架构演进的全过程。项目涵盖了自动化部署、集群编排及深度业务监控的完整链路。

##  技术栈
* **操作系统**: Rocky Linux 9 (RHEL 兼容)
* **容器引擎**: Docker & Docker Compose
* **集群编排**: K3s (Lightweight Kubernetes)
* **监控系统**: Zabbix 6.0+ (LTS)
* **网络插件**: Traefik (Ingress) / Cloudflare WARP (Network Optimization)

##  核心组件说明

### 容器化监控底座
基于 Docker Compose 快速构建 Zabbix 监控环境。解决容器环境下的 MySQL 依赖、端口冲突及 Nginx 反向代理配置。实现了 Web 端、Server 端与数据库的解耦与稳定通信。

### K3s 集群与业务编排
在 Rocky Linux 上完成 K3s 集群初始化及环境变量优化。资源编排：实现了 Nginx 业务的 Deployment 配置，设置了合理的 Resource Limits (CPU/MEM)。流量接入：通过 Service 和 Ingress (Traefik) 实现业务的外部访问。

### 自动化监控脚本
监控自愈逻辑：编写自定义 Shell 脚本，通过 `kubectl top` 实时采集 Pod 指标。
* **关键指标**:
  * `cpu`: 监测容器计算资源消耗。
  * `mem`: 实时获取内存占用，防止 OOM。
  * `port`: 监控 Service 端口存活状态。
* **集成方式**: 脚本可直接作为 Zabbix 的 UserParameter，实现业务级告警自动化。

## 快速开始

### 1. 一键初始化 K3s 集群环境
```bash
chmod +x scripts/install_k3s.sh
bash scripts/install_k3s.sh```
2. 启动容器化监控底座 (Zabbix)
```Bash
cp .env_db_password.example .env_db_password
docker-compose up -d```
3. 部署 Nginx 业务服务到 K3s
```Bash
kubectl apply -f k8s-nginx-app.yaml
