//time to tear the balance of a "love letter to COD and MOH" a new asshole.


class NewMauserAmmo : Ammo replaces MauserAmmo
{
	Default
	{
	//$Category Ammo (BoA)
	//$Title Clip (x5 clips)
	//$Color 6
	Scale 0.3;
	Tag "7.92x57mm";
	Inventory.Amount 10;
	Inventory.MaxAmount 200;
	Ammo.BackpackAmount 50;
	Ammo.BackpackMaxAmount 400;
	Inventory.PickupMessage "Clip (x10 Mauser Ammo)";
	Inventory.Icon "MAUS02";
	}
	States
	{
	Spawn:
		792A A -1 NODELAY A_SetScale(Scale.X * RandomPick(-1, 1), Scale.Y);
		Stop;
	}

	override String PickupMessage()
	{
		String msg = StringTable.Localize(Super.PickupMessage());
		msg.Replace("%a", String.Format("%i", amount));

		return msg;
	}
}

class NewMauserAmmoBox : NewMauserAmmo replaces MauserAmmoBox
{
	Default
	{
	//$Category Ammo (BoA)
	//$Title Clipbox (x20 clips)
	//$Color 6
	Scale 0.5;
	Inventory.Amount 40;
	Inventory.PickupMessage "Clipbox (x40 Mauser Ammo)";
	}
	States
	{
	Spawn:
		792A B -1;
		Stop;
	}
}

class NewFlameAmmo : Ammo replaces FlameAmmo
{
	Default
	{
	//$Category Ammo (BoA)
	//$Title Gas (x25 cans)
	//$Color 6
	Tag "$TAGPETRO";
	Inventory.PickupMessage "$FLAMAMMO";
	Inventory.Amount 50;
	Inventory.MaxAmount 300;
	Ammo.BackpackAmount 25;
	Ammo.BackpackMaxAmount 600;
	Scale .5;
	Inventory.Icon "FLAM01";
	}
	States
	{
	Spawn:
		FAMO A -1;
		Stop;
	}

	override String PickupMessage()
	{
		String msg = StringTable.Localize(Super.PickupMessage());
		msg.Replace("%a", String.Format("%i", amount));

		return msg;
	}
}

//new asshole torn.

class Ammo45ACP : Ammo
{
 Default {
	Scale 0.6;
	Tag ".45 ACP";
	Inventory.Amount 40;
	Inventory.MaxAmount 200;
	Ammo.BackpackAmount 100;
	Ammo.BackpackMaxAmount 400;
	Inventory.PickupMessage "Picked up a .45 ACP magazine.";
	Inventory.Icon "FUDD02";
  }	
	States
	{
	Spawn:
		45AM A -1;
		Stop;
	}
	
	override String PickupMessage()
	{
		String msg = StringTable.Localize(Super.PickupMessage());
		msg.Replace("%a", String.Format("%i", amount));

		return msg;
	}	
}

class Ammo45ACPBox : Ammo45ACP
{
 Default
 {
	Inventory.Amount 80;
	Scale .5;
	Inventory.PickupMessage "Picked up a pack of .45 ACP ammo.";
	Inventory.Icon "FUDD02";
  }	
	States
	{
	Spawn:
		45AM B -1;
		Stop;
	}
}


class KurzAmmo : Ammo
{
Default
{
	Tag "7.92x33mm";
	Inventory.Amount 60;
	Inventory.MaxAmount 150;
	Ammo.BackpackAmount 90;
	Ammo.BackpackMaxAmount 270;
	Inventory.PickupMessage "Picked up a box of 7.92x33mm ammo.";
	Inventory.Icon "KURZ01";
	}
	States
	{
	Spawn:
		792K A -1;
		Stop;
	}
}

Class SpringAmmo : Ammo
{
Default
{
	Tag ".30-06";
	Inventory.Amount 16;
	Inventory.MaxAmount 100;
	Ammo.BackpackAmount 24;
	Ammo.BackpackMaxAmount 300;
	Inventory.Icon "GARA02";
	Scale 1;
	Inventory.PickupMessage "Picked up a .30-06 en bloc clip.";
}	
	States
	{
	Spawn:
		M1GA A -1;
		Stop;
	}
}

class SpringAmmoBox : SpringAmmo
{
Default
{
	Inventory.Icon "GARA02";
	Inventory.Amount 40;
	Inventory.PickupMessage "Picked up a box of .30-06 Springfield ammo.";
	Scale 1;
}	
	States
	{
	Spawn:
		M1GA B -1;
		Stop;
	}
}
