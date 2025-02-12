local M = {}

M.base = [[
---
aliases: 
  - {title}
created: {today} 

---
# {title}
]]

M.format_template = function(title)
  local config = require("obsidian-tools.config").get().template
  local aliases = vim.tbl_deep_extend("force", config.aliases, { title = title })
  local path = vim.api.nvim_buf_get_name(0)
  local template_name = config.resolve_template(path, title)
  local template_config = require("obsidian-tools.config").get().template
  template_name = template_name or "base"
  for name, template in pairs(template_config.templates) do
    if template_name == name then
      for key, value in pairs(aliases) do
        template = template:gsub("{" .. key .. "}", value)
      end
      return template
    end
  end
  vim.notify("Template was not found. Will not apply template")
  return ""
end

return M
