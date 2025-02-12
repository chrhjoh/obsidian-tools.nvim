---@class ObsidianTools.Picker
local M = {}

M.quickswitch = function()
  local workspace = require("obsidian-tools.workspace").get_current()
  require("snacks").picker.files { ft = "md", cwd = workspace.directory }
end
M.tags = function()
  local workspace = require("obsidian-tools.workspace").get_current()
  vim.ui.input({ prompt = "Select Tag to search for" }, function(tag)
    require("snacks").picker.grep {
      ft = "md",
      cwd = workspace.directory,
      live = false,
      search = "#" .. tag,
    }
  end)
end

--TODO: Get all tags using ripgrep (Getting a few FP is fine)
--

return M
