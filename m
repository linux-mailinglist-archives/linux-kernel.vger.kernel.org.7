Return-Path: <linux-kernel+bounces-760173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A848EB1E75D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 13:30:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57BEBA022DB
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 11:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A415C2749DC;
	Fri,  8 Aug 2025 11:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MMl4EInZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B197A272817;
	Fri,  8 Aug 2025 11:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754652630; cv=none; b=IkmopyC056Psj35vyfRurD+gEU1Gdz3gsqVCPiTHmV3L9i43Vwto4ErUll8TewUXrXromx21Qw5beJGyWSrVWn+IATRCncm5XTg5Sj4hm6uaDcfVjKpW9LzDsxCf1uRus6ujx3pzNfo9SunZCmpJUD4lp0I3hpzi/0YlhzUxieU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754652630; c=relaxed/simple;
	bh=wZEIKyE5485Mw3BWBNh3QazLxP+D9x1Qf1L1CJP7GoY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YjXRMwsqsjmjtaj8uw1/rPkM7UoF3HIvNOI32e8yoxBIAOB3zR6OdRcva7WMkHBxPWlrhz4BopNQxG5oKAqdWmWNP7KnVD2SNuvLliJqJccy5LajWxF4MnMS45k0s/f5b4shrJiINZO3r1fSzmb6YrgoBLqTQIKM1dBgOtUvZpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MMl4EInZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76B84C4CEED;
	Fri,  8 Aug 2025 11:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754652630;
	bh=wZEIKyE5485Mw3BWBNh3QazLxP+D9x1Qf1L1CJP7GoY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MMl4EInZB1rbLM3BVhrG0G0sDKTZ+eATghJt8c0XCH5tUe2Z6h6XGnnCkG6vX7U6D
	 mS99eoIZiHdja59GbE2GtxOKBrvsdUKpFzHKaazU1LB1EJLxmd4fOTzZO/6cygnayr
	 QHtLBQzj6Zlnzq24x36OW7ocSrRxJhqn9/s2LPy6f44AILQdzhgUq1l9Ns+ou3kujX
	 PtAi7cDf4aJ1PvicN58DZC5QUYNGTd48XjOPnVoZm9KiEltYKyA7jr2MAs01CpltSy
	 td1bERVZc+JX8/YXohtSF6Dgg1yNONodekMwY8mgN4o/zP2VkPgQVq6RV/IYCtwp+F
	 LRdU/QqnCsb9g==
Date: Fri, 8 Aug 2025 12:30:25 +0100
From: Mark Brown <broonie@kernel.org>
To: Colin Ian King <colin.i.king@gmail.com>
Cc: Kiseok Jo <kiseok.jo@irondevice.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org, kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] ASoC: codec: sma1307: replace spelling mistake
 with new error message
Message-ID: <f646f36e-7835-415d-8da7-fc632c57e4e2@sirena.org.uk>
References: <20250808105324.829883-1-colin.i.king@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Yy/TZTxovBDVddSO"
Content-Disposition: inline
In-Reply-To: <20250808105324.829883-1-colin.i.king@gmail.com>
X-Cookie: What an artist dies with me!


--Yy/TZTxovBDVddSO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 08, 2025 at 11:53:24AM +0100, Colin Ian King wrote:

> There is a spelling mistake in a failure message, replace the
> message with something a little more meaningful.

>  	if ((sma1307->set.checksum >> 8) != SMA1307_SETTING_CHECKSUM) {
> -		dev_err(sma1307->dev, "%s: failed by dismatch \"%s\"\n",
> +		dev_err(sma1307->dev, "%s: checksum failed \"%s\"\n",

It's definitely an unusual term and the reword makes sense but that does
make sense to me as a word, I don't think it's a spelling error as such.

--Yy/TZTxovBDVddSO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmiV39AACgkQJNaLcl1U
h9ALZgf/R9yfaxi5LBB/HQrL9Xh5gdF+BUGogUyAZkM4X6a6fUUCO0EMVvEX2Y/I
AA9nNjMnPXG6/qUUTvAs1ka7x25CJCT8zTRHsda7cYmwk+dS6hCRjQiJvjhA22qm
swAAM+YeY+QoJ5Qeq1hwtDPHpz8TRovwaRVnt1k4DynavJ57/OqliybaQfPB+v6L
xsZeJF4aPWJ/mPuMy3zas1uGZNcoGa84hxqhl0Uyyf1fAeNKHGQK1kOxjeOpPgDY
cJIZJkDexUd5muWDH0UBZ5aPdu/gViVR0frWllEx2SJx9uRpTLYqAw26ljpJ+ymC
XOfEUuY6Z2xTa4lntqCwByFL9VWubQ==
=Lz0h
-----END PGP SIGNATURE-----

--Yy/TZTxovBDVddSO--

