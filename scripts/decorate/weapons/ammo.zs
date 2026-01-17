/*
 * Copyright (c) 2015-2021 Ed the Bat, Ozymandias81, MaxED, Nash Muhandes,
 *                         AFADoomer, Talon1024
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
**/

class Ammo9mm : Ammo
{
	Default {
	//$Category Ammo (BoA)
	//$Title Ammoclip (x8 clips)
	//$Color 6
	Scale 0.15;
	Tag "9x19mm";
	Inventory.Amount 8;
	Inventory.MaxAmount 256;
	Ammo.BackpackAmount 64;
	Ammo.BackpackMaxAmount 480;
	Inventory.PickupMessage "$9MMAMMO";
	Inventory.Icon "WALT01";
	}
	States
	{
	Spawn:
		9MMA A -1 NODELAY A_SetScale(Scale.X * RandomPick(-1, 1), Scale.Y);
		Stop;
	}

	override String PickupMessage()
	{
		String msg = StringTable.Localize(Super.PickupMessage());
		msg.Replace("%a", String.Format("%i", amount));

		return msg;
	}
}

class Ammo9mm_MP40 : Ammo9mm
{
	Default {
	//$Category Ammo (BoA)
	//$Title MP40Mag (x32 clips)
	//$Color 6
	Scale 0.25;
	Inventory.Amount 32;
	Inventory.PickupMessage "$9MMAMMO";
	Inventory.Icon "WALT01";
	}
	States
	{
	Spawn:
		9MMA B -1 NODELAY A_SetScale(Scale.X * RandomPick(-1, 1), Scale.Y);
		Stop;
	}
}

class AmmoBox9mm : Ammo9mm
{
	Default {
	//$Category Ammo (BoA)
	//$Title Ammobox9mm (x64 clips)
	//$Color 6
	Scale 0.15;
	Inventory.Amount 64;
	Inventory.PickupMessage "$9MMBOX";
	Inventory.Icon "WALT02";
	}
	States
	{
	Spawn:
		9MMA C -1;
		Stop;
	}
}

class Ammo45ACP : Ammo
{
	Default {
	//$Category Ammo (BoA)
	//$Title Ammoclip45ACP (x8 clips)
	//$Color 6
	Scale 0.15;
	Tag ".45 ACP";
	Inventory.Amount 7;
	Inventory.MaxAmount 256;
	Ammo.BackpackAmount 64;
	Ammo.BackpackMaxAmount 480;
	Inventory.PickupMessage "$9MMAMMO";
	Inventory.Icon "WALT01";
	}
	States
	{
	Spawn:
		45AC A -1 NODELAY A_SetScale(Scale.X * RandomPick(-1, 1), Scale.Y);
		Stop;
	}

	override String PickupMessage()
	{
		String msg = StringTable.Localize(Super.PickupMessage());
		msg.Replace("%a", String.Format("%i", amount));

		return msg;
	}
}

class Ammo45ACP_Tommy : Ammo45ACP
{
	Default {
	//$Category Ammo (BoA)
	//$Title Ammo45ACP (x64 clips)
	//$Color 6
	Scale 0.25;
	Inventory.Amount 64;
	Inventory.PickupMessage "$9MMBOX";
	Inventory.Icon "WALT02";
	}
	States
	{
	Spawn:
		45AC B -1;
		Stop;
	}
}

class AmmoBox45ACP : Ammo45ACP
{
	Default {
	//$Category Ammo (BoA)
	//$Title Ammobox45ACP (x64 clips)
	//$Color 6
	Scale 0.15;
	Inventory.Amount 64;
	Inventory.PickupMessage "$9MMBOX";
	Inventory.Icon "WALT02";
	}
	States
	{
	Spawn:
		45AC C -1;
		Stop;
	}
}

class Ammo763Mauser : Ammo
{
	Default {
	//$Category Ammo (BoA)
	//$Title Ammoclip45ACP (x8 clips)
	//$Color 6
	Scale 0.14;
	Tag "7.63x25mm Mauser";
	Inventory.Amount 10;
	Inventory.MaxAmount 120;
	Ammo.BackpackAmount 64;
	Ammo.BackpackMaxAmount 240;
	Inventory.PickupMessage "$9MMAMMO";
	Inventory.Icon "WALT01";
	}
	States
	{
	Spawn:
		763M A -1 NODELAY A_SetScale(Scale.X * RandomPick(-1, 1), Scale.Y);
		Stop;
	}

	override String PickupMessage()
	{
		String msg = StringTable.Localize(Super.PickupMessage());
		msg.Replace("%a", String.Format("%i", amount));

		return msg;
	}
}

