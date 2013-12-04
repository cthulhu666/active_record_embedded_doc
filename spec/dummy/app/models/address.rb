class Address
  include ActiveRecordEmbeddedDoc::EmbeddedDocument

  field :street, String
  field :city, String
  field :zip, String

end