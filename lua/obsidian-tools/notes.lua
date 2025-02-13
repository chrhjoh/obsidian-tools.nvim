local M = {}

local sanitize_title = function(title)
  local sanitized_title = title:gsub("[^a-zA-Z0-9]+", "-"):lower()
  return sanitized_title
end

---@param title any
---@param opts ObsidianTools.NoteConfig
---@return string
M.generate_note = function(title, opts)
  local sanititzed_title = sanitize_title(title)
  local filestem = opts.format_filestem(sanititzed_title)
  local content = require("obsidian-tools.templates").format_template(title)
  local current_file = vim.api.nvim_buf_get_name(0)
  local current_directory = require("obsidian-tools.utils").get_parent_directory(current_file)
  local filepath = opts.resolve_directory(current_directory, title) .. "/" .. filestem .. ".md"
  -- Write the template with replaced tags to the file
  vim.fn.writefile(content, filepath, "a")
  vim.notify("File created at: " .. filepath)
  return filepath
end

return M
