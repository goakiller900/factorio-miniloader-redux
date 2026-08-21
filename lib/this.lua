----------------------------------------------------------------------------------------------------
--- Initialize this mod's globals
----------------------------------------------------------------------------------------------------

local const = require('lib.constants')

---@class MiniLoaderMod
---@field other_mods table<string, string>
---@field settings ff2.ModSettings
---@field MiniLoader miniloader.Controller
---@field Snapping miniloader.Snapping
---@field Console miniloader.Console
---@field Config miniloader.EntityConfig
---@field Gui miniloader.Gui
local This = {
    other_mods = {
        ['PickerDollies'] = 'picker-dollies',
        ['even-pickier-dollies'] = 'picker-dollies',
    },
    settings = require('lib.settings'),
}

function This.boot()
    This.MiniLoader = require('scripts.controller')
    This.Snapping = require('scripts.snapping')
    This.Console = require('scripts.console')
    This.Config = require('scripts.config')
    This.Gui = require('scripts.gui')
end

--------------------------------------------------------------------------------
-- Framework initializer
--------------------------------------------------------------------------------

---@return FrameworkConfig config
function This.framework_init()
    return {
        -- prefix is the internal mod prefix
        prefix = const.prefix,
        -- prefix for log messages
        log_prefix = const.log_prefix,
        -- name is a human readable name
        name = const.name,
        -- The filesystem root.
        root = const.root,
    }
end

return This
