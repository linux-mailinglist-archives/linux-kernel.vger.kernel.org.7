Return-Path: <linux-kernel+bounces-761569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FE8BB1FBF6
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Aug 2025 22:06:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACDAA16A1DA
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Aug 2025 20:06:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20942212D7C;
	Sun, 10 Aug 2025 20:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H3NLYvh/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC6A35961;
	Sun, 10 Aug 2025 20:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754856372; cv=none; b=OT3knaJ3o68rLsDu6CSpmQOpju6BQ16IqSe6m2tRi2AAU4rmLEtm7OdW26HGqldqqngWB4WbHfP6OcRaU8Aht2KTbc4ephPDl0CFfL43m0bduCsaqQIMU5A+cw0iSdCEFcWdobCSoOHK4JJUcLoYJdETHVhg2ITk4NJwhImCGrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754856372; c=relaxed/simple;
	bh=pllPXHwz/RPDMfVWZIUSYUcNDnCv/UBWTzGkcJ2N38s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O4QABZIuFuTxk2vxA+rsPgSodPh2nOIKNFby++3FP19k5WYX84emdx6J7ZFdhaPhOwvoQfUcOMzXFvBL9G3QoSBej5u8OU/NrgIMBJRPxGcsb0SKiKpgb7JNXe4iGW8iEiO0nr/CFLE+wG46vX9ISxrUo+3Mj/CPAcEaLuWn8To=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H3NLYvh/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0D70C4CEEB;
	Sun, 10 Aug 2025 20:06:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754856371;
	bh=pllPXHwz/RPDMfVWZIUSYUcNDnCv/UBWTzGkcJ2N38s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H3NLYvh/OxabO0SiK5cZVEWn93Kv+ARL7zo9r/Rds7AniIen7lg8zXnDT+Qj24ZeB
	 tU1wY7gAQLO23yuzQlDhBEecaMUOp/RH6isbLedYKI3EVgIj3F4r8ZXsHRdBTPvReO
	 sIr3oMN3BYprmPlKfUDG0kqanvqSebAsZhccFyPJeOeMu3jx02UCCZq6SXPs1+GSLP
	 Kq/Y/1nqWckq+cDm2p+aq8smvhIf48kG6RRExDlGB+aXGKFmoPUXTAsI/2wEk37MEq
	 55uX4k2qvoZCfFJe5m/I9lbZj9+BBMnIoDDmgX6Mqn4wWt8ubQRhZbQHi1juUmPRAg
	 U+nTHxBB3lK6g==
Date: Sun, 10 Aug 2025 21:06:00 +0100
From: Mark Brown <broonie@kernel.org>
To: Baojun Xu <baojun.xu@ti.com>
Cc: tiwai@suse.de, andriy.shevchenko@linux.intel.com,
	alsa-devel@alsa-project.org, shenghao-ding@ti.com,
	13916275206@139.com, linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] ALSA: hda: Add TAS5825 support
Message-ID: <034afe16-4027-461f-bf5b-d95a15d6a0e0@sirena.org.uk>
References: <20250810122358.1575-1-baojun.xu@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wP2b3y7eRXX+SnBm"
Content-Disposition: inline
In-Reply-To: <20250810122358.1575-1-baojun.xu@ti.com>
X-Cookie: Natural laws have no pity.


--wP2b3y7eRXX+SnBm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Aug 10, 2025 at 08:23:58PM +0800, Baojun Xu wrote:
> Add TAS5825 support in TI's HDA driver.
> TAS5825 is an on-chip DSP, but no calibration is required,
> and no global address support smart amplifier devices.

Acked-by: Mark Brown <broonie@kernel.org>

--wP2b3y7eRXX+SnBm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmiY+6gACgkQJNaLcl1U
h9DVdgf/ZWlTUDmxwnNn4h43uCr2IBqCUeAB7aoggFcVR0fLtr5CikECiBbtqaFe
dHsG6JOJitCG/cauQyL1UcX0nyjVMng7SULHUvkRO0bbw7Hptz4MLnm4Kdws2h7S
/K77hWkRCieJLMI43SHwnUu7LFad08lxiIqMIsteBtVQ3C6BMN0s57ufaQ35dA8v
qSt42M9ZwS+N9cJtdci2OB6uRbxh8aBeN9kCDMasp+zzrpKbvRdz019rm06InTsN
iWmJ1S8g9PiFIMHW3ArC2ZIb/QdI5qHdJsQ9g6M7+A8q2qogI+l9rwXTICHbMGjA
1m2H03DYMOrJpk5wu8GzFGbSKNQ7EA==
=ZfyP
-----END PGP SIGNATURE-----

--wP2b3y7eRXX+SnBm--

