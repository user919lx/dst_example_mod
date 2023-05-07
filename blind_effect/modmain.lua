
AddPlayerPostInit(function (player)
    player:AddComponent("darknessmask")
end)


AddUserCommand("blind", {
    prettyname = "Blind",
    desc = "Blind the player.",
    permission = GLOBAL.COMMAND_PERMISSION.USER,
    slash = true,
    usermenu = false,
    servermenu = false,
    params = {},
    vote = false,
    localfn = function(params, caller)
        if caller ~= nil then
            caller.components.darknessmask:Enable()
        end
    end,
})
