# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools cmake git-r3

DESCRIPTION="Freescale/NXP I.MX Chip Image Deploy Tool"
HOMEPAGE="https://github.com/nxp-imx/mfgtools"

# JRG: Special version numbers to access specific branches or patch sets.
case "${PV}" in
	# Head of master branch. This is a Gentoo convention.
	9999)
		MY_PV="${PV}"
		MY_P="${PN}-${MY_PV}"
		EGIT_REPO_URI="https://github.com/nxp-imx/mfgtools.git"
		;;
	# My local research branch.
	#9997)
	#	MY_PV="${PV}"
	#	MY_P="${PN}-${MY_PV}"
	#	EGIT_REPO_URI="https://github.com/nxp-imx/mfgtools.git"
	#	REFS="refs/heads/semaphores"
	#	;;
	# Normal upstream tarball releases.
	*)
		MY_PV="{$PV}"
		MY_P="${PN}-${MY_PV}"
		SRC_URI="https://github.com/nxp-imx/mfgtools/releases/download/uuu_${PV}/uuu_source-uuu_${PV}.tar.gz"
		KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~hppa ~loong ~mips ~ppc ~ppc64 ~riscv ~sparc ~x86"
		;;
esac

S="${WORKDIR}"/${PN}-${MY_PV}

LICENSE="BSD-3"
SLOT="0"
IUSE="doc"

BDEPEND="
	>=dev-build/cmake-4
	doc ? (
		app-text/doxygen
	)

src_unpack() {
	case "${MY_PV}" in
		9999|9998|9997)
			git-r3_fetch ${EGIT_REPO_URI} ${REFS} ${TAG}
			git-r3_checkout ${EGIT_REPO_URI} "${WORKDIR}/${MY_P}" ${TAG}
			;;
		*)
			default
			;;
	esac
}

