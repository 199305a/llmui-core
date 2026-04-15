# 🎯 安装 LLMUI Core v0.5.0 的三种方式

LLMUI Core 提供 **3 种安装方式**，适配不同熟练度和需求场景。

---

## 🤖 方式 1：Andy（自动化）- 推荐

**适合人群**：新用户、快速安装、生产环境

### 文件
- `andy_setup.sh` - 交互式菜单
- `andy_installer.py` - 自动安装
- `andy_deploy_source.py` - 源码部署
- `andy_start_services.py` - 服务管理

### 特性
✅ **100% 自动化** - 3 条命令完成安装  
✅ **智能检测** - 自动识别 apt/dnf/yum  
✅ **错误处理** - 自动修复常见问题  
✅ **可追溯性** - 使用 SQLite 数据库记录完整历史  
✅ **交互式菜单** - 模块化选项（安装、验证、日志）  
✅ **多系统支持** - Debian、Ubuntu、Rocky、RHEL  

### 完整安装
```bash
# 方案 A：交互式菜单（推荐新手）
sudo bash andy_setup.sh
# → 选择 [1] Complete Installation

# 方案 B：命令行（适合脚本）
sudo python3 andy_installer.py      # 第 1 步：系统基础
sudo python3 andy_deploy_source.py  # 第 2 步：源码文件
sudo python3 andy_start_services.py # 第 3 步：服务
```

### 耗时
- **总计**：15-30 分钟（取决于网络）
- **人工交互**：2 分钟（用户名 + 密码）
- **其余流程**：100% 自动

### 优势
- 🚀 最快
- 🧠 最智能
- 🔒 最安全（可追溯数据库）
- 📊 结束后有详细报告
- 🛡️ 修改前自动备份

### 文档
- `README_ANDY.md` - Andy 完整文档
- `ANDY_INTERACTIVE.md` - 交互式菜单指南

---

## 📚 方式 2：交互式引导 - 适合谨慎用户

**适合人群**：希望理解每一步、用于学习、需要完全控制的人

### 文件
- `scripts/install_interactive.sh` - **分步引导安装**
- `scripts/install.sh` - 经典安装脚本
- `scripts/install_backend.py` - Python 后端安装

### 特性
✅ 每一步都有**详细说明**  
✅ 每个动作前都有**确认提示**  
✅ 可**跳过**部分步骤  
✅ **教学友好** - 非常适合学习  
✅ **灵活性高** - 可自定义安装过程  

### 引导安装
```bash
# 启动交互式助手
sudo bash scripts/install_interactive.sh

# 助手会引导你完成：
# 1. 前置条件检查
# 2. 依赖安装（含确认）
# 3. Ollama + 模型配置（含说明）
# 4. Systemd 服务配置（逐步）
# 5. Nginx 配置（带选项）
# 6. 防火墙配置（可选择）
# 7. 最终验证（带测试）
```

### 交互示例
```
┌─────────────────────────────────────────────┐
│ Step 2/7: Dependencies Installation        │
└─────────────────────────────────────────────┘

此步骤将安装：
  • Python 3.8+ and pip
  • 用于反向代理的 Nginx
  • 用于数据库的 SQLite3
  • 编译工具

是否继续？ [Y/n]: Y
是否同时安装开发工具？ [Y/n]: Y
```

### 耗时
- **总计**：20-40 分钟
- **人工交互**：10-15 分钟（选择与确认）
- **等待时间**：10-25 分钟

### 优势
- 📖 教学性强 - 你会清楚每一步在做什么
- 🎛️ 可控性强 - 每一步都可选择
- ✋ 可暂停 - 可慢慢阅读
- 📝 透明 - 无隐藏操作
- 🎓 非常适合学习 Linux/DevOps

### 适合谁？
- Linux 初学者
- 希望理解架构的管理员
- 需要自定义安装的人
- 学习/培训环境

---

## ⚙️ 方式 3：手动安装 - 适合专家

**适合人群**：有经验的 DevOps、特殊环境、追求极致定制

### 文档
- `INSTALL.md` - 完整手动安装指南

### 特性
✅ **绝对控制** - 每条命令都有文档说明  
✅ **高度定制** - 可按需调整所有内容  
✅ **深入理解** - 全面掌握系统  
✅ **灵活适配** - 面向非标准环境  

### 手动安装
请参考 `INSTALL.md` 中的 "Manual installation" 章节，内容包括：

1. **系统准备**
   ```bash
   sudo apt update && sudo apt upgrade -y
   sudo apt install python3-pip python3-venv nginx...
   ```

2. **安装 Ollama**
   ```bash
   curl -fsSL https://ollama.com/install.sh | sh
   ollama pull phi3:3.8b
   ollama pull gemma2:2b
   ollama pull granite4:micro-h
   ```

3. **用户配置**
   ```bash
   sudo useradd -r -s /bin/bash -d /opt/llmui-core -m llmui
   sudo mkdir -p /opt/llmui-core/{logs,data,backups}...
   ```

4. **Python 环境**
   ```bash
   sudo su - llmui -c "python3 -m venv venv"
   sudo su - llmui -c "venv/bin/pip install -r requirements.txt"
   ```

