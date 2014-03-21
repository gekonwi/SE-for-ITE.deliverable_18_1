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
		args = {type_ids: sel_types.map {|type| type.id}}

		# split the query into an array. \W means any "non-word" character
		# and the "+" means to combine multiple delimiters
		items = []; first = true
		query.split(/\W+/).each do |word|
			args[:q] = "%#{word}%"
			cur_set = Item.joins(:type).where(find_items_conditions, args).to_set

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

	def find_items_conditions
		type_condition = "type_id IN (:type_ids)"

		like_conditions = []
		like_conditions << "items.title LIKE :q"
		like_conditions << "items.description LIKE  :q"
		like_conditions << "items.owner LIKE :q"
		like_conditions << "types.title LIKE :q"

		return "#{type_condition} AND (#{like_conditions.join(' OR ')})"
	end
end