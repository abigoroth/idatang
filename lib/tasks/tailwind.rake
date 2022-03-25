namespace :tailwind do
  desc "Compile Action View assets"
  task :build do
    unless system "yarn install && yarn build:tailwind"
      raise "cssbundling-rails: Command css:build failed, ensure yarn is installed and `yarn build:tailwind` runs without errors"
    end
  end
end

if Rake::Task.task_defined?("css:build")
  Rake::Task["css:build"].enhance(["tailwind:build"])
end
