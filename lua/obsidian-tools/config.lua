local M = {}

---@class ObsidianTools.Config
local config = {
  workspaces = {},
  notes = {
    format_filestem = function(note_stem)
      for i = 1, 8 do
        note_stem = note_stem .. tostring(math.random(0, 9))
      end
      return note_stem
    end,
    directory = "",
    template = "base",
  },
}

M.get = function()
  return config
end

M.resolve = function(opts)
  config = vim.tbl_deep_extend("force", config, opts)
end

return M
