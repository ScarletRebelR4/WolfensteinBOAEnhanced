/*
 * Copyright (c) 2015-2021 Tormentor667, Ed the Bat, Ozymandias81, MaxED, Talon1024
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

class TrenchShotgun : NaziWeapon
{
	Default
	{
	//$Category Weapons (BoA)
	//$Title (3) Trench Shotgun
	//$Color 14
	Weapon.SelectionOrder 400;
	Weapon.AmmoType "TrenchShotgunLoaded";
	Weapon.AmmoUse 1;
	Weapon.AmmoType2 "Ammo12Gauge";
	Weapon.AmmoUse2 1;
	Weapon.AmmoGive2 8;
	Weapon.UpSound "SGFOW";
	Inventory.PickupMessage "$TRENSSG";
	+WEAPON.NOAUTOFIRE
	+NaziWeapon.NORAMPAGE
	Scale .5;
	Tag "M1897 Trenchgun";
	}
	States
	{
	Select:
		SGTI A 0 A_Raise;
		SGTI A 1 A_Raise;
		Loop;
	Deselect:
		SGTI A 0 A_JumpIfReloading(3);
		SGTI A 0 A_Lower;
		SGTI A 1 A_Lower;
		Loop;
        SGR3 A 2;
		TNT1 A 0 A_StartSound("SGBAC", CHAN_5);
		SGR3 B 2;
		SGR3 C 2;
		SGR3 D 2;
		TNT1 A 0 A_StartSound("SGFOW", CHAN_6);
		SGR3 E 2;
		SGR3 F 2;
		SGR3 G 2;
		SGR1 H 2;
		SGR1 G 2;
		SGR1 F 2;
		SGR1 E 2;
		SGR1 D 2;
		SGR1 C 2;
		SGR1 B 2;
		SGR1 A 2;
		SGTI A 1 A_Reloading(0);
		Loop;
	Ready:
		SGTI A 0 A_JumpIfInventory("TrenchShotgunLoaded",0,2);
		SGTI A 0 A_JumpIfInventory("Ammo12Gauge",1,2);
		SGTI A 1 A_WeaponReady;
		Loop;
		SGTI A 1 A_WeaponReady(WRF_ALLOWRELOAD);
		Loop;
	Fire:
		SGTI A 0 A_JumpIfReloading("ReloadFinish");
		SGTI A 0 A_JumpIfInventory("TrenchShotgunLoaded",1,1);
		Goto Dryfire;
		SGTI A 0 A_TakeInventory("TrenchShotgunLoaded",1,TIF_NOTAKEINFINITE);
		SGTI A 0 A_StartSound("SGFIR", CHAN_WEAPON);
		SGTI A 0 A_AlertMonsters;
		SGTI B 1;
		SGTI AAAAAAAAAA 0 A_FireProjectile("ShotgunTracer",frandom(-2.0,2.0),0,0,0,0,frandom(-1.5,1.5));
		SGTF A 1 BRIGHT A_GunFlash;
		SGTI A 0 A_JumpIf(waterlevel > 0,2);
		SGTI A 0 A_FireProjectile("ShotSmokeSpawner",0,0,0,random(-4,4),0,0);
		SGTF B 1 BRIGHT A_SetPitch(pitch-(4.0*boa_recoilamount));
		SGTF C 1 Offset(0,40) A_SetPitch(pitch-(2.0*boa_recoilamount));
		SGTF D 1 Offset(0,36) A_SetPitch(pitch-(1.0*boa_recoilamount));
		SGTF E 1 Offset(0,34) A_SetPitch(pitch+(1.0*boa_recoilamount));
		SGTI B 1 A_SetPitch(pitch+(0.5*boa_recoilamount));
		SGTI B 1 A_WeaponReady(WRF_NOFIRE);
        SGPM A 1;
		SGPM B 1;
		SGPM C 1;
		SGPM D 1;
		SGPM E 2;
		SGPM F 2;
		SGPM G 2;
		TNT1 A 0 A_StartSound("SGBAC", CHAN_5);
		SGPM H 2;
		TNT1 A 0 A_SpawnItemEx("ShotgunCasing",12,-20,32,8,random(-2,2),random(0,4),random(-55,-80),SXF_NOCHECKPOSITION);
        SGPM I 2;
		SGPM J 2;
		TNT1 A 0 A_StartSound("SGFOW", CHAN_6);
		SGPM K 2;
		SGPM L 2;
		SGPM M 1;
		SGPM N 1;
		SGPM O 1;
		SGPM P 1;
		SGPM Q 2 A_WeaponReady(WRF_NOBOB);
		SGPM R 2 A_WeaponReady(WRF_NOBOB);
		SGPM S 2 A_WeaponReady(WRF_NOBOB);
		TNT1 A 0 A_CheckReload;
		Goto Ready;
	Reload:
		SGTI A 1 A_Reloading;
        SGR1 A 2;
		SGR1 B 2;
		SGR1 C 2;
		SGR1 D 2;
		SGR1 E 2;
		SGR1 F 2;
		SGR1 G 2;
		SGR1 H 2;
	ReloadLoop:
		SGTI A 0 A_TakeInventory("Ammo12Gauge",1,TIF_NOTAKEINFINITE);
		SGTI A 0 A_GiveInventory("TrenchShotgunLoaded");
		SGR2 A 2;
		SGR2 B 2;
		SGR2 C 2;
		TNT1 A 0 A_StartSound("SGIN", CHAN_5);
		SGR2 D 2;
		SGR2 E 2;
		SGR2 F 2;
		SGR2 G 2;
		SGR2 H 2 A_WeaponReady(WRF_NOBOB|WRF_NOSECONDARY);
		SGTI A 0 A_JumpIfInventory("TrenchShotgunLoaded",0,"ReloadFinish");
		TNT1 A 0 A_JumpIfInventory("Ammo12Gauge",1,"ReloadLoop");
	ReloadFinish:
        SGR3 A 2;
		TNT1 A 0 A_StartSound("SGBAC", CHAN_5);
		SGR3 B 2;
		SGR3 C 2;
		SGR3 D 2;
		TNT1 A 0 A_StartSound("SGFOW", CHAN_6);
		SGR3 E 2;
		SGR3 F 2;
		SGR3 G 2;
		SGR1 H 2;
		SGR1 G 2;
		SGR1 F 2;
		SGR1 E 2;
		SGR1 D 2;
		SGR1 C 2;
		SGR1 B 2;
		SGR1 A 2;
		SGTI A 1 A_Reloading(0);
		Goto Ready;
	Flash:
		TNT1 A 1 A_Light2;
		TNT1 A 1;
		TNT1 A 2 A_Light1;
		Goto LightDone;
	Spawn:
		SHOT A -1;
		Stop;
	}
}

class TrenchShotgunLoaded : Ammo
{
	Default
	{
	Tag "12 Gauge";
	+INVENTORY.IGNORESKILL
	Inventory.MaxAmount 8;
	Inventory.Icon "BROW01";
	}
}