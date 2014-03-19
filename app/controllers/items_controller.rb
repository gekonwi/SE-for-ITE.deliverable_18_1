class ItemsController < ApplicationController
	before_action :set_item, only: [:show, :edit, :update, :destroy]

	# GET /items
	# GET /items.json
	def index
		@items = Item.all
	end

	# GET /items/1
	# GET /items/1.json
	def show
	end

	# GET /items/new
	def new
		@item = Item.new
	end

	# GET /items/1/edit
	def edit
	end

	# POST /items
	# POST /items.json
	def create
		@item = Item.new(item_params)

		respond_to do |format|
			if @item.save
				format.html { redirect_to @item, notice: 'Item was successfully created.' }
				format.json { render action: 'show', status: :created, location: @item }
			else
				format.html { render action: 'new' }
				format.json { render json: @item.errors, status: :unprocessable_entity }
			end
		end
	end

	# PATCH/PUT /items/1
	# PATCH/PUT /items/1.json
	def update
		respond_to do |format|
			if @item.update(item_params)
				format.html { redirect_to @item, notice: 'Item was successfully updated.' }
				format.json { head :no_content }
			else
				format.html { render action: 'edit' }
				format.json { render json: @item.errors, status: :unprocessable_entity }
			end
		end
	end

	# DELETE /items/1
	# DELETE /items/1.json
	def destroy
		@item.destroy
		respond_to do |format|
			format.html { redirect_to items_url }
			format.json { head :no_content }
		end
	end

	def search
		@types = Type.all

		# per default all types are selected
		@sel_types = @types
		@sel_types = Type.where(:id => params[:sel_types]).to_set if !params[:sel_types].nil?

		@query = params[:query]
		@query = "" if @query.nil?

		@items = find_items(@query, @sel_types)
	end

	private

	# returns all items which contain each word in the query as part of some word in its title or description
	def find_items(query, sel_types)
		# split the query into an array. \W means any "non-word" character
		# and the "+" means to combine multiple delimiters
		words = query.split(/\W+/)

		items = []
		type_ids = sel_types.map {|type| type.id}

		first = true
		words.each do |word|
			q = "%#{word}%"
			cur_set = Item.joins(:type).where("types.id IN (?) AND (items.title LIKE ? OR items.description LIKE ?)", type_ids, q, q).to_set

			if first
				first = false
				items = cur_set
			else
				items.intersection(cur_set)
			end
		end

		items
	end

		# Use callbacks to share common setup or constraints between actions.
		def set_item
			@item = Item.find(params[:id])
		end

		# Never trust parameters from the scary internet, only allow the white list through.
		def item_params
			params.require(:item).permit(:title, :description, :type)
		end
	end
