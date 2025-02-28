-- Check if running in WSL environment || 判断是否处于 WSL 环境
local function is_wsl()
    -- First check WSL environment variable || 首先检查 WSL 环境变量
    if vim.fn.getenv("WSL_DISTRO_NAME") ~= vim.NIL then
        return true
    end
    
    -- Fallback: check system release info || 备用方案：检查系统发行版信息
    local file = io.open("/proc/sys/kernel/osrelease", "r")
    if file then
        local content = file:read("*all")
        file:close()
        return string.find(content:lower(), "microsoft") ~= nil
    end
    return false
end

-- Function to copy to Windows clipboard || 复制到 Windows 剪贴板函数
local function copy_to_windows_clipboard()
    -- Get current register content || 获取当前寄存器内容
    local content = vim.fn.getreg('"')
    
    -- Use temp file with UTF-8 encoding || 使用 UTF-8 编码的临时文件
    local temp_file = os.tmpname()
    local file = io.open(temp_file, "w")
    if file then
        -- Ensure content ends with a newline to handle final line properly
        -- 确保内容以换行符结尾，以正确处理最后一行
        if not content:match("\n$") then
            content = content .. "\n"
        end
        
        file:write(content)
        file:close()
        
        -- Convert UTF-8 to Windows encoding using iconv before sending to clip.exe
        -- 使用 iconv 将 UTF-8 转换为 Windows 编码，然后发送到 clip.exe
        os.execute(string.format("cat %s | iconv -f UTF-8 -t CP936 | clip.exe", temp_file))
        os.remove(temp_file)
        
        vim.notify("Copied to Windows clipboard", vim.log.levels.INFO)
    end
end

-- Mapping setup function || 映射设置函数
local function setup_mappings(opts)
    opts = opts or {}
    
    -- Create an autocommand to sync with Windows clipboard after yank
    -- 创建自动命令，在复制操作后同步到 Windows 剪贴板
    vim.api.nvim_create_autocmd("TextYankPost", {
        callback = function()
            copy_to_windows_clipboard()
        end,
    })
end

-- Setup function || 设置函数
local function setup(opts)
    opts = opts or {}
    
    if not is_wsl() then
        vim.notify("Not in WSL environment, plugin disabled", vim.log.levels.WARN)
        return
    end
    
    -- Check if required commands are available || 检查必需的命令是否可用
    if vim.fn.executable('clip.exe') ~= 1 then
        vim.notify("clip.exe not found, plugin disabled", vim.log.levels.ERROR)
        return
    end
    
    if vim.fn.executable('iconv') ~= 1 then
        vim.notify("iconv not found, Chinese characters may not work properly", vim.log.levels.WARN)
    end
    
    setup_mappings(opts)
    vim.notify("WSL copy plugin enabled", vim.log.levels.INFO)
end

return {
    setup = setup,
    copy_to_windows_clipboard = copy_to_windows_clipboard
} 