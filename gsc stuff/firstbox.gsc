#include maps\mp\gametypes_zm\_hud_util;
#include maps\mp\zombies\_zm_utility;
#include common_scripts\utility;
#include maps\mp\_utility;
#include maps\mp\zombies\_zm_weapons;
#include maps\mp\zombies\_zm_magicbox;

boxlocation_origins()
{
	switch(getDvarInt("firstbox"))
	{
		case 1: level thread startbox("bunker_tank_chest"); break;
		case 2: level thread startbox("bunker_cp_chest"); break;
		default: break;
	}
}

boxlocation_mob()
{
	switch(getDvarInt("firstbox"))
	{
		case 1: level thread startbox("cafe_chest"); break;
		case 2: level thread startbox("start_chest"); break;
		default: level thread startbox("cafe_chest"); break;
	}
}

boxlocation_town()
{
	switch(getDvarInt("firstbox"))
	{
		case 1: level thread startbox("town_chest_2"); break;
		case 2: level thread startbox("town_chest"); break;
		default: level thread startbox("town_chest_2"); break;
	}
}


startBox(start_chest)
{

    self endon("disconnect");
    
	for(i = 0; i < level.chests.size; i++)
	{

        if(level.chests[i].script_noteworthy == start_chest)
    		desired_chest_index = i; 
        else if(level.chests[i].hidden == 0)
     		nondesired_chest_index = i;               	
	}

	if( isdefined(nondesired_chest_index) && (nondesired_chest_index < desired_chest_index))
	{
		level.chests[nondesired_chest_index] hide_chest();
		level.chests[nondesired_chest_index].hidden = 1;

		level.chests[desired_chest_index].hidden = 0;
		level.chests[desired_chest_index] show_chest();
		level.chest_index = desired_chest_index;
	}	
}

firstbox()
{
	self endon("disconnect");
	flag_wait("initial_blackscreen_passed");
	
	if(level.round_number < 50 && getDvarInt("firstbox"))
	{
		switch(level.script)
		{
			case "zm_transit":
				forced_box_guns = array("raygun_mark2_zm", "cymbal_monkey_zm", "emp_grenade_zm");
				break;
			
			case "zm_nuked":
				forced_box_guns = array("raygun_mark2_zm", "cymbal_monkey_zm");
				break;

			case "zm_highrise":
				forced_box_guns = array("cymbal_monkey_zm");
				break;

			case "zm_prison":
				forced_box_guns = array("raygun_mark2_zm", "blundergat_zm");
				break;

			case "zm_buried":
				forced_box_guns = array("raygun_mark2_zm", "cymbal_monkey_zm", "slowgun_zm");
				break;

			case "zm_tomb":
				if(getDvar("SR") == 30)
					forced_box_guns = array("scar_zm", "raygun_mark2_zm", "cymbal_monkey_zm");
				else
					forced_box_guns = array("raygun_mark2_zm", "cymbal_monkey_zm", "m32_zm");
				break;
				
			default:
				break;
		}

		level.special_weapon_magicbox_check = undefined;
		foreach(weapon in level.zombie_weapons) 
			weapon.is_in_box = 0;

		boxhits = -1;
		while((boxhits < forced_box_guns.size))
		{
			if(boxhits < level.chest_accessed)
			{
				if(level.chest_accessed != forced_box_guns.size)
				{
					gun = forced_box_guns[boxhits+1];
					level.zombie_weapons[gun].is_in_box = 1;
				}
				boxhits++;		
			}
		wait 2;
		}
		
		switch(level.script)
		{
			case "zm_transit":
				if(level.scr_zm_map_start_location == "town" || level.scr_zm_ui_gametype_group == "zclassic")
					level.special_weapon_magicbox_check = ::transit_special_weapon_magicbox_check;
				else
					level.special_weapon_magicbox_check = ::general_weapon_magicbox_check;
				break;

			case "zm_nuked":
			case "zm_prison":
				level.special_weapon_magicbox_check = ::general_weapon_magicbox_check;
				break;

			case "zm_highrise":
				level.special_weapon_magicbox_check = ::highrise_special_weapon_magicbox_check;
				break;

			case "zm_buried":
				level.special_weapon_magicbox_check = ::buried_special_weapon_magicbox_check;
				break;

			case "zm_tomb":
				level.special_weapon_magicbox_check = ::tomb_special_weapon_magicbox_check;
				break;
				
			default:
				break;
		}

		keys = getarraykeys(level.zombie_include_weapons);
		foreach(weapon in keys)
		{
			if(level.zombie_include_weapons[weapon] == 1)
				level.zombie_weapons[weapon].is_in_box = 1;
		}
	}
}

