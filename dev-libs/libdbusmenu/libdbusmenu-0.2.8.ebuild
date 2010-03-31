# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libindicate/libindicate-0.2.3-r1.ebuild,v 1.2 2010/02/16 17:15:10 josejx Exp $

EAPI=2

inherit autotools eutils versionator

DESCRIPTION="Library to pass menu structure across DBus"
HOMEPAGE="https://launchpad.net/libdbusmenu/"
SRC_URI="http://launchpad.net/dbusmenu/$(get_version_component_range 1-2)/${PV}/+download/${P}.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="gtk test"

RESTRICT="test"

RDEPEND="dev-libs/glib:2
	dev-libs/dbus-glib
	dev-libs/libxml2:2
	gtk? ( x11-libs/gtk+:2 )"
DEPEND="${RDEPEND}
	test? ( dev-libs/json-glib )
	dev-util/pkgconfig"

src_prepare() {
	# Make libdbusmenu-gtk library optional
	epatch "${FILESDIR}/${P}-1-optional-gtk.patch"
	# Make tests optional
	epatch "${FILESDIR}/${P}-2-optional-tests.patch"
	# Fixup undeclared HAVE_INTROSPECTION
	epatch "${FILESDIR}/${P}-no-gobject-introspection.patch"
	# Drop -Werror in a release
	sed -e 's:-Werror::g' -i libdbusmenu-glib/Makefile.am libdbusmenu-gtk/Makefile.am || die "sed failed"
	eautoreconf
}

src_configure() {
	econf \
		$(use_enable gtk) \
		$(use_enable test tests)
}

src_test() {
	emake check || die "testsuite failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS || die "dodoc failed"
}
