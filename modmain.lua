local function BadgePostConstruct(self, anim, owner)
	self:SetScale(2,2,2)
end
AddClassPostConstruct("widgets/badge", BadgePostConstruct)