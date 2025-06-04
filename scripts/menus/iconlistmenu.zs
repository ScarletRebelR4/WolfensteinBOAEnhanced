/*
 * Copyright (c) 2018-2020 AFADoomer
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
/*

  ListMenu extension that allows for menus in the style of Wolf3D's episode and
  skill selection screens.

  This code implements two new ListItem classes:
	IconListMenu
	- Adds an image to the left of each menu entry, resulting in a menu that
	  looks similar to the Wolf3D episode selection menu
	- Also handles automatically offsetting the selection cursor

	StaticIconListMenu
	- Adds an image to the center-right of the entire menu, similar to the one
	  seen on the Wolf3D skill selection menu
	- Automatically calculates position and offsets based on the number and size
	  of the entries in the menu

  Both of these classes also implement the ability to add on-screen descriptive
  text for each menu item (text appears centered below the menu).  They also
  add the ability to cause menu entries to generate a popup message similar to
  Wolf3D shareware's "Click Read This to find out how to order" message.

  To use these classes, they must be set up in MENUDEF by setting the class of
  the menu you are changing to one of these class names.  For example, if I
  wanted to have a Wolf3D-style episode select, my EpisodeMenu definition would
  look something like this:

		ListMenu "EpisodeMenu"
		{
			StaticPatchCentered 160, 5, "M_EPIS"

			NetgameMessage "$NEWGAME"
			Position 70, 60

			Linespacing 26

			Class "IconListMenu"
		}

  Once this is done, you must add the appropriate images and/or LANGUAGE lump
  entries to your mod. Note that if your image is taller than one line of the
  menu font's text, you will also need to adjust Linespacing in MENUDEFS, since
  Episode properties aren't exported to ZScript (yet?).

  All additional menu content must follow a specific naming convention!

  The name of the menu (with "Menu" removed from the end) is used as the base
  of all lookup strings (So, "Episode", "Skill", etc.).  The number of the menu
  item (1st item is 1, 2nd item is 2, etc.) is used as the index (this also
  means that if you re-order your menu items, you'll need to rename your images
  and LANGUAGE entries as well).

    Lookup Strings Used:
	Icon Images (Texture name lookup):
	[Lookup Base][index] 	   	Example: EPISODE1, SKILL2, etc.

	Descriptions (LANGUAGE lookup):
	[Lookup Base]DESCRIPTION[index]	Example: EPISODEDESCRIPTION1, SKILLDESCRIPTION2

	Popup Text (LANGUAGE lookup):
	[Lookup Base][index]MESSAGE	Example: EPISODE1MESSAGE, SKILL5MESSAGE

  Images and Descriptions will automatically be used if they are present.  If
  you do not provide an image or string for a menu item, then the menu entry
  will appear as it normally would in a standard ListMenu (though spacing and
  offsets may still be affected if other icons are present).

  Popup messages are handled slightly differently.  In order to set up a popup
  message, you must add "[Unreleased]" to the beginning of your episode's name
  in MAPINFO:

		episode C3M1
		{
			name = "[Unreleased]The Clash of Faith"
		}

  The "[Unreleased]" portion of the name will be stripped off when the episode
  select screen is rendered, but is used as a flag internally by this code.

  If you add "[Unreleased]" to the episode name but do not include an
  EPISODExMESSAGE string in LANGUAGE, the code will attempt to look up the
  DEFAULTMESSAGE string as a fallback.  If that string is not found either,
  then no message will be displayed (but the background image will be drawn, if
  defined - see below).

  If you want the popup message to have a background, you must provide an image
  named "NOTAVAIL".  If this image is not found, no background image will be
  drawn (but any defined text will still show up).

*/
// Base class that handles drawing informational text under menu entries and display of Wolf3D-style popup message on tagged menu entries
class ExtendedListMenu : ListMenu
{
	String lookupBase;
	int itemCount;
	Name overlay;
	String overlaytext;
	Array<int> placeholders;

