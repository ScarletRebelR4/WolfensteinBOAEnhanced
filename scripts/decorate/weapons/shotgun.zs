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
	Weapon.UpSound "weapon/shotgun/raise";
	Inventory.PickupMessage "$TRENSSG";
	+WEAPON.NOAUTOFIRE
	+NaziWeapon.NORAMPAGE
	Scale .5;
	Tag "M1897 Trenchgun";
	}
	States
	{
		Deselect:
			TNT1 A 0 A_StartSound("Weapons/C96/Lower", CHAN_AUTO, CHANF_OVERLAP, 1.0);
			TRCS ABCDEF 1;
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
				A_GiveInventory("C96Loaded", 10);
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
			TRCS FEDCBA 1;
		Ready1:
			LUGG A 0 A_JumpIf(CountInv("C96Loaded") == 0, "Ready2");
			TRCA A 1 A_WeaponReady(WRF_ALLOWRELOAD);
			Loop;
		Ready2:
			TRCF G 1 A_WeaponReady(WRF_ALLOWRELOAD);
			Loop;
		SlamFire:
			TNT1 A 0 A_StartSound("SGBAC", CHAN_5);
			TRCB ABC 1;
			TRCB D 2 A_SpawnItemEx("ShotgunCasing",12,-20,32,8,random(-2,2),random(0,4),random(-55,-80),SXF_NOCHECKPOSITION);
			TNT1 A 0 A_StartSound("SGFOW", CHAN_6);
			TRCB EFG 1;
		Fire:
			PPKA A 0 A_JumpIf(CountInv("TrenchShotgunLoaded") == 0,"DryFire");
			TRCF A 1 BRIGHT
			{
				A_GunFlash();
				A_AlertMonsters();
				
				if(waterlevel > 0.2)
				{
					//[Pop] Refactor later with new smoke system
					 A_FireProjectile("ShotSmokeSpawner",0,0,0,random(-4,4),0,0);
				}
				//A_SpawnItemEx("Casing9mm",12,-20,32,8,random(-2,2),random(0,4),random(-55,-80),SXF_NOCHECKPOSITION);
				A_TakeInventory("TrenchShotgunloaded", 1);
				
				A_StartSound("SGFIR", CHAN_AUTO, CHANF_OVERLAP);
				//A_StartSound("Weapons/C96/FireExtra", CHAN_AUTO, CHANF_OVERLAP, 0.8);
				//A_StartSound("Weapons/C96/FireMech", CHAN_AUTO, CHANF_OVERLAP, 1.0);
				//A_StartSound("Weapons/C96/FireAdd", CHAN_AUTO, CHANF_OVERLAP, 0.7);
				
				for(int i=0; i<9; i++)
				{
					A_FireProjectile("ShotgunTracer",frandom(-2.0,2.0),0,0,0,0,frandom(-1.5,1.5));
				}
				
				A_SetPitch(pitch-(5.5*boa_recoilamount));
			}
			TRCF BCDEFG 1;
			TNT1 A 0 A_JumpIf(CountInv("TrenchShotgunLoaded") == 0,"FireEnd");
			TRCF G 1 A_ReFire("SlamFire");
			Goto Pump;
		FireEnd: //Last shot empty
			TRCF GGG 1;
			Goto Ready2;
		
		Pump:
			TRCC ABCDEF 1;
			TNT1 A 0 A_StartSound("SGBAC", CHAN_5);
			TRCC GHHH 1;
			TNT1 A 0 A_SpawnItemEx("ShotgunCasing",12,-20,32,8,random(-2,2),random(0,4),random(-55,-80),SXF_NOCHECKPOSITION);
			TRCC IJ 1;
			TNT1 A 0 A_StartSound("SGFOW", CHAN_6);
			TRCC KLMNOPQRS 1;
			Goto Ready1;
		
		Reload:
			TNT1 A 0 A_JumpIf(CountInv("Ammo12Gauge") == 0, "Ready1");
			TNT1 A 0 A_JumpIf(CountInv("TrenchShotgunLoaded") == 6, "Ready1");
			TNT1 A 0 A_JumpIf(CountInv("TrenchShotgunLoaded") == 0, "Reload2"); //Chamber load
		
			TRCE PONMLKJIH 1;
		ReloadLoop:
			TRCE H 3;
			TRCE ABC 1;
			SGTI A 0 A_TakeInventory("Ammo12Gauge",1,TIF_NOTAKEINFINITE);
			SGTI A 0 A_GiveInventory("TrenchShotgunLoaded");
			TNT1 A 0 A_StartSound("SGIN", CHAN_5);
			TRCE DDDEFGH 1;
			SGTI A 0 A_JumpIfInventory("TrenchShotgunLoaded",6,"ReloadFinish");
			TNT1 A 0 A_JumpIfInventory("Ammo12Gauge",1,"ReloadLoop");
		ReloadFinish:
			TRCE HIJKLMNOP 1;
			Goto Ready1;
			
		Reload2:
			TRCD ABCDEF 1;
			TNT1 A 0 A_StartSound("SGBAC", CHAN_5);
			TRCD GHIJ 1;
			TNT1 A 0 A_SpawnItemEx("ShotgunCasing",12,-20,32,8,random(-2,2),random(0,4),random(-55,-80),SXF_NOCHECKPOSITION);
			TRCD KKKLM 1;
			TNT1 A 0 A_StartSound("SGIN", CHAN_5);
			TRCD NOPQ 1;
			TNT1 A 0 A_StartSound("SGFOW", CHAN_6);
			TRCD RSTUUUUU 1;
			Goto ReloadLoop;
		
		Flash:
			TNT1 A 1 A_Light2;
			TNT1 A 1;
			TNT1 A 2 A_Light1;
			Goto LightDone;
		Spawn:
			TRCP A -1;
			Stop;
	}
}

class TrenchShotgunLoaded : Ammo
{
	Default
	{
	Tag "12 Gauge";
	+INVENTORY.IGNORESKILL
	Inventory.MaxAmount 6;
	Inventory.Icon "BROW01";
	}
}