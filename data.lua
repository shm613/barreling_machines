local item_sounds = require("__base__.prototypes.item_sounds")
local hit_effects = require("__base__.prototypes.entity.hit-effects")
local sounds = require("__base__.prototypes.entity.sounds")

function barreling_machine_pipes()
	return {
		north = {
			filename = "__barreling_machines__/graphics/barreling-machine/barreling-machine-pipe-N.png",
			priority = "extra-high",
			width = 71,
			height = 38,
			shift = util.by_pixel(2.25, 13.5),
			scale = 0.5,
		},
		east = {
			filename = "__barreling_machines__/graphics/barreling-machine/barreling-machine-pipe-E.png",
			priority = "extra-high",
			width = 42,
			height = 76,
			shift = util.by_pixel(-24.5, 1),
			scale = 0.5,
		},
		south = {
			filename = "__barreling_machines__/graphics/barreling-machine/barreling-machine-pipe-S.png",
			priority = "extra-high",
			width = 88,
			height = 61,
			shift = util.by_pixel(0, -31.25),
			scale = 0.5,
		},
		west = {
			filename = "__barreling_machines__/graphics/barreling-machine/barreling-machine-pipe-W.png",
			priority = "extra-high",
			width = 39,
			height = 73,
			shift = util.by_pixel(25.75, 1.25),
			scale = 0.5,
		},
	}
end
data:extend({
	{
		name = "barreling",
		type = "recipe-category",
	},
})
data:extend({
	{
		type = "item",
		name = "electric-barreling-machine",
		icon = "__barreling_machines__/graphics/electric-barreling-machine-icon.png",
		subgroup = "production-machine",
		group = "production",
		order = "z-a[barreling-machine-b]",
		inventory_move_sound = item_sounds.metal_chest_inventory_move,
		pick_sound = item_sounds.metal_chest_inventory_pickup,
		drop_sound = item_sounds.metal_chest_inventory_move,
		place_result = "electric-barreling-machine",
		stack_size = 50,
		weight = 20 * kg,
	},
	{
		type = "assembling-machine",
		name = "electric-barreling-machine",
		icon = "__barreling_machines__/graphics/electric-barreling-machine-icon.png",
		flags = { "placeable-neutral", "placeable-player", "player-creation" },
		minable = { mining_time = 0.1, result = "electric-barreling-machine" },
		fast_replaceable_group = "barreling-machine",
		circuit_wire_max_distance = furnace_circuit_wire_max_distance,
		circuit_connector = circuit_connector_definitions["electric-furnace"],
		max_health = 200,
		corpse = "iron-chest-remnants",
		dying_explosion = "iron-chest-explosion",
		resistances = {
			{
				type = "fire",
				percent = 90,
			},
			{
				type = "impact",
				percent = 60,
			},
		},

		selection_box = { { -0.5, -0.5 }, { 0.5, 0.5 } },
		collision_box = { { -0.3, -0.3 }, { 0.3, 0.3 } },
		damaged_trigger_effect = hit_effects.entity(),
		--module_slots = 2,
		icon_draw_specification = { shift = { 0, -0.1 }, scale = 0.0 },
		allowed_effects = { "consumption", "speed", "pollution", "quality" },
		crafting_categories = { "barreling" },
		crafting_speed = 2,
		energy_usage = "20kW",
		source_inventory_size = 1,
		energy_source = {
			type = "electric",
			usage_priority = "secondary-input",
			emissions_per_minute = { pollution = 1 },
		},
		impact_category = "metal",
		open_sound = sounds.metallic_chest_open,
		close_sound = sounds.metallic_chest_close,
		animation_sound = sounds.logistics_chest_open,
		match_animation_speed_to_activity = false,
		opened_duration = 7, --logistic_chest_opened_duration ==7
		working_sound = {
			sound = {
				filename = "__base__/sound/electric-furnace.ogg",
				volume = 0.85,
				modifiers = volume_multiplier("main-menu", 4.2),
				advanced_volume_control = { attenuation = "exponential" },
				audible_distance_modifier = 0.7,
			},
			max_sounds_per_prototype = 4,
			fade_in_ticks = 4,
			fade_out_ticks = 20,
		},
		graphics_set = {
			animation = {
				layers = {

					{
						filename = "__barreling_machines__/graphics/electric-barreling-machine.png",
						priority = "extra-high",
						width = 66,
						height = 74,
						frame_count = 7,
						shift = util.by_pixel(0, -2),
						scale = 0.5,
						frame_sequence = { 1, 2, 3, 4, 5, 6, 7 },
					},
					{
						filename = "__base__/graphics/entity/logistic-chest/logistic-chest-shadow.png",
						priority = "extra-high",
						width = 112,
						height = 46,
						repeat_count = 7,
						shift = util.by_pixel(12, 4.5),
						draw_as_shadow = true,
						scale = 0.5,
					},
				},
			},
		},
		fluid_boxes_off_when_no_fluid_recipe = false,
		fluid_boxes = {
			{
				production_type = "input",
				pipe_picture = barreling_machine_pipes(),
				pipe_covers = pipecoverspictures(),
				volume = 100,
				pipe_connections = {
					{ flow_direction = "input", direction = defines.direction.north, position = { 0, 0 } },
				},
				secondary_draw_orders = { north = -1 },
				--hide_connection_info = true,
			},
			{
				production_type = "output",
				pipe_picture = barreling_machine_pipes(),
				pipe_covers = pipecoverspictures(),
				volume = 100,
				pipe_connections = {
					{ flow_direction = "output", direction = defines.direction.south, position = { 0, 0 } },
				},
				secondary_draw_orders = { north = -1 },
				--hide_connection_info = true,
			},
		},
	},
})

