TERMUX_PKG_HOMEPAGE=http://serf.apache.org/
TERMUX_PKG_DESCRIPTION="High performance C-based HTTP client library"
TERMUX_PKG_VERSION=1.3.9
TERMUX_PKG_REVISION=1
TERMUX_PKG_SRCURL=https://archive.apache.org/dist/serf/serf-${TERMUX_PKG_VERSION}.tar.bz2
TERMUX_PKG_SHA256=549c2d21c577a8a9c0450facb5cca809f26591f048e466552240947bdf7a87cc
TERMUX_PKG_DEPENDS="apr-util, openssl"
TERMUX_PKG_BUILD_IN_SRC=yes

termux_step_make_install () {
	scons APR=$TERMUX_DESTDIR/usr \
	      APU=$TERMUX_DESTDIR/usr \
	      CC=`which $CC` \
	      CFLAGS="$CFLAGS" \
	      CPPFLAGS="$CPPFLAGS -std=c11" \
	      LINKFLAGS="$LDFLAGS" \
	      OPENSSL=$TERMUX_DESTDIR/usr \
	      PREFIX=$TERMUX_DESTDIR/usr \
	      install
	# Avoid specifying -lcrypt:
	perl -p -i -e 's/-lcrypt //' $TERMUX_DESTDIR/usr/lib/pkgconfig/serf-1.pc
}
