require 'rails_helper'

describe "get todos route", :type => :request do
  before(:all) do
    @user = FactoryBot.create(:random_user, :with_todos)
    @other_user = FactoryBot.create(:random_user, :with_todos)
  end

  context "without auth" do
    before do
      get "/api/v1/users/#{@user.username}/todos"
    end

    it "returns status code 401" do
      expect(response).to have_http_status(:unauthorized)
    end
  end

  context "with auth" do
    context "own profile" do
      before(:all) do
        get "/api/v1/users/#{@user.username}/todos", headers: {
          "Authorization" => JsonWebToken.encode(user_id: @user.id)
        }
      end
  
      it "returns status code 200" do
        expect(response).to have_http_status(:ok)
      end
  
      it "returns todos" do
        json = JSON.parse(response.body)
        expect(json.length).to eq(20)
      end
    end

    context "others profile" do
      before(:all) do
        get "/api/v1/users/#{@other_user.username}/todos", headers: {
          "Authorization" => JsonWebToken.encode(user_id: @user.id)
        }
      end
  
      it "returns status code 200" do
        expect(response).to have_http_status(:ok)
      end
  
      it "returns public todos" do
        json = JSON.parse(response.body)
        expect(json.length).not_to eq(20)
      end
    end
  end
end