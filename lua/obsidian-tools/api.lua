---@class ObsidianTools.Api
local M = {}
-- Both selection and prompt
local notes = require("obsidian-tools.notes")
local config = require("obsidian-tools.config").get()

---Creates a new notes by prompting the user for the note.
---@param opts? ObsidianTools.NewNoteOpts
M.new_from_prompt = function(opts)
  opts = opts or {}
  vim.ui.input({ prompt = "Enter title for new note" }, function(title)
    if not title and title ~= "" then
      return
    end
    local filepath = notes.generate_note(title, config.notes)
    if opts.edit_file then
      vim.cmd("e " .. filepath)
    end
  end)
end

---Creates a new notes from visual selection and links to it.
---@param opts? ObsidianTools.NewNoteOpts
M.new_from_visual = function(opts)
  opts = opts or {}
  local obsidian_utils = require("obsidian-tools.utils")
  local title = obsidian_utils.get_visual_selection()
  if title then
    local filepath = notes.generate_note(title, config.notes)
    local filestem = obsidian_utils.get_filestem(filepath)
    vim.cmd("s/" .. title .. "/[[" .. filestem .. "|" .. title .. "]]")
    if opts.edit_file then
      vim.cmd("e " .. filepath)
    end
  end
end

M.open_in_obsidian = function()
  local file_path = vim.api.nvim_buf_get_name(0)
  local workspace = require("obsidian-tools.workspace").get_current()
  local relative_path = file_path:match(".*/" .. workspace.name .. "/(.*)")

  if relative_path then
    -- Construct the Obsidian URI
    local obsidian_uri = string.format("obsidian://open?vault=%s&file=%s", workspace.name, relative_path)

    -- Open the URI using the default method
    -- For macOS
    os.execute(string.format("open '%s'", obsidian_uri))
    -- For Linux
    -- os.execute(string.format("xdg-open '%s'", obsidian_uri))
    -- For Windows
    -- os.execute(string.format("start '%s'", obsidian_uri))
  else
    print("Current file is not within the specified Obsidian vault.")
  end
end

M.quickswitch = require("obsidian-tools.picker.snacks").quickswitch

M.apply_template = function()
  local path = vim.api.nvim_buf_get_name(0)
  vim.ui.input({ prompt = "Title to use for template" }, function(title)
    if not title or title == "" then
      return
    end
    local content = require("obsidian-tools.templates").format_template(title)
    vim.fn.writefile(content, path, "a")
    vim.cmd("e")
  end)
end

M.select_workspace = require("obsidian-tools.workspace").select_workspace

return M
