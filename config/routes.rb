DlCustomHomepage::Engine.routes.draw do
  resource :admin_homepage, path: '/admin/homepage', constraints: AdminConstraint.new
end