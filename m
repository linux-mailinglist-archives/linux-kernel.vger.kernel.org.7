Return-Path: <linux-kernel+bounces-806424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 50E97B49696
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 19:10:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDD3F1C22B1F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 17:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F054A311C31;
	Mon,  8 Sep 2025 17:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tk8kGXq9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D716305970;
	Mon,  8 Sep 2025 17:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757351435; cv=none; b=Xm+ltJwQsCcW7+xFHoZT+zs7NnB4/sWJpSMm9WlHoeDc6cd8Qy5ksQ+rxyYwviQyonYOSmg8rc+4N0VfT8wX8/IYaoGhWdfqrKF38Ogt81mQfK4Ec0YnWp1ldP2Qt9WNDPdLXOqWZiiC8DZmdTKPuGIQRzP4oGC1RS6pY4icPRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757351435; c=relaxed/simple;
	bh=W7ZjuTlEOwtXCnjihP+ONmRgNNY2Qrkb/fLDCbAG+Uo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FdHrhHyhU8zexg/Rz1lnStAOVvMELAfxt/nY8Vj6V81XX+c5VFE8ctO5FjVvPnb/oBK4gNTWF+PDMSSNgKdTtYqqtatDjfhpGnCPtSI6lBIrbcWYxDVkabkjj33RZULgUyaE1QB1RilyS9pXWSoAU3Zk8ghdWunCE75lXJIlYqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tk8kGXq9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9F28C4CEF1;
	Mon,  8 Sep 2025 17:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757351434;
	bh=W7ZjuTlEOwtXCnjihP+ONmRgNNY2Qrkb/fLDCbAG+Uo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Tk8kGXq9QBtgZrdFo/n3vuQp/auP++O89rnilB+a0+axf7iThox/UFHD3u+iHDWKe
	 ZOGqOX4LDC+vJNntHb9HxrluLOZcJ54s5PSlKd3dqw3LLrautndhzS4a3sZvVKAm5n
	 UjOEnjp7fbpEQFxUexOS60RTmPuR9ktNtZRAbGqqtVZFgxNifd8gy/q6EjNVp+Y+dp
	 WT1oUxef9h7tFs+VdwRZB6NMJ0nzOMgo/sQ7qGcEy9Sf/a6Cz7kbnDL0KMDSyqBgPj
	 PDpaNF0F8dAroBC6DHJjGVyKjiWFvHi+9EiSkLu9MVQ9D+nDxMmyqjtz2Kbc2em+z6
	 DxREZyTYxkzgw==
Date: Mon, 8 Sep 2025 18:10:28 +0100
From: Mark Brown <broonie@kernel.org>
To: "Xu, Baojun" <baojun.xu@ti.com>
Cc: "tiwai@suse.de" <tiwai@suse.de>,
	"andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>,
	"13916275206@139.com" <13916275206@139.com>,
	"alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
	"Ding, Shenghao" <shenghao-ding@ti.com>,
	"linux-sound@vger.kernel.org" <linux-sound@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"lgirdwood@gmail.com" <lgirdwood@gmail.com>,
	"robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"Yi, Ken" <k-yi@ti.com>, "Lo, Henry" <henry.lo@ti.com>,
	"Chen, Robin" <robinchen@ti.com>, "Ji, Jesse" <jesse-ji@ti.com>,
	"Wang, Will" <will-wang@ti.com>,
	"jim.shil@goertek.com" <jim.shil@goertek.com>,
	"toastcheng@google.com" <toastcheng@google.com>,
	"chinkaiting@google.com" <chinkaiting@google.com>
Subject: Re: [EXTERNAL] Re: [PATCH v4 1/2] ASoC: tas2781: Add tas2118,
 tas2x20, tas5825 support
Message-ID: <071e0e04-e2cb-480d-8207-f6ba87cb56b5@sirena.org.uk>
References: <20250830061459.24371-1-baojun.xu@ti.com>
 <993d7fe7-5206-45a9-acb6-0d610a3a2136@sirena.org.uk>
 <12aa63e694c94213aeb6b48959d02b45@ti.com>
 <b70314db-357f-4c39-a9b4-088d8ebed2b0@sirena.org.uk>
 <67fafc23d16d4790821321643a87385f@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="+406khRUHZ73UGFa"
Content-Disposition: inline
In-Reply-To: <67fafc23d16d4790821321643a87385f@ti.com>
X-Cookie: Air is water with holes in it.


--+406khRUHZ73UGFa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 08, 2025 at 06:22:51AM +0000, Xu, Baojun wrote:

> > > Or need to create patches on tree broonie/linux.git?

> >   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-6.18

> This patch is also relative (shares the same include/sound/tas5825-tlv.h)
> with another commit on next/linux-next.git:
> https://patch.msgid.link/20250810122358.1575-1-baojun.xu@ti.com (ALSA: hda: Add TAS5825 support)
> However, it was not merged into broonie/sound.git yet, should I wait for it?

OK, it's probably easiest to just apply these directly to Takashi's
tree:

Acked-by: Mark Brown <broonie@kernel.org>

--+406khRUHZ73UGFa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmi/DgMACgkQJNaLcl1U
h9CJuQf/RcWlYaOU6atwCI8zHjGpf1PxtrwNOOUZj0EX8bRkztKxNyHuRYjwqPSx
3zZBX5GX/YPXS+9/oL3XplaYE9xtyGSq/yR1GqEr/acBmQkLgmwG5Hzv7a7yx4cj
v36Tlk4qHEyFzrs2QVrNM87FOxdrrnVASGHSVwzqNn1b+WfD0HCG652oMDYXGfWM
SQUH09smpYCGqpDaLKNWDJKF8m/Tt0itPBA6J5AEX92xwljNYpvYohc9ydLZW++E
ObD4Hc6Y71tH13sqXKDijCvBwLdVJx4CSuZ7GOdFoLIRvKvtCcfvPnskamXDXCUS
V5wucygKLUOSMLxvUbYYGAgKjWdArA==
=02zS
-----END PGP SIGNATURE-----

--+406khRUHZ73UGFa--

