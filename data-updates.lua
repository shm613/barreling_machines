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

			pipe_picture = barreling_machine_pipes(),
			pipe_covers = pipecoverspictures(),
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
	table.insert(
		data.raw["technology"]["diesel-automation"].effects,
		{ type = "unlock-recipe", recipe = "diesel-barreling-machine" }
	)
end

if mods["nuclear_science_pack"] and false then
	-------------------------------------------------------------------------------
	-- nuclear barreling machine
	-------------------------------------------------------------------------------
	local nuclear_barreling_machine = table.deepcopy(data.raw["assembling-machine"]["electric-barreling-machine"])
	local nuclear_barreling_machine_item = table.deepcopy(data.raw["item"]["electric-barreling-machine"])
	nuclear_barreling_machine.icon = "__barreling_machines__/graphics/nuclear-barreling-machine-icon.png"
	nuclear_barreling_machine.name = "nuclear-barreling-machine"
	nuclear_barreling_machine.minable = { mining_time = 0.1, result = "nuclear-barreling-machine" }
	nuclear_barreling_machine.crafting_speed = 8
	nuclear_barreling_machine.graphics_set = {
		animation = {
			layers = {

				{
					filename = "__barreling_machines__/graphics/nuclear-barreling-machine.png",
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
				{
					filename = "__barreling_machines__/graphics/nuclear-barreling-machine.png",
					priority = "extra-high",
					width = 66,
					height = 74,
					frame_count = 7,
					shift = util.by_pixel(0, -2),
					scale = 0.5,
					frame_sequence = { 1, 2, 3, 4, 5, 6, 7 },
					draw_as_light = true,
				},
			},
		},
	}
	nuclear_barreling_machine_item.icon = "__barreling_machines__/graphics/nuclear-barreling-machine-icon.png"
	nuclear_barreling_machine_item.name = "nuclear-barreling-machine"
	nuclear_barreling_machine_item.place_result = "nuclear-barreling-machine"
	nuclear_barreling_machine_item.order = "z-a[barreling-machine-c]"
	nuclear_barreling_machine.energy_source = {
		type = "burner",
		fuel_categories = { "nuclear" },
		effectivity = 1,
		fuel_inventory_size = 1,
		burnt_inventory_size = 1,
		light_flicker = {
			color = { 0, 0, 0 },
			minimum_intensity = 0.7,
			maximum_intensity = 0.95,
		},
		emissions_per_minute = { pollution = 1 }, --12 is burner drill ,10 is electric drill
	}
	nuclear_barreling_machine.energy_usage = "200kW"
	data.extend({ nuclear_barreling_machine })
	data.extend({ nuclear_barreling_machine_item })
	data:extend({
		{
			type = "recipe",
			name = "nuclear-barreling-machine",
			enabled = false,
			ingredients = {
				{ type = "item", name = "iron-plate", amount = 10 },
				{ type = "item", name = "iron-gear-wheel", amount = 5 },
				{ type = "item", name = "engine-unit", amount = 1 },
			},
			results = { { type = "item", name = "nuclear-barreling-machine", amount = 1 } },
		},
	})
	if data.raw["technology"]["nuclear-automation"] ~= nil then
		table.insert(
			data.raw["technology"]["nuclear-automation"].effects,
			{ type = "unlock-recipe", recipe = "nuclear-barreling-machine" }
		)
	end
end
