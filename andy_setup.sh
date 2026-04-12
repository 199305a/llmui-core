#!/bin/bash
# ==============================================================================
# Andy Setup - LLMUI Core 交互式安装 V 0.5.0
# ==============================================================================
clear
cat << "EOF"
╔══════════════════════════════════════════════════════════════════════════╗
║                                                                          ║
║ █████╗ ███╗   ██╗██████╗ ██╗   ██╗ ██╗   ██╗ ██╗   ██████╗ ███████╗      ║
║ ██╔══██╗████╗  ██║██╔══██╗╚██╗ ██╔╝ ██║   ██║ ██║   ██╔═══██╗██╔════╝      ║
║ ███████║██╔██╗ ██║██║  ██║ ╚████╔╝ ██║   ██║ ██║   ██║   ██║███████╗      ║
║ ██╔══██║██║╚██╗██║██║  ██║  ╚██╔╝  ╚██╗ ██╔╝ ██║   ██║   ██║╚════██║      ║
║ ██║  ██║██║ ╚████║██████╔╝   ██║    ╚████╔╝  ╚██████╔╝███████║      ║
║ ╚═╝  ╚═╝╚═╝  ╚═══╝╚═════╝    ╚═╝     ╚═══╝    ╚═════╝ ╚══════╝       ║
║                                                                          ║
║               自动化 DevOps 助手 v0.5.0                                   ║
║               LLMUI Core 自动化安装                                       ║
║                                                                          ║
║                       Francois Chalut                                   ║
║                       数字主权                                            ║
║                                                                          ║
╚══════════════════════════════════════════════════════════════════════════╝
EOF
echo ""
echo "欢迎使用 LLMUI Core 交互式安装！"
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
# 检查 root
if [ "$EUID" -ne 0 ]; then
    echo "❌ 本脚本必须以 root 身份运行"
    echo " 请使用: sudo bash andy_setup.sh"
    exit 1
fi
echo "✓ 已确认 root 权限"
echo ""
# 主菜单
while true; do
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo " 主菜单"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo ""
    echo " [1] 完整安装（推荐）"
    echo " [2] 仅基础安装"
    echo " [3] 部署源代码文件"
    echo " [4] 启动服务"
    echo " [5] 检查安装"
    echo " [6] 查看日志"
    echo " [7] 阅读文档"
    echo " [Q] 退出"
    echo ""
    read -p "请选择: " choice
    echo ""
   
    case $choice in
        1)
            echo "🚀 LLMUI Core 完整安装"
            echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
            echo ""
            echo "本安装包含："
            echo " • 更新操作系统"
            echo " • 安装 Ollama + 3 个 LLM 模型"
            echo " • 完整系统配置"
            echo " • 部署源代码"
            echo " • 启动服务"
            echo ""
            read -p "是否继续？(o/N): " confirm
            if [[ $confirm =~ ^[Oo]$ ]]; then
                echo ""
                echo "═══ 第 1/3 步：基础安装 ═══"
                python3 andy_installer.py
                INSTALL_STATUS=$?

                if [ $INSTALL_STATUS -ne 0 ]; then
                    echo ""
                    echo "❌ 第 1 步失败（andy_installer.py）"
                    echo "   请查看日志: /tmp/andy_install.log"
                    read -p "按 Enter 返回菜单..."
                    continue
                fi

                echo ""
                echo "═══ 第 2/3 步：部署源码 ═══"
                python3 andy_deploy_source.py
                if [ $? -ne 0 ]; then
                    echo "❌ 第 2 步失败"
                    read -p "按 Enter 继续..."
                    continue
                fi

                echo ""
                echo "═══ 第 3/3 步：启动服务 ═══"
                python3 andy_start_services.py

                echo ""
                echo "✓ 完整安装已成功结束！"
                echo "  请通过服务器 IP 访问 Web 界面"
                echo ""
                read -p "按 Enter 继续..."
            fi
            ;;
           
        2)
            echo "🔧 基础安装"
            echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
            python3 andy_installer.py
            echo ""
            read -p "按 Enter 继续..."
            ;;
           
        3)
            echo "📦 部署源代码文件"
            echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
            python3 andy_deploy_source.py
            echo ""
            read -p "按 Enter 继续..."
            ;;
           
        4)
            echo "▶️ 启动服务"
            echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
            python3 andy_start_services.py
            echo ""
            read -p "按 Enter 继续..."
            ;;
           
        5)
            echo "🔍 检查安装情况"
            echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
            echo ""
           
            echo "systemd 服务:"
            systemctl is-active llmui-backend && echo " ✓ llmui-backend: 运行中" || echo " ✗ llmui-backend: 未运行"
            systemctl is-active llmui-proxy && echo " ✓ llmui-proxy: 运行中" || echo " ✗ llmui-proxy: 未运行"
            systemctl is-active nginx && echo " ✓ nginx: 运行中" || echo " ✗ nginx: 未运行"
           
            echo ""
            echo "HTTP 测试:"
            if curl -I http://localhost/ 2>/dev/null | head -n 1; then
                echo " ✓ 界面可访问"
            else
                echo " ✗ 界面不可访问"
            fi
           
            echo ""
            echo "服务器 IP 地址:"
            IP=$(hostname -I | awk '{print $1}')
            echo " → http://$IP/"
           
            echo ""
            read -p "按 Enter 继续..."
            ;;
           
        6)
            echo "📋 可用日志"
            echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
            echo ""
            echo " [1] Andy 安装日志"
            echo " [2] 后端日志（实时）"
            echo " [3] 代理日志（实时）"
            echo " [4] Nginx 访问日志"
            echo " [5] Nginx 错误日志"
            echo " [6] 返回"
            echo ""
            read -p "请选择: " log_choice
           
            case $log_choice in
                1) less /tmp/andy_install.log 2>/dev/null || echo "未找到日志" ;;
                2) journalctl -u llmui-backend -f ;;
                3) journalctl -u llmui-proxy -f ;;
                4) tail -f /var/log/nginx/llmui-access.log 2>/dev/null || echo "日志不存在" ;;
                5) tail -f /var/log/nginx/llmui-error.log 2>/dev/null || echo "日志不存在" ;;
                6|*) continue 2 ;;
            esac
            ;;
           
        7)
            echo "📖 文档"
            echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
            if [ -f README_ANDY.md ]; then
                less README_ANDY.md
            else
                echo "当前目录未找到 README_ANDY.md"
            fi
            read -p "按 Enter 继续..."
            ;;
           
        [Qq])
            echo "👋 感谢使用 Andy！"
            echo ""
            echo "重要路径:"
            echo " • 日志: /tmp/andy_install.log"
            echo " • 数据库: /tmp/andy_installation.db"
            echo " • 安装目录: /opt/llmui-core/"
            echo ""
            exit 0
            ;;
           
        *)
            echo "❌ 无效选择"
            echo ""
            ;;
    esac
   
    clear
    cat << "EOF"
╔══════════════════════════════════════════════════════════════════════════╗
║ Andy v0.5.0 - DevOps 助手                                                ║
╚══════════════════════════════════════════════════════════════════════════╝
EOF
    echo ""
done