class Ammo763Mauser_PPSH : Ammo763Mauser
{
	Default {
	//$Category Ammo (BoA)
	//$Title Ammo45ACP (x64 clips)
	//$Color 6
	Scale 0.22;
	Inventory.Amount 64;
	Inventory.PickupMessage "$9MMBOX";
	Inventory.Icon "WALT02";
	}
	States
	{
	Spawn:
		763M B -1;
		Stop;
	}
}

class AmmoBox763Mauser : Ammo763Mauser
{
	Default {
	//$Category Ammo (BoA)
	//$Title Ammobox45ACP (x64 clips)
	//$Color 6
	Scale 0.15;
	Inventory.Amount 64;
	Inventory.PickupMessage "$9MMBOX";
	Inventory.Icon "WALT02";
	}
	States
	{
	Spawn:
		763M C -1;
		Stop;
	}
}

class Ammo380ACP : Ammo
{
	Default {
	//$Category Ammo (BoA)
	//$Title Ammoclip380ACP (x8 clips)
	//$Color 6
	Scale 0.15;
	Tag ".380 ACP";
	Inventory.Amount 8;
	Inventory.MaxAmount 256;
	Ammo.BackpackAmount 64;
	Ammo.BackpackMaxAmount 480;
	Inventory.PickupMessage "$9MMAMMO";
	Inventory.Icon "WALT01";
	}
	States
	{
	Spawn:
		380A A -1 NODELAY A_SetScale(Scale.X * RandomPick(-1, 1), Scale.Y);
		Stop;
	}

	override String PickupMessage()
	{
		String msg = StringTable.Localize(Super.PickupMessage());
		msg.Replace("%a", String.Format("%i", amount));

		return msg;
	}
}

class Ammo380ACP_Sten : Ammo380ACP
{
	Default {
	//$Category Ammo (BoA)
	//$Title Ammo45ACP (x64 clips)
	//$Color 6
	Scale 0.25;
	Inventory.Amount 32;
	Inventory.PickupMessage "$9MMBOX";
	Inventory.Icon "WALT02";
	}
	States
	{
	Spawn:
		380A B -1;
		Stop;
	}
}

class AmmoBox380ACP : Ammo380ACP
{
	Default {
	//$Category Ammo (BoA)
	//$Title Ammobox45ACP (x64 clips)
	//$Color 6
	Scale 0.5;
	Inventory.Amount 64;
	Inventory.PickupMessage "$9MMBOX";
	Inventory.Icon "WALT02";
	}
	States
	{
	Spawn:
		380A C -1;
		Stop;
	}
}

class Ammo12Gauge : Ammo
{
	Default {
	//$Category Ammo (BoA)
	//$Title Shells (x4 shells)
	//$Color 6
	Scale 0.30;
	Tag "$TAGGAUGE";
	Inventory.PickupMessage "$GAUGAMMO";
	Inventory.Amount 4;
	Inventory.MaxAmount 64;
	Ammo.BackpackAmount 4;
	Ammo.BackpackMaxAmount 128;
	Inventory.Icon "BROW02";
	}
	States
	{
	Spawn:
		12GA A -1 NODELAY A_SetScale(Scale.X * RandomPick(-1, 1), Scale.Y);
		Stop;
	}

	override String PickupMessage()
	{
		String msg = StringTable.Localize(Super.PickupMessage());
		msg.Replace("%a", String.Format("%i", amount));

		return msg;
	}
}

class Ammo12Gauge_Drum : Ammo12Gauge
{
	Default {
	//$Category Ammo (BoA)
	//$Title Autohammer-12 Drum(x12 shells)
	//$Color 6
	Scale 0.25;
	Inventory.Amount 12;
	Inventory.PickupMessage "$GAUGBOX";
	}
	States
	{
	Spawn:
		12GA B -1;
		Stop;
	}
}

class AmmoBox12Gauge : Ammo12Gauge
{
	Default {
	//$Category Ammo (BoA)
	//$Title Shellbox (x20 shells)
	//$Color 6
	Scale 0.25;
	Inventory.Amount 20;
	Inventory.PickupMessage "$GAUGBOX";
	}
	States
	{
	Spawn:
		12GA C -1;
		Stop;
	}
}

