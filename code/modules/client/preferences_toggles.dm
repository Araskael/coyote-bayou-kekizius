//this works as is to create a single checked item, but has no back end code for toggleing the check yet
#define TOGGLE_CHECKBOX(PARENT, CHILD) PARENT/CHILD/abstract = TRUE;PARENT/CHILD/checkbox = CHECKBOX_TOGGLE;PARENT/CHILD/verb/CHILD

//Example usage TOGGLE_CHECKBOX(datum/verbs/menu/Settings/Ghost/chatterbox, toggle_ghost_ears)()

//override because we don't want to save preferences twice.
/datum/verbs/menu/Settings/Set_checked(client/C, verbpath)
	if (checkbox == CHECKBOX_GROUP)
		C.prefs.menuoptions[type] = verbpath
	else if (checkbox == CHECKBOX_TOGGLE)
		var/checked = Get_checked(C)
		C.prefs.menuoptions[type] = !checked
		winset(C, "[verbpath]", "is-checked = [!checked]")

/datum/verbs/menu/Settings/verb/setup_character()
	set name = "Game Preferences"
	set category = "Preferences"
	set desc = "Open Game Preferences Window"
	usr.client.prefs.current_tab = 1
	usr.client.prefs.ShowChoices(usr)

//toggles
/datum/verbs/menu/Settings/Ghost/chatterbox
	name = "Chat Box Spam"

TOGGLE_CHECKBOX(/datum/verbs/menu/Settings/Ghost/chatterbox, toggle_ghost_ears)()
	set name = "Show/Hide GhostEars"
	set category = "Preferences"
	set desc = "See All Speech"
	usr.client.prefs.chat_toggles ^= CHAT_GHOSTEARS
	to_chat(usr, "As a ghost, you will now [(usr.client.prefs.chat_toggles & CHAT_GHOSTEARS) ? "see all speech in the world" : "only see speech from nearby mobs"].")
	usr.client.prefs.save_preferences()
	SSblackbox.record_feedback("nested tally", "preferences_verb", 1, list("Toggle Ghost Ears", "[usr.client.prefs.chat_toggles & CHAT_GHOSTEARS ? "Enabled" : "Disabled"]")) //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!
/datum/verbs/menu/Settings/Ghost/chatterbox/toggle_ghost_ears/Get_checked(client/C)
	return C.prefs.chat_toggles & CHAT_GHOSTEARS

TOGGLE_CHECKBOX(/datum/verbs/menu/Settings/Ghost/chatterbox, toggle_ghost_sight)()
	set name = "Show/Hide GhostSight"
	set category = "Preferences"
	set desc = "See All Emotes"
	usr.client.prefs.chat_toggles ^= CHAT_GHOSTSIGHT
	to_chat(usr, "As a ghost, you will now [(usr.client.prefs.chat_toggles & CHAT_GHOSTSIGHT) ? "see all emotes in the world" : "only see emotes from nearby mobs"].")
	usr.client.prefs.save_preferences()
	SSblackbox.record_feedback("nested tally", "preferences_verb", 1, list("Toggle Ghost Sight", "[usr.client.prefs.chat_toggles & CHAT_GHOSTSIGHT ? "Enabled" : "Disabled"]")) //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!
/datum/verbs/menu/Settings/Ghost/chatterbox/toggle_ghost_sight/Get_checked(client/C)
	return C.prefs.chat_toggles & CHAT_GHOSTSIGHT

TOGGLE_CHECKBOX(/datum/verbs/menu/Settings/Ghost/chatterbox, toggle_ghost_whispers)()
	set name = "Show/Hide GhostWhispers"
	set category = "Preferences"
	set desc = "See All Whispers"
	usr.client.prefs.chat_toggles ^= CHAT_GHOSTWHISPER
	to_chat(usr, "As a ghost, you will now [(usr.client.prefs.chat_toggles & CHAT_GHOSTWHISPER) ? "see all whispers in the world" : "only see whispers from nearby mobs"].")
	usr.client.prefs.save_preferences()
	SSblackbox.record_feedback("nested tally", "preferences_verb", 1, list("Toggle Ghost Whispers", "[usr.client.prefs.chat_toggles & CHAT_GHOSTWHISPER ? "Enabled" : "Disabled"]")) //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!
/datum/verbs/menu/Settings/Ghost/chatterbox/toggle_ghost_whispers/Get_checked(client/C)
	return C.prefs.chat_toggles & CHAT_GHOSTWHISPER

