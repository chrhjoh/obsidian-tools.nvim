local M = {}

M.format_template = function(title)
  local config = require("obsidian-tools.config").get().template
  local aliases = vim.tbl_deep_extend("force", config.aliases, { title = title })
  local path = vim.api.nvim_buf_get_name(0)
  local template_name = config.resolve_template(path, title)
  template_name = template_name or "base"
  for name, template in pairs(config.templates) do
    if template_name == name then
      local resolved_template = {}
      for _, line in ipairs(template) do
        for key, value in pairs(aliases) do
          line = line:gsub("{" .. key .. "}", value)
        end
        table.insert(resolved_template, line)
      end
      return resolved_template
    end
  end
  vim.notify("Template was not found. Will not apply template")
  return ""
end

return M
