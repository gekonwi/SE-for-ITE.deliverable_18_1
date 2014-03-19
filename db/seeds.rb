# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Type.destroy_all
Item.destroy_all

type_titles = ["PC Hardware", "Clothes", "Furniture", "Food"]
type_titles.each {|type| Type.create(title: type)}

items = Hash.new

items["PC Hardware"] = ["keyboard", "mouse", "LCD", "cooler", "graphic card", "cpu", "mainboard", "RAM", "hard disk", "blu-ray drive"]
items["Clothes"] = %w{shirt pants socks jacket coat gloves hat shoes jeans pullover hoody}
items["Furniture"] = %w{table desk chair bed bookshelf cupboard closet safe bedstand couch sofa}
items["Food"] = %w{beef pork chicken bacon ham lamb liver kidneys turkey duck sausages salami apple orange banana pear peach lemon
	lime plum melon grape mango kiwi apricot pineapple blackberry blackcurrant redcurrant blueberry strawberry raspberry gooseberry
	rhubarb cod haddock plaice tuna salmon trout mackerel herring sardine pilchard sole anchovy toast jam marmalade breakfast cereal
	cornflakes muesli porridge}

	positive_adjectives = ['good', 'super', 'fine', 'usable', 'pretty', 'probably usable' ]
	negative_adjectives = ['damaged', 'squeezed', 'dirty', 'scratched', 'water damaged', 'bended', 'broken' ]

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

			times = ["yestarday", "last week", "on 03/12", "today morning", "on Monday", "on Tuesday", "on Wednesday", "some days ago", "tonight"]

			activities = ["on the way home", "while walking to the parking slot", "leaving campus", "walking near the parc", ""]

			places = ["in the toilet", "near the gym", "in room 774", "in the CS office", "on the street", "behind a tree", "next to a car"]

			bad_quality_intros = ["a little", "seems to be", "might be", "although a little"]
			good_quality_intros = ["condition:", "looks", "still looks", "should still be"]

			taste_intros = ["it still tastes", "seems to be", "tastes", "it tastes"]

			names = ['Melynda Corder', 'Sylvie Verges', 'Neely Rasberry', 'Octavia Hibbert', 'Shawana Leggett', 'Nell Lesh', 'Lindsay Haefner',
				'Charisse Holtzclaw', 'Cole Kula', 'Alina Spires', 'Margret Perri', 'Annabelle Seel', 'Gussie Fretwell', 'Inell Burgio', 'Nydia Mcgivney',
				'Dominic Arner', 'Madlyn Casebeer', 'Dayle Walpole', 'Inocencia Howells', 'Vallie Sue', 'Anya Mccutcheon', 'Jazmin Coty',
				'Debroah Seagle', 'Marilyn Mireles', 'Vince Mcgowen']

				100.times do
					type = Type.all.sample

					title = items[type.title].sample
					title += " (#{colors.sample})" if ["Clothes", "Furniture"].include?(type.title) && rand(2) == 0

					case rand(4)
					when 0
						description = "found by #{names.sample}"
						description += " #{times.sample}" if rand(2) == 0
					when 1
						description = "#{times.sample} #{names.sample} found it #{places.sample}"
						description += " #{activities.sample}" if rand(2) == 0
					when 2
						description = "#{names.sample} brought it #{times.sample}"
					when 3
						description = "was found #{places.sample}"
						description += " #{times.sample}" if rand(2) == 0
					end

					case rand(4)
					when 0

					when 1
						description += "; #{bad_quality_intros.sample} #{negative_adjectives.sample}"
					when 2
						description += "; #{good_quality_intros.sample} #{positive_adjectives.sample}"
					when 3
						description += "; #{bad_quality_intros.sample} #{negative_adjectives.sample},
						#{good_quality_intros.sample} #{positive_adjectives.sample}"
					end

					if rand(2) == 0 && type.title == "Food"
						description += "; "
						description += "#{names.sample} tried it, " if rand(2) == 0
						description += "#{taste_intros.sample} #{taste_adjectives.sample}"
					end

					item = Item.new(title: title, description: description)
					item.type = type
					item.owner = names.sample if rand(2) == 0
					item.save
				end