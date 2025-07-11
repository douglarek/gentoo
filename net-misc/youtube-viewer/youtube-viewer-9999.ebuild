# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DIST_TEST="do"
inherit desktop optfeature perl-module git-r3 xdg-utils

DESCRIPTION="A command line utility for viewing youtube-videos in Mplayer"
HOMEPAGE="https://github.com/trizen/youtube-viewer"
SRC_URI=""
EGIT_REPO_URI="https://github.com/trizen/${PN}.git"

LICENSE="|| ( Artistic-2 GPL-1+ )"
SLOT="0"
KEYWORDS=""
IUSE="gtk"

RDEPEND="
	dev-perl/Data-Dump
	dev-perl/JSON
	dev-perl/libwww-perl[ssl]
	dev-perl/LWP-Protocol-https
	dev-perl/Term-ReadLine-Gnu
	gtk? (
		dev-perl/Gtk3
		dev-perl/File-ShareDir
		virtual/freedesktop-icon-theme
		x11-libs/gdk-pixbuf:2[jpeg]
	)
	|| ( media-video/ffmpeg[openssl] media-video/ffmpeg[gnutls] )
	|| ( media-video/mpv media-video/mplayer media-video/vlc gtk? ( media-video/smplayer ) )"
DEPEND="${RDEPEND}"
BDEPEND="dev-perl/Module-Build"

src_configure() {
	local myconf
	if use gtk; then
		myconf="--gtk3"
	fi

	perl-module_src_configure
}

src_install() {
	perl-module_src_install

	if use gtk; then
		domenu share/gtk-youtube-viewer.desktop
		doicon share/icons/gtk-youtube-viewer.png
	fi
}

pkg_postinst() {
	use gtk && xdg_icon_cache_update
	optfeature "local cache support" dev-perl/LWP-UserAgent-Cached
	optfeature "faster JSON to HASH conversion" dev-perl/JSON-XS
	optfeature "printing results in a fixed-width format (--fixed-width, -W)" dev-perl/Text-CharWidth
	optfeature "live streams support" net-misc/yt-dlp
	elog
	elog "Check the configuration file in ~/.config/youtube-viewer/"
	elog "and configure your video player backend."
}

pkg_postrm() {
	use gtk && xdg_icon_cache_update
}
