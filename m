Return-Path: <linux-kernel+bounces-792172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CFE63B3C10B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 18:42:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C4021CC46DF
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 16:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 930DF72626;
	Fri, 29 Aug 2025 16:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="I+Bh806c"
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F0933471D
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 16:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756485642; cv=none; b=C3FJ8yydOTjRygN5Vgz7ckBeKRMDDEIy/QjxDnNLCUCNCXjR06vthElYrVSEwgxG0EF8yniWBXeHleJmBg2mDGWxJ2YLFZtyFWHFVDDtSPAXXiwpDYDm5yi3SO1OQXw+OOxlEHvYaii0p4icerPfZipXkQ060T0MPM7BYPgKm1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756485642; c=relaxed/simple;
	bh=x4ZDkkQZorcnoASI/OYgcdfOEbitgM/x31L3N1gCOhA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZCctHBnZHwpI8/V76nokGMN9sz3Jwm7eCKGAZaMItliW4Rod/dpbdvml54AEcwrl8P9oWKFWd3sL/bd6Q/qQOzmZJtZaNJSMeZs15Vigk6MNZ1/PB4ySBOmQ8f23xsfV31GWcTgAYsXRWERN2G1IDpjPlwQApldUsW4Go4snxWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=I+Bh806c; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-248a638dbbeso20757905ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 09:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1756485639; x=1757090439; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pw/8UIadEXy0T7dkot2/2NxJZHRvfpZovW+FIme3Y18=;
        b=I+Bh806c1JMBrWIRDz9s5hz6b48kdas1vht1IMriQ/IZKKgUJD2K0C8DV6jahoa9Pi
         NN2u+Ji7oEyLbLpDH81pS9n6BVb9SGsPYLCUfaGyOOZqPO2RFRNRaEDKRTIubr9IaqXz
         Qg4USWS1sI7HUYsaEJG8hudB5VRWxphjCiEl4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756485639; x=1757090439;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pw/8UIadEXy0T7dkot2/2NxJZHRvfpZovW+FIme3Y18=;
        b=ZJICiFg/C8euBrcxFSplDO9zvTiTYt7w8paJ6WKzOKCy2dPV24q/I/mxDWMfFdZUbm
         QAjvDRM8f1Xfb3dRBDVbPkVJdhVLTDqG2pRK871/lVG1uo8w16zeGDK+tVKQWUYk5hvf
         C3GsEiqntDdC2TM0S/s3Y5DK5NMO7Q6/3c4Ku5uBfD3u8LpOFvhJSQxVymr04Fuvd3Fb
         E5ukkvodMUOrgXha3RH6ze0ZpraZtqDVsOvSpderC3OMnNNJqbnhmNI3nY0hBi9UMqdN
         hArsIC22tlX/m4p5YV3IAvzXZRviA3vb6WMzUArSipKriooQhTHHHr0MLF+SyFmPkPSO
         FN7g==
X-Forwarded-Encrypted: i=1; AJvYcCUuUaN6r8+LJUgMq09EZMlZOXFZytTSHGQ1YJpwYmYjMUJzNSFo3b3ijYTNaEPPjx1hL8biQpwW4GOPk70=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJYeGbkTmQ03Z3lcnsTeELrvHfWRCyPffofCSO/pYDWCx11uNq
	CIUrnj47y6VTzsYl72oIyCQ62yb0we8BgtnFC7EfHw4NMBb6tTwjImQzksMBilkTg9wJ6Zj0Mae
	DYRsSUg==
X-Gm-Gg: ASbGncvGDWWj77ezL2IEP8kfUBJnM49ketK6fnoZvpSm6rhhAu73Hof7L4MfkBcdmEI
	Hkz1aNVBFkUZTZt8GqvuSdaS1Pn9Pfpu8/IOsU9bAuytm5XMAGEQVNScLHWruMANz9hDbPhLa2x
	lA+1oL4dGTVY1hb6pxZphcYCbZKtRBkiXmaoq37Lob73uX624oUw+nhTxJZOnQj5iXmfXtjaI+t
	8DkZ+VK7SwujJAnjFHYlpYJolWibQZaEAh8YuKqLx1Iajj9BmJFHuDwvfqd6AXDBra0ZU19pOLK
	sugeXpf081X/zNl5ron6Zhi+FuOJ2N3zeKMU37dViXJDgzINmt1rumXcvrKZkvzODHn8MlAWvy2
	OmWIqK0JrT4YOu0/omqW6GDCdTR3GraxZF0ikqYa1sqQeg3o8KR0bduITxzYH3wKSgwnK7okbmP
	1q
