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

class WaltherPPK : NaziWeapon replaces Walther9mm
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
	Weapon.AmmoType2 "Ammo9mm";
	Weapon.AmmoUse2 1;
	Weapon.AmmoGive2 8;
	Weapon.UpSound "PPKCOK";
	Tag "Walther PPK";
	Inventory.PickupMessage "You got the Walther PPK!";
	}
	States
	{
	Ready:
		PPKI A 0 A_JumpIfInventory("WaltherPPKLoaded",0,2);
		PPKI A 0 A_JumpIfInventory("Ammo9mm",1,2);
		PPKI A 1 A_WeaponReady;
		Loop;
		PPKI A 1 A_WeaponReady(WRF_ALLOWRELOAD);
		Loop;
	Deselect:
		PPKI A 0 A_Lower;
		PPKI A 1 A_Lower;
		Loop;
	Select:
		PPKI A 0 A_Raise;
		PPKI A 1 A_Raise;
		Loop;
	Fire:
		PPKI A 0 A_JumpIfInventory("WaltherPPKLoaded",1,1);
		Goto Dryfire;
		PPKI A 0 A_GunFlash;
		PPKI A 0 A_SetPitch(pitch-(0.2*boa_recoilamount));
		PPKI A 0 A_JumpIf(waterlevel > 0,2);
		PPKI A 0 A_FireProjectile("PistolSmokeSpawner",0,0,0,random(-4,4),0,0);
		PPKI A 0 A_StartSound("PPKFIR", CHAN_WEAPON);
		PPKI A 0 A_SpawnItemEx("Casing9mm",12,-20,32,8,random(-2,2),random(0,4),random(-55,-80),SXF_NOCHECKPOSITION);
		PPKI A 1 BRIGHT A_FireProjectile("PPKTracer");
		PPKF A 1;
		PPKF B 1 A_SetPitch(pitch-(0.2*boa_recoilamount));
		PPKF C 1 A_WeaponOffset(0,38, WOF_INTERPOLATE);
		PPKF D 1 A_WeaponReady();
		PPKI A 1 A_WeaponReady(); 
		TNT1 A 0 A_CheckReload;
		PPKI A 1 A_Jump(128,"Ready");
		Goto Ready;
	Reload:
		PPKR A 2;
		PPKR B 2;
		PPKR C 2;
		TNT1 A 0 A_StartSound("PPKOUT", CHAN_5);
		PPKR D 2;
		PPKR E 2;
		PPKR F 2;
		PPKR G 2;
		PPKR H 2;
	ReloadLoop:
		TNT1 A 0 A_TakeInventory("Ammo9mm",1,TIF_NOTAKEINFINITE);
		TNT1 A 0 A_GiveInventory("WaltherPPKLoaded");
		TNT1 A 0 A_JumpIfInventory("WaltherPPKLoaded",0,"ReloadFinish");
		TNT1 A 0 A_JumpIfInventory("Ammo9mm",1,"ReloadLoop");
	ReloadFinish:
		PPKR I 2;
		PPKR J 2;
		PPKR K 2;
		TNT1 A 0 A_StartSound("PPKIN", CHAN_5);
		PPKR L 2;
		PPKR M 2;
		PPKR M 2;
		PPKR O 2;
		PPKR P 2;
		PPKR Q 2;
		PPKR R 2;
		TNT1 A 0 A_StartSound("PPKCOK", CHAN_5);
		PPKR S 2;
		PPKR T 2;
		PPKR U 2;
		PPKR V 2;
		PPKR W 2;
		PPKR X 2;
		PPKR Y 2;
		Goto Ready;
	Flash:
		TNT1 A 1 A_Light2;
		TNT1 A 1;
		TNT1 A 2 A_Light1;
		Goto LightDone;
	Spawn:
		PPKP A -1;
		Stop;
	}
}

class WaltherPPKLoaded : Ammo
{
	Default
	{
	Tag "9x19mm";
	+INVENTORY.IGNORESKILL
	Inventory.MaxAmount 8;
	Inventory.Icon "WALT01";
	}
}

class PPKTracer : LugerTracer
{
	Default
	{
	DamageFunction 12;
	Speed 90;
	}
}