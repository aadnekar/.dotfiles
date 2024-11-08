local function python_lint(bufnr)
  local filename = vim.api.nvim_buf_get_name(bufnr)
  local sort_cmd = "flake8 '" .. filename .. "'"

  local cmd_handle = io.popen(sort_cmd)
  if cmd_handle == nil then
    return
  end

  local lines = {}
  for line in cmd_handle:lines() do
    table.insert(lines, line)
  end
  cmd_handle:close()

  vim.cmd('vnew ')
  -- local win = vim.api.nvim_get_current_win()
  -- print('window: ', win)
  -- local buf = vim.api.nvim_create_buf(true, true)
  -- print('buffer: ', buf)
  -- vim.api.nvim_win_set_buf(win, buf)
  local buf = vim.api.nvim_get_current_buf()
  -- Would like to make the register unmodifiable,
  -- and ultimately be able to just click 'q' to close the pane.
  -- vim.api.nvim_buf_set_option(buf, 'PythonLint', )
  print('buf:  ', buf)
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
end
