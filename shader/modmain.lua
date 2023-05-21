Assets = {
    Asset("SHADER", "shaders/myshader.ksh")
}


AddPrefabPostInit("researchlab", function (inst)
    inst.AnimState:SetBloomEffectHandle(GLOBAL.resolvefilepath("shaders/myshader.ksh"))
end)