-------------------------------------------------------------------------------
-- burner barreling machine
-------------------------------------------------------------------------------
local burner_barreling_machine = table.deepcopy(data.raw["assembling-machine"]["electric-barreling-machine"])
local burner_barreling_machine_item = table.deepcopy(data.raw["item"]["electric-barreling-machine"])
burner_barreling_machine.icon = "__barreling_machines__/graphics/burner-barreling-machine-icon.png"
burner_barreling_machine.name = "burner-barreling-machine"
burner_barreling_machine.minable = { mining_time = 0.1, result = "burner-barreling-machine" }
burner_barreling_machine.crafting_speed = 1
burner_barreling_machine.graphics_set = {
	animation = {
		layers = {

			{
				filename = "__barreling_machines__/graphics/burner-barreling-machine.png",
				priority = "extra-high",
				width = 66,
				height = 74,
				frame_count = 7,
				shift = util.by_pixel(0, -2),
				scale = 0.5,
				frame_sequence = { 1, 2, 3, 4, 5, 6, 7 },
			},
			{
				filename = "__base__/graphics/entity/logistic-chest/logistic-chest-shadow.png",
				priority = "extra-high",
				width = 112,
				height = 46,
				repeat_count = 7,
				shift = util.by_pixel(12, 4.5),
				draw_as_shadow = true,
				scale = 0.5,
			},
		},
	},
}
burner_barreling_machine_item.icon = "__barreling_machines__/graphics/burner-barreling-machine-icon.png"
burner_barreling_machine_item.name = "burner-barreling-machine"
burner_barreling_machine_item.place_result = "burner-barreling-machine"
burner_barreling_machine_item.order = "z-a[barreling-machine-a]"
burner_barreling_machine.energy_source = {
	fuel_inventory_size = 1,
	type = "burner",
	usage_priority = "secondary-input",
	emissions_per_minute = { pollution = 3 },
}

data.extend({ burner_barreling_machine })
data.extend({ burner_barreling_machine_item })

data:extend({
	{
		type = "recipe",
		name = "electric-barreling-machine",
		enabled = false,
		ingredients = {
			{ type = "item", name = "iron-plate", amount = 10 },
			{ type = "item", name = "iron-gear-wheel", amount = 5 },
			{ type = "item", name = "electronic-circuit", amount = 3 },
		},
		results = { { type = "item", name = "electric-barreling-machine", amount = 1 } },
	},
})

