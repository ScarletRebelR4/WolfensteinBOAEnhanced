//I don't know what was wrong with me but this thing has FOUR DIFFERENT AMMO STATES

Class MG42 : NaziWeapon
{
Default
{
	//$Category Weapons (Confiscated Weapons)
	//$Title (8) MG42
	//$Color 14
	Scale 0.5;
	Weapon.SlotNumber 7;
	Weapon.SelectionOrder 750;
	Weapon.AmmoType "MG42Loaded";
	Weapon.AmmoUse 1;
	Weapon.AmmoType2 "NewMauserAmmo";
	Weapon.AmmoUse2 1;
	Weapon.AmmoGive1 50;
	Weapon.AmmoGive2 100;
	Tag "MG 42";
	Inventory.PickupMessage "You got the Maschinengewehr 42!";
	Weapon.UpSound "MG42COK";
	}
	States
	{
	Select:
		TNT1 A 0 A_JumpIf(CountInv("MG42Loaded") == 0,"EmptySelect");
	    TNT1 A 0 A_JumpIf(CountInv("MG42Loaded") <= 5,"AlmostSelect");
	    TNT1 A 0 A_JumpIf(CountInv("MG42Loaded") <= 25,"HalfSelect");
		M42I A 0 A_Raise;
		M42I A 1 A_Raise;
		Loop;
	Deselect:
		TNT1 A 0 A_JumpIf(CountInv("MG42Loaded") == 0,"EmptyDeSelect");
	    TNT1 A 0 A_JumpIf(CountInv("MG42Loaded") <= 5,"AlmostDeSelect");
	    TNT1 A 0 A_JumpIf(CountInv("MG42Loaded") <= 25,"HalfDeSelect");
		TNT1 A 0 A_StopSound(CHAN_WEAPON);
		M42I A 0 A_Lower;
		M42I A 1 A_Lower;
		Loop;
	HalfSelect:
		M42I C 0 A_Raise;
		M42I C 1 A_Raise;
		Loop;
	HalfDeselect:
    	TNT1 A 0 A_StopSound(CHAN_WEAPON);
		M42I C 0 A_Lower;
		M42I C 1 A_Lower;
		Loop;
	AlmostSelect:
		M42I E 0 A_Raise;
		M42I E 1 A_Raise;
		Loop;
	AlmostDeselect:
	    TNT1 A 0 A_StopSound(CHAN_WEAPON);
		M42I E 0 A_Lower;
		M42I E 1 A_Lower;
		Loop;
	EmptySelect:
		M42I G 0 A_Raise;
		M42I G 1 A_Raise;
		Loop;
	EmptyDeselect:
	    TNT1 A 0 A_StopSound(CHAN_WEAPON);
		M42I G 0 A_Lower;
		M42I G 1 A_Lower;
		Loop;	
	Ready:
		TNT1 A 0 A_JumpIf(CountInv("MG42Loaded") == 0,"EmptyReady");
	    TNT1 A 0 A_JumpIf(CountInv("MG42Loaded") <= 5,"AlmostReady");
	    TNT1 A 0 A_JumpIf(CountInv("MG42Loaded") <= 25,"HalfReady");
		M42I A 0 A_JumpIfInventory("MG42Loaded",0,2);
		M42I A 0 A_JumpIfInventory("NewMauserAmmo",1,2);
		M42I A 1 A_WeaponReady;
		Loop;
		M42I A 1 A_WeaponReady(WRF_ALLOWRELOAD);
		Loop;
	HalfReady:	
		M42I C 0 A_JumpIfInventory("MG42Loaded",0,2);
		M42I C 0 A_JumpIfInventory("NewMauserAmmo",1,2);
		M42I C 1 A_WeaponReady;
		Loop;
		M42I C 1 A_WeaponReady(WRF_ALLOWRELOAD);
		Loop;
	AlmostReady:	
		M42I E 0 A_JumpIfInventory("MG42Loaded",0,2);
		M42I E 0 A_JumpIfInventory("NewMauserAmmo",1,2);
		M42I E 1 A_WeaponReady;
		Loop;
		M42I E 1 A_WeaponReady(WRF_ALLOWRELOAD);
		Loop;
	EmptyReady:	
		M42I G 0 A_JumpIfInventory("MG42Loaded",0,2);
		M42I G 0 A_JumpIfInventory("NewMauserAmmo",1,2);
		M42I G 1 A_WeaponReady;
		Loop;
		M42I G 1 A_WeaponReady(WRF_ALLOWRELOAD);
		Loop;		
	Fire:
		M42I A 0 A_JumpIfInventory("MG42Loaded",1,1);
		Goto Dryfire;
		M42I A 0 A_GunFlash;
		TNT1 A 0 A_JumpIf(CountInv("MG42Loaded") == 1,"Finalfire");
	    TNT1 A 0 A_JumpIf(CountInv("MG42Loaded") <= 5,"Almostfire");
	    TNT1 A 0 A_JumpIf(CountInv("MG42Loaded") <= 25,"Halffire");
		M42I A 0 A_PlaySound("MG42FIR",CHAN_WEAPON,1,1);
		M42I A 0 A_SpawnItemEx("MauserRifleCasing",12,-20,32,8,random(-2,2),random(0,4),random(-55,-80),SXF_NOCHECKPOSITION);
		M42I A 0 A_AlertMonsters;
		M42F A 1 BRIGHT A_FireProjectile("Kar98kTracer",frandom(-1.5,1.5),1,0,0,0,frandom(-1.0,1.0));
		M42I B 1 Offset(0,40) A_SetPitch(pitch-(1.6*boa_recoilamount));
		M42I A 0 A_JumpIf(waterlevel > 0,2);
		M42I A 0 A_FireProjectile("ChainSmokeSpawner",0,0,0,random(-4,4),0,0);
		M42I A 1 Offset(0,43) A_Refire;
		TNT1 A 0 A_StopSound(CHAN_WEAPON);
		M42I A 1 Offset(0,42) A_WeaponReady(WRF_NOBOB);
		M42I A 1 Offset(0,44) A_WeaponReady(WRF_NOBOB);
		M42I A 1 Offset(0,43) A_WeaponReady(WRF_NOBOB);
		M42I A 1 Offset(0,40) A_WeaponReady(WRF_NOBOB);
		M42I A 1 Offset(0,36) A_WeaponReady(WRF_NOBOB);
		M42I A 1 Offset(0,32) A_WeaponReady(WRF_NOBOB);
		Goto Ready;
		Halffire:
		M42I C 0A_PlaySound("MG42FIR",CHAN_WEAPON,1,1);
		M42I C 0 A_SpawnItemEx("MauserRifleCasing",12,-20,32,8,random(-2,2),random(0,4),random(-55,-80),SXF_NOCHECKPOSITION);
		M42I C 0 A_AlertMonsters;
		M42F B 1 A_FireProjectile("Kar98kTracer",frandom(-1.5,1.5),1,0,0,0,frandom(-1.0,1.0));
		M42I D 1 Offset(0,40) A_SetPitch(pitch-(1.6*boa_recoilamount));
		M42I C 0 A_JumpIf(waterlevel > 0,2);
		M42I C 0 A_FireProjectile("ChainSmokeSpawner",0,0,0,random(-4,4),0,0);
		M42I C 1 Offset(0,43) A_Refire;
		TNT1 A 0 A_StopSound(CHAN_WEAPON);
		M42I C 1 Offset(0,42) A_WeaponReady(WRF_NOBOB);
		M42I C 1 Offset(0,44) A_WeaponReady(WRF_NOBOB);
		M42I C 1 Offset(0,43) A_WeaponReady(WRF_NOBOB);
		M42I C 1 Offset(0,40) A_WeaponReady(WRF_NOBOB);
		M42I C 1 Offset(0,36) A_WeaponReady(WRF_NOBOB);
		M42I C 1 Offset(0,32) A_WeaponReady(WRF_NOBOB);
		Goto HalfReady;
		AlmostFire:
		M42I E 0 A_PlaySound("MG42FIR",CHAN_WEAPON,1,1);
		M42I E 0 A_SpawnItemEx("MauserRifleCasing",12,-20,32,8,random(-2,2),random(0,4),random(-55,-80),SXF_NOCHECKPOSITION);
		M42I E 0 A_AlertMonsters;
		M42F C 1 A_FireProjectile("Kar98kTracer",frandom(-1.5,1.5),1,0,0,0,frandom(-1.0,1.0));
		M42I F 1 Offset(0,40) A_SetPitch(pitch-(1.6*boa_recoilamount));
		M42I E 0 A_JumpIf(waterlevel > 0,2);
		M42I E 0 A_FireProjectile("ChainSmokeSpawner",0,0,0,random(-4,4),0,0);
		M42I E 1 Offset(0,43) A_Refire;
		TNT1 A 0 A_StopSound(CHAN_WEAPON);
		M42I E 1 Offset(0,42) A_WeaponReady(WRF_NOBOB);
		M42I E 1 Offset(0,44) A_WeaponReady(WRF_NOBOB);
		M42I E 1 Offset(0,43) A_WeaponReady(WRF_NOBOB);
		M42I E 1 Offset(0,40) A_WeaponReady(WRF_NOBOB);
		M42I E 1 Offset(0,36) A_WeaponReady(WRF_NOBOB);
		M42I E 1 Offset(0,32) A_WeaponReady(WRF_NOBOB);
		Goto AlmostReady;
		FinalFire:
		M42I A 0 A_PlaySound("MG42FIR",CHAN_WEAPON,1,1);
		M42I A 0 A_SpawnItemEx("MauserRifleCasing",12,-20,32,8,random(-2,2),random(0,4),random(-55,-80),SXF_NOCHECKPOSITION);
		M42I A 0 A_AlertMonsters;
		M42F C 1 A_FireProjectile("Kar98kTracer",frandom(-1.5,1.5),1,0,0,0,frandom(-1.0,1.0));
		M42I G 1 Offset(0,40) A_SetPitch(pitch-(1.6*boa_recoilamount));
		M42I G 0 A_JumpIf(waterlevel > 0,2);
		M42I G 0 A_FireProjectile("ChainSmokeSpawner",0,0,0,random(-4,4),0,0);
		M42I G 1 Offset(0,43) A_Refire;
		TNT1 A 0 A_StopSound(CHAN_WEAPON);
		M42I G 1 Offset(0,42) A_WeaponReady(WRF_NOBOB);
		M42I G 1 Offset(0,44) A_WeaponReady(WRF_NOBOB);
		M42I G 1 Offset(0,43) A_WeaponReady(WRF_NOBOB);
		M42I G 1 Offset(0,40) A_WeaponReady(WRF_NOBOB);
		M42I G 1 Offset(0,36) A_WeaponReady(WRF_NOBOB);
		M42I G 1 Offset(0,32) A_WeaponReady(WRF_NOBOB);
		Goto EmptyReady;
	Reload:
	    TNT1 A 0 A_StopSound(CHAN_WEAPON);
		M421 A 2;
		M421 B 2;
		M421 C 2;
		M421 D 2;
		M421 E 2;
		M421 F 2;
		M421 G 2;
		M421 H 2;
		M421 I 2;
		M421 J 2;
		M421 K 2;
		M421 L 2;
		M421 M 2;
		TNT1 A 0 A_PlaySound("MG42COK",CHAN_5);
		M421 N 2;
		M421 O 2;
		M421 P 2;
		M421 Q 2;
		M422 A 2;
		M422 B 2;
		M422 C 2;
		M422 D 2;
		M422 E 2;
		M422 F 2;
		M422 G 2;
		M422 H 2;
		M422 I 2;
		M422 J 2;
		M422 K 2;
		M422 L 2;
		M422 M 2;
		M422 N 2;
		M422 O 2;
		M422 P 2;
	ReloadLoop:
		MG42 C 0 A_TakeInventory("NewMauserAmmo",1,TIF_NOTAKEINFINITE);
		MG42 C 0 A_GiveInventory("MG42Loaded");
		MG42 C 0 A_JumpIfInventory("MG42Loaded",0,"ReloadFinish");
		MG42 C 0 A_JumpIfInventory("NewMauserAmmo",1,"ReloadLoop");
	ReloadFinish:
		M423 A 2;
		M423 B 2;
		M423 C 2;
		TNT1 A 0 A_PlaySound("MG42UP",CHAN_5);
		M423 D 2;
		M423 E 2;
		M423 F 2;
		M423 G 2;
		M423 H 2;
		M423 I 2;
		M423 J 2;
		M423 K 2;
		M423 L 2;
		TNT1 A 0 A_PlaySound("MG42IN",CHAN_5);
		M423 M 2;
		M423 N 2;
		M423 O 2;
		M423 P 2;
		M423 Q 2;
		M423 R 2;
		M423 S 2;
		M423 T 2;
		M424 A 2;
		TNT1 A 0 A_PlaySound("MG42DW",CHAN_5);
		M424 B 2;
		M424 C 2;
		M424 D 2;
		M424 E 2;
		M424 F 2;
		M424 G 2;
		M424 H 2;
		M424 I 2;
		M424 J 2;
		M424 K 2;
		M424 L 2;
		M424 M 2;
		M424 N 2;
		Goto Ready;
	Flash:
		TNT1 A 1 BRIGHT A_Light2;
		TNT1 A 1 BRIGHT;
		TNT1 A 1 BRIGHT;
		TNT1 A 2 A_Light1;
		Goto LightDone;
	Spawn:
		M42P A -1;
		Stop;
	}
}

Class MG42Loaded : Ammo
{
Default
{
	Tag "7.92x57mm";
	+Inventory.IGNORESKILL;
	Inventory.MaxAmount 50;
	Inventory.Icon "MAUS01";
}
}