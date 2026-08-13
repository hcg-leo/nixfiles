-- git good lol 

local M = {}

local plugins = require("svim.plugins")
local base = vim.fn.stdpath("data") .. "/site/pack/plugins/start/"

local function name(repo) return repo:match("[^/]+$") end

local function info(msg) vim.notify("[svim] " .. msg, vim.log.levels.INFO) end
local function warn(msg) vim.notify("[svim] " .. msg, vim.log.levels.WARN) end
local function err(msg)  vim.notify("[svim] " .. msg, vim.log.levels.ERROR) end

local function preflight()
    local ok = true

    if vim.fn.executable("git") == 0 then
        err("git not found. install git.")
        ok = false
    end

    if vim.fn.mkdir(base, "p") == 0 and vim.fn.isdirectory(base) == 0 then
        err("cannot create plugin dir: " .. base)
        ok = false
    end

    for _, repo in ipairs(plugins) do
        if not repo:match("^[%w%.%-_]+/[%w%.%-_]+$") then
            err("malformed repo: '" .. repo .. "' (expected 'author/repo')")
            ok = false
        end
    end

    local seen = {}
    for _, repo in ipairs(plugins) do
        local n = name(repo)
        if seen[n] then
            warn("duplicate plugin name '" .. n .. "'")
        end
        seen[n] = true
    end

    return ok
end

function M.install(silent)
    if not preflight() then return end
    local installed_any = false
    for _, repo in ipairs(plugins) do
        local dir = base .. name(repo)
        if vim.fn.isdirectory(dir) == 0 then
            info("installing " .. repo)
            local result = vim.fn.system({ "git", "clone", "--depth=1", "https://github.com/" .. repo, dir })
            if vim.v.shell_error ~= 0 then
                err("failed to install " .. repo .. ": " .. result)
            else
                installed_any = true
            end
        end
    end
    vim.cmd("packloadall | helptags ALL")
    if not silent or installed_any then info("done.") end
end

function M.update()
    for _, repo in ipairs(plugins) do
        local dir = base .. name(repo)
        if vim.fn.isdirectory(dir) == 1 then
            info("updating " .. name(repo))
            local result = vim.fn.system({ "git", "-C", dir, "pull", "--ff-only" })
            if vim.v.shell_error ~= 0 then
                err("failed to update " .. name(repo) .. ": " .. result)
            end
        end
    end
    info("done.")
end

function M.clean()
    local installed = vim.fn.glob(base .. "*", false, true)
    local wanted = {}
    for _, repo in ipairs(plugins) do wanted[name(repo)] = true end
    for _, path in ipairs(installed) do
        if not wanted[path:match("[^/]+$")] then
            info("removing " .. path:match("[^/]+$"))
            vim.fn.delete(path, "rf")
        end
    end
    info("done.")
end

return M
