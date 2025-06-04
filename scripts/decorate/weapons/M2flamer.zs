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

class M2Flamer : NaziWeapon replaces Pyrolight
{
	Default
	{
	//$Category Weapons (BoA)
	//$Title (5) Pyrolight
	//$Color 14
	Weapon.SelectionOrder 800;
	Inventory.PickupMessage "You got the SodomUndGomorraKraftwerk modified M2 Flamethrower! Burn, baby, burn...";
	Weapon.AmmoType "NewFlameAmmo";
	Weapon.AmmoUse 1;
	Weapon.AmmoGive 125;
	Weapon.UpSound "flamer/select";
	Tag "M2 Flamethrower (SUGK)";
	Scale 0.5;
	}
	States
	{
	Ready:
		M2FI A 0 A_JumpIfInventory("NewFlameAmmo",10,4);
		M2FI A 0 A_JumpIfInventory("NewFlameAmmo",1,2);
		M2FI A 1 A_WeaponReady(WRF_NOSECONDARY);
		Loop;
		M2FI A 1 A_WeaponReady(WRF_ALLOWRELOAD|WRF_NOSECONDARY);
		Loop;
		M2FI A 0 A_JumpIfInventory("NewFlameAmmo",0,2);
		M2FI A 0 A_JumpIfInventory("NewFlameAmmo",1,2);
		M2FI A 1 A_WeaponReady;
		Loop;
		M2FI A 1 A_WeaponReady(WRF_ALLOWRELOAD);
		Loop;
	Deselect:
	    TNT1 A 0 A_StopSound(1);
		M2FI A 0 A_Lower;
		M2FI A 1 A_Lower;
		Loop;
	Select:
		M2FI A 0 A_Raise;
		M2FI A 1 A_Raise;
		Loop;
	Fire:
		M2FI A 0 A_JumpIf(waterlevel>= 2,"NoWay");
		M2FI A 0 A_JumpIfInventory("NewFlameAmmo",1,1);
		Goto Dryfire;
		M2FI A 0 A_Light2;
		M2FI A 0 A_AlertMonsters;
		M2FI A 1 Offset(0,35) A_FireProjectile("Flamebolt");
		M2FI A 1 Offset(0,36);
		M2FI A 0 A_Light0;
		M2FI A 0 A_Refire;
		M2FI A 20 A_GunFlash;
		Goto Ready;
	Flash:
		TNT1 A 1 A_StartSound("flamer/steam",CHAN_5);
		TNT1 AAAAAAAAAAA 0 A_FireProjectile("ChainSmokeSpawner",0,0,0,random(-4,4),0,0);
		Stop;
	NoWay:
		M2FI A 1 A_WeaponReady(WRF_NOFIRE|WRF_NOBOB);
		Goto Ready;
	AltFire:
		M2FI A 0 A_JumpIf(waterlevel>= 2,"NoWay");
		M2FI A 0 A_JumpIfInventory("NewFlameAmmo",10,1);
		Goto Dryfire;
		M2FI A 0 A_TakeInventory("NewFlameAmmo",10,TIF_NOTAKEINFINITE);
		M2FI A 0 A_StartSound("M2FIR",CHAN_WEAPON,1);
		M2FI A 0 A_AlertMonsters;
		M2FI A 1 A_FireProjectile("Flameball",0,0);
		M2FI A 1 Offset(0,34);
		M2FI A 1 Offset(0,36);
		M2FI A 1 Offset(0,40);
		M2FI A 1 Offset(0,44);
		M2FI A 1 Offset(0,45);
		M2FI A 1 Offset(0,43);
		M2FI A 1 Offset(0,40);
		M2FI A 1 Offset(0,36);
		M2FI A 11 Offset(0,32) A_GunFlash;
		Goto Ready;
	Spawn:
		M2FP A -1;
		Loop;
	}
}

