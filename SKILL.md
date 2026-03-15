---
name: minimax-usage
description: 查询 MiniMax 模型 API 使用量和剩余额度
argument-hint: [setup|status]
user-invocable: true
allowed-tools: Bash, Read
---

# MiniMax 用量查询

这个 skill 用于查询 MiniMax 模型的 API 使用量和剩余额度。

## 功能

- `/minimax-usage setup` - 配置 MiniMax API Key
- `/minimax-usage status` - 查询当前用量和剩余额度

## 实现细节

### 直接调用脚本

脚本路径：`~/.claude/skills/minimax-usage/scripts/query.sh`

使用方法：
```bash
~/.claude/skills/minimax-usage/scripts/query.sh <API_KEY>
```

### Key 获取

1. 首先检查 `~/.claude/settings.json` 中的 `ANTHROPIC_AUTH_TOKEN` 字段
2. 如果没有，引导用户通过 setup 命令输入

### 使用示例

1. 首次使用需要先配置 API Key：
   ```
   /minimax-usage setup
   ```
   然后输入你的 MiniMax API Key（格式：sk-cp-xxx）

2. 查询用量：
   ```
   /minimax-usage status
   ```

## 注意事项

- 用户的 API Key 必须保持机密，绝不能泄露到代码中
- Key 仅在执行 curl 请求时使用，不存储到任何文件
- 如果 API 返回错误，检查 key 是否正确或是否过期
