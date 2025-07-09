Return-Path: <linux-kernel+bounces-723509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 30AF8AFE7C6
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 13:31:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1A581C80D61
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 11:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22EE5295510;
	Wed,  9 Jul 2025 11:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NQjFI9RG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 715FA270554;
	Wed,  9 Jul 2025 11:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752060574; cv=none; b=HjWObw+kKH33jJxeKL1eFt5FSCSS7JTgVDrJc48QQuxuDPDpcpKiqk3ZG4R/4jahkyyPie/X5iI0fX4Q2Xy99yhHVIG0cxaoY6O50kDpI2PMj8ItrL7RTNqjfsM06oOddJHuYlDPncSeNsD3EhDnsUyvoDSxH+wREP8p5ZvdFGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752060574; c=relaxed/simple;
	bh=OvhnqrXG7felB/7evYF13YaImsTGT+SXEAkJLH2cWFk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ikxQOgHcBTaxQqL9BCTGbkIBu5xw0Q/mrjJBDt9kKlmawUCRogoK385gQ4Ni92dBcFXNsX5wUQeBtfVMl3Lj8eATPlRr2KV+PVSTazSFhmn4Zwj1NiywiZto6D52+9Xr0/un3jxZp/M9Kx52IIzQ0RmHBYaohDVYyRb3Yc5LAng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NQjFI9RG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53421C4CEEF;
	Wed,  9 Jul 2025 11:29:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752060574;
	bh=OvhnqrXG7felB/7evYF13YaImsTGT+SXEAkJLH2cWFk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NQjFI9RG5VtojKBKzLtxzNM7kTdKu42vagKeKDt3EneU73kG8mW6RlSHpG07stIJz
	 ugPrBmsNf32iGqmLk/zouRZ0JPP30nViumSaupUQWZOivS4djDOOhrcpnN1HbdUaS6
	 CuJ6ZS0IC0pGY6YPVVkJyffaKTBxYc5Q6rIDooy1ix/6lSLhAzxu7TvVzpOLtJfE8/
	 NGaVSlGy81lxVfdK9sPeY//UtjFptE8ebYTgaBJyReMRYni2hreKx3CJKco9son9i+
	 iDmLCW2XAMPzgUM1bj0Em6njSN1/2hhATCgTYuJBVd9pqIUp8htEuY4a3eplhe9+DI
	 j/toref9Erdig==
Date: Wed, 9 Jul 2025 12:29:30 +0100
From: Mark Brown <broonie@kernel.org>
To: Nick Li <nick.li@foursemi.com>
Cc: lgirdwood@gmail.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, perex@perex.cz, tiwai@suse.com,
	xiaoming.yang@foursemi.com, danyang.zheng@foursemi.com,
	like.xy@foxmail.com, linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] ASoC: codecs: Add FourSemi FS2104/5S audio
 amplifier driver
Message-ID: <aG5Smt_DErSq5WjE@finisterre.sirena.org.uk>
References: <20250703035639.7252-1-nick.li@foursemi.com>
 <20250708112901.25228-1-nick.li@foursemi.com>
 <20250708112901.25228-5-nick.li@foursemi.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="FEYXvC00dM6TQVjr"
Content-Disposition: inline
In-Reply-To: <20250708112901.25228-5-nick.li@foursemi.com>
X-Cookie: Do not cut switchbacks.


--FEYXvC00dM6TQVjr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 08, 2025 at 07:29:01PM +0800, Nick Li wrote:

> The FS2104/5S are FourSemi digital audio amplifiers
> with I2C control. They are Inductor-Less, Stereo, Closed-Loop,
> Digital Input Class-D Power Amplifiers with Enhanced Signal Processing.

This looks broadly OK - there's a few more fairly small issues below in
addition to those that Krzysztof flagged.

> +static int fs210x_set_pcm_volume(struct fs210x_priv *fs210x)
> +{
> +	u16 vol[2];
> +	int ret;
> +
> +	if (fs210x->devid == FS2105S_DEVICE_ID) {

A swtich statement is better style here, it makes it easier to add more
variants.

> +	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {

_CLOCK_PROVIDER_MASK

> +	case SND_SOC_DAIFMT_CBC_CFC:
> +		/* Only supports slave mode */

consumer mode.

> +		dev_err(fs210x->dev, "Only supports slave mode\n");

consumer mode.

> +static int fs210x_dai_hw_params(struct snd_pcm_substream *substream,
> +				struct snd_pcm_hw_params *params,
> +				struct snd_soc_dai *dai)
> +{
> +	struct fs210x_priv *fs210x;
> +	int chn_num;
> +	int ret;
> +
> +	if (substream->stream != SNDRV_PCM_STREAM_PLAYBACK)
> +		return 0;

There's no configuration for capture?  Should the driver be setting
symmetric_rates and then not reconfiguring if active instead, it looks a
lot like the driver is relying on userspace starting playback before
capture to configure?

> +static int fs210x_pcm_volume_put(struct snd_kcontrol *kcontrol,
> +				 struct snd_ctl_elem_value *ucontrol)
> +{

> +	fs210x->vol[0] = (u16)*pval;
> +	fs210x->vol[1] = (u16)*(pval + 1);
> +	dev_dbg(fs210x->dev, "Set volume: %d-%d\n",
> +		fs210x->vol[0], fs210x->vol[1]);
> +

The driver should return 1 if there's a change in the values and 0
otherwise (plus it can skip a bunch of work if there's nothing to do).

The mixer-test test will spot this for you.

> +static int fs210x_effect_scene_put(struct snd_kcontrol *kcontrol,
> +				   struct snd_ctl_elem_value *ucontrol)
> +{

> +	ret = fs210x_set_scene(fs210x, scene_id);
> +	if (ret)
> +		dev_err(fs210x->dev, "Failed to set scene: %d\n", ret);
> +
> +	mutex_unlock(&fs210x_mutex);
> +
> +	return ret;

Same issue with flagging changes.

--FEYXvC00dM6TQVjr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmhuUpkACgkQJNaLcl1U
h9AH5wf8CfGM+wPWLvoAvI4SK6c29T1yyg+WVNu0ac8V/TYd35XuBXxRnuJwRklP
SJM/KhZTagfF1muBeKQPLArEJISEszVlVjYsttPtp9ibuMSJCZ7qAxjKuOVnO5gj
6IRLsdTM8Ofi2o0A50nU/ekZzSLzwzAqhHoXQAkuuX0TQfTbioq1bKWKd4cYnZTz
XDKuX+vHTT7y9chNbDM9nbZzcm0ZcdoC+ZDf98wne89neTiIIwwc2ZIiPccp2PU+
Uz6dS9iNZbDkKZZ2eSstavQy7Z1X+esIoYvmwkoXApg4wqRGHnR4B+O1zUQOPsw8
ZdhTLZg4H2t2TnL4+Z0y+PMLjZ2ocg==
=Nu39
-----END PGP SIGNATURE-----

--FEYXvC00dM6TQVjr--