TOGGLE_CHECKBOX(/datum/verbs/menu/Settings/Ghost/chatterbox, toggle_ghost_radio)()
	set name = "Show/Hide GhostRadio"
	set category = "Preferences"
	set desc = "See All Radio Chatter"
	usr.client.prefs.chat_toggles ^= CHAT_GHOSTRADIO
	to_chat(usr, "As a ghost, you will now [(usr.client.prefs.chat_toggles & CHAT_GHOSTRADIO) ? "see radio chatter" : "not see radio chatter"].")
	usr.client.prefs.save_preferences()
	SSblackbox.record_feedback("nested tally", "preferences_verb", 1, list("Toggle Ghost Radio", "[usr.client.prefs.chat_toggles & CHAT_GHOSTRADIO ? "Enabled" : "Disabled"]")) //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc! //social experiment, increase the generation whenever you copypaste this shamelessly GENERATION 1
/datum/verbs/menu/Settings/Ghost/chatterbox/toggle_ghost_radio/Get_checked(client/C)
	return C.prefs.chat_toggles & CHAT_GHOSTRADIO

TOGGLE_CHECKBOX(/datum/verbs/menu/Settings/Ghost/chatterbox, toggle_ghost_pda)()
	set name = "Show/Hide GhostPDA"
	set category = "Preferences"
	set desc = "See All PDA Messages"
	usr.client.prefs.chat_toggles ^= CHAT_GHOSTPDA
	to_chat(usr, "As a ghost, you will now [(usr.client.prefs.chat_toggles & CHAT_GHOSTPDA) ? "see all pda messages in the world" : "only see pda messages from nearby mobs"].")
	usr.client.prefs.save_preferences()
	SSblackbox.record_feedback("nested tally", "preferences_verb", 1, list("Toggle Ghost PDA", "[usr.client.prefs.chat_toggles & CHAT_GHOSTPDA ? "Enabled" : "Disabled"]")) //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!
/datum/verbs/menu/Settings/Ghost/chatterbox/toggle_ghost_pda/Get_checked(client/C)
	return C.prefs.chat_toggles & CHAT_GHOSTPDA

/datum/verbs/menu/Settings/Ghost/chatterbox/Events
	name = "Events"

//please be aware that the following two verbs have inverted stat output, so that "Toggle Deathrattle|1" still means you activated it
TOGGLE_CHECKBOX(/datum/verbs/menu/Settings/Ghost/chatterbox/Events, toggle_deathrattle)()
	set name = "Toggle Deathrattle"
	set category = "Preferences"
	set desc = "Death"
	usr.client.prefs.toggles ^= DISABLE_DEATHRATTLE
	usr.client.prefs.save_preferences()
	to_chat(usr, "You will [(usr.client.prefs.toggles & DISABLE_DEATHRATTLE) ? "no longer" : "now"] get messages when a sentient mob dies.")
	SSblackbox.record_feedback("nested tally", "preferences_verb", 1, list("Toggle Deathrattle", "[!(usr.client.prefs.toggles & DISABLE_DEATHRATTLE) ? "Enabled" : "Disabled"]")) //If you are copy-pasting this, maybe you should spend some time reading the comments.
/datum/verbs/menu/Settings/Ghost/chatterbox/Events/toggle_deathrattle/Get_checked(client/C)
	return !(C.prefs.toggles & DISABLE_DEATHRATTLE)

TOGGLE_CHECKBOX(/datum/verbs/menu/Settings/Ghost/chatterbox/Events, toggle_arrivalrattle)()
	set name = "Toggle Arrivalrattle"
	set category = "Preferences"
	set desc = "New Player Arrival"
	usr.client.prefs.toggles ^= DISABLE_ARRIVALRATTLE
	to_chat(usr, "You will [(usr.client.prefs.toggles & DISABLE_ARRIVALRATTLE) ? "no longer" : "now"] get messages when someone joins the station.")
	usr.client.prefs.save_preferences()
	SSblackbox.record_feedback("nested tally", "preferences_verb", 1, list("Toggle Arrivalrattle", "[!(usr.client.prefs.toggles & DISABLE_ARRIVALRATTLE) ? "Enabled" : "Disabled"]")) //If you are copy-pasting this, maybe you should rethink where your life went so wrong.
/datum/verbs/menu/Settings/Ghost/chatterbox/Events/toggle_arrivalrattle/Get_checked(client/C)
	return !(C.prefs.toggles & DISABLE_ARRIVALRATTLE)

