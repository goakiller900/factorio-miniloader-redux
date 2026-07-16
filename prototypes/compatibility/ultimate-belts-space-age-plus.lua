------------------------------------------------------------------------
-- Ultimate Belts Space Age Plus compatibility
------------------------------------------------------------------------

local util = require('util')
local const = require('lib.constants')

local STACKING_ENABLED = feature_flags.space_travel

-- Ultimate Belts uses 2x through 6x express-belt speed (90/135/180/225/270 items/s).
-- The 90, 180 and 270 configurations match existing Miniloader Redux speed tiers.
-- The 135 and 225 configurations interpolate rotation speed and need in-game throughput validation.
local SPEED_SETTINGS = {
    speed_90 = {
        items_per_second = 90,
        rotation_speed = 0.25,
        inserter_pairs = 1,
        stack_size_bonus = 3,
        power_correction = 897/305,
    },
    speed_135 = {
        items_per_second = 135,
        rotation_speed = 0.375,
        inserter_pairs = 1,
        stack_size_bonus = 3,
        power_correction = 1,
    },
    speed_180 = {
        items_per_second = 180,
        rotation_speed = 0.5,
        inserter_pairs = 2,
        stack_size_bonus = 2,
        power_correction = 2070/703,
    },
    speed_225 = {
        items_per_second = 225,
        rotation_speed = 5/12,
        inserter_pairs = 3,
        stack_size_bonus = 2,
        power_correction = 1,
    },
    speed_270 = {
        items_per_second = 270,
        rotation_speed = 0.5,
        inserter_pairs = 3,
        stack_size_bonus = 2,
        power_correction = 3350/1130,
    },
}

local function add_loader(loaders, tier, max_loader)
    loaders[tier.prefix] = {
        condition = function()
            return true
        end,
        data = function()
            return {
                order = tier.order,
                subgroup = 'belt',
                stack_size = 50,
                tint = util.color(tier.tint),
                speed = data.raw['transport-belt'][tier.transport_belt].speed,
                stack = STACKING_ENABLED,
                upgrade_from = const:name_from_prefix(tier.previous),
                corpse_gfx = tier.graphics_prefix,
                explosion_gfx = max_loader,
                belt_gfx = tier.graphics_prefix,
                ingredients = function()
                    return {
                        { type = 'item', name = const:name_from_prefix(tier.previous), amount = tier.previous_count },
                        { type = 'item', name = tier.underground_belt, amount = 1 },
                        { type = 'item', name = 'bulk-inserter', amount = tier.inserter_count },
                    }
                end,
                prerequisites = function()
                    return { tier.technology, const:name_from_prefix(tier.previous), }
                end,
                speed_config = tier.speed_config,
            }
        end,
    }
end

return function(templates)
    local max_loader = mods['space-age'] and 'turbo' or 'express'

    local tiers = {
        {
            prefix = 'ub-ultra-fast',
            previous = max_loader,
            previous_count = 1,
            inserter_count = 4,
            order = 'd[b]-f',
            tint = '00b30cFF',
            transport_belt = 'ultra-fast-belt',
            underground_belt = 'ultra-fast-underground-belt',
            graphics_prefix = 'ultra-fast',
            technology = 'ultra-fast-logistics',
            speed_config = SPEED_SETTINGS.speed_90,
        },
        {
            prefix = 'ub-extreme-fast',
            previous = 'ub-ultra-fast',
            previous_count = 2,
            inserter_count = 2,
            order = 'd[b]-g',
            tint = 'e00000FF',
            transport_belt = 'extreme-fast-belt',
            underground_belt = 'extreme-fast-underground-belt',
            graphics_prefix = 'extreme-fast',
            technology = 'extreme-fast-logistics',
            speed_config = SPEED_SETTINGS.speed_135,
        },
        {
            prefix = 'ub-ultra-express',
            previous = 'ub-extreme-fast',
            previous_count = 2,
            inserter_count = 2,
            order = 'd[b]-h',
            tint = '3604b5E8',
            transport_belt = 'ultra-express-belt',
            underground_belt = 'ultra-express-underground-belt',
            graphics_prefix = 'ultra-express',
            technology = 'ultra-express-logistics',
            speed_config = SPEED_SETTINGS.speed_180,
        },
        {
            prefix = 'ub-extreme-express',
            previous = 'ub-ultra-express',
            previous_count = 2,
            inserter_count = 2,
            order = 'd[b]-i',
            tint = '002bffFF',
            transport_belt = 'extreme-express-belt',
            underground_belt = 'extreme-express-underground-belt',
            graphics_prefix = 'extreme-express',
            technology = 'extreme-express-logistics',
            speed_config = SPEED_SETTINGS.speed_225,
        },
        {
            prefix = 'ub-ultimate',
            previous = 'ub-extreme-express',
            previous_count = 2,
            inserter_count = 2,
            order = 'd[b]-j',
            tint = '00ffddD1',
            transport_belt = 'ultimate-belt',
            underground_belt = 'original-ultimate-underground-belt',
            graphics_prefix = 'original-ultimate',
            technology = 'ultimate-logistics',
            speed_config = SPEED_SETTINGS.speed_270,
        },
    }

    for _, tier in ipairs(tiers) do
        add_loader(templates.loaders, tier, max_loader)
    end
end
