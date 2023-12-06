local server_specific_settings = {
    lua_ls = {
        settings = {
            Lua = {
                diagnostics = {
                    globals = { 'vim' },
                },
            },
        },
    },
}

Setup = function()
    local servers = {
        'lua_ls',

        'tsserver',
        'tailwindcss',

        -- Python
        'jedi_language_server',

        -- C/C++
        'clangd',
    }

    local settings = {
        ui = {
            borders = 'rounded'
        },
        log_level = vim.log.levels.DEBUG,
    }

    require('mason').setup(settings)
    require('mason-lspconfig').setup({
        ensure_installed = servers,
        automatic_installation = true,
    })

    local lspconfig = require('lspconfig')

    local opts = {}

    for _, server in pairs(servers) do
        opts = Get_server_options()
        server = vim.split(server, "@")[1]


        for _server, custom_settings in pairs(server_specific_settings) do
            if _server == server then
                print(string.format('%s is equal to %s', _server, server))
                opts = vim.tbl_deep_extend('force', custom_settings, opts)
            else
                print(string.format('%s is not equal to %s', _server, server))
            end
        end

        lspconfig[server].setup(opts)
    end
end

Get_server_options = function()
    local M = {}

    local cmp_nvim_lsp = require('cmp_nvim_lsp')

    M.capabilities = vim.lsp.protocol.make_client_capabilities()
    M.capabilities.textDocument.completion.completionItem.snippetSupport = true
    M.capabilities = cmp_nvim_lsp.default_capabilities(M.capabilities)

    M.setup = function()
        -- Do I need to edit the signs?
        local signs = {
            { name = "DiagnosticSignError", text = "" },
            { name = "DiagnosticSignWarn", text = "" },
            { name = "DiagnosticSignHint", text = "" },
            { name = "DiagnosticSignInfo", text = "" },
        }

        for _, sign in ipairs(signs) do
            vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
        end

        local config = {
            virtual_text = false,
            -- signs...
            update_in_insert = true,
            underline = true,
            severity_sort = true,
            float = {
                focusable = true,
                style = 'minimal',
                border = 'rounded',
                source = 'always',
            }
        }

        vim.diagnostic.config(config)

        vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
            border = 'rounded',
        })

        vim.lsp.hanlders["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
            border = 'rounded',
        })
    end

    local function lsp_keymaps(bufnr)
        local opts = { noremap = true, silent = true }
        local keymap = vim.api.nvim_buf_set_keymap
        keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
        keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
        keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
        keymap(bufnr, "n", "gI", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
        keymap(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
        keymap(bufnr, "n", "gl", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
        keymap(bufnr, "n", "<leader>lf", "<cmd>lua vim.lsp.buf.format{ async = true }<cr>", opts)
        keymap(bufnr, "n", "<leader>li", "<cmd>LspInfo<cr>", opts)
        keymap(bufnr, "n", "<leader>lI", "<cmd>LspInstallInfo<cr>", opts)
        keymap(bufnr, "n", "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
        keymap(bufnr, "n", "<leader>lj", "<cmd>lua vim.diagnostic.goto_next({buffer=0})<cr>", opts)
        keymap(bufnr, "n", "<leader>lk", "<cmd>lua vim.diagnostic.goto_prev({buffer=0})<cr>", opts)
        keymap(bufnr, "n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
        keymap(bufnr, "n", "<leader>ls", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
        keymap(bufnr, "n", "<leader>lq", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
    end


    M.on_attach = function(client, bufnr)
        lsp_keymaps(bufnr)

        local status_ok, illuminate = pcall(require, 'illuminate')
        if not status_ok then
            return
        end

        illuminate.on_attach(client)
    end

    return M
end

return {
    'neovim/nvim-lspconfig',
    dependencies = {
       "williamboman/mason-lspconfig.nvim",
        { "williamboman/mason.nvim", build = ":MasonUpdate" },
        "hrsh7th/cmp-nvim-lsp",
    },
    event = { 'VeryLazy', 'BufReadPre', 'BufNewFile' },
    config = function()
        Setup()
    end,
}
