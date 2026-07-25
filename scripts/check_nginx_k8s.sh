#!/bin/bash
# Zabbix 监控 K3s Nginx 脚本

APP_LABEL="app=nginx"

case "$1" in
    cpu)
        # 获取 CPU 使用率 (单位: m)
        val=$(sudo k3s kubectl top pod -l $APP_LABEL --no-headers 2>/dev/null | awk '{print $2}' | sed 's/m//')
        echo "${val:-0}"
        ;;
    mem)
        # 获取内存使用量 (单位: Mi)
        val=$(sudo k3s kubectl top pod -l $APP_LABEL --no-headers 2>/dev/null | awk '{print $3}' | sed 's/Mi//')
        echo "${val:-0}"
        ;;
        
    port)
        # 检查 Service 端口状态 (1正常, 0异常)
        nc -z nginx-service 80 >/dev/null 2>&1 && echo 1 || echo 0
        ;;
    *)
        echo 0
        ;;
esac
