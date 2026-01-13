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
	Weapon.UpSound "weapon/Launcher/raise";
	Radius 18;
	Height 12;
	+WEAPON.NOAUTOFIRE
	+NaziWeapon.NORAMPAGE
	Scale .55;
	}
	States
	{
	Deselect:
			//TNT1 A 0 A_StartSound("Weapons/C96/Lower", CHAN_AUTO, CHANF_OVERLAP, 1.0);
			PANZ A 1 Offset(0,32);
			PANZ A 1 Offset(-4, 36);
			PANZ A 1 Offset(-16, 52);
			PANZ A 1 Offset(-28, 71);
			PANZ A 1 Offset(-40, 90);
			PANZ A 1 Offset(-52, 109);
			TNT1 A 0 Offset(-64, 128);
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
			TNT1 A 0 A_WeaponOffset(-64, 128, WOF_INTERPOLATE);
			PANZ A 1 A_WeaponOffset(-52, 109, WOF_INTERPOLATE);
			PANZ A 1 A_WeaponOffset(-40, 90, WOF_INTERPOLATE);
			PANZ A 1 A_WeaponOffset(-28, 71, WOF_INTERPOLATE);
			PANZ A 1 A_WeaponOffset(-16, 52, WOF_INTERPOLATE);
			PANZ A 1 A_WeaponOffset(-4, 36, WOF_INTERPOLATE);
			PANZ A 1 A_WeaponOffset(0,32, WOF_INTERPOLATE);
		Ready1:
			PANZ A 1 A_WeaponReady(WRF_ALLOWRELOAD);
			Loop;
		AltFire:
			PANZ A 1 A_WeaponOffset(0, 32, WOF_INTERPOLATE);
			PANZ A 1 A_WeaponOffset(4, 48, WOF_INTERPOLATE);
			PANZ A 1 A_WeaponOffset(8, 64, WOF_INTERPOLATE);
			PANZ A 1 A_WeaponOffset(16, 80, WOF_INTERPOLATE);
			PANZ A 1 A_WeaponOffset(24, 88, WOF_INTERPOLATE);
			PANZ A 1 A_WeaponOffset(32, 96, WOF_INTERPOLATE);
			PANZ A 1 A_WeaponOffset(48, 100, WOF_INTERPOLATE);
			PANZ A 1 A_WeaponOffset(64, 104, WOF_INTERPOLATE);
			PANZ A 1 A_WeaponOffset(80, 108, WOF_INTERPOLATE);
		AltHold:
			PANZ A 1 A_WeaponOffset(80, 108, WOF_INTERPOLATE);
			PANZ A 1 A_Refire;
			Goto AltFireFinish;
		AltFireFinish:
			PANZ A 1 A_WeaponOffset(80, 108, WOF_INTERPOLATE);
			PANZ A 1 A_WeaponOffset(64, 104, WOF_INTERPOLATE);
			PANZ A 1 A_WeaponOffset(48, 100, WOF_INTERPOLATE);
			PANZ A 1 A_WeaponOffset(32, 96, WOF_INTERPOLATE);
			PANZ A 1 A_WeaponOffset(24, 88, WOF_INTERPOLATE);
			PANZ A 1 A_WeaponOffset(16, 80, WOF_INTERPOLATE);
			PANZ A 1 A_WeaponOffset(8, 64, WOF_INTERPOLATE);
			PANZ A 1 A_WeaponOffset(4, 48, WOF_INTERPOLATE);
			PANZ A 1 A_WeaponOffset(0, 32, WOF_INTERPOLATE);
			PANZ A 1 A_WeaponReady;
			Goto Ready1;
	
		Flash:
			TNT1 A 1 BRIGHT A_Light2;
			TNT1 A 1 BRIGHT;
			TNT1 A 2 A_Light1;
			Goto LightDone;
	
		Fire:
			PANZ A 0 A_JumpIf(CountInv("PanzerschreckLoaded") == 0, "DryFire");
			PANZ A 2;
			PANZ B 2 BRIGHT
			{
				A_GunFlash();
				A_AlertMonsters();
				if(waterlevel > 0.2)
				{
					for(int i=0; i<10; i++)
					{
						//[Pop] Refactor later with new smoke system
						A_FireProjectile("ShotSmokeSpawner",frandom(4,-4),0,0,0,0,frandom(4,-4));
					}
				}
				A_StartSound("Panzer/fire", CHAN_WEAPON);
				A_FireProjectile("PanzerRocket",0,1,12,0);
			}
			PANZ A 16;
			TNT1 A 0 A_CheckReload;
			Goto Ready1;
		Reload:
			TNT1 A 0 A_JumpIf(CountInv("PanzerAmmo") == 0, "Ready1");
			TNT1 A 0 A_JumpIf(CountInv("PanzerschreckLoaded") == 1, "Ready1");
			PANZ ACD 10;
			TNT1 A 0 A_StartSound("Panzer/load", CHAN_WEAPON);
			PANZ EFG 10;
			TNT1 A 0 A_TakeInventory("PanzerAmmo",1);
			TNT1 A 0 A_GiveInventory("PanzerschreckLoaded");
			PANZ HDCA 10;
			Goto Ready1;
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