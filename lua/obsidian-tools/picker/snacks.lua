---@class ObsidianTools.Picker
local M = {}

M.quickswitch = function()
  require("snacks").picker.files { ft = "md", cwd = os.getenv("OBSIDIAN_HOME") .. "/Work/" }
end
M.tags = function()
  vim.ui.select({ "TODO" }, { prompt = "Select Tag to search for" }, function(tag)
    require("snacks").picker.grep {
      ft = "md",
      cwd = os.getenv("OBSIDIAN_HOME") .. "/Work/",
      live = false,
      search = "#" .. tag,
    }
  end)
end

--TODO: Get all tags using ripgrep (Getting a few FP is fine)
--

return M
