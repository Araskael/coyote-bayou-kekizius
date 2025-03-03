/obj/item/ammo_box/magazine/internal/boltaction
	name = "bolt action rifle internal magazine"
	desc = "Oh god, this shouldn't be here"
	ammo_type = /obj/item/ammo_casing/a308
	caliber = list(CALIBER_308)
	max_ammo = 5
	multiload = 1

/obj/item/ammo_box/magazine/internal/boltaction/twentytwo
	ammo_type = /obj/item/ammo_casing/a22
	caliber = list(CALIBER_22LR)

/obj/item/ammo_box/magazine/internal/boltaction/enchanted
	max_ammo = 1
//	ammo_type = /obj/item/ammo_casing/a762/enchanted

/obj/item/ammo_box/magazine/internal/boltaction/enchanted/arcane_barrage
	ammo_type = /obj/item/ammo_casing/magic/arcane_barrage

//Fallout 13

/obj/item/ammo_box/magazine/internal/boltaction/enfield
	max_ammo = 10
	multiload = 1
	
/obj/item/ammo_box/magazine/internal/boltaction/hunting
	ammo_type = /obj/item/ammo_casing/a3006
	caliber = list(CALIBER_3006)
	max_ammo = 5
	multiload = 1
	
/obj/item/ammo_box/magazine/internal/boltaction/hunting/paciencia
	max_ammo = 2 //with 1 in the tube = 3 shots

/obj/item/ammo_box/magazine/internal/boltaction/antimateriel
	ammo_type = /obj/item/ammo_casing/a50MG
	caliber = list(CALIBER_50MG)
	max_ammo = 4
	multiload = 0 //one bullet at a time

/obj/item/ammo_box/magazine/internal/salvaged_eastern_rifle
	name = "salvaged eastern rifle internal magazine"
	desc = "Oh god, this shouldn't be here"
	ammo_type = /obj/item/ammo_casing/m5mm
	caliber = list(CALIBER_556, CALIBER_5MM)
	max_ammo = 25
	multiload = FALSE // one at a time~

/obj/item/ammo_box/magazine/internal/mauserinternal
	name = "C96 Mauser internal magazine"
	desc = "Pew pew pew pew!"
	ammo_type = /obj/item/ammo_casing/c9mm
	caliber = list(CALIBER_9MM)
	max_ammo = 10
	multiload = FALSE
