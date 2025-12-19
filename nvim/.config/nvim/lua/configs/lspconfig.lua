require("nvchad.configs.lspconfig").defaults()

local servers = { "pylsp", "clangd", "lua-language-server" }
vim.lsp.enable(servers)

-- read :h vim.lsp.config for changing options of lsp servers 
