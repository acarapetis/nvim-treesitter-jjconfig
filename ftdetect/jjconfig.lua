local function is_jj_schema(url)
    if not url then return false end
    return url:match("^https://jj%-vcs%.github%.io/jj/.*/config%-schema%.json$")
        or url:match("^https://docs%.jj%-vcs%.dev/.*/config%-schema%.json$")
end

local function get_json_schema_url()
    local parser = vim.treesitter.get_parser(0, "jjconfig")
    if not parser then return nil end

    local root = parser:parse()[1]:root()

    -- Query for top-level pairs with key "$schema"
    local query = vim.treesitter.query.parse(
        "jjconfig",
        [[
            (document
              (pair
                (quoted_key (string_content) @key)
                (#eq? @key "$schema")
                (string (string_content) @value)))
        ]]
    )

    for id, node in query:iter_captures(root, 0) do
        if query.captures[id] == "value" then
            return vim.treesitter.get_node_text(node, 0)
        end
    end

    return nil
end

local function is_comment(line) return line:match("^%s*#") end
local function extract_schema_url(line) return line:match("^%s*#:schema%s*(.*)$") end

local function get_schema_url()
    -- "$schema" = ... at the top level:
    local url = get_json_schema_url()
    if url then return url end

    -- Or #:schema anywhere in the first comment block
    for line_num = 0, vim.api.nvim_buf_line_count(0) - 1 do
        local line = vim.api.nvim_buf_get_lines(0, line_num, line_num + 1, false)[1]
        if not is_comment(line) then return false end
        url = extract_schema_url(line)
        if url then return url end
    end
end

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    pattern = "*.toml",
    callback = function()
        if is_jj_schema(get_schema_url()) then vim.bo.filetype = "jjconfig.toml" end
    end,
})
