/obj/structure/railing
	name = "railing"
	desc = "Basic railing meant to protect idiots like you from falling."
	icon = 'icons/fallout/structures/fences.dmi'
	icon_state = "railing"
	flags_1 = ON_BORDER_1
	density = TRUE
	anchored = TRUE
	pass_flags_self = LETPASSTHROW
	/// armor more or less consistent with grille. max_integrity about one time and a half that of a grille.
	armor = ARMOR_VALUE_MEDIUM

	max_integrity = 75

	climbable = TRUE
	///Initial direction of the railing.
	var/ini_dir

/obj/structure/railing/corner //aesthetic corner sharp edges hurt oof ouch
	icon_state = "railing_corner"
	density = FALSE
	climbable = FALSE

/obj/structure/railing/Initialize(mapload)
	. = ..()
	ini_dir = dir

	if(density && flags_1 & ON_BORDER_1) // blocks normal movement from and to the direction it's facing.
		var/static/list/loc_connections = list(
			COMSIG_ATOM_EXIT = .proc/on_exit,
		)
		AddElement(/datum/element/connect_loc, loc_connections)

	AddComponent(/datum/component/simple_rotation)

/obj/structure/railing/attackby(obj/item/I, mob/living/user, params)
	..()
	add_fingerprint(user)

	if(I.tool_behaviour == TOOL_WELDER)
		if(obj_integrity < max_integrity)
			if(!I.tool_start_check(user, amount=0))
				return

			to_chat(user, span_notice("You begin repairing [src]..."))
			if(I.use_tool(src, user, 40, volume=50))
				obj_integrity = max_integrity
				to_chat(user, span_notice("You repair [src]."))
		else
			to_chat(user, span_warning("[src] is already in good condition!"))
		return

/obj/structure/railing/AltClick(mob/user)
	return ..() // This hotkey is BLACKLISTED since it's used by /datum/component/simple_rotation

/obj/structure/railing/wirecutter_act(mob/living/user, obj/item/I)
	. = ..()
	if(!anchored)
		to_chat(user, span_warning("You cut apart the railing."))
		I.play_tool_sound(src, 100)
		deconstruct()
		return TRUE

/obj/structure/railing/deconstruct(disassembled)
	if(!(flags_1 & NODECONSTRUCT_1))
		var/obj/item/stack/rods/rod = new /obj/item/stack/rods(drop_location(), 3)
		transfer_fingerprints_to(rod)
	return ..()

///Implements behaviour that makes it possible to unanchor the railing.
/obj/structure/railing/wrench_act(mob/living/user, obj/item/I)
	. = ..()
	if(flags_1&NODECONSTRUCT_1)
		return
	to_chat(user, span_notice("You begin to [anchored ? "unfasten the railing from":"fasten the railing to"] the floor..."))
	if(I.use_tool(src, user, volume = 75, extra_checks = CALLBACK(src, .proc/check_anchored, anchored)))
		set_anchored(!anchored)
		to_chat(user, span_notice("You [anchored ? "fasten the railing to":"unfasten the railing from"] the floor."))
	return TRUE

/obj/structure/railing/CanPass(atom/movable/mover, border_dir)
	. = ..()
	if(border_dir & dir)
		return . || mover.throwing || mover.movement_type & (FLYING | FLOATING)
	return TRUE

/obj/structure/railing/do_climb(atom/movable/A)
	if(loc != A.loc)
		return ..()
	if(climbable)
		density = FALSE
		. = step(A,dir)
		density = TRUE


/obj/structure/railing/CanAStarPass(obj/item/card/id/ID, to_dir, atom/movable/caller, no_id = FALSE)
	if(!(to_dir & dir))
		return TRUE
	return ..()

/obj/structure/railing/proc/on_exit(datum/source, atom/movable/leaving, direction)
	SIGNAL_HANDLER

	if(leaving == src)
		return // Let's not block ourselves.

	if(!(direction & dir))
		return

	if (!density)
		return

	if (leaving.throwing)
		return

	if (leaving.movement_type & (FLYING | FLOATING))
		return

	if (leaving.move_force >= MOVE_FORCE_EXTREMELY_STRONG)
		return

	leaving.Bump(src)
	return COMPONENT_ATOM_BLOCK_EXIT

/obj/structure/railing/proc/check_anchored(checked_anchored)
	if(anchored == checked_anchored)
		return TRUE

/////////////
// RAILING //
/////////////

//Wooden fence
/obj/structure/railing/wood
	name = "wooden fence"
	desc = "Marks property and prevents accidents."
	icon = 'icons/fallout/structures/fences.dmi'
	icon_state = "straight_wood"
	layer = WALL_OBJ_LAYER

/obj/structure/railing/wood/underlayer
	layer = BELOW_MOB_LAYER

/obj/structure/railing/wood/post 
	icon_state = "post_wood"
	density = FALSE

/obj/structure/railing/wood/post/underlayer
	layer = BELOW_MOB_LAYER

/obj/structure/simple_door/metal/fence/wooden
	name = "wood fence gate"
	desc = "A wooden gate for a wood fence."
	icon_state = "fence_wood"
	door_type = "fence_wood"
	open_sound = "sound/machines/door_open.ogg"
	close_sound = "sound/machines/door_close.ogg"
	opacity = FALSE
	base_opacity = FALSE
	can_have_lock = TRUE


//Yellow rail
/obj/structure/railing/handrail
	name = "handrail"
	desc = "A waist high handrail, perhaps you could climb over it."
	icon_state = "handrail_y"
	layer = WALL_OBJ_LAYER

/obj/structure/railing/handrail/underlayer
	layer = BELOW_MOB_LAYER

/obj/structure/railing/handrail/end
	icon_state = "handrail_y_end"
	density = FALSE

/obj/structure/railing/handrail/end/underlayer
	layer = BELOW_MOB_LAYER

/obj/structure/railing/handrail/intersect
	icon_state = "handrail_y_intersect"

//Rusty rail
/obj/structure/railing/handrail/rusty
	name = "handrail"
	desc = "Old, rusted metal handrails. The green paint is chipping off in spots."
	icon_state = "handrail_g"

/obj/structure/railing/handrail/rusty/underlayer
	layer = BELOW_MOB_LAYER

/obj/structure/railing/handrail/rusty/end
	icon_state = "handrail_g_end"
	density = FALSE

/obj/structure/railing/handrail/rusty/end/underlayer
	layer = BELOW_MOB_LAYER

//Blue rail
/obj/structure/railing/handrail/blue
	name = "handrail"
	desc = "Old, rusted metal handrails. The green paint is chipping off in spots."
	icon_state = "handrail_b"

/obj/structure/railing/handrail/blue/underlayer
	layer = BELOW_MOB_LAYER

/obj/structure/railing/handrail/blue/end
	icon_state = "handrail_b_end"

/obj/structure/railing/handrail/blue/end/underlayer
	layer = BELOW_MOB_LAYER

/obj/structure/railing/handrail/blue/intersect
	icon_state = "handrail_b_intersect"


///////////
// POLES //
/////////// For tents and such

/obj/structure/railing/tent_pole
	icon_state = "pole_tent"
	density = FALSE

/obj/structure/railing/tent_pole/top
	icon_state = "pole_tent_top"

/obj/structure/railing/dancing_pole
	icon_state = "pole_b"
	layer = BELOW_MOB_LAYER

/obj/structure/railing/dancing_pole/top
	icon_state = "pole_t"
