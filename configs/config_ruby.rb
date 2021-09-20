def add_gems_ruby
<<-RUBY
  source 'https://rubygems.org'
  ruby '#{RUBY_VERSION}'

  #{"gem 'bootsnap', require: false" if Rails.version >= "5.2"}
  gem 'devise'
  gem 'jbuilder', '~> 2.0'
  gem 'pg', '~> 1.1'
  gem 'puma'
  gem 'rails', '#{Rails.version}'
  gem 'redis'
  gem "execjs", '~> 2.7.0'
  gem 'postmark-rails'
  gem 'activeadmin'
  gem 'activeadmin_addons'
  gem 'draper'
  gem 'pundit'
  gem 'geocoder'
  gem 'ckeditor'

  gem 'autoprefixer-rails'
  gem 'font-awesome-sass', '~> 5.6.1'
  gem 'sassc-rails'
  gem 'simple_form'
  gem 'uglifier'
  gem 'webpacker'
  gem 'slim'

  group :development do
    gem 'rails-erd'
    gem 'web-console', '>= 3.3.0'
  end

  group :development, :test do
    gem 'pry-byebug'
    gem 'pry-rails'
    gem 'letter_opener'
    gem 'listen', '~> 3.0.5'
    gem 'spring'
    gem 'spring-watcher-listen', '~> 2.0.0'
    gem 'dotenv-rails'
  end
RUBY
end

def add_admin_pages_ruby
<<-RUBY
ActiveAdmin.register Page do

  permit_params :title, :content

  form do |f|
    f.inputs "Page" do
      f.input :title
      f.input :content, as: :ckeditor, label: false
    end
    f.button :submit
  end
end
RUBY
end

def add_admin_users_ruby
<<-RUBY
ActiveAdmin.register User do

  permit_params :email, :encrypted_password, :password, :password_confirmation, :admin

  member_action :login_as, :method => :get do
    user = User.find(params[:id])
    sign_in(:user, user, bypass: true)
    flash[:alert] = "Vous êtes désormais connecté en tant que " + user.email
    redirect_to root_path
  end

  index do
    selectable_column
    column :id
    column :email
    toggle_bool_column :admin
    column :created_at
    column :updated_at
    column :login_as do |user|
      link_to user.email, login_as_admin_user_path(user), :target => '_blank'
    end
    actions
  end
  form do |f|
    tabs do
      tab 'User' do
        f.inputs do
          f.input :email
          f.input :password
          f.input :password_confirmation
          f.input :admin
          f.button :submit
        end
      end
    end
  end
  show do
    tabs do
      tab "Utilisateur" do
        attributes_table do
          row :email
          row :admin
        end
      end
    end
  end
  controller do
    def update
      return super if params[:user].nil?
      if params[:user][:password].blank? && params[:user][:password_confirmation].blank?
        params[:user].delete("password")
        params[:user].delete("password_confirmation")
      end
      super
    end
  end
end
RUBY
end

def add_letter_opener_ruby
  <<-RUBY
  LetterOpener.configure do |config|
    # To overrider the location for message storage.
    # Default value is `tmp/letter_opener`
    config.location = Rails.root.join('tmp', 'emails')

    # To render only the message body, without any metadata or extra containers or styling.
    # config.message_template = :light
    # Default value is `:default` that renders styled message with showing useful metadata.
  end
  RUBY
end

def add_email_interceptor_initializer_ruby
<<-RUBY
# if Rails.env.production? || Rails.env.staging?
if Rails.env.staging?
  require "email_interceptor"
  ActionMailer::Base.register_interceptor(EmailInterceptor)
end
RUBY
end

def add_email_interceptor_class_ruby
<<-RUBY
class EmailInterceptor
  def self.delivering_email(message)
    message.subject = message.to + " " + message.subject
    message.to = [ ENV['DEFAULT_EMAIL'] ]
  end
end
RUBY
end

def add_postmark_initializer_ruby
<<-RUBY
ActionMailer::Base.smtp_settings = {
  :address => 'smtp.postmarkapp.com',
  :port => 587,
  :domain => ENV['DOMAIN'] || "localhost:3000",
  :user_name => ENV['POSTMARK_USERNAME'],
  :password => ENV['POSTMARK_PASSWORD'],
  :authentication => :plain,
  :enable_starttls_auto => true
}
RUBY
end

def add_postmark_production_environment_ruby
<<-RUBY
\n  config.action_mailer.delivery_method     = :postmark
  config.action_mailer.postmark_settings   = { api_token: ENV['POSTMARK_API_TOKEN'] }
  config.action_mailer.default_url_options = { host: ENV['DOMAIN'] }
  config.action_mailer.raise_delivery_errors = false
RUBY
end


