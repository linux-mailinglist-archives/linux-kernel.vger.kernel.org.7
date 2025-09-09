Return-Path: <linux-kernel+bounces-807059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7D2DB49F62
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 04:48:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E4037A51E1
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 02:46:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C71902561C5;
	Tue,  9 Sep 2025 02:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="VvE3WCTc"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74B6F70830;
	Tue,  9 Sep 2025 02:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757386075; cv=none; b=WzkCJ1IxG4y8+OAGnT8E1KSL3BQPV2zWjpm67YPYdj6niPk/e66Fz4g8F2SQwyr9Oe+hOfBeRUpQczsvarIzfkmSxwlOjwXJLUxoYE7qTP/iD0F6aj/jjtiJO8xrECX1PalNHiulLHfO4+mPbqHMdBXwuv4d4Me6UIIdwFVtcEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757386075; c=relaxed/simple;
	bh=ejR9grjKWc97yGUBrV5lFsu49cLZsmuMV1SaMV0W+CM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JXQSRizc8NJu/582HlKLRvmb9dIJTto0GAFMHWfGdz590R6fcmazYmOfyDgXPF5vppOasCWy7LkOxXLlNafhU6n5Sw2vdVQOMkETfNQTtUS/VQmusHITbqDr3MKRMowxLVNXiIpeKYrpjblIQLDQRHYN3kANT9Cqy/v1hOsz2S0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au; spf=pass smtp.mailfrom=gandalf.ozlabs.org; dkim=pass (2048-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b=VvE3WCTc; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gandalf.ozlabs.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=gibson.dropbear.id.au; s=202508; t=1757386069;
	bh=9+CdsBGy4T2E0zJIcbzCDvyA+QnH9bQ4ENyn6rO8WlQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VvE3WCTct7v+aCxguHq3gqJpVVePqiabJVIongb0t81Yt+avhtQEJdlMKdvzWSnaL
	 enw9rrsRUlmde5ZtOfNcnwt8QdGo2Ls44DiD1ZOVkkJVqTar9qDZeWm5a5/B0s8XVD
	 EEaqG5IwUUhB6rFRhj9SluYm32FaUiZO+S31tSitpJgi2baoZbyeoPIiNA4PesIhvr
	 kcPTJSb+tk/+SYdBb4Bpl2vTY9tRodzOCtgfZrDbrc6VeeWT9M1jy/qOIVVSt5Y2yF
	 QxDiTaX5rRdKdGjAayqbWF06EiAeoO5wR13QyW6J7u2Aw5K2DqkVSt8Tm0d+mDXaBw
	 gEnu2HsZqgx7w==
Received: by gandalf.ozlabs.org (Postfix, from userid 1007)
	id 4cLSsx4lf4z4wB0; Tue,  9 Sep 2025 12:47:49 +1000 (AEST)
Date: Tue, 9 Sep 2025 12:44:06 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Ayush Singh <ayush@beagleboard.org>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Krzysztof Kozlowski <krzk@kernel.org>, devicetree@vger.kernel.org,
	Rob Herring <robh@kernel.org>, Jason Kridner <jkridner@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree-compiler@vger.kernel.org, linux-kernel@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Herve Codina <herve.codina@bootlin.com>, Andrew Davis <afd@ti.com>
Subject: Re: Device tree representation of (hotplug) connectors: discussion
 at ELCE
Message-ID: <aL-UdtUWAnyGOOzT@zatzit>
References: <20250902105710.00512c6d@booty>
 <aLkiNdGIXsogC6Rr@zatzit>
 <337281a8-77f9-4158-beef-ae0eda5000e4@beagleboard.org>
 <aL5dNtzwiinq_geg@zatzit>
 <CAMuHMdWmJcwy8YUqfeBT+B79a19YeW77Ms6KjNhKGY8935tTog@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="GkbB3ffqO/8m1/M2"
Content-Disposition: inline
In-Reply-To: <CAMuHMdWmJcwy8YUqfeBT+B79a19YeW77Ms6KjNhKGY8935tTog@mail.gmail.com>


--GkbB3ffqO/8m1/M2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 08, 2025 at 11:01:42AM +0200, Geert Uytterhoeven wrote:
> Hi David,
>=20
> On Mon, 8 Sept 2025 at 06:36, David Gibson <david@gibson.dropbear.id.au> =
wrote:
> > On Thu, Sep 04, 2025 at 11:15:44AM +0530, Ayush Singh wrote:
> > > I would need to wrap my head around this a bit, specially in context =
of
> > > chaining connectors. It does seem like it will still require the poin=
ts you
> > > mentioned above to be present in one form or another, i.e. some way to
> > > extend busses to different nodes/trees and connector (even a chained =
one)
> > > local symbols/aliases.
> >
> > Yes, it would still require those mappings.  I don't think chained
> > connectors introduce a lot of extra complication.  An intermediate
> > connector would need to be able to "re-export" things it got from its
> > parent connector to its child connector(s) - renaming them if
> > necessary.
>=20
> I don't expect chained connectors to be complicated.
> Boards using multiple-connectors may be more difficult, e.g.
> https://1bitsquared.de/products/pmod-hyperram

Ah.. from the link, I'm gathering you mean a peripheral which plugs
into multiple connectors on a parent board, rather than a board which
supplies multiple connectors.

That is a case I hadn't considered, which does complicate things
further.  I think the main thing that would need to be tackled here is
that the resources would need to be renamable / namespaced on the
plugin side as well as the parent board side.

--=20
David Gibson (he or they)	| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you, not the other way
				| around.
http://www.ozlabs.org/~dgibson

--GkbB3ffqO/8m1/M2
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEO+dNsU4E3yXUXRK2zQJF27ox2GcFAmi/lGkACgkQzQJF27ox
2GdQFA/+KTFDZgTVxk+RY6KBqMXMZT1UNXamrgyLquBKVsOmVeJ+RwME1KSQmXfJ
3Ky+OaPKtG9dg5qB+jgNykS6RYGMZLrLbmTzymt5hBgdVqWOoSK5N3gjYDxb2IB8
KlcLf9dJfFqoqZbuikogEBw8USFUtu+/Rr5N53CUIszTagEz0BzSD922QZVfmI7f
Kk+/bpQ18fgNxW8KH36oDnYKOU0HVBmCIyU3MhmhavIhh9kWTzBguWUTfU0JVDgo
plEeYfpNfAq2pNDhX2uBEAtt+H4OXB9k4g1CRtIYredyLM5gXAPrE0fedtrzDotr
3TPaZ02K6e0SzHzATLTM/1F+x8xsnO7MbJMhwFe2zdyLKi962L2vDKZ4LY6r6agy
oT2nXfnLd4K/jJvLQ2+19C8G+BRx6I21DV3xr8DH3qGdamkviBGhlQB04f6LowBA
3ORRi9Pn48YSKWzZWsSjdDFJGmv9RtBT3SOTjPV70JzI2cguc7DdtDqM7SN7JSmK
AGykQuUOHlqd1qWUiP7OADqTqXieAdgXSpLH5VJLE96x/pLK//SSGt2OVCEx4rny
bwRg0Hy+ZwJb6fg/gdiBR5v6cwssQXWNIilXo/tyU6nweHdxrnhBfYMUbG+/na9L
4BF0ZZIUj/XWyR1KA77YGsgnFdLUCbEopUDSpSirpCilOHtyp1s=
=2pQU
-----END PGP SIGNATURE-----

--GkbB3ffqO/8m1/M2--

