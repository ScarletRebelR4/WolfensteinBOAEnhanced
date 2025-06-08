

Class M1GarandRifleCasing : MauserRifleCasing{Default{}}

Class M1GarandTracer : PlayerTracer
{
Default
{
	Damage 50;
	Speed 180;
	ProjectileKickback 100;
}	
}

Class Garand : NaziWeapon
{
Default
{
	//$Category Weapons (Neoatomized Weapons)
	//$Title (5) M1 Garand
	//$Color 14
	Scale 0.40;
	Weapon.SlotNumber 5;
	Weapon.AmmoType "GarandLoaded";
	Weapon.AmmoUse 1;
	Weapon.AmmoType2 "SpringAmmo";
	Weapon.AmmoUse2 1;
	Weapon.AmmoGive1 0;
	Weapon.AmmoGive2 20;
	Inventory.PickupMessage "You got the M1 Garand! Trust me, when you load this gun up... - Lt. Hyde";
	Weapon.SelectionOrder 750;
	+WEAPON.NOAUTOFIRE;
	Tag "M1 Garand";
	Weapon.UpSound "M1GFOW";
}	
	States
	{
	Ready:
		TNT1 A 0 A_JumpIfInventory("GarandLoaded",1,2);
		Goto ReadyEmpty;
		TNT1 A 0 A_CheckReload;
		TNT1 A 0 A_JumpIfInventory("GarandLoaded",0,2);
		TNT1 A 0 A_JumpIfInventory("SpringAmmo",1,2);
		M1GI A 1 A_WeaponReady;
		Loop;
		M1GI A 1 A_WeaponReady(WRF_ALLOWRELOAD);
		Loop;
	ReadyEmpty:
		TNT1 A 0 A_CheckReload;
		TNT1 A 0 A_JumpIfInventory("SpringAmmo",1,2);
		M1LF D 1 A_WeaponReady;
		Goto Ready;
		M1LF D 1 A_WeaponReady(WRF_ALLOWRELOAD);
		Goto Ready;
	Select:
		TNT1 A 0 A_JumpIfInventory("GarandLoaded",1,3);
		M1LF D 0 A_Raise;
		M1LF D 1 A_Raise;
		Loop;
		M1GI A 0 A_Raise;
		M1GI A 1 A_Raise;
		Loop;
	Deselect:
		TNT1 A 0 A_JumpIfInventory("GarandLoaded",1,3);
		M1LF D 0 A_Lower;
		M1LF D 1 A_Lower;
		Loop;
		M1GI A 0 A_Lower;
		M1GI A 1 A_Lower;
		Loop;
	Fire:
		M1GI A 0 A_JumpIfInventory("GarandLoaded",1,1);
		Goto Dryfire;
		M1GI A 0 A_GunFlash;
		TNT1 A 0 A_PlaySound("M1GFIR",CHAN_WEAPON);
		M1GI A 0 A_SpawnItemEx("M1GarandRifleCasing",12,-20,32,8,random(-2,2),random(0,4),random(-55,-80),SXF_NOCHECKPOSITION);
		M1GI A 0 A_AlertMonsters;
		M1FG A 1 BRIGHT A_FireProjectile("M1GarandTracer");
		M1FG B 1 A_SetPitch(pitch-(3.6*boa_recoilamount));
		M1GI C 0 A_JumpIf(waterlevel > 0,2);
		M1GI C 0 A_FireProjectile("ShotSmokeSpawner",0,0,0,random(-4,4),0,0);
		M1FG B 1 A_JumpIf(CountInv("GarandLoaded") == 0,"ClipEject");
	FireFinish:
		M1FG C 1 A_WeaponReady(WRF_ALLOWRELOAD);
		M1FG D 1 A_WeaponReady(WRF_ALLOWRELOAD);
		M1FG E 1 A_WeaponReady(WRF_ALLOWRELOAD);
		TNT1 A 0 A_CheckReload;
		Goto Ready;
	ClipEject:
	    TNT1 A 0 A_PlaySound("M1GPING",5);
		M1LF A 1;
		M1LF B 1;
		M1LF C 1;
		M1LF D 1;
		M1LF D 1 A_GiveInventory("M1Pinged");
		Goto Ready;
	Reload:
		TNT1 A 0 A_JumpIfInventory("M1Pinged",1,"FullReload");
		M1H1 A 2;
		M1H1 B 2;
		M1H1 C 2;
		M1H1 D 2;
		M1H1 E 2;
		M1H1 F 2;
		M1H1 G 2;
		M1H1 H 2;
		M1H1 I 2;
		M1H1 J 2;
		M1H1 K 2;
		M1H1 L 2;
		M1H1 M 2;
		M1H1 N 2;
		M1H1 O 2;
		M1H1 P 2;
		TNT1 A 0 A_PlaySound("M1GBAC",5);
		TNT1 A 0 A_PlaySound("M1GOUT",6);
		M1H2 A 2;
		M1H2 B 2;
		M1H2 C 2;
		M1H2 D 2;
		M1H2 E 2;
		TNT1 A 0 A_PlaySound("M1GFOW",5);
		M1H2 F 2;
		M1H2 G 2;
		M1H2 H 2;
		M1H2 I 2;
		M1H2 J 2; //Are we there yet????
		M1H2 K 2;
		M1H2 L 2;
		M1H3 A 2;
		M1H3 B 2;
		M1H3 C 2;
		M1H3 D 2;
		M1H3 E 2;
		M1H3 F 2;
		M1H3 G 2;
		M1H3 H 2;
		M1H3 I 2;
		M1H3 J 2;
		M1H3 K 2;
		TNT1 A 0 A_PlaySound("M1GBAC",5);
		M1H3 L 2;
		M1H3 M 2;
		M1H4 A 2;
		M1H4 B 2;
		M1H4 C 2;
		M1H4 D 2;
		M1H4 E 2;
		M1H4 F 2;
		TNT1 A 0 A_PlaySound("M1GIN",5);
		M1H4 G 2;
		TNT1 A 0 A_PlaySound("M1GFOW",6);
		M1H4 H 2;
		M1H4 I 2;
		M1H4 J 2;
		M1H4 K 2;
		M1H4 L 2;
		Goto ReloadLoop;
	FullReload:
		M1G1 A 2;
		M1G1 B 2;
		M1G1 C 2;
		M1G1 D 2;
		M1G1 E 2;
		M1G1 F 2;
		M1G1 G 2;
		M1G1 H 2;
		M1G1 I 2;
		M1G2 A 2;
		M1G2 B 2;
		M1G2 C 2;
		M1G2 D 2;
		TNT1 A 0 A_PlaySound("M1GIN",5);
		M1G2 E 2;
		TNT1 A 0 A_PlaySound("M1GFOW",6);
		M1G2 F 2;
		M1G2 G 2;
		M1G2 H 2;
		M1G2 I 2;
		M1G2 J 2;	
	ReloadLoop:
		M1AR A 0 A_TakeInventory("SpringAmmo",1,TIF_NOTAKEINFINITE);
		M1AR A 0 A_GiveInventory("GarandLoaded");
		M1AR A 0 A_JumpIfInventory("GarandLoaded",0,"ReloadFinish");
		M1AR A 0 A_JumpIfInventory("SpringAmmo",1,"ReloadLoop");
	ReloadFinish:
		M1GI A 1 A_TakeInventory("M1Pinged");
		M1GI A 1;
		Goto Ready;
	Flash:
		TNT1 A 1 BRIGHT A_Light2;
		TNT1 A 1;
		TNT1 A 2 A_Light1;
		Goto LightDone;
	Spawn:
		M1GP A -1;
		Stop;
	}
}

Class GarandLoaded : Ammo
{
Default
{
	Tag ".30-06";
	+INVENTORY.IGNORESKILL;
	Inventory.MaxAmount 8;
	Inventory.Icon "GARA01";
}	
}

Class M1Pinged : Inventory{Default{}}