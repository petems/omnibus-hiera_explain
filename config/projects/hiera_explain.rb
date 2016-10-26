name 'hiera_explain'
maintainer 'Peter Souter <root@localhost>'
homepage 'https://github.com/petems/omnibus-hiera_explain'
description 'A tool for explaining hiera'

install_dir     '/opt/hiera_explain'
build_version   "0.0.3"
build_iteration 1

override :rubygems, :version => '2.4.4'
## WARN: do not forget to change RUBY_VERSION in the postinst script
##       when switching to a new minor version
override :ruby, :version => '2.1.5'

# creates required build directories
dependency 'preparation'

dependency 'patch'

# hiera_explain dependencies/components
dependency 'hiera_explain'

# version manifest file
dependency 'version-manifest'

# tweaking package-specific options
package :deb do
  license 'Apache'
end

package :rpm do
  license 'Apache'
end

exclude '\.git*'
exclude 'bundler\/git'
