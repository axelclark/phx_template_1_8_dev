# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :phx_template_1_8_dev, :scopes,
  user: [
    default: true,
    module: PhxTemplate18Dev.Accounts.Scope,
    assign_key: :current_scope,
    access_path: [:user, :id],
    schema_key: :user_id,
    schema_type: :id,
    schema_table: :users,
    test_data_fixture: PhxTemplate18Dev.AccountsFixtures,
    test_login_helper: :register_and_log_in_user
  ]

config :phx_template_1_8_dev,
  ecto_repos: [PhxTemplate18Dev.Repo],
  generators: [timestamp_type: :utc_datetime]

# Configures the endpoint
config :phx_template_1_8_dev, PhxTemplate18DevWeb.Endpoint,
  url: [host: "localhost"],
  adapter: Bandit.PhoenixAdapter,
  render_errors: [
    formats: [html: PhxTemplate18DevWeb.ErrorHTML, json: PhxTemplate18DevWeb.ErrorJSON],
    layout: false
  ],
  pubsub_server: PhxTemplate18Dev.PubSub,
  live_view: [signing_salt: "5ICHKL8V"]

# Configures the mailer
#
# By default it uses the "Local" adapter which stores the emails
# locally. You can see the emails in your browser, at "/dev/mailbox".
#
# For production it's recommended to configure a different adapter
# at the `config/runtime.exs`.
config :phx_template_1_8_dev, PhxTemplate18Dev.Mailer, adapter: Swoosh.Adapters.Local

# Configure esbuild (the version is required)
config :esbuild,
  version: "0.17.11",
  phx_template_1_8_dev: [
    args:
      ~w(js/app.js --bundle --target=es2022 --outdir=../priv/static/assets --external:/fonts/* --external:/images/*),
    cd: Path.expand("../assets", __DIR__),
    env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
  ]

# Configure tailwind (the version is required)
config :tailwind,
  version: "4.0.9",
  phx_template_1_8_dev: [
    args: ~w(
      --input=assets/css/main.css
      --output=priv/static/assets/main.css
    ),
    cd: Path.expand("..", __DIR__)
  ]

# Configures Elixir's Logger
config :logger, :default_formatter,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
