local json_schema_re =
    vim.regex([["$schema" = "https://\(jj-vcs\.github\.io/jj\|docs.jj-vcs.dev\)/.*/config-schema\.json"]])
local taplo_comment_re =
    vim.regex([[^#:schema https://\(jj-vcs\.github\.io/jj\|docs.jj-vcs.dev\)/.*/config-schema\.json]])

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    pattern = "*.toml",
    callback = function()
        if json_schema_re:match_line(0, 0) or taplo_comment_re:match_line(0, 0) then vim.bo.filetype = "jjconfig.toml" end
    end,
})
