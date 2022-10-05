GLOBAL.CHEATS_ENABLED = true
local _G = _G or GLOBAL
local require = _G.require


local function make_player_water_walk(player)
    if player.components.drownable.enabled then
        -- 激活
        player.Physics:ClearCollidesWith(GLOBAL.COLLISION.LAND_OCEAN_LIMITS)
        player.components.drownable.enabled = false
    else
        -- 失效
        player.Physics:CollidesWith(GLOBAL.COLLISION.LAND_OCEAN_LIMITS)
        player.components.drownable.enabled = true
    end
end

GLOBAL.TheInput:AddKeyDownHandler(GLOBAL.KEY_R, function()
    make_player_water_walk(GLOBAL.ThePlayer)
end)