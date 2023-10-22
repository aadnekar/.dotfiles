return {
    'nvim-treesitter/nvim-treesitter',
    opts = {
        ensure_installed = {
            'lua',
            'typescript',
            'javascript',
            'rust',
        },
        sync_install = false,
        auto_install = true,

        highlight = {
            enable = true,
        },
    }
}

