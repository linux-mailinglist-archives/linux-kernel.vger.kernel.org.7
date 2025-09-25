Return-Path: <linux-kernel+bounces-831723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16DC4B9D66F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 06:44:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B9FF1B24A29
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 04:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15EA52E762E;
	Thu, 25 Sep 2025 04:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="befOMnmr"
Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 828662E719D
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 04:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758775437; cv=none; b=Xm8H5EyQsGA+5k/ZR90VsyqBBhxZ5VnbO0XaAiKULxqW0uHU6lUgQaDFLMBGSZ0EO7fWR4NPPGqWKTYtAB0OsW7tFBV9yMGNPw3tvMAMiKldKyMzIhiDlVqDCqp23sP5WzcORymXTB+6FmXbjEQlkUuZuLSrZV4KQHNp3HDhy6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758775437; c=relaxed/simple;
	bh=PGqrRhdMWce1Hj8sN1qPC6ME+4yXRSkg7MLsCSpcBNo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qowGfsB9h7p7lfs4uhRLwIMosukizVnbMVqT4RUfVjhaVZdris5GkpZIA9mclWtikPSAIoj33J+fJpXnTWLsIwxcQK0noVFBLt4OR4dy3WLBiTkfpwSHp1RWn6enooNuZvDLenCfAo5h3SelJdJxds0GChR0ScjvtYkzXh7FMcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=befOMnmr; arc=none smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-6352c8b683eso340306d50.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 21:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758775434; x=1759380234; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1oJ0z/i9UwoXPf+FRdpG+d9rqB85q6G/tg6yqdMdAbE=;
        b=befOMnmrxh4vJYQWGi6vRPyPQln0ja/KE+lvpxxAPyzrJ7/1ha9IJ7Lf9tTUfCh4fz
         wR3D4hgO5y2Ti1ATY7BQDA1OnOUz5KEJYmr+jwQ3MPiqc9wluPxEauWkx2g6GAb7tQWF
         KWDD7TOG/xMqzFK5+kqW/mr6AmnKjwp6YzFkmued3EVu1SjTf8g5/qfxH1c6yVhUUA3K
         drvqq5Kvsh1YM4n7JYQczceZDaNentHuS8SgRsu/L82ReigkByKt0y+SP3bL0refn449
         QHaIkZOkjy8uRfyFiMwlgoiwrOrHi4NJGxOWHrwYemy1jkrME+++mIXF6Qms0GNzAUdt
         51ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758775434; x=1759380234;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1oJ0z/i9UwoXPf+FRdpG+d9rqB85q6G/tg6yqdMdAbE=;
        b=iXroLMh3ANdE/B4SIcGW85s0f+Hakve8E/yQi15UjXbIGhAu9nkKimTlOL6roxHVFz
         uDqi7lI9761FQkSY0ZbqaCm/D5ztS55Wtpf9l8/KlYWcYVZPK1az5Obz15yxqXJDQkxC
         VeBoC5JT0lLhjAsdD6p2uRCU+/qNTHhMf64SgaCA8K1IOIcnz3E6Ou3nWjTj8Q755JSV
         7D+IYRyrycBqUW4XyGSz4LDin+9r+j4/IuVEYRaVKX0K/TFadOYU4vP/6YP89o5iWO0F
         dm8gAd1G/DtK1bflUrM7MiME9jY3FeWdXKQsqz9K9g2SBTUfTlX0ll/QbTWaOeEy5K/r
         SloA==
X-Forwarded-Encrypted: i=1; AJvYcCXNxhYRwb3dbD6GdXTY8x3HQZ1Q9YkW+rqyvXJlyywurEroG3qQw3JwymaQ3GEhzyFzmpqxpUm3QOK++HE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBlJ26sPRwkBqjdyMTKR94xANwRwxwjNZ1mq8r3PvBoJKMU2uZ
	OsfSXoz8122qJRHtMyrjztuOJuIKdm7PvNNge0MHVDLi1WhmOD72QIUm/gxPyxA70kt/JUD4Ovd
	h5NO2svGXSne7SuLKX7scfTegFoDdsUh0zgY0om8FEg==
