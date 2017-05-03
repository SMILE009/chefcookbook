name 'my-rails-app'
maintainer 'SSA Studeent'
maintainer_email 'lv-229@ssa.lviv.ua'
license 'All Rights Reserved'
description 'Installs/Configures my-rails-app'
long_description 'Installs/Configures my-rails-app'
version '0.1.0'
chef_version '>= 12.1' if respond_to?(:chef_version)

# The `issues_url` points to the location where issues for this cookbook are
# tracked.  A `View Issues` link will be displayed on this cookbook's page when
# uploaded to a Supermarket.
#
# issues_url 'https://github.com/<insert_org_here>/my-rails-app/issues'

# The `source_url` points to the development reposiory for this cookbook.  A
# `View Source` link will be displayed on this cookbook's page when uploaded to
# a Supermarket.
#
# source_url 'https://github.com/<insert_org_here>/my-rails-app'

depends "git"
depends "ntp"
depends "database"
depends "postgresql"
depends "yum-epel"
depends "user"
depends "application_ruby"