	override void Init(Menu parent, ListMenuDescriptor desc)
	{
		Super.Init(parent, desc);

		placeholders.Clear();

		GetPlaceholders();

		// Allow generic lookups - strip "menu" off of the menu name, and use that stub as the lookup base (e.g., SKILL, EPISODE, etc.)
		String MenuName = ToUpper(mDesc.mMenuName);
		MenuName.Replace("MENU", "");

		lookupBase = MenuName;
	}

	override void Drawer()
	{
		// Draw the text description for the currently selected item
		DrawItemText(mDesc.mSelectedItem, breakWidth:230, scale:0.6);

		Super.Drawer();

		if (overlay)
		{
			double scale = 1.0;
			double ratio = screen.GetAspectRatio();

			// Calculate width and height to keep the image at the same relative size, regardless of aspect ratio
			double width = ratio > 1.25 ? 200 * ratio : 320;
			double height = ratio < 1.25 ? 320 / ratio : 200;

			TextureID tex = TexMan.CheckForTexture(overlay, TexMan.Type_Any);
			if (tex.IsValid()) { screen.DrawTexture(tex, true, (width / 2) / scale, (height / 2) / scale, DTA_Clean, true, DTA_CenterOffset, true, DTA_KeepRatio, true, DTA_VirtualWidthF, width / scale, DTA_VirtualHeightF, height / scale); };

			if (overlaytext.Length())
			{
				scale *= 0.95;
				double fontheight = BigFont.GetHeight() * scale;

				// Default position is essentially centered on the screen (offset slightly toward the bottom so the graphic can have a title and still be centered)
				double x = (width / 2);
				double y = (height / 2) + 10 * scale;
				
				String temp; BrokenString message;
				[temp, message] = BrokenString.BreakString(overlaytext, int(240 / scale), fnt:BigFont);

				int c = message.Count();

				for (int i = 0; i < c; i++) { y -= fontheight / 2; }

				for (int i = 0; i < c; i++)
				{
					screen.DrawText (BigFont, 0, x / scale - message.StringWidth(i) / 2, y / scale, message.StringAt(i), DTA_Clean, true, DTA_KeepRatio, true, DTA_VirtualWidthF, width / scale, DTA_VirtualHeightF, height / scale);
					y += fontheight;
				}
			}
		}
	}

	virtual void DrawItemIcon(int index, double x = -1, double y = -1, double alpha = 1.0)
	{
		return;
	}

	void DrawItemText(int index, double x = -1, double y = -1, double alpha = 1.0, int breakWidth = 300, double scale = 1.0)
	{
		if (index < 0) { return; }

		double fontheight = SmallFont.GetHeight() * scale;

		// Default position is centered, 35 pixels off the bottom of the screen
		if (x < 0) { x = 160; }
		if (y < 0) { y = 165; }

		// Semi-hard-coded, unfortunately - Descriptions must be named [Menu name]DESCRIPTION1, [Menu name]DESCRIPTION2, etc.
		String text = StringTable.Localize("$" .. lookupBase .. "DESCRIPTION"..index);
		if (text == lookupBase .. "DESCRIPTION"..index) { return; }

		String temp; BrokenString message;
		[temp, message] = BrokenString.BreakString(text, int(breakWidth / scale), fnt:SmallFont);

		int c = message.Count();

		for (int i = 0; i < c; i++) { y -= fontheight / 2; }

		for (int i = 0; i < c; i++)
		{
			screen.DrawText (SmallFont, OptionMenuSettings.mFontColor, x / scale - message.StringWidth(i) / 2, y / scale, message.StringAt(i), DTA_Clean, true, DTA_Alpha, alpha, DTA_VirtualWidthF, 320 / scale, DTA_VirtualHeightF, 200 / scale);
			y += fontheight;
		}
	}

