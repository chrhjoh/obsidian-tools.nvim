local M = {}

---@type ObsidianTools.Workspace
local current_workspace = nil

---@type ObsidianTools.Workspace[]
local workspaces = nil

---@return ObsidianTools.Workspace
M.get_current = function()
  return current_workspace
end

M.select_workspace = function()
  vim.ui.select(workspaces, {
    prompt = "Select Workspace",
    format_item = function(item)
      return item.name
    end,
  }, function(item)
    current_workspace = item
  end)
end

---@param config ObsidianTools.Config
M.setup = function(config)
  workspaces = config.workspaces
  current_workspace = workspaces[1] or nil
end

return M
