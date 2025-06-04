class STG44Casing : MauserRifleCasing{}


class MPStGTracer : PlayerTracer
{
  Default
  {
	ProjectileKickback 100;
	Damage 20;
	Speed 115;
  }
}
class STG44 : NaziWeapon
{
	Default
	{
	Weapon.SlotNumber 4;
	Weapon.SelectionOrder 700;
	inventory.pickupmessage "You got the Sturmgewehr 44!";
	Weapon.AmmoType "STG44Loaded";
	Weapon.AmmoUse 1;
	weapon.ammotype2 "KurzAmmo";
	weapon.ammouse2 1;
	Weapon.AmmoGive1 0;
	Weapon.AmmoGive2 60;
	Scale .5;
	Tag "Sturmgewehr 44";
	Weapon.UpSound "MP44COK";
	}
	States
	{
	Ready:
		STGG A 0 A_JumpIfInventory("STG44Loaded",0,2);
		STGG A 0 A_JumpIfInventory("KurzAmmo",1,2);
		STGG A 1 A_WeaponReady;
		Loop;
		STGG A 1 A_WeaponReady(WRF_ALLOWRELOAD);
		Loop;
	Deselect:
		STGG A 0 A_Lower;
		STGG A 1 A_Lower;
		Loop;
	Select:
		STGG A 0 A_Raise;
		STGG A 1 A_Raise;
		Loop;
	Fire:
		STGG A 0 A_JumpIfInventory("STG44Loaded",1,1);
		Goto Dryfire;
		STGG A 0 A_GunFlash;
		TNT1 A 0;
		STGG B 0 A_PlaySound("MP44FIR",CHAN_WEAPON);
		STGG B 0 A_SpawnItemEx("STG44Casing",12,-20,32,8,random(-2,2),random(0,4),random(-55,-80),SXF_NOCHECKPOSITION);
		STGG B 0 A_AlertMonsters;
		STGF A 1 BRIGHT A_FireProjectile("MPStGTracer",frandom(-1.0,1.0));
		STGF B 1 A_SetPitch(pitch-(1.0*boa_recoilamount));
		STGG B 0 A_JumpIf(waterlevel > 0,2);
		STGG B 0 A_FireProjectile("ShotSmokeSpawner",0,0,0,random(-4,4),0,0);
		STGF C 1; 
		STGF D 1;
		TNT1 A 0 A_CheckReload;
		Goto Ready;
	Reload:
		STG1 A 2;
		STG1 B 2;
		STG1 C 2;
		STG1 D 2;
		STG1 E 2;
		STG1 F 2;
		STG1 G 2;
		STG1 H 2;
		TNT1 A 0 A_PlaySound("MP44OUT",5);
		STG1 I 2;
		STG1 J 2;
		STG1 K 2;
		STG1 L 2;
		STG1 M 2;
	ReloadLoop:
		TNT1 A 0 A_TakeInventory("KurzAmmo",1,TIF_NOTAKEINFINITE);
		TNT1 A 0 A_GiveInventory("STG44Loaded");
		TNT1 A 0 A_JumpIfInventory("STG44Loaded",0,"ReloadFinish");
		TNT1 A 0 A_JumpIfInventory("KurzAmmo",1,"ReloadLoop");
	ReloadFinish:
		STG2 A 2;
		STG2 B 2;
		STG2 C 2;
		STG2 D 2;
		STG2 E 2;
		TNT1 A 0 A_PlaySound("MP44IN",5);
		STG2 F 2;
		STG2 G 2;
		STG2 H 2;
		STG2 I 2;
		STG2 J 2;
		STG3 A 2;
		TNT1 A 0 A_PlaySound("MP44COK",5);
		STG3 B 2;
		STG3 C 2;
		STG3 D 2;
		STG3 E 2;
		STG3 F 2;
		STG3 G 2;
		STG3 H 2;
		STG3 I 2;
		STG3 J 2;
		STG3 K 2;
		STG3 L 2;
		STG3 M 2;
		Goto Ready;
	Flash:
		TNT1 A 1 BRIGHT A_Light2;
		TNT1 B 1 BRIGHT;
		TNT1 A 2 A_Light1;
		Goto LightDone;
	Spawn:
		STGI A -1;
		Stop;
	}
}

class STG44Loaded : Ammo
{
   Default
   {
	Tag "7.92x33mm";
	+INVENTORY.IGNORESKILL;
	Inventory.MaxAmount 30;
	Inventory.Icon "KURZ02";
   }
}