local M = {}

local function register_parsers()
    local parsers = require("nvim-treesitter.parsers")
    parsers.jjconfig = {
        tier = 2,
        install_info = {
            url = "https://github.com/acarapetis/tree-sitter-toml",
            files = { "src/parser.c", "src/scanner.c" },
            revision = "bdab29474846592d41fc4e298e0e1db048566af7",
        },
    }
    parsers.jjui = {
        tier = 2,
        install_info = {
            url = "https://github.com/acarapetis/tree-sitter-toml",
            files = { "src/parser.c", "src/scanner.c" },
            revision = "7b228d27bbe08e8b41ec25c1da6f35a87bca4ad2",
        },
    }
    parsers.jjtemplate = {
        tier = 2,
        install_info = {
            url = "https://github.com/bryceberger/tree-sitter-jjtemplate",
            files = { "src/parser.c" },
            revision = "4313eda8ac31c60e550e3ad5841b100a0a686715",
        },
    }
    parsers.jjrevset = {
        tier = 2,
        install_info = {
            url = "https://github.com/bryceberger/tree-sitter-jjrevset",
            files = { "src/parser.c" },
            revision = "d9af23944b884ec528b505f41d81923bb3136a51",
        },
    }
end

function M.setup()
    vim.api.nvim_create_autocmd("User", {
        pattern = "TSUpdate",
        callback = register_parsers,
    })
end

return M
