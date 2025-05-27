Return-Path: <linux-kernel+bounces-663642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 32BDFAC4B47
	for <lists+linux-kernel@lfdr.de>; Tue, 27 May 2025 11:13:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8EF8A7AC563
	for <lists+linux-kernel@lfdr.de>; Tue, 27 May 2025 09:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96B4324DCF5;
	Tue, 27 May 2025 09:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="An211V9p"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E53591EF09D
	for <linux-kernel@vger.kernel.org>; Tue, 27 May 2025 09:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748337195; cv=none; b=ApDYknM1Z7DhEQTxbKQ4KfuhLNXVC1j2cfBOqaRi8LGbJQYyv100b6en5eS0nh/wpJpg0m99Ouxk4uIC5abUp4IqkSxnSe0HgQezjtt1nlqNCYVdCMXIHC1uIiUc2MGV1dqMkE0Skj4yxRYlMdmUZcfAwWlnZRtytixenH4T2aU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748337195; c=relaxed/simple;
	bh=abqTtzvfpLe4Uvpk0Uo+xvVDO1TjWy7S8bPep2221yI=;
	h=Content-Type:Date:Message-Id:Subject:Cc:From:To:References:
	 In-Reply-To; b=pxkVE0XGhUXn9w5E2iaTQwaK3qxUA/S6bdh5rY/JzifNGJjkSzYlDmu+HB+tQbHiPU/tHOUGDw+NxYKES8mzcjKHgSwtD6HivplUQWBfXetLldKBnjmK/MERsFmxQ/TG2VIBnaplzOenzJ3q/sZ3IloC5aXDZYmed6V2lM+hGJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=An211V9p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D57D0C4CEE9;
	Tue, 27 May 2025 09:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748337194;
	bh=abqTtzvfpLe4Uvpk0Uo+xvVDO1TjWy7S8bPep2221yI=;
	h=Date:Subject:Cc:From:To:References:In-Reply-To:From;
	b=An211V9p+frR/eitZ0CS/a3bhryu27yCVxgoxqFZOMVdI+puDpHTgtF+tgbMdym2k
	 wDCTba8AVi3lMO6VAjQSR2IAxRNkA1D91n70xH0jN0HmMF1zb/jhPX+9NSWGvb257U
	 WzCQGf5LnVh8S/7mRil2hNWUvvn23FfvsziEVRaKQmUTu2KECrMtbhRTYTsZRrNPuf
	 ZELfY/taBN0VymPO3naAloITWSmVsfra3n2tMFRkXnyb04Xyh0dfmG6PdNYvRiq0rr
	 zVIu19znIxggPgLXvw2iO/wOa6efANsThym1CMhQ+r0IFU6BeTvlpA1oruOBJmx9iI
	 CkcWC9vNi/aYA==
Content-Type: multipart/signed;
 boundary=9fcfc53e0fcd83cc188fa2e200cd3fe58dd86edaab762b63b2b775e59452;
 micalg=pgp-sha384; protocol="application/pgp-signature"
Date: Tue, 27 May 2025 11:13:10 +0200
Message-Id: <DA6TT575Z82D.3MPK8HG5GRL8U@kernel.org>
Subject: Re: [PATCH v2 03/18] drm/tidss: Adjust the pclk based on the HW
 capabilities
Cc: <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 <linux-phy@lists.infradead.org>, "Francesco Dolcini"
 <francesco@dolcini.it>, "Aradhya Bhatia" <aradhya.bhatia@linux.dev>,
 "Devarsh Thakkar" <devarsht@ti.com>
