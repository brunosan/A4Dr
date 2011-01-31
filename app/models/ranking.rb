class Ranking < ActiveRecord::Base

default_scope :order => 'rankings.votes DESC'


end
