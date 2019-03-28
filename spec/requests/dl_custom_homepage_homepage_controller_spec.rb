require 'rails_helper'

describe DlCustomHomepage::HomepageController do
  let(:user) { Fabricate(:admin) }
  let(:homepage) {
    {
      raw: "test_raw",
      cooked: "test_cooked"
    }
  }
  describe "GET #show" do
    context "as an ordinary user" do
      before :each do
          PluginStore.set("dl_custom_homepage", "homepage", homepage)
      end
      it 'allow ordinary users to access' do
        get "/homepage.json"
        expect(response.status).to eq(200)
        homepage_returned = JSON.parse(response.body)

        expect(homepage_returned["raw"]).to eq(homepage[:raw])
        expect(homepage_returned["cooked"]).to eq(homepage[:cooked])
      end
    end
  end
end