X-Gm-Gg: ASbGncs9xGE9eNfJ2nXOuLzIBpeTX+Xd7qY4kxMb87l/n9X5irrb3BfIJGh+q4MtEOE
	b2seAxo7xo8Z0aAznUKS6UcZrKQ3P2iwBb7j9tFZHts56M50qrw6wSwFgQZg9dfvB6RWWa1gFIC
	Y86ZnV2IjxaQEqOq6Hrkr5Uo8jyMfCH1Hh+jGO/pjL9HbLNl/yKFko6NcoCqBE3GE3KHS9DxBQi
	DFZIYFFqkgTWhv0uZWGpV+r3g4JjheMRVc3fw==
X-Google-Smtp-Source: AGHT+IFrDu14o9eG1G/hd/jmgmyyF5h7kKgIrglBSkEsXTmL19swhPH9YqIMrOxeKGPXFw+V8ureBREiZfTmlkcgTpM=
X-Received: by 2002:a05:690e:2146:b0:633:961a:bd46 with SMTP id
 956f58d0204a3-6361a85f9a2mr1236698d50.25.1758775434361; Wed, 24 Sep 2025
 21:43:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250924-dsi-dual-panel-upstream-v3-0-6927284f1098@linaro.org>
 <20250924-dsi-dual-panel-upstream-v3-3-6927284f1098@linaro.org> <v3tfzspjck2oqppelx7bmi5uflhs47ixw6tjmq2d7inauzfo7k@gxebj3buyuni>
In-Reply-To: <v3tfzspjck2oqppelx7bmi5uflhs47ixw6tjmq2d7inauzfo7k@gxebj3buyuni>
From: Jun Nie <jun.nie@linaro.org>
Date: Thu, 25 Sep 2025 12:43:43 +0800
X-Gm-Features: AS18NWDgoGjQmOdf_hz0GeNod_X081dyusIHBuXhWh7GwxfQWDtv3U1S9TJ5f90
Message-ID: <CABymUCMvczXHM-cOXNko77xDVxX8Q6MA2AEZcGx_Yg6TWosMAg@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] drm/msm/dsi: Support dual panel use case with
 single CRTC
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>, Abhinav Kumar <abhinav.kumar@linux.dev>, 
	Jessica Zhang <jessica.zhang@oss.qualcomm.com>, Dmitry Baryshkov <lumag@kernel.org>, 
	Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Krishna Manikandan <quic_mkrishn@quicinc.com>, linux-arm-msm@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com> =E4=BA=8E2025=E5=B9=B4=
9=E6=9C=8825=E6=97=A5=E5=91=A8=E5=9B=9B 03:21=E5=86=99=E9=81=93=EF=BC=9A
>
> On Wed, Sep 24, 2025 at 11:08:12PM +0800, Jun Nie wrote:
> > Support a hardware configuration where two independent DSI panels are
> > driven by a single, synchronous CRTC. This configuration uses a bonded
> > DSI link to provide a unified vblank for both displays.
> >
> > This allows application software to treat the two displays as a single,
> > wide framebuffer with a synchronized refresh cycle, simplifying renderi=
ng
> > logic for side-by-side panel arrangements.
>
> I'd like to understand how is it framed on the overall system design
> level. If it's a panel controlled over the DSI interface, it's fine
> since we can broadcast commands over two DSI links. What if the panel
> (or bridge) is controlled via I2C / SPI?

You mean there is only DSI data and all configuration is done via I2C/SPI,
right? I do not have a real use case so far, but it can be supported in the
same way. Panel driver finds the sibling panel via device tree to get the
peer I2C/SPI first. All commands are send to every bus in panel driver.

