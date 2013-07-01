require 'rake/contrib/ftptools'

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
# Renames local files location, you can use wildcards
# Defaults to: public/**/8

set_default :ftp_from_path, 'public/**/*'

# ### s3
# Sets the s3 connection object

set_default :ftp, proc{
  _ftp = Rake::FtpUploader.connect(ftp_path, ftp_host, ftp_username, ftp_password)
  _ftp.verbose = verbose_mode?
  _ftp
}

# ## Deploy tasks
# These tasks are meant to be invoked inside deploy scripts, not invoked on
# their own.

namespace 'ftp' do
  # ### ftp:deploy
  # Starts a deploy to FTP server
  desc 'Starts a deploy to FTP server'
  task :deploy do
    print_str '-----> Starting FTP deployment'
    ftp.upload_files(ftp_from_path)
  end

  # ### aws:s3:empty
  # Empties bucket of any files
  desc 'Empty the FTP path'
  task :empty do
    print_str '-----> Cleaned %s' % ftp_path
  end
end
