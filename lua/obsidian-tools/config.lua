local M = {}
local templates = require("obsidian-tools.templates")
---@class ObsidianTools.Config
local config = {
  workspaces = {},
  notes = {
    format_filestem = function(note_stem)
      note_stem = note_stem .. "-"
      for i = 1, 10 do
        note_stem = note_stem .. tostring(math.random(0, 9))
      end
      return note_stem
    end,
    resolve_directory = function(current_buffer, title)
      return current_buffer
    end,
  },
  template = {
    resolve_template = function(current_buffer, title)
      return "base"
    end,
    aliases = {
      today = function(directory, title)
        return tostring(os.date("%Y-%m-%d"))
      end,
      title = function(directory, title)
        return title
      end,
    },
    templates = {
      base = {
        "---",
        "aliases:",
        "  - {title}",
        "created: {today}",
        "",
        "---",
        "# {title}",
      },
    },
  },
}

M.get = function()
  return config
end

M.resolve = function(opts)
  config = vim.tbl_deep_extend("force", config, opts)
end

return M
