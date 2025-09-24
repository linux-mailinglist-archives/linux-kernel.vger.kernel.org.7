Return-Path: <linux-kernel+bounces-829912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DA16FB982E0
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 06:17:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4829B7B1D4A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 04:15:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82156233128;
	Wed, 24 Sep 2025 04:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="v+wmntoh"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 579702AF1B;
	Wed, 24 Sep 2025 04:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758687435; cv=none; b=h/ggd6fYB7ausd/ViqJ1pOg8QADo92O+CkYJ3iqWaE+t+SCG0c6aFnNSp/TjEtP2orpyYTV/6g50aXPTo7xYtPia/P7e9jyhvWUQdx55OKpP7TNeQrkSfdPajWOK/Q0saSMzy6qidQUur4qB55mxp3un9NH6X5HrnsvoTtfmVjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758687435; c=relaxed/simple;
	bh=2jGW7nU6Fl4sPFQ7WD9QALveoqd8x4kSGrrUKRlxCs0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OfKVN3OEf1aLoZtidtIL4xNKgLgDBZTmTI1OGOXBmDeq+Giu2o0SUnDT6ebyKDUyc0F4hmIc5Y8a5oFB19/SNbv4JQkC54Fr/Agpt4kA9Kpbvj9J3w21V/0VjEPWyfmc3AzZ49CAgII+N2vbnMj2S+GWRdNJ6Fcpnnees7MCvRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au; spf=pass smtp.mailfrom=gandalf.ozlabs.org; dkim=pass (2048-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b=v+wmntoh; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gandalf.ozlabs.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=gibson.dropbear.id.au; s=202508; t=1758687426;
	bh=nCJ0Y0jzQB2BbL9/gHVuaIfxE69sLkf1MJ03mS/NmV4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=v+wmntohEdfhIvgV4miU6fkwJINnF4/7dBvJHntV3h0eAmSpa/G9HBvzlCmyG09R6
	 RBEy1c9ZHAz+ENUSyN/jSpJCDBPVQG2UyFQ3WLDmKQLo3hXn3CHnroQQvdk2pni9TL
	 WISFyqpvdvxErUzenaGfVhk5YwZBGYDqfFMpixj9oQDdbdtnwLB98WgwE6f+OGtBSu
	 SIKSgRLoeKaDlMrQfyRAUxTKoAMyMkK3kBKKYpVLlm98ii0kDBS6Hxuwi0SeeqrU7O
	 3rzqb0FH9CXOB3QCR/jxhwWZfc9L8sqcwrlo0UpufDTpgQn5sJ4/ojhoTUhWYV9pR/
	 9nd7sMtpwbyFw==
Received: by gandalf.ozlabs.org (Postfix, from userid 1007)
	id 4cWk820yCfz4wCK; Wed, 24 Sep 2025 14:17:06 +1000 (AEST)
Date: Wed, 24 Sep 2025 14:17:02 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Andrew Davis <afd@ti.com>
Cc: Herve Codina <herve.codina@bootlin.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Ayush Singh <ayush@beagleboard.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	devicetree@vger.kernel.org, Jason Kridner <jkridner@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree-compiler@vger.kernel.org, linux-kernel@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: Device tree representation of (hotplug) connectors: discussion
 at ELCE
Message-ID: <aNNwvhgdDidsWfRD@zatzit>
References: <20250916084631.77127e29@bootlin.com>
 <aMt5kEI_WRDOf-Hw@zatzit>
 <20250918094409.0d5f92ec@bootlin.com>
 <aMzhgDYOuG4qNcc0@zatzit>
 <dcbeaff2-0147-4a27-bb46-e247e42810d7@beagleboard.org>
 <aNJVqSpdAJzGliNx@zatzit>
 <20250923114849.2385736d@bootlin.com>
 <CAMuHMdWmDwedyPnBERs-tSYEG15nMUuh9u1Q+W_FdquHpUC0-A@mail.gmail.com>
 <20250923153646.754e86f8@bootlin.com>
 <fe45ac1d-e49b-4456-bbe1-5a04f400e73f@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mJ9ylWqQJ0f1GSHh"
Content-Disposition: inline
In-Reply-To: <fe45ac1d-e49b-4456-bbe1-5a04f400e73f@ti.com>


--mJ9ylWqQJ0f1GSHh
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 23, 2025 at 11:47:38AM -0500, Andrew Davis wrote:
> On 9/23/25 8:36 AM, Herve Codina wrote:
> > On Tue, 23 Sep 2025 12:29:27 +0200
> > Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> >=20
> > > Hi Herv=E9,
> > >=20
> > > On Tue, 23 Sept 2025 at 11:49, Herve Codina <herve.codina@bootlin.com=
> wrote:
> > > > On Tue, 23 Sep 2025 18:09:13 +1000
> > > > David Gibson <david@gibson.dropbear.id.au> wrote:
> > > > > Ah, right.  To be clear: we absolutely don't want multiple addons
> > > > > altering the same nodes.  But I think we could do that in ways ot=
her
> > > > > than putting everything under a connector.  This is exactly why I
> > > > > think we should think this through as an end-to-end problem, rath=
er
> > > > > trying to do it as a tweak to the existing (crap) overlay system.
> > > > >=20
> > > > > So, if we're thinking of this as an entirely new way of updating =
the
> > > > > base dt - not "an overlay" - we can decide on the rules to ensure=
 that
> > > > > addition and removal is sane.  Two obvious ones I think we should
> > > > > definitely have are:
> > > > >=20
> > > > > a) Addons can only add completely new nodes, never modify existing
> > > > >     ones.  This means that whatever addons are present at runtime,
> > > > >     every node has a single well defined owner (either base board=
 or
> > > > >     addon).
> > > >=20
> > > > In this rule I suppose that "never modify existing ones" should be =
understood
> > > > as "never modify, add or remove properties in existing ones". Becau=
se, of course
> > > > adding a full node in a existing one is allowed (rule b).
> > >=20
> > > What if the add-on board contains a provider for the base board.
> > > E.g. the connector has a clock input, fed by an optional clock genera=
tor
> > > on the add-on board.  Hooking that into the system requires modifying
> > > a clocks property in the base board, cfr. [1].
> > > Or is there some other solution?
> > >=20
> > > I was also wondering about endpoints, as they have two sides: one on
> > > the base board, and one on the add-on board. But it seems that typica=
lly
> > > both ends are added by the extension, so these fall under rule b.
> > >=20
> > > Thanks!
> > >=20
> > > [1] https://elixir.bootlin.com/linux/v6.16/source/arch/arm64/boot/dts=
/renesas/white-hawk-ard-audio-da7212.dtso#L165
> > >=20
> >=20
> > Hi Geert,
> >=20
> > Addon DT we talk about is not a way to fine tune base board devices.
> >=20
> > For the clock, you need a clock driver which is able to support clock h=
ot-plugging.
> > Same for endpoint, the remote endpoint part should support hot-plugging.
>=20
> Why should these drivers need hot-plug support, they are attached and then
> the board is booted. Nothing is hot-plugged here.

