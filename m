Return-Path: <linux-kernel+bounces-885134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7973C32158
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 17:34:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC389464EB0
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 16:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33A5F33290A;
	Tue,  4 Nov 2025 16:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b/M6HVby"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E8EF33344B
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 16:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762273857; cv=none; b=r9PSb2gdOpKzKthXT3t1RSgJY3FhK0cgYxLtWM/VoJNiQSGTMKfU83xV8/967It4yb8hbgtkoXZ5EVZ7LzTw0BwRuWnomGUd0dcoJzjNksAI4734Sh0GSbeZ6JqqRNYTwL3Yu9ZY8TD6IHYY4+WHTf9larOpuKdpjUX8R2gSdus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762273857; c=relaxed/simple;
	bh=v6h3H0oNELTrdPAQmYPV1RA2KzBoG8cd2M9i4s1fPDs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aiJPtY/NHW61nj951DRSHzoCjyOTeWdIagS3iNifYpxAZE8l8n6Fbd0yJiitXpih2lGCXwzi6rnToMpN/GZZUFsR/yn5ejZ8QougElF8KLo0JAA23jSGabFjygejpQ+Ogh2h5VhKcBoxUVj7EIM68r85l1TRbw3hOaQuTC1PRWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b/M6HVby; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8887C4CEF7;
	Tue,  4 Nov 2025 16:30:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762273857;
	bh=v6h3H0oNELTrdPAQmYPV1RA2KzBoG8cd2M9i4s1fPDs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b/M6HVby0tgKGtVSNUxzXPq70qsLXduU3Dd5ZSRsPMAtvrQxzX64lpTvSPs1v10Q1
	 W4wQhtw++cH0naxQmaOo0PMwwF96nhLMYo7Y/e8R5VtVr3o6x/gPRN6dsD7vD6OWw0
	 MlarbH3vyywviA0JwPkaQV2a1gZ1OQpj2YONCAbtsxe63NWeupAPVtUbpQ/sXOInDS
	 /mfKabcgy9WZfx1hz4Rci5kM/qLLU9uNRmWsqmRUY0C4ShXZZ3iaGJd2EkW3xlpi+H
	 lYtGO57SVyd1ArZzExfg8Gq9Y57lu4UJTyRwsZ16egxvOcIXQ8zjOoAcsmFefE8zMd
	 M4T4G4NRsqRPg==
Date: Tue, 4 Nov 2025 16:30:54 +0000
From: Mark Brown <broonie@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: regulator branch mess
Message-ID: <aQoqPqVeQiHJ2tiF@finisterre.sirena.org.uk>
References: <aQoZ22aT27wHBpbI@smile.fi.intel.com>
 <aQocq1eRjOOjiRdY@finisterre.sirena.org.uk>
 <aQogTFANK1fMtloW@smile.fi.intel.com>
 <aQojdTvP94aYVW4l@finisterre.sirena.org.uk>
 <aQolne8AKHXdJw0-@smile.fi.intel.com>
 <aQonVNgqJI56nspA@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4b8c3QaUhB7Rbabj"
Content-Disposition: inline
In-Reply-To: <aQonVNgqJI56nspA@smile.fi.intel.com>
X-Cookie: If in doubt, mumble.


--4b8c3QaUhB7Rbabj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 04, 2025 at 06:18:28PM +0200, Andy Shevchenko wrote:
> On Tue, Nov 04, 2025 at 06:11:09PM +0200, Andy Shevchenko wrote:

> > The merge in your regulator tree for-6.19 branch which is

> >   commit 9de2057bbdfb58f4d9bb1476135317cd3fe6aa52 (patch)
> >   tree 97c34e939fd59891ab122d191ebbe8837a0010d3
> >=20
> >   regulator: pf9453: optimize PMIC PF9453 driver

> Because "base" keyword in the series points out to the=20

>   commit 98bd8b16ae57e8f25c95d496fcde3dfdd8223d41 (tag: next-20251031)
> 	Author: Stephen Rothwell <sfr@canb.auug.org.au>
> 	Date:   Fri Oct 31 20:35:57 2025 +1100
>=20
>   Add linux-next specific files for 20251031
>=20
>   Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>

> And that merge did it. If you are going to send this to Linus, I believe =
it
> will become a trouble.

No, that merge very much did not do that.  As you can tell with git log
and from the diffstat I posted previously that linux-next commit does
not appear in the history of the above commit.  You can also see this
with git cherry:

$ git cherry origin/master regulator/for-6.19
+ 6277a486a7faaa6c87f4bf1d59a2de233a093248
+ 433e294c3c5b5d2020085a0e36c1cb47b694690a
+ 835dfb12fc389f36eb007657f163bd1c539dcd45
+ 1356c98ef911e14ccfaf374800840ce5bdcb3bbd
+ 6a8cdef7dc2a4c0dbde3f7d7100b3d99712a766b
+ 65efe5404d151767653c7b7dd39bd2e7ad532c2d
+ fb25114cd760c13cf177d9ac37837fafcc9657b5
+ f76dbe127f1b5910e37dfe307d2de5c13d61ed89
+ d054cc3a2ccfb19484f3b54d69b6e416832dc8f4
+ 01313661b248c5ba586acae09bff57077dbec0a5
+ 86df0030b71d7172317d957df17524a7fd6232d4
+ 4c33cef58965eb655a0ac8e243aa323581ec025f
+ 28039efa4d8e8bbf98b066133a906bd4e307d496
+ 252abf2d07d33b1c70a59ba1c9395ba42bbd793e
+ a2d4691b3fec6a2360e4ec953d06819ea055c3e7
+ 0144a2b29d95af8523c308116de65d398d6e935b
+ 2ecc8c089802e033d2e5204d21a9f467e2517df9

That is the full list of commits in the for-6.19 that do not already
appear in mainline.

--4b8c3QaUhB7Rbabj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmkKKjoACgkQJNaLcl1U
h9BM+Af+Mj8QdHlH2B7wACmFvAQ1+PNuScY5HRGWa94wzItNJXojFdnSqYRCD8Re
6hYz5Wzw3qfnOWhXdAvNK1xMHlhu3Akn88tC0TUF+9IWHKjC/NsyKrbVlOidtfgw
DPSvJRYU6ZICnk+qVpOOLUUzxfsoHdmOhqraabnVQki5IPKIsFWbiano1iGWYbar
jtnecSeOWlvHHjnyG8MVsO5Qq0d2xv+CBjp6F00j/c5KA3I5WpSnzL/Ynr1oKeOa
vYhFjpw/lWOqIXArMS0lGZEeqMlPPP/fsH9JDmJXGNfqGbpq1/uBWBetZlrvbOcS
b7az34KhqUNAi0yDB4ejzulOQL9DeA==
=kJPT
-----END PGP SIGNATURE-----

--4b8c3QaUhB7Rbabj--

