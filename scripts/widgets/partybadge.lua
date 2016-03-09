local Badge = require "widgets/badge"
local UIAnim = require "widgets/uianim"

local function OnIsFullMoon(inst, isfullmoon)
    inst.widget.isfullmoon = isfullmoon
    inst.widget:UpdateArrow()
end

local PartyBadge = Class(Badge, function(self, owner)
    Badge._ctor(self, "health", owner)

    self.sanityarrow = self.underNumber:AddChild(UIAnim())
    self.sanityarrow:GetAnimState():SetBank("sanity_arrow")
    self.sanityarrow:GetAnimState():SetBuild("sanity_arrow")
    self.sanityarrow:SetClickable(false)

    self.inst:WatchWorldState("isfullmoon", OnIsFullMoon)
    self.isfullmoon = TheWorld.state.isfullmoon
    self.val = 100
    self.arrowdir = nil
    self:UpdateArrow()
end)

function PartyBadge:UpdateArrow()
    local anim = self.isfullmoon and self.val > 0 and "arrow_loop_decrease_most" or "neutral"
    if self.arrowdir ~= anim then
        self.arrowdir = anim
        self.sanityarrow:GetAnimState():PlayAnimation(anim, true)
    end
end

function PartyBadge:SetPercent(val, max)
    Badge.SetPercent(self, val, max)
    self.val = val
    self:UpdateArrow()
end

return PartyBadge
