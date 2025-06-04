/*
 * Copyright (c) 2015-2021 Ed the Bat, Ozymandias81, MaxED, Talon1024
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

class Kar98k : NaziWeapon
{
	Default
	{
	//$Category Weapons (BoA)
	//$Title (5) Karabiner 98k
	//$Color 14
	Scale 0.45;
	Weapon.AmmoType "Kar98kLoaded";
	Weapon.AmmoUse 1;
	Weapon.AmmoType2 "MauserAmmo";
	Weapon.AmmoUse2 1;
	Weapon.AmmoGive2 5;
	Weapon.UpSound "K98FOW";
	Inventory.PickupMessage "$Kar98k";
	Weapon.SelectionOrder 750;
	+WEAPON.NOAUTOFIRE
	+NaziWeapon.NORAMPAGE
	Tag "Karabiner 98k";
	}
	States
	{
	Ready:
		K98I A 0 A_JumpIfInventory("SniperZoom",1,"ScopedReady");
		K98I A 0 A_JumpIfInventory("Kar98kLoaded",0,2);
		K98I A 0 A_JumpIfInventory("MauserAmmo",1,2);
		K98I A 1 A_WeaponReady;
		Loop;
		K98I A 1 A_WeaponReady(WRF_ALLOWRELOAD);
		Loop;
	ScopedReady:
		SCO1 A 0 A_JumpIfInventory("Kar98kLoaded",0,2);
		SCO1 A 0 A_JumpIfInventory("MauserAmmo",1,2);
		SCO1 A 1 A_WeaponReady(WRF_NOBOB);
		Goto Ready;
		SCO1 A 1 A_WeaponReady(WRF_NOBOB|WRF_ALLOWRELOAD);
		Goto Ready;
	Select:
		K98I A 0 A_Raise;
		K98I A 1 A_Raise;
		Loop;
	Deselect:
		K98I A 0 A_JumpIfReloading(4);
		K98I A 0 A_JumpIfInventory("SniperZoom",1,"ScopedDeselect");
		K98I A 0 A_Lower;
		K98I A 1 A_Lower;
		Loop;
	    K983 A 2;
		K983 B 2;
		TNT1 A 0 A_StartSound("K98FOW",5);
		K983 C 2;
		K983 D 2;
		TNT1 A 0 A_StartSound("K98DOW",5);
		K983 E 2;
		K983 F 2;
		K983 G 2;
		K983 H 2;
		K983 I 2;
		K983 J 2 A_Reloading(0);
		Loop;
	ScopedDeselect:
		SCO1 A 0 A_TakeInventory("SniperZoom");
		SCO1 A 0 A_StartSound("mauser/scope");
		SCO1 A 1 A_ZoomFactor(1.0);
		Goto Deselect;
	Fire:
		K98I A 0 A_JumpIfReloading("ReloadEnd");
		K98I A 0 A_JumpIfInventory("Kar98kLoaded",1,1);
		Goto Dryfire;
		K98I A 0 A_AlertMonsters;
		K98I A 0 A_StartSound("K98FIR", CHAN_WEAPON);
		K98I A 0 A_JumpIfInventory("SniperZoom", 1, "ScopedFire");
		K98I A 0 A_GunFlash;
		K98F A 1 BRIGHT A_FireProjectile("Kar98kTracer");
		K98I A 0 A_JumpIf(waterlevel > 0,2);
		K98I A 0 A_FireProjectile("ShotSmokeSpawner",0,0,0,random(-4,4),0,0);
		K98F B 2 Offset(0,40) A_SetPitch(pitch-(4.0*boa_recoilamount));
		K98F C 1 Offset(0,36) A_SetPitch(pitch-(2.0*boa_recoilamount));
		K98F D 1 Offset(0,32)A_SetPitch(pitch+(1.0*boa_recoilamount));
		K98F E 1 A_SetPitch(pitch+(1.0*boa_recoilamount));
		K98F F 1 A_SetPitch(pitch+(0.5*boa_recoilamount));
	    K98C A 2;
		K98C B 2;
		K98C C 2;
		K98C D 2;
		TNT1 A 0 A_StartSound("K98UP",5);
		K98C E 2;
		K98C F 2;
		TNT1 A 0 A_StartSound("K98BAC",5);
		K98I A 0 A_SpawnItemEx("MauserRifleCasing",12,-20,32,8,random(-2,2),random(0,4),random(-55,-80),SXF_NOCHECKPOSITION);
		K98C G 2;
		K98C H 2;
		K98C I 2;
		K98C J 2;
		TNT1 A 0 A_StartSound("K98FOW",5);
		K98C K 2;
		TNT1 A 0 A_StartSound("K98DOW",5);
		K98C L 2;
		K98C M 2;
		K98C N 2;
		K98C O 2;
		K98C P 2;
		K98C Q 2;
		K98I A 1 A_CheckReload;
		Goto Ready;
	ScopedFire:
		SCO1 A 2 A_FireProjectile("Kar98kTracer2");
		SCO1 A 0 A_JumpIf(height<=30,"ScopedFireLowRecoil");
		SCO1 A 0 A_JumpIf(waterlevel > 0,2);
		SCO1 A 0 A_FireProjectile("ShotSmokeSpawner",0,0,0,random(-4,4),0,0);
		SCO1 A 2 A_SetPitch(pitch-(4.0*boa_recoilamount));
		SCO1 A 1 A_SetPitch(pitch-(2.0*boa_recoilamount));
		SCO1 A 1 A_SetPitch(pitch+(1.0*boa_recoilamount));
		SCO1 A 3 A_SetPitch(pitch+(1.0*boa_recoilamount));
		SCO1 A 1 A_SetPitch(pitch+(0.5*boa_recoilamount));
		SCO1 A 8;
		TNT1 A 0 A_StartSound("K98UP",5);
		SCO1 A 4;
		TNT1 A 0 A_StartSound("K98BAC",5);
		K98I A 0 A_SpawnItemEx("MauserRifleCasing",12,-20,32,8,random(-2,2),random(0,4),random(-55,-80),SXF_NOCHECKPOSITION);
		SCO1 A 8;
		TNT1 A 0 A_StartSound("K98FOW",5);
		SCO1 A 2;
		TNT1 A 0 A_StartSound("K98DOW",5);
		SCO1 A 1 A_CheckReload;
		Goto Ready;
	ScopedFireLowRecoil:
		SCO1 A 0 A_JumpIf(waterlevel > 0,2);
		SCO1 A 0 A_FireProjectile("ShotSmokeSpawner",0,0,0,random(-4,4),0,0);
		SCO1 A 2 A_SetPitch(pitch-(2.0*boa_recoilamount));
		SCO1 A 1 A_SetPitch(pitch-(1.0*boa_recoilamount));
		SCO1 A 1 A_SetPitch(pitch+(0.5*boa_recoilamount));
		SCO1 A 3 A_SetPitch(pitch+(0.5*boa_recoilamount));
		SCO1 A 1 A_SetPitch(pitch+(0.25*boa_recoilamount));
		SCO1 A 8;
		TNT1 A 0 A_StartSound("K98UP",5);
		SCO1 A 4;
		TNT1 A 0 A_StartSound("K98BAC",5);
		K98I A 0 A_SpawnItemEx("MauserRifleCasing",12,-20,32,8,random(-2,2),random(0,4),random(-55,-80),SXF_NOCHECKPOSITION);
		SCO1 A 8;
		TNT1 A 0 A_StartSound("K98FOW",5);
		SCO1 A 2;
		TNT1 A 0 A_StartSound("K98DOW",5);
		SCO1 A 1 A_CheckReload;
		Goto Ready;
	Flash:
		TNT1 A 1 A_Light2;
		TNT1 A 1;
		TNT1 A 2 A_Light1;
		Goto LightDone;
	AltFire:
		K98I A 0 A_JumpIfReloading("ReloadEnd");
		SCO1 A 0 A_JumpIfInventory("SniperZoom",1,"ZoomOut");
		SCO1 A 0 A_StartSound("mauser/scope");
		SCO1 A 0 A_GiveInventory("SniperZoom");
		SCO1 A 3 A_ZoomFactor(12.0);
		Goto Ready;
	ZoomOut:
		SCO1 A 0 A_TakeInventory("SniperZoom");
		SCO1 A 0 A_StartSound("mauser/scope");
		SCO1 A 3 A_ZoomFactor(1.0);
		Goto Ready;
	Reload:
		SCO1 A 0 A_Reloading;
		SCO1 A 0 A_JumpIfInventory("SniperZoom",1,2);
		SCO1 A 0 A_Jump(256,4);
		SCO1 A 0 A_TakeInventory("SniperZoom");
		SCO1 A 0 A_StartSound("mauser/scope");
		SCO1 A 3 A_ZoomFactor(1.0);
	    K981 A 2;
		K981 B 2;
		K981 C 2;
		K981 D 2;
		K981 E 2;
		K981 F 2;
		K981 G 2;
		K981 H 2;
		K981 I 2;
		TNT1 A 0 A_StartSound("K98UP",5);
		K981 J 2;
		K981 K 2;
		K981 L 2;
		TNT1 A 0 A_StartSound("K98BAC",5);
		K981 M 2;
		K981 N 2;
		K981 O 2;
		K981 P 2;
		K981 Q 2;
	ReloadLoop:
		TNT1 A 0 A_TakeInventory("MauserAmmo",1,TIF_NOTAKEINFINITE);
		TNT1 A 0 A_GiveInventory("Kar98kLoaded");
        K982 A 2;
		K982 B 2;
		K982 C 2;
		K982 D 2;
		K982 E 2;
		TNT1 A 0 A_StartSound("K98IN",5);
		K982 F 2;
		K982 G 2;
		K982 H 2;
		K982 I 2;
		K982 J 2;
		K982 J 1 A_WeaponReady(WRF_NOBOB);
		TNT1 A 0 A_JumpIfInventory("Kar98kLoaded",0,"ReloadEnd");
		TNT1 A 0 A_JumpIfInventory("MauserAmmo",1,"ReloadLoop");
	ReloadEnd:
	    K983 A 2;
		K983 B 2;
		TNT1 A 0 A_StartSound("K98FOW",5);
		K983 C 2;
		K983 D 2;
		TNT1 A 0 A_StartSound("K98DOW",5);
		K983 E 2;
		K983 F 2;
		K983 G 2;
		K983 H 2;
		K983 I 2;
		K983 J 2 A_Reloading(0);
		Goto Ready;
	Spawn:
		K98K A -1;
		Stop;
	}
}

class SniperZoom : Inventory{}

class Kar98kLoaded : Ammo
{
	Default
	{
	Tag "7.92x57mm";
	+INVENTORY.IGNORESKILL
	Inventory.MaxAmount 5;
	Inventory.Icon "MAUS01";
	}
}