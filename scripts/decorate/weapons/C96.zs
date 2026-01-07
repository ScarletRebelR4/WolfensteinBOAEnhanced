/*
 * Copyright (c) 2015-2021 Tormentor667, Ozymandias81, Ed the Bat, MaxED
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

class C96 : NaziWeapon
{
	Default
	{
	//$Category Weapons (BoA)
	//$Title (2) Walther
	//$Color 14
	Scale 0.75;
	Weapon.SelectionOrder 9997;
	Weapon.AmmoType "C96Loaded";
	Weapon.SlotNumber 2;
	Weapon.AmmoUse 1;
	Weapon.AmmoType2 "Ammo763Mauser";
	Weapon.AmmoUse2 1;
	Weapon.AmmoGive2 8;
	Weapon.UpSound "PPKCOK";
	Weapon.UpSound "weapon/Pistol/raise";
	Tag "C96";
	Inventory.PickupMessage "You got the C96!";
	+WEAPON.NOAUTOFIRE;
	}
	States
	{
		Deselect:
			TNT1 A 0 A_StartSound("Weapons/C96/Lower", CHAN_AUTO, CHANF_OVERLAP, 1.0);
			C96B FEDCBA 1;
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
			C96B ABCDEF 1;
		Ready1:
			LUGG A 0 A_JumpIf(CountInv("C96Loaded") == 0, "Ready2");
			C96A A 1 A_WeaponReady(WRF_ALLOWRELOAD);
			Loop;
		Ready2:
			C96A E 1 A_WeaponReady(WRF_ALLOWRELOAD);
			Loop;
		
		Fire:
			PPKA A 0 A_JumpIf(CountInv("C96Loaded") == 0,"DryFire");
			C96A B 1
			{
				A_GunFlash();
				A_AlertMonsters();
				
				if(waterlevel > 0.2)
				{
					//[Pop] Refactor later with new smoke system
					 A_FireProjectile("PistolSmokeSpawner",0,0,0,random(-4,4),0,0);
				}
				A_SpawnItemEx("Casing9mm",12,-20,32,8,random(-2,2),random(0,4),random(-55,-80),SXF_NOCHECKPOSITION);
				//Take Ammo
				
				A_StartSound("Weapons/C96/Fire", CHAN_AUTO, CHANF_OVERLAP, 1.0);
				A_StartSound("Weapons/C96/FireExtra", CHAN_AUTO, CHANF_OVERLAP, 0.8);
				A_StartSound("Weapons/C96/FireMech", CHAN_AUTO, CHANF_OVERLAP, 1.0);
				A_StartSound("Weapons/C96/FireAdd", CHAN_AUTO, CHANF_OVERLAP, 0.7);
				A_FireProjectile("C96Tracer");
				A_SetPitch(pitch-(0.2*boa_recoilamount));
			}
			C96A C 1;
			TNT1 A 0 A_JumpIf(CountInv("C96Loaded") == 0,"FireEnd");
			C96A DA 1;
			C96A A 1 A_WeaponReady();
			Goto Ready1;
		FireEnd: //Last shot empty
			C96A EEE 1;
			Goto Ready2;
		Reload:
			TNT1 A 0 A_JumpIf(CountInv("Ammo763Mauser") == 0, "Ready1");
			TNT1 A 0 A_JumpIf(CountInv("C96Loaded") == 10, "Ready1");
			TNT1 A 0 A_JumpIf(CountInv("C96Loaded") == 0, "Reload2"); //Clip Load
			TNT1 A 0 A_StartSound("Weapons/C96/ArmSwish", CHAN_AUTO, CHANF_OVERLAP, 1.0);
			C96A A 2;
			C96E ABCDEFGHIJ 1;
			TNT1 A 0 A_StartSound("Weapons/C96/BulletCatch", CHAN_AUTO, CHANF_OVERLAP, 1.0);
			C96E KLMNOP 1;
			TNT1 A 0 A_StartSound("Weapons/C96/ClipBump", CHAN_AUTO, CHANF_OVERLAP, 1.0);
			C96E QR 1;
			TNT1 A 0 A_StartSound("Weapons/C96/BoltBack", CHAN_AUTO, CHANF_OVERLAP, 1.0);
			C96E STUVWXYZ 1;
			C96F ABCDEFGH 1;
		ReloadLoop:
			C96F H 2;
			C96F IJKLMN 1;
			TNT1 A 0 A_StartSound("Weapons/C96/Bullet", CHAN_AUTO, CHANF_OVERLAP, 1.0);
			C96F OPQRS 1;
			TNT1 A 0 A_TakeInventory("Ammo763Mauser",1,TIF_NOTAKEINFINITE);
			TNT1 A 0 A_GiveInventory("C96Loaded");
			C96F T 2;
			TNT1 A 0 A_JumpIfInventory("C96Loaded",10,"ReloadFinish");
			TNT1 A 0 A_JumpIfInventory("Ammo763Mauser",1,"ReloadLoop");
		ReloadFinish:
			C96F UVWXYZ 1;
			TNT1 A 0 A_StartSound("Weapons/C96/Slap", CHAN_AUTO, CHANF_OVERLAP, 1.0);
			C96G ABC 1;
			TNT1 A 0 A_StartSound("Weapons/C96/BoltClose", CHAN_AUTO, CHANF_OVERLAP, 1.0);
			C96G DEFGHIJKLMN 1;
			Goto Ready1;
		
		Reload2:
			C96A E 1;
			C96C ABCDEF 1;
			C96C G 10;
			C96C HIJKL 1;
			TNT1 A 0 A_StartSound("Weapons/C96/ClipBump", CHAN_AUTO, CHANF_OVERLAP, 1.0);
			C96C MN 1;
			TNT1 A 0 A_StartSound("Weapons/C96/ClipIn", CHAN_AUTO, CHANF_OVERLAP, 1.0);
			C96C OPQRSTUVWXYZ 1;
		Reload2Loop:
			TNT1 A 0 A_TakeInventory("Ammo763Mauser",1,TIF_NOTAKEINFINITE);
			TNT1 A 0 A_GiveInventory("C96Loaded");
			TNT1 A 0 A_JumpIfInventory("C96Loaded",10,"Reload2Finish");
			TNT1 A 0 A_JumpIfInventory("Ammo763Mauser",1,"Reload2Loop");
		Reload2Finish:
			C96D A 10;
			C96D ABCDE 2;
			TNT1 A 0 A_StartSound("Weapons/C96/ClipPing", CHAN_AUTO, CHANF_OVERLAP, 1.0);
			C96D F 1;
			TNT1 A 0 A_StartSound("Weapons/C96/BoltClose", CHAN_AUTO, CHANF_OVERLAP, 1.0);
			C96D GHIJKLMNO 1;
			Goto Ready1;
		
		Flash:
			TNT1 A 1 A_Light2;
			TNT1 A 1;
			TNT1 A 2 A_Light1;
			Goto LightDone;
		Spawn:
			C96A F -1;
			Stop;
	}
}

class C96Loaded : Ammo
{
	Default
	{
	Tag ".380 ACP";
	+INVENTORY.IGNORESKILL
	Inventory.MaxAmount 10;
	Inventory.Icon "WALT01";
	}
}