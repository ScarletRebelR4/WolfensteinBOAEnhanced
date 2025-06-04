/*
 * Copyright (c) 2015-2021 Tormentor667, Ozymandias81, Ed the Bat, MaxED, Talon1024
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

class Luger9mm : NaziWeapon
{
	Default
	{
	//$Category Weapons (BoA)
	//$Title (2) Luger P08
	//$Color 14
	Scale 0.50;
	Weapon.SelectionOrder 9998;
	Weapon.AmmoType "Luger9mmLoaded";
	Weapon.AmmoUse 1;
	Weapon.AmmoType2 "Ammo9mm";
	Weapon.AmmoUse2 1;
	Weapon.AmmoGive2 8;
	Weapon.UpSound "P08COK";
	Tag "Luger P08";
	Inventory.PickupMessage "$P08LUG";
	+WEAPON.NOAUTOFIRE
	+NaziWeapon.NORAMPAGE
	}
	States
	{
	Ready:
		P08I A 0 A_JumpIfInventory("Luger9mmLoaded",0,2);
		P08I A 0 A_JumpIfInventory("Ammo9mm",1,2);
		P08I A 1 A_WeaponReady;
		Loop;
		P08I A 1 A_WeaponReady(WRF_ALLOWRELOAD);
		Loop;
	Deselect:
		P08I A 0 A_Lower;
		P08I A 1 A_Lower;
		Loop;
	Select:
		P08I A 0 A_Raise;
		P08I A 1 A_Raise;
		Loop;
	Fire:
		P08I A 0 A_JumpIfInventory("Luger9mmLoaded",1,1);
		Goto Dryfire;
		P08I A 0 A_GunFlash;
		P08I A 0 A_SetPitch(pitch-(0.2*boa_recoilamount));
		P08I A 0 A_JumpIf(waterlevel > 0,2);
		P08I A 0 A_FireProjectile("PistolSmokeSpawner",0,0,0,random(-4,4),0,0);
		P08I A 0 A_StartSound("P08FIR", CHAN_WEAPON);
		P08I A 0 A_SpawnItemEx("Casing9mm",12,-20,32,8,random(-2,2),random(0,4),random(-55,-80),SXF_NOCHECKPOSITION);
		P08I A 0 A_AlertMonsters;
		P08F A 1 BRIGHT A_FireProjectile("LugerTracer");
		P08F B 1;
		P08F C 1 A_SetPitch(pitch-(0.2*boa_recoilamount));
		P08F D 1 A_CheckReload;
		P08F E 1 A_WeaponReady(WRF_NOBOB);
		P08I A 1 A_WeaponReady(WRF_NOBOB);
		Goto Ready;
	Reload:
		P081 A 2;
		P081 B 2;
		P081 C 2;
		P081 D 2;
		P081 E 2;
		P081 F 2;
		P081 G 2;
		P081 H 2;
		P081 I 2;
		TNT1 A 0 A_StartSound("P08OUT", CHAN_5);
		P081 J 2;
		P081 K 2;
		P081 L 2;
		P081 M 5;
	ReloadLoop:
		TNT1 A 0 A_TakeInventory("Ammo9mm",1,TIF_NOTAKEINFINITE);
		TNT1 A 0 A_GiveInventory("Luger9mmLoaded");
		TNT1 A 0 A_JumpIfInventory("Luger9mmLoaded",0,"ReloadFinish");
		TNT1 A 0 A_JumpIfInventory("Ammo9mm",1,"ReloadLoop");
	ReloadFinish:
		P082 A 2;
		P082 B 2;
		P082 C 2;
		P082 D 2;
		TNT1 A 0 A_StartSound("P08IN", CHAN_5);
		P082 E 2;
		P082 F 2;
		P082 G 2;
		P082 H 2;
		P082 I 2;
		P082 J 2;
		P083 A 2;
		P083 B 2;
		TNT1 A 0 A_StartSound("P08COK", CHAN_5);
		P083 C 2;
		P083 D 2;
		P083 E 2;
		P083 F 2;
		P083 G 2;
		P083 H 2;
		P083 I 2;
		P083 J 2;
		P083 K 2;
		P083 L 2;
		Goto Ready;
	Flash:
		TNT1 A 1 A_Light2;
		TNT1 A 1;
		TNT1 A 2 A_Light1;
		Goto LightDone;
	Spawn:
		LUGP A -1;
		Stop;
	}
}

class Luger9mmLoaded : Ammo
{
	Default
	{
	Tag "9x19mm";
	+INVENTORY.IGNORESKILL
	Inventory.MaxAmount 8;
	Inventory.Icon "WALT01";
	}
}