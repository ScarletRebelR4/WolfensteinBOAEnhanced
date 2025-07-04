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
		LUGG A 0 A_JumpIfInventory("Luger9mmLoaded",0,2);
		LUGG A 0 A_JumpIfInventory("Ammo9mm",1,2);
		LUGG A 1 A_WeaponReady;
		Loop;
		LUGG A 1 A_WeaponReady(WRF_ALLOWRELOAD);
		Loop;
	Deselect:
		LUGG A 0 A_Lower;
		LUGG A 1 A_Lower;
		Loop;
	Select:
		LUGG A 0 A_Raise;
		LUGG A 1 A_Raise;
		Loop;
	Fire:
		LUGG A 0 A_JumpIfInventory("Luger9mmLoaded",1,1);
		Goto Dryfire;
		LUGG A 0 A_GunFlash;
		LUGG A 0 A_SetPitch(pitch-(0.2*boa_recoilamount));
		LUGG A 0 A_JumpIf(waterlevel > 0,2);
		LUGG A 0 A_FireProjectile("PistolSmokeSpawner",0,0,0,random(-4,4),0,0);
		LUGG A 0
		{
			A_StartSound("Weapons/Luger/Fire", CHAN_AUTO, CHANF_OVERLAP, 0.8);
			A_StartSound("Weapons/Luger/FireAdd", CHAN_AUTO, CHANF_OVERLAP, 1.0);
			A_StartSound("Weapons/Luger/FireMech", CHAN_AUTO, CHANF_OVERLAP, 0.9);
		}
		LUGG A 0 A_SpawnItemEx("Casing9mm",12,-20,32,8,random(-2,2),random(0,4),random(-55,-80),SXF_NOCHECKPOSITION);
		LUGG A 0 A_AlertMonsters;
		LUGG C 1 BRIGHT A_FireProjectile("LugerTracer");
		LUGG B 1;
		LUGG B 1 A_SetPitch(pitch-(0.2*boa_recoilamount));
		LUGG A 1 A_CheckReload;
		LUGG A 1 A_WeaponReady(WRF_NOBOB);
		Goto Ready;
	Reload:
		L1GR ABCDEF 1;
		TNT1 A 0 A_StartSound("Weapons/Luger/MagOut", CHAN_AUTO);
		L1GR GHHIJKLMNOOPQR 1;
		TNT1 A 0 A_StartSound("Weapons/Luger/MagIn", CHAN_AUTO);
		L1GR STUU 1;
	ReloadLoop:
		TNT1 A 0 A_TakeInventory("Ammo9mm",1,TIF_NOTAKEINFINITE);
		TNT1 A 0 A_GiveInventory("Luger9mmLoaded");
		TNT1 A 0 A_JumpIfInventory("Luger9mmLoaded",0,"ReloadFinish");
		TNT1 A 0 A_JumpIfInventory("Ammo9mm",1,"ReloadLoop");
	ReloadFinish:
		L1GR VWXYZ 1;
		L2GR AA 1;
		TNT1 A 0 A_StartSound("Weapons/Luger/Charge", CHAN_AUTO);
		L2GR BCDEFGH 1;
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