#!/bin/bash
# macOS 双击运行：建虚拟环境 → 装依赖 → 启动网页端 → 自动打开浏览器
# 其他系统用：python web/app.py（需要先 export API_KEY=...）
cd "$(dirname "$0")/.." || exit 1

if [ ! -d .venv ]; then
  echo "第一次运行：创建虚拟环境 .venv ..."
  python3 -m venv .venv || { echo "需要 Python 3.10+，请先安装"; read -n 1; exit 1; }
fi
source .venv/bin/activate
pip install -q -r requirements.txt || { echo "安装依赖失败"; read -n 1; exit 1; }

if [ -z "$API_KEY" ]; then
  echo
  echo "粘贴你的模型 API Key 后回车（输入时不显示）。"
  echo "直接回车 = 演示模式（假模型，不需要 Key）。"
  read -r -s API_KEY
  echo
fi

# Agent 只能动这个目录，默认放在家目录下，不碰仓库本身
export NAMI_WORKSPACE="${NAMI_WORKSPACE:-$HOME/agent-workspace}"
mkdir -p "$NAMI_WORKSPACE"
echo "工作区：$NAMI_WORKSPACE"

(sleep 2; open http://localhost:8765) &
if [ -z "$API_KEY" ]; then
  python web/app.py --demo
else
  export API_KEY
  python web/app.py
fi
