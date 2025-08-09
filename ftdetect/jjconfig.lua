vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    pattern = "*.toml",
    callback = function()
        if vim.fn.getline(1) == '"$schema" = "https://jj-vcs.github.io/jj/latest/config-schema.json"' then
            vim.bo.filetype = "jjconfig.toml"
        end
    end,
})
