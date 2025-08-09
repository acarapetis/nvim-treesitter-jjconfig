---@diagnostic disable: inject-field
local M = {}

function M.setup(opts)
    local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
    parser_config.jjconfig = {
        install_info = {
            url = "https://github.com/acarapetis/tree-sitter-toml",
            files = { "src/parser.c", "src/scanner.c" },
            revision = "bdab29474846592d41fc4e298e0e1db048566af7",
            generate_requires_npm = false,
            requires_generate_from_grammar = false,
        },
    }
    parser_config.jjtemplate = {
        install_info = {
            url = "https://github.com/bryceberger/tree-sitter-jjtemplate",
            files = { "src/parser.c" },
            revision = "4313eda8ac31c60e550e3ad5841b100a0a686715",
            generate_requires_npm = false,
            requires_generate_from_grammar = false,
        },
    }
    parser_config.jjrevset = {
        install_info = {
            url = "https://github.com/bryceberger/tree-sitter-jjrevset",
            files = { "src/parser.c" },
            revision = "d9af23944b884ec528b505f41d81923bb3136a51",
            generate_requires_npm = false,
            requires_generate_from_grammar = false,
        },
    }
end

return M
