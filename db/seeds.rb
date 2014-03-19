# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

ItemType.destroy_all
Item.destroy_all

types = ["PC Hardware", "Clothes", "Furniture", "Food"]
types.each {|type| ItemType.create(name: type)}

items = Hash.new

items["PC Hardware"] = ["keyboard", "mouse", "LCD", "cooler", "graphic card", "cpu", "mainboard", "RAM", "hard disk", "blu-ray drive"]
items["Clothes"] = %w{shirt pants socks jacket coat gloves hat shoes jeans pullover hoody}
items["Furniture"] = %w{table desk chair bed bookshelf cupboard closet safe bedstand couch sofa}
items["Food"] = %w{beef pork chicken bacon ham lamb liver kidneys turkey duck sausages salami apple orange banana pear peach lemon
	lime plum melon grape mango kiwi apricot pineapple blackberry blackcurrant redcurrant blueberry strawberry raspberry gooseberry
	rhubarb cod haddock plaice tuna salmon trout mackerel herring sardine pilchard sole anchovy toast jam marmalade breakfast cereal
	cornflakes muesli porridge}

title_prefixes = %w{magic super mega ultra bold big tiny}

positive_adjectives = %w{amazing awesome blithesome excellent fabulous fantastic favorable fortuitous great
	incredible ineffable mirthful outstanding perfect propitious remarkable smart spectacular splendid stellar
	stupendous super ultimate unbelievable wondrous}

taste_adjectives = %w{alkaline bitter bittersweet bland burnt buttery crisp fishy fruity gingery hearty hot mellow oily
	overripe peppery raw ripe salty sour spicy spoiled sugary sweet tangy medicinal tasteless unripe vinegary }

colors = %w{amber amethyst aqua aquamarine avocado azure bistre black blue brass bright brilliant brindle bronze
	buff burgundy canary carmine carnelian cerise charcoal chartreuse chestnut chocolate chrome citrine claret clear
	cobalt copper coral cordovan cream crimson crystalline cyan dark drab dull dun ebony emerald flesh flushed fuchsia
	garnet glassy gold green grizzly henna indigo iridescent ivory jade jet khaki lake lavender lemon light lilac lime
	magenta mahogany maize maroon mauve milky mint mustard navy obsidian ocher olive onyx opaque orange orchid
	pale peach pearl pearly pink plum poppy primrose puce purple red rose ruby ruddy rust sable saffron salmon sapphire
	scarlet sepia shimmering sienna silver slate smoky snowy sooty spruce tan topaz translucent transparent turquoise
	twinkling ultramarine umber vermilion violet walnut white wine yellow}

intros = ["According to the manufacturer", "Most users agree that", "Without a doubt,", "Let's say it this way:",
	"First of all", "We must admit", "After several tests in our laboratories we conclude that"]


100.times do
	type = types.sample

	title = ""
	title += positive_adjectives.sample + " " if rand(3) == 0
	title += title_prefixes.sample + " " if rand(3) == 0
	title += items[type].sample
	title += " (#{colors.sample})" if type != "Food" && rand(3) == 0

	description = intros.sample
	description += " this product is #{positive_adjectives.sample}."
	description += " It is #{taste_adjectives.sample} and #{taste_adjectives.sample} at the same time." if type == "Food"

	Item.create(type: type, title: title, description: description)
end