-- start screen  

local M = {}

local logo = {
    "neovim (1)",
}

local menu = {
    "[e] new file",
    "[f] find file",
    "[q] quit",
    "[u] update plugins",
    "[i] install plugins",
    "[c] clean plugins",
}

local function center(line, width)
    return string.rep(" ", math.max(0, math.floor((width - #line) / 2))) .. line
end

function M.render(buf)
    if not vim.api.nvim_buf_is_valid(buf) then return end

    local width  = vim.o.columns
    local height = vim.o.lines

    local content_height = #logo + 1 + #menu
    local top = math.max(0, math.floor((height - content_height) / 2))

    local padded = {}
    for _ = 1, top do table.insert(padded, "") end
    for _, line in ipairs(logo) do
        table.insert(padded, center(line, width))
    end
    table.insert(padded, "")
    for _, line in ipairs(menu) do
        table.insert(padded, center(line, width))
    end
    while #padded < height do table.insert(padded, "") end

    vim.bo[buf].modifiable = true
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, padded)
    vim.bo[buf].modifiable = false
end

function M.keymaps(buf)
    local git = require("svim.git")
    local opts = { buffer = buf, silent = true }

    vim.keymap.set("n", "q", ":qa<cr>", opts)
    vim.keymap.set("n", "u", function() git.update() end, opts)
    vim.keymap.set("n", "i", function() git.install() end, opts)
    vim.keymap.set("n", "c", function() git.clean() end, opts)

    vim.keymap.set("n", "e", function()
        local path = vim.fn.input("new file: ")
        if path ~= "" then vim.cmd("edit " .. vim.fn.fnameescape(path)) end
    end, opts)

    vim.keymap.set("n", "f", function()
        require("telescope.builtin").find_files()
    end, opts)
end

return M