TOGGLE_CHECKBOX(/datum/verbs/menu/Settings/Ghost, togglemidroundantag)()
	set name = "Toggle Midround Antagonist"
	set category = "Preferences"
	set desc = "Midround Antagonist"
	usr.client.prefs.toggles ^= MIDROUND_ANTAG
	usr.client.prefs.save_preferences()
	to_chat(usr, "You will [(usr.client.prefs.toggles & MIDROUND_ANTAG) ? "now" : "no longer"] be considered for midround antagonist positions.")
	SSblackbox.record_feedback("nested tally", "preferences_verb", 1, list("Toggle Midround Antag", "[usr.client.prefs.toggles & MIDROUND_ANTAG ? "Enabled" : "Disabled"]")) //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!
/datum/verbs/menu/Settings/Ghost/togglemidroundantag/Get_checked(client/C)
	return C.prefs.toggles & MIDROUND_ANTAG

TOGGLE_CHECKBOX(/datum/verbs/menu/Settings/Sound, toggletitlemusic)()
	set name = "Hear/Silence Lobby Music"
	set category = "Preferences"
	set desc = "Hear Music In Lobby"
	usr.client.prefs.toggles ^= SOUND_LOBBY
	usr.client.prefs.save_preferences()
	if(usr.client.prefs.toggles & SOUND_LOBBY)
		to_chat(usr, "You will now hear music in the game lobby.")
		if(isnewplayer(usr))
			usr.client.playtitlemusic()
	else
		to_chat(usr, "You will no longer hear music in the game lobby.")
		usr.stop_sound_channel(CHANNEL_LOBBYMUSIC)
	SSblackbox.record_feedback("nested tally", "preferences_verb", 1, list("Toggle Lobby Music", "[usr.client.prefs.toggles & SOUND_LOBBY ? "Enabled" : "Disabled"]")) //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!
/datum/verbs/menu/Settings/Sound/toggletitlemusic/Get_checked(client/C)
	return C.prefs.toggles & SOUND_LOBBY


TOGGLE_CHECKBOX(/datum/verbs/menu/Settings/Sound, togglemidis)()
	set name = "Hear/Silence Midis"
	set category = "Preferences"
	set desc = "Hear Admin Triggered Sounds (Midis)"
	usr.client.prefs.toggles ^= SOUND_MIDI
	usr.client.prefs.save_preferences()
	if(usr.client.prefs.toggles & SOUND_MIDI)
		to_chat(usr, "You will now hear any sounds uploaded by admins.")
	else
		to_chat(usr, "You will no longer hear sounds uploaded by admins")
		usr.stop_sound_channel(CHANNEL_ADMIN)
		var/client/C = usr.client
		C?.tgui_panel?.stop_music()
	SSblackbox.record_feedback("nested tally", "preferences_verb", 1, list("Toggle Hearing Midis", "[usr.client.prefs.toggles & SOUND_MIDI ? "Enabled" : "Disabled"]")) //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!
/datum/verbs/menu/Settings/Sound/togglemidis/Get_checked(client/C)
	return C.prefs.toggles & SOUND_MIDI


TOGGLE_CHECKBOX(/datum/verbs/menu/Settings/Sound, toggle_instruments)()
	set name = "Hear/Silence Instruments"
	set category = "Preferences"
	set desc = "Hear In-game Instruments"
	usr.client.prefs.toggles ^= SOUND_INSTRUMENTS
	usr.client.prefs.save_preferences()
	if(usr.client.prefs.toggles & SOUND_INSTRUMENTS)
		to_chat(usr, "You will now hear people playing musical instruments.")
	else
		to_chat(usr, "You will no longer hear musical instruments.")
	SSblackbox.record_feedback("nested tally", "preferences_verb", 1, list("Toggle Instruments", "[usr.client.prefs.toggles & SOUND_INSTRUMENTS ? "Enabled" : "Disabled"]")) //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!
/datum/verbs/menu/Settings/Sound/toggle_instruments/Get_checked(client/C)
	return C.prefs.toggles & SOUND_INSTRUMENTS


TOGGLE_CHECKBOX(/datum/verbs/menu/Settings/Sound, Toggle_Soundscape)()
	set name = "Hear/Silence Ambience"
	set category = "Preferences"
	set desc = "Hear Ambient Sound Effects"
	usr.client.prefs.toggles ^= SOUND_AMBIENCE
	usr.client.prefs.save_preferences()
	if(usr.client.prefs.toggles & SOUND_AMBIENCE)
		to_chat(usr, "You will now hear ambient sounds.")
	else
		to_chat(usr, "You will no longer hear ambient sounds.")
		SEND_SOUND(usr, sound(null))
	SSblackbox.record_feedback("nested tally", "preferences_verb", 1, list("Toggle Ambience", "[usr.client.prefs.toggles & SOUND_AMBIENCE ? "Enabled" : "Disabled"]")) //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!
