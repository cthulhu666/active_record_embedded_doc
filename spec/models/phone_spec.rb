require 'spec_helper'

describe ContactData::Phone do
  it "fails validation with wrong number format" do
    phone = ContactData::Phone.new(number: 'xxx')
    expect(phone).to be_invalid
    expect(phone.errors).to have(1).error_on(:number)
  end

  it "passes validation with proper number format" do
    phone = ContactData::Phone.new(number: '500600700')
    expect(phone).to be_valid
  end
end