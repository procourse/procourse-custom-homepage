module DlCustomHomepage
  class HomepageController < ApplicationController

    def show
      if Rails.env != "development" || SiteSetting.dl_custom_homepage_licensed
        homepage = PluginStore.get("dl_custom_homepage", "homepage") || {}
      else
        homepage = {"cooked": I18n.t('dl_custom_homepage.not_licensed_page')}
      end
      
      if !homepage.empty?
        render_json_dump(homepage)
      else
        render nothing: true, status: 404
      end

    end

  end
end