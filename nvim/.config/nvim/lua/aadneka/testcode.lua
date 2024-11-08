local run_tests = function(buf, cmd)
  local append_data = function(data)
    if data then
      vim.api.nvim_buf_set_lines(buf, -1, -1, false, data)
    end
  end

  vim.fn.jobstart(cmd, {
    stdout_buffered = true,
    on_stdout = function(_, data)
      append_data(data)
    end,
    on_stderr = function(_, data)
      append_data(data)
    end,
  })
end

local test_per_lang = {
  rust = function(buf)
    run_tests(buf, { 'cargo', 'test' })
  end,
  typescript = function(buf)
    run_tests(buf, { 'npm', 'test' })
  end,
  javascript = function(buf)
    run_tests(buf, { 'npm', 'test' })
  end,
}

local doTest = function(test_in_lang)
  if test_in_lang == nil then
    print 'Testing in this language is not implemented...'
    return
  end

  local buf = vim.api.nvim_create_buf(true, true)
  local current_window = vim.api.nvim_get_current_win()
  local win_width = vim.api.nvim_win_get_width(current_window)
  local win_height = vim.api.nvim_win_get_height(current_window)
  local window = vim.api.nvim_open_win(buf, false, {
    -- title = 'Test results',
    relative = 'win',
    width = vim.fn.floor(win_width - win_width * 0.2),
    height = vim.fn.floor(win_height - win_height * 0.2),
    row = win_height * 0.1,
    col = win_width * 0.1,
  })
  vim.api.nvim_set_current_win(window)

  vim.api.nvim_set_option_value('filetype', 'terminal', {
    scope = 'local',
    buf = buf,
  })

  test_in_lang(buf)

  vim.keymap.set('n', 'q', function()
    vim.api.nvim_win_close(window, true)
  end, { buffer = true })
end

vim.api.nvim_create_autocmd('BufEnter', {
  desc = 'Run cargo test and display results in a new split buffer',
  group = vim.api.nvim_create_augroup('aadneka-test-code', { clear = true }),
  -- pattern = { '*.rs', '*.{ts,js}' },
  callback = function()
    local filetype = vim.bo.filetype
    vim.keymap.set('n', '<leader>T', function()
      doTest(test_per_lang[filetype])
    end, { desc = '[T]est code' })
  end,
})

vim.api.nvim_create_user_command('Test', function()
  doTest()
end, {})
