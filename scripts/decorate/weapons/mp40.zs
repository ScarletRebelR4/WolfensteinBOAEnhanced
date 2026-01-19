/*
 * Copyright (c) 2015-2021 Tormentor667, Ozymandias81, Ed the Bat, MaxED, AFADoomer
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

class MP40 : NaziWeapon
{
	Default
	{
	//$Category Weapons (BoA)
	//$Title (4) MP40
	//$Color 14
	Scale .5;
	Weapon.SelectionOrder 600;
	Weapon.AmmoType "MP40Loaded";
	Weapon.AmmoUse 1;
	Weapon.AmmoType2 "Ammo9mm";
	Weapon.AmmoUse2 1;
	Weapon.AmmoGive2 32;
	Weapon.UpSound "weapon/SMG/raise";
	Tag "MP 40";
	Inventory.PickupMessage "$MP40";
	Weapon.AmmoGive2 32;
	}
	States
	{
		Ready:
			RIFG A 0 A_JumpIfInventory("MP40Loaded",0,2);
			RIFG A 0 A_JumpIfInventory("Ammo9mm",1,2);
			RIFG A 1 A_WeaponReady;
			Loop;
			RIFG A 1 A_WeaponReady(WRF_ALLOWRELOAD);
			Loop;
		Deselect:
			//TNT1 A 0 A_StartSound("Weapons/C96/Lower", CHAN_AUTO, CHANF_OVERLAP, 1.0);
			M40S ABCDEF 1;
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
			TNT1 A 0 A_StartSound("Weapons/C96/Raise", CHAN_AUTO, CHANF_OVERLAP, 1.0);
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
			TNT1 A 0 A_StartSound("Weapons/C96/Raise", CHAN_AUTO, CHANF_OVERLAP, 1.0);
			M40S FEDCBA 1;
		Ready1:
			TNT1 A 0 A_JumpIf(CountInv("MP40Loaded") == 0, "Ready2");
			M40F A 1 A_WeaponReady(WRF_ALLOWRELOAD);
			Loop;
		Ready2:
			M40F C 1 A_WeaponReady(WRF_ALLOWRELOAD);
			Loop;
		Fire:
			TNT1 A 0 A_JumpIf(CountInv("MP40Loaded") == 0,"DryFire");
			M40F B 1 BRIGHT
			{
				A_GunFlash();
				A_AlertMonsters();
				
				if(waterlevel > 0.2)
				{
					//[Pop] Refactor later with new smoke system
					A_FireProjectile("ShotSmokeSpawner",0,0,0,random(-4,4),0,0);
				}
				A_SpawnItemEx("Casing9mm",12,-20,32,8,random(-2,2),random(0,4),random(-55,-80),SXF_NOCHECKPOSITION);
				//Take Ammo
				
				A_StartSound("weapons/MP40/Fire",CHAN_WEAPON, CHANF_OVERLAP);
				A_StartSound("weapons/MP40/Sweet",CHAN_WEAPON, CHANF_OVERLAP, 0.9);
				A_StartSound("weapons/MP40/Bass",CHAN_WEAPON, CHANF_OVERLAP);
				A_StartSound("weapons/MP40/Mech",CHAN_WEAPON, CHANF_OVERLAP, 0.8);
				A_StartSound("weapons/MP40/Tail",CHAN_WEAPON, CHANF_OVERLAP, 0.65);
				A_FireProjectile("MP40Tracer",frandom(-1.4,1.4));
				A_SetPitch(pitch-(0.5*boa_recoilamount));
			}
			M40F C 1;
			TNT1 A 0 A_JumpIf(CountInv("MP40Loaded") == 0,"Ready2");
			M40F D 1;
			M40F A 1;
			Goto Ready1;
		Reload:
			TNT1 A 0 A_JumpIf(CountInv("Ammo9mm") == 0, "Ready1");
			TNT1 A 0 A_JumpIf(CountInv("MP40Loaded") == 32, "Ready1");
			M40F A 4;
			M40R AB 4;
			TNT1 A 0 A_StartSound("weapons/MP40/Out", CHAN_WEAPON, CHANF_OVERLAP);
			M40R BCD 4;
			M40R D 12;
			TNT1 A 0 A_JumpIf(CountInv("MP40Loaded") > 0, "Reload2");
			M40R D 4;
			TNT1 A 0 A_StartSound("weapons/MP40/Back", CHAN_WEAPON, CHANF_OVERLAP);
			M40R E 4;
			M40R F 18;
			TNT1 A 0 A_StartSound("weapons/MP40/Forward", CHAN_WEAPON, CHANF_OVERLAP);
			M40R E 4;
			M40R D 4;
		Reload2:
			M40R D 4;
			TNT1 A 0 A_StartSound("weapons/MP40/In", CHAN_WEAPON, CHANF_OVERLAP);
			M40R DGB 4;
		ReloadLoop:
			TNT1 A 0 A_TakeInventory("Ammo9mm",1,TIF_NOTAKEINFINITE);
			TNT1 A 0 A_GiveInventory("MP40Loaded");
			TNT1 A 0 A_JumpIfInventory("MP40Loaded",32,"ReloadFinish");
			TNT1 A 0 A_JumpIfInventory("Ammo9mm",1,"ReloadLoop");
		ReloadFinish:
			M40R BA 4;
			M40F A 6;
			Goto Ready1;
		
		Flash:
			TNT1 A 1 A_Light2;
			TNT1 A 1;
			TNT1 A 2 A_Light1;
			Goto LightDone;
		Spawn:
			MP40 A -1;
			Stop;
	}
}

class MP40Loaded : Ammo
{
	Default
	{
	Tag "9x19mm";
	+INVENTORY.IGNORESKILL
	Inventory.MaxAmount 32;
	Inventory.Icon "WALT01";
	}
}
