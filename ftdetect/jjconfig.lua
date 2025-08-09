local jj_schema_re = vim.regex([["$schema" = "https://jj-vcs\.github\.io/jj/.*/config-schema\.json"]])

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    pattern = "*.toml",
    callback = function()
        if jj_schema_re:match_line(0, 0) then vim.bo.filetype = "jjconfig.toml" end
    end,
})
