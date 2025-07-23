Return-Path: <linux-kernel+bounces-742806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68F8CB0F6E5
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 17:23:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9600E171C64
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 15:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F18B72F270A;
	Wed, 23 Jul 2025 15:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=detlev.casanova@collabora.com header.b="CYPzz0WO"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B18552F5323;
	Wed, 23 Jul 2025 15:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753284203; cv=pass; b=MXjgZm2439f5vc7SoPz4B1cBRsHn9Udx2N3ZbtdF+9eXgUYyQCstdElsy6360xYYYhqnsWINQTtFLfp0TT/otNAUvczfNRT1UhEJ9uHJHyNj+2JiEGK3VN3Er/LA6DBRpx6VC1eIVrCjk6eElc9JhCxY/8uE09STEXzyny0DRRo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753284203; c=relaxed/simple;
	bh=tYdMW7RHmDK2cpcTIHh82RKvkBeFOT193ChYpw8FCEw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nyGfp+eYMAgT41J8mdMnjfGLI/403p5mirDriI3uZstH9RKQywLMXfBT19gEJipym+e9cm7WnD4yjHWc6K4gIFjubOdqCPY28Sv2dlTtuZZxx8S+LxkPozk4I//Zd8RcBGP36dyczRsqIpGnRcD2H0A+SjtVClfdo58bqXVZ6Kg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=detlev.casanova@collabora.com header.b=CYPzz0WO; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1753284131; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=bXhqymBa1MtylSabQFcuOC66glOaDTbXYNI4/wYNFIO+BKDCVDQt3jaAeis1DhC6NWPnjL6Bdy9Ajj5JGaBMl0AeH3lisMUQ1HxMCCmMH4xx0OroMhwtAoTJYNz38oO1o2YWn2ojBzImwAaCoyM7AGrZRzMwS0MQovHmtwwzJ+Y=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1753284131; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=iC8/alNqtl/wg+bowF1s5r7GLyw7rEy05us7vDQLZ4g=; 
	b=jnj5pwBUyIukgoxecfRnw3RHxzDiRHeXmfyIn2VJGMr5x7aVCUSLZCPc4imUF5NzBxbKMSa9ctZWUUsDNSaixXHfM5Egv7E0G27adiMWHTXt0ZIibLsoTFenDmqWsA8naCEnb0mYUbLmNGkfvbkQRZAfWMSKXymrBm5tHG6D0ys=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=detlev.casanova@collabora.com;
	dmarc=pass header.from=<detlev.casanova@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1753284131;
	s=zohomail; d=collabora.com; i=detlev.casanova@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
	bh=iC8/alNqtl/wg+bowF1s5r7GLyw7rEy05us7vDQLZ4g=;
	b=CYPzz0WOLAXmFszmJprIPR/kdebm1iQkVSJJJoMpi598jHEhJItJ/d5zpaGqc9Tn
	/d5GFAhmPd5yMyg2YvX31gpV+e+1mLZmFiBJpadrbo1Ls/G7E8Flt82E+MlsqFqrXsM
	A8lC7WKsPKrxFZDR/bA29yp3tyK3CPgk1Eug+yCg=
Received: by mx.zohomail.com with SMTPS id 1753284128259792.1770119186383;
	Wed, 23 Jul 2025 08:22:08 -0700 (PDT)
From: Detlev Casanova <detlev.casanova@collabora.com>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: linux-kernel@vger.kernel.org, Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Douglas Anderson <dianders@chromium.org>, Heiko Stuebner <heiko@sntech.de>,
 Sugar Zhang <sugar.zhang@rock-chips.com>,
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
 Charles Keepax <ckeepax@opensource.cirrus.com>,
 Raag Jadav <raag.jadav@intel.com>, dri-devel@lists.freedesktop.org,
 linux-sound@vger.kernel.org, kernel@collabora.com
