local M = {}

---@param opts ObsidianTools.Config
M.setup = function(opts)
  require("obsidian-tools.config").resolve(opts)
  local config = require("obsidian-tools.config").get()
  require("obsidian-tools.workspace").setup(config)
end

M.new_from_prompt = require("obsidian-tools.api.new").new_from_prompt
M.new_from_visual = require("obsidian-tools.api.new").new_from_visual
M.quickswitch = require("obsidian-tools.api.picker").quickswitch
M.apply_template = require("obsidian-tools.api.template").apply_template
M.open = require("obsidian-tools.api.open_note").open_in_obsidian

return M
