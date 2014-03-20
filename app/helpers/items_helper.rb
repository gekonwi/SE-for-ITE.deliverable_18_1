module ItemsHelper

	# returns 'class=active' if cur_page == page, otherwise an empty string
	def active_if(cur_page, page)
		return 'class=active' if cur_page == page
		return ""
	end

end
