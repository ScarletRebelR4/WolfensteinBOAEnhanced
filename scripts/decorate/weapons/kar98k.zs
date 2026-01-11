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
	Weapon.UpSound "weapon/Sniper/raise";
	Inventory.PickupMessage "$Kar98k";
	Weapon.SelectionOrder 750;
	+WEAPON.NOAUTOFIRE
	+NaziWeapon.NORAMPAGE
	Tag "Karabiner 98k";
	}
	States
	{
		Deselect:
			TNT1 A 0 A_StartSound("Weapons/Kar98k/Lower", CHAN_AUTO, CHANF_OVERLAP, 1.0);
			K98D ABCDEF 1;
			TNT1 A 0 A_Lower();
			Wait;
		Select:
			TNT1 A 0 A_JumpIf(!invoker.firstPickup, "FirstSelect");
			TNT1 A 0 A_Raise();
			Wait;
		FirstSelect:
			TNT1 A 0 A_Raise();
			Wait;
		FirstReady: //First Time Select
			TNT1 A 0 A_StartSound("Weapons/Kar98k/Raise", CHAN_AUTO, CHANF_OVERLAP, 1.0);
			C96I ABCDE 1;
			C96I E 4;
			C96F TUVWXYZ 1;
			TNT1 A 0
			{
				invoker.firstPickup = true;
			}
			TNT1 A 0 A_StartSound("Weapons/C96/Slap", CHAN_AUTO, CHANF_OVERLAP, 1.0);
			C96G A 1;
			TNT1 A 0 A_StartSound("Weapons/C96/BoltClose", CHAN_AUTO, CHANF_OVERLAP, 1.0);
			C96G BCDEFGHIJKLMN 1;
			Goto Ready1;
		Ready:
			TNT1 A 0 A_JumpIf(!invoker.firstPickup, "FirstReady");
			TNT1 A 0 A_StartSound("Weapons/Kar98k/Raise", CHAN_AUTO, CHANF_OVERLAP, 1.0);
			K98D FEDCBA 1;
		Ready1:
			TNT1 A 0 A_JumpIfInventory("SniperZoom",1,"ScopedReady");
			TNT1 A 0 A_JumpIf(CountInv("Kar98kLoaded") == 0, "Ready2");
			K98F A 1 A_WeaponReady(WRF_ALLOWRELOAD);
			Loop;
		Ready2:
			K98F C 1 A_WeaponReady(WRF_ALLOWRELOAD);
			Loop;
		ScopedReady:
			K98S A 1 A_WeaponReady(WRF_ALLOWRELOAD);
			Loop;
		Fire:
			TNT1 A 0 A_JumpIf(CountInv("Kar98kLoaded") == 0,"DryFire");
			TNT1 A 0 A_JumpIfInventory("SniperZoom", 1, "ScopedFire");
			K98F B 2 BRIGHT
			{
				A_GunFlash();
				A_AlertMonsters();
				
				if(waterlevel > 0.2)
				{
					//[Pop] Refactor later with new smoke system
					A_FireProjectile("ShotSmokeSpawner",0,0,0,random(-4,4),0,0);
				}
				//[Pop] no casing this time!
				
				A_StartSound("weapons/Kar98k/Fire", CHAN_WEAPON, CHANF_OVERLAP);
				A_StartSound("weapons/Kar98k/Mech", CHAN_WEAPON, CHANF_OVERLAP, 0.8);
				A_StartSound("weapons/Kar98k/SweetHi", CHAN_WEAPON, CHANF_OVERLAP, 0.7, ATTN_NORM, frandom(0.7,0.8));
				A_StartSound("weapons/Kar98k/SweetLo", CHAN_WEAPON, CHANF_OVERLAP, 0.9);
				A_StartSound("weapons/Kar98k/Bass", CHAN_WEAPON, CHANF_OVERLAP);
				A_FireProjectile("Kar98kTracer");
				A_SetPitch(pitch-(2.0*boa_recoilamount));
			}
			K98F C 4;
			TNT1 A 0 A_JumpIf(CountInv("Kar98kLoaded") == 0,"Ready2");
			K98F C 2;
			K98R A 2;
			TNT1 A 0 A_StartSound("weapons/kar98k/boltup",CHAN_WEAPON, CHANF_OVERLAP);
			K98R BC 2;
			TNT1 A 0 A_StartSound("weapons/kar98k/boltback",CHAN_WEAPON, CHANF_OVERLAP);
			K98R DEF 2;
			TNT1 A 0 A_SpawnItemEx("MauserRifleCasing",12,-20,32,8,random(-2,2),random(0,4),random(-55,-80),SXF_NOCHECKPOSITION);
			K98R F 4;
			TNT1 A 0 A_StartSound("weapons/kar98k/boltforward",CHAN_WEAPON, CHANF_OVERLAP);
			K98R FED 2;
			TNT1 A 0 A_StartSound("weapons/kar98k/boltdown",CHAN_WEAPON, CHANF_OVERLAP);
			K98R CBA 2;
			K98F A 2;
			Goto Ready1;
		ScopedFire:
			K98S B 2 BRIGHT
			{
				A_GunFlash();
				A_AlertMonsters();
				
				if(waterlevel > 0.2)
				{
					//[Pop] Refactor later with new smoke system
					A_FireProjectile("ShotSmokeSpawner",0,0,0,random(-4,4),0,0);
				}
				//[Pop] no casing this time!
				
				A_StartSound("weapons/Kar98k/Fire", CHAN_WEAPON, CHANF_OVERLAP);
				A_StartSound("weapons/Kar98k/Mech", CHAN_WEAPON, CHANF_OVERLAP, 0.8);
				A_StartSound("weapons/Kar98k/SweetHi", CHAN_WEAPON, CHANF_OVERLAP, 0.7, ATTN_NORM, frandom(0.7,0.8));
				A_StartSound("weapons/Kar98k/SweetLo", CHAN_WEAPON, CHANF_OVERLAP, 0.9);
				A_StartSound("weapons/Kar98k/Bass", CHAN_WEAPON, CHANF_OVERLAP);
				A_FireProjectile("Kar98kTracer");
				A_SetPitch(pitch-(4.0*boa_recoilamount));
			}
			K98S A 4;
			TNT1 A 0 A_JumpIf(CountInv("Kar98kLoaded") == 0,"Ready2");
			K98S A 4;
			TNT1 A 0 A_StartSound("weapons/kar98k/boltup",CHAN_WEAPON, CHANF_OVERLAP);
			K98S A 4;
			TNT1 A 0 A_StartSound("weapons/kar98k/boltback",CHAN_WEAPON, CHANF_OVERLAP);
			K98S A 4;
			K98I A 0 A_SpawnItemEx("MauserRifleCasing",12,-20,32,8,random(-2,2),random(0,4),random(-55,-80),SXF_NOCHECKPOSITION);
			K98S A 4;
			TNT1 A 0 A_StartSound("weapons/kar98k/boltforward",CHAN_WEAPON, CHANF_OVERLAP);
			K98S A 6;
			TNT1 A 0 A_StartSound("weapons/kar98k/boltdown",CHAN_WEAPON, CHANF_OVERLAP);
			K98S A 8;
			Goto ScopedReady;
			
		Flash:
			TNT1 A 1 A_Light2;
			TNT1 A 1;
			TNT1 A 2 A_Light1;
			Goto LightDone;
			
		AltFire:
			SCO1 A 0 A_JumpIfInventory("SniperZoom",1,"ZoomOut");
			SCO1 A 0 A_StartSound("mauser/scope");
			SCO1 A 0 A_GiveInventory("SniperZoom");
			K98S A 3 A_ZoomFactor(12.0);
			Goto ScopedReady;
		ZoomOut:
			SCO1 A 0 A_TakeInventory("SniperZoom");
			SCO1 A 0 A_StartSound("mauser/scope");
			K98S A 3 A_ZoomFactor(1.0);
			Goto Ready1;
		Reload:
			TNT1 A 0 A_JumpIf(CountInv("MauserAmmo") == 0, "Ready1");
			TNT1 A 0 A_JumpIf(CountInv("Kar98kLoaded") == 5, "Ready1");
			SCO1 A 0 A_JumpIf(CountInv("SniperZoom") == 0,"ReloadStart");
			SCO1 A 0 A_TakeInventory("SniperZoom");
			SCO1 A 0 A_StartSound("mauser/scope");
			SCO1 A 3 A_ZoomFactor(1.0);
		ReloadStart:
			K98F C 2;
			K98R A 2;
			TNT1 A 0 A_StartSound("weapons/kar98k/boltup",CHAN_WEAPON, CHANF_OVERLAP);
			K98R BC 2;
			TNT1 A 0 A_StartSound("weapons/kar98k/boltback",CHAN_WEAPON, CHANF_OVERLAP);
			K98R DEF 2;
			K98R GH 2;
		ReloadLoop:
			K98R IJ 2;
			TNT1 A 0 A_StartSound("Weapons/Kar98k/Load",CHAN_WEAPON, CHANF_OVERLAP);
			K98R KL 2;
			TNT1 A 0 A_TakeInventory("MauserAmmo",1,TIF_NOTAKEINFINITE);
			TNT1 A 0 A_GiveInventory("Kar98kLoaded");
			K98R KJI 2;
			TNT1 A 0 A_JumpIfInventory("Kar98kLoaded",5,"ReloadEnd");
			TNT1 A 0 A_JumpIfInventory("MauserAmmo",1,"ReloadLoop");
		ReloadEnd:
			K98R H 2;
			K98R F 4;
			TNT1 A 0 A_StartSound("weapons/kar98k/boltforward",CHAN_WEAPON, CHANF_OVERLAP);
			K98R FED 2;
			TNT1 A 0 A_StartSound("weapons/kar98k/boltdown",CHAN_WEAPON, CHANF_OVERLAP);
			K98R CBA 2;
			K98F A 2;
			Goto Ready1;
		Spawn:
			K98P A -1;
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