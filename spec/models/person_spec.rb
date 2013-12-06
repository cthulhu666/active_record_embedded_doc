require 'spec_helper'

describe Person do

  it "includes Behaviour" do
    expect(Person.included_modules).to include(ActiveRecordEmbeddedDoc::Behaviour)
  end

  it "has 'addresses' relation" do
    expect(Person.relations).to include(:addresses)
    expect(Person.relations.addresses.relation).to eq(ActiveRecordEmbeddedDoc::Relations::Many)
  end

  it "has 'family' relation" do
    expect(Person.relations).to include(:family)
    expect(Person.relations.family.relation).to eq(ActiveRecordEmbeddedDoc::Relations::One)
  end

  it "is unchanged after initialization" do
    expect(Person.new.changes).to be_empty
  end

  it "saves properly" do
    p = FactoryGirl.create :person
    expect(p).to be_persisted
  end

  describe "addresses" do

    it "initializes properly with addresses as hashes" do
      params = FactoryGirl.attributes_for(:person, addresses: [{street: 'Elm Street'}, {street: 'Baker Street'}])
      p = Person.new(params)
      expect(p.addresses).to be_an(Array)
      expect(p.addresses.first).to be_an(Address)
    end

    it "initializes properly with addresses as objects" do
      params = FactoryGirl.attributes_for(:person)
      addresses = [Address.new(street: 'Elm Street'), Address.new(street: 'Baker Street')]
      p = Person.new(params.merge(addresses: addresses))
      expect(p.addresses).to be_an(Array)
      expect(p.addresses.first).to be_an(Address)
    end

    it "has nil address" do
      expect(Person.new.addresses).to be_nil
    end

  end

  describe "family" do

    it "has nil family" do
      expect(Person.new.family).to be_nil
    end

    it "handles changes in family" do
      p = FactoryGirl.create :person, family: Family.new(mothers_name: 'Foo', fathers_name: 'Bar')
      p.family.mothers_name = 'Foobar'
      expect(p.changed_attributes.keys).to eq(['family'])
    end

    it "saves and reloads properly" do
      p = FactoryGirl.create :person, family: Family.new(mothers_name: 'Foo', fathers_name: 'Bar')
      expect(p.reload.family.mothers_name).to eq('Foo')
      expect(p.reload.family.fathers_name).to eq('Bar')
    end

  end

  describe "contact_data" do

    it "initializes properly from hash" do
      params = FactoryGirl.attributes_for(:person, contact_data: [{phone: {number: '500600700'}}, {email: {email: 'foo@bar.baz'}}])
      p = Person.new(params)
      expect(p.contact_data).to be_an(Array)
      expect(p.contact_data.first).to be_an(ContactData::Phone)
      expect(p.contact_data.last).to be_an(ContactData::Email)
    end

    it "initializes properly from obects" do
      params = FactoryGirl.attributes_for(:person)
      contact_data = [ContactData::Phone.new(number: '500600700'), ContactData::Email.new(email: 'foo@bar.baz')]
      p = Person.new(params.merge(contact_data: contact_data))
      expect(p.contact_data).to be_an(Array)
      expect(p.contact_data.first).to be_an(ContactData::Phone)
      expect(p.contact_data.last).to be_an(ContactData::Email)
    end

    it "saves properly" do
      params = FactoryGirl.attributes_for(:person, contact_data: [{phone: {number: '500600700'}}, {email: {email: 'foo@bar.baz'}}])
      p = Person.create(params)
      expect(p).to be_persisted
    end

    it "saves changes properly" do
      params = FactoryGirl.attributes_for(:person, contact_data: [{phone: {number: '500600700'}}, {email: {email: 'foo@bar.baz'}}])
      p = Person.create(params)
      p.contact_data.last.email = 'baz@foo.com'
      p.save
      expect(p.reload.contact_data.last.email).to eq('baz@foo.com')
    end

  end

end