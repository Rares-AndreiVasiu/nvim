-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  use {
	  'nvim-telescope/telescope.nvim', tag = '0.1.8',
	  -- or                            , branch = '0.1.x',
	  requires = { {'nvim-lua/plenary.nvim'} }
  }

  -- kanagawa colorscheme
  use({
      'rebelot/kanagawa.nvim', 
      as = 'kanagwa',
      config = function()
          vim.cmd('colorscheme kanagawa')
      end
  })

  use ('nvim-treesitter/nvim-treesitter', {run = ':TSUpdate'})

  use ('nvim-treesitter/playground')
  
  use ('theprimeagen/harpoon')
  
  use ('mbbill/undotree')
  
  use ('tpope/vim-fugitive')

  use{
      'VonHeikemen/lsp-zero.nvim',
        
      branch = "v2.x",

         requires = {
          -- LSP support:

          {'neovim/nvim-lspconfig'},
          {'williamboman/mason.nvim'},
          {'williamboman/mason-lspconfig.nvim'},

          -- Autcompletion
          {'hrsh7th/nvim-cmp'},
          {'hrsh7th/cmp-buffer'},
          {'hrsh7th/cmp-path'},
          {'saadparwaiz1/cmp_luasnip'},
          {'hrsh7th/cmp-nvim-lsp'},
          {'hrsh7th/cmp-nvim-lua'},

          -- Snippets

          {'L3MON4D3/LuaSnip'},
          {'rafamadriz/friendly-snippets'},
      }
  }
  if packer_bootstrap then
      require('packer').sync()
    end
  end)
