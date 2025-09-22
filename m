Return-Path: <linux-kernel+bounces-826762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C43E6B8F46E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 09:23:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D9C317EB0F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 07:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9B0B2F49F5;
	Mon, 22 Sep 2025 07:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uheiXmte"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 019722F3620;
	Mon, 22 Sep 2025 07:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758525786; cv=none; b=hERLhWrqnE2JvbIDfnNaQ7Eaaa2ONhY86FFFIzyNemw4cMD+ZuLNmwZMv8/Yn1upHJyM2Wg/DG/gTCyg8rYpiurIMGN8xpnjX4uET8yUhvCwyA5pmS6OclUo7/uMn8UnNP5VFQx4ZMta4s4NsLr0eYQbLt7SmRy2JB7bXcSXDT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758525786; c=relaxed/simple;
	bh=2FntwlF7Qmhm52NdX37IlJIx8sKgGdOwIqEh4HcAK7U=;
	h=Content-Type:Date:Message-Id:Cc:From:To:Subject:References:
	 In-Reply-To; b=jaVRrEBXff2CZfIOfHMf0Exfh7vlRbj/FkhrgceVXI6evl9Y4c8jd0KRxpzExI0h+zRFi/rwjxRd73r4I7UXk0cMClcm5qsdbfyBK5BtVzGY1YR6tp3jFAbmtfuA19wD3WO7XtIofys5HNLoukD84DR8Tuusz3eiqCQgH6nyBgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uheiXmte; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EDCDC4CEF5;
	Mon, 22 Sep 2025 07:23:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758525785;
	bh=2FntwlF7Qmhm52NdX37IlJIx8sKgGdOwIqEh4HcAK7U=;
	h=Date:Cc:From:To:Subject:References:In-Reply-To:From;
	b=uheiXmte5EO1l2O/1Bxl/0OvKSM8fmL9SyKJs+63bxigNYJ5vChAhHIPR4QUVyVlc
	 IwexTSRYnB3IyLET0ymbxZ9oYJDQrRvMkQsw21jRe+CskQtyREvK3b/01p2YbHFuYx
	 KJH3vz1E7b/liWq6qlgHXm8+OlSLVtvyK6KfvsIssskvrdqy+4ZasvhAKB5ki4LzS9
	 mCaF9fC23GEHKd6FRl6Xm3LCv2DdjrBaSAewIvG32rfGbUj64bAwrAd+SL0HouQUuY
	 kzCGqBRGpTBEMYZrzAAG1qZiAU9dyyGVY/TxmMnSB+EnCgvzMQNAhxE9Ye7IcxogI3
	 AK4+3wd4wlKkA==
Content-Type: multipart/signed;
 boundary=466225747a6c8626ee1778d558a8e4327766c754704dd9ef85670e13e3ed;
 micalg=pgp-sha384; protocol="application/pgp-signature"
Date: Mon, 22 Sep 2025 09:23:01 +0200
Message-Id: <DCZ5D3DB786G.3JANU1P578TCY@kernel.org>
Cc: "Andrew Davis" <afd@ti.com>, <dri-devel@lists.freedesktop.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <linux-clk@vger.kernel.org>
From: "Michael Walle" <mwalle@kernel.org>
To: "Randolph Sapp" <rs@ti.com>, "Frank Binns" <frank.binns@imgtec.com>,
 "Matt Coster" <matt.coster@imgtec.com>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Rob Herring"
 <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor
 Dooley" <conor+dt@kernel.org>, "Nishanth Menon" <nm@ti.com>, "Vignesh
 Raghavendra" <vigneshr@ti.com>, "Tero Kristo" <kristo@kernel.org>, "Santosh
 Shilimkar" <ssantosh@kernel.org>, "Michael Turquette"
 <mturquette@baylibre.com>, "Stephen Boyd" <sboyd@kernel.org>
Subject: Re: [PATCH 2/3] clk: keystone: don't cache clock rate
X-Mailer: aerc 0.16.0
References: <20250915143440.2362812-1-mwalle@kernel.org>
 <20250915143440.2362812-3-mwalle@kernel.org>
 <DCX03UL17R3K.1MRUGNR4PUIDL@ti.com>
