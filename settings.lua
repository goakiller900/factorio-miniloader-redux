This, Framework = require('lib.init')()

local const = require('lib.constants')

data:extend({
    {
        type = 'bool-setting',
        name = const.settings.loader_snapping,
        order = 'aa',
        setting_type = 'runtime-global',
        default_value = true,
    },
    {
        type = 'string-setting',
        name = const.settings.default_mode,
        order = 'ab',
        setting_type = 'runtime-per-user',
        default_value = 'normal',
        allowed_values = { 'normal', 'speed', 'lane-filter', },
    },
    {
        -- Debug mode (framework dependency)
        type = 'string-setting',
        name = Framework.PREFIX .. 'debug-mode',
        order = 'az',
        setting_type = 'startup',
        default_value = '0',
        allowed_values = { '0', '1', '2', '3' },
    },
    {
        type = 'bool-setting',
        name = const.settings.chute_loader,
        order = 'aa',
        setting_type = 'startup',
        default_value = false,
    },
    {
        type = 'bool-setting',
        name = const.settings.double_recipes,
        order = 'ab',
        setting_type = 'startup',
        default_value = false,
    },
    {
        type = 'bool-setting',
        name = const.settings.no_power,
        order = 'ac',
        setting_type = 'startup',
        default_value = false,
    },
    {
        type = 'bool-setting',
        name = const.settings.spill_items,
        order = 'av',
        setting_type = 'startup',
        default_value = true,
    },
    {
        type = 'bool-setting',
        name = const.settings.check_speed_mode,
        order = 'aw',
        setting_type = 'startup',
        default_value = false,
    },
    {
        type = 'bool-setting',
        name = const.settings.sanitize_loaders,
        order = 'ax',
        setting_type = 'startup',
        default_value = false,
    },
    {
        type = 'bool-setting',
        name = const.settings.fix_blueprint_mods,
        order = 'ay',
        setting_type = 'startup',
        default_value = false,
    },
    {
        type = 'bool-setting',
        name = const.settings.migrate_loaders,
        order = 'az',
        setting_type = 'startup',
        default_value = false,
    },
})

--------------------------------------------------------------------------------

---@diagnostic disable-next-line: undefined-field
Framework.post_settings_stage()