>
> >
> > At the DSI host level, the frame width for each link must be that of an
> > individual panel. The driver therefore halves the CRTC's horizontal
> > resolution before configuring the DSI host and any DSC encoders, ensuri=
ng
> > each panel receives the correct half of the framebuffer.
>
> >
> > While the DSI panel driver should manage two panels togehter.
> > 1. During probe, the driver finds the sibling dsi host via device tree
> > phandle and register the 2nd panel to get another mipi_dsi_device.
> > 2. Set dual_panel flag on both mipi_dsi_device.
> > 3. Prepare DSC data per requirement from single panel.
> > 4. All DSI commands should be send on every DSI link.
> > 5. Handle power supply for 2 panels in one shot, the same is true to
> >    brightness.
> > 6. From the CRTC's perspective, the two panels appear as one wide displ=
ay.
> >    The driver exposes a DRM mode where the horizontal timings (hdisplay=
,
> >    hsync_start, etc.) are doubled, while the vertical timings remain th=
ose
> >    of a single panel. Because 2 panels are expected to be mounted in
> >    left/right position.
> >
> > To maintain synchronization, both DSI links are configured to share a
> > single clock source, with the DSI1 controller using the clock provided
> > to DSI0 as below.
> >
> > &mdss_dsi1 {
> >    assigned-clocks =3D <&dispcc DISP_CC_MDSS_BYTE1_CLK_SRC>,
> >                    <&dispcc DISP_CC_MDSS_PCLK1_CLK_SRC>;
> >    assigned-clock-parents =3D <&mdss_dsi0_phy 0>, <&mdss_dsi0_phy 1>;
> > }
> >
> > Signed-off-by: Jun Nie <jun.nie@linaro.org>
> > ---
> >  drivers/gpu/drm/msm/dsi/dsi_host.c | 10 +++++++++-
> >  1 file changed, 9 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/msm/dsi/dsi_host.c b/drivers/gpu/drm/msm/d=
si/dsi_host.c
> > index de51cb02f267205320c5a94fc4188413e05907e6..1fddcea7f86547258be18a5=
1a0a3e3f96f6c3838 100644
> > --- a/drivers/gpu/drm/msm/dsi/dsi_host.c
> > +++ b/drivers/gpu/drm/msm/dsi/dsi_host.c
> > @@ -177,6 +177,7 @@ struct msm_dsi_host {
> >       bool registered;
> >       bool power_on;
> >       bool enabled;
> > +     bool is_dual_panel;
> >       int irq;
> >  };
> >
> > @@ -935,7 +936,10 @@ static void dsi_timing_setup(struct msm_dsi_host *=
msm_host, bool is_bonded_dsi)
> >                       return;
> >               }
> >
> > -             dsc->pic_width =3D mode->hdisplay;
> > +             if (msm_host->is_dual_panel)
> > +                     dsc->pic_width =3D hdisplay;
> > +             else
> > +                     dsc->pic_width =3D mode->hdisplay;
> >               dsc->pic_height =3D mode->vdisplay;
> >               DBG("Mode %dx%d\n", dsc->pic_width, dsc->pic_height);
> >
> > @@ -1609,6 +1613,7 @@ static int dsi_host_attach(struct mipi_dsi_host *=
host,
> >       if (dsi->lanes > msm_host->num_data_lanes)
> >               return -EINVAL;
> >
> > +     msm_host->is_dual_panel =3D dsi->dual_panel;
> >       msm_host->channel =3D dsi->channel;
> >       msm_host->lanes =3D dsi->lanes;
> >       msm_host->format =3D dsi->format;
> > @@ -2492,6 +2497,9 @@ enum drm_mode_status msm_dsi_host_check_dsc(struc=
t mipi_dsi_host *host,
> >       if (!msm_host->dsc)
> >               return MODE_OK;
> >
> > +     if (msm_host->is_dual_panel)
> > +             pic_width =3D mode->hdisplay / 2;
> > +
> >       if (pic_width % dsc->slice_width) {
> >               pr_err("DSI: pic_width %d has to be multiple of slice %d\=
n",
> >                      pic_width, dsc->slice_width);
> >
> > --
> > 2.34.1
> >
>
> --
> With best wishes
> Dmitry