	override bool MenuEvent(int mkey, bool fromcontroller)
	{
		if (overlay)
		{
			overlay = "";
			MenuSound ("menu/backup");

			return false;
		}

		switch (mkey)
		{
			case MKEY_Back:
				RestorePlaceholderMarkers();
				return Super.MenuEvent(mkey, fromcontroller);
			case MKEY_Enter:
				if (mDesc.mSelectedItem >= 0)
				{
					if (placeholders.Find(mDesc.mSelectedItem) != placeholders.Size())
					{
						overlay = "NOTAVAIL";

						overlaytext = StringTable.Localize("$" .. lookupBase .. mDesc.mSelectedItem .. "MESSAGE");
						if (overlaytext == lookupBase .. mDesc.mSelectedItem .. "MESSAGE") // Message wasn't found
						{
							overlaytext = StringTable.Localize("$DEFAULTMESSAGE");
							if (overlaytext == "DEFAULTMESSAGE") { overlaytext = ""; return false; } // Default wasn't found either
						}

						MenuSound("menu/choose");
						return false;
					}
					else
					{
						if (mDesc.mItems[mDesc.mSelectedItem].Activate()) { MenuSound("menu/choose"); }
					}
				}
 				RestorePlaceholderMarkers();
				return true;
			default:
				return Super.MenuEvent(mkey, fromcontroller);
		}
	}

	override void OnReturn()
	{
		GetPlaceholders();
	}

	void GetPlaceholders()
	{
		int index = 0;

		placeholders.Clear();

		for (int i = 0; i < mDesc.mItems.Size(); i++)
		{
			if (mDesc.mItems[i].Selectable()) { index++; }

			if (mDesc.mItems[i] is "ListMenuItemTextItem")
			{
				String temp = ListMenuItemTextItem(mDesc.mItems[i]).mText;
				temp.Replace("[Unreleased]", "");

				// If the replacement string wasn't there, then this one is good
				if (temp == ListMenuItemTextItem(mDesc.mItems[i]).mText) { continue; }

				// Otherwise, fix the text string and recolor it, and add it to the list of known placeholders
				ListMenuItemTextItem(mDesc.mItems[i]).mText = temp;
				ListMenuItemTextItem(mDesc.mItems[i]).mColor = Font.FindFontColor("Disabled");
				ListMenuItemTextItem(mDesc.mItems[i]).mColorSelected = Font.FindFontColor("Disabled");

				placeholders.Push(index);
			}
		}
	}

	void RestorePlaceholderMarkers()
	{
		// Restore the placeholder marker for popup message menus so that they will be treated correctly next time the menu is opened
		if (placeholders.Size())
		{
			for (int p = 0; p < placeholders.Size(); p++)
			{
				ListMenuItemTextItem(mDesc.mItems[placeholders[p]]).mText = "[Unreleased]" .. ListMenuItemTextItem(mDesc.mItems[placeholders[p]]).mText;
			}
		}
	}

	String ToUpper(String input)
	{
		String output;

		for (int i = 0; i < input.length(); i++)
		{
			int c = input.CharCodeAt(i);

			if (c >= 97 && c <= 122) { c -= 32; }

			output.AppendFormat("%c", c);
		}

		return output;
	}
}

// For an icon beside the menu entry, like Wolf3D episode select
class IconListMenu : ExtendedListMenu
{
	override void Init(Menu parent, ListMenuDescriptor desc)
	{
		Super.Init(parent, desc);

		Vector2 iconSize;

		for (int i = 0; i < mDesc.mItems.Size(); i++)
		{
			TextureID tex = TexMan.CheckForTexture(lookupBase .. i, TexMan.Type_Any);

			if (tex.IsValid())
			{
				Vector2 texsize = TexMan.GetScaledSize(tex);

				if (texsize.x > iconSize.x) { iconSize.x = int(texsize.x); }
			}

			if (mDesc.mItems[i].Selectable()) { mDesc.mItems[i].SetX(mDesc.mXpos + iconsize.x / 2); }
		}

		if (mDesc.mXpos + mDesc.mSelectOfsX > mDesc.mXpos - iconSize.x * 1.3) { mDesc.mSelectOfsX -= iconSize.x * 1.3; }
	}

