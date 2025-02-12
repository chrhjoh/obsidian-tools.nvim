local M = {}

local base_template = [[
---
aliases: 
  - {title}
created: ]] .. os.date("%Y-%m-%d") .. [[
---
# {title}
]]

local templates = { base = base_template }

M.format_template = function(template_name, substitutes)
  template_name = template_name or "base"
  for name, template in pairs(templates) do
    if template_name == name then
      for key, value in pairs(substitutes) do
        template = template:gsub("{" .. key .. "}", value)
      end
      return template
    end
  end
  vim.notify("Template was not found. Will not apply template")
  return ""
end

return M
