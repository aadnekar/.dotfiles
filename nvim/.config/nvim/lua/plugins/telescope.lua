-- plugins/telescope.lua:
return {
    'nvim-telescope/telescope.nvim', tag = '0.1.3',
      dependencies = { 'nvim-lua/plenary.nvim' },
      opts = {
        file_ignore_pattern = {
            "node_modules",
        },
      },
      config = true,
      keys = {
        { "<leader>pf", "<cmd>Telescope find_files<CR>"},
        { "<C-p>", "<cmd>Telescope git_files<CR>"},
      }
    }



--  local builtin = require('telescope.builtin')
-- vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
-- vim.keymap.set('n', '<C-p>', builtin.git_files, {})
-- vim.keymap.set('n', '<leader>ps', builtin.live_grep, {})
