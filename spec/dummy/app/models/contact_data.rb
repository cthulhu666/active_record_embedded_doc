class ContactData
  include ActiveRecordEmbeddedDoc::EmbeddedDocument

  class Phone < ContactData
    field :number
  end

  class Email < ContactData
    field :email
  end

end