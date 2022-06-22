class Room < ApplicationRecord
	before_create :generate_unique_room_identifier
	has_many :participants, dependent: :destroy

	def generate_unique_room_identifier
		self.unique_identifier = SecureRandom.hex(5)
	end
end