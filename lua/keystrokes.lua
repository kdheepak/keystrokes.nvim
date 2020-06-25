
local api = vim.api
local fn = vim.fn

local function keystrokes()
    local floating_window_scaling_factor = vim.g.keystrokes_floating_window_scaling_factor

    if type(floating_window_scaling_factor) == 'table' then
        floating_window_scaling_factor = floating_window_scaling_factor[false]
    end

    local height = math.ceil(vim.o.lines * floating_window_scaling_factor) - 1
    local width = math.ceil(vim.o.columns * floating_window_scaling_factor)

    local row = math.ceil(vim.o.lines - height / 4)
    local col = math.ceil(vim.o.columns - width / 4)

    local config = {
        style = "minimal",
        relative = "editor",
        row = row,
        col = col,
        width = math.ceil(width / 4),
        height = math.ceil(height / 4),
    }

    -- create a unlisted scratch buffer
    local file_buffer = api.nvim_create_buf(false, true)
    -- create file window
    local file_window = api.nvim_open_win(
        file_buffer,
        false, -- do not enter into it by default
        config
    )

    vim.bo[file_buffer].filetype = 'keystrokes'

    vim.cmd('setlocal nocursorcolumn')
    vim.cmd('set winblend=' .. vim.g.keystrokes_floating_window_winblend)

    file = vim.fn.expand("~/.config/keystrokes.txt")
    local lines = {}
    for line in io.lines(file) do
        lines[#lines + 1] = line
    end
    api.nvim_buf_set_lines(file_buffer, 0, -1, true, lines)
end

return {
    keystrokes = keystrokes,
}