In-Reply-To: <DCX03UL17R3K.1MRUGNR4PUIDL@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

--466225747a6c8626ee1778d558a8e4327766c754704dd9ef85670e13e3ed
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi,

> > The TISCI firmware will return 0 if the clock or consumer is not
> > enabled although there is a stored value in the firmware. IOW a call to
> > set rate will work but at get rate will always return 0 if the clock is
> > disabled.
> > The clk framework will try to cache the clock rate when it's requested
> > by a consumer. If the clock or consumer is not enabled at that point,
> > the cached value is 0, which is wrong. Thus, disable the cache
> > altogether.
> >
> > Signed-off-by: Michael Walle <mwalle@kernel.org>
> > ---
> > I guess to make it work correctly with the caching of the linux
> > subsystem a new flag to query the real clock rate is needed. That
> > way, one could also query the default value without having to turn
> > the clock and consumer on first. That can be retrofitted later and
> > the driver could query the firmware capabilities.
> >
> > Regarding a Fixes: tag. I didn't include one because it might have a
> > slight performance impact because the firmware has to be queried
> > every time now and it doesn't have been a problem for now. OTOH I've
> > enabled tracing during boot and there were just a handful
> > clock_{get/set}_rate() calls.
> > ---
> >  drivers/clk/keystone/sci-clk.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/drivers/clk/keystone/sci-clk.c b/drivers/clk/keystone/sci-=
clk.c
> > index c5894fc9395e..d73858b5ca7a 100644
> > --- a/drivers/clk/keystone/sci-clk.c
> > +++ b/drivers/clk/keystone/sci-clk.c
> > @@ -333,6 +333,14 @@ static int _sci_clk_build(struct sci_clk_provider =
*provider,
> > =20
> >  	init.ops =3D &sci_clk_ops;
> >  	init.num_parents =3D sci_clk->num_parents;
> > +
> > +	/*
> > +	 * A clock rate query to the SCI firmware will return 0 if either the
> > +	 * clock itself is disabled or the attached device/consumer is disabl=
ed.
> > +	 * This makes it inherently unsuitable for the caching of the clk
> > +	 * framework.
> > +	 */
> > +	init.flags =3D CLK_GET_RATE_NOCACHE;
> >  	sci_clk->hw.init =3D &init;
> > =20
> >  	ret =3D devm_clk_hw_register(provider->dev, &sci_clk->hw);
>
>
> Thanks for looking into this Michael. I'm still convinced that it's unusu=
al to
> report 0 for a clock rate when the device is powered down. In most cases =
it's
> not actually 0 and is actually just in bypass mode.

Yeah. And you can't query the clock rate you've just set if the
clock is off (and if enabled the clock will have the frequency of
the last set_rate). I still think that is a gap in the firmware
interface.

> I was told it's a way to indicate clock status and probably won't be chan=
ging
> any time soon though. Ignore the fact that we also already have a separat=
e way
> to query clock status. :)
>
> This series looks good, but won't quite result in a functional GPU withou=
t the
> following patch: https://lore.kernel.org/all/20250808232522.1296240-1-rs@=
ti.com/

Ahh, I was puzzled why it was working for me. But then I've noticed
that your patch is for the am62p. I'm working with the am67a and
there the ranges are correct for the GPU.

> I suppose I'll submit that again on it's own.
>
> Reviewed-by: Randolph Sapp <rs@ti.com>

Thanks.

-michael

--466225747a6c8626ee1778d558a8e4327766c754704dd9ef85670e13e3ed
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKgEABMJADAWIQTIVZIcOo5wfU/AngkSJzzuPgIf+AUCaND5VRIcbXdhbGxlQGtl
cm5lbC5vcmcACgkQEic87j4CH/hNrgF8CV5l++iJea0s6PucENw5DUZkbZSEGMn1
ZR8wnSzoN5SGQWqUOPXJvYmYWYcM4qs7AXwMCOBuHIVVjx5DeIm2+8kPY6IAMzxH
hc3PYUqyvo1MwSaREzSwn7SHKZ0vrp6ZvB0=
=0WRH
-----END PGP SIGNATURE-----

--466225747a6c8626ee1778d558a8e4327766c754704dd9ef85670e13e3ed--

