# name: dl-custom-homepage
# about: Adds the ability to create a custom homepage for Discourse.
# version: 0.1
# author: Joe Buhlig joebuhlig.com
# url: https://www.github.com/discourse-league/dl-custom-homepage

enabled_site_setting :dl_custom_homepage_enabled

add_admin_route 'dl_custom_homepage.title', 'dl-custom-homepage'

register_asset "stylesheets/dl-custom-homepage.scss"

Discourse.top_menu_items.push(:home)
Discourse.anonymous_top_menu_items.push(:home)
Discourse.filters.push(:home)
Discourse.anonymous_filters.push(:home)

load File.expand_path('../lib/dl_custom_homepage/engine.rb', __FILE__)

Discourse::Application.routes.append do
  get '/admin/plugins/dl-custom-homepage' => 'admin/plugins#index', constraints: StaffConstraint.new
  get '/homepage' => 'dl_custom_homepage/homepage#show'
end

after_initialize do

  require_dependency 'topic_query'
  class ::TopicQuery
    def list_home
      create_list(:latest, {}, latest_results)
    end
  end

end