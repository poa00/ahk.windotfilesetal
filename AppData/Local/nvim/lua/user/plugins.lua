local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system({
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  })
  print("Installing packer close and reopen Neovim...")
  vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init({
  display = {
    open_fn = function()
      return require("packer.util").float({ border = "rounded" })
    end,
  },
  -- Move to lua dir so impatient.nvim can cache it
  compile_path = vim.fn.stdpath("config") .. "/lua/packer_compiled.lua",
})

-- for impatient.nvim
require("packer_compiled")

-- Install your plugins here
return packer.startup(function(use)
  -- My plugins here
  use("wbthomason/packer.nvim") -- Have packer manage itself
  -- use("nvim-lua/popup.nvim") -- An implementation of the Popup API from vim in Neovim
  use("nvim-lua/plenary.nvim") -- Useful lua functions used ny lots of plugins
  use("windwp/nvim-autopairs") -- Autopairs, integrates with both cmp and treesitter
  use("numToStr/Comment.nvim") -- Easily comment stuff
  use("kyazdani42/nvim-web-devicons")
  use("natecraddock/workspaces.nvim")
  use("natecraddock/sessions.nvim")
  use("kyazdani42/nvim-tree.lua")
  use("tamago324/lir.nvim")
  use("tamago324/lir-bookmark.nvim")
  use("akinsho/bufferline.nvim")
  use("moll/vim-bbye")
  use("nvim-lualine/lualine.nvim")
  use("karb94/neoscroll.nvim")
  use("booperlv/nvim-gomove")
  use("goolord/alpha-nvim")
  use("lewis6991/impatient.nvim")
  use("lukas-reineke/indent-blankline.nvim")
  use("tpope/vim-repeat")
  use("tpope/vim-surround")
  use("ggandor/lightspeed.nvim")
  use("ThePrimeagen/harpoon")
  use("mattn/emmet-vim")
  use("lervag/wiki.vim")
  use("dkarter/bullets.vim")
  use("tommcdo/vim-exchange")
  use("michaeljsmith/vim-indent-object")
  use("vim-scripts/ReplaceWithRegister")
  use("svban/YankAssassin.vim")

  -- Colorschemes
  use("folke/tokyonight.nvim")

  -- cmp plugins
  use("hrsh7th/nvim-cmp") -- The completion plugin
  use("hrsh7th/cmp-buffer") -- buffer completions
  use("hrsh7th/cmp-path") -- path completions
  use("hrsh7th/cmp-cmdline") -- cmdline completions
  use("saadparwaiz1/cmp_luasnip") -- snippet completions
  use("hrsh7th/cmp-nvim-lsp")
  use("hrsh7th/cmp-nvim-lua")

  -- snippets
  use("L3MON4D3/LuaSnip") --snippet engine

  -- LSP
  use("neovim/nvim-lspconfig") -- enable LSP
  use("williamboman/nvim-lsp-installer") -- simple to use language server installer
  use("tamago324/nlsp-settings.nvim") -- language server settings defined in json for
  use("jose-elias-alvarez/null-ls.nvim") -- for formatters and linters
  use("ray-x/lsp_signature.nvim") --LSP signature hint as you type
  use("RRethy/vim-illuminate")

  -- Telescope
  use("nvim-telescope/telescope.nvim")
  use("AckslD/nvim-neoclip.lua")
  -- use("rmagatti/session-lens")

  -- Treesitter
  use({
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
  })
  use("JoosepAlviste/nvim-ts-context-commentstring")
  use("nvim-treesitter/nvim-treesitter-textobjects")
  use("RRethy/nvim-treesitter-textsubjects")
  use("windwp/nvim-ts-autotag")

  -- Git
  use("lewis6991/gitsigns.nvim")

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)