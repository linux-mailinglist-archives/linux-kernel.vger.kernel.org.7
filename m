Return-Path: <linux-kernel+bounces-815963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A045B56DAA
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 02:52:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF3ED175B24
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 00:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4554B1BD4F7;
	Mon, 15 Sep 2025 00:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cA0AaN9B"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE7252DC783
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 00:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757897565; cv=none; b=RimGcLwdb/OJ8gFMnRM7P89ZXV0vxIUEUm8qOtDK7RmnGctrSy0HgKAvBjTf8SZ5xArdpCbp0/uZB5e4gaW9M/csRbB1JnwyaaUfGmIai3rejDa4yW5NA3yxKDzYDzZyJQM3KoXqGJzngpOyy4yy6qt+6pAgkOH5PgTvCfVEGAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757897565; c=relaxed/simple;
	bh=6EHrV53FNeLkPVh8mg6xrFCbEKRJyfLGxetsjj5P5wQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Em16/ukTix8AC0OGj0A01OsD/YeFKD1Hx8RGdq2jtH23n0wHyUHplczWzUJWhDESGhqXZwRvP0OLUiR5oFBYxk9ZgmgGvSb/fg9aM15SZ/8/PqzXJUM0PY0RGfOW7bLn4nmZ8YShP5eXCAYmGOliTw0ig5A+Je+9nL7z0k8Zy7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cA0AaN9B; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58ELoYRU004264
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 00:52:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=xGD01IAG8EgiNoSNBgigNyCq
	I9uoRjgAYy7dh2aPLpg=; b=cA0AaN9BcqNT4vuekkirm+8JldCOKOonsyr0WXvd
	824h9qQMKE3xROJI5HdgmFWvleZTyjLaH/LNk+WXuQ3N2rICLY5LBouWOruq2lL9
	iPN9ym4R97Nqj5WQzIu2kY9gb5XcsP9NBHLbriZ1/MiHZUYzbIz33nU+BpQDnSu7
	XF53BH2lwNqtTSwhyiTkmNc922PYo8EKAhmhgIanQTl6ORO62R3b7LncLt6VWuuQ
	luDywLsuutsP26H/2n+dYMP2IeNaKbSW7K/jTyhYC8uv8kBft9zte2ofcSZnzfFv
	2ThC6fCUHM/h/AxLXhlH6kuSooeecbFv9/6s89s2qXZ31Q==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 494yxkb1m3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 00:52:42 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4b5eb7b2c05so95800401cf.0
        for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 17:52:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757897562; x=1758502362;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xGD01IAG8EgiNoSNBgigNyCqI9uoRjgAYy7dh2aPLpg=;
        b=L9TJfFd4P8ODplz5OnTU/vv7G34F/3t2ythXaiASqT8SEBrCTlDTYJqvJZv8b0nPZG
         oA/DQ5YzC330zdVatNZM6Z4bX2+eYTpD00Arr0WUd5hHZLBW6odd+24TwA/XGGI1TBx/
         RhwJbub59gX/RCVg+qYKfeeRyYEMZ2kbdf1769xfZNyZDfpEEt2GXv7N2KlbneNyDTcN
         j681+CLFu771E6rW168pywV80ah0xJfdVdUOo7wnuA0N0rksVuXBFGSVZMgk4i9i267E
         GaQhINonG04v7GTW6VTSXCVvEERwzUaWYsm/v7rY9eSeGGc4nz/sOx21zHjbP1vFueA5
         dXzA==
X-Forwarded-Encrypted: i=1; AJvYcCWHW441lN/Pv+IjEPTeZ+GrUWwJfku6cv5YuNpb30a+/3b3Lg5H6K2MScaSU7R4t0mCC83IouuTHZdpQZI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJYsXExiFytLtyLB2289BbLu+dDS/WmKE+p3k8oYtNZHR4txNl
	smszS6NhRdbEYAVRjuw1CdsaC/+nXCHNA6p1izbmVo/U5O9w1oGsMqEzfY5EddH7xW/bj6clrvm
	GGOtHaXlSfgMt3UeqfytauSNGbNNHcUZPQ82MDN/OZG+OivhS+wbgIG+otEZEfZtPzvk=
