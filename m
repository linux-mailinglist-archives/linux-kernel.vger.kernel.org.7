Return-Path: <linux-kernel+bounces-805042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A5EB7B4835A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 06:48:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71BE3189B3D6
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 04:49:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED5C4221FC6;
	Mon,  8 Sep 2025 04:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="U04buDR1"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E6BB1A9F8E;
	Mon,  8 Sep 2025 04:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757306917; cv=none; b=Mk7tEhrhGeuIJt7BYjnHmaHKe1aiBw3Bln5TBjwEKzMxvSgD/zJCFxjSX2aEOusUugmYvXzTquax3QfBuAmrUrsvAsqIQe1vrKSOg3UeOGE969Eg3eV7UXYaI4kvYkXGXjCo1hSayTM+aHfk2Ni0IVw39KStcujs+6MZKn4RpiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757306917; c=relaxed/simple;
	bh=xyczcj/f4xTSp3rsCWVXfqK6JYw57bDuOtJnu9vdKtM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MwGgoMDK5+6NqQjkvpbieHNi9ztS1rEpVc6pWnZSvDRgXI98vQz7imciYZT3Q/dDXTIt6oZaxFUnMXc0TTWZaazFW/PlnefGi+aViCr+0PEzQKc0ih4iDErxrUpDaorcsC4/371VpyCqSBQPqrOC0wGhhWuMFRz1JDRmfdnCgGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au; spf=pass smtp.mailfrom=gandalf.ozlabs.org; dkim=pass (2048-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b=U04buDR1; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gandalf.ozlabs.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=gibson.dropbear.id.au; s=202508; t=1757306913;
	bh=WpNuMYaWDnzAYqz8DBCICsrWkF8LCMjDwlbbnFrA97s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U04buDR11gnVEFQb3nmhHb/Lbx+rWbX2EXUFZkv/79M5/UQncnl+r1TlrCghkQcPP
	 7g80uwmBbRoUdyHHJiCrM9BGDSVfSefqB15oNPO28f9+dPvhnujSQEL9P8vUexwKpl
	 eeq+hL0QuAQYejsTyS91910twRi41mMAws8/SQGUVTYa1a0Kq4d9VK9pEQi770GYK2
	 sSWoNZRurcq0DKtvqgfg5cFSrAo2YZDMAJOl2VtRJyd7nnKOnAAxoDq4QyTghewkwD
	 s523J6NCrqmjAQDC+RHsL8JX3XpfuIRwKs4HHkceDyiiRTc5SAzz5qKJj0k+w5ycO8
	 4kLNUbO/8XiGg==
Received: by gandalf.ozlabs.org (Postfix, from userid 1007)
	id 4cKvbj1mYZz4w9q; Mon,  8 Sep 2025 14:48:33 +1000 (AEST)
Date: Mon, 8 Sep 2025 14:48:25 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Ayush Singh <ayush@beagleboard.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
	Herve Codina <herve.codina@bootlin.com>, Andrew Davis <afd@ti.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Saravana Kannan <saravanak@google.com>, devicetree@vger.kernel.org,
	devicetree-compiler@vger.kernel.org, linux-kernel@vger.kernel.org,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v2 1/7] dt-bindings: Add support for export-symbols node
Message-ID: <aL5gGRlnbVuAQk-t@zatzit>
References: <20250528185740.4bf91bef@bootlin.com>
 <49e1e1fc-412d-4334-8337-16e352a34788@kernel.org>
 <20250618113232.6d237208@bootlin.com>
 <ed6beb97-12f1-4d71-b4dc-b34d4d611b81@beagleboard.org>
 <3ff4b3f9-cc8d-4044-b2eb-33010d8951c0@kernel.org>
 <3889e19e-7f1e-4306-9e11-77a61432b402@beagleboard.org>
 <f3184805-3617-4b46-be23-70cebcf27207@kernel.org>
 <1884651f-5192-4fd4-9d94-ed755ea89570@beagleboard.org>
 <CAL_JsqLSB=6FduyOE_JNRdy=Uf6dLOcHV-O4qa8psjCobJPaAQ@mail.gmail.com>
 <ef7720ae-bada-4133-a685-d277cd4aa7e6@beagleboard.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="YQA0bZoq72P3ar0W"
Content-Disposition: inline
In-Reply-To: <ef7720ae-bada-4133-a685-d277cd4aa7e6@beagleboard.org>


--YQA0bZoq72P3ar0W
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 18, 2025 at 11:07:57PM +0530, Ayush Singh wrote:
>=20
> On 8/18/25 22:35, Rob Herring wrote:
> > On Sun, Aug 17, 2025 at 3:42=E2=80=AFAM Ayush Singh <ayush@beagleboard.=
org> wrote:
> > > On 8/17/25 13:52, Krzysztof Kozlowski wrote:
> > >=20
> > > > On 17/08/2025 10:18, Ayush Singh wrote:
> > > > > > > > Hardware:
> > > > > > > >       i2c0 from SoC --------- connector 1, I2C A signals
> > > > > > > >       i2c1 from SoC --------- connector 1, I2C B signals
> > > > > > > >=20
> > > > > > > >       connector1 {
> > > > > > > >           export-symbols {
> > > > > > > >      i2c_a =3D <&i2c0>;
> > > > > > > >      i2c_b =3D <&i2c1>;
> > > > > > > >           };
> > > > > > > >       };
> > > > > > > >=20
> > > > > > > > In order to avoid the coding style issue, this could be rep=
lace
> > > > > > > > with:
> > > > > > > >      connector1 {
> > > > > > > >           export-symbols {
> > > > > > > >      symbol-names =3D "i2c_a", "i2c_b";
> > > > > > > >      symbols =3D <&i2c0>, <&i2c1>;
> > > > > > > >           };
> > > > > > > >       };
> > > > > > > >=20
> > > > > > > > Krzysztof, Rob, do you think this could be accepted ?
> > > > > > > >=20
> > > > > > > > Ayush, David, do you thing this could be easily implemented=
 in fdtoverlay ?
