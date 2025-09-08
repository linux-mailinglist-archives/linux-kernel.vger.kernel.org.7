Return-Path: <linux-kernel+bounces-805040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3758DB48358
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 06:48:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0C2517AC62
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 04:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBC1C221F0A;
	Mon,  8 Sep 2025 04:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="EW8htYu/"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E66213FD86;
	Mon,  8 Sep 2025 04:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757306917; cv=none; b=p6u5RUJKGMB82JOSUb1sk3YSEMPXA3672EI3o9ebOOaaST4QSXSRs6DJfC2SnbfvOnkb6h8tHyKp7VZe0tsD2dfUZKXNN44IjPQWw5vCtdV2IybNMiZsUPPPzpOIFzV1VA+EpsS7SA+p+WIdVyfJ1OKgAiVb00fdb4OMpMtyrJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757306917; c=relaxed/simple;
	bh=+1D4oypWCWAbjR3sfEarTSWXW1pVYBiLLFqoIVxXxSk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=he/Ni72N9OWc+lcAaGP/GfJTJwlOhbZSWNF6XGL3wdnfoFTPPmRXgrSaVNTle+ko8dHk2jESb3ESQGv/yo0b5RMCLs2jrILsADEnoYYvw9V+cxzrtv4Gsnx3zXo8osl9R+eI2p/mwOjhOTlPJDH1M4XdSLgj8JUtsv/3kRog/jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au; spf=pass smtp.mailfrom=gandalf.ozlabs.org; dkim=pass (2048-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b=EW8htYu/; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gandalf.ozlabs.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=gibson.dropbear.id.au; s=202508; t=1757306913;
	bh=csrWA1tFnpxAqFt9BGDAiq9GlOI3lsikdAk/U1LeBxc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EW8htYu/lw4Ly14VElmWpeogLdrze02j371iiGiv9MN7zpT/Ss2ds7kgIfou/lKsX
	 lST6Is/AApkfSWrM4fnIKOKbSu2QnHeVK0GUQbCLCjxSpNo+mu8Poh1L2IeVW0DCDl
	 +Fs7a9pQGvsHl0BYz44b+kduLoTBl5E4wcHME1KPG6wtjoYmBdt7YAqqMgn/V3I+0Q
	 w2go4uV7XugtHo8l843zgKDUasE470MpEYOGNU8EhtEkb23kLXbR8+OQsGzJnNAjAZ
	 P2H4GqIqWUkAf6B0/f/zdFbXShXhCMmvAau7sE5vfan0SKFg7TPSNMVWsUEJNmALa4
	 5lEGNEIt7iKjw==
Received: by gandalf.ozlabs.org (Postfix, from userid 1007)
	id 4cKvbj1Ywkz4w9Q; Mon,  8 Sep 2025 14:48:33 +1000 (AEST)
Date: Mon, 8 Sep 2025 14:46:15 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Ayush Singh <ayush@beagleboard.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
	Herve Codina <herve.codina@bootlin.com>,
	Rob Herring <robh@kernel.org>, Andrew Davis <afd@ti.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Saravana Kannan <saravanak@google.com>, devicetree@vger.kernel.org,
	devicetree-compiler@vger.kernel.org, linux-kernel@vger.kernel.org,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v2 1/7] dt-bindings: Add support for export-symbols node
Message-ID: <aL5fl0GhUdZbIZA3@zatzit>
References: <20250430125154.195498-2-herve.codina@bootlin.com>
 <0770a47e-fd2f-4b6f-9a9a-b0d539ace30c@kernel.org>
 <20250528185740.4bf91bef@bootlin.com>
 <49e1e1fc-412d-4334-8337-16e352a34788@kernel.org>
 <20250618113232.6d237208@bootlin.com>
 <ed6beb97-12f1-4d71-b4dc-b34d4d611b81@beagleboard.org>
 <3ff4b3f9-cc8d-4044-b2eb-33010d8951c0@kernel.org>
 <3889e19e-7f1e-4306-9e11-77a61432b402@beagleboard.org>
 <f3184805-3617-4b46-be23-70cebcf27207@kernel.org>
 <1884651f-5192-4fd4-9d94-ed755ea89570@beagleboard.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="aGlrxXj1kT7FPSEL"
Content-Disposition: inline
In-Reply-To: <1884651f-5192-4fd4-9d94-ed755ea89570@beagleboard.org>


