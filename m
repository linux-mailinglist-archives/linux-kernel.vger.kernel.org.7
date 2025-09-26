Return-Path: <linux-kernel+bounces-834038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 04A88BA3A63
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 14:40:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B89DA561B44
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 12:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEB342727F3;
	Fri, 26 Sep 2025 12:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ejIurmpp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C62918C02E;
	Fri, 26 Sep 2025 12:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758890429; cv=none; b=h3qdhUIK86LTZW9z+sKE9uwXXTW2asVFwxpquwffMOoTs80nIiE4rNF6iYOYGcIi4Klyi57k92e7iROoMdHw9n9y0cZSe04nPt2czTOcHPxAJ3iOyQ2BMS1GP/Oy+9QMOWsDAicAj/WwGTwqU0HbCFT6HzonMBF4hwVtPc9Mw2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758890429; c=relaxed/simple;
	bh=D8VNkutOFVbdB+WTbKEdA2yGUCDNpWcCrSFM27oUxD0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hZdR8k4v2bn5ADw/QNQDP9Si+RrzA6wu9Z3l+gLkglKRKKE7/END5fnqQjuMWxan/BBbbnUzoIUTTFq6UkgUGSlMNkJU0GRTFhjarvl6p2rS6e3Luv094GDbmtZAWAtag5FXVJyozFB2Z1hIso2m26OiPDAUAX3yVyZ7rPRIegw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ejIurmpp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA810C4CEF4;
	Fri, 26 Sep 2025 12:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758890427;
	bh=D8VNkutOFVbdB+WTbKEdA2yGUCDNpWcCrSFM27oUxD0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ejIurmpp0T7KnXvLld8UsNcXf3yqMnnkMF5JWl3wu18/Oyc1BNP/yxR3Jin2MbMmD
	 qfmwk+aVsQk6d6G1c5EuuYOa0q2mBvIYrOs++7a+htid9ap9q8ckFoWdUtU9P2XSf6
	 mIZBIKvlVgo2z8mrGc33u3AqMFMyKy2D0rzEc7zrR38ZwmMd5QSMygTiQEf58k5YkY
	 cjoioGzU8+FO4/sM4vbVGUzAczFqOdduLix/zTiukLCfxsUzFpJgi0vUIHRMG6T+Vn
	 flxER02GUY2gtp29pLcKugPo32xVtH/kOUzjSVlynFLLdfwKAzIcKWlkUvGG8Hxt2W
	 KAp3qOCxfplGA==
Date: Fri, 26 Sep 2025 13:40:18 +0100
From: Mark Brown <broonie@kernel.org>
To: Baojun Xu <baojun.xu@ti.com>
Cc: tiwai@suse.de, andriy.shevchenko@linux.intel.com, 13916275206@139.com,
	alsa-devel@alsa-project.org, shenghao-ding@ti.com,
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
	lgirdwood@gmail.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, devicetree@vger.kernel.org, k-yi@ti.com,
	henry.lo@ti.com, robinchen@ti.com, jesse-ji@ti.com,
	will-wang@ti.com, jim.shil@goertek.com, toastcheng@google.com,
	chinkaiting@google.com
Subject: Re: [PATCH v2 1/2] ASoC: tas2781: Add tas5828 support
Message-ID: <31fc3ce7-59c6-401f-9681-fd75764e9124@sirena.org.uk>
References: <20250926043339.8419-1-baojun.xu@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="EIWsqXtN7cfBcYJJ"
Content-Disposition: inline
In-Reply-To: <20250926043339.8419-1-baojun.xu@ti.com>
X-Cookie: Your canceled check is your receipt.


--EIWsqXtN7cfBcYJJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 26, 2025 at 12:33:38PM +0800, Baojun Xu wrote:
> TAS5828 have on-chip DSP without current/voltage feedback.

Reviewed-by: Mark Brown <broonie@kernel.org>

Takashi, this would need to go via your tree (though I guess at this
point it's likely to be after the merge window and I can pick it up).

--EIWsqXtN7cfBcYJJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmjWibIACgkQJNaLcl1U
h9C6uAf/alhWSE8NQd8/eJDv+fU4N46SAore2/8P4xw9zzzJEch843K5n0unLXAS
3e6gEbfkGpz6g/Wdp+cQXZshbMf72I51Jci1W/cQcOkT/n/HOPJtahLpUONo0joH
WwpDJFW0AoT6kOLcB57t8EiIe8Ye/84qFGX241PPwgQzSBOaLzhJSFPJbslwDDmh
E6fpLB56cddQHKXyaK17QjU7dKTEzixP+lFqDuihF1zCFYVfG741Y8pbUPZseEAy
ut+wWKA27dtVpgqGRXFAG+JY2taXhP5FiBOBleYyqKa30C34fjitqWILao9n+KgO
sFiE1e92zUbjCRi+XLtJzNTCL8cmvA==
=3xMG
-----END PGP SIGNATURE-----

--EIWsqXtN7cfBcYJJ--

