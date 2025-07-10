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
	Scale 0.50;
	Weapon.SelectionOrder 9998;
	Weapon.AmmoType "M191145ACPLoaded";
	Weapon.AmmoUse 1;
	Weapon.AmmoType2 "Ammo9mm";
	Weapon.AmmoUse2 1;
	Weapon.AmmoGive2 8;
	Weapon.UpSound "P08COK";
	Tag "M1911";
	Inventory.PickupMessage "$P08LUG";
	+WEAPON.NOAUTOFIRE
	+NaziWeapon.NORAMPAGE
	}
	States
	{
	Ready:
		M45A A 0 A_JumpIf(CountInv("M191145ACPLoaded") == 0, "ReadyEmpty");
		M45A A 0 A_JumpIfInventory("Ammo9mm",1,2);
		M45A A 1 A_WeaponReady;
		Loop;
		M45A A 1 A_WeaponReady(WRF_ALLOWRELOAD);
		Loop;
	ReadyEmpty:
		M45A I 0 A_JumpIfInventory("Ammo9mm",1,2);
		M45A I 1 A_WeaponReady;
		Loop;
		M45A I 1 A_WeaponReady(WRF_ALLOWRELOAD);
		Loop;
	Deselect:
		M45A A 0 A_Lower;
		M45A A 1 A_Lower;
		Loop;
	Select:
		M45A A 0 A_Raise;
		M45A A 1 A_Raise;
		Loop;
	Fire:
		M45A A 0 A_JumpIfInventory("M191145ACPLoaded",1,1);
		Goto Dryfire;
		M45A A 0 A_GunFlash;
		M45A A 0 A_SetPitch(pitch-(0.2*boa_recoilamount));
		M45A A 0 A_JumpIf(waterlevel > 0,2);
		M45A A 0 A_FireProjectile("PistolSmokeSpawner",0,0,0,random(-4,4),0,0);
		M45A A 0
		{
			A_StartSound("Weapons/M1911/Fire", CHAN_AUTO, CHANF_OVERLAP, 1.0);
			A_StartSound("Weapons/M1911/FireAdd", CHAN_AUTO, CHANF_OVERLAP, 0.8);
			A_StartSound("Weapons/M1911/FireMech", CHAN_AUTO, CHANF_OVERLAP, 0.9);
		}
		M45A A 0 A_SpawnItemEx("Casing9mm",12,-20,32,8,random(-2,2),random(0,4),random(-55,-80),SXF_NOCHECKPOSITION);
		M45A A 0 A_AlertMonsters;
		M45A B 1 BRIGHT A_FireProjectile("LugerTracer");
		M45A C 1;
		M45A D 1 A_SetPitch(pitch-(0.2*boa_recoilamount));
		TNT1 A 0 A_JumpIf(CountInv("M191145ACPLoaded") == 0, "FireEndEmpty");
		M45A EF 1 A_WeaponReady(WRF_NOBOB);
		Goto Ready;
	FireEndEmpty:
		M45A GH 1;
		Goto ReadyEmpty;
		
	Reload:
		TNT1 A 0 A_JumpIf(CountInv("M191145ACPLoaded") == 0, "Reload2");
		M452 ABCDEF 1;
		TNT1 A 0 A_StartSound("Weapons/M1911/MagOut", CHAN_AUTO);
		M452 GHIJKLMNO 1;
		TNT1 A 0 A_StartSound("Weapons/M1911/MagIn", CHAN_AUTO);
		M452 PQR 1;
	ReloadLoop:
		TNT1 A 0 A_TakeInventory("Ammo9mm",1,TIF_NOTAKEINFINITE);
		TNT1 A 0 A_GiveInventory("M191145ACPLoaded");
		TNT1 A 0 A_JumpIfInventory("M191145ACPLoaded",0,"ReloadFinish");
		TNT1 A 0 A_JumpIfInventory("Ammo9mm",1,"ReloadLoop");
	ReloadFinish:
		M452 STUVWXYZ 1;
		M453 ABC 1;
		Goto Ready;
		
	Reload2:
		M454 ABCDE 1;
		TNT1 A 0 A_StartSound("Weapons/M1911/MagOut", CHAN_AUTO);
		M454 FGHIJKLM 1;
		TNT1 A 0 A_StartSound("Weapons/M1911/MagIn", CHAN_AUTO);
		M454 NOPQR 1;
	Reload2Loop:
		TNT1 A 0 A_TakeInventory("Ammo9mm",1,TIF_NOTAKEINFINITE);
		TNT1 A 0 A_GiveInventory("M191145ACPLoaded");
		TNT1 A 0 A_JumpIfInventory("M191145ACPLoaded",0,"Reload2Finish");
		TNT1 A 0 A_JumpIfInventory("Ammo9mm",1,"Reload2Loop");
	Reload2Finish:
		M454 STUVW 1;
		TNT1 A 0 A_StartSound("Weapons/M1911/Charge", CHAN_AUTO);
		M454 XYZ 1;
		M455 ABCDEFGHIJK 1;
		Goto Ready;
	
	Flash:
		TNT1 A 1 A_Light2;
		TNT1 A 1;
		TNT1 A 2 A_Light1;
		Goto LightDone;
	Spawn:
		LUGP A -1;
		Stop;
	}
}

class M191145ACPLoaded : Ammo
{
	Default
	{
	Tag "45ACP";
	+INVENTORY.IGNORESKILL
	Inventory.MaxAmount 7;
	Inventory.Icon "WALT01";
	}
}