> > > > > > > >=20
> > > > > > > > Best regards,
> > > > > > > > Herv=C3=A9
> > > > > > > >=20
> > > > > > > Well, it is possible.
> > > > > > >=20
> > > > > > > However, on connectors like pb2 header, there will be 50-100 =
export
> > > > > > > symbols. So it will start becoming difficult to maintain.
> > > > > > And the first syntax solves this how? I don't see the practical=
 difference.
> > > > > Well, I was more worried about matching which phandle belongs to =
which
> > > > > symbol easily. Let us assume that 2 symbols will be in each line =
(after
> > > > > accounting for the indention and 80 char limit) and we have 70 sy=
mbols,
> > > > > so 35 lines. To check which phandle belongs to the 2nd symbol on =
line
> > > > > 25th line of  symbol-names, well, you would at the best case need=
 to
> > > > > have something like relative line numbers in your editor. Then yo=
u know
> > > > > that the 35th line from the current one is where you need to look.
> > > > >=20
> > > > > In the current syntax, the symbol name and phandle are on the sam=
e line.
> > > > > So well, easy to see which symbols refers to which phandle.
> > > > OK, that's valid point. Any ideas how to solve it without introduci=
ng
> > > > underscores for properties?
> > > >=20
> > > > Best regards,
> > > > Krzysztof
> > >=20
> > > Well, we can modify `get_phandle_from_symbols_node` to allow matching
> > > `*_*` to `*-*`. And we can do the same in devicetree easily enough. N=
ot
> > > sure if implicit loose matching like that are the best idea.
> > >=20
> > > Zephyr does something similar for compatible strings. It pretty much
> > > replaces the all non alphanumeric characters with `_` in compatible
> > > string match. Although that is more to do with the limitation they are
> > > working with, i.e. the devicetree being converted to static headers
> > > instead of being runtime thing.
> > This is just going from bad to worse... If there's a real need to use
> > underscores, then use underscores. But that's all beside the point. I
> > didn't like v1 and nothing has changed in v2 to change that.
> >=20
> > This looks like continuing down the path of working around DTB format
> > limitations like DT overlays originally did (which both David (IIRC)
> > and I think was a mistake). But now instead of somewhat hidden,
> > generated data, you're adding manually written/maintained data. I
> > don't have any suggestion currently how to avoid that other than we
> > need to rev the DTB format which no one really wants to hear. Maybe
> > there's some other solution, but I don't have one ATM.
> >=20
> > Rob
>=20
> Well, if anyone decides to do a v2 of DTB, I would love to help in any wa=
y I
> can.

We're already on v17 of DTB (although only 5 of those version numbers
were actually used).

It shouldn't actually be that hard to extend it in a number of ways
without having to completely redefine it.

--=20
David Gibson (he or they)	| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you, not the other way
				| around.
http://www.ozlabs.org/~dgibson

--YQA0bZoq72P3ar0W
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEO+dNsU4E3yXUXRK2zQJF27ox2GcFAmi+YBgACgkQzQJF27ox
2GdgmQ/9Hce0ZQqvS0Bpdmg2MoNiJVf+NfvaqU/D2zjpHVLSI+9AOSLmZYPMaMdZ
QLhnEDgpNyR8YXlfv+9oW/VvWvOJv2n+qFf3a+77DNC1vO57OOuJghyl/05Gsd2l
Mfy8b/sdYO4ek4dA8qFnKKWuZBvwoti+tIzul+74LwSwXSSzs8hgVBDa377WUIN7
bOmYPuvvPk6Tys0kC962QmeyDPtiUlYAaHt+vfbXZ92RfOdmb1/Xibrjux5HDUOr
rVok6KTKA1E6IKPtWqzleaqqbateFCKLOLWxkS8NvdI9hVzrRovIEa1pT+pjoeBS
suXA0/VZ7q3I32JgrogoaISKp2AhuDN2LULICezVgbnfQIs6s//tUfkyannGhVTY
5mqNuoY3xQHmlPfNR8Og0kaw1SUGkTTXElyFL5h2RDYTmT+7+1C6Iy1wI9siFV/E
sKOV69iqnGiK52HxkHNrFOAGn32eKkUwSbNXSSm64GaOaxcodTuHs/B5KgznhGMB
RAbtHZXmT8k8r0FgIRdTIULyAsjQS8WzY7smJ6qT4TvIzGuX6EvSeXzFXrJOzjNi
FqhmEwuiEByw6QGjiC2QJPPo4bo55mHrDhGVrlC9E5Yh/gnRYd/9zNRf49NtClgs
yphjmNPcyNOtcKe4y7mpOrDkNcVW/q7Qf7Kdefwc9j8x22ZK58g=
=5LwX
-----END PGP SIGNATURE-----

--YQA0bZoq72P3ar0W--

