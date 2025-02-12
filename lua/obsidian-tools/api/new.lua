local M = {}
-- Both selection and prompt
local notes = require("obsidian-tools.notes")
local config = require("obsidian-tools.config").get()

M.new_from_prompt = function()
  vim.ui.input({ prompt = "Enter title for new note" }, function(title)
    if not title and title ~= "" then
      return
    end
    notes.generate_note(title, config.notes)
  end)
end

M.new_from_visual = function()
  local title = require("obsidian-tools.utils").get_visual_selection()
  if title then
    local filestem = notes.generate_note(title, config.notes)
    vim.cmd("s/" .. title .. "/[[" .. filestem .. "|" .. title .. "]]")
  end
end
return M
