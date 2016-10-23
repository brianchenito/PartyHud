name="PartyHUD"
description= "A DST mod that displays the health status of other players."
author= "Brian Chen (Chenito)"
version="0.97"
forumthread=""

api_version = 10-- the current version of the modding api




dont_starve_compatible = true
reign_of_giants_compatible = true
dst_compatible = true
all_clients_require_mod = true
client_only_mod = false
priority = -1000-- low priority mod, loads last ish
icon_atlas = "modicon.xml" -- for when we get custom icons
icon = "modicon.tex" -- some really bizzare binary encoding of an image, just send psds to brian or something

server_filter_tags = {"party hud"}

configuration_options=
{
	{
	name="layout",
	label="HUD Layout",
	hover="Choose the Layout of the health indicators",
	options={
			{description = "Compact Grid", data = 0},
			{description = "Horizontal", data = 1}
		},
	default=1,
	},
}