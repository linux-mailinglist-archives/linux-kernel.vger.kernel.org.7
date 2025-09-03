Return-Path: <linux-kernel+bounces-798387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 55C98B41D2B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 13:36:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0359B1BA2759
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 11:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83AD92FABE8;
	Wed,  3 Sep 2025 11:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CujKhsZ2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2AA82FABE2;
	Wed,  3 Sep 2025 11:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756899405; cv=none; b=tpjnNb6U+llTcRUMZ+oJ5vgiCSmgLInJppJIqcgubGjKku/Dnxjj6c+TmLsF9BQIL8p3P41d6EdKOkbcIFg5N2vdgPU9PBuqdo7W1LxlbFE29vvkNsJ0QxV12WumQb1VhKeeMuKpPcn5+s0q04qTcPbL6x47XvqMtH0I0EUEQpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756899405; c=relaxed/simple;
	bh=kcoz6IRnW6gx/sB53OJmz0DlwnSZ6BGmZgBLPY8OboE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qit4p6tCbYwMaydcFqyB//B6UXouwG3fllFeItl7AaPK/RcgFABZpRjKdK7erbjnHOIBohneDZo+2tJNRvh6hLDVWdhrRyQz9A8X4pyd4MKbFBOvvJkykemcA/5m+CjAWDbEDQ03TwXt6pFfG4trRrxkzYsL/9/AWaU9iat4jFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CujKhsZ2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98A51C4CEF0;
	Wed,  3 Sep 2025 11:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756899404;
	bh=kcoz6IRnW6gx/sB53OJmz0DlwnSZ6BGmZgBLPY8OboE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CujKhsZ2eiNRgmkEythvEi3aZU5NdXxkxS86MoT1EeaPOQpXAz95hFRMOo/UdfWrd
	 DU6aitLbnA+3mFS8jY8RC469ToVH5S+h63Y8TMj/83HQ/ogL3MkVVVwPcN+DrVnWwg
	 a2KXKxkSkpCNF1b/pPJrKnjSaT+vCNhI7P4MdGQFJ/EcJd1xNc1qMyWxkdVqNzKSDF
	 4PzBDwMgw9QTqm5eDCsRf1xSvozFHIbRX717nOAqZ2p/orcqxaGOhqC7Rv8Jk3GfaL
	 e7V8l16gYikzTub0o+f5VlP6KkREqFS/p56TnQyjNmC4xRp1WPqGtBBSo4wah6t4x6
	 GcIDSC73KY2zg==
Date: Wed, 3 Sep 2025 12:36:37 +0100
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
Subject: Re: [PATCH v4 1/2] ASoC: tas2781: Add tas2118, tas2x20, tas5825
 support
Message-ID: <993d7fe7-5206-45a9-acb6-0d610a3a2136@sirena.org.uk>
References: <20250830061459.24371-1-baojun.xu@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="GnIkFgzAOSmCpQmI"
Content-Disposition: inline
In-Reply-To: <20250830061459.24371-1-baojun.xu@ti.com>
X-Cookie: try again


--GnIkFgzAOSmCpQmI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Aug 30, 2025 at 02:14:58PM +0800, Baojun Xu wrote:
> Add tas2020, tas2118, tas2120, tas2320, tas2570, tas2572, tas5825
> tas5827 support in tas2781 driver.
> Tas2118, tas2x20, tas257x have no on-chip DSP, tas582x have on-chip
> DSP but have no calibration required stereo smart amplifier.

This doesn't apply against current code, please check and resend.

--GnIkFgzAOSmCpQmI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmi4KEUACgkQJNaLcl1U
h9AlZgf/e7VQ6pQUaocUBbqFkv7B2Odnfb9DRKZ3FDueq/0l2XWuvcYzMVaDkCHB
jlDGfEPUsWSwhNL73yRKy7w2OOOcS9aKHhq6X87Cjt/KGQKmkSGqp5EwYDiiUeLU
iqJCC9quMvYi2egEAEWBtk1W2rYH04nvoZokngeGhAUvAyT+6vaZYMNe0ZOxgFY5
douQiaHI3SN7C+KGJWKob7PhvjT7MZ614Ikq/6xVFU1uwGSHDNLwF4JGesBUTxsw
IKtqqhlPoGB8c9FfPWyarSzn+p1vs0fodL/iqDKcwFEB0d7BYc3SkL8JK68sOv63
D4n4tLwE0keYygArv8QRb8Hr5hD/yg==
=lHOI
-----END PGP SIGNATURE-----

--GnIkFgzAOSmCpQmI--

