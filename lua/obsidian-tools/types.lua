---@class ObsidianTools.Config
---@field workspaces ObsidianTools.Workspace[]
---@field notes ObsidianTools.NoteConfig

---@class ObsidianTools.Workspace
---@field name string
---@field directory string

---@class ObsidianTools.NoteConfig
---@field format_filestem fun(note_stem:string):string
---@field directory string
---@field template string

---@class ObsidianTools.Picker
---@field quickswitch function
---@field tags function
