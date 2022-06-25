class Participant < ApplicationRecord
	before_create :generate_uuid
	belongs_to :room, counter_cache: true

	def generate_uuid
		self.uuid = SecureRandom.uuid
	end
end