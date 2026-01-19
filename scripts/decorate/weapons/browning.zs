/*
 * Copyright (c) 2017-2021 Tormentor667, Ozymandias81, Ed the Bat, MaxED, Talon1024,
 *                         AFADoomer
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

class Browning5 : NaziWeapon
{
	Default
	{
	//$Category Weapons (BoA)
	//$Title (3) Browning
	//$Color 14
	Weapon.SelectionOrder 400;
	Weapon.AmmoUse 1;
	Weapon.AmmoType "Browning5Loaded";
	Weapon.AmmoType2 "Ammo12Gauge";
	Weapon.AmmoUse2 1;
	Weapon.AmmoGive2 10;
	Weapon.UpSound "weapon/shotgun/raise";
	Scale .5;
	Inventory.PickupMessage "$BROWNING";
	Tag "Browning Auto-5";
	+WEAPON.NOAUTOFIRE
	+NaziWeapon.NORAMPAGE
	}
	States
	{
		Deselect:
			TNT1 A 0 A_StartSound("weapons/ba5/Lower", CHAN_WEAPON, CHANF_OVERLAP);
			BA5S ABCDEF 1;
			BA5G A 0 A_Lower;
			Wait;
		Select:
			TNT1 A 0; //A_JumpIf(!invoker.firstPickup, "FirstSelect");
			TNT1 A 0 A_Raise();
			Wait;
		FirstSelect:
			TNT1 A 0 A_Raise();
			Wait;
		FirstReady: //First Time Select
			//[Pop] no animatino for the Auto5 yet, BUT this is still needed
			//so we can make sure to set the ammo in mag to 11, rather than
			//editing the ACS for every map that gives you one on start
			TNT1 A 0 A_StartSound("Weapons/C96/Raise", CHAN_AUTO, CHANF_OVERLAP, 1.0);
			C96I ABCDE 1;
			C96I E 4;
			C96F TUVWXYZ 1;
			TNT1 A 0
			{
				A_GiveInventory("Browning5Loaded", 11);
				invoker.firstPickup = true;
			}
			TNT1 A 0 A_StartSound("Weapons/C96/Slap", CHAN_AUTO, CHANF_OVERLAP, 1.0);
			C96G A 1;
			TNT1 A 0 A_StartSound("Weapons/C96/BoltClose", CHAN_AUTO, CHANF_OVERLAP, 1.0);
			C96G BCDEFGHIJKLMN 1;
			Goto Ready1;
		Ready:
			TNT1 A 0 A_JumpIf(!invoker.firstPickup, "FirstReady");
			TNT1 A 0 A_StartSound("Weapons/BA5/Raise", CHAN_AUTO, CHANF_OVERLAP, 1.0);
			BA5S FEDCBA 1;
		Ready1:
			LUGG A 0 A_JumpIf(CountInv("Browning5Loaded") == 0, "Ready2");
			BA5F A 1 A_WeaponReady(WRF_ALLOWRELOAD);
			Loop;
		Ready2:
			BA5F D 1 A_WeaponReady(WRF_ALLOWRELOAD);
			Loop;
		Fire:
			PPKA A 0 A_JumpIf(CountInv("Browning5Loaded") == 0,"DryFire");
			BA5F B 1 BRIGHT
			{
				A_GunFlash();
				A_AlertMonsters();
				
				if(waterlevel > 0.2)
				{
					//[Pop] Refactor later with new smoke system
					A_FireProjectile("ShotSmokeSpawner",0,0,0,random(-3,3),0,0);
				}
				A_SpawnItemEx("ShotgunCasing",12,-20,32,8,random(-2,2),random(0,4),random(-55,-80),SXF_NOCHECKPOSITION);
				A_TakeInventory("Browning5Loaded",1);
				
				A_StartSound("weapons/ba5/fire", CHAN_WEAPON, CHANF_OVERLAP, 0.6);
				A_StartSound("weapons/ba5/add", CHAN_WEAPON, CHANF_OVERLAP, 0.8);
				A_StartSound("weapons/ba5/firebass", CHAN_WEAPON, CHANF_OVERLAP);
				A_StartSound("weapons/ba5/mech", CHAN_WEAPON, CHANF_OVERLAP, 0.9);
				for(int i=0; i<9; i++)
				{
					A_FireProjectile("AutoShotgunTracer",frandom(-2.5,2.5),0,0,0,0,frandom(-3,3));
				}
				A_SetPitch(pitch-(0.2*boa_recoilamount));
			}
			BA5F C 1 BRIGHT;
			TNT1 A 0 A_JumpIf(CountInv("Browning5Loaded") == 0,"Ready2");
			BA5F DEF 1;
			Goto Ready1;
		Reload:
			BA5F A 1;
			TNT1 A 0 A_JumpIf(CountInv("Browning5Loaded") == 11, "Ready1");
			TNT1 A 0 A_JumpIf(CountInv("Ammo12Gauge") == 0, "Ready1");
			TNT1 A 0 A_JumpIf(CountInv("Browning5Loaded") > 0,"Reload2");
			BA1R ABCDEFGHIJKLMNOPQRST 1;
			TNT1 A 0 A_StartSound("weapons/ba5/boltback", CHAN_WEAPON, CHANF_OVERLAP); //[Pop] play slightly early.
			TNT1 A 0 A_StartSound("weapons/ba5/boltbackadd", CHAN_WEAPON, CHANF_OVERLAP);
			BA1R UVWXYZZZZZ 1;
			BA2R ABBBC 1;
			TNT1 A 0 A_StartSound("weapons/ba5/Shell", CHAN_WEAPON, CHANF_OVERLAP);
			BA2R DEFGGHIJJJ 1;
			TNT1 A 0 A_TakeInventory("Ammo12Gauge",1,TIF_NOTAKEINFINITE);
			TNT1 A 0 A_GiveInventory("Browning5Loaded");
			TNT1 A 0 A_StartSound("weapons/ba5/boltforward", CHAN_WEAPON, CHANF_OVERLAP);
			BA2R KLMNOPQRSTUV 1;
			TNT1 A 0 A_StartSound("weapons/ba5/out", CHAN_WEAPON, CHANF_OVERLAP); //[Pop] Play it early because length of audio file
			BA5F AAAAAAAAAAAAAAA 1;
			BA3R ABCDEFGHIJJJKLMNOPQ 1;
			Goto Reload3;
		Reload2:
			TNT1 A 0 A_StartSound("weapons/ba5/out", CHAN_WEAPON, CHANF_OVERLAP); //[Pop] Play it early because length of audio file
			BA5F AAAAAAAAAAAAAAA 1;
			BA4R ABCDEFGHIJJJKLMNOPQ 1;
		Reload3:
			BA5R AAAAAAAAAABCDEFGH 1;
			TNT1 A 0 A_StartSound("weapons/ba5/in", CHAN_WEAPON, CHANF_OVERLAP);
		ReloadLoop:
			TNT1 A 0 A_TakeInventory("Ammo12Gauge",1,TIF_NOTAKEINFINITE);
			TNT1 A 0 A_GiveInventory("Browning5Loaded");
			TNT1 A 0 A_JumpIfInventory("Browning5Loaded",11,"Reload3Finish");
			TNT1 A 0 A_JumpIfInventory("Ammo12Gauge",1,"ReloadLoop");
		Reload3Finish:
			BA5R IJKLMNOPQRST 1;
			Goto Ready1;
		Flash:
			TNT1 A 1 A_Light2;
			TNT1 A 1;
			TNT1 A 1 A_Light1;
			TNT1 A 1;
			Goto LightDone;
		Spawn:
			BA5P A -1;
			Stop;
	}
}

class Browning5Loaded : Ammo
{
	Default
	{
	Tag "$TAGGAUGE";
	Inventory.MaxAmount 11;
	+INVENTORY.IGNORESKILL
	Inventory.Icon "BROW01";
	}
}