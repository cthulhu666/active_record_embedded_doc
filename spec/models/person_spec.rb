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

  it "has nil family" do
    expect(Person.new.family).to be_nil
  end

  it "is unchanged after initialization" do
    expect(Person.new.changes).to be_empty
  end

  it "handles changes in family" do
    p = FactoryGirl.create :person, family: Family.new(mothers_name: 'Foo', fathers_name: 'Bar')
    p.family.mothers_name = 'Foobar'
    expect(p.changed_attributes.keys).to eq(['family'])
  end

  it "saves properly" do
    p = FactoryGirl.create :person
    expect(p).to be_persisted
  end

end