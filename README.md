# MiniMax Usage

查询 MiniMax 模型 API 使用量的 Claude Code Skill。

## 功能

- 查询 MiniMax 模型剩余额度和使用量
- 支持从配置文件读取 API Key 或手动输入

## 安装

### 方法一：全局安装（推荐）

```bash
# 克隆仓库
git clone https://github.com/Cygra/minimax-usage.git ~/.claude/skills/minimax-usage
```

### 方法二：项目内安装

```bash
# 在项目目录下
git clone https://github.com/Cygra/minimax-usage.git .claude/skills/minimax-usage
```

## 使用方法

### 方式一：配置文件中设置 Key

如果你已经在 `~/.claude/settings.json` 中设置了 `ANTHROPIC_AUTH_TOKEN` 为你的 MiniMax API Key，可以直接使用：

```bash
/minimax-usage status
```

### 方式二：通过 setup 命令输入 Key

首次使用时运行：

```bash
/minimax-usage setup
```

然后按照提示输入你的 MiniMax API Key。

### 查看用量

```bash
/minimax-usage status
```

输出示例：

```
============================================================
MiniMax API 使用量查询
============================================================

模型: MiniMax-M2
  剩余时间: 13小时48分钟
  当前周期: [===========---------] 530/600
  周期时间: 2025-11-12 22:00 - 2025-11-13 02:00

模型: MiniMax-M2.1
  剩余时间: 13小时48分钟
  当前周期: [===========---------] 530/600
  周期时间: 2025-11-12 22:00 - 2025-11-13 02:00

============================================================
```

## API Key 获取

1. 登录 [MiniMax 开放平台](https://www.minimaxi.com/)
2. 进入 API Keys 页面
3. 创建或复制你的 API Key

## 注意事项

- API Key 必须保持机密，切勿泄露
- 当前实现不会存储你的 API Key，每次查询时需要重新输入
- 请确保 API Key 格式正确（以 `sk-cp-` 开头）

## 许可证

MIT License
