Return-Path: <linux-kernel+bounces-830543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 064CAB99F19
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 14:57:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2775318960F4
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 12:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30FCB302156;
	Wed, 24 Sep 2025 12:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YMtq/SBy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E4C2417C2;
	Wed, 24 Sep 2025 12:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758718659; cv=none; b=kU7tePx6y3QsbBbQ19/gNxrslvcSZ1RVHf23o+AvXkHzyaY6dE2OLhe3ek4Qa1UOv6stTDj4WFox+womOxb2VrKiN3Q67SKAQBpyHO29PZWF7r3jTFHT+wfXXhLEYygLaSIkBomTJqy7HmFx/IeW1oo8iOxghTiZDoy5AOs1jHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758718659; c=relaxed/simple;
	bh=VG20TPc0vSAmEbBXOQRn+cY5clUm9F5ItXR7KZk0Ww8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d7OjGp7E/cd6mCCU22+gO8fcoAo3DZuIK5hx7KWmOgC/3ac6M3Ie7fIFuMXhyo6GLMbLVcbEJhi3t/51Pium7M5XlAG4kLls/boRsF9dBNJaffFW2FyfkmVV3JkIuYnV+wyPPe/8sY4a4pVk0S1iTJWp/XhJkNaHcKrzQI7P/GM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YMtq/SBy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79037C4CEE7;
	Wed, 24 Sep 2025 12:57:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758718659;
	bh=VG20TPc0vSAmEbBXOQRn+cY5clUm9F5ItXR7KZk0Ww8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YMtq/SByQ6iK2UkBgv5/kmBi40RN4P0XYKTALZjywJ3uaN/kHmmnmE/qudSKEbSSg
	 HaV3hbD281tfodz7aUI6qkbjfaBwy7pSwigmgVx1aNUFLFZQ9qwH8lZvyEYrV2ewCI
	 dKMOW6ZMBHIVTzcfk+pcjhQ13/exrBYe0Um+yR+IPIEGdleZIwJDTDaEmAeh00/zoW
	 sQGjUOGtYspA1P3J7pHhgG73mhfHDNpwhQEaDERWiIPLjnZqynN2HvwiuoScOqcpwT
	 XoLflD011vfmzP7dbQiDHTYMZy99mtY5l27KEiAoFY9wsuSIVvi6TrrEHCXo0IKx0R
	 Q2mmxMbsGmyvw==
Date: Wed, 24 Sep 2025 14:57:35 +0200
From: Mark Brown <broonie@kernel.org>
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc: linux-kernel@vger.kernel.org, linux-amarula@amarulasolutions.com,
	Michael Trimarchi <michael@amarulasolutions.com>,
	Fabio Estevam <festevam@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>, Takashi Iwai <tiwai@suse.com>,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-sound@vger.kernel.org
Subject: Re: [PATCH 1/3] ASoC: mxs-saif: support usage with simple-audio-card
Message-ID: <aNPqv15dnLCw3qew@finisterre.sirena.org.uk>
References: <20250924101640.2942635-1-dario.binacchi@amarulasolutions.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="MnrHIRL6ihxwJiWv"
Content-Disposition: inline
In-Reply-To: <20250924101640.2942635-1-dario.binacchi@amarulasolutions.com>
X-Cookie: Filmed before a live audience.


--MnrHIRL6ihxwJiWv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 24, 2025 at 12:16:25PM +0200, Dario Binacchi wrote:
> Add support for enabling MCLK output when using the simple-audio-card
> driver. In the sound/soc/mxs/mxs-sgtl5000.c use case, that driver
> handles MCLK enable/disable by calling mxs_saif_get_mclk() and
> mxs_saif_put_mclk() at probe/remove. This does not happen when the
> simple-audio-card driver is used. Extend the mxs-saif driver to enable
> MCLK output in that scenario.

You've not copied me on the rest of the series so I don't know what's
going on with dependencies.  When sending a patch series it is important
to ensure that all the various maintainers understand what the
relationship between the patches as the expecation is that there will be
interdependencies.  Either copy everyone on the whole series or at least
copy them on the cover letter and explain what's going on.  If there are
no strong interdependencies then it's generally simplest to just send
the patches separately to avoid any possible confusion.

--MnrHIRL6ihxwJiWv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmjT6r4ACgkQJNaLcl1U
h9DVqwgAhP2iqSkJ01DCJkMcimnnaPqL1BoYPz9SUVVCg24PgJgprD+E+gepAHr1
qgKvrq9lNgkRC8rbqU2oSB0sXcc1Pyymo85CERMqZLhF2ZriRI+W1iN85si8e9Iw
Oa4He4aXvw0UacsqQb+bj7w9JNjqGdB0iGbleQdzPBn2Iyl1aiuLCap98CPK8lLI
TCZoEaTSLOOHpBOlqYLTaqoJfeDjEDhToR4TI1bYuFbNz2d6ai6OgQoa78W69nWO
c9DOFsbll0dx+W+blKCNwwvLzQNt0QmCvK+STQwLqzTYOOMQXn4XCBNZY1sbO0Wk
F37ZIQT/6j7xA8l8k5YNDLGXw2opYA==
=2GTo
-----END PGP SIGNATURE-----

--MnrHIRL6ihxwJiWv--

