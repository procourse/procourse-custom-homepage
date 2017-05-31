module DlCustomHomepage
  class AdminHomepagesController < Admin::AdminController
    requires_plugin 'dl-custom-homepage'

    def show
      homepage = PluginStore.get("dl_custom_homepage", "homepage") || {}
      render_json_dump(homepage)
    end

    def update
      homepage = PluginStore.get("dl_custom_homepage", "homepage") || {}

      homepage[:raw] = params[:homepage][:raw] if !params[:homepage][:raw].nil?
      homepage[:cooked] = params[:homepage][:cooked] if !params[:homepage][:cooked].nil?

      PluginStore.set("dl_custom_homepage", "homepage", homepage)

      render json: homepage, root: false
    end

  end
end