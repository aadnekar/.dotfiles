return {
  { -- Autoformat
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    keys = {
      {
        '<leader>f',
        function()
          require('conform').format { async = true, lsp_format = 'fallback' }
        end,
        mode = '',
        desc = '[F]ormat buffer',
      },
    },
    opts = {
      -- log_level = vim.log.levels.INFO,
      notify_on_error = true,
      format_on_save = function(bufnr)
        local disable_filetypes = { c = true, cpp = true }
        local lsp_format_opt
        if disable_filetypes[vim.bo[bufnr].filetype] then
          lsp_format_opt = 'never'
        else
          lsp_format_opt = 'fallback'
        end
        return {
          timeout_ms = 500,
          lsp_format = lsp_format_opt,
        }
      end,
      formatters_by_ft = {
        lua = { 'stylua' },
        json = { 'fixjson', 'jq', stop_after_first = true },
        -- yaml = { 'yamlfix', 'yq', stop_after_first = true },
        -- python = { 'isort', 'black' }, -- Use both
        --
        -- You can use 'stop_after_first' to run the first available formatter from the list
        javascript = { 'prettierd', 'prettier', stop_after_first = true },
        typescript = { 'prettierd', 'prettier', stop_after_first = true },
        rust = { 'rustfmt', lsp_format = 'fallback' },
      },
      formatters = {
        yamlfix = { -- Edit yamlfix which is used above
          env = {
            YAMLFIX_WHITELINES = '1',
          },
        },
      },
    },
  },
}
