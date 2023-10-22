return {
    -- LSP Support
    {
        'neovim/nvim-lspconfig',
        config = function()
            local lspConfig = require 'lspconfig'

            -- Typescript/JavaScript
            lspConfig.tsserver.setup {}
            lspConfig.tailwindcss.setup {}
            lspConfig.eslint.setup {
                settings = {
                    {
                        codeAction = {
                            disableRuleComment = {
                                enable = true,
                                location = "separateLine"
                            },
                            showDocumentation = {
                                enable = true
                            }
                        },
                        codeActionOnSave = {
                            enable = false,
                            mode = "all"
                        },
                        experimental = {
                            useFlatConfig = false
                        },
                        format = true,
                        nodePath = "",
                        onIgnoredFiles = "off",
                        problems = {
                            shortenToSingleLine = false
                        },
                        quiet = false,
                        rulesCustomizations = {},
                        run = "onType",
                        useESLintClass = false,
                        validate = "on",
                        workingDirectory = {
                            mode = "location"
                        }
                    }
                }
            }

            --LUA
            lspConfig.lua_ls.setup {
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
                    vim.keymap.set('n', '<leader>f', vim.lsp.buf.format())
                end
            })
        end,
        keys = {
            { 'n', '<leader>e', '<cmd>lua vim.diagnostic.open_float()<cr>' },
            { 'n', '[d',        '<cmd>lua vim.diagnostic.goto_prev' },
            { 'n', ']d',        '<cmd>lua vim.diagnostic.goto_next' },
        }

    },

    {
        'hrsh7th/nvim-cmp',
        dependencies = {
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-cmdline',
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-buffer',
        },
        config = true,
        keys = {
            { '<C-b>', '<cmd>cmp.mapping.scroll_docs(-4)<cr>' },
            { '<C-f>', '<cmd>cmp.mapping.scroll_docs(4)<cr>' },
            { '<C-Space>', '<cmd>cmp.mapping.complete()<cr>' },
            { '<C-e>', '<cmd>cmp.mapping.abort()<cr>' },
            { '<CR>', '<cmd>cmp.mapping.confirm({ select = true})<cr>' },
        }
    },
}
