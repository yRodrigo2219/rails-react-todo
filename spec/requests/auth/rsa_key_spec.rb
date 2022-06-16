require 'rails_helper'

describe "get rsa key", :type => :request do
  before do
    get "/auth/rsa-key"
  end

  it "returns valid key" do
    json = JSON.parse(response.body).with_indifferent_access
    expect(json[:pk]).to eq(Rsa.public_key_str)
  end
end