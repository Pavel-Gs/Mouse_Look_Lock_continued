local Version = '7.1'
local Debugging = false
local MouseLook_TempLockout = false
local MouseLook_LastUpdate = 0
local MouseLook_UpdateFrequency = 0.1  -- adjust this number UP to improve frame rate


-- ARE THESE NEEDED?
BINDING_HEADER_MouseLook            = 'MouseLook'
BINDING_NAME_MouseLook_mode_toggle  = "MouseLook toggle"
BINDING_NAME_MouseLook_momentary    = "MouseLook momentary"


-- LIST OF FRAMES THAT SHOULD AUTOMATICALLY UNDO MOUSELOOK WHILE THEY ARE UP
local MouseLook_FramesToCheck = {
	"ACP_AddonList",             "GossipFrame",              "PetBattleFrame",            "TotemStomperFrame",
	"ARKINV_Frame1",             "GuildFrame",               "PetJournalParent",          "TradeFrame",
	"AccountantFrame",           "GuildRegistrarFrame",      "PetPaperDollFrame",         "TradeSkillFrame",
	"AchievementFrame",          "HelpFrame",                "PetRenamePopup",            "TutorialFrame",
	"AddonList",                 "ImprovedErrorFrame",       "PetStable",                 "UIOptionsFrame",
	"AuctionFrame",              "InspectFrame",             "PlayerChoiceFrame",         "UnitPopup",
	"AuctionHouseFrame",         "InspectPaperDollFrame",    "PlayerSpellsFrame",         "VideoOptionsFrame",
	"AutoPotion_Template_Dialog","InterfaceOptionsFrame",    "PlayerTalentFrame",         "VoiceMacroMenu",
	"BagnonBank1",               "InventoryManagerFrame",    "ProfessionsBookFrame",      "WantAds",
	"BagnonFrameinventory",      "ItemInteractionFrame",     "ProfessionsFrame",          "WardrobeFrame",
	"BagnonInventoryFrame1",     "ItemUpgradeFrame",         "PVEFrame",                  "WeeklyRewardsFrame",
	"BankFrame",                 "KeyBindingFrame",          "PVPUIFrame",                "WorldMapFrame",
	"BattlefieldFrame",          "LanguageMenu",             "QuestFrame",                "Z_ExtraEndPlaceholder",
	"CharacterFrame",            "LFGDungeonReadyDialog",    "QuestLogFrame",             "Z_TemporaryPlaceholder",
	"ChatMenu",                  "LoXXXotFrame",             "QuestShareFrame",           "qcQuestCompletistUI",
	"ChessFrame",                "LookingForGuildFrame",     "RaidFrame",                 "scrappingMachineFrame",
	"ChooseItemsFrame",          "MacroFrame",               "ReputationFrame",			  "BagnonInventory1",
	"ChromieTimeFrame",          "MailFrame",                "ScriptErrors",			  "ScriptErrorsFrame",
	"ClassTalentFrame",          "MajorFactionRenownFrame",  "SettingsPanel",
	"ClassTrainerFrame",         "MerchantFrame",            "SkillFrame",
	"CoinPickupFrame",           "MinesweeperFrame",         "SoundOptionsFrame",
	"CollectionsJournal",        "NxSocial",                 "SpellBookFrame",
	"CommunitiesFrame",          "OptionsFrame",             "StackSplitFrame",
	"ConnectFrame",              "OrderHallTalentFrame",     "StaticPopup1",
	"ContainerFrame1",           "OtherFrame",               "StaticPopup2",
	"ContainerFrame2",           "PaperDollFrame",           "StaticPopup3",
	"ContainerFrame3",           "PetitionFrame",            "StaticPopup4",
	"ContainerFrame4",           "PlayerFrame",              "StatsFrame",
	"ContainerFrame5",           "PlayerTalentFrame",        "SubscriptionInterstitialFrame",
	"ContainerFrame6",           "ProfessionsBookFrame",     "SuggestFrame",
	"ContainerFrame7",           "ProfessionsFrame",         "TabardFrame",
	"ContainerFrame8",           "PVEFrame",                 "TalentFrame",
	"ContainerFrame9",           "PVPUIFrame",               "TalentTrainerFrame",
	"ContainerFrame10",          "QuestFrame",               "TaxiFrame",
	"ContainerFrame11",          "QuestLogFrame",            "TicTacToeFrame",
	"ContainerFrame12",          "QuestShareFrame",          "TradeFrame",
	"ContainerFrame13",          "RaidFrame",                "TradeSkillFrame",
	"ContainerFrame14",          "ReputationFrame",          "TutorialFrame",
	"ContainerFrame15",          "ScriptErrors",             "UIOptionsFrame",
	"ContainerFrame16",          "SettingsPanel",            "UnitPopup",
	"ContainerFrame17",          "SkillFrame",               "VideoOptionsFrame",
	"ContainerFrameCombinedBags","SoundOptionsFrame",        "VoiceMacroMenu",
	"CosmosDropDown",            "SpellBookFrame",           "WantAds",
	"CosmosDropDownBis",         "StackSplitFrame",          "WardrobeFrame",
	"CosmosMasterFrame",         "StaticPopup1",             "WeeklyRewardsFrame",
	"CovenantMissionFrame",      "StaticPopup2",             "WorldMapFrame",
	"CraftFrame",                "StaticPopup3",             "Z_ExtraEndPlaceholder",
	"DropDownList1",             "StaticPopup4",             "Z_TemporaryPlaceholder",
	"DropDownList2",             "StatsFrame",               "qcQuestCompletistUI",
	"DropDownList3",             "scrappingMachineFrame",	 "SubscriptionInterstitialFrame",
	"EmoteMenu",                 "SuggestFrame",
	"EncounterJournal",          "TabardFrame",
	"FlightMapFrame",            "TalentFrame",
	"FriendsFrame",              "TalentTrainerFrame",
	"GameMenuFrame",             "TaxiFrame",
	"GamesListFrame",            "TicTacToeFrame",
	"GenericTraitFrame",         "TotemStomperFrame",
}
-- "UIErrorsFrame",
-- "NxMap1", (carbonite's world map breaks mouselook)
-- "StoreFrame", (causes taint??!??  wtf, blizzard?)


-- LIST OF FRAMES THAT MOUSE MIGHT BE OVER (YES, THESE COULD BADLY USE SOME CLEANUP)
local MouseLook_FramesToCheckForMouse = {
	"AutoFollowStatus",           "CosmosTooltip",             "ItemBuffButton4",           "QuestTimerFrame",         "TargetStatsTooltip",
	"BonusActionBarFrame",        "DialogBoxFrame",            "ItemBuffButton5",           "SecondBar",               "UnitFrame",
	"BuffFrame",                  "DPSPLUS_PlayerFrame",       "ItemBuffButton6",           "SideBar",                 "MonitorStatus",
	"CastingBarFrame",            "DurabilityFrame",           "ItemBuffBar",               "SideBar2",                "PartyFrame",
	"ChatFrame1BottomButton",     "GameTimeFrame",             "ItemTextFrame",             "TargetDistanceFrame",     "PetActionBarFrame",
	"ChatFrame1DownButton",       "HealomaticMainFrame",       "KillCountFrame",            "TargetFrame",             "PetFrame",
	"ChatFrame1Tab",              "InventoryManagerTooltip",   "KillCountFrame2",           "ChatFrameMenuButton",     "PetitionFrame",
	"ChatFrame1UpButton",         "ItemBuffButton1",           "MainMenuBar",               "ChatFrameEditBox",        "PlayerFrame",
	"ChatFrame2BottomButton",     "ItemBuffButton2",           "MinimapCluster",            "CombatStatsDataFrame",    "ChatFrame2DownButton",
	"ChatFrame2Tab",              "ItemBuffButton3",           "CombatStatsFrame",          "ChatFrame2UpButton",      "ChatFrame3BottomButton",
	"ChatFrame3DownButton",       "ChatFrame3Tab",             "ChatFrame3UpButton",        "ChatFrame4BottomButton",  "ChatFrame4DownButton",
	"ChatFrame4Tab",              "ChatFrame4UpButton",        "ChatFrame5BottomButton",    "ChatFrame5DownButton",    "ChatFrame5Tab",
	"ChatFrame5UpButton",         "ChatFrame6BottomButton",    "ChatFrame6DownButton",      "ChatFrame6Tab",           "ChatFrame6UpButton",
	"ChatFrame7BottomButton",     "ChatFrame7DownButton",      "ChatFrame7Tab",             "ChatFrame7UpButton",      "ClockFrame",
	"CoinPickupFrame",            "ColorPickerFrame",          "InventoryManagerTooltip",   "MonitorStatus",           "SideBar2",
}


local function ML_debug(...)
	if not DEFAULT_CHAT_FRAME or not Debugging then return end
	local msg = ''
	for k,v in ipairs(arg) do
		msg = msg .. tostring(v) .. ' : '
	end
	DEFAULT_CHAT_FRAME:AddMessage(msg)
end


local function Print(text)
	if not DEFAULT_CHAT_FRAME then return end
	DEFAULT_CHAT_FRAME:AddMessage(text)
end


local function UnmouseableFrameOnScreen()
	for index in pairs(MouseLook_FramesToCheck) do
		local curFrame = getglobal(MouseLook_FramesToCheck[index])
		if (curFrame and curFrame:IsVisible()) then
			--ML_debug("Frame on screen : " .. MouseLook_FramesToCheck[index])
			return true
		end
	end
end


local function MouseIsOverFrame()
	for index in pairs(MouseLook_FramesToCheckForMouse) do
		local curFrameName = MouseLook_FramesToCheckForMouse[index]
		local curFrame = getglobal(curFrameName)
		if  curFrame
		and curFrame:IsVisible() then
			local xPos, yPos = GetCursorPosition()
			local top    = curFrame:GetTop()    * UIParent:GetScale() + 10
			local right  = curFrame:GetRight()  * UIParent:GetScale() + 10
			local left   = curFrame:GetLeft()   * UIParent:GetScale() - 10
			local bottom = curFrame:GetBottom() * UIParent:GetScale() - 10
			if string.find(curFrameName, "ChatFrame") then
				top = top + 10
				left = left - 10
			end
			if  xPos and yPos
			and left and right
			and top  and bottom then
				if  (xPos >= left)
				and (xPos <= right)
				and (yPos >= bottom)
				and (yPos <= top) then
					--ML_debug("Mouse is over frame : " .. curFrameName)
					return true
				end
			end
		end
	end
end


function MouseLook_OnUpdate(self,elapsed,...)
	MouseLook_LastUpdate = MouseLook_LastUpdate + elapsed
	if (MouseLook_LastUpdate >= MouseLook_UpdateFrequency) then
		MouseLook_LastUpdate = 0
		if MouseLookOn
		and not MouseLook_MomentaryPointer then
			if CursorHasItem()
			or UnmouseableFrameOnScreen()
			or MouseIsOverFrame()
			or SpellIsTargeting() then
				if not MouseLook_TempLockout then
					--IsMouselooking() -- also for mouselook tools ;)
					MouselookStop()
					--Print("MouselookStop()")
					--SetBinding("BUTTON1","CAMERAORSELECTORMOVE")
					--SetBinding("BUTTON2","TURNORACTION")
					MouseLook_TempLockout = true
				end
			else
				if MouseLook_TempLockout then
					MouselookStart()
					--Print("MouselookStart()")
					--SetBinding("BUTTON1","MOVEBACKWARD")
					--SetBinding("BUTTON2","MOVEFORWARD")
					MouseLook_TempLockout = false
				end
			end
		end
	end
