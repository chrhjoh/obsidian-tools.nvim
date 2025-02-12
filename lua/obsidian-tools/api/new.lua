local M = {}
-- Both selection and prompt
local notes = require("obsidian-tools.notes")
local config = require("obsidian-tools.config").get()

M.new_note_prompt = function()
  vim.ui.input({ prompt = "Enter title for new note" }, function(title)
    notes.generate_note(title, config.notes)
  end)
end

return M
