# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
USE_RUBY="ruby31 ruby32 ruby33 ruby34"

RUBY_FAKEGEM_EXTRADOC="README.md"

RUBY_FAKEGEM_RECIPE_TEST="rspec3"

inherit ruby-fakegem

DESCRIPTION="Gives objects the ability to 'histogram' in several useful ways"
HOMEPAGE="https://github.com/jtprince/histogram"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 x86"

ruby_add_bdepend "test? ( dev-ruby/narray )"

all_ruby_prepare() {
	sed -i -e '/simplecov/I s:^:#:' spec/spec_helper.rb || die
}
