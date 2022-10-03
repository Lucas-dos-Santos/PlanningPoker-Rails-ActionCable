module ApplicationHelper
	def set_title_page
		@room.present? ? "Team #{@room.team_name.capitalize}" : 'Planning Poker Free'
	end

	def set_url_language(language)
		request.path + language
	end
end