vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

vim.opt.number = true
vim.opt.relativenumber = true

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    -- add your plugins here
    {"nyoom-engineering/oxocarbon.nvim"},
    {"mason-org/mason.nvim", opts = {}},
    {"mason-org/mason-lspconfig.nvim", opts = {
      ensure_installed = {
        "lua_ls",
        "pylsp",
        "clangd",
        "ts_ls"
      	},
	    },
	  },
    {"hrsh7th/nvim-cmp", opts = {}},
    {"neovim/nvim-lspconfig", config = function() 
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      vim.lsp.config('lua_ls', {
        capabilities = capabilities,
        on_attach = function(client, bufnr)
          -- Key mappings for LSP
          vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>gd', '<cmd>lua vim.lsp.buf.definition()<CR>', { noremap = true, silent = true })
          vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>gr', '<cmd>lua vim.lsp.buf.references()<CR>', { noremap = true, silent = true })
          vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', { noremap = true, silent = true })
          vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>gs', '<cmd>lua vim.lsp.buf.signature_help()<CR>', { noremap = true, silent = true })
        end,
      })

      vim.lsp.config('pylsp', {
        capabilities = capabilities,
        on_attach = function(client, bufnr)
          -- Key mappings for LSP
          vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>gd', '<cmd>lua vim.lsp.buf.definition()<CR>', { noremap = true, silent = true })
          vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>gr', '<cmd>lua vim.lsp.buf.references()<CR>', { noremap = true, silent = true })
          vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', { noremap = true, silent = true })
          vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>gs', '<cmd>lua vim.lsp.buf.signature_help()<CR>', { noremap = true, silent = true })
        end,
      })

      vim.lsp.config('clangd', {
        capabilities = capabilities,
        on_attach = function(client, bufnr)
          -- Key mappings for LSP
          vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>gd', '<cmd>lua vim.lsp.buf.definition()<CR>', { noremap = true, silent = true })
          vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>gr', '<cmd>lua vim.lsp.buf.references()<CR>', { noremap = true, silent = true })
          vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', { noremap = true, silent = true })
          vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>gs', '<cmd>lua vim.lsp.buf.signature_help()<CR>', { noremap = true, silent = true })
        end,
        settings = {
          clangd = {
            completion = { enable = true },
            diagnostics = { enable = true },
            arguments = {
              "--header-insertion=iwyu",  -- Include headers for code completion
              "--clang-tidy",             -- Enable clang-tidy
              "--compile-commands-dir=build",  -- Path to compile_commands.json
            },
          },
        },
      })

      vim.lsp.config('tsserver', {
        capabilities = capabilities,
        on_attach = function(client, bufnr)
          -- Key mappings for LSP
          vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>gd', '<cmd>lua vim.lsp.buf.definition()<CR>', { noremap = true, silent = true })
          vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>gr', '<cmd>lua vim.lsp.buf.references()<CR>', { noremap = true, silent = true })
          vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', { noremap = true, silent = true })
          vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>gs', '<cmd>lua vim.lsp.buf.signature_help()<CR>', { noremap = true, silent = true })
        end,
      })

    end },

    {"nvim-telescope/telescope.nvim",
    
    }, 
    {"nvim-telescope/telescope-fzf-native.nvim"},
    {"hrsh7th/cmp-nvim-lsp", opts = {}},
    {"nvim-treesitter/nvim-treesitter", 
    lazy = false,
    build = ':TSUpdate'},
  },
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  install = { colorscheme = { "oxocarbon" } },
  -- automatically check for plugin updates
  checker = { enabled = true },
})

require'nvim-treesitter'.setup {
  install_dir = vim.fn.stdpath('data') .. '/site'
}

require'nvim-treesitter'.install { 'c', 'cpp', 'python', 'lua' }

vim.api.nvim_create_autocmd('FileType', {
  pattern = { '<filetype>' },
  callback = function() vim.treesitter.start() end,
})

vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"

local cmp = require("cmp")
cmp.setup({
  sources = {
    { name = "nvim_lsp" },  -- LSP completion
    { name = "buffer" },    -- Buffer completion
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-Tab>"] = cmp.mapping.complete(),   -- Trigger autocompletion
    ["<CR>"] = cmp.mapping.confirm({ select = true }),  -- Confirm completion
  }),
})

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })

vim.cmd.colorscheme "oxocarbon"
