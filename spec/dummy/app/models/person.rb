class Person < ActiveRecord::Base

  embeds_many :addresses
  embeds_many :contact_data, class_name: "ContactData"
  embeds_one  :family

  validates_associated :contact_data

end
