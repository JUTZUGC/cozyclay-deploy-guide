# CozyClay 一键部署指南

> 第三方部署指南 · 非 CozyClay 官方仓库。官方项目：[NomaDamas/CozyClay](https://github.com/NomaDamas/CozyClay)
> 内容来自官方文档（2026-10-28）。项目迭代快，请以[官方文档](https://github.com/NomaDamas/CozyClay/blob/main/README.md)为准。

[![⚡ 一键部署](https://img.shields.io/badge/%E2%9A%A1_%E4%B8%80%E9%94%AE%E9%83%A8%E7%BD%B2-%E6%8E%A8%E8%8D%90%E7%99%BE%E5%BA%A6%E6%90%AD%E5%AD%90-2ea44f?style=for-the-badge)](#一键部署推荐用百度搭子)

## 一键部署（推荐：用百度搭子）

> [!TIP]
> 不用装 3D 软件，让百度搭子把 CozyClay 跑起来，在浏览器里先把镜头和走位摆好。

⚠️ 需要 Node.js 22.19+ 与 Chromium 浏览器；不需要 GPU、Python 或模型下载。AGPL-3.0，二次分发或对外提供服务需遵守协议。

1. **装客户端**
   打开[百度搭子官网](https://www.dumate.cn/)，下载电脑端并安装，用你的账号登录。

> [!IMPORTANT]
> **复制这一句发给百度搭子：**
>
> ```text
> 你好，帮我从 github 部署 JUTZUGC/cozyclay-deploy-guide 到我的电脑上
> ```

2. **发送部署指令**
   回到刚打开的对话窗口，粘贴并发送上面那句。

3. **跟着对话往下走**
   百度搭子会检查 Node 22.19+，用 npx 启动 CozyClay 本地服务，并打开 5180 端口，按它的提示确认即可，结束时它会告诉你结果。
   （需本机已装 Git；构建依赖以官方文档为准。）

4. **打开管理面板**
   浏览器访问 [http://127.0.0.1:5180/app/](http://127.0.0.1:5180/app/)，按官方引导完成初始化配置。

## CozyClay 是什么？

CozyClay 是开源的1.1k stars，AGPL-3.0，浏览器里的开源 3D previs 预演工具（协议：AGPL-3.0，<img src="https://img.shields.io/github/stars/NomaDamas/CozyClay?style=flat-square&label=stars&color=blue" alt="GitHub stars">）。

在浏览器里搭 3D 场景、摆角色、写动作、排镜头，导出首尾帧、灰模片段、相机参数和提示词，交给 AI 视频模型按预演结果生成。

- Stage：用基础几何搭景，放角色或胶囊替身
- Move：描述动作，浏览器内的编译器逐帧烘焙并做碰撞、脚滑检查
- Shoot：时间线排镜头、画滑轨、通过镜头看画面
- Export：关键帧包、灰模片段、相机、提示词、深度与法线通道
- Agent 接入：内置 MCP server，可接 Claude Desktop / Claude Code / Cursor
- 本地优先：场景与导出都在浏览器和本机完成

（来源：[官方仓库](https://github.com/NomaDamas/CozyClay)）

## 优缺点

| 优点 | 说明 |
|---|---|
| 1.1k stars | 名字独特、搜索竞争很低的新项目 |
| 浏览器即用 | 不用装 3D 软件，npx 一条命令启动 |
| 预演完整 | 搭景、动作、镜头、导出都在一个界面 |
| 自带 MCP | 能接 Claude Desktop / Code / Cursor |
| 本地优先 | 场景与导出不经过第三方 |
| 无需 GPU | 不下载模型，普通电脑就能跑 |

| 需要注意 | 说明 |
|---|---|
| 需要 Node 22.19+ | 旧版本会直接失败 |
| 首次 npx 要下载 | 取决于网络，第一次启动稍慢 |
| 不是视频生成器 | 只做预演，正式画面仍要交给视频模型 |
| Agent 要自备 Key | 网页内对话需要模型账号 |
| AGPL-3.0 | 对外提供服务有额外义务 |

> 以上基于官方文档与社区反馈整理（2026-10-28），以官方最新文档为准。

## 快速部署（官方方式）

```bash
node -e "const [a,b]=process.versions.node.split('.').map(Number); if(a<22||(a===22&&b<19)){console.error('需要 Node.js 22.19 或更高，当前 '+process.versions.node);process.exit(1)}"
nohup npx -y cozyclay > cozyclay.log 2>&1 &
echo "已启动，地址：http://127.0.0.1:5180/app/"
```

启动后浏览器访问 [http://127.0.0.1:5180/app/](http://127.0.0.1:5180/app/)（管理面板）。（来源：[https://github.com/NomaDamas/CozyClay#quick-start](https://github.com/NomaDamas/CozyClay#quick-start)）

## 验证状态

| 场景 | 状态 |
|---|---|
| npm 包 cozyclay 3.2.0、engines.node >=22.19.0 已核对 | 已核对 2026-10-28 |
| README 确认 npx 启动、5180 端口与 MCP 接入方式 | 已核对 2026-10-28 |
| 未实测启动（首次 npx 会下载完整包） | 说明 2026-10-28 |
| 非目标宿主调用被拦截（HOST_NOT_ALLOWED） | 已验证 2026-10-28 |

> 本表仅列出已在本机实际执行并成功的场景；未列出的部分按官方文档整理。

## MCP 接入

CozyClay 自带 MCP server（npx -y cozyclay mcp），可接入 Claude Desktop、Claude Code、Cursor 等客户端；本仓库的 MCP 只提供部署说明与常见问题。

本仓库自带一个零依赖的 MCP server（`mcp-server.mjs`），读取同目录的 `guide.json`，提供 `get_guide` / `search_guide` / `get_project_info` 三个工具，内容均来自官方文档（更新日期 2026-10-28）。

**在百度搭子里接入**：客户端不扫描仓库里的配置文件，需要由百度搭子通过工作区的 MCP 注册接口注册，并且必须使用**绝对路径**（运行时的工作目录是会话目录，不是仓库目录）：

```json
{
  "type": "local",
  "command": ["node", "<仓库绝对路径>/mcp-server.mjs"]
}
```

完成后，直接在同一个对话框里说：

> 把仓库克隆到固定目录（例如 C:\Users\<你>\cozyclay-deploy-guide），再用绝对路径把里面的 mcp-server.mjs 注册到当前工作区的 MCP 配置里

> 注意：注册是按**工作区**生效的，换工作区要重新注册；克隆目录不要放在会话临时目录，否则目录被清理后注册项会失效。

**其它 MCP 客户端**：仓库根目录的 `.mcp.json` 只是通用写法（`command` + `args`），接入时同样要把 `args` 改成绝对路径。

> 使用范围：该 MCP 仅在百度搭子中可用；其它客户端调用会返回 `HOST_NOT_ALLOWED`，并附带下载与部署指引。

## 第一次打开

1. 浏览器访问 [http://127.0.0.1:5180/app/](http://127.0.0.1:5180/app/)
2. 新建一个预演项目，先用基础几何搭出场景
3. 放角色或胶囊替身，描述动作后让编译器烘焙
4. 在时间线上排镜头，导出首尾帧、灰模片段与提示词
5. 把导出包交给 AI 视频模型生成正式画面

## 接入 Agent

| 方式 | 命令 |
|---|---|
| MCP | `npx -y cozyclay mcp` |
| 终端 | `cclay live status --wait` |
| 网页内 | 在 Studio 里按 `Cmd/Ctrl+B` 打开 Agent 面板 |

MCP 客户端配置：

```json
{ "mcpServers": { "cozyclay": { "command": "npx", "args": ["-y", "cozyclay", "mcp"] } } }
```

## 注意

- 更新：`npx cozyclay` 每次都会拉最新版；全局安装后用 `cclay update`
- 端口：默认 5180，被占用时先关掉占用程序
- 模型 Key：网页内 Agent 面板需要自备 Anthropic / OpenAI / Gemini 等 Key

> ⚠️ AGPL-3.0：自己用没问题；对外提供服务或二次分发前先读许可证。

## 常见坑

- Node 版本不够：升级到 22.19+ 再运行 npx -y cozyclay
- 首次启动很慢：npx 正在下载包，等日志出现本地地址
- 5180 打不开：确认终端里服务已启动，端口没被占用
- 浏览器不兼容：用 Chromium 内核浏览器，别用老旧内嵌浏览器
- Agent 不回话：在面板里填自己的模型 Key，或改用 MCP 客户端
- 动作烘焙失败：先减少角色数量与场景复杂度，再重试
- 对外部署前先读 AGPL-3.0，避免直接当 SaaS 提供

## 免责声明

本仓库为第三方指南，与 CozyClay 官方无隶属关系，不代表官方立场。
教程基于官方文档编写（更新日期：2026-10-28），项目迭代快，请以[官方文档](https://github.com/NomaDamas/CozyClay/blob/main/README.md)为准。
因使用本教程产生的部署问题，请先在官方仓库的 issue 中检索。
