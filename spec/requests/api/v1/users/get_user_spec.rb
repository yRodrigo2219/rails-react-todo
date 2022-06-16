require 'rails_helper'

describe "get user route", :type => :request do
  before(:all) do
    @user = FactoryBot.create(:random_user)
    @other_user = FactoryBot.create(:random_user)
  end

  context "without auth" do
    before do
      get "/api/v1/users/#{@user.username}"
    end

    it "returns status code 401" do
      expect(response).to have_http_status(:unauthorized)
    end
  end

  context "with auth" do
    context "own profile" do
      before(:all) do
        get "/api/v1/users/#{@user.username}", headers: {
          "Authorization" => JsonWebToken.encode(user_id: @user.id)
        }
      end

      it "returns status code 200" do
        expect(response).to have_http_status(:ok)
      end

      it "returns user info" do
        json = JSON.parse(response.body).with_indifferent_access
        expect(json).to eq(@user.as_json)
      end
    end

    context "others profile" do
      before(:all) do
        get "/api/v1/users/#{@other_user.username}", headers: {
          "Authorization" => JsonWebToken.encode(user_id: @user.id)
        }
      end

      it "returns status code 200" do
        expect(response).to have_http_status(:ok)
      end

      it "returns user info without email" do
        json = JSON.parse(response.body).with_indifferent_access
        expect(json).to eq(@other_user.as_json(except: :email))
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