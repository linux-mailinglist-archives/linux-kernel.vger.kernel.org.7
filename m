Return-Path: <linux-kernel+bounces-594072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 115D6A80CA2
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Apr 2025 15:41:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 62B297B6C56
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Apr 2025 13:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FBF718784A;
	Tue,  8 Apr 2025 13:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ndVeUD8/"
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16DA5170826
	for <linux-kernel@vger.kernel.org>; Tue,  8 Apr 2025 13:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744119694; cv=none; b=nU6iT5Rm+R/yJM1E2LqPSAqA0Y0dL4MT5dOeyDVMRtYitz3WnyQXPIrEm2oXvSdFB8sDayKtBL6UZ4Ew380q1m0d9abCFmU1HnhHyJxWKAklLQboeOZJHCRwPd2JLc14Gx8G7HFIUNTlLzuVtJzRpwXkydTQ5623+5o/26qacYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744119694; c=relaxed/simple;
	bh=ascLXQfARhHSzi851xNKkCwST5leRtzxKcYOE4Jx9iM=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=jR8TE6hXMMqNzKNxUX3H5huzKJaa67bhSpoZloSyJB0ddyVu+GAjCU4tZtXLjSDVf7TM/qN6DpgWf0mNgWKkzffZN3/kTSn6uzB5Mwsio4GXUIIQRTw5z9CK8oGEsylZXizxeq9rdpRM9/KjKG5y3eDhNP7DoE1DP3HKZuyw36I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ndVeUD8/; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <94a1f5bf-5b6d-47cc-a344-753a8a5272bd@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1744119688;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UJ24xdldXfdfyi1hupLmHyJNywDoo6R03YHUziiP89M=;
	b=ndVeUD8/kmEJGa0tXr+U2XGei6GsKw6VxzY1HY/8dfxqLJXpDOk3JwaAWHvPTzlganu84O
	FTxfRsXeLa5VY5i5pvXul53pqFATDlZYfrWCQiynWbpVdOfLi9AY64rOMtFLNkbJ0n0S+b
	QCr/G4TBZyYWYZqUE4WroZ/OTQRGGM4=
Date: Tue, 8 Apr 2025 19:10:34 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Aradhya Bhatia <aradhya.bhatia@linux.dev>
Subject: Re: [PATCH v2 12/18] drm/bridge: cdns-dsi: Drop checks that shouldn't
 be in .mode_valid()
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-phy@lists.infradead.org, Francesco Dolcini <francesco@dolcini.it>,
 Devarsh Thakkar <devarsht@ti.com>, Jyri Sarha <jyri.sarha@iki.fi>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>
References: <20250402-cdns-dsi-impro-v2-0-4a093eaa5e27@ideasonboard.com>
 <20250402-cdns-dsi-impro-v2-12-4a093eaa5e27@ideasonboard.com>
 <46dc6803-47f0-4434-9794-08307604e450@linux.dev>
 <daa8c462-e2c7-47fa-9ccd-b72dc3c6b9cc@ideasonboard.com>
 <03142c89-fc5a-45cf-9233-549ec1b9a469@ideasonboard.com>
Content-Language: en-US
In-Reply-To: <03142c89-fc5a-45cf-9233-549ec1b9a469@ideasonboard.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Hi Tomi,

