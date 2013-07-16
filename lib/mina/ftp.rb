require 'rake/contrib/ftptools'
require 'ftp_sync'

# # Modules: FTP
# Adds settings and tasks for uploading to FTP
#
#     require 'mina/ftp'
#
# ## Settings
# Any and all of these settings can be overwritten in your `deploy.rb`.
#
# ### ftp_host
# Sets the FTP server hostname

set_default :ftp_host, domain

# ### ftp_path
# Sets the FTP target path

set_default :ftp_path, domain

# ### ftp_username
# Sets the default FTP username

set_default :ftp_username, 'CHANGE THIS'

# ### ftp_password
# Sets the default FTP password

set_default :ftp_password, 'CHANGE THIS'

# ### ftp_from_path
# Local files location, defaults to: public

set_default :ftp_from_path, 'public'

# ### ftp_files_pattern
# Pattern to match what files to be uploaded, like with `Dir#glob`
# Defaults to: **/*

set_default :ftp_files_pattern, '**/*'

# ### ftp_client
# Sets up the ftp client
set_default :ftp_client, proc{
  FtpSync.new(ftp_host, ftp_username, ftp_password, :verbose => verbose_mode?)
}

# ## Deploy tasks
# These tasks are meant to be invoked inside deploy scripts, not invoked on
# their own.

namespace 'ftp' do
  # ### ftp:deploy
  # Starts a deploy to FTP server
  desc 'Starts a deploy to FTP server'
  task :deploy do
    print_str '-----> Starting FTP deployment to %s' % ftp_host
    Dir.chdir(ftp_from_path)
    local_path = Dir.pwd
    local_files = Dir.glob(ftp_files_pattern).select{ |fn| File.file?(fn) }

    ftp_client.push_files(local_path, ftp_path, local_files)
  end

  # ### aws:s3:empty
  # Empties bucket of any files
  desc 'Empty the FTP path'
  task :empty do
    Dir.chdir(ftp_from_path)
    local_files = Dir.glob(ftp_files_pattern)

    ftp_client.remove_files(ftp_path, local_files)
    print_str '-----> Cleaned %s on %s' % [ftp_path, ftp_host]
  end
end
