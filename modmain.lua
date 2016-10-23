_G = GLOBAL
--_G.CHEATS_ENABLED = true--disable for push to live
--_G.require( 'debugkeys' )--disable for push to live

--print(AllPlayers[1]:HasTag("playerghost"))

--AllPlayers[1]:PushEvent("respawnfromghost")
--print(AllPlayers[1].components.health:IsDead())


-- pulls setting for hud configs from modinfo
local layout=GetModConfigData("layout")
--imports partybadge
local custombadge= _G.require "widgets/partybadge"

local xpos=-650
local ypos=100 

--local scale=_G
--constructor for badge array
local function onstatusdisplaysconstruct(self)

	self.badgearray = {}
		--instance badges for players. 
	for i = 1, GLOBAL.TheNet:GetDefaultMaxPlayers(), 1 do
		self.badgearray[i]=self:AddChild(custombadge(self,self.owner))
		
		if layout==0 then
			--complicated spagetti for a  properly aligned 2x3 grid
			self.badgearray[i]:SetPosition(xpos+(35*(-i-i%2)) ,ypos-110+(110*(-i%2)),0)

		else
			--top centered
			self.badgearray[i]:SetPosition(xpos+(-70*i),ypos,0)
		end
	end

	self.owner.UpdateBadgeVisibility = function()
		for i = 1, GLOBAL.TheNet:GetDefaultMaxPlayers(), 1 do
			self.badgearray[i]:HideBadge()
			--self.badgearray[i]:ShowBadge()

		end
		for i, v in ipairs(_G.AllPlayers) do
			local isdead = (v.customisdead and v.customisdead:value() or false)

			print("Player "..tostring(i).." Should be "..tostring(isdead).." bruh")
			if isdead==true then 
				self.badgearray[i]:ShowDead()
			else
				self.badgearray[i]:ShowBadge()
			end

		end
	end


	--call upon any player healthdelta
	self.owner.UpdateBadges= function()
		--update badges
		for i, v in ipairs(_G.AllPlayers) do
			local percent = v.customhpbadgepercent and (v.customhpbadgepercent:value())/100 or 0
			local max = v.customhpbadgemax and v.customhpbadgemax:value() or 0
			local debuff = v.customhpbadgedebuff and v.customhpbadgedebuff:value() or 0
			self.badgearray[i]:SetPercent(percent,max,0)
			self.badgearray[i]:SetName(v:GetDisplayName())
		end
		GLOBAL.ThePlayer.UpdateBadgeVisibility()
	end


end

-- Apply function on construction of class statusdisplays
AddClassPostConstruct("widgets/statusdisplays", onstatusdisplaysconstruct)

--server functions
local function onhealthdelta(inst, data)
	--get health of char
	local setpercent = data.newpercent and data.newpercent or 0
	inst.customhpbadgepercent:set(math.floor(setpercent * 100+0.5))--potatoey rounding to push shorts
	--get max health of char
	inst.customhpbadgemax:set(inst.components.health:GetMaxWithPenalty())
	--get debuff of char health
	inst.customhpbadgedebuff:set(inst.components.health:GetPenaltyPercent())
	-- forcible is dead check
	if(inst:HasTag('playerghost')) then
	inst.customisdead:set(true)
	end
end

local function ondeath(inst,data)
	inst.customisdead:set(true)
end

local function onrespawn(inst,data)
	inst.customisdead:set(false)
end

--network functions


-- When somebody's health changes, it triggers the badges health update
local function oncustomhpbadgedirty(inst)
	GLOBAL.ThePlayer.UpdateBadges()
end

--when someone dies or revives, it triggers badge visibility toggle
local function ondeathdeltadirty(inst)
	GLOBAL.ThePlayer.UpdateBadgeVisibility()
end
--when someone leaves the server, it triggers badge visibility toggle
local function ondiconnectdirty( inst )
	GLOBAL.ThePlayer.UpdateBadgeVisibility()
end

local function customhppostinit(inst)
	-- Net variable that stores between 0-255; more info in netvars.lua
	-- GUID of entity, unique identifier of variable, event pushed when variable changes
	-- Event is pushed to the entity it refers to, server and client side wise

	inst.customhpbadgepercent = GLOBAL.net_byte(inst.GUID, "customhpbadge.percent", "customhpbadgedirty")
	inst.customhpbadgemax = GLOBAL.net_byte(inst.GUID,"customhpbadge.max","customhpbadgedirty")
	inst.customhpbadgedebuff = GLOBAL.net_byte(inst.GUID,"customhpbadge.debuff","customhpbadgedirty")
	inst.customisdead=GLOBAL.net_bool(inst.GUID,"customhpbadge.isdead","ondeathdeltadirty")



	inst:ListenForEvent("playerexited",ondiconnectdirty, GLOBAL.TheWorld)
	-- Server (master simulation) reacts to health and changes the net variable
	if GLOBAL.TheWorld.ismastersim then
		inst:ListenForEvent("healthdelta", onhealthdelta)
		inst:ListenForEvent("respawnfromghost", onrespawn)
		inst:ListenForEvent("death", ondeath)
		
		-- Hack to trigger deltas for when somebody joins for first time, to update their badges
		inst.components.health:DoDelta(0)
	end

	-- Dedicated server is dummy player, only players hosting or clients have the badges
	-- Only them react to the event pushed when the net variable changes
	if not GLOBAL.TheNet:IsDedicated() then
		inst:ListenForEvent("customhpbadgedirty", oncustomhpbadgedirty)
		inst:ListenForEvent("ondeathdeltadirty", ondeathdeltadirty)
	end
end
-- Apply function on player entity post initialization
AddPlayerPostInit(customhppostinit)