-- main `S` code in init.lua
local S
S = farming.S

minetest.register_node("farming_cannabis:cannabis_sapling", {
	description = S("Cannabis Tree Sapling"),
	drawtype = "plantlike",
	tiles = {"farming_cannabis_sapling.png"},
	inventory_image = "farming_cannabis_sapling.png",
	wield_image = "farming_cannabis_sapling.png",
	paramtype = "light",
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-0.3, -0.5, -0.3, 0.3, 0.35, 0.3}
	},
	groups = {dig_immediate=3,flammable=2},
	sounds = default.node_sound_defaults(),
})

minetest.register_node("farming_cannabis:cannabis_leaves", {
	drawtype = "allfaces_optional",
	tiles = {"farming_cannabis_leaves.png"},
	paramtype = "light",
	groups = {snappy=3, leafdecay=3, flammable=2, not_in_creative_inventory=1},
 	drop = {
		max_items = 1,
		items = {
			{
				items = {'farming_cannabis:cannabis_sapling'},
				rarity = 20,
			},
		}
	},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_abm({
	nodenames = {"farming_cannabis:cannabis_sapling"},
	interval = 60,
	chance = 20,
	action = function(pos, node)
		farming.generate_tree(pos, "default:tree", "farming_cannabis:cannabis_leaves", {"default:sand", "default:desert_sand"}, {["farming_cannabis:cannabis"]=20})
	end
})

minetest.register_on_generated(function(minp, maxp, blockseed)
	if math.random(1, 100) > 5 then
		return
	end
	local tmp = {x=(maxp.x-minp.x)/2+minp.x, y=(maxp.y-minp.y)/2+minp.y, z=(maxp.z-minp.z)/2+minp.z}
	local pos = minetest.find_node_near(tmp, maxp.x-minp.x, {"default:desert_sand"})
	if pos ~= nil then
		farming.generate_tree({x=pos.x, y=pos.y+1, z=pos.z}, "default:tree", "farming_cannabis:cannabis_leaves", {"default:sand", "default:desert_sand"}, {["farming_cannabis:cannabis"]=20})
	end
end)

minetest.register_node("farming_cannabis:cannabis", {
	description = S("Cannabis"),
	tiles = {"farming_cannabis.png"},
	visual_scale = 0.5,
	inventory_image = "farming_cannabis.png",
	wield_image = "farming_cannabis.png",
	drawtype = "torchlike",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	groups = {fleshy=3,dig_immediate=3,flammable=2,leafdecay=3,leafdecay_drop=1},
	sounds = default.node_sound_defaults(),
})

minetest.register_craftitem("farming_cannabis:cannabis_bud", {
	description = "Cannabis Bud",
	inventory_image = "farming_cannabis_bud.png",
})

minetest.register_craft({
	output = "farming_cannabis:cannabis_bud 4",
	type = "shapeless",
	recipe = {"farming_cannabis:cannabis"},
})
minetest.register_craftitem("farming_cannabis:cannabis_doobie", {
description = "Cannabis Doobie :D",
image = "farming_cannabis_doobie.png",
on_place = minetest.item_place,
on_use = minetest.item_eat(1)
})
minetest.register_craft({
output = 'farming_cannabis:cannabis_doobie',
recipe = {
{'default:paper'},
{'farming_cannabis:cannabis_bud'},
}
})