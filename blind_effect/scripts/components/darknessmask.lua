local NineSlice = require "widgets/nineslice"

local DarknessMask = Class(function(self, inst)
    self.inst = inst
    self.dark_duration = 5 -- 持续时间
end)

function DarknessMask:DarkInit()
    self.dark_time = 0
end

function DarknessMask:Enable()
    if not self.mask then
        self:DarkInit()
        self.mask = self.inst.HUD.overlayroot:AddChild(NineSlice("images/dialogcurly_9slice.xml"))
        self.mask:SetSize(RESOLUTION_X, RESOLUTION_Y)
        self.mask:SetVAnchor(ANCHOR_MIDDLE)
        self.mask:SetHAnchor(ANCHOR_MIDDLE)
        self.mask:SetPosition(0, 0)
        self.mask:SetScale(1)
        self.mask:SetTint(1, 1, 1, 1) -- 调整此数值以遮罩层透明度
        self.inst:StartUpdatingComponent(self)
    end
end

function DarknessMask:Disable()
    if self.mask then
        self.mask:Kill()
        self.mask = nil
    end
    self.inst:StopUpdatingComponent(self)
end

function DarknessMask:OnUpdate(dt)
    self.dark_time = self.dark_time + dt

    local darkness = 1 - self.dark_time/self.dark_duration
    if darkness<=0 then
        self:Disable()
        return
    end
    self.mask:SetTint(0, 0, 0, darkness)
end

function DarknessMask:LongUpdate(dt)
    self:OnUpdate(dt)
end



return DarknessMask