data:extend({
	{
		type = "recipe",
		name = "burner-barreling-machine",
		enabled = false,
		ingredients = {
			{ type = "item", name = "iron-plate", amount = 10 },
			{ type = "item", name = "iron-gear-wheel", amount = 5 },
		},
		results = { { type = "item", name = "burner-barreling-machine", amount = 1 } },
	},
})

if mods["diesel_machines"] then
	-------------------------------------------------------------------------------
	-- diesel barreling machine
	-------------------------------------------------------------------------------
	local diesel_barreling_machine = table.deepcopy(data.raw["assembling-machine"]["electric-barreling-machine"])
	local diesel_barreling_machine_item = table.deepcopy(data.raw["item"]["electric-barreling-machine"])
	diesel_barreling_machine.icon = "__barreling_machines__/graphics/diesel-barreling-machine-icon.png"
	diesel_barreling_machine.name = "diesel-barreling-machine"
	diesel_barreling_machine.minable = { mining_time = 0.1, result = "diesel-barreling-machine" }
	diesel_barreling_machine.crafting_speed = 4
	diesel_barreling_machine.graphics_set = {
		animation = {
			layers = {

				{
					filename = "__barreling_machines__/graphics/diesel-barreling-machine.png",
					priority = "extra-high",
					width = 66,
					height = 74,
					frame_count = 7,
					shift = util.by_pixel(0, -2),
					scale = 0.5,
					frame_sequence = { 1, 2, 3, 4, 5, 6, 7 },
				},
				{
					filename = "__base__/graphics/entity/logistic-chest/logistic-chest-shadow.png",
					priority = "extra-high",
					width = 112,
					height = 46,
					repeat_count = 7,
					shift = util.by_pixel(12, 4.5),
					draw_as_shadow = true,
					scale = 0.5,
				},
			},
		},
	}
	diesel_barreling_machine_item.icon = "__barreling_machines__/graphics/diesel-barreling-machine-icon.png"
	diesel_barreling_machine_item.name = "diesel-barreling-machine"
	diesel_barreling_machine_item.place_result = "diesel-barreling-machine"
	diesel_barreling_machine_item.order = "z-a[barreling-machine-c]"
	diesel_barreling_machine.energy_source = {
		type = "fluid",
		burns_fluid = true, -- fluid used as power
		scale_fluid_usage = true,
		fluid_box = {

			pipe_covers = pipecoverspictures(),
			--pipe_picture = assemblerpipepictures(),
			always_draw_covers = true,
			volume = 10,
			pipe_connections = {
				{ direction = defines.direction.west, position = { 0, 0 } },
				{ direction = defines.direction.east, position = { 0, 0 } },
			},
			production_type = "input-output",
		},

		smoke = {
			{
				-- not enough ?
				name = "smoke",
				frequency = 5,
				position = { 0, 0 },
				starting_vertical_speed = 0.1, --base 0.08
				starting_frame_deviation = 60,
			},
		},
		emissions_per_minute = { pollution = 1 }, --12 is burner drill
	}
	data.extend({ diesel_barreling_machine })
	data.extend({ diesel_barreling_machine_item })
	data:extend({
		{
			type = "recipe",
			name = "diesel-barreling-machine",
			enabled = false,
			ingredients = {
				{ type = "item", name = "iron-plate", amount = 10 },
				{ type = "item", name = "iron-gear-wheel", amount = 5 },
				{ type = "item", name = "engine-unit", amount = 1 },
			},
			results = { { type = "item", name = "diesel-barreling-machine", amount = 1 } },
		},
	})
end
if data.raw["technology"]["fluid-handling"] then
	table.insert(
		data.raw["technology"]["fluid-handling"].effects,
		{ type = "unlock-recipe", recipe = "burner-barreling-machine" }
	)
end

if data.raw["technology"]["chemical-science-pack"] then
	table.insert(
		data.raw["technology"]["chemical-science-pack"].effects,
		{ type = "unlock-recipe", recipe = "electric-barreling-machine" }
	)
end
