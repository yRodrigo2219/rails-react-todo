require 'rails_helper'

describe "autocomplete route", :type => :request do
  before(:all) do
    @user = FactoryBot.create(:random_user)
    FactoryBot.create_list(:random_user, 10)
  end


  context "without auth" do
    before(:all) do
      get "/api/v1/users"
    end

    it "returns status code 401" do
      expect(response).to have_http_status(:unauthorized)
    end
  end

  context "with auth" do
    context "no search" do
      before(:all) do
        get "/api/v1/users", params: {
          :search => "",
        }, headers: {
          "Authorization" => JsonWebToken.encode(user_id: @user.id)
        }
      end

      it "returns status code 200" do
        expect(response).to have_http_status(:ok)
      end

      it "returns autocomplete" do
        json = JSON.parse(response.body)
        expect(json.length).to eq(5)
      end
    end

    context "with search params" do
      before(:all) do
        get "/api/v1/users", params: {
          :search => @user.username,
        }, headers: {
          "Authorization" => JsonWebToken.encode(user_id: @user.id)
        }
      end

      it "returns status code 200" do
        expect(response).to have_http_status(:ok)
      end

      it "returns autocomplete" do
        json = JSON.parse(response.body)
        expect(json.length).to eq(1)
      end
    end

    context "with no found users" do
      before(:all) do
        get "/api/v1/users", params: {
          :search => "231aaa", # faker n gera com numero
        }, headers: {
          "Authorization" => JsonWebToken.encode(user_id: @user.id)
        }
      end

      it "returns status code 200" do
        expect(response).to have_http_status(:ok)
      end

      it "returns autocomplete" do
        json = JSON.parse(response.body)
        expect(json.length).to eq(0)
      end
    end
  end
end