class NewFlamebolt : GrenadeBase Replaces Flamebolt
{
	Default
	{
	DamageFunction (random(1,4));
	Alpha 0.9;
	RenderStyle "Add";
	Speed 25;
	Radius 16;
	Scale 0.1;
	Projectile;
	+BLOODLESSIMPACT
	+RIPPER
	+WINDTHRUST
	SeeSound "flamer/fire";
	DamageType "Fire";
	Decal "Scorch";
	Obituary "$OBPYRO";
	ProjectileKickback 20;
	GrenadeBase.FearDistance 96;
	}
	States
	{
	Spawn:
	    TNT1 A 2;
		"####" A 1 NODELAY A_Jump(256, "Flame1", "Flame2", "Flame3", "Flame4");
		Stop;
	Flame1:
		FLM1 A 0;
		Goto Animation;
	Flame2:
		FLM2 A 0;
		Goto Animation;
	Flame3:
		FLM3 A 0;
		Goto Animation;
	Flame4:
		FLM4 A 0;
		Goto Animation;
	Animation:
		"####" AAAAA 3 BRIGHT LIGHT("BOAFLAMW")
			{
				A_SetScale(Scale.X+0.05);
				A_FadeOut(0.05);
				A_Explode(2,16);
				A_RadiusGive("HeatShaderControl", radius+64, RGF_PLAYERS | RGF_GIVESELF, 32);
				if (waterlevel > 0) {
					A_ScaleVelocity(0.0);
					return A_Jump(256, "Smoke1", "Smoke2", "Smoke3");
				}
				return ResolveState(null);
			}
		"####" A 0 A_Jump(128, "Smoke1", "Smoke2", "Smoke3");
		Goto Death;
	Smoke1:
		"####" A 0 A_SpawnItemEx("FlamerSmoke1");
		Goto Death;
	Smoke2:
		"####" A 0 A_SpawnItemEx("FlamerSmoke2");
		Goto Death;
	Smoke3:
		"####" A 0 A_SpawnItemEx("FlamerSmoke3");
		Goto Death;
	Death:
		"####" A 0 A_SpawnItemEx("ZScorch");
	Death.Loop:
		"####" A 1 LIGHT("BOAFLAMW")
			{
				A_SetScale(Scale.X+0.05);
				A_FadeOut(0.05);
				A_Explode(2,64);
			}
		Goto Death.Loop;
	}
}

class NewFlameball : NewFlamebolt replaces Flameball
{
	Default
	{
	Damage 30;
	Speed 20;
	Scale 0.3;
	-RIPPER
	+WINDTHRUST
	SeeSound "flamer/napalm";
	DeathSound "nebelwerfer/xplode";
	RenderStyle "Add";
	GrenadeBase.FearDistance 256;
	}
	States
	{
	Spawn:
	    TNT1 A 2;
		FBAL A 2 BRIGHT LIGHT("BOAFLMW2")
			{
				A_SpawnItemEx("TracerSpark", random(-32,32), random(-32,32), random(-32,32), random(-2,2), random(-2,2), random(-2,2), random(0,359));
				A_SpawnItemEx("TracerSpark", random(-32,32), random(-32,32), random(-32,32), random(-2,2), random(-2,2), random(-2,2), random(0,359));
				A_SpawnItemEx("TracerSpark", random(-32,32), random(-32,32), random(-32,32), random(-2,2), random(-2,2), random(-2,2), random(0,359));
				A_RadiusGive("HeatShaderControl", radius+64, RGF_PLAYERS | RGF_GIVESELF, 64);
				if (waterlevel > 0) {
					A_ScaleVelocity(0.0);
					return ResolveState("Death");
				}
				return ResolveState(null);
			}
		"####" A 0 A_Jump(192, "Smoke1", "Smoke2", "Smoke3");
		Loop;
	Smoke1:
		"####" A 0 A_SpawnItemEx("FlamerSmoke1");
		"####" A 0 A_Jump (192,1,2);
		"####" A 0 A_SpawnItemEx("Flame_Small");
		"####" A 0 A_SpawnItemEx("Flame_Small");
		Goto Spawn;
	Smoke2:
		"####" A 0 A_SpawnItemEx("FlamerSmoke2");
		"####" A 0 A_Jump (192,1,2);
		"####" A 0 A_SpawnItemEx("Flame_Small");
		"####" A 0 A_SpawnItemEx("Flame_Small");
		Goto Spawn;
	Smoke3:
		"####" A 0 A_SpawnItemEx("FlamerSmoke3");
		"####" A 0 A_Jump (192,1,2);
		"####" A 0 A_SpawnItemEx("Flame_Small");
		"####" A 0 A_SpawnItemEx("Flame_Small");
		Goto Spawn;
	Death:
		"####" A 0 A_SpawnItemEx("NebFloor");
		"####" A 0 A_SpawnItemEx("NebSmokeFloor");
		"####" A 0 A_SpawnItemEx("NebSmokeMushroom",0,0,0);
		"####" A 0 A_SpawnItemEx("NebSmokePillar",0,0,0,0,0,2);
		"####" A 0 A_SetScale(1.0);
		"####" AAAAAAAAAAAAAAAAAAAA 0 A_SpawnItemEx("TracerSpark", random(-32,32), random(-32,32), random(-32,32), random(-4,4), random(-4,4), random(-4,4), random(0,359));
		FBLX A 2 BRIGHT LIGHT("BOAFLMW2") { A_Explode(96,128); A_SpawnItemEx("ZScorch"); }
		FBLX A 0 A_RadiusGive("BlurShaderControl", 128, RGF_PLAYERS | RGF_GIVESELF, 80);
		FBLX BCDEFGHIJK 2 BRIGHT LIGHT("BOAFLMW2");
		Stop;
	}
}