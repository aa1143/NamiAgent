from fake import FakeClient, tool_call

import agent


def test_non_object_tool_arguments_are_rejected_without_crashing():
    client = FakeClient([
        [tool_call("bad-args", "list_dir", [])],
        "已收到错误结果并继续。",
    ])
    session = agent.Session("bad-tool-args", persist=False)

    result = agent.run(session, "请列出目录", client, log=lambda *_: None)

    assert result == "已收到错误结果并继续。"
    assert session.messages[3]["content"] == "Error: 工具参数必须是 JSON 对象"
