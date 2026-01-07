/*
 * Copyright (c) 2015-2021 Ed the Bat, Ozymandias81, MaxED
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

class G43 : NaziWeapon
{
	Default
	{
	//$Category Weapons (BoA)
	//$Title (4) Gewehr 43
	//$Color 14
	Scale 0.35;
	Weapon.SelectionOrder 750;
	Weapon.AmmoType "G43Loaded";
	Weapon.AmmoUse 1;
	Weapon.AmmoType2 "MauserAmmo";
	Weapon.AmmoUse2 1;
	Weapon.AmmoGive2 10;
	Weapon.UpSound "weapon/Sniper/raise";
	Inventory.PickupMessage "$G43";
	Tag "Gewehr 43";
	Weapon.UpSound "G43COK";
	+WEAPON.NOAUTOFIRE;
	+NaziWeapon.NORAMPAGE
	}
	States
	{
		Deselect:
			//TNT1 A 0 A_StartSound("Weapons/C96/Lower", CHAN_AUTO, CHANF_OVERLAP, 1.0);
			G43C FEDCBA 1;
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
			G43C ABCDEF 1;
		Ready1:
			TNT1 A 0 A_JumpIf(CountInv("G43Loaded") == 0, "Ready2");
			G43A A 1 A_WeaponReady(WRF_ALLOWRELOAD);
			Loop;
		Ready2:
			G43A E 1 A_WeaponReady(WRF_ALLOWRELOAD);
			Loop;
		Fire:
			TNT1 A 0 A_JumpIf(CountInv("G43Loaded") == 0,"DryFire");
			G43A B 1 BRIGHT
			{
				A_GunFlash();
				A_AlertMonsters();
				
				if(waterlevel > 0.2)
				{
					//[Pop] Refactor later with new smoke system
					A_FireProjectile("ShotSmokeSpawner",0,0,0,random(-4,4),0,0);
				}
				A_SpawnItemEx("MauserRifleCasing",12,-20,32,8,random(-2,2),random(0,4),random(-55,-80),SXF_NOCHECKPOSITION);
				//Take Ammo
				
				A_StartSound("G43FIR",CHAN_WEAPON, CHANF_OVERLAP);
				A_FireProjectile("G43Tracer");
				A_SetPitch(pitch-(1.4*boa_recoilamount));
			}
			G43A C 1;
			TNT1 A 0 A_JumpIf(CountInv("G43Loaded") == 0,"FireEnd");
			G43A DC 1;
			G43A A 1 A_WeaponReady();
			Goto Ready1;
		FireEnd:
			G43A EEE 1;
			Goto Ready2;
		Reload:
			TNT1 A 0 A_JumpIf(CountInv("MauserAmmo") == 0, "Ready1");
			TNT1 A 0 A_JumpIf(CountInv("G43Loaded") == 11, "Ready1");
			TNT1 A 0 A_JumpIf(CountInv("G43Loaded") == 0, "Reload2");
			G43A A 6;
			G43R A 8;
			TNT1 A 0 A_StartSound("G43OUT", CHAN_WEAPON, CHANF_OVERLAP);
			G43R B 16;
			TNT1 A 0 A_StartSound("G43IN", CHAN_WEAPON, CHANF_OVERLAP);
			G43R A 2;
		ReloadLoop:
			TNT1 A 0 A_TakeInventory("MauserAmmo",1,TIF_NOTAKEINFINITE);
			TNT1 A 0 A_GiveInventory("G43Loaded");
			TNT1 A 0 A_JumpIfInventory("G43Loaded",11,"ReloadFinish");
			TNT1 A 0 A_JumpIfInventory("MauserAmmo",1,"ReloadLoop");
		ReloadFinish:
			G43R A 16;
			Goto Ready1;
		Reload2:
			G43A E 4;
			G43R C 8;
			TNT1 A 0 A_StartSound("G43OUT", CHAN_WEAPON, CHANF_OVERLAP);
			G43R DEEF 4;
			TNT1 A 0 A_StartSound("G43IN", CHAN_WEAPON, CHANF_OVERLAP);
		Reload2Loop:
			TNT1 A 0 A_TakeInventory("MauserAmmo",1,TIF_NOTAKEINFINITE);
			TNT1 A 0 A_GiveInventory("G43Loaded");
			TNT1 A 0 A_JumpIfInventory("G43Loaded",10,"Reload2Finish");
			TNT1 A 0 A_JumpIfInventory("MauserAmmo",1,"Reload2Loop");
		Reload2Finish:
			G43R GH 4;
			TNT1 A 0 A_StartSound("G43COK", CHAN_5);
			G43R IA 4;
			Goto Ready1;
		Flash:
			TNT1 A 1 A_Light2;
			TNT1 A 1;
			TNT1 A 2 A_Light1;
			Goto LightDone;
		Spawn:
			G43P A -1;
			Stop;
	}
}

class G43Loaded : Ammo
{
	Default
	{
	Tag "7.92x57mm";
	+INVENTORY.IGNORESKILL
	Inventory.MaxAmount 11;
	Inventory.Icon "MAUS01";
	}
}