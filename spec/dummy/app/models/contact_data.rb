class ContactData
  include ActiveRecordEmbeddedDoc::EmbeddedDocument

  class Phone < ContactData
    field :number

    validates :number, format: /\d{9}/
  end

  class Email < ContactData
    field :email
  end

end