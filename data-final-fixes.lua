-----------------------------------------------------------------------------------------------------------------------
-- barreling category
-----------------------------------------------------------------------------------------------------------------------
local original_recipes = {}
for name, _ in pairs(data.raw.recipe) do
	table.insert(original_recipes, name)
end

for name, recipe in pairs(data.raw.recipe) do
	if recipe and string.sub(name, -6) == "barrel" and string.len(name) > 6 then
		if not recipe.additional_categories then
			recipe.additional_categories = {}
		end
		table.insert(recipe.additional_categories, "barreling")
	end
end
if data.raw["recipe"]["titanium-barrel"] ~= nil then
	data.raw["recipe"]["titanium-barrel"].additional_categories = {}
end
if data.raw["recipe"]["cargo-crate-barrel"] ~= nil then
	data.raw["recipe"]["cargo-crate-barrel"].additional_categories = {}
end
if data.raw["recipe"]["cargo-crate-barrel"] ~= nil then
	data.raw["recipe"]["cargo-crate-titanium-barrel"].additional_categories = {}
end
if data.raw["recipe"]["cargo-crate-barrel"] ~= nil then
	data.raw["recipe"]["unpack-cargo-crate-barrel"].additional_categories = {}
end
if data.raw["recipe"]["cargo-crate-barrel"] ~= nil then
	data.raw["recipe"]["unpack-cargo-crate-titanium-barrel"].additional_categories = {}
end
