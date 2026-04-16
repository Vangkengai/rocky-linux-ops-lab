#!/bin/bash
# Zabbix 监控 K3s Nginx 脚本

APP_NAME="nginx-app"

case $1 in
  cpu)
    # 获取 CPU 使用率
    sudo k3s kubectl top pod -l app=nginx --no-headers | awk '{print $2}' | sed 's/m//'
    ;;
  mem)
    # 获取内存使用量
    sudo k3s kubectl top pod -l app=nginx --no-headers | awk '{print $3}' | sed 's/Mi//'
    ;;
  port)
    # 检查 Service 端口状态 (1正常, 0异常)
    nc -z nginx-service 80 && echo 1 || echo 0
    ;;
esac
