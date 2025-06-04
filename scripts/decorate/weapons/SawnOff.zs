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

class Coachgun : NaziWeapon
{
	Default
	{
	//$Category Weapons (BoA)
	//$Title (3) Trench Shotgun
	//$Color 14
	Weapon.SelectionOrder 400;
	Weapon.SlotNumber 3;
	Weapon.AmmoType "CoachgunLoaded";
	Weapon.AmmoUse 1;
	Weapon.AmmoType2 "Ammo12Gauge";
	Weapon.AmmoUse2 1;
	Weapon.AmmoGive2 8;
	Weapon.UpSound "SSGCLO";
	Inventory.PickupMessage "You got the Sawn-off Coachgun! Pass the whiskey!";
	+WEAPON.NOAUTOFIRE
	+NaziWeapon.NORAMPAGE
	Scale .5;
	Tag "Coachgun";
	}
	States
	{
	Select:
		SSGI A 0 A_Raise;
		SSGI A 1 A_Raise;
		Loop;
	Deselect:
		SSGI A 0 A_Lower;
		SSGI A 1 A_Lower;
		Loop;
	Ready:
		SSGI A 0 A_JumpIfInventory("CoachGunLoaded",0,2);
		SSGI A 0 A_JumpIfInventory("Ammo12Gauge",1,2);
		SSGI A 1 A_WeaponReady;
		Loop;
		SSGI A 1 A_WeaponReady(WRF_ALLOWRELOAD);
		Loop;
	Fire:
		SSGI A 0 A_JumpIfInventory("CoachGunLoaded",2,1);
		Goto Dryfire;
		SSGI A 0 A_TakeInventory("CoachGunLoaded",2,TIF_NOTAKEINFINITE);
		SSGI A 0 A_StartSound("SSGFIR", CHAN_WEAPON);
		SSGI A 0 A_AlertMonsters;
		SSGI A 1;
		SSGI AAAAAAAAAA 0 A_FireProjectile("ShotgunTracer",frandom(-6.0,6.0),0,0,0,0,frandom(-3.5,3.5));
		SSGI AAAAAAAAAA 0 A_FireProjectile("ShotgunTracer",frandom(-6.0,6.0),0,0,0,0,frandom(-3.5,3.5));
		SSGF A 1 BRIGHT A_GunFlash;
		SSGI A 0 A_JumpIf(waterlevel > 0,2);
		SSGI A 0 A_FireProjectile("ShotSmokeSpawner",0,0,0,random(-4,4),0,0);
		SSGF B 1 BRIGHT A_SetPitch(pitch-(6.0*boa_recoilamount));
		SSGF C 1 Offset(0,40) A_SetPitch(pitch-(2.0*boa_recoilamount));
		SSGF D 1 Offset(0,36) A_SetPitch(pitch-(1.0*boa_recoilamount));
		SSGF E 1 Offset(0,34) A_SetPitch(pitch+(1.0*boa_recoilamount));
	    SSGF F 1 A_SetPitch(pitch+(0.5*boa_recoilamount));
		SSGI A 1 A_WeaponReady(WRF_NOFIRE);
		TNT1 A 0 A_CheckReload;
		Goto Ready;
	Reload:
		SSGI A 1;
        SSG1 A 2;
		SSG1 B 2;
		SSG1 C 2;
		SSG1 D 2;
		SSG1 E 2; 
		TNT1 A 0 A_StartSound("SSGOPN", 5);
		SSG1 F 2;
		SSG1 G 2;
		SSG1 H 2;
		SSG1 I 2;
		SSG2 A 2;
		SSG2 B 2;
		SSG2 C 2;
	ReloadLoop:
		SSGI A 0 A_TakeInventory("Ammo12Gauge",1,TIF_NOTAKEINFINITE);
		SSGI A 0 A_GiveInventory("CoachGunLoaded");
		SSGI A 0 A_JumpIfInventory("CoachGunLoaded",0,"ReloadFinish");
		TNT1 A 0 A_JumpIfInventory("Ammo12Gauge",1,"ReloadLoop");
	ReloadFinish:
	    TNT1 A 0 A_StartSound("SSGIN", 5);
	    SSG2 D 2;
		SSG2 E 2;
		SSG2 F 2;
		SSG2 G 2;
		SSG2 H 2;
		SSG3 A 2;
		SSG3 B 2;
		TNT1 A 0 A_StartSound("SSGCLO", 5);
		SSG3 C 2;
		SSG3 D 2;
		SSG3 E 2;
		SSG3 F 2;
		SSG3 G 2;
		SSG3 H 2;
		SSG3 I 2;
		SSG3 J 2;
		SSG3 K 2;
		Goto Ready;
	Flash:
		TNT1 A 1 A_Light2;
		TNT1 A 1;
		TNT1 A 2 A_Light1;
		Goto LightDone;
	Spawn:
		SSGP A -1;
		Stop;
	}
}

class CoachgunLoaded : Ammo
{
	Default
	{
	Tag "12 Gauge";
	+INVENTORY.IGNORESKILL
	Inventory.MaxAmount 2;
	Inventory.Icon "BROW01";
	}
}