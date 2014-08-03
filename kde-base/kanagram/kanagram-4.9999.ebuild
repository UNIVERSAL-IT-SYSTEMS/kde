# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

KDE_HANDBOOK="optional"
inherit kde4-base

DESCRIPTION="KDE: letter order game"
HOMEPAGE="http://www.kde.org/applications/education/kanagram
http://edu.kde.org/kanagram"
KEYWORDS=""
IUSE="debug"

DEPEND="
	$(add_kdebase_dep libkdeedu)
"
RDEPEND=${DEPEND}
