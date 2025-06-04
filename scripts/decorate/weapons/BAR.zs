//Shamelessly borrowed from Zik's Confiscated Weapons :3

Class BAR3006 : NaziWeapon
{
Default
{
	//$Category Weapons (Neoatomized Weapons)
	//$Title (4) BAR LMG
	//$Color 14
	Scale 0.3;
	Weapon.SlotNumber 4;
	Weapon.SelectionOrder 750;
	Weapon.AmmoType "BAR3006Loaded";
	Weapon.AmmoUse 1;
	Weapon.AmmoType2 "SpringAmmo";
	Weapon.AmmoUse2 1;
	Weapon.AmmoGive1 20;
	Weapon.AmmoGive2 40;
	Tag "Browning Automatic Rifle";
	Inventory.PickupMessage "You got the Browning Automatic Rifle! Firing it in alternate attack will use its slow auto mode instead of full.";
	Weapon.UpSound "BARCOK";
	}
	States
	{
	Select:
		BRAG A 0 A_Raise;
		BRAG A 1 A_Raise;
		Loop;
	Deselect:
		BRAG A 0 A_Lower;
		BRAG A 1 A_Lower;
		Loop;
	Ready:
		BRAG A 0 A_JumpIfInventory("BAR3006Loaded",0,2);
		BRAG A 0 A_JumpIfInventory("SpringAmmo",1,2);
		BRAG A 1 A_WeaponReady;
		Loop;
		BRAG A 1 A_WeaponReady(WRF_ALLOWRELOAD);
		Loop;
	Fire:
		BRAG A 0 A_JumpIfInventory("BAR3006Loaded",1,1);
		Goto Dryfire;
		BRAG A 0 A_GunFlash;
		BRAG A 0 A_PlaySound("BARFIR",CHAN_WEAPON);
		BRAG A 0 A_SpawnItemEx("M1GarandRifleCasing",12,-20,32,8,random(-2,2),random(0,4),random(-55,-80),SXF_NOCHECKPOSITION);
		BRAG A 0 A_AlertMonsters;
		BRAF A 1 BRIGHT A_FireProjectile("M1GarandTracer",frandom(-2.0,2.0),1,0,0,0,frandom(-1.0,1.0));
		BRAF B 1 A_SetPitch(pitch-(2.6*boa_recoilamount));
		BRAG A 0 A_JumpIf(waterlevel > 0,2);
		BRAG A 0 A_FireProjectile("ChainSmokeSpawner",0,0,0,random(-4,4),0,0);
		BRAF D 1;
		TNT1 A 0 A_Refire;
		Goto Ready;
	Hold:
		BRAG A 0 A_JumpIfInventory("BAR3006Loaded",1,1);
		Goto Dryfire;
		BRAG A 0 A_GunFlash;
		BRAG A 0 A_PlaySound("BARFIR",CHAN_WEAPON);
		BRAG A 0 A_SpawnItemEx("M1GarandRifleCasing",12,-20,32,8,random(-2,2),random(0,4),random(-55,-80),SXF_NOCHECKPOSITION);
		BRAG A 0 A_AlertMonsters;
		BRAF A 1 BRIGHT A_FireProjectile("M1GarandTracer",frandom(-2.0,2.0),1,0,0,0,frandom(-1.0,1.0));
		BRAF B 1 A_SetPitch(pitch-(2.6*boa_recoilamount));
		BRAG A 0 A_JumpIf(waterlevel > 0,2);
		BRAG A 0 A_FireProjectile("ChainSmokeSpawner",0,0,0,random(-4,4),0,0);
		BRAF C 1;
		TNT1 A 0 A_Refire;
		Goto Ready;
	Altfire:
		BRAG A 0 A_JumpIfInventory("BAR3006Loaded",1,1);
		Goto Dryfire;
		BRAG A 0 A_GunFlash;
		TNT1 A 0;
		BRAG B 0 A_PlaySound("BARFIR",CHAN_WEAPON);
		BRAG B 0 A_SpawnItemEx("M1GarandRifleCasing",12,-20,32,8,random(-2,2),random(0,4),random(-55,-80),SXF_NOCHECKPOSITION);
		BRAG B 0 A_AlertMonsters;
		BRAG B 0 A_TakeInventory("BAR3006Loaded",1,TIF_NOTAKEINFINITE);
		BRAF A 1 BRIGHT A_FireProjectile("M1GarandTracer",frandom(-1.0,1.0),0,0,0,0,frandom(-1.0,1.0));
		BRAF B 1 A_SetPitch(pitch-(2.6*boa_recoilamount));
		BRAG B 0 A_JumpIf(waterlevel > 0,2);
		BRAG B 0 A_FireProjectile("ShotSmokeSpawner",0,0,0,random(-4,4),0,0);
		BRAF C 1;
		BRAF D 1;
		BRAG A 1;
		TNT1 A 0 A_CheckReload;
		TNT1 A 0 A_Refire;
		Goto Ready;
	Reload:
		BRA1 A 2;
		BRA1 B 2;
		BRA1 C 2;
		BRA1 D 2;
		BRA1 E 2;
		BRA1 F 2;
		BRA1 G 2;
		BRA1 H 2;
		BRA1 I 2;
		BRA1 J 2;
		TNT1 A 0 A_PlaySound("BARCOK",5);
		BRA1 K 2;
		BRA1 L 2;
		BRA1 M 2;
		BRA1 N 2;
	ReloadLoop:
		BRAG C 0 A_TakeInventory("SpringAmmo",1,TIF_NOTAKEINFINITE);
		BRAG C 0 A_GiveInventory("BAR3006Loaded");
		BRAG C 0 A_JumpIfInventory("BAR3006Loaded",0,"ReloadFinish");
		BRAG C 0 A_JumpIfInventory("SpringAmmo",1,"ReloadLoop");
	ReloadFinish:
		BRA2 A 2;
		BRA2 B 2;
		BRA2 C 2;
		BRA2 D 2;
		TNT1 A 0 A_PlaySound("BAROUT",5);
		BRA2 E 2;
		BRA2 F 2;
		BRA2 G 2;
		BRA2 H 2;
		BRA2 I 2;
		BRA3 A 2;
		BRA3 B 2;
		BRA3 C 2;
		BRA3 D 2;
		BRA3 E 2;
		BRA3 F 2;
		TNT1 A 0 A_PlaySound("BARIN",5);
		BRA3 G 2;
		BRA3 H 2;
		BRA3 I 2;
		BRA3 J 2;
		BRA3 K 2;
		BRA3 L 2;
		BRA3 M 2;
		BRA3 N 2;
		BRA3 O 2;
		BRA3 P 2;
		Goto Ready;
	Flash:
		TNT1 A 1 BRIGHT A_Light2;
	    TNT1 A 1 BRIGHT;
		TNT1 A 2 A_Light1;
		Goto LightDone;
	Spawn:
		BRAW A -1;
		Stop;
	}
}

class BAR3006Loaded : Ammo
{
Default
{
	Tag ".30-06";
	+Inventory.IGNORESKILL;
	Inventory.MaxAmount 20;
	Inventory.Icon "BARA01";
}	
}