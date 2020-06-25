
local api = vim.api
local fn = vim.fn

local file_window = nil
local file_buffer = nil
local old_line = ""

function string.replace(text, old, new)
  local b,e = text:find(old,1,true)
  if b==nil then
     return text
  else
     return text:sub(1,b-1) .. new .. text:sub(e+1)
  end
end

local function start_keystrokes()

    if file_window == nil then

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
        file_buffer = api.nvim_create_buf(false, true)
        -- create file window
        file_window = api.nvim_open_win(
            file_buffer,
            false, -- do not enter into it by default
            config
        )

        vim.bo[file_buffer].filetype = 'keystrokes'

        vim.cmd('setlocal nocursorcolumn')
        vim.cmd('set winblend=' .. vim.g.keystrokes_floating_window_winblend)

    end

    file = vim.fn.expand("~/.config/keystrokes.txt")
    local lines = {}
    for new_line in io.lines(file) do
        local line = new_line:replace( old_line, "" )
        lines[#lines + 1] = line
        old_line = new_line
    end
    api.nvim_buf_set_lines(file_buffer, 0, -1, true, lines)
end

local function stop_keystrokes()
    if file_window == nil then return end
    api.nvim_win_close(file_window, true)
    file_window = nil
end

return {
    start_keystrokes = start_keystrokes,
    stop_keystrokes = stop_keystrokes,
}
