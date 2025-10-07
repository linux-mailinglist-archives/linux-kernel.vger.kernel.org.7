Return-Path: <linux-kernel+bounces-844322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD299BC18F3
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 15:48:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 685B23C469F
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 13:48:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBC832E090C;
	Tue,  7 Oct 2025 13:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AGo78e9G"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CF5CEACD;
	Tue,  7 Oct 2025 13:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759844886; cv=none; b=dtoaOLfq+1flptDbx1WUuTXJwmIlZ8VExm9gjbBeEnSk02dYbMep2t/Jkuw6VV/NEhLKlnbJwf4TlYYhna3s5srbITEdQStXGeUZn1AAaCMaq/NvKOeZ76jcDlkmaiogz7ejxtnJf25g0UBPY8fic+n9uUlkwx0wG4PfU/BVNdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759844886; c=relaxed/simple;
	bh=4/4SX/q9VB4cE9kuVPhWF8KCi+XreZkiVVBqTifUcAA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sytDcMoVLWzFKPLX78M2RJldeZEFWMgRHmFzthWEBU1Dim3lXKurrcIgxlTOc6KDMPSNbyLyl6r3TfeCu2hwtUCa4mybwRHXazWEVJQzsSS8XP2jCiG55A7kpnYXngosElWaSvPRLFjvt1ZBUsVe7dRiExdGEqMtfsabS+PI9kY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AGo78e9G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E44CC4CEF1;
	Tue,  7 Oct 2025 13:48:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759844885;
	bh=4/4SX/q9VB4cE9kuVPhWF8KCi+XreZkiVVBqTifUcAA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AGo78e9GvCJP4T9EDZNxVyHHe8i4RI1V5D4fdiXpBNuuqH4DbEhY4ZQlciLOpOPmB
	 Qk+KC/m91wjzWIkG8qqU4rmQHDbnXPAuIm6ysv75TO/vXhhR9BLuHMrqS6Zyswtbhb
	 eg4qyc58/8jSnMURatPCObsAUG2DtKhgEo5tGZOl5wfRozRtGK8/n0TZHoMWOBl8qt
	 8b3yEboEyoTE6UReBIVEZdZi3GHYrhUHGHAzi+6bLXIL57TCcx42OpzckoHBoTXk6X
	 hcZnhoH1Rnkt9OzX0IPBxxvSuyDlpQ5wTV0WAY76V2+m/hyPbqRIfskbw9Eog3xEMD
	 p12yoirpyWSIg==
Date: Tue, 7 Oct 2025 14:48:01 +0100
From: Mark Brown <broonie@kernel.org>
To: Sune Brian <briansune@gmail.com>
Cc: Charles Keepax <ckeepax@opensource.cirrus.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sound/soc/codecs/wm8978: add missing BCLK divider setup
Message-ID: <ec917317-4240-47ff-bb9a-6f2fe9068c19@sirena.org.uk>
References: <20251003091304.3686-1-briansune@gmail.com>
 <aOTrsYllMst3oR03@opensource.cirrus.com>
 <CAN7C2SB5Re35yGYsqr14hGXde3nTKLX2Aa3ZbuJ9xuT0m07uxg@mail.gmail.com>
 <aOUDbF/i4+9PXc1j@opensource.cirrus.com>
 <CAN7C2SBsFQJ2qNe0HLfpG+6cuONtpChBnq6fuFkd_CGkLt2c5g@mail.gmail.com>
 <aOUSZ2pnxRfxEPi4@opensource.cirrus.com>
 <CAN7C2SBDC2LrWpUTe3zZakHCrmUy1nQ-WiguLQKVK1CyOPb9zw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="EFN581FX+K83+URe"
Content-Disposition: inline
In-Reply-To: <CAN7C2SBDC2LrWpUTe3zZakHCrmUy1nQ-WiguLQKVK1CyOPb9zw@mail.gmail.com>
X-Cookie: Teachers have class.


--EFN581FX+K83+URe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 07, 2025 at 09:39:59PM +0800, Sune Brian wrote:

> Before the below action started. I need more background, if possible.
> If my understand is correct on your ideas. Do you mean the default driver calls
> the bclkdiv on other places? But how could that bclkdiv # be correct
> from first place?
> As I had mentioned the div # ifself like this codec is a LUT rather
> than the actual divided #?
> For example /32 from LUT is a 3b101?
> For example what if MCLK is set higher than /64 could even out of the
> LUT from first place.
> The external div # passed in, how to ensure it is codec LUT compatible
> from first place?

Systems doing this are using a machine driver written for that specific
machine and will know exactly which CODEC and other components they are
dealing with.

--EFN581FX+K83+URe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmjlGhAACgkQJNaLcl1U
h9AM6Af/eZL0C0ipwU26zrj2GjyQpI2PmWTyayMGQRploTw4F3uO1jK4v4UHjSJy
8xFRvRFll8FWv+d4sSXjQOiz1aHX0SaHjGHUwYHBx2xwty8dRearUwuIrUFkGWUf
U40wGclX1Kbqlxu6KVYYIG0NYKFq4W8gAcq35nXwYgGmPwVaj9p8fYR957Goz5K2
6gDoHf6X5SxNFT6JKt7ZCbX6aFZGZsYnDMF2+spx+qlk4INRzc0GQ/GaEsmGYmcO
WsDFIU594snCbSW6lDAZDJFUHnmSjWE5gP3KgcTdWaYQ8CdSHMYED219ZOLhKsUV
8GP4RGhu9PWPDQbvbULYuLIgdh0DYA==
=FYKp
-----END PGP SIGNATURE-----

--EFN581FX+K83+URe--

