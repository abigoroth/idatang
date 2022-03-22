def check_files
  remote.chdir(paths.release) do
    remote.run('yarn', 'install', '--check-files')
  end
end

def assets_precompile
  remote.rake("assets:precompile", silent: true, raise_on_error: false)
end

# rubocop:disable Style/FormatStringToken
plugin "git"
plugin "env"
plugin "bundler"
plugin "rails"
plugin "puma"
plugin 'sidekiq'
plugin "./plugins/ebaki.rb"
plugin './plugins/yarn.rb'

host "akob@nft.metalab.my"

set application: "ebaki"
set deploy_to: "/var/www/%{application}"
set git_url: "git@github.com:abigoroth/metalab.git"
set git_branch: "master"
set git_exclusions: %w[
  .tomo/
  spec/
  test/
]
set env_vars: {
  RACK_ENV: "production",
  RAILS_ENV: "production",
  RAILS_LOG_TO_STDOUT: "1",
  RAILS_SERVE_STATIC_FILES: "1",
  BOOTSNAP_CACHE_DIR: "tmp/bootsnap-cache",
  RAILS_MASTER_KEY: :prompt
}
set linked_dirs: %w[
  .yarn/cache
  log
  storage
  node_modules
  public/assets
  public/packs
  tmp/cache
  tmp/pids
  tmp/sockets
  app/assets/builds
]

set linked_files: %w[
  config/database.yml
]

setup do
  run "env:setup"
  run "core:setup_directories"
  run "git:clone"
  run "git:create_release"
  run "core:symlink_shared"
  run "bundler:upgrade_bundler"
  run "bundler:config"
  run "bundler:install"
  # run "rails:db_create"
  run "rails:db_schema_load"
  run "rails:db_seed"
  run "puma:setup_systemd"
  run 'sidekiq:setup_systemd'
end

deploy do
  run "env:update"
  run "git:create_release"
  run "core:symlink_shared"
  run "core:write_release_json"
  run "bundler:install"
  run 'yarn:check_files'
  run "rails:db_migrate"
  run "rails:assets_precompile"
  run "core:symlink_current"
  run "puma:restart"
  run "puma:check_active"
  run "core:clean_releases"
  run "bundler:clean"
  run "core:log_revision"
  run 'sidekiq:restart'
end
# rubocop:enable Style/FormatStringToken
