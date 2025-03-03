/mob/living/simple_animal/hostile/trog
	name = "trog"
	desc = "A human who has mutated and regressed back to a primal, cannibalistic state. Rumor says they're poisonous as well. Want to find out? "
	icon = 'icons/fallout/mobs/monsters/tunnelers.dmi'
	icon_state = "troglodyte"
	icon_living = "troglodyte"
	icon_dead = "trog_dead"

	speed = 2
	maxHealth = 40
	health = 40
	obj_damage = 30
	melee_damage_lower = 5
	melee_damage_upper = 15
	harm_intent_damage = 5
	waddle_amount = 2
	waddle_up_time = 1
	waddle_side_time = 1
	mob_biotypes = MOB_ORGANIC|MOB_HUMANOID
	robust_searching = TRUE
	turns_per_move = 5
	speak_emote = list("growls")
	emote_see = list("screeches")
	a_intent = INTENT_HARM
	attack_verb_simple = "lunges at"
	attack_sound = 'sound/hallucinations/growl1.ogg'
	atmos_requirements = list("min_oxy" = 5, "max_oxy" = 0, "min_tox" = 0, "max_tox" = 1, "min_co2" = 0, "max_co2" = 5, "min_n2" = 0, "max_n2" = 0)
	unsuitable_atmos_damage = 20
	stat_attack = CONSCIOUS
	gold_core_spawnable = HOSTILE_SPAWN
	faction = list("trog")
	guaranteed_butcher_results = list(/obj/item/reagent_containers/food/snacks/meat/slab/human = 2,
							/obj/item/stack/sheet/animalhide/human = 1,
							/obj/item/stack/sheet/bone = 1)

/mob/living/simple_animal/hostile/trog/sporecarrier
	name = "spore carrier"
	desc = "A victim of the beauveria mordicana fungus, these corpses sole purpose is to spread its spores."
	icon_state = "spore_carrier"
	icon_living = "spore_carrier"
	icon_dead = "spore_dead"
	health = 80
	maxHealth = 80
	harm_intent_damage = 5
	melee_damage_lower = 10
	melee_damage_upper = 25
	attack_sound = 'sound/hallucinations/growl1.ogg'
	atmos_requirements = list("min_oxy" = 0, "max_oxy" = 0, "min_tox" = 0, "max_tox" = 0, "min_co2" = 0, "max_co2" = 0, "min_n2" = 0, "max_n2" = 0)
	unsuitable_atmos_damage = 0
	faction = list("plants")
	guaranteed_butcher_results = list(/obj/item/stack/sheet/bone = 1)

/mob/living/simple_animal/hostile/trog/tunneler
	name = "tunneler"
	desc = "A mutated creature that is sensitive to light, but can swarm and kill even Deathclaws."
	icon_state = "tunneler"
	icon_living = "tunneler"
	icon_dead = "tunneler_dead"
	robust_searching = TRUE
	stat_attack = CONSCIOUS
	health = 144
	maxHealth = 144
	speed = 1
	melee_damage_lower = 18
	melee_damage_upper = 32
	obj_damage = 150
	see_in_dark = 8
	attack_sound = 'sound/weapons/bladeslice.ogg'
	atmos_requirements = list("min_oxy" = 5, "max_oxy" = 0, "min_tox" = 0, "max_tox" = 1, "min_co2" = 0, "max_co2" = 5, "min_n2" = 0, "max_n2" = 0)
	damage_coeff = list(BRUTE = 1, BURN = 1, TOX = -1, CLONE = 0, STAMINA = 0, OXY = 0)
	unsuitable_atmos_damage = 5
	faction = list("tunneler")
	guaranteed_butcher_results = list(/obj/item/stack/sheet/bone = 1)
	death_sound = 'sound/f13npc/ghoul/ghoul_death.ogg'

/mob/living/simple_animal/hostile/trog/tunneler/Aggro()
	..()
	summon_backup(15)

/mob/living/simple_animal/hostile/trog/tunneler/AttackingTarget()
	. = ..()
	var/atom/my_target = get_target()
	if(!. || !ishuman(my_target))
		return
	var/mob/living/carbon/human/H = my_target
	H.reagents.add_reagent(/datum/reagent/toxin, 5)


/mob/living/simple_animal/hostile/trog/tunneler/blindone
	name = "Blind One"
	desc = "A...tunneler? Her scales reflect the light oddly, almost making her transparent, but her eyes are solid. She moves blindingly quickly, darting in and out of view despite her size. Overfilled, swelling venom-sacs line her throat."
	icon = 'icons/fallout/mobs/monsters/tunnelers.dmi'
	icon_state = "blindone"
	icon_living = "blindone"
	icon_dead = "trog_dead"
	mob_armor = ARMOR_VALUE_DEATHCLAW_MOTHER
	gender = FEMALE
	resize = 1.3
	alpha = 150
	speed = 1
	maxHealth = 150
	health = 150
	has_field_of_vision = FALSE
	obj_damage = 30
	melee_damage_lower = 18
	melee_damage_upper = 40
	vision_range = 9
	aggro_vision_range = 18
	retreat_distance = 6
	turns_per_move = 5
	speak_emote = list("mumbles incoherently")
	emote_see = list("screeches")
	a_intent = INTENT_HARM
	attack_verb_simple = "lunges at"
	attack_sound = 'sound/hallucinations/veryfar_noise.ogg'
	atmos_requirements = list("min_oxy" = 5, "max_oxy" = 0, "min_tox" = 0, "max_tox" = 1, "min_co2" = 0, "max_co2" = 5, "min_n2" = 0, "max_n2" = 0)
	unsuitable_atmos_damage = 20
	stat_attack = CONSCIOUS
	gold_core_spawnable = HOSTILE_SPAWN
	faction = list("tunneler")
	guaranteed_butcher_results = list(/obj/item/reagent_containers/food/snacks/meat/slab/human = 2,
							/obj/item/stack/sheet/animalhide/human = 1,
							/obj/item/stack/sheet/bone = 1)

/mob/living/simple_animal/hostile/trog/tunneler/blindone/Aggro()
	..()
	summon_backup(15)

/mob/living/simple_animal/hostile/trog/tunneler/blindone/AttackingTarget()
	. = ..()
	var/atom/my_target = get_target()
	if(!. || !ishuman(my_target))
		return
	var/mob/living/carbon/human/H = my_target
	H.reagents.add_reagent(/datum/reagent/toxin, 3)
	H.reagents.add_reagent(/datum/reagent/toxin/venom, 5)
	H.reagents.add_reagent(/datum/reagent/toxin/mindbreaker, 3)

