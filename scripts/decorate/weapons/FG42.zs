class FG42 : NaziWeapon
{
	Default
	{
		Scale 0.45;
		Weapon.AmmoType "FG42Loaded";
		Weapon.AmmoUse 1;
		Weapon.AmmoType2 "NewMauserAmmo";
		Weapon.AmmoUse2 1;
		Weapon.AmmoGive2 20;
		Weapon.UpSound "FG42COK";
		Weapon.SlotNumber 5;
		Inventory.PickupMessage "You got the FG-42!";
		Weapon.SelectionOrder 50;
		+WEAPON.NOAUTOFIRE
		Tag "FG 42";
	}
	States
	{
	Ready:
		F42I A 0 A_JumpIfInventory("SniperZoom",1,"ScopedReady");
		F42I A 0 A_JumpIfInventory("FG42Loaded",0,2);
		F42I A 0 A_JumpIfInventory("NewMauserAmmo",1,2);
		F42I A 1 A_WeaponReady;
		Loop;
		F42I A 1 A_WeaponReady(WRF_ALLOWRELOAD);
		Loop;
	ScopedReady:
		SCO1 A 0 A_JumpIfInventory("FG42Loaded",0,2);
		SCO1 A 0 A_JumpIfInventory("NewMauserAmmo",1,2);
		SCO1 A 1 A_WeaponReady(WRF_NOBOB);
		Goto Ready;
		SCO1 A 1 A_WeaponReady(WRF_NOBOB|WRF_ALLOWRELOAD);
		Goto Ready;
	Select:
		F42I A 0 A_Raise;
		F42I A 1 A_Raise;
		Loop;
	Deselect:
		F42I A 0 A_JumpIfReloading(4);
		F42I A 0 A_JumpIfInventory("SniperZoom",1,"ScopedDeselect");
		F42I A 0 A_Lower;
		F42I A 1 A_Lower;
		Loop;
		F42I T 3 Offset(0,60);
		F42I S 3 Offset(0,51);
		F42I R 3 Offset(0,42);
		F42I A 2 Offset(0,36);
		F42I A 2 Offset(0,33) A_Reloading(0);
		Loop;
	ScopedDeselect:
		SCO1 A 0 A_TakeInventory("SniperZoom");
		SCO1 A 0 A_StartSound("mauser/scope");
		SCO1 A 1 A_ZoomFactor(1.0);
		Goto Deselect;
	Fire:
		F42I A 0 A_JumpIfReloading("ReloadEnd");
		F42I A 0 A_JumpIfInventory("FG42Loaded",1,1);
		Goto Dryfire;
		F42I A 0 A_AlertMonsters;
		F42I A 0 A_StartSound("FG42FIR", CHAN_WEAPON); // fg42/fire
		F42I A 0 A_SpawnItemEx("MauserRifleCasing",12,-20,32,8,random(-2,2),random(0,4),random(-55,-80),SXF_NOCHECKPOSITION);
		F42I A 0 A_JumpIfInventory("SniperZoom", 1, "ScopedFire");
		F42I A 0 A_GunFlash;
		F42F A 1 BRIGHT A_FireProjectile("Kar98kTracer",frandom(-0.1,0.1));
		F42I A 0 A_JumpIf(waterlevel > 0,2);
		F42I A 0 A_FireProjectile("ShotSmokeSpawner",0,0,0,random(-4,4),0,0);
		F42F B 1 A_SetPitch(pitch-(2.0*boa_recoilamount));
		F42F C 1 A_SetPitch(pitch-(1.0*boa_recoilamount));
		F42I A 1 A_SetPitch(pitch+(1.5*boa_recoilamount));
		F42I A 1 A_CheckReload;
		F42I A 0 A_Refire;
		Goto Ready;
	ScopedFire:
		SCO1 A 2 A_FireProjectile("Kar98kTracer",frandom(-0.1,0.1));
		SCO1 A 0 A_JumpIf(height<=30,"ScopedFireLowRecoil");
		SCO1 A 0 A_JumpIf(waterlevel > 0,2);
		SCO1 A 0 A_FireProjectile("ShotSmokeSpawner",0,0,0,random(-4,4),0,0);
		SCO1 A 2 A_SetPitch(pitch-(2.0*boa_recoilamount));
		SCO1 A 2 A_SetPitch(pitch-(1.0*boa_recoilamount));
		SCO1 A 1 A_SetPitch(pitch+(1.5*boa_recoilamount));
		SCO1 A 1 A_CheckReload;
		SCO1 A 0 A_Refire;
		Goto Ready;
	ScopedFireLowRecoil:
		SCO1 A 0 A_JumpIf(waterlevel > 0,2);
		SCO1 A 0 A_FireProjectile("ShotSmokeSpawner",0,0,0,random(-4,4),0,0);
		SCO1 A 2 A_SetPitch(pitch-(1.5*boa_recoilamount));
		SCO1 A 2 A_SetPitch(pitch-(0.5*boa_recoilamount));
		SCO1 A 1 A_SetPitch(pitch+(0.75*boa_recoilamount));
		SCO1 A 1 A_CheckReload;
		SCO1 A 0 A_Refire;
		Goto Ready;
	Flash:
		TNT1 A 1 A_Light2;
		TNT1 A 1;
		TNT1 A 2 A_Light1;
		Goto LightDone;
	AltFire:
		F42I A 0 A_JumpIfReloading("ReloadEnd");
		SCO1 A 0 A_JumpIfInventory("SniperZoom",1,"ZoomOut");
		SCO1 A 0 A_StartSound("mauser/scope");
		SCO1 A 0 A_GiveInventory("SniperZoom");
		SCO1 A 2 A_ZoomFactor(6.0);
		Goto Ready;
	ZoomOut:
		SCO1 A 0 A_TakeInventory("SniperZoom");
		SCO1 A 0 A_StartSound("mauser/scope");
		SCO1 A 2 A_ZoomFactor(1.0);
		Goto Ready;
	Reload:
		SCO1 A 0 A_Reloading;
		SCO1 A 0 A_JumpIfInventory("SniperZoom",1,2);
		SCO1 A 0 A_Jump(256,4);
		SCO1 A 0 A_TakeInventory("SniperZoom");
		SCO1 A 0 A_StartSound("mauser/scope");
		SCO1 A 2 A_ZoomFactor(1.0);
		F421 A 2;
		F421 B 2;
		F421 C 2;
		F421 D 2;
		F421 E 2;
		F421 F 2;
		F421 G 2;
		F421 H 2;
		F421 I 2;
		F421 J 2;
		F421 K 2;
		F421 L 2;
		F421 M 2;
		F421 N 2;
		TNT1 A 0 A_StartSound("FG42OUT", CHAN_5);
		F421 O 2;
		F421 P 2;
		F421 Q 2;
		F421 R 2;
		F421 S 2;
		F421 T 5;
	ReloadLoop:
		TNT1 A 0 A_TakeInventory("NewMauserAmmo",1,TIF_NOTAKEINFINITE);
		TNT1 A 0 A_GiveInventory("FG42Loaded");
		TNT1 A 0 A_JumpIfInventory("FG42Loaded",0,"ReloadFinish");
		TNT1 A 0 A_JumpIfInventory("NewMauserAmmo",1,"ReloadLoop");
	ReloadFinish:
        F422 A 2;
		F422 B 2;
		F422 C 2;
		TNT1 A 0 A_StartSound("FG42IN", CHAN_5);
		F422 D 2;
		F422 E 2;
		F422 F 2;
		F422 G 2;
		F422 H 2;
		F422 I 2;
		F423 A 2;
		F423 B 2;
		F423 C 2;
		F423 D 2;
		F423 E 2;
		F423 F 2;
		F423 G 2;
		F423 H 2;
		TNT1 A 0 A_StartSound("FG42COK", CHAN_5);
		F423 I 2;
		F423 J 2;
		F423 K 2;
		F423 L 2;
		F423 M 2;
		F423 N 2;
		F423 O 2;
		F423 P 2;
		F423 Q 2;
		F423 R 2;
		F423 S 2;		
		F42I A 1 A_Reloading(0);
		Goto Ready;
	Spawn:
		F42P A -1;
		Stop;
	}
}

class FG42Loaded : Ammo
{
	Default
	{
		Tag "7.92x57mm";
		+Inventory.IGNORESKILL
		Inventory.MaxAmount 20;
		Inventory.Icon "MAUS01";
	}
}
