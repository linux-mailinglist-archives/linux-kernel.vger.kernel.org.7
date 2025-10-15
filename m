Return-Path: <linux-kernel+bounces-855127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38F0DBE050B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 21:09:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5656E427176
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 19:09:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC70E305044;
	Wed, 15 Oct 2025 19:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A2jZX8Tv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CEC8303A27;
	Wed, 15 Oct 2025 19:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760555336; cv=none; b=iCeUAixwc/6vEXWZ/xzNQb/s+wqHYTut6lBhCa8FmUFZfkgCo6t4Iz/sXcPUl9CqveqE8qfCjyMJ5y/QyFb6OE3SFxeBYOQoOHj9ILzuJnAwwCD9wHh9l97TglmvFav9m/14L+x4KRlcyRFyeI1MRzH7Srm5L74RkKr4UiH1TGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760555336; c=relaxed/simple;
	bh=aWG9O1/Dym+WL0DOXQO8ZFYK3N5DSHC8DNu5QxxmCyQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V2zRvAFCJiriXnHVg30f23cW5jGQUElkoK2h9UPkqfMq/BRvetlaqhgBACXqiUnuDlYKk7p9kCFNzew22QCreUD1MWfyH+bj0nuXtq2n5ZehKw+AQqNwkR9Un6XpWiz9TyTTh0G9cekRaN3yHm+IZfajEWSkfjJZKy9h1t2+G7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A2jZX8Tv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A4C0C4CEF8;
	Wed, 15 Oct 2025 19:08:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760555335;
	bh=aWG9O1/Dym+WL0DOXQO8ZFYK3N5DSHC8DNu5QxxmCyQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A2jZX8TvxvEnMb/sYF1O7Rh5t268OyJGgh87kkTjL/eMEtcFJxjshVV0I3CybXJhc
	 kMcCIPsL8wMEY1Op9N38ISofkTqRx8wTTSxpe/LQyogk8iN4mjnr/Vv4kjkD8pRmEy
	 Poxn+mgdA9l8Raruo6ovNL9MZjbHLYPoeWXz1aosSaNnbNrO/Ie/0hbgqrFSld/9sy
	 E67gBQ9PSd6L0TE7UgjZF6MkoJlQ48QMuhc6MkNY/HcIUr1ls/g2hKNqmKGS45CSbZ
	 nOgSLMUaOUz778XcaXmP8ixowIrYCHUxXCCTLcvSQXSEm6RE6RSrLRgpDKG41QOPoE
	 ndpubYr1daVQg==
Date: Wed, 15 Oct 2025 20:08:48 +0100
From: Mark Brown <broonie@kernel.org>
To: hariconscious@gmail.com
Cc: lgirdwood@gmail.com, peter.ujfalusi@linux.intel.com,
	yung-chuan.liao@linux.intel.com, ranjani.sridharan@linux.intel.com,
	daniel.baluta@nxp.com, kai.vehmanen@linux.intel.com,
	pierre-louis.bossart@linux.dev, shuah@kernel.org, perex@perex.cz,
	tiwai@suse.com, sound-open-firmware@alsa-project.org,
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sound/soc/sof:Use kmalloc_array instead of kmalloc
Message-ID: <fad32f5c-f9a4-4cf2-9082-845deff309ea@sirena.org.uk>
References: <20250923142513.11005-1-hariconscious@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="DghlwrYu+gIPr9Hd"
Content-Disposition: inline
In-Reply-To: <20250923142513.11005-1-hariconscious@gmail.com>
X-Cookie: Long life is in store for you.


--DghlwrYu+gIPr9Hd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 23, 2025 at 07:55:13PM +0530, hariconscious@gmail.com wrote:
> From: HariKrishna Sagala <hariconscious@gmail.com>
>=20
> Documentation/process/deprecated.rst recommends to avoid the use of
> kmalloc with dynamic size calculations due to the risk of them
> overflowing. This could lead to values wrapping around and a

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

--DghlwrYu+gIPr9Hd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmjv8UAACgkQJNaLcl1U
h9AE3ggAgBaC2BwzFWEen9uUH73oFXv3vFgu9MrvlUciFbwuITGfiZcqq6VmMhky
U7V0/hXBUoEt6z0UdAFhMC6P76wLczrhz5i0D+l87ZcHX2mNz3Q/14U7fsHL+YqS
XQh1xHv8VSme4d/8n/3OS+fI7pAYUUyQ71iRjQGk5fn8PGRTNS6E/4hZ/U7tKNC/
2lV5yWBeIOARAFk3A+KSJdfxy9VAmaC+XgwpGKPjEzQr48m/LAUgD0W3yBXmrfyS
4QO/3Y9yEjMIBYgX7+/L68ebV9ON7SH1naQ0TP/SP4ojtcaboFFY3bn6uWOM1R+P
yLCEowuxBUBHEHFM7XVulBNEDVJx3Q==
=AQZF
-----END PGP SIGNATURE-----

--DghlwrYu+gIPr9Hd--

