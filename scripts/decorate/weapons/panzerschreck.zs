/*
 * Copyright (c) 2015-2021 Tormentor667, Ozymandias81, Ed the Bat, MaxED, Talon1024,
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

class Panzerschreck : NaziWeapon
{
	Default
	{
	//$Category Weapons (BoA)
	//$Title (7) Panzerschreck
	//$Color 14
	Weapon.SelectionOrder 10000;
	Inventory.PickupMessage "$PZSIA";
	Tag "Panzerschreck";
	Weapon.AmmoType "PanzerschreckLoaded";
	Weapon.AmmoUse 1;
	Weapon.AmmoType2 "PanzerAmmo";
	Weapon.AmmoGive2 1;
	Weapon.AmmoUse2 1;
	Weapon.UpSound "Panzer/select";
	Radius 18;
	Height 12;
	+WEAPON.NOAUTOFIRE
	+NaziWeapon.NORAMPAGE
	Scale .55;
	}
	States
	{
	Ready:
		PZSI A 0 A_JumpIfInventory("PanzerschreckLoaded",0,2);
		PZSI A 0 A_JumpIfInventory("PanzerAmmo",1,2);
		PZSI A 1 A_WeaponReady;
		Loop;
		PZSI A 1 A_WeaponReady(WRF_ALLOWRELOAD);
		Loop;
	Select:
		PZSI A 1 A_Raise;
		Loop;
	Deselect:
		PZSI A 1 A_Lower;
		Loop;
	AltFire:
		PZS1 A 2;
		PZS1 B 2;
		PZS1 C 2;
		PZS1 D 2;
		PZS1 E 2;
		PZS1 F 2;
		PZS1 G 2;
		PZS1 H 2;
	AltHold:
		PZS1 H 1;
		PZS1 H 1A_Refire;
		Goto FireFinish;
	FireFinish:
		PZS1 H 2;
		PZS1 G 2;
		PZS1 F 2;
		PZS1 E 2;
		PZS1 D 2;
		PZS1 C 2;
		PZS1 B 2;
		PZS1 A 2;
		PZSI A 1 A_WeaponReady;
		Goto Ready;
	Flash:
		TNT1 A 1 BRIGHT A_Light2;
		TNT1 A 1 BRIGHT;
		TNT1 A 2 A_Light1;
		Goto LightDone;
	Fire:
		PZSI A 0 A_JumpIfInventory("PanzerschreckLoaded",1,1);
		Goto Dryfire;
		PZSI A 0 A_StartSound("Panzer/fire", CHAN_WEAPON);
		PZSI A 0 A_GunFlash;
		PZSI A 2 BRIGHT A_FireProjectile("PanzerRocket",0,1,12,0);
		PZSI A 1 Offset(6,34);
		PZSI A 1 Offset(14,36);
		PZSI A 1 Offset(24,39);
		PZSI A 1 Offset(28,43);
		PZSI A 1 Offset(31,48);
		PZSI A 1 Offset(27,44);
		PZSI A 1 Offset(23,40);
		PZSI A 1 Offset(18,36);
		PZSI A 1 Offset(12,34);
		PZSI A 1 Offset(6,32);
		PZSI A 1 Offset(3,30);
		PZSI A 1 Offset(1,29);
		PZSI A 1 Offset(-2,30);
		PZSI A 1 Offset(-1,32);
		TNT1 A 0 A_CheckReload;
		Goto Ready;
	Reload:
		TNT1 A 0 A_StartSound("Panzer/load", CHAN_WEAPON);
		PZS1 A 2;
		PZS1 B 2;
		PZS1 C 2;
		PZS1 D 2;
		PZS1 E 2;
		PZS1 F 2;
		PZS1 G 2;
		PZS1 H 2;
		PZS2 A 2;
		PZS2 B 2;
		PZS2 C 2;
		PZS2 D 2;
		PZS2 E 2;
		PZS2 F 2;
		PZS2 G 2;
		PZS2 H 2;
		PZS2 I 2;
		PZS2 J 2;
		PZS2 K 2;
		PZS2 L 2;
		PZS2 M 2;
		PZS2 N 2;
		PZS2 O 2;
		PZS2 P 2;
		PZS2 Q 2;
		PZS2 R 2;
		PZS2 S 2;
		PZS2 T 2;		
		TNT1 A 0 A_TakeInventory("PanzerAmmo",1);
		TNT1 A 0 A_GiveInventory("PanzerschreckLoaded");
		PZS3 A 2;
		PZS3 B 2;
		PZS3 C 2;
		PZS3 D 2;
		PZS3 E 2;
		PZS3 F 2;
		PZS3 G 2;
		Goto Ready;
	Spawn:
		PANP A -1;
		Loop;
	}
}

class PanzerschreckLoaded : Ammo
{
	Default
	{
	+INVENTORY.IGNORESKILL
	Tag "$TAGLOADD";
	Inventory.Icon "PANZ01";
	}
}

class PanzerRocket : GrenadeBase
{
	Default
	{
	Radius 5;
	Height 6;
	Speed 70;
	Projectile;
	-NOTELEPORT
	+WINDTHRUST
	+THRUGHOST
	DamageFunction (2500);
	DamageType "Rocket";
	Decal "Scorch";
	Obituary "$OBPANZA";
	ProjectileKickback 25000;
	GrenadeBase.SplashType "Missile";
	}
	States
	{
	Spawn:
		MNSS A 1 BRIGHT LIGHT("BOAFLMW2") NODELAY A_StartSound("panzer/fly", CHAN_VOICE, CHANF_LOOPING, 1.0);
		MNSS A 1 BRIGHT LIGHT("BOAFLMW2") A_SpawnItemEx("RocketFlame",random(-1,1),0,random(-1,1));
		Wait;
	Death:
		EXP1 A 0 A_SpawnGroundSplash;
		EXP1 A 0 A_SetScale(0.75,0.75);
		EXP1 A 0 A_StopSound(CHAN_VOICE);
		EXP1 A 0 A_StartSound("panzer/explode", CHAN_VOICE, 0, 1.0, ATTN_NORM);
		EXP1 A 0 { A_Explode(192); A_SpawnItemEx("ZScorch"); } //if we define fulldamagedistance on A_Explode, damage STARTS from that value and not INSIDE it
		TNT1 AAAAAAAAAAAAAAAAAAAAAAAAAAA 0 A_SpawnItemEx("TracerSpark_Longlive", 0, 0, 0, random(-5,5), random(-5,5), random(-5,5), random(0,359)); //T667 improvements
		TNT1 A 0 A_SpawnItemEx("PanzerNuke",0,0,0,0,0,0,0,SXF_TRANSFERPOINTERS|SXF_NOCHECKPOSITION);
		TNT1 A 8 A_SpawnItemEx("GeneralExplosion_Large",56,0,32);
		EXP1 A 2 BRIGHT LIGHT("BOAFLMW2") A_Quake(9,15,0,1024,"");
		EXP1 BCDEFGHIJKLMN 2 BRIGHT LIGHT("BOAFLMW2");
		Stop;
	}
}

class EnemyPanzerRocket : PanzerRocket
{
	Default
	{
	DamageType "Rocket2";
	Speed 20;
	FastSpeed 25;
	DamageFunction (random(35,55));
	}
	States
	{
	Death:
		EXP1 A 0 A_SpawnGroundSplash;
		EXP1 A 0 A_SetScale(0.75,0.75);
		EXP1 A 0 A_StopSound(CHAN_VOICE);
		EXP1 A 0 A_StartSound("panzer/explode", CHAN_VOICE, 0, 1.0, ATTN_NORM);
		EXP1 A 0 { A_Explode(0, 192, 0, TRUE, 320); A_SpawnItemEx("ZScorch"); } //this is different so panzerguards doesn't die if they shot right down their feet
		TNT1 AAAAAAAAAAAAAAAAAAAAAAAAAAA 0 A_SpawnItemEx("TracerSpark_Longlive", 0, 0, 0, random(-5,5), random(-5,5), random(-5,5), random(0,359)); //T667 improvements
		TNT1 A 0 A_SpawnItemEx("PanzerNuke",0,0,0,0,0,0,0,SXF_TRANSFERPOINTERS|SXF_NOCHECKPOSITION);
		TNT1 A 8 A_SpawnItemEx("GeneralExplosion_NazisL",56,0,32);
		EXP1 A 2 BRIGHT LIGHT("BOAFLMW2") A_Quake(9,15,0,1024,"");
		EXP1 BCDEFGHIJKLMN 2 BRIGHT LIGHT("BOAFLMW2");
		Stop;
	}
}

class BabyEnemyPanzerRocket : EnemyPanzerRocket	{ Default { Speed 15; FastSpeed 20; DamageFunction (random(25,40)); } }
class HardEnemyPanzerRocket : EnemyPanzerRocket	{ Default { Speed 25; FastSpeed 30; DamageFunction (random(45,65)); } }

class PanzerBoom : EnemyPanzerRocket
{
	Default
	{
	Damage 0;
	}
	States
	{
	Spawn:
		TNT1 A 0 NODELAY;
	Death:
		EXP1 A 0 A_SetScale(0.75,0.75);
		EXP1 A 0 A_StopSound(CHAN_VOICE);
		EXP1 A 0 A_StartSound("panzer/explode", CHAN_VOICE, 0, 1.0, ATTN_NORM);
		EXP1 A 0 A_Explode(0, 144, 0, TRUE, 256);
		TNT1 AAAAAAAAAAAAAAAAAAAAAAAAAAA 0 A_SpawnItemEx("TracerSpark_Longlive", 0, 0, 0, random(-5,5), random(-5,5), random(-5,5), random(0,359)); //T667 improvements
		TNT1 A 0 A_SpawnItemEx("PanzerNuke",0,0,0,0,0,0,0,SXF_TRANSFERPOINTERS|SXF_NOCHECKPOSITION);
		TNT1 A 8 A_SpawnItemEx("GeneralExplosion_Large",56,0,32);
		EXP1 A 2 BRIGHT LIGHT("BOAFLMW2") A_Quake(9,15,0,1024,"");
		EXP1 BCDEFGHIJKLMN 2 BRIGHT LIGHT("BOAFLMW2");
		Stop;
	}
}