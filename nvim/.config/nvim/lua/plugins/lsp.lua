return {
  -- LSP Support
  {
    'neovim/nvim-lspconfig',
    config = function()
        local lspConfig = require'lspconfig'
        lspConfig.tsserver.setup{}
        lspConfig.tailwindcss.setup{}
        lspConfig.lua_ls.setup{
            settings = {
                Lua = {
                    diagnostics = {
                        globals = {
                            'vim',
                            'require'
                        },
                    },
                    workspace = {
                        library = vim.api.nvim_get_runtime_file("", true),
                    }
                }
            }
        }

        vim.api.nvim_create_autocmd('LspAttach', {
            callback = function(args)
                vim.keymap.set('n', 'K', vim.lsp.buf.hover, { buffer = args.buf })
            end,
        })
    end
  },
  {
      'typescript-language-server/typescript-language-server',
  },
}

