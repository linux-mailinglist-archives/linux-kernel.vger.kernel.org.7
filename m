Return-Path: <linux-kernel+bounces-826979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 08FFFB8FC9F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 11:40:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D14B1189ED13
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 09:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 238FA287513;
	Mon, 22 Sep 2025 09:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uvJMnWa9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A9EA22758F;
	Mon, 22 Sep 2025 09:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758534007; cv=none; b=M90+FdR2MB6LEL56/RWHqf1p5teu+xRFuIBAGHMclqNDIUn8+ePUcEl3ClejMTV3gFocsfU2u7KNlLyWO8M4ptoA7Cc0e1/Q8pL8BAdKPpHLjWf5QJewV4ElONGM1D2yLIqHio/eq8VNfIDucDRFJOA/hPjLladukCCqMUSGaWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758534007; c=relaxed/simple;
	bh=o6odwIioUUT77Fg9yWNjDxSm+/A6LvZVTlgfH/VUWHA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XO3P+BQsoPOb1DrdJCoQse8nn3n0jzIs7MBKOgqhwqGglX9KuiuXSBO0zRho5h11VyAalTiXYznT8HEw2STbq7Y2vEbWE8qAN0Z/voour1AZFUjesrEheJGus+o96N8KfXiywa3NC7hToVvmJ2Gl4oZJJ5eLifLaYdpB1mu5bt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uvJMnWa9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 508C6C4CEF0;
	Mon, 22 Sep 2025 09:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758534007;
	bh=o6odwIioUUT77Fg9yWNjDxSm+/A6LvZVTlgfH/VUWHA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uvJMnWa95WX7LGlP5Qwi5rMwaTkQLQEnbAPQPlQi5MnOLwUWQP0Cem/BfsL5FnPwP
	 s0+24oBlDBbThQdNOAJqz2TFXDBqBpAUd8pBLNoNFYpRKupxsYkgR99Kesmf8QlBEp
	 Abew5J0sC6fj7BEDGH/ubfk7J+pTeykPX2kfE+4evvvjnEay/K3nqZGAevS8TXr02E
	 eaaCaeNBMf347EVeA7Xlj0V2sFe5M9f+/SNoB/PJC2ubIz3mGN+Rx4XrcIOrbYBa15
	 qGOkoL6Wq1FvSX3+XjLKucG/ZEFLO6BY6PD3u2c6Ziksgkol8G8I7EOcnjYITiiUrp
	 +E805szz6HQhg==
Date: Mon, 22 Sep 2025 10:40:00 +0100
From: Mark Brown <broonie@kernel.org>
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Kevin Hilman <khilman@baylibre.com>,
	linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/26] clk: amlogic: clock controllers clean-up and
 factorisation
Message-ID: <aNEZcNbSfJlkP7Ra@finisterre.sirena.org.uk>
References: <20250702-meson-clk-cleanup-24-v1-0-e163c9a1fc21@baylibre.com>
 <b88a947c-7074-4fed-8283-c278b573a7ca@sirena.org.uk>
 <CAFBinCBe3LhN+3beovFVuWPpe3pDF5P1wSt7nPjm=ykRAx4zzQ@mail.gmail.com>
 <1jldm855cd.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="0U/sTuh5QZlkIMvs"
Content-Disposition: inline
In-Reply-To: <1jldm855cd.fsf@starbuckisacylon.baylibre.com>
X-Cookie: Filmed before a live audience.


--0U/sTuh5QZlkIMvs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Sep 21, 2025 at 02:59:30PM +0200, Jerome Brunet wrote:
> On Sun 21 Sep 2025 at 14:21, Martin Blumenstingl <martin.blumenstingl@googlemail.com> wrote:

> > A few days ago Marek reported problems on an Odroid-N2 and provided a fix: [0]
> > It's not queued up for -next yet.
> >
> > Please give Marek's patch a try

> Being on the A311D as well, it is likely to be the same issue.
> I suspect you would not see the crash it without earlycon indeed.

> The fix is in clk-next already so linux-next should get it soon.
> Sorry for the inconvenience and thanks for the report.

If it's supposed to turn up in -next it's probably easier for me to pick
it up from there given the firmware issues with the board, though there
may not be one until Thursday.

--0U/sTuh5QZlkIMvs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmjRGW8ACgkQJNaLcl1U
h9DDQggAgiEc2INRax0E+QPt6OLJRhJ0izyMuuq9C4NNk9FZ6uxptjkqn3vIr8ke
A5QqfhxdGYJyNatPT2Z0nwLuAcpOzJ9sX2Ry0FNLmIgo06wTfuAEokP+eDpqbe5G
HRfbJ2ss0g8Wg3Dc/ONwinFAP5QUkmU/Z257CtQ8tyyCHlRvaIIa5ClmEBHIN1RS
p1wO3tDt1UEMtH2i9naLEfZ8OlDSI+oiLFyEu1HKEIYq64yjXcDESxLS/Bzc3YoS
XYsLaby29vMQX6WPwzEq+ou7ZcOQF8UfJ/Bfr6dgLGaj3rDFx6zEAFSGpJM26ZmM
5+vVO9dMOj09VxweqK/PXARB+G8VqQ==
=BAPN
-----END PGP SIGNATURE-----

--0U/sTuh5QZlkIMvs--

