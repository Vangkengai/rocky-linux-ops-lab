#!/bin/bash
set -e

# 1. 环境清理 (可选，防止旧残留干扰)
# [ -f /usr/local/bin/k3s-uninstall.sh ] && /usr/local/bin/k3s-uninstall.sh

# 2. 安装 k3s (跳过内置镜像，通过官方脚本安装)
# 针对国内网络环境，建议提前配置代理或使用国内镜像源
curl -sfL https://get.k3s.io | sh -

# 3. 环境变量与路径修复 (解决 sudo 找不到命令的问题)
export PATH=$PATH:/usr/local/bin

# 永久修复 (写入 bashrc)
if ! grep -q "/usr/local/bin" ~/.bashrc 2>/dev/null; then
    echo 'export PATH=$PATH:/usr/local/bin' >> ~/.bashrc
fi

# 4. 验证集群状态
echo "正在检查集群节点状态..."
sudo /usr/local/bin/k3s kubectl get nodes
