local M = {}

---@param opts ObsidianTools.Config
M.setup = function(opts)
  require("obsidian-tools.config").resolve(opts)
end

M.note_creation = require("obsidian-tools.api.new").new_note_prompt

return M
