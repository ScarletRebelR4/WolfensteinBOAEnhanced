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
	Inventory.PickupMessage "$G43";
	Tag "Gewehr 43";
	Weapon.UpSound "G43COK";
	+WEAPON.NOAUTOFIRE;
	+NaziWeapon.NORAMPAGE
	}
	States
	{
	Select:
		G43I A 0 A_Raise;
		G43I A 1 A_Raise;
		Loop;
	Deselect:
		G43I A 0 A_Lower;
		G43I A 1 A_Lower;
		Loop;
	Ready:
		G43I A 0 A_JumpIfInventory("G43Loaded",0,2);
		G43I A 0 A_JumpIfInventory("MauserAmmo",1,2);
		G43I A 1 A_WeaponReady;
		Loop;
		G43I A 1 A_WeaponReady(WRF_ALLOWRELOAD);
		Loop;
	Fire:
		G43I A 0 A_JumpIfInventory("G43Loaded",1,1);
		Goto Dryfire;
		G43I A 0 A_StartSound("G43FIR",CHAN_WEAPON);
		G43I A 0 A_GunFlash;
		G43I A 0 A_SpawnItemEx("MauserRifleCasing",12,-20,32,8,random(-2,2),random(0,4),random(-55,-80),SXF_NOCHECKPOSITION);
		G43I A 0 A_AlertMonsters;
		G43F A 1 BRIGHT A_FireProjectile("G43Tracer");
		G43I A 0 A_JumpIf(waterlevel > 0,2);
		G43I A 0 A_FireProjectile("ShotSmokeSpawner",0,0,0,random(-4,4),0,0);
		G43F B 1 A_SetPitch(pitch-(1.4*boa_recoilamount));
		G43F C 1;
		TNT1 A 0 A_CheckReload;
		G43F D 1 A_WeaponReady(WRF_NOBOB);
		Goto Ready;
	Reload:
		G43I A 1;
		G431 A 2;
		G431 B 2;
		G431 C 2;
		G431 D 2;
		G431 E 2;
		G431 F 2;
		G431 G 2;
		TNT1 A 0 A_StartSound("G43OUT", CHAN_5);
		G431 H 2;
		G431 I 2;
		G431 J 2;
		G431 K 2;
		G431 L 2;
		G431 M 2;
		G431 N 2;
		G431 O 2;
	ReloadLoop:
		TNT1 A 0 A_TakeInventory("MauserAmmo",1,TIF_NOTAKEINFINITE);
		TNT1 A 0 A_GiveInventory("G43Loaded");
		TNT1 A 0 A_JumpIfInventory("G43Loaded",0,"ReloadFinish");
		TNT1 A 0 A_JumpIfInventory("MauserAmmo",1,"ReloadLoop");
	ReloadFinish:
	    G432 A 2;
		G432 B 2;
		G432 C 2;
		G432 D 2;
		G432 E 2;
		TNT1 A 0 A_StartSound("G43IN", CHAN_5);
		G432 F 2;
		G432 G 2;
		G432 H 2;
		G432 I 2;
		G432 J 2;
		G432 K 2;
		G432 L 2;
		G433 A 2;
		G433 B 2;
		G433 C 2;
		G433 D 2;
		TNT1 A 0 A_StartSound("G43COK", CHAN_5);
		G433 E 2;
		G433 F 2;
		G433 G 2;
		G433 H 2;
		G433 I 2;
		G433 J 2;
		G433 K 2;
		G433 L 2;
		G433 M 2;
		G433 N 2;
		G433 O 2;
		Goto Ready;
	Flash:
		TNT1 A 1 A_Light2;
		TNT1 A 1;
		TNT1 A 2 A_Light1;
		Goto LightDone;
	Spawn:
		M1GP A -1;
		Stop;
	}
}

class G43Loaded : Ammo
{
	Default
	{
	Tag "7.92x57mm";
	+INVENTORY.IGNORESKILL
	Inventory.MaxAmount 10;
	Inventory.Icon "MAUS01";
	}
}