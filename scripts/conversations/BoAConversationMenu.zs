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

class BoAConversationMenu : ExtendedConversationMenuBase
{
	//This still relies on some of the old ConversationMenu parsing code under the hood
	override int Init(StrifeDialogueNode CurNode, PlayerInfo player, int activereply)
	{
		//Set some default values
		Super.Init(CurNode, player, activereply);

		//Used below to align speaker name/text and responses
		// Assumes default dialogue coordinate system
		// (e.g., dialogue.targetscreenx = 320 and dialogue.targetscreeny = 240)
		int xAlign = 74;
		int yAlign = 16;
		int width = 216;

		dialogue = new("DialogueDescriptor"); // New dialogue "container" - essentially for dialogue-scope variables and keeping track of all of the dialogue components
			dialogue.currentmenu = self; // Required here because an Init is called early in the Response code below
			dialogue.focus = "Responses"; // Set initial focus - overridden if there's a scrolling text element
			dialogue.autofocus = true; // When true, automatically moves between tabindexed elements when you reach the end of a scrollable area (text or response list)
			dialogue.selectiondim.alpha = 0.2; // Dim the backgroud of the currently active control
			dialogue.useconfontgraphics = Cursor; // Uses confont for selector only.  If set to 'None', use graphics for all.  If set to 'All', use confont for cursor and scrollbars

		let Background = dialogue.AddNew("DialogueBackground");
			Background.image = "CONVBACK";
			Background.dim.alpha = 0.25;

		let SpeakerName = dialogue.AddNew("DialogueTextBox");
			SpeakerName.scale = 0.5;
			SpeakerName.SetFont = "BigFont";
			SpeakerName.fontcolor = Font.CR_DARKRED;
			SpeakerName.caption = ParseSpeakerName();
			SpeakerName.w = width;
			SpeakerName.pos.x = xAlign;
			SpeakerName.pos.y = yAlign;

		let Responses = dialogue.AddNew("DialogueResponses");
			Responses.scale = 0.7;
			Responses.fontcolor = Font.CR_UNTRANSLATED;
			Responses.linespacing = 1.5;
			Responses.w = width;
			Responses.refname = "Responses";
			Responses.pos.x = xAlign;
			Responses.margin.top = 2;
			Responses.margin.bottom = 2;
			Responses.margin.left = 2;
			Responses.margin.right = 2;
			Responses.dim.alpha = 0.45;
			Responses.numberformat = "%d. ";
			Responses.numberwidth = 16;
			Responses.tabindex = 2;
			Responses.numberalign = ALIGN_Right;
			ParseReplies(int((width - (4 + Responses.numberwidth + 4)) / Responses.scale), "SmallFont"); //ParseReplies is still basically the old parsing code - TODO: Redo more generically...
			Responses.Init(); // Early direct call to Init to automatically calculate height based on response line count

			Responses.pos.y = 225 - Responses.h; // 'h' calculated during Init call

		let SpeakerText = dialogue.AddNew("DialogueTextBox");
			SpeakerText.linespacing = 2.0;
			SpeakerText.caption = ParseSpeakerMessage();
			SpeakerText.refname = "SpeakerText";
			SpeakerText.pos.x = xAlign;
			SpeakerText.pos.y = yAlign + 16;
			SpeakerText.w = width;
			SpeakerText.h = Responses.pos.y - 8 - SpeakerText.pos.y; // Fills screen down to just above response block
			SpeakerText.margin.top = 2;
			SpeakerText.margin.bottom = 2;
			SpeakerText.margin.left = 2;
			SpeakerText.margin.right = 2;
			SpeakerText.scale = 0.75;
			SpeakerText.tabindex = 1;

		let Icon = dialogue.AddNew("DialogueIcon");
			Icon.parent = SpeakerText; //Link to speakertext in order to animate the icon according to what character is being "spoken"
			Icon.image = mCurNode.Backdrop;
			Icon.h = 38;
			Icon.w = 38;
			Icon.pos.x = int(xAlign - 10 - Icon.w);
			Icon.pos.y = yAlign;
			Icon.margin.left = 1;
			Icon.margin.right = 1;
			Icon.margin.top = 1;
			Icon.margin.bottom = 1;
			Icon.dim.alpha = 0.45;

		dialogue.Initialize(self);

		return 100; // y value on screen where output messages will appear
	}
}