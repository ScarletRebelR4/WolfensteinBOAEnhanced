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

class VenomGunMK3 : NaziWeapon
{
	Default
	{
	//$Category Weapons (BoA)
	//$Title (8) UMG 43
	//$Color 14
	Scale 0.35;
	Inventory.PickupMessage "$UMG43";
	Inventory.PickupSound "chaingun/get";
	Tag "MG-VK MK3 Venom Gun";
	Weapon.AmmoGive 30;
	Weapon.AmmoType "Ammo9mm";
	Weapon.AmmoUse 1;
	Weapon.AmmoType2 "Ammo9mm";
	Weapon.AmmoUse2 4;
	Weapon.SelectionOrder 900;
	Weapon.UpSound "chaingun/select";
	-WEAPON.AMMO_CHECKBOTH
	-WEAPON.NOALERT
	}
	
	States
	{
	Select:
		UMGA A 0 A_Raise;
		UMGA A 1 A_Raise;
		Loop;
	Deselect:
		UMGA A 0 A_StopSound(CHAN_5);
		UMGA A 0 A_Lower;
		UMGA A 1 A_Lower;
		Loop;
	Ready:
		UMGA A 0 A_ClearRefire;
		UMGA A 0 A_StopSound(CHAN_5);
		UMGA A 1 A_WeaponReady;
		Wait;
	Ready2:
		UMGA ACBD 1 A_WeaponReady;
		Loop;
	Fire:
		TNT1 A 0 A_JumpIfInventory("VGSpin", 1, "Hold");
		TNT1 A 0 A_StartSound("weapons/VenomGun/WindUp", CHAN_AUTO, CHANF_OVERLAP, 1.0);
		UMGA AAAACCCCBBBBDDDDAACCBBDDAACCBBDDACBD 1;
		TNT1 A 0 A_StartSound("Weapons/VenomGun/Loop", CHAN_5, CHANF_LOOPING, 0.2);
		UMGA D 1 A_Refire;
	Hold:
		UMGA A 1 A_StartSound("weapons/VenomGun/Mech", CHAN_AUTO, CHANF_OVERLAP, 1.0);
		UMGA C 1
		{
			A_Overlay(-3, "VGFlash");
			A_SetPitch(pitch-(0.34*boa_recoilamount));
			A_WeaponOffset(random(-2,2),random(33,36), WOF_INTERPOLATE);
			
			A_StartSound("weapons/VenomGun/fire", CHAN_AUTO, CHANF_OVERLAP, 1.0);
			A_StartSound("weapons/VenomGun/FireAdd", CHAN_AUTO, CHANF_OVERLAP, 1.0);
			
			A_SpawnItemEx("Casing9mm",12,-20,32,8,random(-2,2),random(0,4),random(20,55),SXF_NOCHECKPOSITION);
			if(waterlevel > 0.2)
			{
				A_FireProjectile("ChainSmokeSpawner",0,0,0,random(-4,4),0,0);
			}
			
			A_FireProjectile("ChaingunTracer",frandom(-1.4,1.4),1,0,0,0,frandom(-0.7,0.7));
		}
		UMGA B 1 A_StartSound("weapons/VenomGun/Mech", CHAN_AUTO, CHANF_OVERLAP, 1.0);
		UMGA D 1
		{
			A_Overlay(-3, "VGFlash");
			A_SetPitch(pitch-(0.34*boa_recoilamount));
			A_WeaponOffset(random(-2,2),random(33,36), WOF_INTERPOLATE);
			
			A_StartSound("weapons/VenomGun/fire", CHAN_AUTO, CHANF_OVERLAP, 1.0);
			A_StartSound("weapons/VenomGun/FireAdd", CHAN_AUTO, CHANF_OVERLAP, 1.0);
			
			A_SpawnItemEx("Casing9mm",12,-20,32,8,random(-2,2),random(0,4),random(20,55),SXF_NOCHECKPOSITION);
			if(waterlevel > 0.2)
			{
				A_FireProjectile("ChainSmokeSpawner",0,0,0,random(-4,4),0,0);
			}
			
			A_FireProjectile("ChaingunTracer",frandom(-1.4,1.4),1,0,0,0,frandom(-0.7,0.7));
		}
		UMGA E 1 A_Refire;
		Goto FireFinish;
	FireFinish:
		TNT1 A 0 A_JumpIfInventory("VGSpin", 1, "Ready2");
		UMGA D 0 Offset(0,32) A_StartSound("weapons/Venomgun/WindDown", CHAN_5);
		UMGA ACBCACBDAAABBBCCCCDDDD 1;
		Goto Ready;
	
	AltFire:
		TNT1 A 0 A_JumpIfInventory("VGSpin", 1, "AltFire2");
		TNT1 A 0
		{
			A_GiveInventory("VGSpin", 1);
		}
		TNT1 A 0 A_StartSound("weapons/VenomGun/WindUp", CHAN_AUTO, CHANF_OVERLAP, 1.0);
		UMGA AAAACCCCBBBBDDDDAACCBBDDAACCBBDDACBD 1;
		TNT1 A 0 A_StartSound("Weapons/VenomGun/Loop", CHAN_5, CHANF_LOOPING, 0.2);
		
		Goto Ready2;
	AltFire2:
		TNT1 A 0
		{
			A_TakeInventory("VGSpin", 1);
		}
		UMGA D 0 Offset(0,32) A_StartSound("weapons/Venomgun/WindDown", CHAN_5);
		UMGA ACBCACBDAAABBBCCCCDDDD 1;
		Goto Ready;
	
	VGFlash:
		TNT1 A 0 A_Jump(256, "VGFlash1", "VGFlash2", "VGFlash3", "VGFlash4");
	VGFlash1:
		UMGF A 1;
		Stop;
	VGFlash2:
		UMGF B 1;
		Stop;
	VGFlash3:
		UMGF C 1;
		Stop;
	VGFlash4:
		UMGF D 1;
		Stop;
	Spawn:
		UMGP A -1;
		Stop;
	}
}

class VGSpin : Inventory
{
	Default
	{
		Inventory.MaxAMount 1;
	}
}