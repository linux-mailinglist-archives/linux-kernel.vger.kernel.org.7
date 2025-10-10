Return-Path: <linux-kernel+bounces-848149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E7AAFBCCB73
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 13:13:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 700A44ED563
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 11:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C71652EDD63;
	Fri, 10 Oct 2025 11:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="DDW15/kp"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A2D224167A;
	Fri, 10 Oct 2025 11:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760094775; cv=none; b=mJbJxXfQkb1HrgQFUz9B+lPcyEZR2y/x4nQKzYT6WyOKqfDx/v0H6GELXLZwR0/C1Fqzcidstvz9lbFsFYgn2OG/FaJyqZLPkqJLeS+ReVKnUCeJeb3jSNO7zf8+puna1iaMBijBJirtPDssFc4oG/lTe05lYfuGKCSy8Oza1Mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760094775; c=relaxed/simple;
	bh=PH6BK8k7jgJZM8Z1WEm9LWjUJiFZapASzntw1xVKL/g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W4ryXSu8U6vJAGi9A/lm47JTZ0SqFLzdi4pwjeNd+I9/JAJWvut2jNATnmtd4RDDDCCkhaXGTzUeWAOAYxYbMeFJK3Qyf1ZKeYXJMK1MZNAsZ+O0thPt/ZE36IPN1WxghMyh6HCP0Hjcak2W+1AQKKULO8blDT9fRhTdhim/r8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au; spf=pass smtp.mailfrom=gandalf.ozlabs.org; dkim=pass (2048-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b=DDW15/kp; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gandalf.ozlabs.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=gibson.dropbear.id.au; s=202510; t=1760094158;
	bh=UJf6JA61Nmd5HVq98pguqChiugARbS4c9yK3aZVFduk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DDW15/kpFeSZdUSbplqhwDfROrMrCDlEYPmT24g7r+1QGgWpeQnefi0xE6jL6JDrK
	 l5Kn8wthw8/XH52Bgkq5QratMpv/opY5233IudfgdhVzc5T8jP9XxU3SP3oqU7mEcE
	 CYEk8HJ+xUYJC3N4FA9Z3gf/+P5SGY5TfGB17WRfgKN0HEet1pUQPutsc5UDBBIWWq
	 mznGCvLIzq8RIkLesNFE5+1/vZSH/BUtrkRfpV6KuPHC2S5/2nuyyUUna4/h5Q52GT
	 a5WfZUC4/m77A4arPqz7m/Z4XU5foltNqCVSwjwMIXM+fxt1pKmMaObKAfofsHgZl7
	 NU+Z3BvFghp6w==
Received: by gandalf.ozlabs.org (Postfix, from userid 1007)
	id 4cjkNZ0WNHz4wCl; Fri, 10 Oct 2025 22:02:38 +1100 (AEDT)
Date: Fri, 10 Oct 2025 18:58:24 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Ayush Singh <ayush@beagleboard.org>,
	Herve Codina <herve.codina@bootlin.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Rob Herring <robh@kernel.org>, Andrew Davis <afd@ti.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	devicetree@vger.kernel.org, Jason Kridner <jkridner@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree-compiler@vger.kernel.org, linux-kernel@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: Device tree representation of (hotplug) connectors: discussion
 at ELCE
Message-ID: <aOi8oLGYVckesJSb@zatzit>
References: <20250918094409.0d5f92ec@bootlin.com>
 <aMzhgDYOuG4qNcc0@zatzit>
 <dcbeaff2-0147-4a27-bb46-e247e42810d7@beagleboard.org>
 <aNJVqSpdAJzGliNx@zatzit>
 <20250923114849.2385736d@bootlin.com>
 <CAMuHMdWmDwedyPnBERs-tSYEG15nMUuh9u1Q+W_FdquHpUC0-A@mail.gmail.com>
 <aNNvaN4xJtKBFmWT@zatzit>
 <cd9763b7-919a-4b44-a347-f1491d9584b9@beagleboard.org>
 <aNtXnAeLj3xNwkyE@zatzit>
 <CAMuHMdV+sUZpMtbCtWqJMiL_JC_nFEJcFDOoZJZPhhzhY8zQJQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Eq3oV7M9wkH493A0"
Content-Disposition: inline
In-Reply-To: <CAMuHMdV+sUZpMtbCtWqJMiL_JC_nFEJcFDOoZJZPhhzhY8zQJQ@mail.gmail.com>


--Eq3oV7M9wkH493A0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 30, 2025 at 09:52:44AM +0200, Geert Uytterhoeven wrote:
> Hi David,
>=20
> On Tue, 30 Sept 2025 at 06:34, David Gibson <david@gibson.dropbear.id.au>=
 wrote:
> > On Wed, Sep 24, 2025 at 10:33:50PM +0530, Ayush Singh wrote:
> > > On 9/24/25 09:41, David Gibson wrote:
[snip]
> > > > > > > a) Addons can only add completely new nodes, never modify exi=
sting
> > > > > > >     ones.  This means that whatever addons are present at run=
time,
> > > > > > >     every node has a single well defined owner (either base b=
oard or
> > > > > > >     addon).
> > > > > > In this rule I suppose that "never modify existing ones" should=
 be understood
