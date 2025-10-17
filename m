Return-Path: <linux-kernel+bounces-858465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AB2ACBEADDC
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 18:50:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 443365A269B
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 16:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2A822C11C3;
	Fri, 17 Oct 2025 16:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FUmdqQiw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F8342C08BB;
	Fri, 17 Oct 2025 16:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760719302; cv=none; b=eC/HsFhWBxJP5emdWXJNW0nXbmD6e8fiXYgb1nDSF8jlN5WN2GVhQIYnS+safJ4g4Qx5bJxlVmE8D+9b1TuEfsVmcVF6B2uWveBecCzpqJGWfYUSESsi10utUgMjV8yGQ8GPB4nC+5FQlgMGADoX12KVGD+cRB/ekEKDExvMtbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760719302; c=relaxed/simple;
	bh=Kluv6meTOXVV/CYoXDaXYdFXj5omH8c8AFCn633N9wM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TyiO/c3ZY3ylAxpfp36/lpfD9abo+O3RNpOBDHbds+84arVRkKPJYR+oPw6SIZw+qNDCRmebZ7qqasFxkX7MOAQ1QGvb9Q01JAM6DMssnd2elJPDvWjjP1OF6KQ1Eg/n0MG3cw2UCtUREyRYdYjYh6vxW+vr8Ls7M/hy/Bhi6IQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FUmdqQiw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9ECCAC4CEE7;
	Fri, 17 Oct 2025 16:41:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760719301;
	bh=Kluv6meTOXVV/CYoXDaXYdFXj5omH8c8AFCn633N9wM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FUmdqQiwUM/WjNay9BbHp1DPnlJq7/YWVm1B970h+DCycwwca++qTTGl6X4Z1ZZPO
	 OJyM8CyHmxN70NXLDKp7rhw/tr+ToOWKVxkGi95hqSY/xCkMqLxnSGmYzkbK+lxaQi
	 N8/7QZqmcRzPmRAUoBUp6NMevyV5XlO0bLSnk4lx32AftNLV+zVREzTdJjmZVutnh4
	 luNy3r2WI8QVEI6eKnicvkitWQvxg7413HDrfuZLlpGw0MJUn7YGOEYN+N1sYtnMXE
	 fIQkq4X1EzfnOf/7PUlUGO8xE1NrJ1jc9N2QFynKPDz+zMY4HqgPyi22JFgC9xhvXj
	 D7bAj1o16+UeA==
Date: Fri, 17 Oct 2025 17:41:35 +0100
From: Mark Brown <broonie@kernel.org>
To: Vitaly Rodionov <vitalyr@opensource.cirrus.com>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, Takashi Iwai <tiwai@suse.com>,
	Jaroslav Kysela <perex@perex.cz>,
	David Rhodes <david.rhodes@cirrus.com>,
	Richard Fitzgerald <rf@opensource.cirrus.com>,
	Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org, patches@opensource.cirrus.com,
	devicetree@vger.kernel.org,
	Simon Trimmer <simont@opensource.cirrus.com>
Subject: Re: [PATCH v4 07/11] ASoC: cs530x: Add CODEC and DAC support
Message-ID: <a0944336-e6e0-4ab2-95c3-be446e20230f@sirena.org.uk>
References: <20251017161543.214235-1-vitalyr@opensource.cirrus.com>
 <20251017161543.214235-8-vitalyr@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mtHkEX5ILNkXrGIx"
Content-Disposition: inline
In-Reply-To: <20251017161543.214235-8-vitalyr@opensource.cirrus.com>
X-Cookie: Androphobia:


--mtHkEX5ILNkXrGIx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 17, 2025 at 05:15:34PM +0100, Vitaly Rodionov wrote:

> --- a/sound/soc/codecs/cs530x.c
> +++ b/sound/soc/codecs/cs530x.c
> @@ -45,6 +45,18 @@ static const struct reg_default cs530x_reg_defaults[] = {
>  	{ CS530X_IN_VOL_CTRL3_1, 0x8000 },
>  	{ CS530X_IN_VOL_CTRL4_0, 0x8000 },
>  	{ CS530X_IN_VOL_CTRL4_1, 0x8000 },
> +	{ CS530X_OUT_ENABLES, 0 },
> +	{ CS530X_OUT_RAMP_SUM, 0x0022 },
> +	{ CS530X_OUT_FILTER, 0 },
> +	{ CS530X_OUT_INV, 0 },
> +	{ CS530X_OUT_VOL_CTRL1_0, 0x8000 },
> +	{ CS530X_OUT_VOL_CTRL1_1, 0x8000 },
> +	{ CS530X_OUT_VOL_CTRL2_0, 0x8000 },
> +	{ CS530X_OUT_VOL_CTRL2_1, 0x8000 },
> +	{ CS530X_OUT_VOL_CTRL3_0, 0x8000 },
> +	{ CS530X_OUT_VOL_CTRL3_1, 0x8000 },
> +	{ CS530X_OUT_VOL_CTRL4_0, 0x8000 },
> +	{ CS530X_OUT_VOL_CTRL4_1, 0x8000 },

Do these new registers apply to all parts or just some (I'm guessing
these might be different packaging/binnings of the same die in which
case this should be fine if a little messy, but just checking).

>  	/* Write IN_VU bit for the volume change to take effect */
> -	regmap_write(regmap, CS530X_IN_VOL_CTRL5, CS530X_IN_VU);
> +	regmap_write(regmap, CS530X_IN_VOL_CTRL5, CS530X_INOUT_VU);

The comment is now out of sync.  I can't help but feel that this change
might be easier to read if the rename of everything to INOUT were a
separate patch.

> +		cs530x->dac_pairs_count--;
> +		if (!cs530x->dac_pairs_count) {
> +			usleep_range(1000, 1100);
> +			return regmap_write(regmap, CS530X_OUT_VOL_CTRL5,
> +					    CS530X_INOUT_VU);
> +		}

Should dac_pairs_count be a supply widget?

--mtHkEX5ILNkXrGIx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmjycb4ACgkQJNaLcl1U
h9B4Lgf9GKj6aiJbvrg4PMOCSwR7GZWa2kJfni2TF7qcueGWgUFLTTC1KOebwPLx
w++KWthtXse2sI6LDVdwir2ULzObC2Gy0/8MAu9/370VYp+6IEKnH8OdqKMt3jaQ
Ue+buS7teJZwZ826j3O3H5IyIVHYCcih+uTWWfZD6E8zzvZ+YICQSO07nKbKIMWO
ROGJvH0PGuEGsT3pneQ9zZjDid1liLec/866Y89U2g7WDN9oNNT2DXC4DcqYpL/0
sKUcmwxhlHRacm3Dx2+O5bJ3ICPiB5pr4RQh1cQ4GNv1F5IHBjnVwqYDzHtXqXzu
EOwWMxzKjUvE6qehCmpgmNIe3XYwHQ==
=oCtF
-----END PGP SIGNATURE-----

--mtHkEX5ILNkXrGIx--