transit_special_weapon_magicbox_check(weapon)
{
	if(isdefined(level.raygun2_included) && level.raygun2_included)
	{
		if(weapon == "ray_gun_zm")
		{
			if(self has_weapon_or_upgrade("raygun_mark2_zm") || maps\mp\zombies\_zm_tombstone::is_weapon_available_in_tombstone("raygun_mark2_zm", self))
			{
				return 0;
			}
		}
		if(weapon == "raygun_mark2_zm")
		{
			if(self has_weapon_or_upgrade("ray_gun_zm") || maps\mp\zombies\_zm_tombstone::is_weapon_available_in_tombstone("ray_gun_zm", self))
			{
				return 0;
			}
			if(randomint(100) >= 33)
			{
				return 0;
			}
		}
	}
	return 1;
}

buried_special_weapon_magicbox_check(weapon)
{
	if(weapon == "ray_gun_zm")
	{
		if(self has_weapon_or_upgrade("raygun_mark2_zm"))
		{
			return 0;
		}
	}
	if(weapon == "raygun_mark2_zm")
	{
		if(self has_weapon_or_upgrade("ray_gun_zm"))
		{
			return 0;
		}
	}
	if(weapon == "time_bomb_zm")
	{
		players = get_players();
		for(i = 0; i < players.size; i++)
		{
			if(is_player_valid(players[i], undefined, 1) && players[i] is_player_tactical_grenade(weapon))
			{
				return 0;
			}
		}
	}
	return 1;
}

highrise_special_weapon_magicbox_check(weapon)
{
	if(isdefined(level.raygun2_included) && level.raygun2_included)
	{
		if(weapon == "ray_gun_zm")
		{
			if(self has_weapon_or_upgrade("raygun_mark2_zm") || maps\mp\zombies\_zm_chugabud::is_weapon_available_in_chugabud_corpse("raygun_mark2_zm", self))
			{
				return 0;
			}
		}
		if(weapon == "raygun_mark2_zm")
		{
			if(self has_weapon_or_upgrade("ray_gun_zm") || maps\mp\zombies\_zm_chugabud::is_weapon_available_in_chugabud_corpse("ray_gun_zm", self))
			{
				return 0;
			}
			if(randomint(100) >= 33)
			{
				return 0;
			}
		}
	}
	return 1;
}

general_weapon_magicbox_check(weapon)
{
	if (isDefined( level.raygun2_included ) && level.raygun2_included)
	{
		if (weapon == "ray_gun_zm")
		{
			if (self has_weapon_or_upgrade("raygun_mark2_zm"))
			{
				return 0;
			}
		}
		if (weapon == "raygun_mark2_zm")
		{
			if (self has_weapon_or_upgrade("ray_gun_zm"))
			{
				return 0;
			}
			if (randomint(100) >= 33)
			{
				return 0;
			}
		}
	}
	return 1;
}

tomb_special_weapon_magicbox_check(weapon)
{
	if ( isDefined( level.raygun2_included ) && level.raygun2_included )
	{
		if ( weapon == "ray_gun_zm" )
		{
			if ( self has_weapon_or_upgrade( "raygun_mark2_zm" ) )
			{
				return 0;
			}
		}
		if ( weapon == "raygun_mark2_zm" )
		{
			if ( self has_weapon_or_upgrade( "ray_gun_zm" ) )
			{
				return 0;
			}
			if ( randomint( 100 ) >= 33 )
			{
				return 0;
			}
		}
	}
	if ( weapon == "beacon_zm" )
	{
		if ( isDefined( self.beacon_ready ) && self.beacon_ready )
		{
			return 1;
		}
		else
		{
			return 0;
		}
	}
	if ( isDefined( level.zombie_weapons[ weapon ].shared_ammo_weapon ) )
	{
		if ( self has_weapon_or_upgrade( level.zombie_weapons[ weapon ].shared_ammo_weapon ) )
		{
			return 0;
		}
	}
	return 1;
}