/datum/verbs/menu/Settings/Sound/Toggle_Soundscape/Get_checked(client/C)
	return C.prefs.toggles & SOUND_AMBIENCE


TOGGLE_CHECKBOX(/datum/verbs/menu/Settings/Sound, toggle_ship_ambience)()
	set name = "Hear/Silence Wasteland Ambience"
	set category = "Preferences"
	set desc = "Hear Wasteland Ambience"
	usr.client.prefs.toggles ^= SOUND_SHIP_AMBIENCE
	usr.client.prefs.save_preferences()
	if(usr.client.prefs.toggles & SOUND_SHIP_AMBIENCE)
		to_chat(usr, "You will now hear wasteland ambience.")
	else
		to_chat(usr, "You will no longer hear wasteland ambience.")
		SEND_SOUND(usr, sound(null))
	SSblackbox.record_feedback("nested tally", "preferences_verb", 1, list("Toggle Wasteland Ambience", "[usr.client.prefs.toggles & SOUND_SHIP_AMBIENCE ? "Enabled" : "Disabled"]")) //If you are copy-pasting this, I bet you read this comment expecting to see the same thing :^)
/datum/verbs/menu/Settings/Sound/toggle_ship_ambience/Get_checked(client/C)
	return C.prefs.toggles & SOUND_SHIP_AMBIENCE


TOGGLE_CHECKBOX(/datum/verbs/menu/Settings/Sound, toggle_announcement_sound)()
	set name = "Hear/Silence Announcements"
	set category = "Preferences"
	set desc = "Hear Announcement Sound"
	usr.client.prefs.toggles ^= SOUND_ANNOUNCEMENTS
	to_chat(usr, "You will now [(usr.client.prefs.toggles & SOUND_ANNOUNCEMENTS) ? "hear announcement sounds" : "no longer hear announcements"].")
	usr.client.prefs.save_preferences()
	SSblackbox.record_feedback("nested tally", "preferences_verb", 1, list("Toggle Announcement Sound", "[usr.client.prefs.toggles & SOUND_ANNOUNCEMENTS ? "Enabled" : "Disabled"]")) //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!
/datum/verbs/menu/Settings/Sound/toggle_announcement_sound/Get_checked(client/C)
	return C.prefs.toggles & SOUND_ANNOUNCEMENTS


TOGGLE_CHECKBOX(/datum/verbs/menu/Settings/Sound, toggle_sound_indicator)()
	set name = "Hear/Silence Sound Indicator"
	set category = "Preferences"
	set desc = "Hear Sound Indicator"
	usr.client.prefs.toggles ^= SOUND_SI
	to_chat(usr, "You will now [(usr.client.prefs.toggles & SOUND_SI) ? "hear the sound indicator" : "no longer hear the sound indicator"].")
	usr.client.prefs.save_preferences()
	SSblackbox.record_feedback("nested tally", "preferences_verb", 1, list("Toggle Sound Indicator", "[usr.client.prefs.toggles & SOUND_SI ? "Enabled" : "Disabled"]")) //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!
/datum/verbs/menu/Settings/Sound/toggle_sound_indicator/Get_checked(client/C)
	return C.prefs.toggles & SOUND_SI


TOGGLE_CHECKBOX(/datum/verbs/menu/Settings/Sound, toggleprayersounds)()
	set name = "Hear/Silence Prayer Sounds"
	set category = "Preferences"
	set desc = "Hear Prayer Sounds"
	usr.client.prefs.toggles ^= SOUND_PRAYERS
	usr.client.prefs.save_preferences()
	if(usr.client.prefs.toggles & SOUND_PRAYERS)
		to_chat(usr, "You will now hear prayer sounds.")
	else
		to_chat(usr, "You will no longer prayer sounds.")
	SSblackbox.record_feedback("nested tally", "admin_toggle", 1, list("Toggle Prayer Sounds", "[usr.client.prefs.toggles & SOUND_PRAYERS ? "Enabled" : "Disabled"]"))
/datum/verbs/menu/Settings/Sound/toggleprayersounds/Get_checked(client/C)
	return C.prefs.toggles & SOUND_PRAYERS


