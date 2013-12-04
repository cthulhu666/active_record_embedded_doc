require 'spec_helper'

describe Address do

  %w(street city zip).each do |field|
    it "has #{field} field" do
      expect(Address.fields.keys).to include(field)
    end
  end

  it "has street reader" do
    expect(Address.new(street: 'Foo').street).to eq('Foo')
  end

  it "has street writer" do
    addr = Address.new
    addr.street = 'Foo'
    expect(addr.street).to eq('Foo')
  end

  it "is unchanged after initialization" do
    expect(Address.new(street: 'Foo').changes).to be_empty
  end

  it "handles street changes" do
    addr = Address.new(street: 'Foo')
    addr.street = 'Bar'
    expect(addr.changed_attributes).to include('street')
  end

end