local M = {}

local all_parsers = { "jjconfig", "jjtemplate", "jjrevset" }

---@class TSJJConfig
---@field ensure_installed? boolean If true, automatically install jj parsers.
---@field sync_install? boolean If true, do the automatic installation synchronously.

---@param opts TSJJConfig|nil
function M.setup(opts)
    opts = opts or {}

    ---@diagnostic disable: inject-field
    local parsers = require("nvim-treesitter.parsers")
    local declare
    if parsers.get_parser_configs then
        -- old nvim-treesitter
        declare = function(name, install_info)
            parsers.get_parser_configs()[name] = { install_info = install_info }
        end
    else
        -- new nvim-treesitter
        declare = function(name, install_info)
            vim.api.nvim_create_autocmd("User", {
                pattern = "TSUpdate",
                callback = function() parsers[name] = { install_info = install_info } end,
            })
        end
    end
    declare("jjconfig", {
        url = "https://github.com/acarapetis/tree-sitter-toml",
        files = { "src/parser.c", "src/scanner.c" },
        revision = "bdab29474846592d41fc4e298e0e1db048566af7",
        generate_requires_npm = false,
        requires_generate_from_grammar = false,
    })
    declare("jjtemplate", {
        url = "https://github.com/bryceberger/tree-sitter-jjtemplate",
        files = { "src/parser.c" },
        revision = "4313eda8ac31c60e550e3ad5841b100a0a686715",
        generate_requires_npm = false,
        requires_generate_from_grammar = false,
    })
    declare("jjrevset", {
        url = "https://github.com/bryceberger/tree-sitter-jjrevset",
        files = { "src/parser.c" },
        revision = "d9af23944b884ec528b505f41d81923bb3136a51",
        generate_requires_npm = false,
        requires_generate_from_grammar = false,
    })

    if opts.ensure_installed then
        local install = require("nvim-treesitter.install")
        local has_ensure = install.ensure_installed
        if has_ensure then
            -- old nvim-treesitter
            if opts.sync_install then
                install.ensure_installed_sync(all_parsers)
            else
                install.ensure_installed(all_parsers)
            end
        else
            -- new nvim-treesitter
            local future = require("nvim-treesitter").install(all_parsers)
            if opts.sync_install then future:wait(300000) end
        end
    end
end

return M
