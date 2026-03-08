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

class M191145ACP : NaziWeapon
{
	Default
	{
	//$Category Weapons (BoA)
	//$Title (2) M1911
	//$Color 14
	Scale 0.6;
	Weapon.SelectionOrder 9998;
	Weapon.AmmoType "M191145ACPLoaded";
	Weapon.AmmoUse 1;
	Weapon.AmmoType2 "Ammo45ACP";
	Weapon.AmmoUse2 1;
	Weapon.AmmoGive2 8;
	Weapon.UpSound "weapon/Pistol/raise";
	Tag "M1911";
	Inventory.PickupMessage "$P08LUG";
	+WEAPON.NOAUTOFIRE
	+NaziWeapon.NORAMPAGE
	}
	
	States
	{
		Deselect:
			TNT1 A 0 A_StartSound("Weapons/C96/Lower", CHAN_AUTO, CHANF_OVERLAP, 1.0);
			M45H ABCDEF 1;
			TNT1 A 0 A_Lower();
			Wait;
		Select:
			TNT1 A 0 A_JumpIf(!invoker.firstPickup, "FirstSelect");
			M45A A 0 A_Raise;
			M45A A 0 A_Raise;
			Loop;
		FirstSelect:
			TNT1 AAA 0 A_Raise;
			TNT1 A 1 A_Raise;
			Loop;
		FirstReady:
			M451 ABCDEFGHI 1;
			TNT1 A 0 
			{
				A_GiveInventory("M191145ACPLoaded", 8);
				A_StartSound("Weapons/M1911/Charge", CHAN_AUTO);
				invoker.firstPickup = true;
			}
			M451 JKLMNOPQRSTUVWXYZ 1;
			Goto Ready1;
		Ready:
			TNT1 A 0 A_JumpIf(!invoker.firstPickup, "FirstReady");
			TNT1 A 0 A_StartSound("Weapons/C96/Raise", CHAN_AUTO, CHANF_OVERLAP, 1.0);
			M45D ABCDEF 1;
		Ready1:
			LUGG A 0 A_JumpIf(CountInv("M191145ACPLoaded") == 0, "Ready2");
			M45G A 1 A_WeaponReady(WRF_ALLOWRELOAD);
			Loop;
		Ready2:
			M45F B 1 A_WeaponReady(WRF_ALLOWRELOAD);
			Loop;
		Fire:
			PPKA A 0 A_JumpIf(CountInv("M191145ACPLoaded") == 0,"DryFire");
			M45F A 1 BRIGHT
			{
				A_GunFlash();
				A_AlertMonsters();
				
				if(waterlevel > 0.2)
				{
					//[Pop] Refactor later with new smoke system
					A_FireProjectile("PistolSmokeSpawner",0,0,0,random(-4,4),0,0);
				}
				A_SpawnItemEx("Casing45ACP",12,-20,32,8,random(-2,2),random(0,4),random(-55,-80),SXF_NOCHECKPOSITION);
				//Take Ammo
				 
				A_StartSound("Weapons/M1911/Fire", CHAN_AUTO, CHANF_OVERLAP, 0.25);
				A_StartSound("Weapons/M1911/FireExtra", CHAN_AUTO, CHANF_OVERLAP, 0.6);
				A_StartSound("Weapons/M1911/FireAdd", CHAN_AUTO, CHANF_OVERLAP, 1.0);
				A_StartSound("Weapons/M1911/FireMech", CHAN_AUTO, CHANF_OVERLAP, 0.8);
				A_FireProjectile("LugerTracer");
				A_SetPitch(pitch-(0.2*boa_recoilamount));
			}
			M45F CB 1;
			TNT1 A 0 A_JumpIf(CountInv("M191145ACPLoaded") == 0, "FireEndEmpty");
			M45F CEDFG 1 A_WeaponReady(WRF_NOBOB);
			Goto Ready1;
		FireEndEmpty:
			M45F BBB 1;
			Goto Ready2;
		
		Reload:
			M452 A 0 A_JumpIf(CountInv("Ammo45ACP") == 0, "Ready1");
			TNT1 A 0 A_JumpIf(CountInv("M191145ACPLoaded") == 8, "Ready1");
			TNT1 A 0 A_JumpIf(CountInv("M191145ACPLoaded") == 0, "Reload2");
			M45A ABCDEFGHIJKLMNOPQRSTUUU 1;
			TNT1 A 0 A_StartSound("Weapons/M1911/MagOut", CHAN_AUTO);
			M45A VWXYYYZ 1;
			M45B ABC 1;
			TNT1 A 0 A_StartSound("Weapons/M1911/MagIn", CHAN_AUTO);
			M45B DEFGHI 1;
		ReloadLoop:
			TNT1 A 0 A_TakeInventory("Ammo45ACP",1,TIF_NOTAKEINFINITE);
			TNT1 A 0 A_GiveInventory("M191145ACPLoaded");
			TNT1 A 0 A_JumpIfInventory("M191145ACPLoaded",8,"ReloadFinish");
			TNT1 A 0 A_JumpIfInventory("Ammo45ACP",1,"ReloadLoop");
		ReloadFinish:
			M45B JKLMNOPQRSTUVW 1;
			Goto Ready1;
		
		Reload2:
			M452 ABCDEF 1;
			TNT1 A 0 A_StartSound("Weapons/M1911/MagOut", CHAN_AUTO);
			M452 GHIJKLLLLLMNO 1;
			TNT1 A 0 A_StartSound("Weapons/M1911/MagIn", CHAN_AUTO);
			M452 PQR 1;
		Reload2Loop:
			TNT1 A 0 A_TakeInventory("Ammo45ACP",1,TIF_NOTAKEINFINITE);
			TNT1 A 0 A_GiveInventory("M191145ACPLoaded");
			TNT1 A 0 A_JumpIfInventory("M191145ACPLoaded",7,"Reload2Finish");
			TNT1 A 0 A_JumpIfInventory("Ammo45ACP",1,"Reload2Loop");
		Reload2Finish:
			M454 STUVW 1;
			TNT1 A 0 A_StartSound("Weapons/M1911/Charge", CHAN_AUTO);
			M454 XYZ 1;
			M455 ABCDEFGHIJK 1;
			Goto Ready1;
		
		Flash:
			TNT1 A 1 A_Light2;
			TNT1 A 1;
			TNT1 A 2 A_Light1;
			Goto LightDone;
		Spawn:
			M45P A -1;
			Stop;
	}
}

class M191145ACPLoaded : Ammo
{
	Default
	{
	Tag "45ACP";
	+INVENTORY.IGNORESKILL
	Inventory.MaxAmount 8;
	Inventory.Icon "WALT01";
	}
}