/datum/verbs/menu/Settings/Sound/verb/stop_client_sounds()
	set name = "Stop Sounds"
	set category = "Preferences"
	set desc = "Stop Current Sounds"
	SEND_SOUND(usr, sound(null))
	var/client/C = usr.client
	C?.tgui_panel?.stop_music()
	SSblackbox.record_feedback("nested tally", "preferences_verb", 1, list("Stop Self Sounds")) //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!


TOGGLE_CHECKBOX(/datum/verbs/menu/Settings, listen_ooc)()
	set name = "Show/Hide OOC"
	set category = "Preferences"
	set desc = "Toggles seeing Out Of Character chat"
	usr.client.prefs.chat_toggles ^= CHAT_OOC
	usr.client.prefs.save_preferences()
	to_chat(usr, "You will [(usr.client.prefs.chat_toggles & CHAT_OOC) ? "now" : "no longer"] see messages on the OOC channel.")
	SSblackbox.record_feedback("nested tally", "preferences_verb", 1, list("Toggle Seeing OOC", "[usr.client.prefs.chat_toggles & CHAT_OOC ? "Enabled" : "Disabled"]")) //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!
/datum/verbs/menu/Settings/listen_ooc/Get_checked(client/C)
	return C.prefs.chat_toggles & CHAT_OOC

TOGGLE_CHECKBOX(/datum/verbs/menu/Settings, listen_looc)()
	set name = "Show/Hide LOOC"
	set category = "Preferences"
	set desc = "Toggles seeing LocalOutOfCharacter chat"
	usr.client.prefs.chat_toggles |= CHAT_LOOC
	usr.client.prefs.save_preferences()
	//to_chat(usr, "You will [(usr.client.prefs.chat_toggles & CHAT_LOOC) ? "now" : "no longer"] see messages on the LOOC channel.")
	to_chat(usr, "Local OOC cannot be disabled. If someone is being obnoxious over LOOC, please ahelp.")
	SSblackbox.record_feedback("nested tally", "preferences_verb", 1, list("Toggle Seeing LOOC", "[usr.client.prefs.chat_toggles & CHAT_LOOC ? "Enabled" : "Disabled"]"))
/datum/verbs/menu/Settings/listen_looc/Get_checked(client/C)
	return C.prefs.chat_toggles & CHAT_LOOC

TOGGLE_CHECKBOX(/datum/verbs/menu/Settings, listen_anonooc)()
	set name = "Show/Hide AnonOOC"
	set category = "Preferences"
	set desc = "Toggles seeing Anonymous Out Of Character chat"
	usr.client.prefs.chat_toggles ^= CHAT_AOOC
	usr.client.prefs.save_preferences()
	to_chat(usr, "You will [(usr.client.prefs.chat_toggles & CHAT_AOOC) ? "now" : "no longer"] see messages on the AnonOOC channel.")
	SSblackbox.record_feedback("nested tally", "preferences_verb", 1, list("Toggle Seeing AnonOOC", "[usr.client.prefs.chat_toggles & CHAT_AOOC ? "Enabled" : "Disabled"]")) //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!
/datum/verbs/menu/Settings/listen_aooc/Get_checked(client/C)
	return C.prefs.chat_toggles & CHAT_AOOC

TOGGLE_CHECKBOX(/datum/verbs/menu/Settings, listen_bank_card)()
	set name = "Show/Hide Income Updates"
	set category = "Preferences"
	set desc = "Show or hide updates to your income"
	usr.client.prefs.chat_toggles ^= CHAT_BANKCARD
	usr.client.prefs.save_preferences()
	to_chat(usr, "You will [(usr.client.prefs.chat_toggles & CHAT_BANKCARD) ? "now" : "no longer"] be notified when you get paid.")
	SSblackbox.record_feedback("nested tally", "preferences_verb", 1, list("Toggle Income Notifications", "[(usr.client.prefs.chat_toggles & CHAT_BANKCARD) ? "Enabled" : "Disabled"]"))
/datum/verbs/menu/Settings/listen_bank_card/Get_checked(client/C)
	return C.prefs.chat_toggles & CHAT_BANKCARD