end


function MouseLook_Toggle()
	if not MouseLookOn then
		MouselookStart()
		--SetBinding("BUTTON1","MOVEBACKWARD")
		--SetBinding("BUTTON2","MOVEFORWARD")
		MouseLookOn = true
	else
		MouselookStop()
		--SetBinding("BUTTON1","CAMERAORSELECTORMOVE")
		--SetBinding("BUTTON2","TURNORACTION")
		MouseLookOn = false
	end
end


local oldMouseDown
local oldMouseUp
local mouse_button_down


local function status(bool)
	if bool then return "true" else return "false" end
end


function MouseLook_Momentary(keystate)
	if MouseLookOn then
		if ( keystate == "down" ) then
			MouselookStop()
			--Print("MouselookStop()")
			--SetBinding("BUTTON1","CAMERAORSELECTORMOVE")
			--SetBinding("BUTTON2","TURNORACTION")
			MouseLook_MomentaryPointer = true
			--Print("Down")
		else
			--if mouse_button_down then
			--	waiting_to_reset = true
			--	Print("1")
			--else
				if not MouseLook_TempLockout then
					MouselookStart()
					--Print("MouselookStart()")
					--SetBinding("BUTTON1","MOVEBACKWARD")
					--SetBinding("BUTTON2","MOVEFORWARD")
					--Print("2")
				else
					--Print("3")
				end
				MouseLook_MomentaryPointer = false
			--end
			--Print("up")
		end
	end
