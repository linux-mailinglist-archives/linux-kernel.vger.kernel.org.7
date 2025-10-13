Return-Path: <linux-kernel+bounces-850468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EE3EFBD2E81
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 14:06:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 219A734B7A1
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 12:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1D8E26E6FD;
	Mon, 13 Oct 2025 12:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eHqi/xQu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5F6826CE26;
	Mon, 13 Oct 2025 12:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760357164; cv=none; b=qRF9ttPpPvjQC77RVzWg6dcOau8uXVtubnTOv85sBL3s2jHsSBy4LQ5w3YtS3ZtU7vvdZwSM7o4LGFhUoEyRfTbsu+HqMjEeFyc0THQAa4/4DaTJTTz9vTGu4rYEGt/QkTukXkatOk6V9weVKPGKLEZS4iLfC6n/QtNq9ZH9324=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760357164; c=relaxed/simple;
	bh=eQCTZ+DwwjDnDCLacfwORLwSG59bihMMYVuM80C2bGE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dWJ3zPZhCKLQ2+3WL0fqysTsnK8pV+N9ALEqaejorDPjggQskwjU51aglw/L2wDQF6oClueQdRkhVcmOZ+TUTQ+6/nvBGI1unuiz9FR3TmYHZLEbzNk/fhaG859Im842qtxpwqltY7BcNACnpBLz1zCVZsu1kEfOze2CxJO2iyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eHqi/xQu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6962C4CEE7;
	Mon, 13 Oct 2025 12:06:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760357163;
	bh=eQCTZ+DwwjDnDCLacfwORLwSG59bihMMYVuM80C2bGE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eHqi/xQutfRuvsv8IaAwOdm6h7IN+PcJRmIo5zSLeBghKtzNPbHI2oJqkpU+c139+
	 c7SFp1N2yH0nzOtchE3ZSBz+yki1CL2oar5WMpC+g9Q5IvJIe03ReLM7dCxlYUVJtN
	 aTXy8yNf4+CK1Ur2YenEkrFLCDEOAu5YxSeopH1NHmsSFIZGTNGid3WuyB5eW0xZob
	 v4mREbWlg/ZeJUmRTdiScuIa19OlWQbizwly1dTV3UlXP01QnAiLBGKNGvFe4pPTRm
	 2TiimEbCwCYRh/9Z35Q+a/rdR6loCJ6UJmSgsyn38tjSULUcMPrtBNKi5J/IcaFBsp
	 Smi/ODVtShrig==
Date: Mon, 13 Oct 2025 13:05:58 +0100
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
Subject: Re: [PATCH v4 2/2] ASoC: spacemit: add i2s support for K1 SoC
Message-ID: <d1d965c4-f0f4-4b09-b5c3-5925d5f7ce1b@sirena.org.uk>
References: <20250921-k1-i2s-v4-0-4f819f50e468@linux.spacemit.com>
 <20250921-k1-i2s-v4-2-4f819f50e468@linux.spacemit.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wweVKEal3BporYO0"
Content-Disposition: inline
In-Reply-To: <20250921-k1-i2s-v4-2-4f819f50e468@linux.spacemit.com>
X-Cookie: Ahead warp factor one, Mr. Sulu.


--wweVKEal3BporYO0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Sep 21, 2025 at 04:52:17PM +0800, Troy Mitchell wrote:

> +	case SND_SOC_DAIFMT_DSP_A:
> +	case SND_SOC_DAIFMT_DSP_B:
> +		snd_pcm_hw_constraint_minmax(substream->runtime,
> +					     SNDRV_PCM_HW_PARAM_CHANNELS,
> +					     1, 1);
> +		snd_pcm_hw_constraint_mask64(substream->runtime,
> +					     SNDRV_PCM_HW_PARAM_FORMAT,
> +					     SNDRV_PCM_FMTBIT_S32_LE);
> +		break;

The handling for one of these is buggy, DSP A and B are distinct modes
but throughout the driver they're handled identically AFAICT.

--wweVKEal3BporYO0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmjs6yUACgkQJNaLcl1U
h9Be0Qf9GD0TEOD2NY68jkxmsqkwbrzpKPPN7UJKdC4om8/KIdo80hj9EOQJqjrf
LSFy9aQ5XESBTKTvd9iDZVTTqHvQjzlDe+8TXKu8oSkOJYZ8elONRCU0yU0swo2L
aBRSVCJP2zXg7srTXVuGP2imoHNSvBDCE/1/vqv8iHE+X/O7ckhM2DPl9bx8+SwR
xyxWhHD60jw4slx4cyQCsAcTF5ge2oTcGC+Wn3eBb9UenLuon7wTE8lsph4zUT6N
oVi1xiLjEgTpz5oFF87VoGPQySQmN8ZnlYZKQ8iZyasgocfz9IM3XkOovKxTagB6
K6mb5skvKkIOkH6rcWHb7iVU7gPpRw==
=XcnN
-----END PGP SIGNATURE-----

--wweVKEal3BporYO0--

