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

class WaltherPPK : NaziWeapon
{
	Default
	{
	//$Category Weapons (BoA)
	//$Title (2) Walther
	//$Color 14
	Scale 0.50;
	Weapon.SelectionOrder 9997;
	Weapon.AmmoType "WaltherPPKLoaded";
	Weapon.SlotNumber 2;
	Weapon.AmmoUse 1;
	Weapon.AmmoType2 "Ammo380ACP";
	Weapon.AmmoUse2 1;
	Weapon.AmmoGive2 8;
	Weapon.UpSound "PPKCOK";
	Tag "Walther PPK";
	Inventory.PickupMessage "You got the Walther PPK!";
	+WEAPON.NOAUTOFIRE;
	}
	States
	{
		Deselect:
			TNT1 A 0 A_StartSound("Weapons/PPK/Drop", CHAN_AUTO, CHANF_OVERLAP, 1.0);
			PPKB FEDCBA 1;
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
			TNT1 A 0 A_StartSound("Weapons/PPK/Raise", CHAN_AUTO, CHANF_OVERLAP, 1.0);
			PPKC ABCDEFGHIJ 1;
			TNT1 A 0 A_StartSound("Weapons/PPK/Charge", CHAN_AUTO, CHANF_OVERLAP, 1.0);
			PPKC KLMN 1;
			TNT1 A 0
			{
				invoker.firstPickup = true;
			}
			PPKC OPQRSTUVW 1;
			Goto Ready1;
		Ready:
			TNT1 A 0 A_JumpIf(!invoker.firstPickup, "FirstReady");
			TNT1 A 0 A_StartSound("Weapons/PPK/Raise", CHAN_AUTO, CHANF_OVERLAP, 1.0);
			PPKB ABCDEF 1;
		Ready1:
			LUGG A 0 A_JumpIf(CountInv("WaltherPPKLoaded") == 0, "ReadyEmpty");
			PPKA A 1 A_WeaponReady(WRF_ALLOWRELOAD);
			Loop;
		Ready2:
			PPKA D 1 A_WeaponReady(WRF_ALLOWRELOAD);
			Loop;
		
		Fire:
			PPKA A 0 A_JumpIf(CountInv("WaltherPPKLoaded") == 0,"DryFire");
			PPKA B 1
			{
				A_GunFlash();
				//A_AlertMonsters(); silent weapon
				
				if(waterlevel > 0.2)
				{
					//[Pop] Refactor later with new smoke system
					 A_FireProjectile("PistolSmokeSpawner",0,0,0,random(-4,4),0,0);
				}
				A_SpawnItemEx("Casing9mm",12,-20,32,8,random(-2,2),random(0,4),random(-55,-80),SXF_NOCHECKPOSITION);
				//Take Ammo
				
				A_StartSound("Weapons/PPK/Fire", CHAN_AUTO, CHANF_OVERLAP, 1.0);
				A_StartSound("Weapons/PPK/FireMech", CHAN_AUTO, CHANF_OVERLAP, 0.8);
				A_StartSound("Weapons/PPK/FireAdd", CHAN_AUTO, CHANF_OVERLAP, 0.9);
				A_FireProjectile("PPKTracer");
				A_SetPitch(pitch-(0.2*boa_recoilamount));
			}
			PPKA CD 1;
			TNT1 A 0 A_JumpIfInventory("WaltherPPKLoaded",0,"FireEnd");
			PPKA A 1 A_WeaponReady();
			Goto Ready1;
		FireEnd: //Last shot empty
			PPKA DC 1;
			Goto Ready2;
		Reload:
			TNT1 A 0 A_JumpIf(CountInv("WaltherPPKLoaded") == 8, "Ready1");
			TNT1 A 0 A_JumpIf(CountInv("WaltherPPKLoaded") == 0, "Reload2");
			PPKA A 1;
			PPKD ABCDEFGHII 1;
			TNT1 A 0 A_StartSound("Weapons/PPK/MagRelease", CHAN_AUTO, CHANF_OVERLAP, 1.0);
			PPKD JKLMNOPPQ 1;
			TNT1 A 0 A_StartSound("Weapons/PPK/MagOut", CHAN_AUTO, CHANF_OVERLAP, 1.0);
			PPKD RSTTTUVWXYXYZ 1;
			PPKE ABCDEEFGHHI 1;
			TNT1 A 0 A_StartSound("Weapons/PPK/MagIn", CHAN_AUTO, CHANF_OVERLAP, 1.0);
			PPKE JKLMMMN 1;
		ReloadLoop:
			TNT1 A 0 A_TakeInventory("Ammo380ACP",1,TIF_NOTAKEINFINITE);
			TNT1 A 0 A_GiveInventory("WaltherPPKLoaded");
			TNT1 A 0 A_JumpIfInventory("WaltherPPKLoaded",8,"ReloadFinish");
			TNT1 A 0 A_JumpIfInventory("Ammo380ACP",1,"ReloadLoop");
		ReloadFinish:
			PPKE OPQRSTU 1;
			Goto Ready1;
		Reload2:
			PPKA A 1;
			PPKF ABCDEFG 1;
			TNT1 A 0 A_StartSound("Weapons/PPK/MagOut", CHAN_AUTO, CHANF_OVERLAP, 1.0);
			PPKF HIIJKLMNOPQRSSTTUVWXYZ 1;
			PPKG ABCDEFG 1;
			TNT1 A 0 A_StartSound("Weapons/PPK/MagIn", CHAN_AUTO, CHANF_OVERLAP, 1.0);
			PPKG HIIJKLMMM 1;
		Reload2Loop:
			TNT1 A 0 A_TakeInventory("Ammo380ACP",1,TIF_NOTAKEINFINITE);
			TNT1 A 0 A_GiveInventory("WaltherPPKLoaded");
			TNT1 A 0 A_JumpIfInventory("WaltherPPKLoaded",7,"Reload2Finish");
			TNT1 A 0 A_JumpIfInventory("Ammo380ACP",1,"Reload2Loop");
		Reload2Finish:
			PPKG NOPQQR 1;
			TNT1 A 0 A_StartSound("Weapons/PPK/Charge", CHAN_AUTO, CHANF_OVERLAP, 1.0);
			PPKG STUUUVWXYZ 1;
			PPKH ABCD 1;
			Goto Ready1;
		
		Flash:
			TNT1 A 1 A_Light2;
			TNT1 A 1;
			TNT1 A 2 A_Light1;
			Goto LightDone;
		Spawn:
			PPKA E -1;
			Stop;
	}
}

class WaltherPPKLoaded : Ammo
{
	Default
	{
	Tag ".380 ACP";
	+INVENTORY.IGNORESKILL
	Inventory.MaxAmount 8;
	Inventory.Icon "WALT01";
	}
}