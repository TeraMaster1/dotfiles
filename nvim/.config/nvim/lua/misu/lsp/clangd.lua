require'lspconfig'.clangd.setup({
  cmd = { 'clangd' },  -- Ensure clangd is in your PATH
  root_dir = require('lspconfig').util.root_pattern('.clangd', 'compile_commands.json'),  -- root markers
  filetypes = { 'c', 'cc', 'cpp' },  -- Supported filetypes
})
