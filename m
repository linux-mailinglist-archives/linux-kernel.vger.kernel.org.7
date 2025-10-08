Return-Path: <linux-kernel+bounces-845580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 431E6BC56BD
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 16:21:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1A02F4EC572
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 14:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 658D22BF016;
	Wed,  8 Oct 2025 14:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NQJSj+Z0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA0829C343;
	Wed,  8 Oct 2025 14:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759933246; cv=none; b=m87m5C1laT2c7W9EBvzL8YnpzzSP5qNWsCxA09wzgMk8Tu0pTSf7XlrbMyI5jHO5Rg0TSB2z/VRHORgeAXPNaSTu3WlO7KRL0aPgN7dQWBI1407moDAJj7wylGSe7IWIleK+ykrSxCv07B7UsKKc+lkYTTGcZykrJzB+rI5d2B8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759933246; c=relaxed/simple;
	bh=6a5qfTHpJTVJJ5ht3JIEElvMvyIVarbrOvy86nHaVEs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mDPSl4cDHZ4ex/WL4vAnFjWEONezOHrnQCbheyroxwppmj82xHvaxJCGXVVxDyFDbxXQGbGplLXkCcUsScW+mUJLpTuZv43EyUW4s2EBa0q16OaD0RW+OVyTcamEV8SxImvwHIxJ1M/7tX0q1jMt4m2ZsVjsd8F2I2XPnWfwjz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NQJSj+Z0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46826C4CEE7;
	Wed,  8 Oct 2025 14:20:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759933246;
	bh=6a5qfTHpJTVJJ5ht3JIEElvMvyIVarbrOvy86nHaVEs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NQJSj+Z0d7keux9c9BcBwF6Xlq66XCJgWO6o0Lqonz7yD7wmbntX9cGb/HncJK4Ny
	 mK9Nh+o5S65gzwVB+Vn112HZi17B0uDihvsbyxKj8ciuOlhX3Tpo8nwh9xGMNURocd
	 XyEk95t4aXRoYo53v2ciQHsDmnlHG3WAEDdqoC93mkhxUB3X0p57re9Zj8kECdZw6D
	 gByShP3GTpUIaTGjuyjA6/HGaq3DzW+uKlIYMQ5oUZR35R7bC7GNh0tOl7xv58Okgr
	 YjC5HSFAOhVNztkzF3zMPEnUv2rCr4NbLhmVrxkwhRCnXJo0f6GGrQJ2tzC30qYBkh
	 ZeJcPQZD3IAmw==
Date: Wed, 8 Oct 2025 15:20:42 +0100
From: Mark Brown <broonie@kernel.org>
To: Sune Brian <briansune@gmail.com>
Cc: Charles Keepax <ckeepax@opensource.cirrus.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] ASoC: wm8978: add missing BCLK divider setup
Message-ID: <f15af8e0-3bf5-4dd5-85e6-07d00f8b020c@sirena.org.uk>
References: <20251007145028.1845-1-briansune@gmail.com>
 <aOUv69rMkyYFiHae@opensource.cirrus.com>
 <CAN7C2SDUiuMfPs_X5r0RDC56313aJsfhfx0-juhZRKGTb1OKuA@mail.gmail.com>
 <e78c9cc0-4a1f-4a22-9cba-a8213a7b9301@sirena.org.uk>
 <CAN7C2SDMB8_b-m0ZMzuSmhHxWpA10mcxxxDMKWuNe6wfiEXo-g@mail.gmail.com>
 <58756837-9be7-4027-b951-401ceeb69e4c@sirena.org.uk>
 <CAN7C2SBG2EZ4CJKR_vWKBGsKpZTF_9VJXj7ysLx38nJW3dFxeQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="AlnqrY1VvDa6/ETV"
Content-Disposition: inline
In-Reply-To: <CAN7C2SBG2EZ4CJKR_vWKBGsKpZTF_9VJXj7ysLx38nJW3dFxeQ@mail.gmail.com>
X-Cookie: 10.0 times 0.1 is hardly ever 1.0.


--AlnqrY1VvDa6/ETV
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 08, 2025 at 09:46:07PM +0800, Sune Brian wrote:
> Mark Brown <broonie@kernel.org> =E6=96=BC 2025=E5=B9=B410=E6=9C=888=E6=97=
=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=889:40=E5=AF=AB=E9=81=93=EF=BC=9A

> > This is not OK, BCLK is 99 which is less than 100 so there are not
> > enough BCLK cycles to clock the samples.

> With all do respect.
> This is not how IIS, left/right-just works my friend.
> LRCLK and BCLK must follows.
> This is no pure sample rate concept.
> I hate to explain my self.
> If this patch is not good I just give up.

Many devices (including all the Wolfson ones of that era IIRC) will
happily just ignore extra cycles on BCLK, the issue here is handling of
a f_256fs which is a bit off what it should be for some reason.  You're
assuming that the device is clocked at an exact and suitable multiple of
the sample rate like it's supposed to be but in practice these devices
work well enough for the system's purposes when the clocking is merely
close, they tend not to be particularly fragile and users perhaps not so
deeply concerned with audio fidelity.  Note the warning the driver will
generate about considering using the PLL to fix up such misclocking.

--AlnqrY1VvDa6/ETV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmjmczkACgkQJNaLcl1U
h9ALbgf/cHksH7d29W90hSmZYxlAXeVwuiY/byPt08C/N1qvbgMAQZYwtrUV7/ka
bQ24aVI9I+dg+9fFoeup7i1xNgp9Y3A2CXYMmqvPrspX6ELeFHhGrHiajAQV6taJ
cGmbVMx5eQTZHnPwWzC5XtqcPkB7VenZJ1AuAldzRLDND1U4koihFlM6DRD25k3A
bd1c/j49/wn/m1yOaHPY24cMPtJ6VJMQrH2NTcX9ACGS85SgXqC7TkjvMdLXzvs+
THQtP8PT9v5ZBbEyobgun7vOOwSKRtXjDPHtFu43cvodMSvC2jKpeLaGzHzr9925
7c7vgdvu0T2zjYCMwzibfuGzYAojQw==
=lDtU
-----END PGP SIGNATURE-----

--AlnqrY1VvDa6/ETV--

