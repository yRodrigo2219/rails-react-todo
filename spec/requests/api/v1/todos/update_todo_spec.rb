require 'rails_helper'

describe "update todo route", :type => :request do
  before(:all) do
    @user = FactoryBot.create(:random_user, :with_todos)
    @other_user = FactoryBot.create(:random_user, :with_todos)
  end

  context "without auth" do
    before do
      put "/api/v1/users/#{@user.username}/todos/#{@user.todos.first.id}", params: {
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
      before do
        put "/api/v1/users/#{@user.username}/todos/#{@user.todos.first.id}", params: {
          title: "Todo",
          description: "aaa",
          is_done: false,
          is_public: true
        }, headers: {
          "Authorization" => JsonWebToken.encode(user_id: @user.id)
        }
      end
  
      it "returns status code 204" do
        expect(response).to have_http_status(:no_content)
      end
    end

    context "others profile" do
      before do
        put "/api/v1/users/#{@other_user.username}/todos/#{@other_user.todos.first.id}", params: {
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