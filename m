Return-Path: <linux-kernel+bounces-829913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AF45B982E6
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 06:17:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1348F17510D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 04:17:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCFAC23504B;
	Wed, 24 Sep 2025 04:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="T4X13y1S"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57A17145329;
	Wed, 24 Sep 2025 04:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758687436; cv=none; b=bZ7koaKMeMqE+d2VMi6GmGd6Vo4AwaSVyCi7xYh7y0kitJULEg1eq/b8tlq1WQ0zlwYehg5QCC1Xko5enLXBBw5O3Yt/yoZTKwV3pE3I8D+xxeITgy4CjPXvX8lQilQ517r92i5/cTezQfMhxoAMOhbiB5YQnY+1DkhdqFrU5/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758687436; c=relaxed/simple;
	bh=tfv83TI6Dd4/TM+6Gy4WFhsaH7KyF7FZu9cY74WXAtk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YREh53XAnaY/aJRvtNl+aCuNQBcDXypZ5D4bbdN91Z/NhfFKWXh5tGPyFtr56kXVAuRoCRiYFP91mpapGKeH7yD2aUMrVDp/XaYXn3ERcYMdEY/0azMthLpEa5n6llln+1rJ/JrZ4u/skvmQlLtvure4+fvV5a19R6iZQqRnySI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au; spf=pass smtp.mailfrom=gandalf.ozlabs.org; dkim=pass (2048-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b=T4X13y1S; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gandalf.ozlabs.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=gibson.dropbear.id.au; s=202508; t=1758687426;
	bh=CcEqCcYKR16Hb3iR99TfbZHr7mQ9icFWfEUpLaLOKC8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T4X13y1SEhque7kXU4r1W1PHeA7JMfDy4fjmlNrqmmwFdA4f7z6trs0xl03fHg9p7
	 tZMFGPCt7V+AQ9QSKgu9i/gDGJ3pU89/Rzj6bw0bj8klH5q27bhWGCSQquuzf6CYcL
	 UsFIRG5qiw25Gstuet6+HhCscgLphgsKULfwkH+l6JeyOFtxut9QlCUt1I5yC/xiSK
	 PySRcwNUVaaCx219o544sbH4c+NK1gv3K4U9w6jinDuiiQL0jChpDIudbhTbpQMKf7
	 nEtXuwz9mmAGxSX+LMpH2MOsbbTu8aiDCV0Zsa/h9vKSDbgkwTNFQphve7Y2F35/Ru
	 ygQyiRkM79FSg==
Received: by gandalf.ozlabs.org (Postfix, from userid 1007)
	id 4cWk820nW7z4w2J; Wed, 24 Sep 2025 14:17:06 +1000 (AEST)
Date: Wed, 24 Sep 2025 14:11:20 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Herve Codina <herve.codina@bootlin.com>,
	Ayush Singh <ayush@beagleboard.org>,
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
Message-ID: <aNNvaN4xJtKBFmWT@zatzit>
References: <20250911104828.48ef2c0e@bootlin.com>
 <aMebXe-yJy34kST8@zatzit>
 <20250916084631.77127e29@bootlin.com>
 <aMt5kEI_WRDOf-Hw@zatzit>
 <20250918094409.0d5f92ec@bootlin.com>
 <aMzhgDYOuG4qNcc0@zatzit>
 <dcbeaff2-0147-4a27-bb46-e247e42810d7@beagleboard.org>
 <aNJVqSpdAJzGliNx@zatzit>
 <20250923114849.2385736d@bootlin.com>
 <CAMuHMdWmDwedyPnBERs-tSYEG15nMUuh9u1Q+W_FdquHpUC0-A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3cinCq2Z6IKfcS1Z"
Content-Disposition: inline
In-Reply-To: <CAMuHMdWmDwedyPnBERs-tSYEG15nMUuh9u1Q+W_FdquHpUC0-A@mail.gmail.com>


--3cinCq2Z6IKfcS1Z
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 23, 2025 at 12:29:27PM +0200, Geert Uytterhoeven wrote:
> Hi Herv=E9,
>=20
> On Tue, 23 Sept 2025 at 11:49, Herve Codina <herve.codina@bootlin.com> wr=
ote:
> > On Tue, 23 Sep 2025 18:09:13 +1000
> > David Gibson <david@gibson.dropbear.id.au> wrote:
> > > Ah, right.  To be clear: we absolutely don't want multiple addons
> > > altering the same nodes.  But I think we could do that in ways other
> > > than putting everything under a connector.  This is exactly why I
> > > think we should think this through as an end-to-end problem, rather
> > > trying to do it as a tweak to the existing (crap) overlay system.
> > >
> > > So, if we're thinking of this as an entirely new way of updating the
> > > base dt - not "an overlay" - we can decide on the rules to ensure that
> > > addition and removal is sane.  Two obvious ones I think we should
> > > definitely have are:
> > >
> > > a) Addons can only add completely new nodes, never modify existing
> > >    ones.  This means that whatever addons are present at runtime,
> > >    every node has a single well defined owner (either base board or
> > >    addon).
> >
> > In this rule I suppose that "never modify existing ones" should be unde=
rstood
> > as "never modify, add or remove properties in existing ones". Because, =
of course
> > adding a full node in a existing one is allowed (rule b).
>=20
> What if the add-on board contains a provider for the base board.
> E.g. the connector has a clock input, fed by an optional clock generator
> on the add-on board.  Hooking that into the system requires modifying
> a clocks property in the base board, cfr. [1].
> Or is there some other solution?

