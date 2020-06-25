
local api = vim.api
local fn = vim.fn

print("Loaded successfully")

local function keystrokes()
end

local function open_floating_window()

    local floating_window_scaling_factor = vim.g.keystrokes_floating_window_scaling_factor

    if type(floating_window_scaling_factor) == 'table' then
        floating_window_scaling_factor = floating_window_scaling_factor[false]
    end

    local height = math.ceil(vim.o.lines * floating_window_scaling_factor) - 1
    local width = math.ceil(vim.o.columns * floating_window_scaling_factor)

    local row = math.ceil(vim.o.lines - height) / 2
    local col = math.ceil(vim.o.columns - width) / 2

    local border_opts = {
        style = "minimal",
        relative = "editor",
        row = row - 1,
        col = col - 1,
        width = width + 2,
        height = height + 2,
    }

    local opts = {
        style = "minimal",
        relative = "editor",
        row = row,
        col = col,
        width = width,
        height = height,
    }

    local border_lines = {'╭' .. string.rep('─', width) .. '╮'}
    local middle_line = '│' .. string.rep(' ', width) .. '│'
    for i = 1, height do
        table.insert(border_lines, middle_line)
    end
    table.insert(border_lines, '╰' .. string.rep('─', width) .. '╯')

    -- create a unlisted scratch buffer for the border
    local border_buffer = api.nvim_create_buf(false, true)

    -- set border_lines in the border buffer from start 0 to end -1 and strict_indexing false
    api.nvim_buf_set_lines(border_buffer, 0, -1, true, border_lines)
    -- create border window
    local border_window = api.nvim_open_win(border_buffer, true, border_opts)

    vim.cmd 'set winhl=Normal:Floating'

    -- create a unlisted scratch buffer
    local file_buffer = api.nvim_create_buf(false, true)
    -- create file window
    local file_window = api.nvim_open_win(file_buffer, true, opts)

    vim.bo[file_buffer].filetype = 'keystrokes'

    vim.cmd('setlocal nocursorcolumn')
    vim.cmd('set winblend=' .. vim.g.keystrokes_floating_window_winblend)
end

return {
    keystrokes = keystrokes,
}
