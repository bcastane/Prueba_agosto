class Song < ActiveRecord::Base
	belongs_to :genre

   has_many :user_songs, dependent: :destroy
   has_many :users, through: :user_songs

end
