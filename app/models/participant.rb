class Participant < ApplicationRecord
	belongs_to :room, counter_cache: true
end