def add_staging_environment_ruby
<<-RUBY
Rails.application.configure do
  config.action_mailer.default_url_options = { host: ENV['DOMAIN'] }
  config.action_mailer.raise_delivery_errors = false
  # Settings specified here will take precedence over those in config/application.rb.
  config.action_mailer.delivery_method     = :postmark
  config.action_mailer.postmark_settings   = { api_token: ENV['POSTMARK_API_TOKEN'] }

  # Code is not reloaded between requests.
  config.cache_classes = true

  # Eager load code on boot. This eager loads most of Rails and
  # your application in memory, allowing both threaded web servers
  # and those relying on copy on write to perform better.
  # Rake tasks automatically ignore this option for performance.
  config.eager_load = true

  # Full error reports are disabled and caching is turned on.
  config.consider_all_requests_local       = false
  config.action_controller.perform_caching = true

  # Ensures that a master key has been made available in either ENV["RAILS_MASTER_KEY"]
  # or in config/master.key. This key is used to decrypt credentials (and other encrypted files).
  # config.require_master_key = true

  # Disable serving static files from the `/public` folder by default since
  # Apache or NGINX already handles this.
  config.public_file_server.enabled = ENV['RAILS_SERVE_STATIC_FILES'].present?

  # Compress CSS using a preprocessor.
  # config.assets.css_compressor = :sass

  # Do not fallback to assets pipeline if a precompiled asset is missed.
  config.assets.compile = false

  # Enable serving of images, stylesheets, and JavaScripts from an asset server.
  # config.action_controller.asset_host = 'http://assets.example.com'

  # Specifies the header that your server uses for sending files.
  # config.action_dispatch.x_sendfile_header = 'X-Sendfile' # for Apache
  # config.action_dispatch.x_sendfile_header = 'X-Accel-Redirect' # for NGINX

  # Store uploaded files on the local file system (see config/storage.yml for options).
  config.active_storage.service = :cloudinary

  # Mount Action Cable outside main process or domain.
  # config.action_cable.mount_path = nil
  # config.action_cable.url = 'wss://example.com/cable'
  # config.action_cable.allowed_request_origins = [ 'http://example.com', /http:\/\/example.*/ ]

  # Force all access to the app over SSL, use Strict-Transport-Security, and use secure cookies.
  config.force_ssl = true

  # Use the lowest log level to ensure availability of diagnostic information
  # when problems arise.
  config.log_level = :debug

  # Prepend all log lines with the following tags.
  config.log_tags = [ :request_id ]

  # Use a different cache store in production.
  # config.cache_store = :mem_cache_store

  # Use a real queuing backend for Active Job (and separate queues per environment).
  # config.active_job.queue_adapter     = :resque
  # config.active_job.queue_name_prefix = "drive_a2pconcept_production"

  config.action_mailer.perform_caching = false

  #{add_postmark_production_environment_ruby}
  # Ignore bad email addresses and do not raise email delivery errors.
  # Set this to true and configure the email server for immediate delivery to raise delivery errors.
  # config.action_mailer.raise_delivery_errors = false

  # Enable locale fallbacks for I18n (makes lookups for any locale fall back to
  # the I18n.default_locale when a translation cannot be found).
  config.i18n.fallbacks = true

  # Send deprecation notices to registered listeners.
  config.active_support.deprecation = :notify

  # Use default logging formatter so that PID and timestamp are not suppressed.
  config.log_formatter = ::Logger::Formatter.new

  # Use a different logger for distributed setups.
  # require 'syslog/logger'
  # config.logger = ActiveSupport::TaggedLogging.new(Syslog::Logger.new 'app-name')

  if ENV["RAILS_LOG_TO_STDOUT"].present?
    logger           = ActiveSupport::Logger.new(STDOUT)
    logger.formatter = config.log_formatter
    config.logger    = ActiveSupport::TaggedLogging.new(logger)
  end

  # Do not dump schema after migrations.
  config.active_record.dump_schema_after_migration = false

  # Inserts middleware to perform automatic connection switching.
  # The `database_selector` hash is used to pass options to the DatabaseSelector
  # middleware. The `delay` is used to determine how long to wait after a write
  # to send a subsequent read to the primary.
  #
  # The `database_resolver` class is used by the middleware to determine which
  # database is appropriate to use based on the time delay.
  #
  # The `database_resolver_context` class is used by the middleware to set
  # timestamps for the last write to the primary. The resolver uses the context
  # class timestamps to determine how long to wait before reading from the
  # replica.
  #
  # By default Rails will store a last write timestamp in the session. The
  # DatabaseSelector middleware is designed as such you can define your own
  # strategy for connection switching and pass that into the middleware through
  # these configuration options.
  # config.active_record.database_selector = { delay: 2.seconds }
  # config.active_record.database_resolver = ActiveRecord::Middleware::DatabaseSelector::Resolver
  # config.active_record.database_resolver_context = ActiveRecord::Middleware::DatabaseSelector::Resolver::Session
