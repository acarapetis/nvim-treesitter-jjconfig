;; inherits: toml

; lua scripts in jjui config
(table 
 (pair 
   (bare_key) @lua 
   (string (string_content) @injection.content)
   (#eq? @lua "lua")
   (#set! injection.language "lua")))
