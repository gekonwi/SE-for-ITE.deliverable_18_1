class ItemsController < ApplicationController
	before_action :set_item, only: [:show, :edit, :update, :destroy]

	# GET /items
	# GET /items.json
	def index
		@items = Item.all
	end

	def search
		# the default search mode is OR
		@sel_mode = params[:mode] || 'or'
		@all_types = Type.all.to_set

		# per default all types are selected
		@sel_types = @all_types
		@sel_types = Type.where(:id => params[:sel_types]).to_set unless params[:sel_types].nil?

		@query = params[:query] || ""

		@items = find_items(@query, @sel_types, @sel_mode == 'and')
	end

	private

	# returns all items which contain each word in the query as part of some word in its title or description
	def find_items(query, sel_types, and_mode)

		# split the query into an array. \W means any "non-word" character
		# and the "+" means to combine multiple delimiters
		words = query.split(/\W+/)

		items = Set.new
		type_ids = sel_types.map {|type| type.id}

		first = true
		words.each do |word|
			q = "%#{word}%"
			cur_set = Item.where("type_id IN (?) AND (title LIKE ? OR description LIKE ?)", type_ids, q, q).to_set

			if first
				first = false
				items = cur_set
			else
				items = items.intersection(cur_set) if and_mode
				items = items.merge(cur_set) unless and_mode
			end
		end

		items
	end
end