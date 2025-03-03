/mob/living/simple_animal/hostile/faithless
	name = "The Faithless"
	desc = "The Wish Granter's faith in humanity, incarnate."
	icon_state = "faithless"
	icon_living = "faithless"
	icon_dead = "faithless_dead"
	mob_biotypes = MOB_ORGANIC|MOB_HUMANOID
	gender = MALE
	speak_chance = 0
	turns_per_move = 5
	response_help_continuous = "passes through"
	response_help_simple = "pass through"
	response_disarm_continuous = "shoves"
	response_disarm_simple = "shove"
	response_harm_continuous = "hits"
	response_harm_simple = "hit"
	emote_taunt = list("wails")
	taunt_chance = 25
	speed = 0
	maxHealth = 80
	health = 80
	spacewalk = TRUE
	stat_attack = CONSCIOUS
	robust_searching = 1
	blood_volume = 0

	harm_intent_damage = 8
	obj_damage = 50
	melee_damage_lower = 15
	melee_damage_upper = 15
	attack_verb_continuous = "grips"
	attack_verb_simple = "grip"
	attack_sound = 'sound/hallucinations/growl1.ogg'
	speak_emote = list("growls")

	atmos_requirements = list("min_oxy" = 0, "max_oxy" = 0, "min_tox" = 0, "max_tox" = 0, "min_co2" = 0, "max_co2" = 0, "min_n2" = 0, "max_n2" = 0)
	minbodytemp = 0

	faction = list("faithless")
	gold_core_spawnable = HOSTILE_SPAWN

	footstep_type = FOOTSTEP_MOB_SHOE

/mob/living/simple_animal/hostile/faithless/AttackingTarget()
	. = ..()
	var/atom/my_target = get_target()
	if(!. || !prob(14) || !ishuman(my_target))
		return
	var/mob/living/carbon/human/C = my_target
	C.DefaultCombatKnockdown(60)
	C.visible_message(span_danger("\The [src] knocks down \the [C]!"), \
			span_userdanger("\The [src] knocks you down!"))
