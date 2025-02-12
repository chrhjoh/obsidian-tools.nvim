---@class ObsidianTools: ObsidianTools.Api
local M = {}

---@param opts ObsidianTools.Config
M.setup = function(opts)
  require("obsidian-tools.config").resolve(opts)
  local config = require("obsidian-tools.config").get()
  require("obsidian-tools.workspace").setup(config)
end

M = setmetatable(M, {
  __index = function(_, k)
    return require("obsidian-tools.api")[k]
  end,
})

return M
