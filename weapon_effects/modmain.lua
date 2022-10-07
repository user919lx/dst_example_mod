--[[****************************************************************************
  * Copyright (c) 2022. LongFei
  ****************************************************************************]]
--[[
  * 
  * Author: LongFei
  * Date: 2022/10/07
  * 
--]]
GLOBAL.CHEATS_ENABLED = true
-- 使用Mod API对长矛进行修改
AddPrefabPostInit("spear",function (inst)
    -- 判断是否是有效目标
    local function IsValidTarget(target)
        if target == nil or
            not (target.entity:IsValid() and target.entity:IsVisible()) then
            return false
        end
        return true
    end
    -- 参考Combat组件的DoAreaAttack
    -- 攻击回调函数，三个参数，分别是武器自身，攻击者，目标
    local function OnattackCallback(weapon, attacker, target)
        local x, y, z = target.Transform:GetWorldPosition()
        -- 在目标周围搜索
        local range = 5 -- 周围5格 
        local ents = TheSim:FindEntities(x, y, z, range, { "_combat" })
        for _, ent in ipairs(ents) do
            if ent ~= weapon and
                ent ~= attacker and
                IsValidTarget(ent) then
                weapon:PushEvent("onareaattackother", { target = ent, weapon = weapon})
                -- 造成aoe伤害，排除攻击目标(攻击目标的伤害由原本的攻击流程产生)
                if ent ~= target then
                    local aoe_percent = 0.5 -- 分散倍率
                    local damage = weapon.components.weapon:GetDamage(attacker, target)
                    ent.components.combat:GetAttacked(attacker, damage*aoe_percent, weapon)
                end
                -- 施加1层冰冻效果
                if ent.components.freezable then
                    ent.components.freezable:AddColdness(1)
                end
                -- 加一点随机特效
                local fxs = {"icespike_fx_1","icespike_fx_2","icespike_fx_3","icespike_fx_4"}
                GLOBAL.SpawnAt(GLOBAL.GetRandomItem(fxs),ent)
            end
        end
    end
    if inst.components.weapon then
        -- 添加攻击回调函数，在使用武器攻击到目标时执行回调函数
        inst.components.weapon:SetAttackCallback(OnattackCallback)
    end
end)