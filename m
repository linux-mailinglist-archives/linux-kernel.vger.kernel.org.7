Return-Path: <linux-kernel+bounces-856309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C6B7BE3D20
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 15:55:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAA343A73F4
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 13:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC85A33CE9C;
	Thu, 16 Oct 2025 13:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H1f2zkrU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E24224AED
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 13:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760622948; cv=none; b=A9zKiXsba+s3K/JBL6c9Q0CRnq/fj4OYoSOLZZ9kqQqSRvgpoyjFfwHiq0GSPOc3CUsXQ9sxEsJC8HvPnY2vE45T9YIIsPm0paPuOlTtmkUhjPgLz7rJ1Ia3ncf7Hn5tUnFKy+yV3fAl786hakZ8XWn1T9iYOp5PmOS2q6ACX4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760622948; c=relaxed/simple;
	bh=bm6Tw/iAecfuuqesbnL0lZ5K2LRVKKPusnIpr7/snA0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pg3lGC7yvAEFRhmUQEASaWeL1py6MrRhMhquOE4mNDuHxM3fkFItUgRHlOJBXgANB4E0IzYdcfArno/nW1dyYWCEsIzECVNwM5+3B1mNBzqtVf0R3FWJkjCHW8ZX2yZVJlfozYaGP1fc3aKXkAc7mNKGaSLGWZQlxqC6YQN2Aow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H1f2zkrU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82CDDC4CEF1;
	Thu, 16 Oct 2025 13:55:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760622946;
	bh=bm6Tw/iAecfuuqesbnL0lZ5K2LRVKKPusnIpr7/snA0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H1f2zkrUQskMY+TIu8+sL1xLFj1N9n2p4gawuQ3PzdlQrfKA0NeLfJz0KjlXS+IBD
	 jOAdi39HBsLjNU5UFjXz+UvR+RVy+XgQiamZJ8vRBL1cuJ+8lItC10AiCL10lcPsuN
	 IWOHYUgA8O2at0C17hMkcXj6p1jJ6m4JGZd1GiPGnBpglJZgm2v1Big46zGPC8cPan
	 iLlVBodxMnauHQDqT0d9lqWfHSJmXw8pWENZsqetlvSflk2BRW7KrW+Z9qToi4lQfe
	 E/v8q3aemmxTa5rBaBbXxl6cZuC6jX0ichRKU+iY+uSOMu4iRY4C61+G653meZZk98
	 d7hreHWkuerCQ==
Date: Thu, 16 Oct 2025 14:55:32 +0100
From: Mark Brown <broonie@kernel.org>
To: Sander Vanheule <sander@svanheule.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] regmap: add cache validity to REGCACHE_FLAT
Message-ID: <143f0597-7cfa-4b16-ada9-72922f566284@sirena.org.uk>
References: <20250109180256.6269-1-sander@svanheule.net>
 <a2f7e2c3-f072-40f7-a865-5693b82b636e@sirena.org.uk>
 <0b2fa71f1ccd49d66ca02b6c44ba8fe2135e9b6f.camel@svanheule.net>
 <ca528e3e-39f1-41cc-9f46-ad787af48a77@sirena.org.uk>
 <187bc058ff944dbde0e876efa6e72046bcc2a124.camel@svanheule.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="D5gm0aSRkCsYKtL6"
Content-Disposition: inline
In-Reply-To: <187bc058ff944dbde0e876efa6e72046bcc2a124.camel@svanheule.net>
X-Cookie: Whoever dies with the most toys wins.


--D5gm0aSRkCsYKtL6
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 16, 2025 at 02:08:41PM +0200, Sander Vanheule wrote:
> On Thu, 2025-10-16 at 12:53 +0100, Mark Brown wrote:

> > Taking a step back for a minute, what's the actual problem you're trying
> > to solve here?=A0 Why use a flat cache rather than a maple tree cache f=
or
> > your application?

> The device I want to use this for has a small contiguous register space, =
so a
> flat cache should be sufficient. The driver can also works with maple (or=
 RB-
> tree) cache.

I strongly recommend just doing that, unless you have a specific need to
use something else you should use a maple tree cache.

> This difference in caching behavior isn't (wasn't) immediately clear to m=
e from
> the documentation. Don't the different cache types exist to optimize spee=
d or
> memory for different use-cases? Because then I would only expect differen=
ces in
> memory/speed, not in way the cache is initialized.

The flat cache is a bit of a sharp edge, it's specifically there to be
the absolute bare minimum cache.  It's there mainly for MMIO devices
that are on the edge of being able to use regmap at all for performance
reasons, and as a simple way of guaranteeing that we never do any
allocations at runtime for things that do register access in hardirq
context.

The documentation could definitely use some improvement here.

--D5gm0aSRkCsYKtL6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmjw+VMACgkQJNaLcl1U
h9AgWAf8CN8GoFFTNfDXKDlH03nFzpCbNfE19UxK56aWb/5bHIV0m/F3eEvTvumg
YujXvIn4BUVvBMBpryMSK3GtTR/s5sOClfumWBBjiDKi879EK01exWLGfxI1260R
s63gneERJyqSBu7sZZ/DzSoKy4i5IlQI5/oKfyrw2Ucx5AFfsoBZmcYJQVr3Tr5D
DCNs4sxWASUd4qF7zvU1hWEH4naA6Vad3uGP/tdpbrocHu+Oeb4pDtOqI85b95SB
CL5Ixe4GxAP8eCnLOz3EI5/iFCslkT1CDJTqFUaSgHwJFnW2XCEzvnfnOMpgetNB
O4EjJlhRVuNBYLK5VflDT4jLnA+Kew==
=VvGB
-----END PGP SIGNATURE-----

--D5gm0aSRkCsYKtL6--