TOGGLE_CHECKBOX(/datum/verbs/menu/Settings, toggle_gun_cursor)()
	set name = "Show Gun Cursor"
	set category = "Preferences"
	set desc = "Show the gun cursor when you have one out"
	usr.client.prefs.cb_toggles ^= AIM_CURSOR_ON
	usr.client.prefs.save_preferences()
	to_chat(usr, "You will [(usr.client.prefs.chat_toggles & AIM_CURSOR_ON) ? "now" : "no longer"] see a sickass cursor when you have a gun out.")
	SSblackbox.record_feedback("nested tally", "preferences_verb", 1, list("Toggle Gun Cursor", "[(usr.client.prefs.chat_toggles & CHAT_BANKCARD) ? "Enabled" : "Disabled"]"))


TOGGLE_CHECKBOX(/datum/verbs/menu/Settings, fit_window)()
	set name = "Boss Left"
	set category = "Preferences"
	set desc = "Fit Viewport"
	usr.client.fit_viewport()

GLOBAL_LIST_INIT(ghost_forms, list("ghost","ghostking","ghostian2","skeleghost","ghost_red","ghost_black", \
							"ghost_blue","ghost_yellow","ghost_green","ghost_pink", \
							"ghost_cyan","ghost_dblue","ghost_dred","ghost_dgreen", \
							"ghost_dcyan","ghost_grey","ghost_dyellow","ghost_dpink", "ghost_purpleswirl","ghost_funkypurp","ghost_pinksherbert","ghost_blazeit",\
							"ghost_mellow","ghost_rainbow","ghost_camo","ghost_fire", "catghost"))
/client/proc/pick_form()
	if(!is_content_unlocked())
		alert("This setting is for accounts with BYOND premium only.")
		return
	var/new_form = input(src, "Thanks for supporting BYOND - Choose your ghostly form:","Thanks for supporting BYOND",null) as null|anything in GLOB.ghost_forms
	if(new_form)
		prefs.ghost_form = new_form
		prefs.save_preferences()
		if(isobserver(mob))
			var/mob/dead/observer/O = mob
			O.update_icon(new_form)

GLOBAL_LIST_INIT(ghost_orbits, list(GHOST_ORBIT_CIRCLE,GHOST_ORBIT_TRIANGLE,GHOST_ORBIT_SQUARE,GHOST_ORBIT_HEXAGON,GHOST_ORBIT_PENTAGON))

/client/proc/pick_ghost_orbit()
	if(!is_content_unlocked())
		alert("This setting is for accounts with BYOND premium only.")
		return
	var/new_orbit = input(src, "Thanks for supporting BYOND - Choose your ghostly orbit:","Thanks for supporting BYOND",null) as null|anything in GLOB.ghost_orbits
	if(new_orbit)
		prefs.ghost_orbit = new_orbit
		prefs.save_preferences()
		if(isobserver(mob))
			var/mob/dead/observer/O = mob
			O.ghost_orbit = new_orbit

/client/proc/pick_ghost_accs()
	var/new_ghost_accs = alert("Do you want your ghost to show full accessories where possible, hide accessories but still use the directional sprites where possible, or also ignore the directions and stick to the default sprites?",,"full accessories", "only directional sprites", "default sprites")
	if(new_ghost_accs)
		switch(new_ghost_accs)
			if("full accessories")
				prefs.ghost_accs = GHOST_ACCS_FULL
			if("only directional sprites")
				prefs.ghost_accs = GHOST_ACCS_DIR
			if("default sprites")
				prefs.ghost_accs = GHOST_ACCS_NONE
		prefs.save_preferences()
		if(isobserver(mob))
			var/mob/dead/observer/O = mob
			O.update_icon()

/client/verb/pick_ghost_customization()
	set name = "Ghost Customization"
	set category = "Preferences"
	set desc = "Customize your ghastly appearance."
	if(is_content_unlocked())
		switch(alert("Which setting do you want to change?",,"Ghost Form","Ghost Orbit","Ghost Accessories"))
			if("Ghost Form")
				pick_form()
			if("Ghost Orbit")
				pick_ghost_orbit()
			if("Ghost Accessories")
				pick_ghost_accs()
	else
		pick_ghost_accs()

/client/verb/pick_ghost_others()
	set name = "Ghosts of Others"
	set category = "Preferences"
	set desc = "Change display settings for the ghosts of other players."
	var/new_ghost_others = alert("Do you want the ghosts of others to show up as their own setting, as their default sprites or always as the default white ghost?",,"Their Setting", "Default Sprites", "White Ghost")
	if(new_ghost_others)
		switch(new_ghost_others)
			if("Their Setting")
				prefs.ghost_others = GHOST_OTHERS_THEIR_SETTING
			if("Default Sprites")
				prefs.ghost_others = GHOST_OTHERS_DEFAULT_SPRITE
			if("White Ghost")
				prefs.ghost_others = GHOST_OTHERS_SIMPLE
		prefs.save_preferences()
		if(isobserver(mob))
			var/mob/dead/observer/O = mob
			O.update_sight()

