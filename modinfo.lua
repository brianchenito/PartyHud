name="PartyHUD"
description= "A DST mod that displays the health status of other players."
author= "Brian Chen (Chenito)"
version="0.12"
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
	name="scale",
	label="Badge Scale",
	hover="Set the size of the indicators:",
	options={
			{description = "Compact", data = 0.8},
			{description = "Normal", data = 1},
			{description = "Large", data = 1.5},
		},
	default=1,
	},
}