class Ammo792Kurz : Ammo
{
	Default
	{
	//$Category Ammo (BoA)
	//$Title Clip (x5 clips)
	//$Color 6
	Scale 0.15;
	Tag "7.92x33mm Kurz";
	Inventory.Amount 20;
	Inventory.MaxAmount 120;
	Ammo.BackpackAmount 40;
	Ammo.BackpackMaxAmount 240;
	Inventory.PickupMessage "$MAUSAMMO";
	Inventory.Icon "MAUS02";
	}
	States
	{
	Spawn:
		792K A -1 NODELAY A_SetScale(Scale.X * RandomPick(-1, 1), Scale.Y);
		Stop;
	}

	override String PickupMessage()
	{
		String msg = StringTable.Localize(Super.PickupMessage());
		msg.Replace("%a", String.Format("%i", amount));

		return msg;
	}
}

class Ammo792Kurz_STG : Ammo792Kurz
{
	Default
	{
	//$Category Ammo (BoA)
	//$Title G43 Mag (x10 clips)
	//$Color 6
	Scale 0.2;
	Inventory.Amount 30;
	Inventory.PickupMessage "$MAUSBOX";
	}
	States
	{
	Spawn:
		792K B -1;
		Stop;
	}
}

class AmmoBox792Kurz : Ammo792Kurz
{
	Default
	{
	//$Category Ammo (BoA)
	//$Title Clipbox (x20 clips)
	//$Color 6
	Scale 0.5;
	Inventory.Amount 50;
	Inventory.PickupMessage "$MAUSBOX";
	}
	States
	{
	Spawn:
		792K C -1;
		Stop;
	}
}

class MauserAmmo : Ammo
{
	Default
	{
	//$Category Ammo (BoA)
	//$Title Clip (x5 clips)
	//$Color 6
	Scale 0.3;
	Tag "7.92x57mm Mauser";
	Inventory.Amount 5;
	Inventory.MaxAmount 150;
	Ammo.BackpackAmount 5;
	Ammo.BackpackMaxAmount 300;
	Inventory.PickupMessage "$MAUSAMMO";
	Inventory.Icon "MAUS02";
	}
	States
	{
	Spawn:
		792M A -1 NODELAY A_SetScale(Scale.X * RandomPick(-1, 1), Scale.Y);
		Stop;
	}

	override String PickupMessage()
	{
		String msg = StringTable.Localize(Super.PickupMessage());
		msg.Replace("%a", String.Format("%i", amount));

		return msg;
	}
}

class MauserAmmo_G43 : MauserAmmo
{
	Default
	{
	//$Category Ammo (BoA)
	//$Title G43 Mag (x10 clips)
	//$Color 6
	Scale 0.25;
	Inventory.Amount 10;
	Inventory.PickupMessage "$MAUSBOX";
	}
	States
	{
	Spawn:
		792M B -1;
		Stop;
	}
}

class MauserAmmo_MG42 : MauserAmmo
{
	Default
	{
	//$Category Ammo (BoA)
	//$Title G43 Mag (x10 clips)
	//$Color 6
	Scale 0.2;
	Inventory.Amount 50;
	Inventory.PickupMessage "$MAUSBOX";
	}
	States
	{
	Spawn:
		792M C -1;
		Stop;
	}
}

class MauserAmmoBox : MauserAmmo
{
	Default
	{
	//$Category Ammo (BoA)
	//$Title Clipbox (x20 clips)
	//$Color 6
	Scale 0.5;
	Inventory.Amount 75;
	Inventory.PickupMessage "$MAUSBOX";
	}
	States
	{
	Spawn:
		792M D -1;
		Stop;
	}
}

class Ammo3006 : Ammo
{
	Default
	{
	//$Category Ammo (BoA)
	//$Title Clip (x5 clips)
	//$Color 6
	Scale 0.1;
	Tag ".30-06 Springfield";
	Inventory.Amount 8;
	Inventory.MaxAmount 100;
	Ammo.BackpackAmount 8;
	Ammo.BackpackMaxAmount 200;
	Inventory.PickupMessage "$MAUSAMMO";
	Inventory.Icon "MAUS02";
	}
	States
	{
	Spawn:
		3006 A -1 NODELAY A_SetScale(Scale.X * RandomPick(-1, 1), Scale.Y);
		Stop;
	}

	override String PickupMessage()
	{
		String msg = StringTable.Localize(Super.PickupMessage());
		msg.Replace("%a", String.Format("%i", amount));

		return msg;
	}
}

class Ammo3006_BAR : Ammo3006
{
	Default
	{
	//$Category Ammo (BoA)
	//$Title G43 Mag (x10 clips)
	//$Color 6
	Scale 0.2;
	Inventory.Amount 20;
	Inventory.PickupMessage "$MAUSBOX";
	}
	States
	{
	Spawn:
		3006 B -1;
		Stop;
	}
}