X-Google-Smtp-Source: AGHT+IGZVlobkyEJz+XTVUKlxPPzusNeHpy6QqXC/eROHxdJdl0VA2OVepfpnje+EnOSVS9BKoFbHQ==
X-Received: by 2002:a17:902:f602:b0:249:f16:f06c with SMTP id d9443c01a7336-2490f16f406mr54047565ad.15.1756485639624;
        Fri, 29 Aug 2025 09:40:39 -0700 (PDT)
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com. [209.85.215.176])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24903705bd6sm29273575ad.30.2025.08.29.09.40.39
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Aug 2025 09:40:39 -0700 (PDT)
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b4c72885c8bso1261034a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 09:40:39 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVn/ZDk3acT9NNRIi9WIcZKmUIeNDm6gJ2PWXnKho62gsCdJuuAv4YWlBHS/2SINOc8jEv3ffH1tTzazu0=@vger.kernel.org
X-Received: by 2002:a17:903:1a88:b0:240:671c:6341 with SMTP id
 d9443c01a7336-2462ee9bb60mr441983655ad.26.1756485638246; Fri, 29 Aug 2025
 09:40:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250820152407.2788495-1-john.ripple@keysight.com>
In-Reply-To: <20250820152407.2788495-1-john.ripple@keysight.com>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 29 Aug 2025 09:40:26 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WiORm+rawNZoinXFZWdt_yqKQfTFWCiBcJFyJKXj4spQ@mail.gmail.com>
X-Gm-Features: Ac12FXwe3dzJSqeETH_QgJavTfzSE7FIFSZtHwGhpfmt-3bMa7L5D_syMoMJ_fo
Message-ID: <CAD=FV=WiORm+rawNZoinXFZWdt_yqKQfTFWCiBcJFyJKXj4spQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/bridge: ti-sn65dsi86: Add support for DisplayPort
 mode with HPD
To: John Ripple <john.ripple@keysight.com>
Cc: andrzej.hajda@intel.com, neil.armstrong@linaro.org, rfoss@kernel.org, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, 
	airlied@gmail.com, simona@ffwll.ch, Laurent.pinchart@ideasonboard.com, 
	jonas@kwiboo.se, jernej.skrabec@gmail.com, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Aug 20, 2025 at 8:24=E2=80=AFAM John Ripple <john.ripple@keysight.c=
om> wrote:
>
> Add support for DisplayPort to the bridge, which entails the following:
> - Register the proper connector type;
> - Get and use an interrupt for HPD;
> - Properly clear all status bits in the interrupt handler;
> - Implement bridge and connector detection;
> - Report DSI channel errors;
> - Report Display Port errors;
> - Disable runtime pm entirely;
>
> Signed-off-by: John Ripple <john.ripple@keysight.com>
> ---
>  drivers/gpu/drm/bridge/ti-sn65dsi86.c | 287 +++++++++++++++++++++++++-
>  1 file changed, 281 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi86.c b/drivers/gpu/drm/brid=
ge/ti-sn65dsi86.c
> index 464390372b34..75f9be347b41 100644
> --- a/drivers/gpu/drm/bridge/ti-sn65dsi86.c
> +++ b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
> @@ -37,6 +37,8 @@
>
>  #define SN_DEVICE_ID_REGS                      0x00    /* up to 0x07 */
>  #define SN_DEVICE_REV_REG                      0x08
> +#define SN_RESET_REG                           0x09
> +#define  SOFT_RESET                            BIT(0)
>  #define SN_DPPLL_SRC_REG                       0x0A
>  #define  DPPLL_CLK_SRC_DSICLK                  BIT(0)
>  #define  REFCLK_FREQ_MASK                      GENMASK(3, 1)
> @@ -48,7 +50,9 @@
>  #define  CHA_DSI_LANES(x)                      ((x) << 3)
>  #define SN_DSIA_CLK_FREQ_REG                   0x12
>  #define SN_CHA_ACTIVE_LINE_LENGTH_LOW_REG      0x20
> +#define SN_CHA_ACTIVE_LINE_LENGTH_HIGH_REG     0x21

