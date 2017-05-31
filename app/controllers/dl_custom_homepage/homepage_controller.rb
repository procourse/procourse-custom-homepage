module DlCustomHomepage
  class HomepageController < ApplicationController

    def show
      homepage = PluginStore.get("dl_custom_homepage", "homepage") || {}

      if !homepage.empty?
        render_json_dump(homepage)
      else
        render nothing: true, status: 404
      end

    end

  end
end