That's a reasonable case, but not AIUI, the case that Herv=E9 (and
others) are trying to deal with.  The existing overlay mechanics are
not as problematic when you don't have to deal with hot unplug.

Here we're trying to design a protocol that's suitable for things that
can (at least in principle) be hot plugged and unplugged.


As a little background here the existing overlay mechanism was never
designed for hotplugging let alone hot unplugging.  It was built for
boot time, or pre-boot use, "tweaking" a mostly correct device tree.

In fact... it wasn't even really designed for that.  Its semantics
were basically just copied from dtc's *compile time* overlay support.
That wasn't designed for any kind of plugging, hot, cold, whatever.
It was designed for building DTs for a bunch of similar but not
identical boards from a common base (such as a SoC tree).

Moved to runtime with dtbo, that was already pretty clunky.
Attempting to use it for hotplug is just awful.

--=20
David Gibson (he or they)	| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you, not the other way
				| around.
http://www.ozlabs.org/~dgibson

--mJ9ylWqQJ0f1GSHh
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEO+dNsU4E3yXUXRK2zQJF27ox2GcFAmjTcL0ACgkQzQJF27ox
2GdozQ/+Kk3zOGcKKpLkL1aKtmQ/8wKl6ffi2fXmdiYDjd+olcAvt83BnJ66wh/i
xCbUVv96vaWftgJksY2FEvx57dkMb2KqveMVGgKX2EnwLutp9q1O1PL2419jXTkI
5F2rp2/TAgKu1+fWO38oGtaSpJolyHjnw6sJOzqX5fY34jAqiT4/9jEWOiKm5pVE
MuyGh29PE5iWVOVC4Vbx+Xm32NwDoS2dKlbq58B/I5g1TZB/1fHlqkHGtopONbSi
k+lmQ4Sw6svu2bCmYajGrWnMOSWjbaxzxiJdaXQTTQSpQD0gsmvps0XHLrmpb1v3
uDoNrmolQrYLw+Cs5dJ2WGbvvFaxIqC/qQoTVgRqd0//tWVy4oHX9W/ICUsevtBi
qEhTEC7vub6BU3HNpi8WJj7+7S76QWv99bowDCVPlp8uNok/XF2FR5LfvoW8KZq1
MMd25J6a6nYbzHgqwPpdxaVRTB2ts4ncSMvqmNRb2CMBD5tZmMOu+dgqUB80dO/K
8ta/QyQeha/d5s6B9b6R6VgL4YxZyYdr+ofhNBO/WI+C4b9Sjn0HCD40r1xVbSIB
yR4GH4JPgrDljacFhAxoJwIWHdzsmtClZBzb30uHl0+Wkma1RC0cTJ7ob5czAcSD
zCmixfF+yLVRRClGQ3FonjVzuT7Is2Pgo/MNtHu2zMR7z/lS1FY=
=uqjI
-----END PGP SIGNATURE-----

--mJ9ylWqQJ0f1GSHh--

