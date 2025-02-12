local M = {}

local sanitize_title = function(title)
  local sanitized_title = title:gsub("[^%w%.%_]", "-"):lower()
  return sanitized_title
end

M.generate_note = function(title, opts)
  local sanititzed_title = sanitize_title(title)
  local filestem = opts.format_filestem(sanititzed_title)
  local content = require("obsidian-tools.templates").format_template(opts.template, { title })
  local filepath = opts.directory .. filestem .. ".md"

  local file = io.open(filepath, "w")
  if file then
    -- Write the template with replaced tags to the file
    file:write(content)
    file:close()
    vim.notify("File created at: " .. filepath)
  else
    vim.notify("Error: Could not create file")
  end
end

return M