This and many other #defines you added aren't actually used in your patch.

One can make an argument that adding #defines for all the registers
and bits in the datasheet (even if they're not used) is a good thing.
...but one can also make the argument that we should avoid cluttering
the driver with extra #defines until they're needed, especially since
the datasheet for this part is public. We can certainly have that
debate if you want, but let's please do it in a separate patch. Adding
all of these defines is not required for your HPD case so shouldn't be
in the HPD patch.


> @@ -189,6 +305,7 @@ struct ti_sn65dsi86 {
>         int                             dp_lanes;
>         u8                              ln_assign;
>         u8                              ln_polrs;
> +       bool                    no_hpd;

nit: in my editor the indentation seems wrong here.


> @@ -987,6 +1104,11 @@ static int ti_sn_link_training(struct ti_sn65dsi86 =
*pdata, int dp_rate_idx,
>         int ret;
>         int i;
>
> +       /*
> +        * DP data rate and lanes number will be set by the bridge by wri=
ting
> +        * to DP_LINK_BW_SET and DP_LANE_COUNT_SET.
> +        */
> +

This comment seems unrelated to your patch. If we want to add it,
please do so in a separate patch.

Also, please match the names used elsewhere in the file. Searching the
file for DP_LINK_BW_SET and DP_LANE_COUNT_SET shows no hits.


> @@ -1105,7 +1227,10 @@ static void ti_sn_bridge_atomic_enable(struct drm_=
bridge *bridge,
>
>         valid_rates =3D ti_sn_bridge_read_valid_rates(pdata);
>
> -       /* Train until we run out of rates */
> +       /*
> +        * Train until we run out of rates. Start with the lowest possibl=
e rate
> +        * and move up in order to select the lowest working functioning =
point.
> +        */

Similar to the last comment. If we want to improve comments it should
be done in a separate patch.


>         for (dp_rate_idx =3D ti_sn_bridge_calc_min_dp_rate_idx(pdata, sta=
te, bpp);
>              dp_rate_idx < ARRAY_SIZE(ti_sn_bridge_dp_rate_lut);
>              dp_rate_idx++) {
> @@ -1116,9 +1241,13 @@ static void ti_sn_bridge_atomic_enable(struct drm_=
bridge *bridge,
>                 if (!ret)
>                         break;
>         }
> -       if (ret) {
> +       if (ret || dp_rate_idx =3D=3D ARRAY_SIZE(ti_sn_bridge_dp_rate_lut=
)) {

Why did you need to change? We'll always run through the above loop at
least once, right? That means we'll always set "ret"


>                 DRM_DEV_ERROR(pdata->dev, "%s (%d)\n", last_err_str, ret)=
;
>                 return;
> +       } else {
> +               DRM_DEV_INFO(pdata->dev,
> +                            "Link training selected rate: %u MHz\n",
> +                            ti_sn_bridge_dp_rate_lut[dp_rate_idx]);

Again, this should be in a separate patch.

Also: this is logspam. If there's really a reason we need to logspam
every time we link train then that reason needs to be justified. IMO
it would be fine to make this a "debug" level log, but I'd be against
leaving it at INFO level.


> @@ -1298,6 +1427,69 @@ static int ti_sn_bridge_parse_dsi_host(struct ti_s=
n65dsi86 *pdata)
>         return 0;
>  }
>
> +static irqreturn_t ti_sn_bridge_interrupt(int irq, void *private)
> +{
> +       struct ti_sn65dsi86 *pdata =3D private;
> +       struct drm_device *dev =3D pdata->bridge.dev;
> +       u32 status =3D 0;
> +       bool hpd_event =3D false;
> +
> +       regmap_read(pdata->regmap, SN_IRQ_STATUS_REG, &status);

Please check the return code from regmap_read(), since i2c transfers
can fail. I know this driver isn't terribly good about it with
existing code, but that doesn't mean we should keep being bad about it
with new code.



> +       if (status & (HPD_REMOVAL_STATUS | HPD_INSERTION_STATUS))
> +               hpd_event =3D true;

hpd_event =3D status & (HPD_REMOVAL_STATUS | HPD_INSERTION_STATUS);


> +       /*
> +        * Writing back the status register to acknowledge the IRQ appare=
ntly
> +        * needs to take place right after reading it or the bridge will =
get
> +        * confused and fail to report subsequent IRQs.
> +        */

Really? Is this documented?

In general for edge triggered interrupts you always want to
acknowledge before you actually act on them. Is it just that, or does
this specifically have to be before other stuff below?


> +       if (status)
> +               drm_err(dev, "(SN_IRQ_STATUS_REG =3D %#x)\n", status);

Getting interrupts is an "error" ? That doesn't seem right.


> +       regmap_write(pdata->regmap, SN_IRQ_STATUS_REG, status);

Shouldn't it only write if non-zero?


> +       regmap_read(pdata->regmap, SN_CHA_IRQ_STATUS0_REG, &status);
> +       if (status)
> +               drm_err(dev, "DSI CHA error reported (status0 =3D %#x)\n"=
, status);
> +       regmap_write(pdata->regmap, SN_CHA_IRQ_STATUS0_REG, status);
> +       if (status)
> +               regmap_write(pdata->regmap, SN_RESET_REG, SOFT_RESET);
> +
> +       regmap_read(pdata->regmap, SN_CHA_IRQ_STATUS1_REG, &status);
> +       if (status)
> +               drm_err(dev, "DSI CHA error reported (status1 =3D %#x)\n"=
, status);
> +       regmap_write(pdata->regmap, SN_CHA_IRQ_STATUS1_REG, status);
> +       if (status)
> +               regmap_write(pdata->regmap, SN_RESET_REG, SOFT_RESET);
> +
> +       /* Dirty hack to reset the soft if any error occurs on the DP sid=
e */
> +       regmap_read(pdata->regmap, SN_IRQ_EVENTS_DPTL_REG_1, &status);
> +       if (status)
> +               drm_err(dev, "(SN_IRQ_EVENTS_DPTL_REG_1 =3D %#x)\n", stat=
us);
> +       regmap_write(pdata->regmap, SN_IRQ_EVENTS_DPTL_REG_1, status);
> +       if (status)
> +               regmap_write(pdata->regmap, SN_RESET_REG, SOFT_RESET);
> +
> +       regmap_read(pdata->regmap, SN_IRQ_EVENTS_DPTL_REG_2, &status);
> +       if (status)
> +               drm_err(dev, "(SN_IRQ_EVENTS_DPTL_REG_2 =3D %#x)\n", stat=
us);
> +       regmap_write(pdata->regmap, SN_IRQ_EVENTS_DPTL_REG_2, status);
> +       if (status)
> +               regmap_write(pdata->regmap, SN_RESET_REG, SOFT_RESET);
> +
> +       regmap_read(pdata->regmap, SN_IRQ_LT, &status);
> +       if (status)
> +               drm_err(dev, "(SN_IRQ_LT =3D %#x)\n", status);
> +       regmap_write(pdata->regmap, SN_IRQ_LT, status);
> +       if (status)
> +               regmap_write(pdata->regmap, SN_RESET_REG, SOFT_RESET);

If we want to start handling error interrupts, let's do it in a
separate patch please. Then we can talk about what kind of value this
brings and how you've tested it.


> @@ -1335,9 +1527,48 @@ static int ti_sn_bridge_probe(struct auxiliary_dev=
ice *adev,
>                  * for eDP.
>                  */
>                 mutex_lock(&pdata->comms_mutex);
> -               if (pdata->comms_enabled)
> +               if (pdata->comms_enabled) {
> +                       /* Enable HPD and PLL events. */
> +                       regmap_write(pdata->regmap, SN_IRQ_EVENTS_EN_REG,
> +                                       PLL_UNLOCK_EN |
> +                                       HPD_REPLUG_EN |
> +                                       HPD_REMOVAL_EN |
> +                                       HPD_INSERTION_EN |
> +                                       IRQ_HPD_EN);
> +
> +                       /* Enable DSI CHA error reporting events. */
> +                       regmap_write(pdata->regmap, SN_CHA_IRQ_EN0_REG,
> +                                       CHA_CONTENTION_DET_EN |
> +                                       CHA_FALSE_CTRL_EN |
> +                                       CHA_TIMEOUT_EN |
> +                                       CHA_LP_TX_SYNC_EN |
> +                                       CHA_ESC_ENTRY_EN |
> +                                       CHA_EOT_SYNC_EN |
> +                                       CHA_SOT_SYNC_EN |
> +                                       CHA_SOT_BIT_EN);
> +
> +                       regmap_write(pdata->regmap, SN_CHA_IRQ_EN1_REG,
> +                                       CHA_DSI_PROTOCOL_EN |
> +                                       CHA_INVALID_LENGTH_EN |
> +                                       CHA_DATATYPE_EN |
> +                                       CHA_CHECKSUM_EN |
> +                                       CHA_UNC_ECC_EN |
> +                                       CHA_COR_ECC_EN);
> +
> +                       /* Disable DSI CHB error reporting events. */
> +                       regmap_write(pdata->regmap, SN_CHB_IRQ_EN0_REG, 0=
);
> +                       regmap_write(pdata->regmap, SN_CHB_IRQ_EN1_REG, 0=
);
> +
>                         regmap_update_bits(pdata->regmap, SN_HPD_DISABLE_=
REG,
> -                                          HPD_DISABLE, 0);
> +                                       HPD_DISABLE, 0);
> +
> +                       /* Enable DisplayPort error reporting events. */
> +                       regmap_write(pdata->regmap, SN_DPTL_IRQ_EN0_REG, =
0xFF);
> +                       regmap_write(pdata->regmap, SN_DPTL_IRQ_EN1_REG, =
0xFF);
> +
> +                       regmap_update_bits(pdata->regmap, SN_IRQ_EN_REG, =
IRQ_EN,

As per previous comment, enabling the error interrupts should be in a
separate patch.


> @@ -1884,8 +2115,12 @@ static inline void ti_sn_gpio_unregister(void) {}
>
>  static void ti_sn65dsi86_runtime_disable(void *data)
>  {
> -       pm_runtime_dont_use_autosuspend(data);
> -       pm_runtime_disable(data);
> +       if (pm_runtime_enabled(data)) {
> +               pm_runtime_dont_use_autosuspend(data);
> +               pm_runtime_disable(data);
> +       } else {
> +               ti_sn65dsi86_suspend(data);
> +       }

See below--we should leverage the existing code to keep PM Runtime on
when HPD is used.


> @@ -1943,6 +2178,7 @@ static int ti_sn65dsi86_probe(struct i2c_client *cl=
ient)
>                 return dev_err_probe(dev, PTR_ERR(pdata->refclk),
>                                      "failed to get reference clock\n");
>
> +       pdata->no_hpd =3D of_property_read_bool(pdata->host_node, "no-hpd=
");
>         pm_runtime_enable(dev);
>         pm_runtime_set_autosuspend_delay(pdata->dev, 500);
>         pm_runtime_use_autosuspend(pdata->dev);
> @@ -1950,6 +2186,45 @@ static int ti_sn65dsi86_probe(struct i2c_client *c=
lient)
>         if (ret)
>                 return ret;
>
> +       if (client->irq && !pdata->no_hpd) {
> +               enum drm_connector_status status;
> +
> +               pm_runtime_disable(pdata->dev);

You can't permanently disable pm_runtime (AKA always keep things
powered on) based on just having an IRQ and lacking "no-hpd".

Instead, this decision needs to be made based on "DP" vs. "eDP". When
using the bridge in "eDP" mode you still want to be able to power the
bridge down even if interrupts and HPD are hooked up. This is because
in the "eDP" case you always just assume that the panel is there and
you don't need to detect it. This allows you to go into a lower power
state when the eDP panel is turned off because you can power the
bridge off.

We also already handle powering the bridge on in that case. See commit
55e8ff842051 ("drm/bridge: ti-sn65dsi86: Add HPD for DisplayPort
connector type"). You can see there that when
ti_sn_bridge_hpd_enable() is called we power the bridge on and it will
stay on.

What you should be doing is hooking into the ti_sn_bridge_hpd_enable()
function. When you see that then you should enable the interrupt. IMO
in probe you could still request the HPD interrupt. One way to do this
would be to set the `SN_IRQ_EVENTS_EN_REG` to turn on the HPD
interrupts in ti_sn_bridge_hpd_enable() after grabbing the runtime PM
reference and turn them off in ti_sn_bridge_hpd_disable() before
dropping it.



-Doug

