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

class M1Thompson : NaziWeapon
{
	Default
	{
	//$Category Weapons (BoA)
	//$Title (4) MP40
	//$Color 14
	Scale .5;
	Weapon.SelectionOrder 620;
	Weapon.SlotNumber 4;
	Weapon.AmmoType "ThompsonLoaded";
	Weapon.AmmoUse 1;
	Weapon.AmmoType2 "Ammo45ACP";
	Weapon.AmmoUse2 1;
	Weapon.UpSound "TGCOK";
	Tag "M1A1 Thompson";
	Inventory.PickupMessage "You got the M1A1 Thompson!";
	Weapon.AmmoGive2 30;
	}
	States
	{
	Ready:
		M1TI A 0 A_JumpIfInventory("ThompsonLoaded",0,2);
		M1TI A 0 A_JumpIfInventory("Ammo45ACP",1,2);
		M1TI A 1 A_WeaponReady;
		Loop;
		M1TI A 1 A_WeaponReady(WRF_ALLOWRELOAD);
		Loop;
	Deselect:
		M1TI A 0 A_Lower;
		M1TI A 1 A_Lower;
		Loop;
	Select:
		M1TI A 0 A_Raise;
		M1TI A 1 A_Raise;
		Loop;
	Fire:
		M1TI A 0 A_JumpIfInventory("ThompsonLoaded",1,1);
		Goto Dryfire;
		M1TI A 0 A_GunFlash;
		M1TI A 0 A_SetPitch(pitch-(0.5*boa_recoilamount));
		M1TI A 0 A_JumpIf(waterlevel > 0,2);
		M1TI A 0 A_FireProjectile("ChainSmokeSpawner",0,0,0,random(-4,4),0,0);
		M1TI A 0 A_StartSound("TGFIR", CHAN_WEAPON, 0, frandom(0.6, 0.8));
		M1TI A 0 A_SpawnItemEx("Casing9mm",12,-20,32,8,random(-2,2),random(0,4),random(-55,-80),SXF_NOCHECKPOSITION);
		M1TI A 0 A_AlertMonsters;
		M1TF A 1 BRIGHT A_FireProjectile("M1ThompsonTracer",frandom(-1.4,1.4));
		M1TF B 1;
		M1TF C 1;
		TNT1 A 0 A_CheckReload;
		Goto Ready;
	Reload:
		M1T1 A 2;
		M1T1 B 2;
		M1T1 C 2;
		M1T1 D 2;
		M1T1 E 2;
		M1T1 F 2;
		TNT1 A 0 A_StartSound("TGOUT", CHAN_5);
		M1T1 G 2;
		M1T1 H 2;
		M1T1 I 2;
		M1T1 J 2;
		M1T1 K 5;
	ReloadLoop:
		TNT1 A 0 A_TakeInventory("Ammo45ACP",1,TIF_NOTAKEINFINITE);
		TNT1 A 0 A_GiveInventory("ThompsonLoaded");
		TNT1 A 0 A_JumpIfInventory("ThompsonLoaded",0,"ReloadFinish");
		TNT1 A 0 A_JumpIfInventory("Ammo45ACP",1,"ReloadLoop");
	ReloadFinish:
		M1T2 A 2;
		M1T2 B 2;
		M1T2 C 2;
		M1T2 D 2;
		M1T2 E 2;
		TNT1 A 0 A_StartSound("TGTAP", CHAN_5);
		M1T2 F 2;
		M1T2 G 2;
		M1T2 H 2;
		M1T2 I 2;
		TNT1 A 0 A_StartSound("TGIN", CHAN_5);
		M1T2 J 2;
		M1T2 K 2;
		M1T2 L 2;
		M1T3 A 2;
		M1T3 B 2;
		M1T3 C 2;
		TNT1 A 0 A_StartSound("TGCOK", CHAN_5);
		M1T3 D 2;
		M1T3 E 2;
		M1T3 F 2;
		M1T3 G 2;
		M1T3 H 2;
		M1T3 I 2;
		M1T3 J 2;
		M1T3 K 2;
		M1T3 L 2;
		M1T3 M 2;
		M1TI A 1 A_WeaponReady(WRF_NOBOB);
		Goto Ready;
	Flash:
		TNT1 A 1 A_Light2;
		TNT1 A 1;
		TNT1 A 2 A_Light1;
		Goto LightDone;
	Spawn:
		M1TP A -1;
		Stop;
	}
}

class M1ThompsonTracer : PlayerTracer
{
  Default
  {
	ProjectileKickback 100;
	Damage 15;
	Speed 120;
  }
}

class ThompsonLoaded : Ammo
{
  Default
  {
	Tag ".45 ACP";
	Inventory.MaxAmount 30;
	+Inventory.IGNORESKILL
	Inventory.Icon "FUDD01";
  }
}
