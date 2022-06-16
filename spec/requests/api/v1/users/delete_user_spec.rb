require 'rails_helper'

describe "delete user route", :type => :request do
  before(:all) do
    @user = FactoryBot.create(:random_user)
    @other_user = FactoryBot.create(:random_user)
  end

  context "without auth" do
    before do
      delete "/api/v1/users/#{@user.username}"
    end

    it "returns status code 422" do
      expect(response).to have_http_status(:unprocessable_entity) # error trying to decode password
    end
  end

  context "with auth" do
    context "others profile" do
      before do
        delete "/api/v1/users/#{@other_user.username}", headers: {
          "Authorization" => JsonWebToken.encode(user_id: @user.id)
        }
      end

      it "returns status code 422" do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context "without password" do
      before do
        delete "/api/v1/users/#{@user.username}", headers: {
          "Authorization" => JsonWebToken.encode(user_id: @user.id)
        }
      end

      it "returns status code 422" do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context "with password" do
      before do
        delete "/api/v1/users/#{@user.username}", params: {
          password: Rsa.encode_msg(@user.password)
        }, headers: {
          "Authorization" => JsonWebToken.encode(user_id: @user.id)
        }
      end

      it "returns status code 204" do
        expect(response).to have_http_status(:no_content)
      end
    end
  end
end