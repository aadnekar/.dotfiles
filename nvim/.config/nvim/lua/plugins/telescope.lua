local is_git_repository = function()
    local ret = os.execute('git rev-parse --is-inside-work-tree')
    return ret == 0
end


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
      keys = function()
        local keys = {
          { "<leader>ps", "<cmd>Telescope live_grep<CR>"},
        }

        if (is_git_repository()) then
            print("IS a git repo")
            table.insert(keys, { "<C-p>", "<cmd>Telescope git_files<CR>"})
            table.insert(keys, { "<leader>pf", "<cmd>Telescope find_files<CR>" })
        else
            table.insert(keys, { "<C-p>", "<cmd>Telescope find_files<CR>" })
        end
        return keys
    end
}



--  local builtin = require('telescope.builtin')
-- vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
-- vim.keymap.set('n', '<C-p>', builtin.git_files, {})
-- vim.keymap.set('n', '<leader>ps', builtin.live_grep, {})
