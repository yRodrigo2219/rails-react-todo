require 'rails_helper'

describe "register route", :type => :request do
  context "without params" do
    before do
      post "/api/v1/users"
    end

    it "returns status code 422" do
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  context "with all params" do
    before do
      post "/api/v1/users", params: {
        :email => "test@email.com",
        :name => "Test",
        :username =>  "test",
        :password => Rsa.encode_msg("123456")
      }
    end
  
    it "returns status code 201" do
      expect(response).to have_http_status(:created)
    end
  end
end