/client/verb/toggle_intent_style()
	set name = "Toggle Intent Selection Style"
	set category = "Preferences"
	set desc = "Toggle between directly clicking the desired intent or clicking to rotate through."
	prefs.toggles ^= INTENT_STYLE
	to_chat(src, "[(prefs.toggles & INTENT_STYLE) ? "Clicking directly on intents selects them." : "Clicking on intents rotates selection clockwise."]")
	prefs.save_preferences()
	SSblackbox.record_feedback("nested tally", "preferences_verb", 1, list("Toggle Intent Selection", "[prefs.toggles & INTENT_STYLE ? "Enabled" : "Disabled"]")) //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!

/client/verb/toggle_ghost_hud_pref()
	set name = "Toggle Ghost HUD"
	set category = "Preferences"
	set desc = "Hide/Show Ghost HUD"

	prefs.ghost_hud = !prefs.ghost_hud
	to_chat(src, "Ghost HUD will now be [prefs.ghost_hud ? "visible" : "hidden"].")
	prefs.save_preferences()
	if(isobserver(mob))
		mob.hud_used.show_hud()
	SSblackbox.record_feedback("nested tally", "preferences_verb", 1, list("Toggle Ghost HUD", "[prefs.ghost_hud ? "Enabled" : "Disabled"]"))

/client/verb/set_tbs()
	set name = "Set Top/Bottom/Switch"
	set category = "Preferences"
	set desc = "Set whether you're a top, a bottom, or a switch!"

	var/new_tbs = input(src, "Are you a top, bottom, or switch? (or none of the above)", "Character Preference") as null|anything in TBS_LIST
	if(new_tbs)
		prefs.tbs = new_tbs
	SSstatpanels.cached_tops -= ckey
	SSstatpanels.cached_bottoms -= ckey
	SSstatpanels.cached_switches -= ckey
	switch(prefs.tbs)
		if(TBS_TOP)
			SSstatpanels.cached_tops |= ckey
		if(TBS_BOTTOM)
			SSstatpanels.cached_bottoms |= ckey
		if(TBS_SHOES)
			SSstatpanels.cached_switches |= ckey
	to_chat(src, "You can now proudly say '[span_boldnotice(new_tbs)]'.")
	prefs.save_preferences()

/client/verb/set_kiss()
	set name = "Set Kisser"
	set category = "Preferences"
	set desc = "Set whether you kiss boys, girls, or none of the above!!"

	var/new_kiss = input(src, "What sort of person do you like to kiss?", "Character Preference") as null|anything in KISS_LIST
	if(new_kiss)
		prefs.kisser = new_kiss
	SSstatpanels.cached_boykissers -= ckey
	SSstatpanels.cached_girlkissers -= ckey
	SSstatpanels.cached_anykissers -= ckey
	switch(prefs.kisser)
		if(KISS_BOYS)
			SSstatpanels.cached_boykissers |= ckey
		if(KISS_GIRLS)
			SSstatpanels.cached_girlkissers |= ckey
		if(KISS_ANY)
			SSstatpanels.cached_anykissers |= ckey
	to_chat(src, "You can now proudly say '[span_boldnotice(new_kiss)]'.")
	prefs.save_preferences()


/client/verb/toggle_inquisition() // warning: unexpected inquisition
	set name = "Toggle Inquisitiveness"
	set desc = "Sets whether your ghost examines everything on click by default"
	set category = "Preferences"

	prefs.inquisitive_ghost = !prefs.inquisitive_ghost
	prefs.save_preferences()
	if(prefs.inquisitive_ghost)
		to_chat(src, span_notice("You will now examine everything you click on."))
	else
		to_chat(src, span_notice("You will no longer examine things you click on."))
	SSblackbox.record_feedback("nested tally", "preferences_verb", 1, list("Toggle Ghost Inquisitiveness", "[prefs.inquisitive_ghost ? "Enabled" : "Disabled"]"))

//Admin Preferences
/client/proc/toggleadminhelpsound()
	set name = "Hear/Silence Adminhelps"
	set category = "Preferences.Admin"
	set desc = "Toggle hearing a notification when admin PMs are received"
	if(!holder)
		return
	prefs.toggles ^= SOUND_ADMINHELP
	prefs.save_preferences()
	to_chat(usr, "You will [(prefs.toggles & SOUND_ADMINHELP) ? "now" : "no longer"] hear a sound when adminhelps arrive.")
	SSblackbox.record_feedback("nested tally", "admin_toggle", 1, list("Toggle Adminhelp Sound", "[prefs.toggles & SOUND_ADMINHELP ? "Enabled" : "Disabled"]")) //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!

