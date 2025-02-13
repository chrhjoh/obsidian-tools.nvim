local M = {}

local sanitize_title = function(title)
  local sanitized_title = title:gsub("[^a-zA-Z0-9]+", "-"):lower()
  return sanitized_title
end

---@param title any
---@param opts ObsidianTools.NoteConfig
---@return unknown
M.generate_note = function(title, opts)
  local sanititzed_title = sanitize_title(title)
  local filestem = opts.format_filestem(sanititzed_title)
  local content = require("obsidian-tools.templates").format_template(title)
  local current_file_path = vim.api.nvim_buf_get_name(0)
  local directory = vim.fn.fnamemodify(current_file_path, ":h")
  local filepath = opts.resolve_directory(directory, title) .. "/" .. filestem .. ".md"
  -- Write the template with replaced tags to the file
  vim.fn.writefile(content, filepath, "a")
  vim.notify("File created at: " .. filepath)
  return filestem
end

return M
