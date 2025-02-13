local M = {}

---@param bufnr integer
---@return boolean
M.buf_in_workspace = function(bufnr)
  return false
end

---@return string?
M.get_visual_selection = function()
  local _, start_row, start_col, _ = unpack(vim.fn.getpos("v"))
  local _, end_row, end_col, _ = unpack(vim.fn.getpos("."))

  -- Handle reversed selections (if the user selects backward)
  if start_row > end_row or (start_row == end_row and start_col > end_col) then
    start_row, end_row = end_row, start_row
    start_col, end_col = end_col, start_col
  end

  -- Get selected lines
  local lines = vim.api.nvim_buf_get_lines(0, start_row - 1, end_row, false)

  -- Adjust for partial selection on first and last lines
  if #lines ~= 1 then
    return nil
  end
  lines[1] = lines[1]:sub(start_col)

  return lines[1]:sub(1, end_col - start_col + 1)
end

---@param filepath string
---@return string
M.get_filestem = function(filepath)
  local filename = vim.fn.fnamemodify(filepath, ":t")
  return filename:match("(.+)%..+$") or filename
end

---@param filepath string
---@param n? integer
---@return string
M.get_parent_directory = function(filepath, n)
  n = n or 1
  local modifier = string.rep(":h", n)
  return vim.fn.fnamemodify(filepath, modifier)
end

return M