end


function MouseLook_OnLoad(self,...)
	MouseLookFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
	MouseLookFrame:RegisterEvent("PLAYER_REGEN_DISABLED")
	MouseLookFrame:RegisterEvent("PLAYER_REGEN_ENABLED")
	oldMouseDown=WorldFrame:GetScript("OnMouseDown")
	oldMouseUp = WorldFrame:GetScript("OnMouseUp")
	WorldFrame:SetScript("OnMouseDown",MouseDown)
	WorldFrame:SetScript("OnMouseUp",MouseUp)
	SetMouselookOverrideBinding("BUTTON1", "MOVEBACKWARD") --------------
	SetMouselookOverrideBinding("BUTTON2", "MOVEFORWARD") --------------
	--Print("on load")
end


-- NEED TO DETERMINE WHICH MOUSEBUTTON IS DOWN. IT'S IN ARG2. HOW DO I READ IT? I FORGOT. ACTUALLY, IT DOESN'T REALLY MATTER ANYMORE.
function MouseDown(...)
	if mouse_button_down then
		--both_buttons_down = true
		--Print("MouseDown() mouse_button_down true")
	else
		mouse_button_down = true
		--Print("MouseDown() mouse_button_down false")
	end
	if oldMouseDown then oldMouseDown(args) end