From: "Michael Walle" <mwalle@kernel.org>
To: "Tomi Valkeinen" <tomi.valkeinen@ideasonboard.com>, "Jyri Sarha"
 <jyri.sarha@iki.fi>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Vinod Koul"
 <vkoul@kernel.org>, "Kishon Vijay Abraham I" <kishon@kernel.org>, "Andrzej
 Hajda" <andrzej.hajda@intel.com>, "Neil Armstrong"
 <neil.armstrong@linaro.org>, "Robert Foss" <rfoss@kernel.org>, "Laurent
 Pinchart" <Laurent.pinchart@ideasonboard.com>, "Jonas Karlman"
 <jonas@kwiboo.se>, "Jernej Skrabec" <jernej.skrabec@gmail.com>
X-Mailer: aerc 0.16.0
References: <20250402-cdns-dsi-impro-v2-0-4a093eaa5e27@ideasonboard.com>
 <20250402-cdns-dsi-impro-v2-3-4a093eaa5e27@ideasonboard.com>
In-Reply-To: <20250402-cdns-dsi-impro-v2-3-4a093eaa5e27@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

--9fcfc53e0fcd83cc188fa2e200cd3fe58dd86edaab762b63b2b775e59452
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi Tomi,

While testing Aardhya's OLDI support patches [1], I've noticed that
the resulting LVDS clock is wrong if this patch is applied.

> In practice, with the current K3 SoCs, the display PLL is capable of
> producing very exact clocks, so most likely the rounded rate is the same
> as the original one.

This is now what I'm seeing. Most SoCs have that fixed clock thingy
for (some?) VPs, e.g. [2]. And clk_round_rate() will return the
fixed clock rate for this clock, which will then result in an LVDS
clock which is way off.

I'm testing on an AM67A (J722S) and I've backported some of the
patches as well as dtsi fragmets from downstream. Thus, it might be
as well the case that the fixed-factor-clock node is wrong here.
OTOH other K3 SoCs do this in mainline as well.