Hmm.  My first inclination would be that this case is not in scope for
the protocol we're trying to design now.  If the widget provides
things to the base board as well as the other way around, it's no
longer an "addon" for the purposes of this spec.

But it's possible I've underestimated how common / useful such a case
is.

Note that I'd expect the existing overlay mechanism to still be
around.  It may be ugly and not very well thought out, but its
drawbacks are much less severe if you're not dealing with hot unplug.

--=20
David Gibson (he or they)	| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you, not the other way
				| around.
http://www.ozlabs.org/~dgibson

--3cinCq2Z6IKfcS1Z
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEO+dNsU4E3yXUXRK2zQJF27ox2GcFAmjTb2gACgkQzQJF27ox
2Ge1FRAAi7D57ve6FZWbZDi6g5hVjwDLjDq6zhVJWLujOcXYMF01nF5bC+4A/q3M
hl+eFoGBAfjIOSY8XiRARMt3qDPdlGMmFC8dm8HvWTUPGVE2NtGDP5d96+NrMz1S
juLkLRNJ+xOj1bDR51KLAYCrgQlgzY+WTt+4crCr8Eo0VufsBDYtCYCMFfuZi6Qm
0shNRqxzid7Eiq56WHzyoix0iMSsKvo75v6MBV2mE0JwqF0g4eg/BBzRO4Oje0wI
jT2Td/bzCAeo8oAIz0nXDvkaTOSMhL4IGCY0MKkLQ/L8iol3UsBj1TqeMn52pZoI
7zokHS/dh48aDp0kR4JBNFEuVgQS96va50gljtI9ZKZ8eiODpOlCD7fQ8WjyWKQK
w0Nq7gGN+34e6PTVixxLOkDp7BQJaJ78X5qSDq/6MDdPVqniQxZO/RU88oxCNvqV
Ezw2OEv/gob+rdMj99wRU6wkqUaYgMcz+bM+tn0jCy3pWeouN1vVMvQVMgOKQ7RS
IMB2Q9CuKc4O2/83Ny+NtaWJsERKqAPcONRyuQ/m6z7Ljl+pl8KpjsexdNgAwjI0
NnmAI8GCcwFvrNAZHRuR83D/s6j4bLWTnTF76mh9/GdG6BOSvU2BEmuNTldqLn7+
hFrlWHPHKlBCmVYBYG2SbPkreMgCdGkXpAnyV7voG6PY2vCcSNo=
=ZjzD
-----END PGP SIGNATURE-----

--3cinCq2Z6IKfcS1Z--