	override void Drawer()
	{
		// Draw the icons
		DrawItemIcon(mDesc.mSelectedItem, -1, -1, 1.0);

		Super.Drawer();
	}

	override void DrawItemIcon(int index, double x, double y, double alpha)
	{
		double fontheight = mDesc.mFont.GetHeight();
		double drawx = x;
		double drawy = y;
		int itemindex = 0;

		for (int i = 0; i < mDesc.mItems.Size(); i++)
		{
			if (mDesc.mItems[i].Selectable())
			{
				itemindex++;

				// Again, semi-hard-coded, unfortunately - Icons must be named [Menu name]1, [Menu name]2, etc.
				TextureID tex = TexMan.CheckForTexture(lookupBase .. itemindex, TexMan.Type_Any);
				if (tex.IsValid())
				{
					Vector2 texsize = TexMan.GetScaledSize(tex);

					// Default to Wolf3D-style positioning, roughly vertically centered on the episode name
					if (x == -1) { drawx = mDesc.mItems[itemindex].GetX() - texsize.x / 2 - 10; }
					if (y == -1) { drawy = mDesc.mItems[itemindex].GetY() + fontheight / 2; }

					// Use the center of the image for positioning
					drawx -= texsize.x / 2;
					drawy -= texsize.y / 2;

					screen.DrawTexture(tex, true, drawx, drawy, DTA_Clean, true, DTA_Alpha, itemindex != index ? alpha * 0.6 : alpha);
				}
			}
		}
	}
}

// For an icon that swaps out in place, like the Wolf3D skill menu
class StaticIconListMenu : ExtendedListMenu
{
	double iconOffset;

	override void Init(Menu parent, ListMenuDescriptor desc)
	{
		// Some logic to determine the rightmost pixel point of the middle skill values
		//  Used for default positioning a la Wolf3D
		double maxWidth;
		int min;

		mDesc = desc;

		// Find the middle skill menu entry (with rounding if odd number of entries)
		double median = (mDesc.mItems.Size() - 1) / 2;
		if (median < int(median) + 0.5) { min = int(median); }
		else { min = int(median) + 1; }

		// Figure out the widest skill name...
		for (int i = min; i < min + 2; i++)
		{
			int width = mDesc.mItems[i].GetWidth();
			if (width > maxWidth) { maxWidth = width; }
		}

		// ... And use it's length to calculate the default x offset
		iconOffset = mDesc.mXPos + maxWidth;

		Super.Init(parent, desc);
	}


	override void Drawer()
	{
		// Draw the icon for the currently selected item
		DrawItemIcon(mDesc.mSelectedItem, -1, -1, 1.0);

		Super.Drawer();
	}

	override void DrawItemIcon(int index, double x, double y, double alpha)
	{
		if (index < 0) { return; }

		double fontheight = mDesc.mFont.GetHeight();

		// Again, semi-hard-coded, unfortunately - Icons must be named [Menu name]1, [Menu name]2, etc.
		TextureID tex = TexMan.CheckForTexture(lookupBase .. index, TexMan.Type_Any);
		if (tex.IsValid())
		{
			Vector2 texsize = TexMan.GetScaledSize(tex);

			// Default to Wolf3D-style positioning, roughly vertically centered on the skill list,
			//  horizontally centered between the screen edge and the longest of the middle skill names.
			if (x == -1) { x = (320 + iconOffset) / 2; }
			if (y == -1) { y = mDesc.mYpos + ((mDesc.mItems.Size() - 1) * mDesc.mLinespacing) / 2; }

			// Use the center of the image for positioning
			x -= texsize.x / 2;
			y -= texsize.y / 2;

			screen.DrawTexture(tex, true, x, y, DTA_Clean, true, DTA_Alpha, alpha);
		}
	}
}