X-Gm-Gg: ASbGncswVMUygzwO6W8ZRSXZLHzoXZy5U/DFmMZ2xghi2bxflvAiBJN+1VKS25OvwVH
	qWrNfKcps/SJ6f9VQPNfsJ310SClIhpOJWsrfxuWVR5HDxWxgRPsjuafSquTdIiG9vEuMntCfm8
	NkutqRQUGsBiDNRSKqukHP+u/xpj1XwbUqBw3gN296gzdxN+Tp10SYsNsN1ERTDD6kqgXPkT/OO
	02OPtPVvwlDQNQU1esU8BgrV84a4JG0WzfcVxLu2xYe+QkLLQdl/iUQ91wbqn052spEIuZo+yKO
	ugnNdDZYW1GXg2f7okx9HmtVDGHt7XLzAJy5tSlAgiQLO4gMoxGKaxKeKTlfNXEt/J9BPtpbZKb
	uugzY7QQvLeQkr6JwtCv9JPYo2hYJBCGFSWrcIxwXJIylrLO5nNH+
X-Received: by 2002:a05:622a:118b:b0:4b5:f27c:85f7 with SMTP id d75a77b69052e-4b77d1be2ccmr131463581cf.83.1757897561594;
        Sun, 14 Sep 2025 17:52:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFiGMEuGK2fMfFM34phtPtyHS2iG9N9oi8+i6v0OXyNy6+2Ly3OhQQUrROvts0Wj6aG5FZabQ==
X-Received: by 2002:a05:622a:118b:b0:4b5:f27c:85f7 with SMTP id d75a77b69052e-4b77d1be2ccmr131463361cf.83.1757897561109;
        Sun, 14 Sep 2025 17:52:41 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-56e5c3b5fbdsm3179435e87.30.2025.09.14.17.52.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Sep 2025 17:52:39 -0700 (PDT)
Date: Mon, 15 Sep 2025 03:52:37 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Paul Sajna <sajattack@postmarketos.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        David Heidelberg <david@ixit.cz>,
        Amir Dahan <system64fumo@protonmail.com>
Subject: Re: [PATCH 1/3] drm/panel: Add LG SW49410 Panel
Message-ID: <nhmlgiyde2xlevrpsvtjjqmewv3q3ifbyerdzxhdaalv7oysyq@yhlnddkudwwn>
References: <20250910-judyln-panel-v1-0-825c74403bbb@postmarketos.org>
 <20250910-judyln-panel-v1-1-825c74403bbb@postmarketos.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250910-judyln-panel-v1-1-825c74403bbb@postmarketos.org>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEzMDAyMiBTYWx0ZWRfX/VcH3IZc4f2A
 KJIT6AEOeI+/Sg/T1sdmMA//nsOMPOvX6pV9hZWyYoSyJWcX1lFP1NZx00a2iTCnzAnDwKBxrAR
 DC2ZeQbkoIc3rMYy28FMRRCD68ztuh2h8Y8SefTV9PZwGuzqiK+P5qJrE4E0DaKAVAP+xkRdHEt
 bRVX7H8udaiC6SeqLdesMm10Z1YKyE6p3dAl0l5FA1UXLts2YnQnfiiNOpiq3VUdP443DnIUTfc
 hGyGbNC4J10DaiP8oub6eLC+a8VQZI0wJY5lwQzbT6IbVWgpiRcLun5ysSGXyYqT2r75SMFNc9Z
 ql8BIi2AfuNpqRWC43KoPwcN3WlqE0+D0MkmvSWJtQDBvUpTS6EixeZ+huZqDkikiNlr08MgLge
 7CIrYfvz
X-Proofpoint-ORIG-GUID: lB7IdvVu1JfDKYMPxcXmj-LHw87TIN53
X-Authority-Analysis: v=2.4 cv=KfjSsRYD c=1 sm=1 tr=0 ts=68c7635a cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=sfOm8-O8AAAA:8 a=Gbw9aFdXAAAA:8 a=d-sDLFr6_VOwSKI_PXAA:9
 a=CjuIK1q_8ugA:10 a=a_PwQJl-kcHnX1M80qC6:22 a=TvTJqdcANYtsRzA46cdi:22
 a=9vIz8raoGPyDa4jBFAYH:22
