return {
  "catppuccin/nvim",
  name = "catppuccin",
  lazy = false,
  priority = 1000,
  config = function()
    local ok, catppuccin = pcall(require, "catppuccin")
    if not ok then
      print("❌ Failed to load Catppuccin module")
      return
    end

    catppuccin.setup({
      flavour = "mocha",
      integrations = {
        cmp = true,
        treesitter = true,
        telescope = true,
        nvimtree = true,
      },
    })

    -- this forces Neovim to refresh highlights
    vim.cmd([[colorscheme catppuccin]])
    vim.cmd([[doautocmd ColorScheme]])
    print("✅ Catppuccin applied")
  end,
}

-- vim.cmd.colorscheme = "catppuccin"

