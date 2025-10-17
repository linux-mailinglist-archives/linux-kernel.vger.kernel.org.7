Return-Path: <linux-kernel+bounces-858129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AB3EBE9129
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 15:56:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 921E93A9543
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 13:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E056369964;
	Fri, 17 Oct 2025 13:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G2+SOkjA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA543570CC
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 13:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760709378; cv=none; b=YPXiSLWTSIZTvDl+G+/7JAY45VKrsSGQNaCoDkf4WLc7gyTV3vpRUSAhkXg8oJs//3gwdf4/2DxHKB/2Vy36Zm4BidvzjmYCIbynjMrVDaDhwDPLEzk/wswa9shs16iHcM8HZ3PLDgbQKC1UfXPgLeLeghHedHoSQwv9eJwkOFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760709378; c=relaxed/simple;
	bh=rtEJFX+8Iq/oUlQHIJhSyAfom+26J30+J1Q6OYYdRCo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XtHJJiRJl9QFqvRPcQnSNlr44Za4BEG6g7GNwJPVse2+LSovfmXb4duXN7roRuNQJ4dtklcS4oeDEazm2M49ETXKBhadVkX+gk2f0QSzxjMw3TfjL12FUIiAhPb4hi+tKcvRdWgQL4DuxD/qrQ1X5aLFkHLyE+y2fUeqvcgmWXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G2+SOkjA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 226B4C4CEE7;
	Fri, 17 Oct 2025 13:56:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760709378;
	bh=rtEJFX+8Iq/oUlQHIJhSyAfom+26J30+J1Q6OYYdRCo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G2+SOkjA5ddghyQmycgMQ1BXfwMNWincbi/oeDcqu6odNjIHs6tC8xXe9/3Lybuzk
	 fDJMN7H10zb206b5nbMKB5Sa0TPLOx5fu+L83uxeZYKlrz/xcV6/zXPGDPUirKbsmf
	 jY4EeSXw4de2cbUfEbl6bA+DRiqP5vFMnuF76IaYs+3dR5BBzzCJjaLDjrndMODoe4
	 GKV/4ajGSi8VfY0N6YO1MsIWBU1YmSAuZFVUwic7NeQbQd/lU/p+XK5HjNEfTkad2F
	 Mr0hyXG1mSpW7ZQWuiTcYdP78LAtzJQwS1jKDH+rq09ZA45qYRg1JNsn5Zq5F0yoJu
	 JZ0Vzfko9Lyqw==
Date: Fri, 17 Oct 2025 14:56:10 +0100
From: Mark Brown <broonie@kernel.org>
To: Sander Vanheule <sander@svanheule.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] regmap: add cache validity to REGCACHE_FLAT
Message-ID: <26abcd6d-ae3a-4ef8-890a-9b209c3c8e03@sirena.org.uk>
References: <20250109180256.6269-1-sander@svanheule.net>
 <a2f7e2c3-f072-40f7-a865-5693b82b636e@sirena.org.uk>
 <0b2fa71f1ccd49d66ca02b6c44ba8fe2135e9b6f.camel@svanheule.net>
 <ca528e3e-39f1-41cc-9f46-ad787af48a77@sirena.org.uk>
 <187bc058ff944dbde0e876efa6e72046bcc2a124.camel@svanheule.net>
 <143f0597-7cfa-4b16-ada9-72922f566284@sirena.org.uk>
 <baaa378164ae45c43a521eca467b49e0eda38818.camel@svanheule.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="8NWmJnmdXfMqJS85"
Content-Disposition: inline
In-Reply-To: <baaa378164ae45c43a521eca467b49e0eda38818.camel@svanheule.net>
X-Cookie: Androphobia:


--8NWmJnmdXfMqJS85
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 16, 2025 at 10:49:40PM +0200, Sander Vanheule wrote:

> The proposed patch also won't perform any allocations outside of the regm=
ap
> initialization. There is the additional overhead of checking a bitmap, ye=
s, but
> that's probably not a huge problem if the main issue are the allocations?

The allocations are more of an issue, but they're both potential issues.
Note that you can also avoid allocations with rbtree or maple by
prefilling the cache, it's just harder to absolutely guarantee that you
got everything right.

> A number of REGCACHE_FLAT users provide only num_reg_defaults_raw. That l=
ooked
> strange to me, because why would a user provide a buffer size, but no buf=
fer?
> This even conflicts with the documentation, as "Number of elements in
> reg_defaults_raw" doesn't make sense if reg_defaults_raw is NULL. As you =
are
> probably aware, this configuration causes the regmap init to read registe=
rs from
> the device to generate a default state, which is then used to fill the fl=
at
> cache. So this effectively replaces the (invalid) zero-initialization. Wh=
at
> feels problematic to me, is that only the flat cache requires this sort of
> "hack" for it to contain values that correctly reflect the hardware state.

Yes, that's absoutely a hack for the lack of sparseness in the flat
cache.

> Some quick grepping turned up 35 drivers which use REGCACHE_FLAT without =
any
> cache initialization (see below), thus defaulting to the all-zero cache. =
This
> includes the driver I think you found issues with on the pine64: sun8i-co=
dec.c
> If this driver (accidentally) relies on the zero-initialization, I would =
expect
> the spurious interrupts to also pop up when switching to a maple cache, o=
r when
> using the num_reg_defaults_raw workaround.

Yes, that driver is relying on the current behaviour - I'd expect at
least some of the other drivers are too. =20

There's two separate things here, there's what the driver you're working
on should do (which is to use a maple tree cache from the sounds of it)
and there's potential improvements to the flat cache, or adding a new
sparse flat cache.

--8NWmJnmdXfMqJS85
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmjySvkACgkQJNaLcl1U
h9DeGQf7BZeBGFkxXUEN07E3UqkWfvaaTJw4vcdODfbM/raUoLv0QNHylaDH445s
2wKH1vKu59C1Du5eqifrhs7o4JwB5o/2yCPkePZ/Peo8hz3g/QyoDN3mLAmKo3/F
M2CwAg5tNXD18ZpMb2g0aOhOYA1r8bpLMD4YbixYG6J3G179r5ZRP+o98vk/Si25
z3yinptml/eSXS6A/GvLdwdS4Yrzn9Wj5V+ehCxqlphvelxoIQVrW6EPMb0Zw/Da
zGiJSX4tLHO5CwV9b6lhDyt/YDsdCGAdTEK1NxhESW9vNi/VlQUaqtYs2dOa+pbP
qlP2kRknXvBukPwn0sP2IfvPGkBA1w==
=IQ3s
-----END PGP SIGNATURE-----

--8NWmJnmdXfMqJS85--

