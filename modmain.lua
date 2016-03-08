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

Assets={
	 Asset( "ANIM", "anim/health.zip"),
}
local activebadges=0;
local hudposition= GetModConfigData("position")

--print all userids and health%
for _,v in ipairs(_G.AllPlayers) do print(v.userid, v.components.health:GetPercent()) end  

---[[
 -- does something important maybe, we figure it out
local function AddPlayersPostInit(fn)
	for i,v in ipairs(_G.DST_CHARACTERLIST) do
		DST_CHARACTERLIST + ROG_CHARACTERLIST
		AddPrefabPostInit(v,fn)
	end
	for i,v in ipairs(_G.MODCHARACTERLIST) do
		AddPrefabPostInit(v,fn)
	end

end

--]]

