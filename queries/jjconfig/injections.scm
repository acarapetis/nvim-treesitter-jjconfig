;; inherits: toml

; Syntax highlight revset and template RHS
(table
 (bare_key) @table-name (#any-of? @table-name "revsets" "revset-aliases")
 (pair (_) (string (string_content) @injection.content))
 (#set! injection.language "jjrevset"))

(table
 (bare_key) @table-name (#any-of? @table-name "templates" "template-aliases")
 (pair (_) (string (string_content) @injection.content))
 (#set! injection.language "jjtemplate"))

; Syntax highlight function definitions in revset/template LHS
(table
 (bare_key) @table-name (#any-of? @table-name "revsets" "revset-aliases")
 (pair . (quoted_key (string_content) @injection.content))
 (#set! injection.language "jjrevset"))

(table
 (bare_key) @table-name (#any-of? @table-name "templates" "template-aliases")
 (pair . (quoted_key (string_content) @injection.content))
 (#set! injection.language "jjtemplate"))

; Syntax highlight revset expressions in command aliases
(table
 (bare_key) @table-name (#eq? @table-name "aliases")
 (pair (_) (array (string (string_content) @before) . 
                  (string (string_content) @injection.content)))
 (#any-of? @before "--from" "--to" "--into" "--revisions" "--insert-after" "--insert-before" "--destination" "--source")
 (#set! injection.language "jjrevset"))

; Syntax highlight inline templates in command aliases
(table
 (bare_key) @table-name (#eq? @table-name "aliases")
 (pair (_) (array (string (string_content) @before) . 
                  (string (string_content) @injection.content)))
 (#any-of? @before "--template" "-T")
 (#set! injection.language "jjtemplate"))

; Syntax highlight shell scripts in command aliases
(table
 (bare_key) @table-name (#eq? @table-name "aliases")
 (pair (_) (array (string (string_content) @b1) . 
                  (string (string_content) @b2) . 
                  (string (string_content) @injection.content)))
 (#any-of? @b1 "bash" "sh")
 (#eq? @b2 "-c")
 (#set! injection.language "sh"))
