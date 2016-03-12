--[[ 
todo:
phase 1:
	-write class for badges, instance on hud
	-detect player login/ logout
		-update badges to reflect active players(do on login/logout event)
	-get all active players
		-for each active player, get and print health(do on tick)
phase 2: stuff

optional functionality:
	- on hover over badge, display name, numerical health, sanity, food, highlight badge
	- detect damage to player, display fighting indicator over badge
	-detect low health,  display health warning over badge(maybe show red glow around badge?)
	-allow hud positioning options
--]]
--on login or login event or logout event
	--get players
		--get their health

_G = GLOBAL
_G.CHEATS_ENABLED = true--disable for push to live
_G.require( 'debugkeys' )--disable for push to live

-- pulls setting for hud position from modinfo
local hudposition= GetModConfigData("position")

--pulls setting for badge spacing from modinfo
local spacing=GetModConfigData("spacing")

--imports partybadge
local badge= _G.require "widgets/partybadge"

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


local function UpdateBadge(inst)

end
--]]
--constructs badges
AddClassPostConstruct("widgets/statusdisplays", function(self)
	local i=0
	self.badgearray= {}
	for _,v in ipairs(_G.AllPlayers) do
		
		self.badgearray[i]=self:AddChild(badge(self,self.owner))
		self.badgearray[i]:SetPosition(-spacing-spacing*i,100,0)
		i=(i+1)
	end
end)










