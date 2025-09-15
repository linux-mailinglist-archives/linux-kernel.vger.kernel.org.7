Return-Path: <linux-kernel+bounces-817712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52EACB5858F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 21:55:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4617A4C5B96
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 19:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CBCB288527;
	Mon, 15 Sep 2025 19:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qU7+qyHl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D32A8287271;
	Mon, 15 Sep 2025 19:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757965975; cv=none; b=K3h2C4L+jg/4a4YSsf8nsj576AE+OO/KtfslnXTsEMp9GZHG707pef2lopGBRvP4vaxsrq6X+7CKu4UFObxQCsdZO5gQ6RzWu3wX1W9OEzi1IYY6blY8lLTRZ6JrR3G0keDzlXet9HTRmPLJRWMGAgsaeC9znGtDAz4sRqNiASA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757965975; c=relaxed/simple;
	bh=uOejRi2XFO7qeixRkiyMH2Apb1CTrpBORTrA10JAROg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f0SO2sCGkSkua6FYM7EE+/9LoJvdHq3+53kfzU4Y5NX0ZdwA++0g5YGiLKCpNwIALm61HqQgK+8nKEBpCiwQx2AArfs3TepcaLxXZHEp45tHESRYPejK3ZpLa0dK95t26CWK6FswO2oZKaYRAb7p3E/LLDC6Uv92IzY2xhNPeLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qU7+qyHl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9069FC4CEF1;
	Mon, 15 Sep 2025 19:52:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757965974;
	bh=uOejRi2XFO7qeixRkiyMH2Apb1CTrpBORTrA10JAROg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qU7+qyHlZrBu/gHA3AJ6ybvYlPuZ9cE2B8ivLGMmpgMb2CTlsMAcrLFG8Rqs7iR58
	 trQljAvT+THNok/lBolUatoHOkf2F+/qNp1jyopY0nehy5T39ibuQNX76ps4LtlEc2
	 Kpn/ycP5WZUGeDfHwW1TvEtCS2ulAX/fhFv/r/21w79fTB149Ruin4gcO/aZwtsJpR
	 bFt+jNr5rFpfavWiUFGSBiLgXx7Re6slKaeAhg/FZiVOfzRj0U1rckVJfQPSeSzxmC
	 fMTBpOVzuzlh4iMSuJJTk6Eg3bgXkn9On/BE6GK/18smpRaUtQROx6L8582/uzj0pg
	 adVSmS0KSukKA==
Date: Mon, 15 Sep 2025 20:52:48 +0100
From: Mark Brown <broonie@kernel.org>
To: Troy Mitchell <troy.mitchell@linux.spacemit.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@gentoo.org>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Philipp Zabel <p.zabel@pengutronix.de>, linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev, linux-kernel@vger.kernel.org,
	Jinmei Wei <weijinmei@linux.spacemit.com>
Subject: Re: [PATCH v3 2/2] ASoC: spacemit: add i2s support for K1 SoC
Message-ID: <50b81d55-a4d9-4e8f-831d-b98d789c125e@sirena.org.uk>
References: <20250911-k1-i2s-v3-0-57f173732f9c@linux.spacemit.com>
 <20250911-k1-i2s-v3-2-57f173732f9c@linux.spacemit.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="EGXM8N1jhlP6IDAm"
Content-Disposition: inline
In-Reply-To: <20250911-k1-i2s-v3-2-57f173732f9c@linux.spacemit.com>
X-Cookie: Use a pun, go to jail.


--EGXM8N1jhlP6IDAm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 11, 2025 at 01:47:11PM +0800, Troy Mitchell wrote:

> +
> +static int spacemit_i2s_set_fmt(struct snd_soc_dai *cpu_dai,
> +				unsigned int fmt)
> +{
> +	struct spacemit_i2s_dev *i2s = dev_get_drvdata(cpu_dai->dev);
> +	u32 sspsp_val;

> +	case SND_SOC_DAIFMT_DSP_A:
> +		sspsp_val |= SSPSP_FSRT;
> +	case SND_SOC_DAIFMT_DSP_B:
> +		cpu_dai->driver->playback.channels_min = 1;
> +		cpu_dai->driver->playback.channels_max = 1;
> +		cpu_dai->driver->capture.channels_min = 1;
> +		cpu_dai->driver->capture.channels_max = 1;
> +		cpu_dai->driver->playback.formats = SNDRV_PCM_FMTBIT_S32_LE;
> +		cpu_dai->driver->capture.formats = SNDRV_PCM_FMTBIT_S32_LE;
> +		sspsp_val |= FIELD_PREP(SSPSP_FIELD_SFRMWDTH, 0x1);
> +		break;

You really shouldn't be modifying the driver struct at all, if two
interfaces have different configurations or if one interface changes
modes the two will fight with each other.  Use the constraints API to
enforce any constraints that are discovered at runtime.

--EGXM8N1jhlP6IDAm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmjIbpAACgkQJNaLcl1U
h9Dx7wf+JdDIZkZd9eM9d4C+b/D0+e65EupvZa+AsItg/lCqRm5ORu57BBdcmBTA
kKSHTTfHgAT7EMcHDmRYTX+HUxqVMBFFJ1Qp7ZP23Yv2oMUQw1pmDUCHc6iirgvQ
MOiKDXTv8Y9XHI5DpzrnC9wUTxy5B9RV1THZY2P5PQCDPKSknMafWOZsJLFzjOCC
QpBWW+TYApx9c7m45lHRvWK8Xk/tdzhz9E2EyUNTSX1mUc2w4M9A0RPlI/gVAPzk
8kfsGCNjmRA1gOwgecmB69k2bBqvSH4HUJbt8d1oct2qNtuzqLP4NneaALBK340h
6oSgJkPkOKdN3shbVXBUXaVIFg2LIQ==
=DUX+
-----END PGP SIGNATURE-----

--EGXM8N1jhlP6IDAm--