/client/proc/toggleannouncelogin()
	set name = "Do/Don't Announce Login"
	set category = "Preferences.Admin"
	set desc = "Toggle if you want an announcement to admins when you login during a round"
	if(!holder)
		return
	prefs.toggles ^= ANNOUNCE_LOGIN
	prefs.save_preferences()
	to_chat(usr, "You will [(prefs.toggles & ANNOUNCE_LOGIN) ? "now" : "no longer"] have an announcement to other admins when you login.")
	SSblackbox.record_feedback("nested tally", "admin_toggle", 1, list("Toggle Login Announcement", "[prefs.toggles & ANNOUNCE_LOGIN ? "Enabled" : "Disabled"]")) //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!

/client/proc/toggle_hear_radio()
	set name = "Show/Hide Radio Chatter"
	set category = "Preferences.Admin"
	set desc = "Toggle seeing radiochatter from nearby radios and speakers"
	if(!holder)
		return
	prefs.chat_toggles ^= CHAT_RADIO
	prefs.save_preferences()
	to_chat(usr, "You will [(prefs.chat_toggles & CHAT_RADIO) ? "now" : "no longer"] see radio chatter from nearby radios or speakers")
	SSblackbox.record_feedback("nested tally", "admin_toggle", 1, list("Toggle Radio Chatter", "[prefs.chat_toggles & CHAT_RADIO ? "Enabled" : "Disabled"]")) //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!

/client/proc/toggle_split_admin_tabs()
	set name = "Toggle Split Admin Tabs"
	set category = "Preferences.Admin"
	set desc = "Toggle the admin tab being split into separate tabs instead of being merged into one"
	if(!holder)
		return
	prefs.toggles ^= SPLIT_ADMIN_TABS
	prefs.save_preferences()
	to_chat(src, span_infoplain("Admin tabs will now [(prefs.toggles & SPLIT_ADMIN_TABS) ? "be" : "not be"] split."))
	SSblackbox.record_feedback("nested tally", "admin_toggle", 1, list("Toggle Split Admin Tabs", "[prefs.toggles & SPLIT_ADMIN_TABS ? "Enabled" : "Disabled"]"))

/client/proc/deadchat()
	set name = "Show/Hide Deadchat"
	set category = "Preferences.Admin"
	set desc ="Toggles seeing deadchat"
	prefs.chat_toggles ^= CHAT_DEAD
	prefs.save_preferences()
	to_chat(src, "You will [(prefs.chat_toggles & CHAT_DEAD) ? "now" : "no longer"] see deadchat.")
	SSblackbox.record_feedback("nested tally", "admin_toggle", 1, list("Toggle Deadchat Visibility", "[prefs.chat_toggles & CHAT_DEAD ? "Enabled" : "Disabled"]")) //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!

/client/proc/toggleprayers()
	set name = "Show/Hide Prayers"
	set category = "Preferences.Admin"
	set desc = "Toggles seeing prayers"
	prefs.chat_toggles ^= CHAT_PRAYER
	prefs.save_preferences()
	to_chat(src, "You will [(prefs.chat_toggles & CHAT_PRAYER) ? "now" : "no longer"] see prayerchat.")
	SSblackbox.record_feedback("nested tally", "admin_toggle", 1, list("Toggle Prayer Visibility", "[prefs.chat_toggles & CHAT_PRAYER ? "Enabled" : "Disabled"]")) //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!

/client/proc/RemoteLOOC()
	set name = "Show/Hide Remote LOOC"
	set category = "Preferences.Admin"
	set desc ="Toggles seeing (R)LOOC messages."
	prefs.chat_toggles ^= CHAT_REMOTE_LOOC
	prefs.save_preferences()
	to_chat(src, "You will [(prefs.chat_toggles & CHAT_REMOTE_LOOC) ? "no longer" : "now"] see (R) LOOC messages.")
	SSblackbox.record_feedback("nested tally", "admin_toggle", 1, list("Toggle Remote LOOC Visibility", "[prefs.chat_toggles & CHAT_REMOTE_LOOC ? "Disabled" : "Enabled"]")) //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc! | Haha, funny. no. I refuse to not look like the others.