X-Proofpoint-GUID: lB7IdvVu1JfDKYMPxcXmj-LHw87TIN53
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-14_08,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 impostorscore=0 priorityscore=1501 suspectscore=0
 adultscore=0 phishscore=0 bulkscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509130022

On Wed, Sep 10, 2025 at 08:08:20PM -0700, Paul Sajna wrote:
> From: Amir Dahan <system64fumo@protonmail.com>
> 
> Added panel driver used by LG G7 ThinQ (judyln)
> 
> Signed-off-by: Amir Dahan <system64fumo@protonmail.com>
> Signed-off-by: Paul Sajna <sajattack@postmarketos.org>
> Co-authored-by: Paul Sajna <sajattack@postmarketos.org>
> ---
>  drivers/gpu/drm/panel/Kconfig            |  14 +
>  drivers/gpu/drm/panel/Makefile           |   1 +
>  drivers/gpu/drm/panel/panel-lg-sw49410.c | 513 +++++++++++++++++++++++++++++++
>  3 files changed, 528 insertions(+)
> 
> diff --git a/drivers/gpu/drm/panel/Kconfig b/drivers/gpu/drm/panel/Kconfig
> index cfebb08e8a62680a14a500d28decfafc2daf743a..48144848c8d3282d231d7495d694381456dde63b 100644
> --- a/drivers/gpu/drm/panel/Kconfig
> +++ b/drivers/gpu/drm/panel/Kconfig
> @@ -406,6 +406,20 @@ config DRM_PANEL_LG_SW43408
>  	  pixel. It provides a MIPI DSI interface to the host and has a
>  	  built-in LED backlight.
>  
> +config DRM_PANEL_LG_SW49410
> +	tristate "LG SW49410 panel"
> +	depends on OF
> +	depends on DRM_MIPI_DSI
> +	depends on BACKLIGHT_CLASS_DEVICE
> +	select DRM_DISPLAY_DSC_HELPER
> +	select DRM_DISPLAY_DP_HELPER

You should not need DP helper for DSI panel