--aGlrxXj1kT7FPSEL
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 17, 2025 at 02:12:28PM +0530, Ayush Singh wrote:
> On 8/17/25 13:52, Krzysztof Kozlowski wrote:
>=20
> > On 17/08/2025 10:18, Ayush Singh wrote:
> > > > > > Hardware:
> > > > > >      i2c0 from SoC --------- connector 1, I2C A signals
> > > > > >      i2c1 from SoC --------- connector 1, I2C B signals
> > > > > >=20
> > > > > >      connector1 {
> > > > > >          export-symbols {
> > > > > > 	  i2c_a =3D <&i2c0>;
> > > > > > 	  i2c_b =3D <&i2c1>;
> > > > > >          };
> > > > > >      };
> > > > > >=20
> > > > > > In order to avoid the coding style issue, this could be replace
> > > > > > with:
> > > > > >     connector1 {
> > > > > >          export-symbols {
> > > > > > 	  symbol-names =3D "i2c_a", "i2c_b";
> > > > > > 	  symbols =3D <&i2c0>, <&i2c1>;
> > > > > >          };
> > > > > >      };
> > > > > >=20
> > > > > > Krzysztof, Rob, do you think this could be accepted ?
> > > > > >=20
> > > > > > Ayush, David, do you thing this could be easily implemented in =
fdtoverlay ?
> > > > > >=20
> > > > > > Best regards,
> > > > > > Herv=E9
> > > > > >=20
> > > > > Well, it is possible.
> > > > >=20
> > > > > However, on connectors like pb2 header, there will be 50-100 expo=
rt
> > > > > symbols. So it will start becoming difficult to maintain.
> > > > And the first syntax solves this how? I don't see the practical dif=
ference.
> > >=20
> > > Well, I was more worried about matching which phandle belongs to which
> > > symbol easily. Let us assume that 2 symbols will be in each line (aft=
er
> > > accounting for the indention and 80 char limit) and we have 70 symbol=
s,
> > > so 35 lines. To check which phandle belongs to the 2nd symbol on line
> > > 25th line of=A0 symbol-names, well, you would at the best case need to
> > > have something like relative line numbers in your editor. Then you kn=
ow
> > > that the 35th line from the current one is where you need to look.
> > >=20
> > > In the current syntax, the symbol name and phandle are on the same li=
ne.
> > > So well, easy to see which symbols refers to which phandle.
> > OK, that's valid point. Any ideas how to solve it without introducing
> > underscores for properties?
> >=20
> > Best regards,
> > Krzysztof
>=20
>=20
> Well, we can modify `get_phandle_from_symbols_node` to allow matching `*_=
*`
> to `*-*`. And we can do the same in devicetree easily enough. Not sure if
> implicit loose matching like that are the best idea.
>=20
> Zephyr does something similar for compatible strings. It pretty much
> replaces the all non alphanumeric characters with `_` in compatible string
> match. Although that is more to do with the limitation they are working
> with, i.e. the devicetree being converted to static headers instead of be=
ing
> runtime thing.

This is another reason to consider doing this in a new out-of-band
extension to dtb, rather than as "regular" device tree properties.  In
that case you can redefine your naming conventions to suit your needs.

--=20
David Gibson (he or they)	| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you, not the other way
				| around.
http://www.ozlabs.org/~dgibson

--aGlrxXj1kT7FPSEL
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEO+dNsU4E3yXUXRK2zQJF27ox2GcFAmi+X5YACgkQzQJF27ox
2GeSqg//Tk8PVUzmeMbmFytewbXAgmHQTkPwUmS8TtF2DFIKfoc0aP36SAalDUSR
sGu9TrxB9tvxjuHOMOP3B/AOuNqs9L0UbGyX6pjYFrFzhOEh/8TJnob/AZf6+xr7
EbtUcEIphDRdgcwor6JJUxfAjKj7mMUXO5ELcf3evN/vNH4iwKIDC1XKxC68K6gY
mFfea4PUZM170j2Nt5lhdnCrFiuirJu5lxWhwaOHmwyi0HmMMHKiuHsWd1gAEVUJ
Jhhy6nuZAvPGUSiREw3nRKks/njCvDPnmfOTH2mb2A/JW9LOEpAerSkenudeaX1x
IiRkaC1k66+9icQ6NnG9ikbbQRFHky9ZDH+7CIMFL5vvB6bMgoX+CQNx8KIzayaw
GDXrAgByahJEWEMjsoLJtuy7Rano42I7BGBAHHrB8CgLfKQmY6sn9zTZAV9u2+Hj
eQg+TIDvsDoeS2Y4Bz5a8o+fVtQ9ynV7PJxIM15uZQ9+y76BPzx1Q9TK2J29d6yr
So8kUFYnEXJQE8BcIEt2gr2QrZHtCO0biMzQ31nxfMGsLLiNHdUUKDV573VlyVr4
ycMzxhvbMQ8Q0trpc2oztmmTw4TFTeNXjwzfDIfNp6i+sDG3lfOa727z/+rkBIb/
rpnatSRzwstS2FxO9t7EGdPuQzg8LDNEDFYwEoxUYdqiowCRmZA=
=71QT
-----END PGP SIGNATURE-----

--aGlrxXj1kT7FPSEL--

