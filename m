Return-Path: <linux-kernel+bounces-826829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 916D8B8F727
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 10:16:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEAE63BA756
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 08:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E90727C854;
	Mon, 22 Sep 2025 08:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cyjOY+t/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE23570814;
	Mon, 22 Sep 2025 08:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758528955; cv=none; b=Visz4Az0EAFxSkJY5BJXGBMGwxPvKNSFMzDAU9nUlskizG02SkFc/zPOV8L3shc3g3tUKB1/42FdCzglx0UFmXjM0lErSfwKdKxEJAudVl9V7l1WuLPBOT1hF7aIz5H3yhktuK9ga5kTh0rnnArroY/coPJhXfugU6pJpm5iV44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758528955; c=relaxed/simple;
	bh=9e8PlwwYBfj5/qImlIzuspQWaypq4Jop0H/ZcPuXT5o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i76FSwQG8JvFNWBTtSENv8Ajbvj6+yROx5m5kHdeXfxGlhHcQ2yl8u1nQgBdQUZtCQU00h/gDbebbtsKvEqdV2a11oo2WIrQdJ9/75Y2ooH+u+ZKWcNY+A0vF4CD1fOpmjmPG+8D+GES95N0/fCbbqOoz1ipJx/GhmU0UWE2M9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cyjOY+t/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4D56C4CEF5;
	Mon, 22 Sep 2025 08:15:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758528955;
	bh=9e8PlwwYBfj5/qImlIzuspQWaypq4Jop0H/ZcPuXT5o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cyjOY+t/38baIkWLeToE6zJ1Hm4xM42cTOTwqGMjzzdUlfcdZMQemybm5tVTfyaiM
	 Zc7XTUMc/igXQyEDTWfdxkQUCTmFW6gAJDj6SXdvacg8zgHhvo2+IcIAUktCZjiQLp
	 Psg9PyiEOXPg5D2RYcu1BuOB3C4Nwls6S3zVQNkvVXoyPRQEAnW/h3wG0IiRh5VH2C
	 wgvFZDoqpFV7rli7d8/nlegN9plHfLC7hr3onMeHlnC4BPsJpVN1kf8RCQf1tfXJ2k
	 AjXDCmQFhSn43xE1DYg0CiIyD7/jROThJYkIuBkKUuxa1ta8R11QFf6z7HC586uCfU
	 785xXlEFump8A==
Date: Mon, 22 Sep 2025 09:15:48 +0100
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
Subject: Re: [PATCH v1] ASoC: tas2781: Correct the wrong description and
 register address on tas2781
Message-ID: <aNEFtCV0Gm2koLKv@finisterre.sirena.org.uk>
References: <20250920062044.1904-1-baojun.xu@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jxMegtNIkBGudZ3I"
Content-Disposition: inline
In-Reply-To: <20250920062044.1904-1-baojun.xu@ti.com>
X-Cookie: Who is John Galt?


--jxMegtNIkBGudZ3I
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Sep 20, 2025 at 02:20:44PM +0800, Baojun Xu wrote:
> Correct the wrong description for TAS257X. Combined TAS5825 with TAS2563,
> as they use the same register address and number.
> Correct the register address and number for TAS5827.

This depends on commits in Takashi's tree so it needs to go via there:

Acked-by: Mark Brown <broonie@kernel.org>

--jxMegtNIkBGudZ3I
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmjRBbMACgkQJNaLcl1U
h9DH/QgAgM2mgvWmptxmf+4GpjO0ExIV3YPboWvh1E3GdATS1ZKo3nefHDbw8qZD
1OYF/zRT/SwsO+DhSQJOV66Gq//35nl1A+nJyxfQJC/yQ86kxuNVYzusVI6GTjj6
WLJRx4Ddw4hsq906RU9y67lYIxCnzFKODFlg6mwE8hmcW4BJB88PcEpyg3IvPfem
WahY6NaRfy4Owrz4ZVa1PsR3utbZvE17xn2t4EamfN4QnGydeK0AWENmbDEXL4Of
zko7SnOhK04jDAuQj99wlNUzfmfFFLY6M54PJ08etQ9j1vP14Qv8KXSoUnVV9WSs
rx/PZwhz/a+EfMhTGx/ZGcUWLtWk5g==
=SEDg
-----END PGP SIGNATURE-----

--jxMegtNIkBGudZ3I--

