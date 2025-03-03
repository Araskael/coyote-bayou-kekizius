/obj/machinery/recharger
	name = "recharger"
	icon = 'icons/obj/stationobjs.dmi'
	icon_state = "recharger0"
	desc = "A charging dock for energy based weaponry."
	use_power = IDLE_POWER_USE
	idle_power_usage = 12
	active_power_usage = 750
	circuit = /obj/item/circuitboard/machine/recharger
	pass_flags = PASSTABLE
	var/obj/item/charging = null
	var/recharge_coeff = 1
	var/using_power = FALSE //Did we put power into "charging" last process()?

	var/static/list/allowed_devices = typecacheof(list(
		/obj/item/gun/energy,
		/obj/item/melee/baton,
		/obj/item/ammo_box/magazine/recharge,
		/obj/item/modular_computer,
		/obj/item/ammo_casing/mws_batt,
		/obj/item/ammo_box/magazine/mws_mag,
		/obj/item/electrostaff,
		/obj/item/storage/battery_box,
		/obj/item/gun/ballistic/automatic/magrifle))

/obj/machinery/recharger/RefreshParts()
	for(var/obj/item/stock_parts/capacitor/C in component_parts)
		recharge_coeff = C.rating

/obj/machinery/recharger/examine(mob/user)
	. = ..()
	if(!in_range(user, src) && !issilicon(user) && !isobserver(user))
		. += span_warning("You're too far away to examine [src]'s contents and display!")
		return

	if(charging)
		. += {"<span class='notice'>\The [src] contains:</span>
		<span class='notice'>- \A [charging].</span>"}

	if(!(stat & (NOPOWER|BROKEN)))
		. += span_notice("The status display reads:")
		. += span_notice("- Recharging <b>[recharge_coeff*10]%</b> cell charge per cycle.")
		if(charging)
			var/charge_percent
			var/obj/item/stock_parts/cell/C = charging.get_cell()
			if(C)
				charge_percent = C.percent()
			else
				charge_percent = SEND_SIGNAL(charging, COMSIG_CELL_CHECK_CHARGE_PERCENT)
			. += span_notice("- \The [charging]'s cell is at <b>[charge_percent]%</b>.")

/obj/machinery/recharger/proc/setCharging(new_charging)
	charging = new_charging
	if (new_charging)
		START_PROCESSING(SSmachines, src)
		use_power = ACTIVE_POWER_USE
		using_power = TRUE
		update_icon()
	else
		use_power = IDLE_POWER_USE
		using_power = FALSE
		update_icon()

/obj/machinery/recharger/Exited(atom/movable/M, atom/newloc)
	. = ..()
	if(charging == M)
		setCharging()

/obj/machinery/recharger/attackby(obj/item/G, mob/user, params)
	if(istype(G, /obj/item/wrench))
		if(charging)
			to_chat(user, span_notice("Remove the charging item first!"))
			return
		setAnchored(!anchored)
		power_change()
		to_chat(user, span_notice("You [anchored ? "attached" : "detached"] [src]."))
		G.play_tool_sound(src)
		return

	var/allowed = is_type_in_typecache(G, allowed_devices)

	if(allowed)
		if(anchored)
			if(charging || panel_open)
				return 1

			//Checks to make sure he's not in space doing it, and that the area got proper power.
			var/area/a = get_area(src)
			if(!a || !a.powered(EQUIP))
				to_chat(user, span_notice("[src] blinks red as you try to insert [G]."))
				return 1

			if (istype(G, /obj/item/gun/energy))
				var/obj/item/gun/energy/E = G
				if(!E.can_charge)
					to_chat(user, span_notice("Your gun has no external power connector."))
					return 1

			if(!user.transferItemToLoc(G, src))
				return 1
			setCharging(G)

		else
			to_chat(user, span_notice("[src] isn't connected to anything!"))
		return 1

	if(anchored && !charging)
		if(default_deconstruction_screwdriver(user, "rechargeropen", "recharger0", G))
			return

		if(panel_open && istype(G, /obj/item/crowbar))
			default_deconstruction_crowbar(G)
			return

	return ..()

/obj/machinery/recharger/on_attack_hand(mob/user, act_intent = user.a_intent, unarmed_attack_flags)

	add_fingerprint(user)
	if(charging)
		charging.update_icon()
		user.put_in_hands(charging)

/obj/machinery/recharger/attack_tk(mob/user)
	if(charging)
		charging.update_icon()
		charging.forceMove(drop_location())

/obj/machinery/recharger/process()
	if(stat & (NOPOWER|BROKEN) || !anchored)
		return PROCESS_KILL

	using_power = FALSE
	if(charging)
		using_power = SEND_SIGNAL(charging, COMSIG_ITEM_RECHARGE, recharge_coeff)
		use_power(using_power)
		update_icon()
		var/obj/item/stock_parts/cell/C = charging.get_cell()
		if(C)
			if(C.charge < C.maxcharge)
				C.give(C.maxcharge/10 * recharge_coeff)
				use_power(C.maxcharge/10 * recharge_coeff)
				using_power = TRUE
			update_icon()

		if(istype(charging, /obj/item/ammo_box/magazine/recharge))
			var/obj/item/ammo_box/magazine/recharge/R = charging
			if(R.stored_ammo.len < R.max_ammo)
				R.stored_ammo += new R.ammo_type(R)
				use_power(200 * recharge_coeff)
				using_power = TRUE
			update_icon()
			return

		if(istype(charging, /obj/item/ammo_casing/mws_batt))
			var/obj/item/ammo_casing/mws_batt/R = charging
			if(R.cell.charge < R.cell.maxcharge)
				R.cell.give(R.cell.chargerate * recharge_coeff)
				use_power(250 * recharge_coeff)
				using_power = 1
			if(R.BB == null)
				R.chargeshot()
			update_icon(using_power)

		if(istype(charging, /obj/item/ammo_box/magazine/mws_mag))
			var/obj/item/ammo_box/magazine/mws_mag/R = charging
			for(var/B in R.stored_ammo)
				var/obj/item/ammo_casing/mws_batt/batt = B
				if(batt.cell.charge < batt.cell.maxcharge)
					batt.cell.give(batt.cell.chargerate * recharge_coeff)
					use_power(250 * recharge_coeff)
					using_power = 1
				if(batt.BB == null)
					batt.chargeshot()
			update_icon(using_power)

	else
		return PROCESS_KILL

/obj/machinery/recharger/power_change()
	..()
	update_icon()

/obj/machinery/recharger/emp_act(severity)
	. = ..()
	if (. & EMP_PROTECT_CONTENTS)
		return
	if(!(stat & (NOPOWER|BROKEN)) && anchored)
		if(istype(charging,  /obj/item/gun/energy))
			var/obj/item/gun/energy/E = charging
			if(E.cell)
				E.cell.emp_act(severity)

		else if(istype(charging, /obj/item/melee/baton))
			var/obj/item/melee/baton/B = charging
			if(B.cell)
				B.cell.charge = 0


/obj/machinery/recharger/update_icon_state()
	if(stat & (NOPOWER|BROKEN) || !anchored)
		icon_state = "rechargeroff"
	else if(panel_open)
		icon_state = "rechargeropen"
	else if(charging)
		if(using_power)
			icon_state = "recharger1"
		else
			icon_state = "recharger2"
	else
		icon_state = "recharger0"
