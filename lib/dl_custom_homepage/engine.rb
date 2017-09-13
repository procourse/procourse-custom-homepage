module DlCustomHomepage
  class Engine < ::Rails::Engine
    isolate_namespace DlCustomHomepage

    config.after_initialize do
  		Discourse::Application.routes.append do
  			mount ::DlCustomHomepage::Engine, at: "/dl-custom-homepage"
  		end
      module ::Jobs
        class CustomHomepageConfirmValidKey < Jobs::Scheduled
          every 1.days

          def execute(args)
            validate_url = "https://discourseleague.com/licenses/validate?base_url=" + Discourse.base_url + "&id=60249&key=" + SiteSetting.dl_custom_homepage_license_key
            request = Net::HTTP.get(URI.parse(validate_url))
            result = JSON.parse(request)
            if result["enabled"]
              SiteSetting.dl_custom_homepage_licensed = true
            else
              SiteSetting.dl_custom_homepage_licensed = false
            end
          end

        end
      end
    end

  end
end

require 'open-uri'
require 'net/http'

DiscourseEvent.on(:site_setting_saved) do |site_setting|
  if site_setting.name.to_s == "dl_custom_homepage_license_key" && site_setting.value_changed?

    if site_setting.value.empty?
      SiteSetting.dl_custom_homepage_licensed = false
    else
      validate_url = "https://discourseleague.com/licenses/validate?base_url=" + Discourse.base_url + "&id=60249&key=" + site_setting.value
      request = Net::HTTP.get(URI.parse(validate_url))
      result = JSON.parse(request)
      
      if result["errors"]
        raise Discourse::InvalidParameters.new(
          'Sorry. That key is invalid.'
        )
      end

      if result["enabled"]
        SiteSetting.dl_custom_homepage_licensed = true
      else
        SiteSetting.dl_custom_homepage_licensed = false
      end
    end

  end
end