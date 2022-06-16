require 'rails_helper'

describe "login route", :type => :request do
  before(:all) do
    @user = FactoryBot.create(:random_user)
  end

  context "success" do
    before(:all) do
      post "/auth/login", params: {
        :email => @user.email,
        :password => Rsa.encode_msg(@user.password)
      }
    end

    it "returns auth token" do
      json = JSON.parse(response.body).with_indifferent_access
      expect(json[:token]).not_to be_nil
    end
    
    it "returns status code 200" do
      expect(response).to have_http_status(:ok)
    end
  end

  context "failed" do
    before do
      post "/auth/login", params: {
        :email => "aaa@email.com",
        :password => Rsa.encode_msg("errado")
      }
    end

    it "returns status code 401" do
      expect(response).to have_http_status(:unauthorized)
    end
  end
end