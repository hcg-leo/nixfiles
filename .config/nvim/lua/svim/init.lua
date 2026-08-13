require("svim.defaults")

local git = require("svim.git")

vim.api.nvim_create_user_command("Sinstall", function() git.install() end, {})
vim.api.nvim_create_user_command("Supdate",  function() git.update() end, {})
vim.api.nvim_create_user_command("Sclean",   function() git.clean() end, {})

require("svim.lsp")


local function setup(mod, fn)
    local ok, m = pcall(require, mod)
    if ok then fn(m) end
end

setup("lualine", function(lualine)
    lualine.setup({ options = { theme = "auto" } })
end)

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

setup("nvim-tree", function(tree)
    tree.setup({
        view = { width = 30, side = "left" },
    })
    vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<cr>", { silent = true })
end)

setup("cmp", function(cmp)
    cmp.setup({
        snippet = {
            expand = function(args)
                require("luasnip").lsp_expand(args.body)
            end,
        },
        mapping = cmp.mapping.preset.insert({
            ["<C-Space>"] = cmp.mapping.complete(),
            ["<CR>"]      = cmp.mapping.confirm({ select = true }),
            ["<Tab>"]     = cmp.mapping.select_next_item(),
            ["<S-Tab>"]   = cmp.mapping.select_prev_item(),
        }),
        sources = {
            { name = "nvim_lsp" },
            { name = "luasnip" },
            { name = "buffer" },
            { name = "path" },
        },
    })
end)

return git
