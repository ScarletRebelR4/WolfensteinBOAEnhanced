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

class PPSH41 : NaziWeapon
{
	Default
	{
	//$Category Weapons (BoA)
	//$Title (4) PPSH41
	//$Color 14
	Scale .5;
	Weapon.SelectionOrder 600;
	Weapon.AmmoType "PPSH41Loaded";
	Weapon.AmmoUse 1;
	Weapon.AmmoType2 "Ammo763Mauser";
	Weapon.AmmoUse2 1;
	Weapon.UpSound "weapon/SMG/raise";
	Tag "PPSH-41";
	Inventory.PickupMessage "$PPSH41";
	Weapon.AmmoGive2 32;
	}
	States
	{
		Deselect:
			PSHA A 0 A_Lower;
			PSHA A 1 A_Lower;
			Loop;
		Select:
			PSHA A 0 A_Raise;
			PSHA A 1 A_Raise;
			Loop;
		FirstSelect:
			TNT1 A 0; //Check First Time Select
			TNT1 A 0 A_Raise();
			TNT1 A 1 A_Raise();
			Loop;
		FirstReady:
			TNT1 A 1;
		Ready:
			PSHA A 0 A_JumpIf(CountInv("PPSH41Loaded") == 0,"Ready2");
			PSHA A 1 A_WeaponReady(WRF_ALLOWRELOAD);
			Loop;
		Ready2:
			PSHA A 1 A_WeaponReady(WRF_ALLOWRELOAD);
			Loop;
		Fire:
			PSHA A 0 A_JumpIf(CountInv("PPSH41Loaded") == 0, "DryFire");
			PSHA B 1 BRIGHT
			{
				A_GunFlash();
				A_AlertMonsters();
				
				if(waterlevel > 0.2)
				{
					//[Pop] Refactor later with new smoke system
					A_FireProjectile("ChainSmokeSpawner",0,0,0,random(-4,4),0,0);
				}
				
				A_SpawnItemEx("Casing9mm",12,-20,32,8,random(-2,2),random(0,4),random(-55,-80),SXF_NOCHECKPOSITION);
				A_FireProjectile("PPSH41Tracer",frandom(-1.4,1.4));
				
				A_StartSound("Weapons/PPSH/Fire", CHAN_AUTO, CHANF_OVERLAP, 1.0);
				A_StartSound("Weapons/PPSH/Add", CHAN_AUTO, CHANF_OVERLAP, 0.75);
				A_StartSound("Weapons/PPSH/Thump", CHAN_AUTO, CHANF_OVERLAP, 1.0);
				A_StartSound("Weapons/PPSH/Mech", CHAN_AUTO, CHANF_OVERLAP, 0.9);
				
				A_SetPitch(pitch-(0.5*boa_recoilamount));
			}
			PSHA C 1;
			PSHA D 1 A_ReFire("Fire");
			TNT1 A 0 A_CheckReload;
			Goto Ready;
		AltFire:
			PSHA A 1;
			Goto Ready;
		Reload:
			TNT1 A 0 A_JumpIf(CountInv("Ammo763Mauser") == 0, "Ready");
			TNT1 A 0 A_JumpIf(CountInv("PPSH41Loaded") == 0, "Reload2");
			PSHB ABCDEF 1;
			TNT1 A 0 A_StartSound("Weapons/PPSH/MagOut", CHAN_AUTO, CHANF_OVERLAP, 0.75);
			PSHB GH 2;
			PSHB IJKLM 1;
			PSHB N 6;
			PSHB OPQR 1;
			PSHB S 1 A_StartSound("Weapons/PPSH/MagIn", CHAN_AUTO, CHANF_OVERLAP, 0.75);
			PSHB T 6;
		ReloadLoop:
			TNT1 A 0 A_TakeInventory("Ammo763Mauser",1,TIF_NOTAKEINFINITE);
			TNT1 A 0 A_GiveInventory("PPSH41Loaded", 1);
			TNT1 A 0 A_JumpIfInventory("PPSH41Loaded",71,"ReloadFinish");
			TNT1 A 0 A_JumpIfInventory("Ammo763Mauser",1,"ReloadLoop");
		ReloadFinish:
			PSHB UVWXYZ 1;
			PSHC ABC 1;
			Goto Ready;
		Reload2:
			PSHD ABCDEFGHIJKLM 1;
			PSHD N 4;
			PSHD O 4 A_StartSound("Weapons/PPSH/MagTap", CHAN_AUTO, CHANF_OVERLAP);
			PSHD P 1 A_StartSound("Weapons/PPSH/MagOut", CHAN_AUTO, CHANF_OVERLAP, 0.75);
			PSHD QQRRRR 1;
			PSHD STUUVW 1;
			TNT1 A 0 A_StartSound("Weapons/PPSH/MagIn", CHAN_AUTO, CHANF_OVERLAP, 0.75);
		Reload2Loop:
			TNT1 A 0 A_TakeInventory("Ammo763Mauser",1,TIF_NOTAKEINFINITE);
			TNT1 A 0 A_GiveInventory("PPSH41Loaded", 1);
			TNT1 A 0 A_JumpIfInventory("PPSH41Loaded",71,"Reload2Finish");
			TNT1 A 0 A_JumpIfInventory("Ammo763Mauser",1,"Reload2Loop");
		Reload2Finish:
			PSHD XXYYYYZ 1;
			PSHE ABC 1;
			PSHE DE 2;
			PSHE FGHIJK 1;
			TNT1 A 0 A_StartSound("Weapons/PPSH/Charge", CHAN_AUTO, CHANF_OVERLAP);
			PSHE LMNNOOOOPPQQRRSSTUV 1;
			Goto Ready;
		
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

class PPSH41Loaded : Ammo
{
	Default
	{
	Tag "762x25mm";
	+INVENTORY.IGNORESKILL
	Inventory.MaxAmount 71;
	Inventory.Icon "WALT01";
	}
}
