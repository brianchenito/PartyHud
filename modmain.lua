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
	 --Asset( "ANIM", "anim/health.zip"), 
	 --it breaks your normal hpbar atm 
}

-- pulls setting for hod position from modinfo
local hudposition= GetModConfigData("position")

--returns the number of players on the server
local function countplayers(inst)
	local activeplayers=0
	for _,v in ipairs(_G.AllPlayers) do
		print(v.userid, v.components.health:GetPercent()) 
		activeplayers=(activeplayers+1)
	end  
	return activeplayers
end

-- adds function fn to all characters, plus modded chars if exist 
local function AddPlayersPostInit(fn)
	for i,v in ipairs(_G.DST_CHARACTERLIST) do--DST_CHARACTERLIST + ROG_CHARACTERLIST
		AddPrefabPostInit(v,fn)
	end
	if(_G.MODCHARACTERLIST)
		for i,v in ipairs(_G.MODCHARACTERLIST) do-- modded char list
			AddPrefabPostInit(v,fn)
		end
	end
end


