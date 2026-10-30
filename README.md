# NamiAgent

**从零手写 Agent：零基础入门 AI Agent 教程**

Agent 没有什么神秘的，核心就是一个 while 循环：调模型、执行工具、把结果写回上下文，再调模型。

这个仓库从十几行的最小循环开始，一课加一个能力：工具、权限、上下文管理、Skills、MCP、子 Agent、计划、记忆。最后拆解 Claude Code、Codex 等主流 Agent 是怎么做的。

这是我自己一步步学习、动手实践后整理出来的。先学 [NamiGPT](https://github.com/aa1143/NamiGPT) 搞懂模型本身，再学 NamiAgent 搞懂模型外面那一圈。

<p align="center">
  <img src="assets/agent-loop.gif" width="860" alt="逐格播放 Agent Loop：左边是代码跑到哪一行，右边是此刻的上下文">
  <br>
  <sub>Agent Loop 逐格播放：左边是代码执行到哪一行，右边是此刻的上下文。完整图解见 <a href="https://namiai.tech/matrix/agent/">Agent 是怎么工作的</a></sub>
</p>

<!-- TODO：网页端做好后，在这里加第二张 GIF（对话 + 上下文面板 + 思考过程） -->

## 特点

- **每课一个可运行的快照**：`lesson-01` 到 `lesson-11`，每个目录都是学完这一课时的完整代码，可以直接运行，也可以对比相邻两课的 diff
- **不绑定厂商**：使用 OpenAI 兼容接口，默认用 DeepSeek，换模型只需改两个环境变量
- **测试不花钱**：第 3 课起每课都有测试，用假模型跑，不需要 API Key
- **本地网页端**（开发中）：实时显示上下文怎么一圈圈变长，展示模型的思考过程和每一步工具调用

## 课程目录

### 第一部分：手写核心

| 课 | 主题 | 这一课新增 |
|---|---|---|
| 01 | 最小循环 | `agent.py`：三个工具 + 一个 while 循环 |
| 02 | 工具系统 | `tools.py`：注册表、统一执行器 |
| 03 | 权限 | `permissions.py`：硬规则 → 风险分级 → 人工确认 |
| 04 | 上下文管理 | `context.py`：截断 → 清理 → 摘要，会话持久化 |
| 05 | Skills | `skills.py`：AGENTS.md 常驻，技能按需加载 |
| 06 | 接入聊天软件 | `telegram.py`、`bot.py`：常驻、聊天确认、白名单 |
| 07 | 定时任务与心跳 | `scheduler.py`：无人值守的预授权、心跳 |

### 第二部分：补上主流能力

| 课 | 主题 | 这一课新增 |
|---|---|---|
| 08 | MCP | `mcp_client.py`：stdio MCP 客户端 |
| 09 | 子 Agent 与多 Agent | `subagent.py`：独立上下文，并行只读 |
| 10 | 计划 | `planning.py`：待办清单、由代码强制只读的计划模式 |
| 11 | 记忆 | `memory.py`：长期记忆（每条确认）、会话检索 |

### 第三部分：拆解主流 Agent（只有文章，没有新代码）

12 Claude Code · 13 Codex · 14 Pi · 15 Grok Bot · 16 DeepSeek Harness · 17 OpenClaw 与 Hermes · 18 总对照表

> 第三部分写的是截至 2026 年 10 月的情况，这些产品更新很快，细节以各自官方文档为准。

每一课的文章原稿在 [`docs/`](docs/) 目录，网站版：[namiai.tech/agent](https://namiai.tech/agent/)

## 快速开始

需要 Python 3.9+。

```bash
git clone https://github.com/aa1143/NamiAgent.git
cd NamiAgent
pip install openai pytest

export API_KEY=你的模型密钥
# 默认用 DeepSeek；换其他 OpenAI 兼容模型：
# export BASE_URL=https://...   MODEL=模型名

export NAMI_WORKSPACE=~/agent-workspace   # 第 3 课起，Agent 只能操作这个目录
mkdir -p $NAMI_WORKSPACE

cd lesson-05 && python agent.py
```

跑测试（不需要 API Key）：

```bash
cd lesson-11 && pytest -q
```

## 环境变量

| 变量 | 作用 | 默认值 |
|---|---|---|
| `API_KEY` | 模型密钥 | 必填 |
| `BASE_URL` | OpenAI 兼容接口地址 | `https://api.deepseek.com` |
| `MODEL` | 模型名 | `deepseek-chat` |
| `NAMI_WORKSPACE` | Agent 的工作区（第 3 课起） | 启动时所在的目录 |
| `NAMI_STATE_DIR` | 会话记录、定时任务等状态 | `~/.nami-agent` |

第 6 课起的 `bot.py` 还需要 `TG_BOT_TOKEN` 和 `TG_ALLOWED_USERS`。第 8 课起的 MCP 配置放在 `~/.nami-agent/mcp.json`。

## 安全提醒

这是教学代码，Agent 会真的执行命令、读写文件。第 3 课的权限机制能挡住误操作和低成本的越界，**挡不住有意的攻击**。

请在专门的工作区目录里运行，不要把工作区指向你的主目录。

## 这不是什么

NamiAgent 是一个**看得懂的最小 Agent**，不是生产级框架，也不打算和 Claude Code、Codex 比功能。目标是让你读完之后，再看任何 Agent 产品，都知道它在上下文里做了什么。

## 相关

- [NamiGPT](https://github.com/aa1143/NamiGPT)：从零手写 GPT-2
- [图解大模型 · Agent 是怎么工作的](https://namiai.tech/matrix/agent/)
- [从零手写 Agent 系列文章](https://namiai.tech/agent/)

## License

MIT
