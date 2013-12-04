class Person < ActiveRecord::Base

  embeds_many :addresses
  #embeds_many :contact_data

  embeds_one :family

end