class AmmoBox3006 : Ammo3006
{
	Default
	{
	//$Category Ammo (BoA)
	//$Title G43 Mag (x10 clips)
	//$Color 6
	Scale 0.5;
	Inventory.Amount 60;
	Inventory.PickupMessage "$MAUSBOX";
	}
	States
	{
	Spawn:
		3006 C -1;
		Stop;
	}
}

class Ammo842Thalberg : Ammo
{
	Default
	{
	//$Category Ammo (BoA)
	//$Title Clip (x5 clips)
	//$Color 6
	Scale 0.3;
	Tag "8.42x60mm Thalberg";
	Inventory.Amount 30;
	Inventory.MaxAmount 200;
	Ammo.BackpackAmount 60;
	Ammo.BackpackMaxAmount 400;
	Inventory.PickupMessage "$MAUSAMMO";
	Inventory.Icon "MAUS02";
	}
	States
	{
	Spawn:
		842T A -1 NODELAY A_SetScale(Scale.X * RandomPick(-1, 1), Scale.Y);
		Stop;
	}

	override String PickupMessage()
	{
		String msg = StringTable.Localize(Super.PickupMessage());
		msg.Replace("%a", String.Format("%i", amount));

		return msg;
	}
}

class AmmoBox842Thalberg : Ammo842Thalberg
{
	Default
	{
	//$Category Ammo (BoA)
	//$Title Clipbox (x20 clips)
	//$Color 6
	Scale 0.5;
	Inventory.Amount 100;
	Inventory.PickupMessage "$MAUSBOX";
	}
	States
	{
	Spawn:
		842T B -1;
		Stop;
	}
}

