return {
    {
      'VonHeikemen/lsp-zero.nvim',
      branch = 'v3.x'
    },
  
    --- Uncomment these if you want to manage LSP servers from neovim
    {'williamboman/mason.nvim'},
    {'williamboman/mason-lspconfig.nvim'},
  
    -- LSP Support
    {
      'neovim/nvim-lspconfig',
      dependencies = {
        {'hrsh7th/cmp-nvim-lsp'},
      }
    },
  
    -- Autocompletion
    {
      'hrsh7th/nvim-cmp',
      dependencies = {
        {'L3MON4D3/LuaSnip'},
      }
    }
}


       