> +	select DRM_DISPLAY_HELPER
> +	help
> +	  Say Y here if you want to enable support for LG sw49410 panel.
> +	  The panel has a 1440x3120@60Hz resolution and uses 24 bit RGB per
> +	  pixel. It provides a MIPI DSI interface to the host and has a
> +	  built-in LED backlight.
> +
>  config DRM_PANEL_MAGNACHIP_D53E6EA8966
>  	tristate "Magnachip D53E6EA8966 DSI panel"
>  	depends on OF && SPI
> diff --git a/drivers/gpu/drm/panel/Makefile b/drivers/gpu/drm/panel/Makefile
> index 714cbac830e3f0be3659f1907c5dbacef863bbd8..f7f6d232ad9c7163f328d94f4461fcb3379f998b 100644
> --- a/drivers/gpu/drm/panel/Makefile
> +++ b/drivers/gpu/drm/panel/Makefile
> @@ -41,6 +41,7 @@ obj-$(CONFIG_DRM_PANEL_LINCOLNTECH_LCD197) += panel-lincolntech-lcd197.o
>  obj-$(CONFIG_DRM_PANEL_LG_LB035Q02) += panel-lg-lb035q02.o
>  obj-$(CONFIG_DRM_PANEL_LG_LG4573) += panel-lg-lg4573.o
>  obj-$(CONFIG_DRM_PANEL_LG_SW43408) += panel-lg-sw43408.o
> +obj-$(CONFIG_DRM_PANEL_LG_SW49410) += panel-lg-sw49410.o
>  obj-$(CONFIG_DRM_PANEL_MAGNACHIP_D53E6EA8966) += panel-magnachip-d53e6ea8966.o
>  obj-$(CONFIG_DRM_PANEL_NEC_NL8048HL11) += panel-nec-nl8048hl11.o
>  obj-$(CONFIG_DRM_PANEL_NEWVISION_NV3051D) += panel-newvision-nv3051d.o
> diff --git a/drivers/gpu/drm/panel/panel-lg-sw49410.c b/drivers/gpu/drm/panel/panel-lg-sw49410.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..1243577f9280ecf3e906d2ad001c6c313b3af495
> --- /dev/null
> +++ b/drivers/gpu/drm/panel/panel-lg-sw49410.c
> @@ -0,0 +1,513 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +// Generated with linux-mdss-dsi-panel-driver-generator from vendor device tree:
> +// Copyright (c) 2025, The Linux Foundation. All rights reserved.
> +
> +#include <linux/backlight.h>
> +#include <linux/delay.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/regulator/consumer.h>
> +
> +#include <video/mipi_display.h>
> +
> +#include <drm/drm_mipi_dsi.h>
> +#include <drm/drm_panel.h>
> +#include <drm/drm_probe_helper.h>
> +#include <drm/display/drm_dsc.h>
> +#include <drm/display/drm_dsc_helper.h>
> +
> +struct sw49410_panel {
> +	struct drm_panel panel;
> +	struct mipi_dsi_device *dsi;
> +	struct drm_dsc_config dsc;
> +	struct gpio_desc *reset_gpio;
> +};
> +
> +static inline
> +struct sw49410_panel *to_sw49410_panel(struct drm_panel *panel)
> +{
> +	return container_of(panel, struct sw49410_panel, panel);
> +}
> +
> +static void sw49410_panel_reset(struct sw49410_panel *ctx)
> +{
> +	gpiod_set_value_cansleep(ctx->reset_gpio, 0);
> +	usleep_range(10000, 11000);
> +	gpiod_set_value_cansleep(ctx->reset_gpio, 1);
> +	usleep_range(10000, 11000);
> +	gpiod_set_value_cansleep(ctx->reset_gpio, 0);
> +	usleep_range(10000, 11000);
> +}
> +
> +static int sw49410_panel_on(struct sw49410_panel *ctx)
> +{
> +	struct mipi_dsi_multi_context dsi_ctx = { .dsi = ctx->dsi };
> +
> +	ctx->dsi->mode_flags |= MIPI_DSI_MODE_LPM;
> +
> +	mipi_dsi_dcs_set_tear_on_multi(&dsi_ctx, MIPI_DSI_DCS_TEAR_MODE_VBLANK);
> +	mipi_dsi_dcs_set_page_address(ctx->dsi, 0x0000, 0x0c2f);

Please rewrite this function to only use _multi() functions. Don't use
functions that take mipi_dsi_device directly. If anything is missing,
please add new wrappers.

> +	mipi_dsi_dcs_set_display_brightness(ctx->dsi, 0x00ff);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, MIPI_DCS_WRITE_CONTROL_DISPLAY,
> +				     0x2c);

[..]

> +
> +static int sw49410_panel_prepare(struct drm_panel *panel)
> +{
> +	struct sw49410_panel *ctx = to_sw49410_panel(panel);
> +	struct device *dev = &ctx->dsi->dev;
> +	struct drm_dsc_picture_parameter_set pps;
> +	int ret;
> +
> +	sw49410_panel_reset(ctx);
> +
> +	ret = sw49410_panel_on(ctx);
> +	if (ret < 0) {
> +		dev_err(dev, "Failed to initialize panel: %d\n", ret);
> +		gpiod_set_value_cansleep(ctx->reset_gpio, 1);
> +		return ret;
> +	}
> +
> +	drm_dsc_pps_payload_pack(&pps, &ctx->dsc);
> +
> +	ret = mipi_dsi_picture_parameter_set(ctx->dsi, &pps);

mipi_dsi_picture_parameter_set_multi(), move this call and the next ones
to sw49410_panel_on().

> +	if (ret < 0) {
> +		dev_err(panel->dev, "failed to transmit PPS: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = mipi_dsi_compression_mode(ctx->dsi, true);

mipi_dsi_compression_mode_multi

> +	if (ret < 0) {
> +		dev_err(dev, "failed to enable compression mode: %d\n", ret);
> +		return ret;
> +	}
> +
> +	msleep(28);

mipi_dsi_msleep

> +
> +	return 0;
> +}
> +

-- 
With best wishes
Dmitry

