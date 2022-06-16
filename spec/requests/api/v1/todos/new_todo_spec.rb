require 'rails_helper'

describe "new todo route", :type => :request do
  before(:all) do
    @user = FactoryBot.create(:random_user)
    @other_user = FactoryBot.create(:random_user)
  end

  context "without auth" do
    before do
      post "/api/v1/users/#{@user.username}/todos", params: {
        title: "Todo",
        description: "aaa",
        is_done: false,
        is_public: true
      }
    end

    it "returns status code 401" do
      expect(response).to have_http_status(:unauthorized)
    end
  end

  context "with auth" do
    context "own profile" do
      before(:all) do
        post "/api/v1/users/#{@user.username}/todos", params: {
          title: "Todo",
          description: "aaa",
          is_done: false,
          is_public: true
        }, headers: {
          "Authorization" => JsonWebToken.encode(user_id: @user.id)
        }
      end
  
      it "returns status code 201" do
        expect(response).to have_http_status(:created)
      end
  
      it "returns todo" do
        json = JSON.parse(response.body).with_indifferent_access
        expect(json).to eq(@user.todos.first.as_json)
      end
    end

    context "others profile" do
      before do
        post "/api/v1/users/#{@other_user.username}/todos", params: {
          title: "Todo",
          description: "aaa",
          is_done: false,
          is_public: true
        }, headers: {
          "Authorization" => JsonWebToken.encode(user_id: @user.id)
        }
      end
  
      it "returns status code 401" do
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end