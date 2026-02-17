vim.filetype.add({
  pattern = {
    [".*/jjui/config%.toml"] = function(_, _)
      -- Keep it as TOML (so you get standard toml highlighting/plugins)
      return "jjui.toml"
    end
  }
})
