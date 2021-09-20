require_relative 'configs/config_css.rb'
require_relative 'configs/config_html.rb'
require_relative 'configs/config_js.rb'
require_relative 'configs/config_ruby.rb'
require_relative 'configs/config_txt.rb'
require_relative 'configs/config_yml.rb'

# USE HEREDOC

run "if uname | grep -q 'Darwin'; then pgrep spring | xargs kill -9; fi"

# GEMFILE
########################################
run 'rm Gemfile'
file 'Gemfile', add_gems_ruby

# Procfile
########################################
file 'Procfile', add_procfile_yml

# Assets
########################################
run 'rm -rf app/assets/stylesheets'
run 'rm -rf vendor'
file 'app/assets/stylesheets/application.scss', add_application_css
file 'app/assets/stylesheets/components/_alert.scss', add_alert_css
file 'app/assets/stylesheets/components/_banner.scss', add_banner_css
file 'app/assets/stylesheets/components/_footer.scss', add_footer_css
file 'app/assets/stylesheets/components/_index.scss', add_components_index_css
file 'app/assets/stylesheets/components/_input.scss', add_input_css
file 'app/assets/stylesheets/components/_navbar.scss', add_navbar_css
file 'app/assets/stylesheets/components/_utilities.scss', add_utilities_css
file 'app/assets/stylesheets/config/_bootstrap_variables.scss', add_bootstrap_variables_css
file 'app/assets/stylesheets/config/_colors.scss', add_colors_css
file 'app/assets/stylesheets/config/_fonts.scss', add_font_css
file 'app/assets/stylesheets/config/_index.scss', add_config_index_css
file 'app/assets/stylesheets/config/_sizing.scss', add_sizing_css
file 'app/assets/stylesheets/layouts/_index.scss', add_layouts_index_css
file 'app/assets/stylesheets/units/_button.scss', add_button_css
file 'app/assets/stylesheets/units/_index.scss', add_units_index_css

if Rails.version < "6"
  run 'rm app/assets/javascripts/application.js'
  file 'app/assets/javascripts/application.js', add_application_js
end

# Cookies
########################################
run 'cp ../rails-template-flo-rails6/check.svg app/assets/images/check.svg'
run 'mkdir -p app/javascript/components'
file 'app/javascript/components/cookies.js', add_cookie_js
file 'app/views/layouts/_cookies_banner.html.erb', add_cookie_html

# Dev environment
########################################
gsub_file('config/environments/development.rb', /config\.assets\.debug.*/, 'config.assets.debug = false')
inject_into_file 'config/environments/production.rb', after: 'config.action_mailer.perform_caching = false' do
  add_postmark_production_environment_ruby
end
file 'config/initializers/ckeditor.rb', add_ckeditor_initializer_ruby
inject_into_file 'config/initializers/assets.rb', after: "Rails.application.config.assets.version = '1.0'" do
  update_assets_initializer_ruby
end
file 'config/environments/staging.rb', add_staging_environment_ruby
file 'config/initializers/email_interceptor.rb', add_email_interceptor_initializer_ruby
file 'config/initializers/letter_opener.rb', add_letter_opener_ruby
file 'config/initializers/smtp.rb', add_postmark_initializer_ruby
file 'config/locales/fr.yml', add_fr_locales_yml
run 'rm config/locales/en.yml'
file 'config/locales/en.yml', add_en_locales_yml

# Layout
########################################
run 'rm app/views/layouts/application.html.erb'
file 'app/views/layouts/application.html.erb', add_layout_html
file 'app/views/layouts/_google_analytics.html.erb', add_google_analytics_html
file 'app/views/shared/_footer.html.erb', add_footer_html
file 'app/views/shared/_navbar.html.erb', add_navbar_html
file 'app/views/shared/_flashes.html.erb', add_flash_html

run 'rm public/500.html'
file 'public/500.html', update_error_page_html(500)

run 'rm public/404.html'
file 'public/404.html', update_error_page_html(404)

run 'rm public/422.html'
file 'public/422.html', update_error_page_html(422)

run 'cp ../rails-template-flo-rails6/logo.png app/assets/images/logo.png'
run 'cp ../rails-template-flo-rails6/logo.png public/logo.png'
run 'cp ../rails-template-flo-rails6/favicon.svg app/assets/images/favicon.svg'
run 'cp ../rails-template-flo-rails6/favicon.svg public/favicon.svg'

# FRENCH
application "config.i18n.default_locale = :fr"
application "config.i18n.available_locales = ['fr']"
application "config.time_zone = 'Europe/Paris'"

# README
########################################
markdown_file_content = <<-MARKDOWN
Rails app generated with Florent BRAURE's template.
MARKDOWN
file 'README.md', markdown_file_content, force: true

# Generators
########################################
generators = <<-RUBY
  config.generators do |generate|
      generate.assets false
      generate.helper false
      generate.test_framework  :test_unit, fixture: false
    end
    config.exceptions_app = self.routes
RUBY

environment generators