>
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> ---
>  drivers/gpu/drm/tidss/tidss_crtc.c  | 23 +++++++++++++++++++----
>  drivers/gpu/drm/tidss/tidss_dispc.c |  6 ++++++
>  drivers/gpu/drm/tidss/tidss_dispc.h |  2 ++
>  3 files changed, 27 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/tidss/tidss_crtc.c b/drivers/gpu/drm/tidss/t=
idss_crtc.c
> index 1604eca265ef..6c3967f70510 100644
> --- a/drivers/gpu/drm/tidss/tidss_crtc.c
> +++ b/drivers/gpu/drm/tidss/tidss_crtc.c
> @@ -91,7 +91,7 @@ static int tidss_crtc_atomic_check(struct drm_crtc *crt=
c,
>  	struct dispc_device *dispc =3D tidss->dispc;
>  	struct tidss_crtc *tcrtc =3D to_tidss_crtc(crtc);
>  	u32 hw_videoport =3D tcrtc->hw_videoport;
> -	const struct drm_display_mode *mode;
> +	struct drm_display_mode *adjusted_mode;
>  	enum drm_mode_status ok;
> =20
>  	dev_dbg(ddev->dev, "%s\n", __func__);
> @@ -99,12 +99,27 @@ static int tidss_crtc_atomic_check(struct drm_crtc *c=
rtc,
>  	if (!crtc_state->enable)
>  		return 0;
> =20
> -	mode =3D &crtc_state->adjusted_mode;
> +	adjusted_mode =3D &crtc_state->adjusted_mode;

Here, adjusted_mode->clock is still the correct pixel clock.

> -	ok =3D dispc_vp_mode_valid(dispc, hw_videoport, mode);
> +	if (drm_atomic_crtc_needs_modeset(crtc_state)) {
> +		long rate;
> +
> +		rate =3D dispc_vp_round_clk_rate(tidss->dispc,
> +					       tcrtc->hw_videoport,
> +					       adjusted_mode->clock * 1000);
> +		if (rate < 0)
> +			return -EINVAL;
> +
> +		adjusted_mode->clock =3D rate / 1000;

While after this statement, adjusted_mode->clock is 300MHz in my
case (the VP1 clock seems to be 2.1GHz, divided by 7).

-michael

[1] https://lore.kernel.org/all/20250525151721.567042-1-aradhya.bhatia@linu=
x.dev/
[2] https://elixir.bootlin.com/linux/v6.15/source/arch/arm64/boot/dts/ti/k3=
-am62.dtsi#L110

> +
> +		drm_mode_set_crtcinfo(adjusted_mode, 0);
> +	}
> +
> +	ok =3D dispc_vp_mode_valid(dispc, hw_videoport, adjusted_mode);
>  	if (ok !=3D MODE_OK) {
>  		dev_dbg(ddev->dev, "%s: bad mode: %ux%u pclk %u kHz\n",
> -			__func__, mode->hdisplay, mode->vdisplay, mode->clock);
> +			__func__, adjusted_mode->hdisplay,
> +			adjusted_mode->vdisplay, adjusted_mode->clock); >  		return -EINVAL;
>  	}
> =20
> diff --git a/drivers/gpu/drm/tidss/tidss_dispc.c b/drivers/gpu/drm/tidss/=
tidss_dispc.c
> index a5107f2732b1..3930fb7f03c2 100644
> --- a/drivers/gpu/drm/tidss/tidss_dispc.c
> +++ b/drivers/gpu/drm/tidss/tidss_dispc.c
> @@ -1318,6 +1318,12 @@ unsigned int dispc_pclk_diff(unsigned long rate, u=
nsigned long real_rate)
>  	return (unsigned int)(abs(((rr - r) * 100) / r));
>  }
> =20
> +long dispc_vp_round_clk_rate(struct dispc_device *dispc, u32 hw_videopor=
t,
> +			     unsigned long rate)
> +{
> +	return clk_round_rate(dispc->vp_clk[hw_videoport], rate);
> +}
> +
>  int dispc_vp_set_clk_rate(struct dispc_device *dispc, u32 hw_videoport,
>  			  unsigned long rate)
>  {
> diff --git a/drivers/gpu/drm/tidss/tidss_dispc.h b/drivers/gpu/drm/tidss/=
tidss_dispc.h
> index c31b477a18b0..d4c335e918fb 100644
> --- a/drivers/gpu/drm/tidss/tidss_dispc.h
> +++ b/drivers/gpu/drm/tidss/tidss_dispc.h
> @@ -120,6 +120,8 @@ enum drm_mode_status dispc_vp_mode_valid(struct dispc=
_device *dispc,
>  					 const struct drm_display_mode *mode);
>  int dispc_vp_enable_clk(struct dispc_device *dispc, u32 hw_videoport);
>  void dispc_vp_disable_clk(struct dispc_device *dispc, u32 hw_videoport);
> +long dispc_vp_round_clk_rate(struct dispc_device *dispc, u32 hw_videopor=
t,
> +			     unsigned long rate);
>  int dispc_vp_set_clk_rate(struct dispc_device *dispc, u32 hw_videoport,
>  			  unsigned long rate);
>  void dispc_vp_setup(struct dispc_device *dispc, u32 hw_videoport,


--9fcfc53e0fcd83cc188fa2e200cd3fe58dd86edaab762b63b2b775e59452
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKgEABMJADAWIQTIVZIcOo5wfU/AngkSJzzuPgIf+AUCaDWCJhIcbXdhbGxlQGtl
cm5lbC5vcmcACgkQEic87j4CH/gUWAF/XnIRUuokTBhnPlsAEUUt79SPR3vV/Tvp
5gWuHNuznd1PdThlB+vlGbAEGJp2uXDzAX0dbUeWPMM4k153g6b5Nw5QugAsnNj/
ZqMhzPu9jIcshLO+1PnQRNDMcluYdGOnDxg=
=qew6
-----END PGP SIGNATURE-----

--9fcfc53e0fcd83cc188fa2e200cd3fe58dd86edaab762b63b2b775e59452--