5. **Systemd 服务**
   - 手动创建 `.service` 文件
   - 精细化参数配置

6. **Nginx 配置**
   - 完整自定义反向代理
   - 高级 SSL 配置

7. **防火墙与安全**
   - 手动配置 UFW/firewalld
   - 自定义规则

### 耗时
- **总计**：30-60 分钟
- **经验要求**：高级 Linux 能力
- **文档规模**：20-30 页详细说明

### 优势
- 🎯 精度最高
- 🛠️ 定制空间无限
- 🔬 理解最深入
- 🗝️ 适合非标准环境
- 📚 文档最完整

### 适合谁？
- 资深 DevOps
- 关键生产环境
- 自定义架构场景
- 需对接现有基础设施的场景

---

## 📊 对比表

| 指标 | Andy（自动） | 交互式 | 手动 |
|---------|-------------|-------------|--------|
| **总耗时** | 15-30 分钟 | 20-40 分钟 | 30-60 分钟 |
| **人工交互** | 2 分钟 | 10-15 分钟 | 持续进行 |
| **所需水平** | 新手 | 中级 | 专家 |
| **学习价值** | ⭐⭐ | ⭐⭐⭐⭐⭐ | ⭐⭐⭐⭐ |
| **可定制性** | ⭐⭐ | ⭐⭐⭐ | ⭐⭐⭐⭐⭐ |
| **自动化程度** | ⭐⭐⭐⭐⭐ | ⭐⭐⭐ | ⭐ |
| **可追溯性** | ⭐⭐⭐⭐⭐ | ⭐⭐⭐ | ⭐⭐ |
| **错误处理** | ⭐⭐⭐⭐⭐ | ⭐⭐⭐ | ⭐⭐ |

---

## 🎯 如何选择？

### 你是 LLMUI Core 新手？
→ **Andy（方式 1）** - 3 次点击完成安装

### 想学习系统如何工作？
→ **交互式（方式 2）** - 分步引导

### 你是有特定需求的资深 DevOps？
→ **手动（方式 3）** - 完全控制

### 需要在多台服务器部署？
→ **Andy（方式 1）** - 自动化 + 标准化

### 学习/培训环境？
→ **交互式（方式 2）** - 教学友好且灵活

### 关键生产环境且架构特殊？
→ **手动（方式 3）** - 最大化定制能力

---

## 🔄 组合使用方式

你可以**组合**不同安装方式：

### 示例 1：用 Andy 打基础，再手动定制
```bash
# 1. 用 Andy 快速安装
sudo python3 andy_installer.py

# 2. 手动定制
sudo nano /opt/llmui-core/config.yaml
sudo systemctl restart llmui-backend
```

### 示例 2：先交互式学习，再用 Andy 复用
```bash
# 1. 首次：交互式安装以理解流程
sudo bash scripts/install_interactive.sh

# 2. 后续服务器：Andy 快速部署
sudo bash andy_setup.sh
```

---

## 📖 按方式查看文档

### Andy
- `README.md` 中的 "Installation with Andy" 章节
- `QUICKSTART.md` - 快速开始
- `README_ANDY.md` - 完整文档
- `ANDY_INTERACTIVE.md` - 菜单指南

### 交互式
- `INSTALL.md` - 步骤参考
- `scripts/install_interactive.sh` - 脚本本体（含注释）

### 手动
- `INSTALL.md` 中的 "Manual installation" 章节
- `docs/ARCHITECTURE.md` - 技术架构
- `docs/CONFIGURATION.md` - 高级配置

---

## 🆘 按方式排障

### Andy 有问题？
```bash
# 查看日志
less /tmp/andy_install.log

# 查看 SQLite 数据库
sqlite3 /tmp/andy_installation.db
SELECT * FROM commands WHERE status='failed';
```

### 交互式有问题？
```bash
# 重新执行出问题的步骤
sudo bash scripts/install_interactive.sh
# 选择跳过已成功步骤
```

### 手动方式有问题？
```bash
# 查看 INSTALL.md 的 "Troubleshooting" 章节
# 查看系统日志
sudo journalctl -xe
```

---

## ✅ 安装后验证

无论使用哪种方式，都建议执行以下验证：

```bash
# 服务是否运行？
sudo systemctl status llmui-backend llmui-proxy nginx

# HTTP 测试
curl -I http://localhost/

# API 测试
curl http://localhost:5000/api/health

# Ollama 模型检查
ollama list
```

或者使用 Andy：
```bash
sudo bash andy_setup.sh
# 选择 [5] Verify installation
```

---

## 💡 最后建议

**90% 的场景**：使用 **Andy**（方式 1）
- 安装最快
- 自动处理错误
- 完整可追溯
- 可直接用于生产

**用于学习**：使用 **交互式**（方式 2）
- 理解每个步骤
- 按需选择选项
- 非常适合培训

**专家场景**：使用 **手动**（方式 3）
- 完全控制
- 最大化定制
- 适配特殊环境

---

**Francois Chalut**  
*三种方式，一个目标：数字主权* 🇨🇦
