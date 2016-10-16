local Badge = require "widgets/badge"
local UIAnim = require "widgets/uianim"
local Text = require "widgets/text"
local function OnEffigyDeactivated(inst)
    if inst.AnimState:IsCurrentAnimation("deactivate") then
        inst.widget:Hide()
    end
end

local PartyBadge = Class(Badge, function(self, owner)
    Badge._ctor(self, "health", owner)

    -- instance the health debuff coverup
    self.topperanim = self.underNumber:AddChild(UIAnim())
    self.topperanim:GetAnimState():SetBank("effigy_topper")
    self.topperanim:GetAnimState():SetBuild("effigy_topper")
    self.topperanim:GetAnimState():PlayAnimation("anim")
    self.topperanim:SetClickable(false)

    -- instance hp up/down arrow
    self.sanityarrow = self.underNumber:AddChild(UIAnim())
    self.sanityarrow:GetAnimState():SetBank("sanity_arrow")
    self.sanityarrow:GetAnimState():SetBuild("sanity_arrow")
    self.sanityarrow:GetAnimState():PlayAnimation("neutral")
    self.sanityarrow:SetClickable(false)


    --Hide the original frame since it is now overlapped by the topperanim
    self.anim:GetAnimState():Hide("frame")

    self.val = 100
    self.arrowdir = nil
    --self:UpdateArrow()
    	
    self.name = self:AddChild(Text(BODYTEXTFONT, 20))
    self.name:SetHAlign(ANCHOR_MIDDLE)
    self.name:SetPosition(0, -40, 0)
    self.name:SetString("--")

end)

function PartyBadge:SetName(namestring)
    self.name:SetString(namestring)
end
-- updates hud, val= current hp percent(undebuffed), max = max hp, penalty =current hp penalty percent
function PartyBadge:SetPercent(val, max, penaltypercent)
    
    Badge.SetPercent(self, val, max)
    penaltypercent = penaltypercent or 0
    self.topperanim:GetAnimState():SetPercent("anim", penaltypercent)
end

-- hide entire badge
function PartyBadge:HideBadge()
	self.anim:Hide()
	self.sanityarrow:Hide()
	self.topperanim:Hide()
    self.name:Hide()
end

--show entire badge
function PartyBadge:ShowBadge()
	self.anim:Show()
	self.sanityarrow:Show()
	self.topperanim:Show()
    self.name:Show()
	self.anim:GetAnimState():Hide("frame")
end


function PartyBadge:UpdateArrow()
    local down= self.owner~=nil
    	and false
    local up= self.owner~=nil
    	and false
    
    local anim = down and "arrow_loop_decrease_most" or (up and "arrow_loop_increase" or "neutral")
    if self.arrowdir ~= anim then
        self.arrowdir = anim
        self.sanityarrow:GetAnimState():PlayAnimation(anim, true)
    end
end



return PartyBadge
