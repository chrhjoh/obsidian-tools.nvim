local M = {}

local function prepend_to_file(filename, content)
  local file = io.open(filename, "r")
  local original_content = ""

  if file then
    original_content = file:read("*all")
    file:close()
  end

  file = io.open(filename, "w")
  if file then
    file:write(content .. "\n" .. original_content)
    file:close()
  else
    vim.notify("Error: Could not open file for writing.")
  end
end

M.apply_template = function()
  local path = vim.api.nvim_buf_get_name(0)
  vim.ui.input({ prompt = "Title to use for template" }, function(title)
    if not title or title == "" then
      return
    end
    local content = require("obsidian-tools.templates").format_template(title)
    prepend_to_file(path, content)
    vim.cmd("e")
  end)
end

return M
