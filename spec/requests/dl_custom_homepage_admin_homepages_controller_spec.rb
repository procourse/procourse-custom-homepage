require 'rails_helper'

describe DlCustomHomepage::AdminHomepagesController do
  let(:user) { Fabricate(:user) }
  let(:admin) { Fabricate(:admin) }

  describe "GET #show" do
    context "as anon" do
      it 'does not allow anonymous users to access' do
          get "/dl-custom-homepage/admin/homepage.json"
          expect(response.status).to eq(404)
      end
    end

    context "as an ordinary user" do
      before :each do
          sign_in(user)
      end
      it 'does not allow ordinary users to access' do
          get "/dl-custom-homepage/admin/homepage.json"
          expect(response.status).to eq(404)
      end
    end

    context "as an admin" do
      before :each do
          sign_in(admin)
      end
      it 'allow admin users to access' do
          get "/dl-custom-homepage/admin/homepage.json"
          expect(response.status).to eq(200)
      end
    end
  end

  describe "POST #update" do
    context "as an admin" do
      before :each do
          sign_in(admin)
      end
      it "allow admin users to create a page" do
        homepage = {
          raw: "test raw",
          cooked: "test_cooked"
        }
        patch "/dl-custom-homepage/admin/homepage.json", params: { homepage: homepage }
        expect(response.status).to eq(200)

        home_page_returned = PluginStore.get("dl_custom_homepage", "homepage")

        expect(home_page_returned["raw"]).to eq(homepage[:raw])
        expect(home_page_returned["cooked"]).to eq(homepage[:cooked])
      end
    end
  end
end