Subject:
 Re: [PATCH v2 1/3] drm/bridge: dw-hdmi-qp: Return 0 in audio prepare when
 disconnected
Date: Wed, 23 Jul 2025 11:22:05 -0400
Message-ID: <6176714.lOV4Wx5bFT@earth>
In-Reply-To: <hw5grsaqfef4l55pu7ypsgojnltcynl22l4jqb7w2t6vlo3yxo@d5yhtxcmtroq>
References:
 <20250722195437.1347865-1-detlev.casanova@collabora.com>
 <20250722195437.1347865-2-detlev.casanova@collabora.com>
 <hw5grsaqfef4l55pu7ypsgojnltcynl22l4jqb7w2t6vlo3yxo@d5yhtxcmtroq>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-ZohoMailClient: External

Hi Dmitry
On Wednesday, 23 July 2025 07:41:43 EDT Dmitry Baryshkov wrote:
> On Tue, Jul 22, 2025 at 03:54:35PM -0400, Detlev Casanova wrote:
> > To configure audio registers, the clock of the video port in use must be
> > enabled.
> > As those clocks are managed by the VOP driver, they can't be enabled here
> > to write the registers even when the HDMI cable is disconnected.
> > 
> > Furthermore, the registers values are computed from the TMDS char rate,
> > which is not available when disconnected.
> > 
> > Returning -ENODEV seemed reasonable at first, but ASoC will log an error
> > multiple times if dw_hdmi_qp_audio_prepare() return an error.
> > Userspace might also retry multiple times, filling the kernel log with:
> > 
> > hdmi-audio-codec hdmi-audio-codec.0.auto: ASoC error (-19): at
> > snd_soc_dai_prepare() on i2s-hifi
> > 
> > This has become even worse with the support of the second HDMI TX port.
> > 
> > Activating the clocks to write fake data (fake because the TMDS char
> > rate is unavailable) would require API changes to communicate between
> > VOP and HDMI, which doesn't really make sense.
> > 
> > Using a cached regmap to be dumped when a cable is connected won't work
> > because writing order is important and some data needs to be retrieved
> > from registers to write others.
> > 
> > Returning 0 to silently fail sounds like the best and simplest solution.
> > 
> > Fixes: fd0141d1a8a2 ("drm/bridge: synopsys: Add audio support for
> > dw-hdmi-qp") Signed-off-by: Detlev Casanova
> > <detlev.casanova@collabora.com>
> > ---
> > 
> >  drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c | 10 +++++++++-
> >  1 file changed, 9 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c
> > b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c index
> > 5e5f8c2f95be1..9b9d43c02e3a5 100644
> > --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c
> > +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c
> > @@ -458,8 +458,16 @@ static int dw_hdmi_qp_audio_prepare(struct
> > drm_connector *connector,> 
> >  	struct dw_hdmi_qp *hdmi = dw_hdmi_qp_from_bridge(bridge);
> >  	bool ref2stream = false;
> > 
> > +	/*
> > +	 * Silently return if tmds_char_rate is not set.
> > +	 *
> > +	 * Writing audio registers requires that the clock of the Video Port
> > currently in +	 * use by the VOP (dclk_vp<id>) is enabled.
> > +	 * That clock is guaranteed to be enabled when hdmi->tmds_char_rate 
is
> > set, so we +	 * only configure audio when it is set.
> > +	 */
> > 
> >  	if (!hdmi->tmds_char_rate)
> > 
> > -		return -ENODEV;
> > +		return 0;
> 
> What if the cable gets diconnected _while_ this function is running?

Unplugging the cable will not deactivate the clocks, that's the job of the 
VOP's vop2_crtc_atomic_disable() function. My understanding is that that 
function will not be called until this one has returned, but I could be wrong.

> >  	if (fmt->bit_clk_provider | fmt->frame_clk_provider) {
> >  	
> >  		dev_err(hdmi->dev, "unsupported clock settings\n");

Regards,
Detlev.



