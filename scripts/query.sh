#!/bin/bash

# MiniMax 用量查询脚本

API_KEY="$1"

if [ -z "$API_KEY" ]; then
    echo "Error: API key is required"
    echo "Usage: $0 <API_KEY>"
    exit 1
fi

response=$(curl -s --location 'https://www.minimaxi.com/v1/api/openplatform/coding_plan/remains' \
    --header "Authorization: Bearer $API_KEY" \
    --header 'Content-Type: application/json')

# 检查返回状态
status_code=$(echo "$response" | python3 -c "import sys, json; print(json.load(sys.stdin).get('base_resp', {}).get('status_code', -1))" 2>/dev/null)

if [ "$status_code" != "0" ]; then
    status_msg=$(echo "$response" | python3 -c "import sys, json; print(json.load(sys.stdin).get('base_resp', {}).get('status_msg', 'Unknown error'))" 2>/dev/null)
    echo "Error: $status_msg"
    exit 1
fi

# 格式化输出
echo "$response" | python3 -c "
import sys, json
from datetime import datetime

def format_duration(ms):
    '''将毫秒转换为 X小时X分 格式'''
    total_minutes = ms // 60000
    hours = total_minutes // 60
    minutes = total_minutes % 60
    if hours > 0:
        return f'{hours}小时{minutes}分钟'
    else:
        return f'{minutes}分钟'

def format_progress(remaining, total, width=20):
    '''生成进度条 [======------]'''
    if total == 0:
        return '[无可用额度]'
    used = total - remaining
    ratio = used / total
    filled = int(ratio * width)
    empty = width - filled
    return '[' + '=' * filled + '-' * empty + f'] {remaining}/{total}'

data = json.load(sys.stdin)
models = data.get('model_remains', [])

print('=' * 60)
print('MiniMax API 使用量查询')
print('=' * 60)

if not models:
    print('暂无用量数据')
    sys.exit(0)

for model in models:
    name = model.get('model_name', 'Unknown')
    remains_ms = model.get('remains_time', 0)
    total = model.get('current_interval_total_count', 0)
    remaining = model.get('current_interval_usage_count', 0)
    start = model.get('start_time', 0)
    end = model.get('end_time', 0)

    # 格式化时间
    remains_str = format_duration(remains_ms)
    start_str = datetime.fromtimestamp(start/1000).strftime('%Y-%m-%d %H:%M') if start else 'N/A'
    end_str = datetime.fromtimestamp(end/1000).strftime('%Y-%m-%d %H:%M') if end else 'N/A'

    print('')
    print(f'模型: {name}')
    print(f'  剩余时间: {remains_str}')
    print(f'  当前周期: {format_progress(remaining, total)}')
    print(f'  周期时间: {start_str} - {end_str}')

print('')
print('=' * 60)
"