class FlameAmmo : Ammo
{
	Default
	{
	//$Category Ammo (BoA)
	//$Title Gas (x25 cans)
	//$Color 6
	Tag "$TAGPETRO";
	Inventory.PickupMessage "$FLAMAMMO";
	Inventory.Amount 25;
	Inventory.MaxAmount 175;
	Ammo.BackpackAmount 25;
	Ammo.BackpackMaxAmount 350;
	Scale 0.5;
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

class NebAmmo : Ammo
{
	Default
	{
	//$Category Ammo (BoA)
	//$Title Nebelrounds (x5 rounds)
	//$Color 6
	Scale 0.47;
	Tag "$TAGMINIR";
	Inventory.Amount 5;
	Inventory.MaxAmount 100;
	Ammo.BackpackAmount 10;
	Ammo.BackpackMaxAmount 150;
	Inventory.PickupMessage "$NEBWAMMO";
	Inventory.Icon "NEBE01";
	}
	States
	{
	Spawn:
		MNRB A -1;
		Stop;
	}

	override String PickupMessage()
	{
		String msg = StringTable.Localize(Super.PickupMessage());
		msg.Replace("%a", String.Format("%i", amount));

		return msg;
	}
}

class NebAmmoBox : NebAmmo
{
	Default
	{
	//$Category Ammo (BoA)
	//$Title Nebelbox (x10 rounds)
	//$Color 6
	Scale 0.63;
	Inventory.Amount 10;
	Inventory.PickupMessage "$NEBWBOX";
	}
	States
	{
	Spawn:
		MNRB B -1;
		Stop;
	}
}

class PanzerAmmo : Ammo
{
	Default
	{
	//$Category Ammo (BoA)
	//$Title Panzerschreck Rocket (x5 rockets)
	//$Color 6
	Tag "$TAGROCKT";
	Inventory.MaxAmount 5;
	Inventory.PickupMessage "$PANZAMMO";
	Ammo.BackpackAmount 1;
	Ammo.BackpackMaxAmount 10;
	Inventory.Icon "PANZ01";
	Scale .25;
	}
	States
	{
	Spawn:
		PANA A -1;
		Stop;
	}
}

class TeslaCell : Ammo
{
	Default
	{
	//$Category Ammo (BoA)
	//$Title Tesla Cell (x10 cell charges)
	//$Color 6
	Tag "$TAGTCELL";
	Inventory.PickupMessage "$TESLAMMO";
	Inventory.Amount 10;
	Inventory.MaxAmount 200;
	Ammo.BackpackAmount 20;
	Ammo.BackpackMaxAmount 200;
	Inventory.Icon "TESL01";
	}
	States
	{
	Spawn:
		TCEL B -1;
		Stop;
	}

	override String PickupMessage()
	{
		String msg = StringTable.Localize(Super.PickupMessage());
		msg.Replace("%a", String.Format("%i", amount));

		return msg;
	}
}

class TeslaCellBox : TeslaCell
{
	Default
	{
	//$Title Tesla Cell (x50 cell charges)
	Inventory.Amount 50;
	Inventory.PickupMessage "$TESLABOX";
	}
	States
	{
	Spawn:
		TCEL A -1;
		Stop;
	}
}

class TurretBulletAmmo : Ammo
{
	Default
	{
	Inventory.Amount 1;
	Inventory.MaxAmount 1;
	Inventory.Icon "WALT01";
	}
}

class TurretHeatAmmo : Ammo
{
	Default
	{
	Inventory.Amount 1;
	Inventory.MaxAmount 100;
	Inventory.Icon "HEAT01";
	}
}





//[Pop] Gonna put ammo spawners down here! These are going to replace preplaced
//ammo pickups as well as what is spawned from goodie boxes! Maybe we should
//consider making goodiebox spawners and map placed spawners separate? That way
//goodieboxes can have higher chances of the unique ammo, and it doesnt screw
//with normal ammo economy as much?

class Spawner_LowCal : RandomSpawner
{
	Default
	{
		DropItem "Ammo9mm", 255, 8;
		DropItem "Ammo9mm_mp40", 255, 8;
		DropItem "Ammo763mauser", 255, 6;
		DropItem "Ammo763mauser_ppsh", 255, 6;
		DropItem "Ammo45ACP", 255, 2;
		DropItem "Ammo45ACP_tommy", 255, 2;
		DropItem "Ammo380ACP", 255, 2;
		DropItem "Ammo380ACP_Sten", 255, 2;
	}
}

class Spawner_LowCalBox : RandomSpawner
{
	Default
	{
		DropItem "AmmoBox9mm", 255, 8;
		DropItem "AmmoBox763mauser", 255, 6;
		DropItem "AmmoBox45ACP", 255, 2;
		DropItem "AmmoBox380ACP", 255, 2;
	}
}

class Spawner_LowCalGoodie : RandomSpawner
{
	Default
	{
		DropItem "Ammo9mm", 255, 2;
		DropItem "Ammo9mm_mp40", 255, 2;
		DropItem "Ammo763mauser", 255, 3;
		DropItem "Ammo763mauser_ppsh", 255, 3;
		DropItem "Ammo45ACP", 255, 4;
		DropItem "Ammo45ACP_tommy", 255, 4;
		DropItem "Ammo380ACP", 255, 4;
		DropItem "Ammo380ACP_Sten", 255, 4;
	}
}

class Spawner_Shell : RandomSpawner
{
	Default
	{
		DropItem "Ammo12Gauge", 255, 8;
		DropItem "Ammo12Gauge_drum", 255, 8;
		DropItem "Ammo3006", 255, 6;
		DropItem "Ammo3006_BAR", 255, 6;
	}
}

class Spawner_ShellBox : RandomSpawner
{
	Default
	{
		DropItem "AmmoBox12Gauge", 255, 8;
		DropItem "AmmoBox3006", 255, 6;
	}
}

class Spawner_ShellGoodie : RandomSpawner
{
	Default
	{
		DropItem "Ammo12Gauge", 255, 8;
		DropItem "Ammo12Gauge_drum", 255, 8;
	}
}

class Spawner_HighCal : RandomSpawner
{
	Default
	{
		DropItem "MauserAmmo", 255, 8;
		DropItem "MauserAmmo_G43", 255, 8;
		DropItem "MauserAmmo_MG42", 255, 8;
		DropItem "Ammo792Kurz", 255, 6;
		DropItem "Ammo792Kurz_STG", 255, 6;
		DropItem "Ammo3006", 255, 2;
		DropItem "Ammo3006_BAR", 255, 2;
	}
}

class Spawner_HighCalBox : RandomSpawner
{
	Default
	{
		DropItem "MauserAmmoBox", 255, 8;
		DropItem "AmmoBox792Kurz", 255, 6;
		DropItem "AmmoBox3006", 255, 2;
	}
}

class Spawner_HighCalGoodie : RandomSpawner
{
	Default
	{
		DropItem "MauserAmmo", 255, 2;
		DropItem "MauserAmmo_G43", 255, 2;
		DropItem "MauserAmmo_MG42", 255, 2;
		DropItem "Ammo792Kurz", 255, 3;
		DropItem "Ammo792Kurz_STG", 255, 3;
		DropItem "Ammo3006", 255, 4;
		DropItem "Ammo3006_BAR", 255, 4;
	}
}