end


function MouseUp(...)
	if both_buttons_down then
		both_buttons_down = false
		--Print("MouseUp() both_buttons_down true")
	else
		mouse_button_down = false
		--Print("MouseUp() both_buttons_down false")
		if waiting_to_reset then
			MouseLook_TempLockout = true
			MouseLook_MomentaryPointer = false
			waiting_to_reset = false
		end
	end
	if oldMouseUp then oldMouseUp(args) end
end


function MouseLook_OnEvent(self,event,...)
	--Print("on event:" ..event)
	if event == "PLAYER_ENTERING_WORLD" then
		--Print("PLAYER_ENTERING_WORLD event")
		if MouseLookOn then
			--Print("Trying to automatically start Mouselook")
			MouselookStart()
			--Print("MouselookStart()")
			--SetBinding("BUTTON1","MOVEBACKWARD")
			--SetBinding("BUTTON2","MOVEFORWARD")
		end
	end
	if event == "PLAYER_REGEN_DISABLED" then
		if MouseLookOn then
			--SetBinding("BUTTON1","CAMERAORSELECTORMOVE")
			--SetBinding("BUTTON2","TURNORACTION")
		end
	end
	if event == "PLAYER_REGEN_ENABLED" then
		if MouseLookOn then
			--SetBinding("BUTTON1","MOVEBACKWARD")
			--SetBinding("BUTTON2","MOVEFORWARD")
		end
	end
end
