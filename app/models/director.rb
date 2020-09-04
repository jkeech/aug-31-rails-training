class Director < ApplicationRecord
    validates_presence_of :name
    validates_presence_of :age
    has_many :movies
end