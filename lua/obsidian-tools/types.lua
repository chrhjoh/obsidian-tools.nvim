---@class ObsidianTools.Config
---@field workspaces ObsidianTools.Workspace[]
---@field notes ObsidianTools.NoteConfig
---@field template ObsidianTools.TemplateConfig

---@class ObsidianTools.Workspace
---@field name string
---@field directory string

---@class ObsidianTools.NoteConfig
---@field format_filestem fun(note_stem:string):string
---@field resolve_directory fun(directory, title):string

---@class ObsidianTools.Picker
---@field quickswitch function
---@field tags function

---@class ObsidianTools.TemplateConfig
---@field resolve_template fun(directory, title):string
---@field aliases table<string, fun(directory, title):string>
---@field templates table<string, string[]>
