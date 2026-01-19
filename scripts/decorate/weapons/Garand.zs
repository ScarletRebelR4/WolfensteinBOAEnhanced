Class Garand : NaziWeapon
{
	Default
	{
		//$Category Weapons (Neoatomized Weapons)
		//$Title (5) M1 Garand
		//$Color 14
		Scale 0.7;
		Weapon.SlotNumber 5;
		Weapon.AmmoType "GarandLoaded";
		Weapon.AmmoUse 1;
		Weapon.AmmoType2 "Ammo3006";
		Weapon.AmmoUse2 1;
		Weapon.AmmoGive1 0;
		Weapon.AmmoGive2 8;
		Weapon.UpSound "weapon/Sniper/raise";
		Inventory.PickupMessage "You got the M1 Garand! Trust me, when you load this gun up... - Lt. Hyde";
		Weapon.SelectionOrder 750;
		+WEAPON.NOAUTOFIRE;
		Tag "M1 Garand";
	}	
	
	States
	{
		Deselect:
			//TNT1 A 0 A_StartSound("Weapons/C96/Lower", CHAN_AUTO, CHANF_OVERLAP, 1.0);
			M1GS ABCDEF 1;
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
				A_GiveInventory("GarandLoaded", 8);
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
			M1GS FEDCBA 1;
		Ready1:
			TNT1 A 0 A_JumpIf(CountInv("GarandLoaded") == 0, "Ready2");
			M1GF A 1 A_WeaponReady(WRF_ALLOWRELOAD);
			Loop;
		Ready2:
			M1GF E 1 A_WeaponReady(WRF_ALLOWRELOAD);
			Loop;
		Fire:
			TNT1 A 0 A_JumpIf(CountInv("GarandLoaded") == 0,"DryFire");
			M1GF B 1 BRIGHT
			{
				A_GunFlash();
				A_AlertMonsters();
				
				if(waterlevel > 0.2)
				{
					//[Pop] Refactor later with new smoke system
					A_FireProjectile("ShotSmokeSpawner",0,0,0,random(-4,4),0,0);
				}
				A_SpawnItemEx("MauserRifleCasing",12,-20,32,8,random(-2,2),random(0,4),random(-55,-80),SXF_NOCHECKPOSITION);
				//Take Ammo
				
				A_StartSound("M1GFIR",CHAN_WEAPON, CHANF_OVERLAP);
				A_FireProjectile("M1GarandTracer");
				A_SetPitch(pitch-(1.6*boa_recoilamount));
			}
			M1GF C 1 BRIGHT;
			M1GF DE 1;
			TNT1 A 0 A_JumpIf(CountInv("GarandLoaded") == 0,"FireEnd");
			M1GF DA 1;
			Goto Ready1;
		FireEnd:
			TNT1 A 0 A_Overlay(5, "Enbloc");
			TNT1 A 0 A_OverlayFlags(5, PSPF_ADDWEAPON, false);
			TNT1 A 0 A_OverlayFlags(5, PSPF_ADDBOB, false);
			TNT1 A 0 A_OverlayPivotAlign(5, PSPA_CENTER, PSPA_CENTER);
			M1GF E 10;
			TNT1 A 0 A_CheckReload;
			Goto Ready2;
		Enbloc:
			M1GR A 0 A_OverlayOffset(5, -12, 52);
			M1GR A 1 { A_OverlayOffset(5, 8, -10, WOF_ADD | WOF_INTERPOLATE); A_OverlayRotate(5, -32, WOF_ADD | WOF_INTERPOLATE); }
			M1GR A 1 { A_OverlayOffset(5, 8, -10, WOF_ADD | WOF_INTERPOLATE); A_OverlayRotate(5, -32, WOF_ADD | WOF_INTERPOLATE); }
			M1GR A 1 { A_OverlayOffset(5, 8, -5, WOF_ADD | WOF_INTERPOLATE); A_OverlayRotate(5, -32, WOF_ADD | WOF_INTERPOLATE); }
			M1GR A 1 { A_OverlayOffset(5, 8, 0, WOF_ADD | WOF_INTERPOLATE); A_OverlayRotate(5, -32, WOF_ADD | WOF_INTERPOLATE); }
			M1GR A 1 { A_OverlayOffset(5, 4, 5, WOF_ADD | WOF_INTERPOLATE); A_OverlayRotate(5, -32, WOF_ADD | WOF_INTERPOLATE); }
			M1GR A 1 { A_OverlayOffset(5, 4, 10, WOF_ADD | WOF_INTERPOLATE); A_OverlayRotate(5, -32, WOF_ADD | WOF_INTERPOLATE); }
			M1GR A 1 { A_OverlayOffset(5, 4, 10, WOF_ADD | WOF_INTERPOLATE); A_OverlayRotate(5, -32, WOF_ADD | WOF_INTERPOLATE); }
			M1GR A 1 { A_OverlayOffset(5, 4, 15, WOF_ADD | WOF_INTERPOLATE); A_OverlayRotate(5, -32, WOF_ADD | WOF_INTERPOLATE); }
			M1GR A 1 { A_OverlayOffset(5, 4, 15, WOF_ADD | WOF_INTERPOLATE); A_OverlayRotate(5, -32, WOF_ADD | WOF_INTERPOLATE); }
			M1GR A 1 { A_OverlayOffset(5, 2, 15, WOF_ADD | WOF_INTERPOLATE); A_OverlayRotate(5, -32, WOF_ADD | WOF_INTERPOLATE); }
			M1GR A 1 { A_OverlayOffset(5, 2, 20, WOF_ADD | WOF_INTERPOLATE); A_OverlayRotate(5, -32, WOF_ADD | WOF_INTERPOLATE); }
			M1GR A 1 { A_OverlayOffset(5, 2, 20, WOF_ADD | WOF_INTERPOLATE); A_OverlayRotate(5, -32, WOF_ADD | WOF_INTERPOLATE); }
			M1GR A 1 { A_OverlayOffset(5, 2, 20, WOF_ADD | WOF_INTERPOLATE); A_OverlayRotate(5, -32, WOF_ADD | WOF_INTERPOLATE); }
			//[Pop] Just to make sure it gets off screen here.
			M1GR A 1 { A_OverlayOffset(5, 2, 20, WOF_ADD | WOF_INTERPOLATE); A_OverlayRotate(5, -32, WOF_ADD | WOF_INTERPOLATE); }
			M1GR A 1 { A_OverlayOffset(5, 2, 20, WOF_ADD | WOF_INTERPOLATE); A_OverlayRotate(5, -32, WOF_ADD | WOF_INTERPOLATE); }
			M1GR A 1 { A_OverlayOffset(5, 2, 20, WOF_ADD | WOF_INTERPOLATE); A_OverlayRotate(5, -32, WOF_ADD | WOF_INTERPOLATE); }
			M1GR A 1 { A_OverlayOffset(5, 2, 20, WOF_ADD | WOF_INTERPOLATE); A_OverlayRotate(5, -32, WOF_ADD | WOF_INTERPOLATE); }
			Stop;
		Reload:
			TNT1 A 0 A_JumpIf(CountInv("GarandLoaded") == 0,"Reload2");
			M1GF A 10;
			M1GR D 10;
			TNT1 A 0 A_PlaySound("M1GBAC",5);
			M1GR C 2;
			TNT1 A 0 A_PlaySound("M1GOUT",6);
			M1GR C 30;
			TNT1 A 0 A_PlaySound("M1GIN",5);
			Goto ReloadLoop;
		ReloadLoop:
			M1AR A 0 A_TakeInventory("Ammo3006",1,TIF_NOTAKEINFINITE);
			M1AR A 0 A_GiveInventory("GarandLoaded");
			M1AR A 0 A_JumpIfInventory("GarandLoaded",8,"ReloadFinish");
			M1AR A 0 A_JumpIfInventory("Ammo3006",1,"ReloadLoop");
		ReloadFinish:
			M1GR C 4;
			TNT1 A 0 A_PlaySound("M1GFOW",6);
			M1GR D 10;
			M1GF A 10;
			Goto Ready1;
		Reload2:
			M1GF E 8;
			M1GR C 20;
			TNT1 A 0 A_PlaySound("M1GIN",5);
		Reload2Loop:
			M1AR A 0 A_TakeInventory("Ammo3006",1,TIF_NOTAKEINFINITE);
			M1AR A 0 A_GiveInventory("GarandLoaded");
			M1AR A 0 A_JumpIfInventory("GarandLoaded",8,"Reload2Finish");
			M1AR A 0 A_JumpIfInventory("Ammo3006",1,"Reload2Loop");
		Reload2Finish:
			M1GR C 20;
			TNT1 A 0 A_PlaySound("M1GFOW",6);
			M1GR D 10;
			M1GF A 8;
			Goto Ready1;
		
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