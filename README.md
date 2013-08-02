# FTP support for Mina

You can use mina now to deploy static websites to FTP servers.

## Installation

Add this line to your application's Gemfile:

    gem 'mina-ftp'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install mina-ftp

## Usage

Use mina to generate the config file:

    $ bundle exec mina init

Load the FTP tasks:

```ruby
require 'mina/ftp'
```

Add some settings to the `config/deploy.rb` or to `Minafile` file.

```ruby
set :ftp_path, 'public_www'
set :ftp_host, 'ftp.domain.com'
set :ftp_username, 'user@domain.com'
set :ftp_password, 'secret'
set :ftp_from_path, 'public'
set :ftp_options, {:passive => false}
```

Update `deploy` task to invoke `ftp:deploy` task:

```ruby
task :deploy do
  invoke :'ftp:deploy'
end
```

Deploy it!

    $ bundle exec mina deploy

Use `--verbose` flag if you want to see FTP client calls.

To clear the remote path, use the `ftp:empty` task:

    $ bundle exec mina ftp:empty

Thats it.

## Todo

Write some tests.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Thanks and credits

This gem uses [ftp_sync](https://github.com/jebw/ftp_sync) gem.

Huge thanks to [mina](https://github.com/nadarei/mina) developers for the awesome tool.
