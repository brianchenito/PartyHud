
_G = GLOBAL
_G.CHEATS_ENABLED = true--disable for push to live
_G.require( 'debugkeys' )--disable for push to live

-- pulls setting for hud position from modinfo
local hudposition= GetModConfigData("position")

--pulls setting for badge spacing from modinfo
local spacing=GetModConfigData("spacing")

--imports partybadge
local custombadge= _G.require "widgets/partybadge"

--[[
--returns the number of players on the server
local function countplayers(inst)
	local activeplayers=0
	for _,v in ipairs(_G.AllPlayers) do
		--print(v.userid, v.components.health:GetPercent()) 
		activeplayers=(activeplayers+1)
	end  
	return activeplayers
end


--]]

--constructs badges, and hides them
AddClassPostConstruct("widgets/statusdisplays", function(self)
	self.badgearray= {}
	for i=0,5 do -- make 6 of these
		self.badgearray[i]=self:AddChild(custombadge(self,self.owner))
		self.badgearray[i]:SetPosition((-100-spacing*i),100,0)
		--self.badgearray[i]:HideBadge()
		self.badgearray[i]:SetPercent(0.5,100,0.2)
		
	end
	
end)