end
RUBY
end

def update_assets_initializer_ruby
<<-RUBY
\nRails.application.config.assets.precompile += %w[ckeditor/config.js]
RUBY
end

def add_ckeditor_initializer_ruby
<<-RUBY
Ckeditor.setup do |config|
  # //cdn.ckeditor.com/<version.number>/<distribution>/ckeditor.js
  config.cdn_url = "//cdn.ckeditor.com/4.6.1/full/ckeditor.js"
end
RUBY
end

def add_default_meta_ruby
<<-RUBY
DEFAULT_META = YAML.load_file(Rails.root.join("config/meta.yml"))
RUBY
end

def add_active_admin_method_ruby
<<-RUBY
  def authenticate_admin!
    redirect_to new_user_session_path unless current_user && current_user.admin
  end
RUBY
end

def add_errors_controller_ruby
<<-RUBY
   class ErrorsController < ApplicationController
      skip_before_action :authenticate_user!
      def not_found
        render status: 404
      end

      def internal_server_error
        render status: 500
      end
    end
RUBY
end

def add_seed_ruby
<<-RUBY
User.create!(email: 'admin@example.com', password: 'macpass', password_confirmation: 'macpass', admin: true)
Page.create!(title: "Mentions Légales", content: "")
RUBY
end

def add_custom_seed_ruby
<<-RUBY
namespace :db do
  namespace :seed do
    Dir[Rails.root.join('db', 'seeds', '*.rb')].each do |filename|
      task_name = File.basename(filename, '.rb')
      desc "Seed " + task_name + ", based on the file with the same name in `db/seeds/*.rb`"
      task task_name.to_sym => :environment do
        load(filename) if File.exist?(filename)
      end
    end
  end
end
RUBY
end

def add_application_controller_ruby
<<-RUBY
class ApplicationController < ActionController::Base
#{"  protect_from_forgery with: :exception\n" if Rails.version < "5.2"}  before_action :authenticate_user!

  # uncomment to raise error if authorize is not call in controller
  # after_action :verify_authorized, except: :index, unless: :skip_pundit?
  # after_action :verify_policy_scoped, only: :index, unless: :skip_pundit?
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def default_url_options
    { host: ENV["DOMAIN"] || "localhost:3000" }
  end

  def skip_pundit?
    devise_controller? || params[:controller] =~ /(^(rails_)?admin)|(^pages$)/
  end

  def user_not_authorized
    flash[:alert] = "Vous n'êtes pas autorisés à réaliser cette action."
    redirect_to(root_path)
  end
end
RUBY
end

def add_pages_controller_ruby
<<-RUBY
  class PagesController < ApplicationController
    skip_before_action :authenticate_user!, only: [:home, :legal]

    def home
    end

    def legal
      @page = Page.find_by(title: "Mentions Légales")
    end
  end
RUBY
end

def add_application_helper_ruby
<<-RUBY
module ApplicationHelper
  def svg_tag(name)
    file_path = Rails.root + "/app/assets/images/" + name + ".svg"
    if File.exists?(file_path)
      File.read(file_path).html_safe
    else
      '(not found)'
    end
  end
end
RUBY
end

def add_meta_tags_helper_ruby
<<-RUBY
module MetaTagsHelper
  def meta_title
    content_for?(:meta_title) ? content_for(:meta_title) : DEFAULT_META["meta_title"]
  end

  def meta_description
    content_for?(:meta_description) ? content_for(:meta_description) : DEFAULT_META["meta_description"]
  end

  def meta_image
    meta_image = (content_for?(:meta_image) ? content_for(:meta_image) : DEFAULT_META["meta_image"])
    meta_image.starts_with?("http") ? meta_image : image_url(meta_image)
  end
end
RUBY
end

def add_geocoder_ruby
<<-RUBY
Geocoder.configure(
  # Geocoding options
  # timeout: 3,                 # geocoding service timeout (secs)
  # lookup: :nominatim,         # name of geocoding service (symbol)
  # ip_lookup: :ipinfo_io,      # name of IP address geocoding service (symbol)
  # language: :en,              # ISO-639 language code
  # use_https: false,           # use HTTPS for lookup requests? (if supported)
  # http_proxy: nil,            # HTTP proxy server (user:pass@host:port)
  # https_proxy: nil,           # HTTPS proxy server (user:pass@host:port)
  # api_key: nil,               # API key for geocoding service
  # cache: nil,                 # cache object (must respond to #[], #[]=, and #del)
  # cache_prefix: 'geocoder:',  # prefix (string) to use for all cache keys

  # Exceptions that should not be rescued by default
  # (if you want to implement custom error handling);
  # supports SocketError and Timeout::Error
  # always_raise: [],

  # Calculation options
  units: :km,                 # :km for kilometers or :mi for miles
  # distances: :linear          # :spherical or :linear
)
RUBY
end
