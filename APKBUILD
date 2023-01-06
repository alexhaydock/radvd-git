# Contributor: Natanael Copa <ncopa@alpinelinux.org>
# Maintainer: Natanael Copa <ncopa@alpinelinux.org>
pkgname=radvd
pkgver=9000
pkgrel=1
pkgdesc="IPv6 router advertisement daemon"
url="http://www.litech.org/radvd"
arch="all"
license="BSD with advertising"
makedepends="flex bison libdaemon-dev linux-headers check-dev libbsd-dev autoconf automake"
install="$pkgname.pre-install"
subpackages="$pkgname-doc $pkgname-openrc"
source="radvd-git-548271773fe66dd7b636071faa196a4bc0ef256d.tar.gz
	radvd.initd
	radvd.confd
	"

# test failure on builders due to kernel issue
case "$CARCH" in
mips*)	options="!check";;
esac

build() {
	./autogen.sh
	./configure \
		--build=$CBUILD \
		--host=$CHOST \
		--prefix=/usr \
		--sysconfdir=/etc/ \
		--with-check \
		--with-pidfile=/run/radvd/radvd.pid
	# work around parallel build issue
	make gram.h && make
}

check() {
	make -C "$builddir" check
}

package() {
	make -j1 DESTDIR="$pkgdir" install
	install -Dm755 "$srcdir"/radvd.initd "$pkgdir"/etc/init.d/radvd
	install -Dm644 "$srcdir"/radvd.confd "$pkgdir"/etc/conf.d/radvd
	install -Dm644 radvd.conf.example \
		"$pkgdir"/usr/share/doc/radvd/radvd.conf.example
}

sha512sums="
20ff1e1a7543a5cf46607d89d7a9b4548c53107ac184326fe52ed0f0a2538cc2eb4b7fd15acc6cffa124eb24d184695937d0498044f9ae321d385aab57c3041a  radvd-git-548271773fe66dd7b636071faa196a4bc0ef256d.tar.gz
fd78249b8ae25d1c55fc0b5cc2b3dd202388c0ca7be2737ecbd33ed5cd3c8616858aa46350967350fe8e8c0032552126918c8b9c36b13d799f3c5d8fb576fdf8  radvd.initd
31cca1d48e5f0c4fe96a7a32ca6339e7aa9e478f7e9086f05bbc79ca59b1637d99e46079d7be77ef717a8fb975fada7664058e3bc61117309025b72f3e87d294  radvd.confd
"
