Return-Path: <linux-kernel+bounces-837098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD119BAB606
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 06:34:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31B50192301A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 04:34:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 448AE248878;
	Tue, 30 Sep 2025 04:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="gWsBngYr"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF462CCC5;
	Tue, 30 Sep 2025 04:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759206846; cv=none; b=Ey8gjDQfpiDRqk1MViKNdNVvu2IPX6K+sknbJOmdVJbhDVmyj6/h/Sip4K6FZkemolzp/2ToaPZrfrOEqKvZd/0MiO/ygPGQv94VFGDJKG+oyLNQ1l2Dch3wWOWut42Ka8WAj7oGHiX/RGag9561dz2al9/c0J5+Mv8v0QAcAAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759206846; c=relaxed/simple;
	bh=zyloaIfApG3Ugb2d/dothpTRpX4hO6cuE3NKVcalncY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yv+6NuzNCN3tZinhUqX+L/q5REJCBFMBtP2yd+VImW4IDn6OCLXfnYu3by2sxxUQxIuPLvZBY4xe6NL377tr+JlmKWLSfWJMeA3fv395XB+7Z1CvgbHTWKOOKB+RN6WXtkVUuJzxZzMtU/btgBy6MXROea4tMXaZbDpYqgMRBls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au; spf=pass smtp.mailfrom=gandalf.ozlabs.org; dkim=pass (2048-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b=gWsBngYr; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gandalf.ozlabs.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=gibson.dropbear.id.au; s=202508; t=1759206839;
	bh=bVfiIX18jPAm6SdUaAX59gr3TaU/bljhvf/jzuLZ9bk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gWsBngYrRgBaQxTz5ZqFLNoEYCwjVCLR9v6ZZV7reLU8Wp5Ibj4vsnZZPeM+4zSBf
	 jLFoUIpAJKf5jHAYYWL9XQXWF0BdJzSi7OceYq8qJet4fXgU8jK9pbaVaYxjMTNgSe
	 zOZkx4ZqeUSKrpDVho9IO06d9Sl+jgbNaN/N5ZNrx/xvjvH/PHuZ5DvOvu4xCKH19G
	 nXthOpXDK1adkZ1Cq4lp7OlxLR71LdCBouDg4iZMze/ooUWW6v0sbmosPhLLYOZKQG
	 CGX1UdmPIV2eSBijKCzhh2XEB+mTun0np2JrnP9gdHQQkkHIy100GLQrzr7zYujTmJ
	 RxC47fARnRznQ==
Received: by gandalf.ozlabs.org (Postfix, from userid 1007)
	id 4cbQDl4jDgz4w2P; Tue, 30 Sep 2025 14:33:59 +1000 (AEST)
Date: Tue, 30 Sep 2025 14:07:56 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Ayush Singh <ayush@beagleboard.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
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
Message-ID: <aNtXnAeLj3xNwkyE@zatzit>
References: <20250916084631.77127e29@bootlin.com>
 <aMt5kEI_WRDOf-Hw@zatzit>
 <20250918094409.0d5f92ec@bootlin.com>
 <aMzhgDYOuG4qNcc0@zatzit>
 <dcbeaff2-0147-4a27-bb46-e247e42810d7@beagleboard.org>
 <aNJVqSpdAJzGliNx@zatzit>
 <20250923114849.2385736d@bootlin.com>
 <CAMuHMdWmDwedyPnBERs-tSYEG15nMUuh9u1Q+W_FdquHpUC0-A@mail.gmail.com>
 <aNNvaN4xJtKBFmWT@zatzit>
 <cd9763b7-919a-4b44-a347-f1491d9584b9@beagleboard.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="38U+DYi6yaZOgmqL"
Content-Disposition: inline
In-Reply-To: <cd9763b7-919a-4b44-a347-f1491d9584b9@beagleboard.org>


--38U+DYi6yaZOgmqL
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 24, 2025 at 10:33:50PM +0530, Ayush Singh wrote:
>=20
> On 9/24/25 09:41, David Gibson wrote:
> > On Tue, Sep 23, 2025 at 12:29:27PM +0200, Geert Uytterhoeven wrote:
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
> > > > In this rule I suppose that "never modify existing ones" should be =
understood
> > > > as "never modify, add or remove properties in existing ones". Becau=
se, of course
> > > > adding a full node in a existing one is allowed (rule b).
> > > What if the add-on board contains a provider for the base board.
> > > E.g. the connector has a clock input, fed by an optional clock genera=
tor
> > > on the add-on board.  Hooking that into the system requires modifying
> > > a clocks property in the base board, cfr. [1].
> > > Or is there some other solution?
> > Hmm.  My first inclination would be that this case is not in scope for
> > the protocol we're trying to design now.  If the widget provides
> > things to the base board as well as the other way around, it's no
> > longer an "addon" for the purposes of this spec.
> >=20
> > But it's possible I've underestimated how common / useful such a case
> > is.
> >=20
> > Note that I'd expect the existing overlay mechanism to still be
> > around.  It may be ugly and not very well thought out, but its
> > drawbacks are much less severe if you're not dealing with hot unplug.
> >=20
>=20
> Well, while that was not an initial use-case in my mind, external clock
> inputs are a valid use-case when talking about connectors for board heade=
rs
> specifically (e.g. pocketbeagle connector).

I guess I'm not familiar enough with modern embedded hardware.  I'm
having a hard time wrapping my head around what's going on here.  If
the external clock input is optional (hence under a connector), how is
anything on the base board dependent on it?  If nothing on the base
board is dependent, why do we need to modify its properties to
represent it?

Is this a design flaw in the clocks binding?

--=20
David Gibson (he or they)	| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you, not the other way
				| around.
http://www.ozlabs.org/~dgibson

--38U+DYi6yaZOgmqL
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEO+dNsU4E3yXUXRK2zQJF27ox2GcFAmjbV44ACgkQzQJF27ox
2Gf7TRAAiB+fR8M9ZW43173P4pNm6v8KnaRxK8YZ+rfvserkiNQswx/mbPhinuJw
9eQQ0d92E4ujz2cx971xnqofCvHIckzoWQkH84BjobvIvSF7iTFjJqStC2n1MmSo
qbchBzgTUjU/ZM9krPtGWxsRFgMTwFuKfeucn3TY5KHcsGMDt2TspLw513mfDIXS
7KwY0Z3GR7uodsHKWncQWkQmShG5iPrRNbjBCcjSd8Kjl9InsLsg944+y0cDrw87
8/Q4WfiJS/BBTIqR+/uZvEi4p4fQzKXLMu9OMt2yEpf2trI1sa701qeZC8ASJSx1
NuyZHjXS8KMX009EOkjTFwNiNNihsSrOQfHXetSEwqnZuMYe5oQMYDzx5GhBHZG7
obQDBBNYmMysa3OUxQG9uhuof8XEexPITgatd2FPd1YhnlJ8Whyovpdt6Mj8ZsAK
kcGPJaT5P4ysEPSPt+cs0zIW0coOXRPCzTeZntPPjLzDihI5sU66MIJq64jrTykq
f4VEkmOH2s909mQVJpPomtsk2idX3G5YV13th74+/8VE3jutC9gjJaaazATosBe7
gJiCvB9VBEQPPpZ+1e1PawcO7dzL5eKEJ/0rcYovYMUE3vmlpmFHLN8WIR9sKDDW
250Khxb8y/6kItvvmK9uz3buo28Hl0e42zt+3eFj/RABpN3/J+k=
=8jCr
-----END PGP SIGNATURE-----

--38U+DYi6yaZOgmqL--

