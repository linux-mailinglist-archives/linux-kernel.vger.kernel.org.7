Return-Path: <linux-kernel+bounces-736438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BA4FFB09CE5
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 09:44:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84A55188131E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 07:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A650D268688;
	Fri, 18 Jul 2025 07:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="NtDb9gfu"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88EC81E832E;
	Fri, 18 Jul 2025 07:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752824642; cv=none; b=c2K3Iq2K50r1+sTwdsYjiRAMdjiazEjOD0D2OhmRKwJVqXRRMdNN1OPv0bEN14cLQvM/s/m3bczbcP/BiYWmRmQaj5jHxod+nCHzI7dtqWFoMBusdoxI1cAVC4akZG4r8hAOr4mJQQmm4XeYRmNgOP+f3zRRP7PQyWOwGM9ZRyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752824642; c=relaxed/simple;
	bh=1PJNCL9BqSSVcVst5Z4CEEQFfiTYdhO5/sNJF+NRPCc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WKgOccBN5xWv+MoFizl1sgbdnvLhxF88wa8wpzQsnJX2eQjAxpyNuBB6RrSngrPBM0tmQgygFZLlwI4Hzoh8+4hnRMOyqzlWaa8wSxYj+cW0U2xGioBbTMsk4+cpgyx+Fy2iEDDZIaDi9JMu+klSQYsHkCwaTUlevJvVxUU1Gi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=NtDb9gfu; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=34xXsyuXLt5G3sFnnm6LhH0F5M0Q/CkN67+h8HkKCxM=; b=NtDb9gfuqjcjuFv2bb5yO2ErUu
	09m3nI8IKZPKenJnZ3CKZiGRxiSW+f6xClTFPKwwy1+1135Ln35PsRzJQrho/KbaArb4IpsoojkDy
	g7peFThtI9xjmVgSmub8FBHopdReuQT6NIb/h5VlfZo35FQKCMqqdz3dkv7rI3pCGW1PYx980PuUZ
	xBw3NCnrt+goyscrsY1q1Df54YHmNrKTluZXKbNPmzojROJRDQacm1x7bTUgRCYbOZE9oa+558h6P
	fasIVQFdQZl9wLr5Pxgt4KigYQTrK85dP7IYMoM5CNwbjUCukXMd6N5xmucBhSdVGaTJT6xVhpiOl
	+svb00ZA==;
Received: from cst-prg-35-241.cust.vodafone.cz ([46.135.35.241] helo=phil.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1ucfke-0001jF-Us; Fri, 18 Jul 2025 09:43:29 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: linux-kernel@vger.kernel.org,
 Detlev Casanova <detlev.casanova@collabora.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Detlev Casanova <detlev.casanova@collabora.com>,
 Douglas Anderson <dianders@chromium.org>,
 Sugar Zhang <sugar.zhang@rock-chips.com>,
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
 Charles Keepax <ckeepax@opensource.cirrus.com>,
 Raag Jadav <raag.jadav@intel.com>, dri-devel@lists.freedesktop.org,
 linux-sound@vger.kernel.org, kernel@collabora.com
Subject:
 Re: [PATCH 1/3] drm/bridge: dw-hdmi-qp: Return 0 in audio prepare when
 disconnected
Date: Fri, 18 Jul 2025 09:43:26 +0200
Message-ID: <8861545.DvuYhMxLoT@phil>
In-Reply-To: <20250717215620.288651-2-detlev.casanova@collabora.com>
References:
 <20250717215620.288651-1-detlev.casanova@collabora.com>
 <20250717215620.288651-2-detlev.casanova@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Am Donnerstag, 17. Juli 2025, 23:56:18 Mitteleurop=C3=A4ische Sommerzeit sc=
hrieb Detlev Casanova:
> To configure audio registers, the clock of the video port in use must be
> enabled.
> As those clocks are managed by the VOP driver, they can't be enabled here
> to write the registers even when the HDMI cable is disconnected.
>=20
> Furthermore, the registers values are computed from the TMDS char rate,
> which is not available when disconnected.
>=20
> Returning -ENODEV seemed reasonable at first, but ASoC will log an error
> multiple times if dw_hdmi_qp_audio_prepare() return an error.
> Userspace might also retry multiple times, filling the kernel log with:
>=20
> hdmi-audio-codec hdmi-audio-codec.0.auto: ASoC error (-19): at snd_soc_da=
i_prepare() on i2s-hifi
>=20
> This has become even worse with the support of the second HDMI TX port.
>=20
> Activating the clocks to write fake data (fake because the TMDS char
> rate is unavailable) would require API changes to communicate between
> VOP and HDMI, which doesn't really make sense.
>=20
> Using a cached regmap to be dumped when a cable is connected won't work
> because writing order is important and some data needs to be retrieved
> from registers to write others.
>=20
> Returning 0 to silently fail sounds like the best and simplest solution.
>=20
> Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>
> ---
>  drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c b/drivers/gpu/d=
rm/bridge/synopsys/dw-hdmi-qp.c
> index 5e5f8c2f95be1..7d3d7b5084c8d 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c
> @@ -459,7 +459,7 @@ static int dw_hdmi_qp_audio_prepare(struct drm_connec=
tor *connector,
>  	bool ref2stream =3D false;
> =20
>  	if (!hdmi->tmds_char_rate)
> -		return -ENODEV;
> +		return 0;

nit: part of me would like a short comment stating the requirment of the
running video-clock.

Heiko

> =20
>  	if (fmt->bit_clk_provider | fmt->frame_clk_provider) {
>  		dev_err(hdmi->dev, "unsupported clock settings\n");
>=20