On 08/04/25 12:39, Tomi Valkeinen wrote:
> Hi,
> 
> On 08/04/2025 09:09, Tomi Valkeinen wrote:
>> Hi,
>>
>> On 07/04/2025 20:59, Aradhya Bhatia wrote:
>>> Hi Tomi,
>>>
>>> On 02/04/25 19:00, Tomi Valkeinen wrote:
>>>> The docs say about mode_valid():
>>>>
>>>> "it is not allowed to look at anything else but the passed-in mode, and
>>>> validate it against configuration-invariant hardware constraints"
>>>>
>>>> We're doing a lot more than just looking at the mode. The main issue
>>>> here is that we're doing checks based on the pixel clock, before we
>>>> know
>>>> what the pixel clock from the crtc actually is.
>>>>
>>>> So, drop the checks from .mode_valid(). This also allows us to remove
>>>> the 'mode_valid_check' parameter from internal functions, and the
>>>> related code.
>>>>
>>>> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
>>>> ---
>>>>   drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c | 44 +++++++
>>>> +------------------
>>>>   1 file changed, 14 insertions(+), 30 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c b/
>>>> drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
>>>> index e85c8652c96e..cf783680b1b4 100644
>>>> --- a/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
>>>> +++ b/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
>>>> @@ -469,25 +469,17 @@ static unsigned int dpi_to_dsi_timing(unsigned
>>>> int dpi_timing,
>>>>   static int cdns_dsi_mode2cfg(struct cdns_dsi *dsi,
>>>>                    const struct drm_display_mode *mode,
>>>> -                 struct cdns_dsi_cfg *dsi_cfg,
>>>> -                 bool mode_valid_check)
>>>> +                 struct cdns_dsi_cfg *dsi_cfg)
>>>>   {
>>>>       struct cdns_dsi_output *output = &dsi->output;
>>>>       u32 dpi_hsa, dpi_hbp, dpi_hfp, dpi_hact;
>>>>       bool sync_pulse;
>>>>       int bpp;
>>>> -    if (mode_valid_check) {
>>>> -        dpi_hsa = mode->hsync_end - mode->hsync_start;
>>>> -        dpi_hbp = mode->htotal - mode->hsync_end;
>>>> -        dpi_hfp = mode->hsync_start - mode->hdisplay;
>>>> -        dpi_hact = mode->hdisplay;
>>>> -    } else {
>>>> -        dpi_hsa = mode->crtc_hsync_end - mode->crtc_hsync_start;
>>>> -        dpi_hbp = mode->crtc_htotal - mode->crtc_hsync_end;
>>>> -        dpi_hfp =  mode->crtc_hsync_start - mode->crtc_hdisplay;
>>>> -        dpi_hact = mode->crtc_hdisplay;
>>>> -    }
>>>> +    dpi_hsa = mode->crtc_hsync_end - mode->crtc_hsync_start;
>>>> +    dpi_hbp = mode->crtc_htotal - mode->crtc_hsync_end;
>>>> +    dpi_hfp =  mode->crtc_hsync_start - mode->crtc_hdisplay;
>>>> +    dpi_hact = mode->crtc_hdisplay;
>>>>       memset(dsi_cfg, 0, sizeof(*dsi_cfg));
>>>> @@ -518,8 +510,7 @@ static int cdns_dsi_mode2cfg(struct cdns_dsi *dsi,
>>>>   static int cdns_dsi_adjust_phy_config(struct cdns_dsi *dsi,
>>>>                     struct cdns_dsi_cfg *dsi_cfg,
>>>>                     struct phy_configure_opts_mipi_dphy *phy_cfg,
>>>> -                  const struct drm_display_mode *mode,
>>>> -                  bool mode_valid_check)
>>>> +                  const struct drm_display_mode *mode)
>>>>   {
>>>>       struct cdns_dsi_output *output = &dsi->output;
>>>>       unsigned long long dlane_bps;
>>>> @@ -549,11 +540,11 @@ static int cdns_dsi_adjust_phy_config(struct
>>>> cdns_dsi *dsi,
>>>>       if (dsi_htotal % lanes)
>>>>           adj_dsi_htotal += lanes - (dsi_htotal % lanes);
>>>> -    dpi_hz = (mode_valid_check ? mode->clock : mode->crtc_clock) *
>>>> 1000;
>>>> +    dpi_hz = mode->crtc_clock * 1000;
>>>>       dlane_bps = (unsigned long long)dpi_hz * adj_dsi_htotal;
>>>>       /* data rate in bytes/sec is not an integer, refuse the mode. */
>>>> -    dpi_htotal = mode_valid_check ? mode->htotal : mode->crtc_htotal;
>>>> +    dpi_htotal = mode->crtc_htotal;
>>>>       if (do_div(dlane_bps, lanes * dpi_htotal))
>>>>           return -EINVAL;
>>>> @@ -569,27 +560,25 @@ static int cdns_dsi_adjust_phy_config(struct
>>>> cdns_dsi *dsi,
>>>>   static int cdns_dsi_check_conf(struct cdns_dsi *dsi,
>>>>                      const struct drm_display_mode *mode,
>>>> -                   struct cdns_dsi_cfg *dsi_cfg,
>>>> -                   bool mode_valid_check)
>>>> +                   struct cdns_dsi_cfg *dsi_cfg)
>>>>   {
>>>>       struct cdns_dsi_output *output = &dsi->output;
>>>>       struct phy_configure_opts_mipi_dphy *phy_cfg = &output-
>>>> >phy_opts.mipi_dphy;
>>>>       unsigned int nlanes = output->dev->lanes;
>>>> -    int mode_clock = (mode_valid_check ? mode->clock : mode-
>>>> >crtc_clock);
>>>>       unsigned long req_hs_clk_rate;
>>>>       int ret;
>>>> -    ret = cdns_dsi_mode2cfg(dsi, mode, dsi_cfg, mode_valid_check);
>>>> +    ret = cdns_dsi_mode2cfg(dsi, mode, dsi_cfg);
>>>>       if (ret)
>>>>           return ret;
>>>> -    ret = phy_mipi_dphy_get_default_config(mode_clock * 1000,
>>>> +    ret = phy_mipi_dphy_get_default_config(mode->crtc_clock * 1000,
>>>>                              mipi_dsi_pixel_format_to_bpp(output-
>>>> >dev->format),
>>>>                              nlanes, phy_cfg);
>>>>       if (ret)
>>>>           return ret;
>>>> -    ret = cdns_dsi_adjust_phy_config(dsi, dsi_cfg, phy_cfg, mode,
>>>> mode_valid_check);
>>>> +    ret = cdns_dsi_adjust_phy_config(dsi, dsi_cfg, phy_cfg, mode);
>>>>       if (ret)
>>>>           return ret;
>>>> @@ -635,8 +624,7 @@ cdns_dsi_bridge_mode_valid(struct drm_bridge
>>>> *bridge,
>>>>       struct cdns_dsi_input *input = bridge_to_cdns_dsi_input(bridge);
>>>>       struct cdns_dsi *dsi = input_to_dsi(input);
>>>>       struct cdns_dsi_output *output = &dsi->output;
>>>> -    struct cdns_dsi_cfg dsi_cfg;
>>>> -    int bpp, ret;
>>>> +    int bpp;
>>>>       /*
>>>>        * VFP_DSI should be less than VFP_DPI and VFP_DSI should be at
>>>> @@ -654,10 +642,6 @@ cdns_dsi_bridge_mode_valid(struct drm_bridge
>>>> *bridge,
>>>>       if ((mode->hdisplay * bpp) % 32)
>>>>           return MODE_H_ILLEGAL;
>>>> -    ret = cdns_dsi_check_conf(dsi, mode, &dsi_cfg, true);
>>>> -    if (ret)
>>>> -        return MODE_BAD;
>>>> -
>>>>       return MODE_OK;
>>>>   }
>>>> @@ -996,7 +980,7 @@ static int cdns_dsi_bridge_atomic_check(struct
>>>> drm_bridge *bridge,
>>>>       adjusted_crtc_mode->flags &= ~(DRM_MODE_FLAG_PHSYNC |
>>>> DRM_MODE_FLAG_PVSYNC);
>>>>       adjusted_crtc_mode->flags |= DRM_MODE_FLAG_NHSYNC |
>>>> DRM_MODE_FLAG_NVSYNC;
>>>> -    return cdns_dsi_check_conf(dsi, mode, dsi_cfg, false);
>>>> +    return cdns_dsi_check_conf(dsi, mode, dsi_cfg);
>>>
>>> With this patch, the driver shifts to using the crtc_* values during the
>>> check phase, and then, it is brought back to using non crtc_* values in
>>> the next patch.
>>>
>>> Should this patch just drop the cdns_dsi_check_conf() check from
>>> .mode_valid() instead, and let the next patch phase out the
>>> mdoe_valid_check parameter as the driver simultaneously shifts to using
>>> the non crtc_* values throughout?
>>
>> Yes.
> 
> Actually, this patch doesn't change the crtc_* vs non-crtc_* behavior.
> After dropping the cdns_dsi_check_conf() call in mode_valid(), the
> 'mode_valid_check' is always false. So this patch removes the parameter,
> and any code paths for the true-case.
> 
> Should the atomic_check() have been using 'true' for the
> 'mode_valid_check'? The atomic_check code was added in
> a53d987756eab40678f241d7cd0eb7e1ca42bba7.
> 

You are right. I had lost a bit of context there.

Upon seeing the change logs, and history for my DSI patches, it seems
that the _atomic_check() was added as a replacement for the check that
was taking place in the _(atomic)_enable(), because the enable-path was
not the right place to do so.

Since the enable-path worked on crtc_* values, the check used to happen
with crtc_* values. And then the _atomic_check() continued to use the
crtc_* values after the patch.

But, since the crtc_* values don't get populated before the bridge's
check-phase, the crtc_* values shouldn't be used at this stage for any
checks.
They are getting populated in this case, via the fbdev_client_setup, if
I understand that right. But it's not right to depend on fbdev as it can
be disabled.

So, it would make sense to use 'true' for the `mode_valid_check`
parameter here. And, I will post a fix for this.


However, we have another question. How would the driver verify the
crtc_* values then, if not during the enable-path? Effectively, it might
not matter for this driver, but there should be a general guideline.


--
Regards
Aradhya

