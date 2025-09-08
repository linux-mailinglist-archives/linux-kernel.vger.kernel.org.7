Return-Path: <linux-kernel+bounces-805041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C24FB48359
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 06:48:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7C94189B92B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 04:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBD07221F12;
	Mon,  8 Sep 2025 04:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="Agc+0ozc"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E66E5315D3A;
	Mon,  8 Sep 2025 04:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757306917; cv=none; b=emrOOjwHUPnNCPUvkaw2RNYcJt/M5yjDKkSW3o0+TeGpppzXcUs/MvwSF1m/PPwJwznVVLywpYEP+bwYngJ1q4A+FZ+nqWouxLRjN9MY4SA/B1uc2d7R4VaEpxshDIljkDo+99gRj624PXHF2CZZqwMpWLY0BXwrrPQbo/euAA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757306917; c=relaxed/simple;
	bh=qe1egGHiDFhYZp34CXk3Kh7cXuUFvPwViqVvCNhwWA8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OHfP8vEbAUeOVKNz8rkT9xF+EfxfPTwSoEAgf0fQr+3m384uDw3eMgGcnTT5glxcPr7ANrmctYi9inQLEWgMk88wcq6uDKJYiN0zUVgefuyPvzO+qhw8JOyUSd0j+WIBdsv6JBNLsQN1ZrIOzJcjFT5o+n1fhj1c1zEyGdGCy5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au; spf=pass smtp.mailfrom=gandalf.ozlabs.org; dkim=pass (2048-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b=Agc+0ozc; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gandalf.ozlabs.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=gibson.dropbear.id.au; s=202508; t=1757306913;
	bh=Shd+L6Rly4iMYuh7X9SKd1//igUWGeucXOjmao0ByuE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Agc+0ozcB3gHMLyXa09Hpt7V2mU1Z9SAd6V4kwasvEzd2xtW+KJ/nezd0fx1K+1sO
	 03RPoC1bUjGzCB0q0PLHNashrLGdQkOWto+RXKTLd+sezolae5msVatzjBkX+Le2/t
	 yqJpjSWd0ALy35DzHeNTuPRvWN6bqBN8s6hugXy177ZBVSVPZltQrH+Jv6kI+5mald
	 wB4FxVfVhR9oN2jA7Y66JZmVtK9W8jnVI3R887+6igAEtME4h2qvVmOnx0iKh/6j8x
	 oZjtRWHepLhy1pPrJP9ZGmVJLGR9sxGfSu46UgIgVRt+cHDoTcNnV15AXmEOJxxWp8
	 BvFiybTVC2yww==
Received: by gandalf.ozlabs.org (Postfix, from userid 1007)
	id 4cKvbj1L1zz4w9d; Mon,  8 Sep 2025 14:48:33 +1000 (AEST)
Date: Mon, 8 Sep 2025 14:44:03 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Ayush Singh <ayush@beagleboard.org>
Cc: Herve Codina <herve.codina@bootlin.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
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
Message-ID: <aL5fEzN2S058oSAI@zatzit>
References: <20250430125154.195498-1-herve.codina@bootlin.com>
 <20250430125154.195498-2-herve.codina@bootlin.com>
 <0770a47e-fd2f-4b6f-9a9a-b0d539ace30c@kernel.org>
 <20250528185740.4bf91bef@bootlin.com>
 <49e1e1fc-412d-4334-8337-16e352a34788@kernel.org>
 <20250618113232.6d237208@bootlin.com>
 <ed6beb97-12f1-4d71-b4dc-b34d4d611b81@beagleboard.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="JcAS3yuewG0Rf+lr"
Content-Disposition: inline
In-Reply-To: <ed6beb97-12f1-4d71-b4dc-b34d4d611b81@beagleboard.org>


--JcAS3yuewG0Rf+lr
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 18, 2025 at 03:24:07PM +0530, Ayush Singh wrote:
>=20
> On 6/18/25 15:02, Herve Codina wrote:
> > Hi Krzysztof,
> >=20
> > On Wed, 4 Jun 2025 20:35:51 +0200
> > Krzysztof Kozlowski <krzk@kernel.org> wrote:
> >=20
> > ...
> >=20
> > > > Symbols are exported only when an overlay is applied on the node wh=
ere the
> > > > export-symbols node is available. Those symbols are visible only fr=
om the
> > > > overlay applied. Symbols exported thanks to export-symbols are not =
global
> > > > to the all device-tree (it is not __symbols__) but local to a node.
> > > >=20
> > > > If an overlay is applied at connector1 node, it can use the 'connec=
tor'
> > > > symbols and thanks to export-symbols, the 'connector' symbol will be
> > > > resolved to foo_connector.
> > > >=20
> > > > If the overlay is applied at connector2 node, the 'connector' symbo=
l is then
> > > > resolved to bar_connector.
> > > OK, this explains a lot. Unless I missed it, would be nice to include=
 it
> > > in binding description.
> > Sure, I will add something in the next iteration.
> >=20
> > ...
> >=20
> > > > > > +patternProperties:
> > > > > > +  "^[a-zA-Z_]?[a-zA-Z0-9_]*$":
> > > > > This messes up with coding style which I would prefer keep intact.
> > > > > Basically these properties will be using label style.
> > > > Yes, those properties remap phandles.
> > > >=20
> > > > Their names are the name of the label used from the overlay and the=
ir
> > > > values are the phandle mapped.
> > > >=20
> > > > You already have this kind properties using label style in __symbol=
s__,
> > > > __fixups__, __local_fixups__ nodes.
> > > I have them in DTB, but I don't have these in DTS. The exported-symbo=
ls
> > > would be in the DTS and that is what coding style is about.
> > >=20
> > I think export-symbols has to be in DTS.
> > Maybe it could be described in an other way in order to avoid the codin=
g style
> > issue you reported.
> >=20
> > Hardware:
> >    i2c0 from SoC --------- connector 1, I2C A signals
> >    i2c1 from SoC --------- connector 1, I2C B signals
> >=20
> >    connector1 {
> >        export-symbols {
> > 	  i2c_a =3D <&i2c0>;
> > 	  i2c_b =3D <&i2c1>;
> >        };
> >    };
> >=20
> > In order to avoid the coding style issue, this could be replace
> > with:
> >   connector1 {
> >        export-symbols {
> > 	  symbol-names =3D "i2c_a", "i2c_b";
> > 	  symbols =3D <&i2c0>, <&i2c1>;
> >        };
> >    };
> >=20
> > Krzysztof, Rob, do you think this could be accepted ?
> >=20
> > Ayush, David, do you thing this could be easily implemented in fdtoverl=
ay ?
> >=20
> > Best regards,
> > Herv=E9
> >=20
>=20
> Well, it is possible.
>=20
> However, on connectors like pb2 header, there will be 50-100 export symbo=
ls.
> So it will start becoming difficult to maintain.
>=20
> Additionally, the further away we move from __symbols__ style, the more
> difficult the implementation will become since we can currently very easi=
ly
> piggy-back on __symbols__ resolution implementation.

I think that should be a non-goal.  Current __symbols__ resolution was
a quick hack.  Design what makes sense rather than being tied to the
ugly past.

--=20
David Gibson (he or they)	| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you, not the other way
				| around.
http://www.ozlabs.org/~dgibson

--JcAS3yuewG0Rf+lr
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEO+dNsU4E3yXUXRK2zQJF27ox2GcFAmi+XxIACgkQzQJF27ox
2GeRBw//R3k0RWzq0QCFmnitALPrVvhXXVB/fSiSyqxkmkeN7zORxOWE+kuz1YUe
VbZC3hZtI+BJ5espIa8InwO+1/NhleVks8lSEJ+b/eDfNvTtAq2PbI39jRzGODOV
8XUHau+Ma+/MSSeDDZm+WWmn87EEKHH2JIfSOXRB1p+Pxv+1spD5iZDXfm5kcMPv
zQ66vCkwyiGLzy15a0NP6kXaAbMB3/vMnRmEP1iRr07PJaTrvffoTbdcpsXNByOy
nx4XndA/9yDnOgEAkSs1iBtHdjL6fEdv0a0+iAiQfQbRqsEWAtZuVXdIY+UjgKPY
rRSefxji/jcrHmq/B78XORNZ7Nb8SON32Y3y4/mUf5Brl1VQGu3f3Nui675AHHbb
1c+Jwh/LcLfER8jiJkF3zfZghL2AE6xS8Uz6lXyxKuo8a49AciihQznHAZKz/FcY
V7g9Gr140bC5Sy2D1NTBbGhnohE0kujCk8guMRljOvVbC7uYPWt1EmcVkUywQQCH
L0C61/d8wWPkDrKVZQWnE6Jc57UVVxFn/wPI3PAzuFb3W/yomj1rpZDAplIWpB5K
5rOBWTe9A6OoREjsW/+0Q8BPRKHMg7sbsqP2fCGjFzskXaqBQLXTclJpy8FkHRcD
1wMDVArGkQMSgaIsx1LG0ev0T6KRumSo5TJkD7NxmN4cC8O1Mq4=
=aIlq
-----END PGP SIGNATURE-----

--JcAS3yuewG0Rf+lr--

