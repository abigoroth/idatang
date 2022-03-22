# frozen_string_literal: true

def check_files
  remote.chdir(paths.release) do
    remote.run('yarn', 'install', '--check-files')
  end
end
