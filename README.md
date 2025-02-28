# wslcwin.nvim

[English](#english) | [中文](#中文)

# English

A lightweight Neovim plugin that automatically synchronizes copy operations to the Windows clipboard in WSL environment.

## Features

- Automatic WSL environment detection
- Seamlessly syncs all yank operations to Windows clipboard
- Preserves all native Vim yank behaviors
- Supports Chinese and other multi-byte characters
- Real-time operation feedback
- Zero configuration needed

## Installation

### Using [lazy.nvim](https://github.com/folke/lazy.nvim)

```lua
{
    "kenis1108/wslcwin.nvim",
    event = "VeryLazy",
    config = function()
        require("wslcwin").setup()
    end,
    -- Only enable in WSL environment
    cond = function()
        return vim.fn.getenv("WSL_DISTRO_NAME") ~= vim.NIL
    end
}
```

### Manual Installation

```bash
git clone https://github.com/kenis1108/wslcwin.nvim.git \
  ~/.local/share/nvim/site/pack/manual/start/wslcwin.nvim
```

Add to your `init.lua`:
```lua
require("wslcwin").setup()
```

## Usage

Just use Vim's native yank operations as usual:

- `y` - Yank selection
- `yy` - Yank current line
- `3yy` - Yank 3 lines
- `yiw` - Yank inner word
- `yip` - Yank inner paragraph
- `yi"` - Yank inside quotes
- ... and all other yank commands

The plugin automatically syncs yanked content to the Windows clipboard.

## Requirements

- WSL environment
- `clip.exe` (Windows clipboard tool)
- `iconv` (for Chinese character support)

## How It Works

The plugin uses Neovim's `TextYankPost` autocmd to detect yank operations and automatically syncs the content to Windows clipboard through `clip.exe`. It handles encoding conversion for Chinese characters using `iconv`.

## License

[Apache License 2.0](LICENSE)

# 中文

在 WSL 环境中自动将 Neovim 复制操作同步到 Windows 剪贴板的轻量级插件。

## 特性

- 自动检测 WSL 环境
- 无缝同步所有复制操作到 Windows 剪贴板
- 保持所有原生 Vim 复制操作行为
- 支持中文等多字节字符
- 实时操作反馈
- 零配置即可使用

## 安装

### 使用 [lazy.nvim](https://github.com/folke/lazy.nvim)

```lua
{
    "kenis1108/wslcwin.nvim",
    event = "VeryLazy",
    config = function()
        require("wslcwin").setup()
    end,
    -- 仅在 WSL 环境中启用
    cond = function()
        return vim.fn.getenv("WSL_DISTRO_NAME") ~= vim.NIL
    end
}
```

### 手动安装

```bash
git clone https://github.com/kenis1108/wslcwin.nvim.git \
  ~/.local/share/nvim/site/pack/manual/start/wslcwin.nvim
```

在你的 `init.lua` 中添加：
```lua
require("wslcwin").setup()
```

## 使用方法

直接使用 Vim 原生的复制操作即可：

- `y` - 复制选中内容
- `yy` - 复制当前行
- `3yy` - 复制 3 行
- `yiw` - 复制当前单词
- `yip` - 复制当前段落
- `yi"` - 复制引号内内容
- ... 以及所有其他复制命令

插件会自动将复制的内容同步到 Windows 剪贴板。

## 依赖

- WSL 环境
- `clip.exe` (Windows 剪贴板工具)
- `iconv` (用于中文字符支持)

## 工作原理

插件使用 Neovim 的 `TextYankPost` 自动命令检测复制操作，并通过 `clip.exe` 自动将内容同步到 Windows 剪贴板。使用 `iconv` 处理中文字符的编码转换。

## 许可证

[Apache License 2.0](LICENSE)

## 更新历史 | Update History

### 2025-02-28
- ♻️ 重构：使用 TextYankPost 自动命令替代按键映射 | Refactor to use TextYankPost autocmd
- 🐛 修复：解决中文字符复制时的乱码问题 | Fix Chinese characters encoding issues
- ✨ 新增：支持所有原生 Vim 复制操作 | Add support for all native Vim yank operations
- 📝 文档：更新文档反映新的使用方式 | Update documentation for new usage
