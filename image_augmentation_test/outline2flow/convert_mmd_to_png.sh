#!/bin/bash

# 用法提示
if [ $# -ne 2 ]; then
    echo "用法: $0 输入文件夹 输出文件夹"
    exit 1
fi

# 输入输出目录
INPUT_DIR="$1"
OUTPUT_DIR="$2"

# 确保输出目录存在
mkdir -p "$OUTPUT_DIR"

# 固定的 mmdc 命令
MMDC_COMMAND="mmdc"

# 检查 mmdc 是否存在
if ! command -v "$MMDC_COMMAND" &> /dev/null; then
    echo "找不到 mmdc 命令，尝试添加 nvm 的路径到 PATH..."
    export PATH="$HOME/.nvm/versions/node/v20.19.1/bin:$PATH"

    # 再次检查
    if ! command -v "$MMDC_COMMAND" &> /dev/null; then
        echo "错误：仍然找不到 mmdc 命令。请确认 mmdc 安装正确。"
        exit 1
    fi
fi

# 遍历输入目录下的所有 .mmd 文件
for mmd_file in "$INPUT_DIR"/*.mmd; do
    # 获取不带扩展名的文件名
    filename=$(basename "$mmd_file" .mmd)
    output_file="$OUTPUT_DIR/${filename}.png"

    echo "正在处理: $mmd_file -> $output_file"

    "$MMDC_COMMAND" -i "$mmd_file" -o "$output_file"
done

echo "全部完成！"
