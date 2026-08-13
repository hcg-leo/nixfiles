-- Opinionated defaults™

local function use_terminal_colours()
    -- Neovim's built-in colourscheme still paints Normal/NormalNC/etc with
    local base_groups = {
        "Normal", "NormalNC", "NormalFloat", "SignColumn",
        "EndOfBuffer", "LineNr", "FoldColumn", "VertSplit", "WinSeparator",
    }
    for _, group in ipairs(base_groups) do
        vim.api.nvim_set_hl(0, group, { bg = "NONE", fg = "NONE" })
    end

    local ansi = {
        black = 0, red = 1, green = 2, yellow = 3,
        blue = 4, magenta = 5, cyan = 6, white = 7,
        bright_black = 8, bright_red = 9, bright_green = 10, bright_yellow = 11,
        bright_blue = 12, bright_magenta = 13, bright_cyan = 14, bright_white = 15,
    }

    local ansi_groups = {
        -- diagnostics
        DiagnosticError = ansi.red,
        DiagnosticWarn  = ansi.yellow,
        DiagnosticInfo  = ansi.blue,
        DiagnosticHint  = ansi.cyan,
        DiagnosticOk    = ansi.green,
        -- diff
        DiffAdd    = ansi.green,
        DiffChange = ansi.yellow,
        DiffDelete = ansi.red,
        DiffText   = ansi.blue,
        -- basic syntax
        String   = ansi.green,
        Comment  = ansi.bright_black,
        Constant = ansi.cyan,
        Number   = ansi.magenta,
        Function = ansi.blue,
        Keyword  = ansi.yellow,
        Statement = ansi.yellow,
        Type     = ansi.cyan,
        Error    = ansi.red,
        Todo     = ansi.magenta,
        healthError = ansi.red,
        healthWarning = ansi.yellow,
        healthSuccess = ansi.green,
    }
    for group, colour in pairs(ansi_groups) do
        vim.api.nvim_set_hl(0, group, { ctermfg = colour, fg = "NONE" })
    end
end

local function apply()
    local o = vim.opt
    o.clipboard = "unnamedplus"
    o.number = true
    o.relativenumber = true
    o.shiftwidth = 4

    local function open_dashboard(buf)
        local dash = require("svim.dashboard")
        vim.api.nvim_set_current_buf(buf)
        vim.bo[buf].buftype = "nofile"
        vim.bo[buf].bufhidden = "wipe"
        vim.bo[buf].swapfile = false
        dash.render(buf)
        dash.keymaps(buf)

        vim.api.nvim_create_autocmd("VimResized", {
            buffer = buf,
            callback = function() dash.render(buf) end
        })
    end

    if vim.fn.argc() == 0 then
        vim.api.nvim_create_autocmd("VimEnter", {
            callback = function()
                open_dashboard(vim.api.nvim_create_buf(false, true))
            end
        })
    end

    use_terminal_colours()
    vim.api.nvim_create_autocmd("ColorScheme", {
        callback = use_terminal_colours,
    })

    vim.api.nvim_create_autocmd("BufEnter", {
        callback = function(args)
            local buf = args.buf
            if vim.bo[buf].buftype ~= "" then return end
            if vim.api.nvim_buf_get_name(buf) ~= "" then return end
            if vim.bo[buf].modified then return end
            if vim.api.nvim_buf_line_count(buf) > 1 then return end
            if vim.api.nvim_buf_get_lines(buf, 0, 1, false)[1] ~= "" then return end
            open_dashboard(buf)
        end
    })
end

apply()