########################################
# AFTER BUNDLE
########################################
after_bundle do
  # Debug: Spring process need to be stopped to run rails g simple_form:install
  run 'bin/spring stop'
  # Generators: db + simple form + pages controller
  ########################################
  generate('simple_form:install', '--bootstrap')
  generate(:controller, 'pages', 'home', 'legal', '--skip-routes','--no-test-framework')
  generate(:model, 'page', 'title', 'content')

  generate('devise:install')
  generate('devise', 'User')
  rails_command 'db:drop db:create db:migrate'
  generate('migration', 'AddAdminToUsers admin:boolean')
  generate("active_admin:install")
  file "app/admin/pages.rb", add_admin_pages_ruby
  file "app/admin/users.rb", add_admin_users_ruby
  generate("activeadmin_addons:install")
  append_file 'config/initializers/active_admin.rb', add_active_admin_method_ruby
  gsub_file('config/initializers/active_admin.rb', 'config.authentication_method = :authenticate_admin_user!', 'config.authentication_method = :authenticate_admin!')
  gsub_file('config/initializers/active_admin.rb', 'config.current_user_method = :current_admin_user', 'config.current_user_method = :current_user')
  gsub_file('config/initializers/active_admin.rb', "  #   config.register_javascript 'my_javascript.js'", "config.register_javascript '//cdn.ckeditor.com/4.6.1/full/ckeditor.js'")
  generate("draper:install")
  generate("pundit:install")

  #Seed
  run 'rm db/seeds.rb'
  file 'db/seed.rb', add_seed_ruby
  run 'mkdir db/seed'
  file 'lib/tasks/custom_seed.rake', add_custom_seed_ruby

  rails_command 'db:drop db:create db:migrate db:seed'

  # Routes
  ########################################
  route "root to: 'pages#home'"
  route "get '/legal', to: 'pages#legal', as: 'legal'"

  # Git ignore
  ########################################
  append_file '.gitignore', add_gitignore_txt

  # App controller
  ########################################
  run 'rm app/controllers/application_controller.rb'
  file 'app/controllers/application_controller.rb', add_application_controller_ruby

  # migrate + devise views
  ########################################
  rails_command 'db:migrate'
  generate('devise:views')
  file 'app/views/devise/shared/_form.html.erb', add_devise_content_html
  { confirmations: [:new], passwords: [:new, :edit], registrations: [:new, :edit], sessions: [:new]}.each do |dir, files|
    files.each do |file|
      prepend_file "app/views/devise/#{dir}/#{file}.html.erb", update_devise_content_prepend_html
      append_file "app/views/devise/#{dir}/#{file}.html.erb", update_devise_content_append_html
    end
  end

  # Pages Controller
  ########################################
  run 'rm app/controllers/pages_controller.rb'
  file 'app/controllers/pages_controller.rb', add_pages_controller_ruby

  run 'rm app/views/pages/legal.html.erb'
  file 'app/views/pages/legal.html.erb', add_pages_legal_html

  run 'rm app/views/pages/home.html.erb'
  file 'app/views/pages/home.html.erb', add_pages_home_html

  # Creation des Meta
  ########################################
  run 'rm app/helpers/application_helper.rb'
  file 'app/helpers/application_helper.rb', add_application_helper_ruby
  file 'app/helpers/meta_tags_helper.rb', add_meta_tags_helper_ruby
  file 'config/meta.yml', add_meta_yml
  file 'config/initializers/default_meta.rb',  add_default_meta_ruby

  # Environments
  ########################################
  environment 'config.action_mailer.default_url_options = { host: "http://localhost:3000" }', env: 'development'
  environment 'config.action_mailer.delivery_method = :letter_opener', env: 'development'
  environment 'config.action_mailer.perform_deliveries = true', env: 'development'
  environment 'config.action_mailer.default_url_options = { host: "ENV["DOMAIN"] }', env: 'production'
  file 'lib/email_interceptor.rb', add_email_interceptor_class_ruby

  # Webpacker / Yarn
  ########################################
  run 'rm app/javascript/packs/application.js'
  run 'yarn add @popperjs/core jquery bootstrap'
  file 'app/javascript/packs/application.js', add_pack_application_js

  if Rails.version >= "6"
    prepend_file 'app/javascript/packs/application.js', add_pack_application_rails6_js
  end

  inject_into_file 'config/webpack/environment.js', before: 'module.exports' do
    add_webpack_js
  end

  run "rails webpacker:install:stimulus"
  file 'app/javascript/plugins/init_mapbox.js', add_mapbox_js
  run 'yarn add mapbox-gl'
  file 'config/initializers/geocoder.rb', add_geocoder_ruby

  # error_with-controller
  file 'app/controllers/errors_controller.rb', add_errors_controller_ruby
  file 'app/views/errors/not_found.html.erb',  update_error_with_controller_html
  file 'app/views/errors/internal_server_error.html.erb', update_error_with_controller_html
  route "match '/404', to: 'errors#not_found', via: :all"
  route "match '/500', to: 'errors#internal_server_error', via: :all"

  # Mailer devise FR
  ["confirmation_instructions", "email_changed", "password_change", "reset_password_instructions", "unlock_instructions"].each do |mailer_name|
    run "rm app/views/devise/mailer/#{mailer_name}.html.erb"
    run "cp ../rails-template-flo-rails6/mailer/#{mailer_name}.html.erb app/views/devise/mailer/#{mailer_name}.html.erb"
  end
  file 'config/locales/devise.fr.yml', add_devise_fr_yml
  gsub_file('config/initializers/devise.rb', "config.mailer_sender = 'please-change-me-at-config-initializers-devise@example.com'", 'config.mailer_sender = ENV["SENDER_EMAIL"]')
  gsub_file('config/initializers/devise.rb', "# config.parent_mailer = 'ActionMailer::Base'", "config.parent_mailer = 'ApplicationMailer'")

  # Dotenv
  ########################################
  run 'touch .env'

  # Git
  ########################################
  git :init
  git add: '.'
  git commit: "-m 'Initial commit with template from Florent BRAURE'"

  # Fix puma config
  gsub_file('config/puma.rb', 'pidfile ENV.fetch("PIDFILE") { "tmp/pids/server.pid" }', '# pidfile ENV.fetch("PIDFILE") { "tmp/pids/server.pid" }')
end