> > > > > > as "never modify, add or remove properties in existing ones". B=
ecause, of course
> > > > > > adding a full node in a existing one is allowed (rule b).
> > > > > What if the add-on board contains a provider for the base board.
> > > > > E.g. the connector has a clock input, fed by an optional clock ge=
nerator
> > > > > on the add-on board.  Hooking that into the system requires modif=
ying
> > > > > a clocks property in the base board, cfr. [1].
> > > > > Or is there some other solution?
> > > > Hmm.  My first inclination would be that this case is not in scope =
for
> > > > the protocol we're trying to design now.  If the widget provides
> > > > things to the base board as well as the other way around, it's no
> > > > longer an "addon" for the purposes of this spec.
> > > >
> > > > But it's possible I've underestimated how common / useful such a ca=
se
> > > > is.
> > > >
> > > > Note that I'd expect the existing overlay mechanism to still be
> > > > around.  It may be ugly and not very well thought out, but its
> > > > drawbacks are much less severe if you're not dealing with hot unplu=
g.
> > >
> > > Well, while that was not an initial use-case in my mind, external clo=
ck
> > > inputs are a valid use-case when talking about connectors for board h=
eaders
> > > specifically (e.g. pocketbeagle connector).
> >
> > I guess I'm not familiar enough with modern embedded hardware.  I'm
> > having a hard time wrapping my head around what's going on here.  If
> > the external clock input is optional (hence under a connector), how is
> > anything on the base board dependent on it?  If nothing on the base
> > board is dependent, why do we need to modify its properties to
> > represent it?
> >
> > Is this a design flaw in the clocks binding?
>=20
> In my example, the external clock input is indeed optional, and not
> used by the base board itself.  Still, it is a clock input to the SoC,
> and may be used as a reference clock when an add-on board is connected
> that needs to use the exact clock frequency of that reference clock.
>=20
> https://elixir.bootlin.com/linux/v6.17/source/arch/arm64/boot/dts/renesas=
/white-hawk-ard-audio-da7212.dtso
> AUDIO_CLKIN_V is the optional clock input to the SoC.
> GP1_25/SL_SW2_V/TPU is the reference clock (actually it is not
> generated on the add-on board, but by a PWM controller on the base
> board, but it could just be a crystal oscillator on the add-on board
> instead)
>=20
> I hope this makes it clearer.

I think so.

IIUC, the problem is that while both the producer and the consumer of
the clock are addons, it's routed through the SoC, which is why it
requires some representation there.

What seems like the logical approach to me is for the base board to
have essentially an unresolved pointer to the clock input.  I'm not
really sure how that could be sensibly encoded, though.

--=20
David Gibson (he or they)	| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you, not the other way
				| around.
http://www.ozlabs.org/~dgibson

--Eq3oV7M9wkH493A0
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEO+dNsU4E3yXUXRK2zQJF27ox2GcFAmjovJQACgkQzQJF27ox
2GfXJw//WY0vLNNk/QHOzkohUQBn+vW48SFGzl7BNkzhnMaDvUjwq6IlsiTZVwod
iP0TXJk+J6FUJ/0Rlf+RSTIskkwNTanY+IMtH8tvxtmIS6xDveSNKTjCMRTBug1G
MdsAeOXPC9brfo4DCufaZ3By7ntXVg3ifHWBAPW/yTxOedb0XOahWWRhdcI/bkJQ
Sza34fbU0c2LN81o7b4ZpfZ+D/OiJ/TPkNhO7qsRKKU5YLwTtg+dPC1jMBsTg2+D
IPGhKEYJkVBN97RXuzWWqudpDQW7zcG1RLpjaKiTWIHz8BEghyKpM26GMZ23OQJG
PkHWwMkYghIJv2pUBZhQqNYoA5WBENBTRSmj+tC4/OSo7qe7qT7d4DO5DclqsbnE
gmVStHGZgh5PIBDHH3HBQTXQJi8a77msGBbNauu4oHJR1FQeAvmOu7Yi4G9L0DyX
0uc9s1bcnFU7bj7LDtvsaMhgVpnpfkyH2XQkpGWHDUeDukpFkKCZ2o3w5NCOX/7P
3ZQLIIuOaPtROEGYszWRE8tGsSvTq1dBcth5dFaWoDsy2UPQb9TmCHiKQVleFNfY
dh9sSzfOUSBTkXS0H5mgT/skMFZIcEJwBvCGOJ9mVsHI/ioTmoKNb2XrQNcPmz6/
ECKs7K/WeGoXl1nU/hU43+rAoXILe0phCIunxRWoU3sxdgeTzBU=
=OmPn
-----END PGP SIGNATURE-----

--Eq3oV7M9wkH493A0--

