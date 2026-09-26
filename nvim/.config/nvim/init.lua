vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.number = true
vim.opt.relativenumber = true

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

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
    {
      "nvim-lualine/lualine.nvim",
      dependencies = { "nvim-tree/nvim-web-devicons" },
    },
    {
      "windwp/nvim-autopairs",
      event = "InsertEnter",
      config = true,
      -- use opts = {} for passing setup options
      -- this is equivalent to setup({}) function
    },
    { "mason-org/mason.nvim", opts = {} },
    {
      "mason-org/mason-lspconfig.nvim",
      opts = {
        ensure_installed = {
          "lua_ls",
          "pylsp",
          "rust_analyzer",

          "zls",
        },
      },
    },
    { "hrsh7th/nvim-cmp", opts = {} },
    { "dchinmay2/clangd_extensions.nvim" },
    {
      "neovim/nvim-lspconfig",
      config = function()
        vim.lsp.enable({
          "lua_ls",
          "pylsp",
          "rust_analyzer",
          "clangd",
          "zls",
        })
        vim.api.nvim_create_autocmd("LspAttach", {
          callback = function(ev)
            local opts = { buffer = ev.buf, silent = true }
            vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
            vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
            vim.keymap.set("n", "<leader>hh", vim.lsp.buf.rename, opts)
            vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
            vim.keymap.set(
              "n",
              "<leader>h",
              "<cmd>ClangdSwitchSourceHeader<CR>",
              { desc = "Switch between Source/Header" }
            )
          end,
        })
      end,
    },
    { "nvim-telescope/telescope.nvim" },
    { "nvim-telescope/telescope-fzf-native.nvim" },
    { "hrsh7th/cmp-nvim-lsp", opts = {} },
    {
      "nvim-treesitter/nvim-treesitter",
      lazy = false,
      build = ":TSUpdate",
      opts = {
        highlight = {
          enable = true,
        },
        indent = {
          enable = true,
        },
        ensure_installed = {
          "c",
          "cpp",
          "python",
          "lua",
          "rust",
          "zig",
        },
      },
    },
    {
      "nvim-tree/nvim-tree.lua",
      version = "*",
      lazy = false,
      dependencies = {
        "nvim-tree/nvim-web-devicons",
      },
      config = function()
        require("nvim-tree").setup({})
      end,
    },
    {
      "stevearc/conform.nvim",
      opts = {},
    },
  },
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  -- automatically check for plugin updates
  checker = { enabled = true },
})

local cmp = require("cmp")
cmp.setup({
  sources = {
    { name = "nvim_lsp" }, -- LSP completion
    { name = "buffer" }, -- Buffer completion
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-Tab>"] = cmp.mapping.complete(), -- Trigger autocompletion
    ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Confirm completion
    ["<Tab>"] = cmp.mapping.select_next_item(),
  }),
})

local function my_on_attach(bufnr)
  local api = require("nvim-tree.api")

  local function opts(desc)
    return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  -- default mappings
  api.map.on_attach.default(bufnr)

  -- custom mappings
  vim.keymap.set("n", "<C-t>", api.tree.change_root_to_parent, opts("Up"))
  vim.keymap.set("n", "?", api.tree.toggle_help, opts("Help"))
end

-- pass to setup along with your other config
require("nvim-tree").setup({
  on_attach = my_on_attach,
})

require("conform").setup({
  formatters_by_ft = {
    lua = { "stylua" },
    rust = { "rustfmt", lsp_format = "fallback" },
  },

  format_on_save = {
    -- These options will be passed to conform.format()
    timeout_ms = 500,
    lsp_format = "fallback",
  },
})

vim.api.nvim_create_autocmd("BufWritePre", {
  callback = function(args)
    require("conform").format({ bufnr = args.buf })
  end,
})

require("lualine").setup({
  options = {
    icons_enabled = true,
    theme = "auto",
    component_separators = { left = "", right = "" },
    section_separators = { left = "", right = "" },
    disabled_filetypes = {
      statusline = {},
      winbar = {},
    },
    ignore_focus = {},
    always_divide_middle = true,
    always_show_tabline = true,
    globalstatus = false,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
      refresh_time = 16, -- ~60fps
      events = {
        "WinEnter",
        "BufEnter",
        "BufWritePost",
        "SessionLoadPost",
        "FileChangedShellPost",
        "VimResized",
        "Filetype",
        "CursorMoved",
        "CursorMovedI",
        "ModeChanged",
      },
    },
  },
  sections = {
    lualine_a = { "mode" },
    lualine_b = { "branch", "diff" },
    lualine_c = { "diagnostics" },
    lualine_x = { "filename" },
    lualine_y = { "encoding", "fileformat", "filetype" },
    lualine_z = { "location" },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { "filename" },
    lualine_x = { "location" },
    lualine_y = {},
    lualine_z = {},
  },
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = {},
})

local tree = require("nvim-tree.api")
vim.keymap.set("n", "<leader>ft", tree.tree.open, { desc = "Open file tree" })
vim.keymap.set("n", "<leader>fc", tree.tree.close, { desc = "Close file tree" })

local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Telescope find files" })
vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Telescope live grep" })
vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Telescope buffers" })
vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Telescope help tags" })
