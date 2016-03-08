local Badge = require "widgets/badge"
local UIAnim = require "widgets/uianim"
local Text = require "widgets/text"

return PartyBadge = Class(Badge, function(self, owner)
	Badge._ctor(self, "badge", owner)
	
	self.partyarrow = self.underNumber:AddChild(UIAnim())
	self.partyarrow:GetAnimState():SetBank("sanity_arrow")
	self.partyarrow:GetAnimState():SetBuild("sanity_arrow")
	self.partyarrow:GetAnimState():PlayAnimation("neutral")
	self.partyarrow:SetClickable(false)
	self.arrowdir = nil
	self:StartUpdating()

	self.text = self:AddChild(Text(NUMBERFONT, 40 / self.base_scale))
end)

function PartyBadge:Update(val)
	self.text:SetString(val)
end

function PartyBadge:OnUpdate(dt)
	local down = self.owner ~= nil and
        self.owner:HasTag("sleeping") and
        self.owner.replica.hunger ~= nil and
        self.owner.replica.hunger:GetPercent() > 0

	local anim = down and "arrow_loop_decrease" or "neutral"
	if self.arrowdir ~= anim then
		self.arrowdir = anim
		self.partyarrow:GetAnimState():PlayAnimation(anim, true)
	end
end

return PartyBadge