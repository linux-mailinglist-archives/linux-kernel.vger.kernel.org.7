Return-Path: <linux-kernel+bounces-895246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 004D2C4D582
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 12:13:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6A043A58ED
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 11:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12D37350A27;
	Tue, 11 Nov 2025 11:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UlPAFqnu";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="g3uHX8Li"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A67F2EAB61
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 11:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762859256; cv=none; b=iiLKiByOQVG+NnhqH/5iEOJZYCm7l1NUJ6T3JvSQxQeULNsVufX35NYR/MZisytBbagIo4Xp6kjKAAuWseY4cEhhl5PgLY8wafIFe76OHhtQXvjHD8Aslhl5tNj3hmWgvwDxSuz8z2V6wpeyWQKpuDsvjE4+3j6N9V2WVYPoLvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762859256; c=relaxed/simple;
	bh=UNMMxH8ng+KSo3urT9RPRvMUXS1SWFxwgVciP+1lrG8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EP/4XkZk/8unPaZHYKIcMHCTpuKxPRDwuc5mx5X1mWESWBgKvQdr0FzqwXZm0K28/5/VEP/hW6/ecHlcFHj34H5fSQRM+begep4yMB/v1AyrYUxnjp2BcKD2em+scgO28TMMu+NaR8wo6j2ANyxKfLJH8jGVaTzT028ZJI5dypU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UlPAFqnu; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=g3uHX8Li; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AB7E5LZ211093
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 11:07:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=0GL6AX4f5B9v3LxUu9tCxDTR
	Pg4Nz4OvpM8/ZiJ/lrY=; b=UlPAFqnulsjL+DwWS1zu3xe0s9DCw1MO29glbnsn
	yD0AegAg+J/6OTRR/XiC3QLJXrF0JcGTHmsS7rbg/nXCYp8Kdw2RsCvDdIWPIMjH
	XkuLaKnT/puCnnQghjV0rogyGH7Up6ifp9033bCvleniOn/ida+HKGc8bGENNMQj
	2JlEJT1xvdHTdL1Il+jhiQiWxha8iZJgLep4ziQ89zDuA1DO+2HsAMJfrmsaeE+h
	/VyWsCA2b8RPkzpru6yHsTvP9hJ3/oSeoO5DtkrAOgimkIi9uqwQFkE3pDQgfYgX
	/z/zmmPtlYcDLmT9gvu0txkPzM83Ty1WpMQN5vRaPrYUqg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4abpy8j5wh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 11:07:33 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4e8b33c1d8eso115231231cf.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 03:07:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762859252; x=1763464052; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0GL6AX4f5B9v3LxUu9tCxDTRPg4Nz4OvpM8/ZiJ/lrY=;
        b=g3uHX8LiYYLYM6rgBiNzBIOeE29nmfNqLl3OKtYoRsQvfOfJvg7gvPtOcygtGaN6w0
         PLPG8eN3DMdAJ1jhqBQz7MIlH82JgJvj9H71hHRGHiX1cBj9BiO3PO1aFDM3D/NR/ID7
         qVW0VtB21pjgJwZqptU9Hrdb9ALE56RWcHsE9+xOcZEHyzQfig1gfqey7Fg0b8UCGhBr
         4s5/tVSdHP36i0VZp8BsCW5rdP60ACNewS9gAdDS/h0q4l+aiJhcKWN51uLTwB+8OAu0
         3/P4awlW6XE3yBJ+SBRK1a5BMej+0OdhVrtLSi2WRfxOmRQZZzAT+IAuf9jWqK39SCip
         ettg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762859252; x=1763464052;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0GL6AX4f5B9v3LxUu9tCxDTRPg4Nz4OvpM8/ZiJ/lrY=;
        b=hEsZhaU5c7Gipv30U7vB2VCCA+nZ3lVweoqU5OgzQU4GngoPv7czPUBsXDqk0sVTXC
         OA/S7zSsJU/vev2cmH2hMQYtWXt86FUoq/nQQ5qYZnHGw+Y+gRFBMGMyeAmWsdhfaxE4
         WU7Ro8xMDf+Ot4tUmdTHImEtm7a8d+0p0/ikAtdCqRD7nb7k/NromI8vr5QO5CwaK5YZ
         u/T7xjZFj8SnyrUxChmmOOEKpRDIVejQYE+GpN8LAPfbADwPbdtTw3FEkoDWaempfbzW
         1/MPapine17SHmu10ie0uQYgNlD2s7vMPCtnsK6uMLqQHNfAvKRmKpeObIfxYSl5bkWB
         KHtg==
X-Forwarded-Encrypted: i=1; AJvYcCU/+KqOiA2m5YAPdEEmrLjd2gVDE+tgEQ1LOVQIZcCIXk5XNig0zLI+CAp1zZIwhs8yKSunbcxuhT8ngYs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfppHXkxExEXeq9gz+pnezFgbJD/EB8anRtb/lGJd0s1ViSu5V
	j6u82GawwCXvQp2SArIxEnlsxqJORmS8PJTD091iJfIz37CadFTFT7quTE1TycwKDTogzV3Q1Lk
	PGSZXzGgXYOBKI2vO19qhOrbW+F8m0SFETwDn689rPpFXCtUhcNZo01hTR3d040Nns+o=
X-Gm-Gg: ASbGncupU7N6MNAzEohfqS8x7UMufOxUzaqnEDXEus4uazC7iSPwJI62XeoY6lLyqdm
	Ob9HGCd1yUvzxJswHRSzfZpfu0xGmBeXQgBfBinUJQ2GW/V2G24Eqt4WERm78lKyW3ER8o4ySYt
	3G+iLNganRoxu2IAocgZ3ljdnjocRPlxBBydLuROogFf0X5+nTBTmAYXpKeat0hwZlNF9lZcV4n
	WHbyvIacX73547lN/vosfwutooZ9y92wXscwupRnfC8r3xL7XC3k9AiKxJxsQRCy/SDbLaEHXU7
	ERaJXia5+neVXhvTdoJImqRELzO1mcSgYNFA2wIEQuE0aIW8/ggsXXUBEqKPfN833GRHH7nJyYv
	MVgIQmHcTL2JFGZJf8JfiAfIpYT73jrQ6TccipZYADF93Dm4p0t/5S9d8yw3GpYZc4jndRo7SER
	TAzVTFiOY1yBHb
X-Received: by 2002:ac8:7d0a:0:b0:4b5:f7d4:39fa with SMTP id d75a77b69052e-4eda4e7ac76mr154971011cf.12.1762859251969;
        Tue, 11 Nov 2025 03:07:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGOyvBNAS3QLH6jY8Fp3DqOwKCqP04zJqQg9X/UOenGRTF/Rnu3xscXAQAT73TcBrpZ7gagDw==
X-Received: by 2002:ac8:7d0a:0:b0:4b5:f7d4:39fa with SMTP id d75a77b69052e-4eda4e7ac76mr154970351cf.12.1762859251305;
        Tue, 11 Nov 2025 03:07:31 -0800 (PST)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-37a5f0ee523sm41794201fa.42.2025.11.11.03.07.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 03:07:30 -0800 (PST)
Date: Tue, 11 Nov 2025 13:07:28 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Sudarshan Shetty <tessolveupstream@gmail.com>
Cc: neil.armstrong@linaro.org, jessica.zhang@oss.qualcomm.com,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] drm: panel: Add Waveshare MIPI-DSI panel driver
Message-ID: <tggz6tsbzsydhi7hmwpacqea7o2nzstm4ta3cye5nbse2dh32y@lxlqnyyfhmfc>
References: <20251111104309.3424018-1-tessolveupstream@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251111104309.3424018-1-tessolveupstream@gmail.com>
X-Proofpoint-ORIG-GUID: ozol5Mxqb5taimjoGxtACECTW52KSHAe
X-Authority-Analysis: v=2.4 cv=AYW83nXG c=1 sm=1 tr=0 ts=691318f5 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=pGLkceISAAAA:8 a=V4Th9uXqAAAA:8 a=LbDzrTjz2W1hcEXESF0A:9 a=CjuIK1q_8ugA:10
 a=dawVfQjAaf238kedN5IG:22 a=NPz-sUGDo_RSEfLfxCKS:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTExMDA4NyBTYWx0ZWRfX+hQWqNB5zRDk
 jen4hteBIH8JR7KNOXWf+p/IBjAp7OvCmK51O91LH0B/9XVy5z1tbl9hWlTB6c50+f3L+M6B+HG
 uGi5xZNWyBmTkFuYe2rWdtLGo6TdGWOVOvL5HMT2NtouKQs6GQ0oa723OV6ok+meeZf9uIw32mS
 P7SlgyPRb+NUN21vFwTlAAWvxJAMEPVEGecFHNyZvUCYo+QMQClLu4TttikVFk+sWDjs3qtI4i0
 EpgLPl/NNtoKlUnIvxMcjsokOlyoPFzXwNJ/NyVVw3p4zMCLi/vaZmsH+cTKvibAaF9GHQBJreK
 w/p7OwcuG5tuopMcaEjX4SbZnnGdUZ13nhj0GylR3CKo0NI+P/o7nWgzM5p0Tf3/SKJxjy3GeZ+
 cEXhKovlod+hY1ZbJNxOOSHx7bB+Xg==
X-Proofpoint-GUID: ozol5Mxqb5taimjoGxtACECTW52KSHAe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-11_02,2025-11-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 malwarescore=0 adultscore=0 clxscore=1015
 suspectscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511110087

On Tue, Nov 11, 2025 at 04:13:09PM +0530, Sudarshan Shetty wrote:
> This patch adds a DRM panel driver for Waveshare MIPI-DSI panels
> of various sizes (5.0", 5.5", 7.0", 8.0", and 10.1") with integrated
> touch functionality.
> 
> The driver provides:
>  - Initialization and reset sequencing
>  - MIPI-DSI command transfer for panel setup
>  - Backlight integration through the backlight class device
>  - Support for multiple panel variants via compatible strings
> 
> These panels are commonly used with Waveshare development kits
> and require proper power sequencing and regulator support.
> 
> Signed-off-by: Sudarshan Shetty <tessolveupstream@gmail.com>
> ---
>  arch/arm64/configs/defconfig                  |    1 +
>  drivers/gpu/drm/panel/Kconfig                 |   11 +
>  drivers/gpu/drm/panel/Makefile                |    1 +
>  .../gpu/drm/panel/panel-waveshare-dsi-v2.c    | 2687 +++++++++++++++++


This was sent to the internal ML, got negative feedback and still
reached the public ML. May I ask, WHY?


Anyway, you missed the bindings for the driver.

>  4 files changed, 2700 insertions(+)
>  create mode 100644 drivers/gpu/drm/panel/panel-waveshare-dsi-v2.c
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index a1e564024be2..178c8699f86c 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -1823,4 +1823,5 @@ CONFIG_CORESIGHT_STM=m
>  CONFIG_CORESIGHT_CPU_DEBUG=m
>  CONFIG_CORESIGHT_CTI=m
>  CONFIG_MEMTEST=y
> +CONFIG_DRM_PANEL_WAVESHARE_TOUCHSCREEN_V2=y
>  CONFIG_REGULATOR_WAVESHARE_TOUCHSCREEN=y

Separate commit, the entry is out of place there is no reason to build
the driver into the kernel, etc.

> diff --git a/drivers/gpu/drm/panel/Kconfig b/drivers/gpu/drm/panel/Kconfig
> index 407c5f6a268b..b771817af8f8 100644
> --- a/drivers/gpu/drm/panel/Kconfig
> +++ b/drivers/gpu/drm/panel/Kconfig
> @@ -1137,6 +1137,17 @@ config DRM_PANEL_VISIONOX_VTDR6130
>  	  Say Y here if you want to enable support for Visionox
>  	  VTDR6130 1080x2400 AMOLED DSI panel.
>  
> +config DRM_PANEL_WAVESHARE_TOUCHSCREEN_V2
> +	tristate "Waveshare touchscreen panels V2"
> +	depends on DRM_MIPI_DSI
> +	depends on I2C
> +	depends on BACKLIGHT_CLASS_DEVICE
> +	help
> +	  Enable support for Waveshare DSI touchscreen panels,
> +	  Say Y here if you want to enable support for the Waveshare
> +	  DSI Touchscreens.  To compile this driver as a module,
> +	  choose M here.
> +
>  config DRM_PANEL_WIDECHIPS_WS2401
>  	tristate "Widechips WS2401 DPI panel driver"
>  	depends on SPI && GPIOLIB
> diff --git a/drivers/gpu/drm/panel/Makefile b/drivers/gpu/drm/panel/Makefile
> index 3615a761b44f..3947e28addde 100644
> --- a/drivers/gpu/drm/panel/Makefile
> +++ b/drivers/gpu/drm/panel/Makefile
> @@ -114,5 +114,6 @@ obj-$(CONFIG_DRM_PANEL_VISIONOX_RM69299) += panel-visionox-rm69299.o
>  obj-$(CONFIG_DRM_PANEL_VISIONOX_RM692E5) += panel-visionox-rm692e5.o
>  obj-$(CONFIG_DRM_PANEL_VISIONOX_VTDR6130) += panel-visionox-vtdr6130.o
>  obj-$(CONFIG_DRM_PANEL_VISIONOX_R66451) += panel-visionox-r66451.o
> +obj-$(CONFIG_DRM_PANEL_WAVESHARE_TOUCHSCREEN_V2) += panel-waveshare-dsi-v2.o
>  obj-$(CONFIG_DRM_PANEL_WIDECHIPS_WS2401) += panel-widechips-ws2401.o
>  obj-$(CONFIG_DRM_PANEL_XINPENG_XPP055C272) += panel-xinpeng-xpp055c272.o
> diff --git a/drivers/gpu/drm/panel/panel-waveshare-dsi-v2.c b/drivers/gpu/drm/panel/panel-waveshare-dsi-v2.c
> new file mode 100644
> index 000000000000..7af11fdc026f
> --- /dev/null
> +++ b/drivers/gpu/drm/panel/panel-waveshare-dsi-v2.c
> @@ -0,0 +1,2687 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2024 Waveshare International Limited
> + *
> + * Based on panel-raspberrypi-touchscreen by Broadcom
> + */
> +
> +#include <linux/delay.h>
> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/errno.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +
> +#include <linux/gpio/consumer.h>
> +#include <linux/regulator/consumer.h>
> +
> +#include <drm/drm_mipi_dsi.h>
> +#include <drm/drm_modes.h>
> +#include <drm/drm_panel.h>
> +
> +#include <video/mipi_display.h>
> +
> +struct ws_panel_desc {
> +	int (*init)(struct mipi_dsi_device *dsi);
> +	const struct drm_display_mode *mode;
> +	const unsigned long mode_flags;
> +	unsigned int lanes;
> +	enum mipi_dsi_pixel_format format;
> +};
> +
> +struct ws_panel {
> +	struct drm_panel panel;
> +	struct mipi_dsi_device *dsi;
> +	const struct ws_panel_desc *desc;
> +
> +	struct regulator *power;
> +	struct gpio_desc *reset;
> +	struct gpio_desc *iovcc;
> +	struct gpio_desc *avdd;

Don't use GPIOs for regulators. Use proper regulator framework devices.

> +
> +	enum drm_panel_orientation orientation;
> +};
> +
> +enum dsi_cmd_type {
> +	INIT_DCS_CMD,
> +	DELAY_CMD,
> +};

Unused

> +
> +struct panel_init_cmd {
> +	enum dsi_cmd_type type;
> +	size_t len;
> +	const char *data;
> +};

Unused

> +
> +static int ws_panel_12_3_a_4lane_init(struct mipi_dsi_device *dsi)
> +{
> +	struct mipi_dsi_multi_context ctx = { .dsi = dsi };
> +
> +	mipi_dsi_dcs_write_seq_multi(&ctx, 0xB9, 0x83, 0x10, 0x2E);

- Please don't group panels by vendor. Panel drivers are grouped by the
  controlling IC. In this driver you've tried to stuff together several
  panels with different controllers. Instead add these to the drivers
  with the corresponding controllers. Feel free to rework existing
  drivers in order to be able to do it.

- Also, lowercase the hex.

> +	mipi_dsi_dcs_write_seq_multi(&ctx, 0xBD, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(&ctx, 0x11);

exit_sleep_mode

> +	msleep(120);

Use a proper wrapper

> +	mipi_dsi_dcs_write_seq_multi(&ctx, 0x29);

set_display_on

> +	msleep(20);
> +
> +	return 0;

Return error code.

> +};
> +
> +static int ws_panel_10_1_a_4lane_init(struct mipi_dsi_device *dsi)
> +{
> +	struct mipi_dsi_multi_context ctx = { .dsi = dsi };
> +
> +	mipi_dsi_dcs_write_seq_multi(&ctx, 0xE0, 0x00);

As you can see, it's a completely different init sequence.

> +
> +static int ws_panel_prepare(struct drm_panel *panel)
> +{
> +	struct ws_panel *ctx = panel_to_ws(panel);
> +	int ret;
> +
> +	if (ctx->iovcc) {
> +		gpiod_set_value_cansleep(ctx->iovcc, 1);
> +		msleep(20);
> +	}
> +
> +	if (ctx->avdd) {
> +		gpiod_set_value_cansleep(ctx->avdd, 1);
> +		msleep(20);
> +	}

Yuck

> +
> +	if (ctx->reset) {
> +		gpiod_set_value_cansleep(ctx->reset, 0);
> +		msleep(60);
> +		gpiod_set_value_cansleep(ctx->reset, 1);
> +		msleep(60);
> +	}
> +
> +	ret = ctx->desc->init(ctx->dsi);
> +	if (ret < 0)
> +		dev_err(panel->dev, "failed to init panel: %d\n", ret);
> +
> +	return 0;
> +}
> +
> +static int ws_panel_unprepare(struct drm_panel *panel)
> +{
> +	struct ws_panel *ctx = panel_to_ws(panel);
> +
> +	mipi_dsi_dcs_set_display_off(ctx->dsi);
> +	mipi_dsi_dcs_enter_sleep_mode(ctx->dsi);
> +
> +	if (ctx->reset) {
> +		gpiod_set_value_cansleep(ctx->reset, 0);
> +		msleep(5);
> +	}
> +
> +	if (ctx->avdd) {
> +		gpiod_set_value_cansleep(ctx->avdd, 0);
> +		msleep(5);
> +	}
> +
> +	if (ctx->iovcc) {
> +		gpiod_set_value_cansleep(ctx->iovcc, 0);
> +		msleep(5);
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct drm_display_mode ws_panel_12_3_a_4lane_mode = {
> +	.clock = 95000,

My preference is to define mode.clock clearly as (720 + 10 + 10 + 12)
* (1920 + 64 + 18 + 4) * 63 / 1000 (why 63 though?)

> +	.hdisplay = 720,
> +	.hsync_start = 720 + 10,
> +	.hsync_end = 720 + 10 + 10,
> +	.htotal = 720 + 10 + 10 + 12,
> +	.vdisplay = 1920,
> +	.vsync_start = 1920 + 64,
> +	.vsync_end = 1920 + 64 + 18,
> +	.vtotal = 1920 + 64 + 18 + 4,
> +	.width_mm = 109,
> +	.height_mm = 292,
> +};
> +
> +static const struct drm_display_mode ws_panel_10_1_a_mode = {
> +	.clock = 70000,
> +	.hdisplay = 800,
> +	.hsync_start = 800 + 40,
> +	.hsync_end = 800 + 40 + 20,
> +	.htotal = 800 + 40 + 20 + 20,
> +	.vdisplay = 1280,
> +	.vsync_start = 1280 + 20,
> +	.vsync_end = 1280 + 20 + 20,
> +	.vtotal = 1280 + 20 + 20 + 4,
> +	.width_mm = 135,
> +	.height_mm = 216,
> +};
> +
> +static const struct drm_display_mode ws_panel_10_1_b_4lane_mode = {
> +	.clock = 66000,
> +	.hdisplay = 720,
> +	.hsync_start = 720 + 60,
> +	.hsync_end = 720 + 60 + 60,
> +	.htotal = 720 + 60 + 60 + 4,
> +	.vdisplay = 1280,
> +	.vsync_start = 1280 + 16,
> +	.vsync_end = 1280 + 16 + 12,
> +	.vtotal = 1280 + 16 + 12 + 4,
> +	.width_mm = 125,
> +	.height_mm = 222,
> +};
> +
> +static const struct drm_display_mode ws_panel_10_1_b_mode = {
> +	.clock = 69000,
> +	.hdisplay = 720,
> +	.hsync_start = 720 + 50,
> +	.hsync_end = 720 + 50 + 50,
> +	.htotal = 720 + 50 + 50 + 50,
> +	.vdisplay = 1280,
> +	.vsync_start = 1280 + 26,
> +	.vsync_end = 1280 + 26 + 12,
> +	.vtotal = 1280 + 26 + 12 + 4,
> +	.width_mm = 125,
> +	.height_mm = 222,
> +};
> +
> +static const struct drm_display_mode ws_panel_9_b_4lane_mode = {
> +	.clock = 66000,
> +	.hdisplay = 720,
> +	.hsync_start = 720 + 60,
> +	.hsync_end = 720 + 60 + 60,
> +	.htotal = 720 + 60 + 60 + 4,
> +	.vdisplay = 1280,
> +	.vsync_start = 1280 + 16,
> +	.vsync_end = 1280 + 16 + 12,
> +	.vtotal = 1280 + 16 + 12 + 4,
> +	.width_mm = 114,
> +	.height_mm = 196,
> +};
> +
> +static const struct drm_display_mode ws_panel_9_b_mode = {
> +	.clock = 69000,
> +	.hdisplay = 720,
> +	.hsync_start = 720 + 50,
> +	.hsync_end = 720 + 50 + 50,
> +	.htotal = 720 + 50 + 50 + 50,
> +	.vdisplay = 1280,
> +	.vsync_start = 1280 + 26,
> +	.vsync_end = 1280 + 26 + 12,
> +	.vtotal = 1280 + 26 + 12 + 4,
> +	.width_mm = 114,
> +	.height_mm = 196,
> +};
> +
> +static const struct drm_display_mode ws_panel_8_8_a_mode = {
> +	.clock = 75000,
> +	.hdisplay = 480,
> +	.hsync_start = 480 + 50,
> +	.hsync_end = 480 + 50 + 50,
> +	.htotal = 480 + 50 + 50 + 50,
> +	.vdisplay = 1920,
> +	.vsync_start = 1920 + 20,
> +	.vsync_end = 1920 + 20 + 20,
> +	.vtotal = 1920 + 20 + 20 + 20,
> +	.width_mm = 68,
> +	.height_mm = 219,
> +};
> +
> +static const struct drm_display_mode ws_panel_8_a_mode = {
> +	.clock = 70000,
> +	.hdisplay = 800,
> +	.hsync_start = 800 + 40,
> +	.hsync_end = 800 + 40 + 20,
> +	.htotal = 800 + 40 + 20 + 20,
> +	.vdisplay = 1280,
> +	.vsync_start = 1280 + 30,
> +	.vsync_end = 1280 + 30 + 12,
> +	.vtotal = 1280 + 30 + 12 + 4,
> +	.width_mm = 107,
> +	.height_mm = 172,
> +};
> +
> +static const struct drm_display_mode ws_panel_7_a_mode = {
> +	.clock = 83333,
> +	.hdisplay = 720,
> +	.hsync_start = 720 + 120,
> +	.hsync_end = 720 + 120 + 100,
> +	.htotal = 720 + 120 + 100 + 100,
> +	.vdisplay = 1280,
> +	.vsync_start = 1280 + 10,
> +	.vsync_end = 1280 + 10 + 10,
> +	.vtotal = 1280 + 10 + 10 + 10,
> +	.width_mm = 85,
> +	.height_mm = 154,
> +};
> +
> +static const struct drm_display_mode ws_panel_5_5_a_mode = {
> +	.clock = 65000,
> +	.hdisplay = 720,
> +	.hsync_start = 720 + 50,
> +	.hsync_end = 720 + 50 + 50,
> +	.htotal = 720 + 50 + 50 + 10,
> +	.vdisplay = 1280,
> +	.vsync_start = 1280 + 15,
> +	.vsync_end = 1280 + 15 + 12,
> +	.vtotal = 1280 + 15 + 12 + 4,
> +	.width_mm = 62,
> +	.height_mm = 110,
> +};
> +
> +static const struct drm_display_mode ws_panel_5_a_mode = {
> +	.clock = 70000,
> +	.hdisplay = 720,
> +	.hsync_start = 720 + 40,
> +	.hsync_end = 720 + 40 + 20,
> +	.htotal = 720 + 40 + 20 + 20,
> +	.vdisplay = 1280,
> +	.vsync_start = 1280 + 30,
> +	.vsync_end = 1280 + 30 + 10,
> +	.vtotal = 1280 + 30 + 10 + 4,
> +	.width_mm = 62,
> +	.height_mm = 110,
> +};
> +
> +static const struct drm_display_mode ws_panel_4_c_mode = {
> +	.clock       = 36500,
> +	.hdisplay    = 720,
> +	.hsync_start = 720 + 40,
> +	.hsync_end   = 720 + 40 + 20,
> +	.htotal      = 720 + 40 + 20 + 20,
> +	.vdisplay    = 720,
> +	.vsync_start = 720 + 24,
> +	.vsync_end   = 720 + 24 + 4,
> +	.vtotal      = 720 + 24 + 4 + 12,
> +	.width_mm	 = 88,
> +	.height_mm	 = 88,
> +};
> +
> +static const struct drm_display_mode ws_panel_3_4_c_mode = {
> +	.clock       = 44300,
> +	.hdisplay    = 800,
> +	.hsync_start = 800 + 40,
> +	.hsync_end   = 800 + 40 + 20,
> +	.htotal      = 800 + 40 + 20 + 20,
> +	.vdisplay    = 800,
> +	.vsync_start = 800 + 24,
> +	.vsync_end   = 800 + 24 + 4,
> +	.vtotal      = 800 + 24 + 4 + 12,
> +	.width_mm	 = 88,
> +	.height_mm	 = 88,
> +};
> +
> +static int ws_panel_get_modes(struct drm_panel *panel,
> +			      struct drm_connector *connector)
> +{
> +	struct ws_panel *ctx = panel_to_ws(panel);
> +	struct drm_display_mode *mode;
> +
> +	mode = drm_mode_duplicate(connector->dev, ctx->desc->mode);
> +	if (!mode) {
> +		dev_err(&ctx->dsi->dev, "failed to add mode %ux%ux@%u\n",
> +			ctx->desc->mode->hdisplay, ctx->desc->mode->vdisplay,
> +			drm_mode_vrefresh(ctx->desc->mode));
> +		return -ENOMEM;
> +	}
> +
> +	drm_mode_set_name(mode);
> +
> +	mode->type = DRM_MODE_TYPE_DRIVER | DRM_MODE_TYPE_PREFERRED;
> +	drm_mode_probed_add(connector, mode);
> +
> +	connector->display_info.width_mm = mode->width_mm;
> +	connector->display_info.height_mm = mode->height_mm;

drm_connector_helper_get_modes_fixed()

> +
> +	drm_connector_set_panel_orientation(connector, ctx->orientation);
> +
> +	return 1;
> +}
> +
> +static enum drm_panel_orientation
> +ws_panel_get_orientation(struct drm_panel *panel)
> +{
> +	struct ws_panel *ctx = panel_to_ws(panel);
> +
> +	return ctx->orientation;
> +}
> +
> +static const struct drm_panel_funcs ws_panel_funcs = {
> +	.prepare = ws_panel_prepare,
> +	.unprepare = ws_panel_unprepare,
> +	.get_modes = ws_panel_get_modes,
> +	.get_orientation = ws_panel_get_orientation,
> +};
> +
> +static int ws_panel_dsi_probe(struct mipi_dsi_device *dsi)
> +{
> +	struct ws_panel *ctx;
> +	int ret;
> +
> +	dev_info(&dsi->dev, "dsi panel: %s\n",
> +		 (char *)of_get_property(
> +			 dsi->dev.of_node, "compatible", NULL));
> +
> +	ctx = devm_kzalloc(&dsi->dev, sizeof(*ctx), GFP_KERNEL);
> +	if (!ctx)
> +		return -ENOMEM;
> +	mipi_dsi_set_drvdata(dsi, ctx);
> +	ctx->dsi = dsi;
> +	ctx->desc = of_device_get_match_data(&dsi->dev);
> +
> +	ctx->panel.prepare_prev_first = true;
> +	drm_panel_init(&ctx->panel, &dsi->dev, &ws_panel_funcs,
> +		       DRM_MODE_CONNECTOR_DSI);
> +
> +	ctx->reset = devm_gpiod_get_optional(
> +			&dsi->dev, "reset", GPIOD_OUT_LOW);
> +	if (IS_ERR(ctx->reset))
> +		return dev_err_probe(&dsi->dev, PTR_ERR(ctx->reset),
> +				     "Couldn't get our reset GPIO\n");
> +
> +	ctx->iovcc = devm_gpiod_get_optional(
> +			&dsi->dev, "iovcc", GPIOD_OUT_LOW);
> +	if (IS_ERR(ctx->iovcc))
> +		return dev_err_probe(&dsi->dev, PTR_ERR(ctx->iovcc),
> +					"Couldn't get our iovcc GPIO\n");
> +
> +	ctx->avdd = devm_gpiod_get_optional(&dsi->dev, "avdd", GPIOD_OUT_LOW);
> +	if (IS_ERR(ctx->avdd))
> +		return dev_err_probe(&dsi->dev, PTR_ERR(ctx->avdd),
> +					"Couldn't get our avdd GPIO\n");
> +
> +	ret = of_drm_get_panel_orientation(
> +			dsi->dev.of_node, &ctx->orientation);
> +	if (ret) {
> +		dev_err(&dsi->dev, "%pOF: failed to get orientation: %d\n",
> +			dsi->dev.of_node, ret);
> +		return ret;
> +	}
> +
> +	ret = drm_panel_of_backlight(&ctx->panel);
> +	if (ret)
> +		return ret;
> +
> +	drm_panel_add(&ctx->panel);
> +
> +	dsi->mode_flags = ctx->desc->mode_flags;
> +	dsi->format = ctx->desc->format;
> +	dsi->lanes = ctx->desc->lanes;
> +	dev_info(&dsi->dev, "lanes: %d\n", dsi->lanes);
> +
> +	ret = mipi_dsi_attach(dsi);
> +	if (ret)
> +		drm_panel_remove(&ctx->panel);
> +
> +	return ret;
> +}
> +
> +static void ws_panel_dsi_remove(struct mipi_dsi_device *dsi)
> +{
> +	struct ws_panel *ctx = mipi_dsi_get_drvdata(dsi);
> +
> +	mipi_dsi_detach(dsi);
> +	drm_panel_remove(&ctx->panel);
> +	if (ctx->reset) {
> +		gpiod_set_value_cansleep(ctx->reset, 0);
> +		msleep(5);
> +	}
> +
> +	if (ctx->avdd) {
> +		gpiod_set_value_cansleep(ctx->avdd, 0);
> +		msleep(5);
> +	}
> +
> +	if (ctx->iovcc) {
> +		gpiod_set_value_cansleep(ctx->iovcc, 0);
> +		msleep(5);
> +	}
> +}
> +
> +static void ws_panel_dsi_shutdown(struct mipi_dsi_device *dsi)
> +{
> +	struct ws_panel *ctx = mipi_dsi_get_drvdata(dsi);
> +
> +	if (ctx->reset) {
> +		dev_info(&dsi->dev, "shutdown\n");
> +		gpiod_set_value_cansleep(ctx->reset, 0);
> +		msleep(5);
> +	}
> +
> +	if (ctx->avdd) {
> +		gpiod_set_value_cansleep(ctx->avdd, 0);
> +		msleep(5);
> +	}
> +
> +	if (ctx->iovcc) {
> +		gpiod_set_value_cansleep(ctx->iovcc, 0);
> +		msleep(5);
> +	}
> +}
> +
> +static const struct ws_panel_desc ws_panel_12_3_inch_a_4lane_desc = {
> +	.init = ws_panel_12_3_a_4lane_init,
> +	.mode = &ws_panel_12_3_a_4lane_mode,
> +	.mode_flags = MIPI_DSI_MODE_VIDEO_HSE | MIPI_DSI_MODE_VIDEO |
> +		      MIPI_DSI_MODE_LPM | MIPI_DSI_CLOCK_NON_CONTINUOUS,
> +	.lanes = 4,
> +	.format = MIPI_DSI_FMT_RGB888,
> +};
> +
> +static const struct ws_panel_desc ws_panel_10_1_inch_a_4lane_desc = {
> +	.init = ws_panel_10_1_a_4lane_init,
> +	.mode = &ws_panel_10_1_a_mode,
> +	.mode_flags = MIPI_DSI_MODE_VIDEO_HSE | MIPI_DSI_MODE_VIDEO |
> +		      MIPI_DSI_MODE_LPM | MIPI_DSI_CLOCK_NON_CONTINUOUS,
> +	.lanes = 4,
> +	.format = MIPI_DSI_FMT_RGB888,
> +};
> +
> +static const struct ws_panel_desc ws_panel_10_1_inch_a_desc = {
> +	.init = ws_panel_10_1_a_init,
> +	.mode = &ws_panel_10_1_a_mode,
> +	.mode_flags = MIPI_DSI_MODE_VIDEO_HSE | MIPI_DSI_MODE_VIDEO |
> +		      MIPI_DSI_MODE_LPM | MIPI_DSI_CLOCK_NON_CONTINUOUS,
> +	.lanes = 2,
> +	.format = MIPI_DSI_FMT_RGB888,
> +};
> +
> +static const struct ws_panel_desc ws_panel_10_1_inch_b_4lane_desc = {
> +	.init = ws_panel_10_1_b_4lane_init,
> +	.mode = &ws_panel_10_1_b_4lane_mode,
> +	.mode_flags = MIPI_DSI_MODE_VIDEO_HSE | MIPI_DSI_MODE_VIDEO |
> +		      MIPI_DSI_MODE_LPM | MIPI_DSI_CLOCK_NON_CONTINUOUS,
> +	.lanes = 4,
> +	.format = MIPI_DSI_FMT_RGB888,
> +};
> +
> +static const struct ws_panel_desc ws_panel_10_1_inch_b_desc = {
> +	.init = ws_panel_10_1_b_init,
> +	.mode = &ws_panel_10_1_b_mode,
> +	.mode_flags = MIPI_DSI_MODE_VIDEO_HSE | MIPI_DSI_MODE_VIDEO |
> +		      MIPI_DSI_MODE_LPM | MIPI_DSI_CLOCK_NON_CONTINUOUS,
> +	.lanes = 2,
> +	.format = MIPI_DSI_FMT_RGB888,
> +};
> +
> +static const struct ws_panel_desc ws_panel_9_inch_b_4lane_desc = {
> +	.init = ws_panel_10_1_b_4lane_init,
> +	.mode = &ws_panel_9_b_4lane_mode,
> +	.mode_flags = MIPI_DSI_MODE_VIDEO_HSE | MIPI_DSI_MODE_VIDEO |
> +		      MIPI_DSI_MODE_LPM | MIPI_DSI_CLOCK_NON_CONTINUOUS,
> +	.lanes = 4,
> +	.format = MIPI_DSI_FMT_RGB888,
> +};
> +
> +static const struct ws_panel_desc ws_panel_9_inch_b_desc = {
> +	.init = ws_panel_10_1_b_init,
> +	.mode = &ws_panel_9_b_mode,
> +	.mode_flags = MIPI_DSI_MODE_VIDEO_HSE | MIPI_DSI_MODE_VIDEO |
> +		      MIPI_DSI_MODE_LPM | MIPI_DSI_CLOCK_NON_CONTINUOUS,
> +	.lanes = 2,
> +	.format = MIPI_DSI_FMT_RGB888,
> +};
> +
> +static const struct ws_panel_desc ws_panel_8_8_inch_a_desc = {
> +	.init = ws_panel_8_8_a_init,
> +	.mode = &ws_panel_8_8_a_mode,
> +	.mode_flags = MIPI_DSI_MODE_VIDEO_HSE | MIPI_DSI_MODE_VIDEO |
> +		      MIPI_DSI_MODE_LPM | MIPI_DSI_CLOCK_NON_CONTINUOUS,
> +	.lanes = 2,
> +	.format = MIPI_DSI_FMT_RGB888,
> +};
> +
> +static const struct ws_panel_desc ws_panel_8_inch_a_4lane_desc = {
> +	.init = ws_panel_8_a_4lane_init,
> +	.mode = &ws_panel_8_a_mode,
> +	.mode_flags = MIPI_DSI_MODE_VIDEO_HSE | MIPI_DSI_MODE_VIDEO |
> +		      MIPI_DSI_MODE_LPM | MIPI_DSI_CLOCK_NON_CONTINUOUS,
> +	.lanes = 4,
> +	.format = MIPI_DSI_FMT_RGB888,
> +};
> +
> +static const struct ws_panel_desc ws_panel_8_inch_a_desc = {
> +	.init = ws_panel_8_a_init,
> +	.mode = &ws_panel_8_a_mode,
> +	.mode_flags = MIPI_DSI_MODE_VIDEO_HSE | MIPI_DSI_MODE_VIDEO |
> +		      MIPI_DSI_MODE_LPM | MIPI_DSI_CLOCK_NON_CONTINUOUS,
> +	.lanes = 2,
> +	.format = MIPI_DSI_FMT_RGB888,
> +};
> +
> +static const struct ws_panel_desc ws_panel_7_inch_a_desc = {
> +	.init = ws_panel_7_a_init,
> +	.mode = &ws_panel_7_a_mode,
> +	.mode_flags = MIPI_DSI_MODE_VIDEO_HSE | MIPI_DSI_MODE_VIDEO |
> +		      MIPI_DSI_MODE_LPM | MIPI_DSI_CLOCK_NON_CONTINUOUS,
> +	.lanes = 2,
> +	.format = MIPI_DSI_FMT_RGB888,
> +};
> +
> +static const struct ws_panel_desc ws_panel_5_5_inch_a_desc = {
> +	.init = ws_panel_5_5_a_init,
> +	.mode = &ws_panel_5_5_a_mode,
> +	.mode_flags = MIPI_DSI_MODE_VIDEO_HSE | MIPI_DSI_MODE_VIDEO |
> +		      MIPI_DSI_MODE_LPM | MIPI_DSI_CLOCK_NON_CONTINUOUS,
> +	.lanes = 2,
> +	.format = MIPI_DSI_FMT_RGB888,
> +};
> +
> +static const struct ws_panel_desc ws_panel_5_inch_a_desc = {
> +	.init = ws_panel_5_a_init,
> +	.mode = &ws_panel_5_a_mode,
> +	.mode_flags = MIPI_DSI_MODE_VIDEO_HSE | MIPI_DSI_MODE_VIDEO |
> +		      MIPI_DSI_MODE_LPM | MIPI_DSI_CLOCK_NON_CONTINUOUS,
> +	.lanes = 2,
> +	.format = MIPI_DSI_FMT_RGB888,
> +};
> +
> +static const struct ws_panel_desc ws_panel_4_inch_c_desc = {
> +	.init = ws_panel_4_c_init,
> +	.mode = &ws_panel_4_c_mode,
> +	.mode_flags = MIPI_DSI_MODE_VIDEO_HSE | MIPI_DSI_MODE_VIDEO |
> +		      MIPI_DSI_MODE_LPM | MIPI_DSI_CLOCK_NON_CONTINUOUS,
> +	.lanes = 2,
> +	.format = MIPI_DSI_FMT_RGB888,
> +};
> +
> +static const struct ws_panel_desc ws_panel_3_4_inch_c_desc = {
> +	.init = ws_panel_3_4_c_init,
> +	.mode = &ws_panel_3_4_c_mode,
> +	.mode_flags = MIPI_DSI_MODE_VIDEO_HSE | MIPI_DSI_MODE_VIDEO |
> +		      MIPI_DSI_MODE_LPM | MIPI_DSI_CLOCK_NON_CONTINUOUS,
> +	.lanes = 2,
> +	.format = MIPI_DSI_FMT_RGB888,
> +};
> +
> +static const struct of_device_id ws_panel_of_match[] = {
> +	{ .compatible = "waveshare,12.3-dsi-touch-a,4lane",
> +	  &ws_panel_12_3_inch_a_4lane_desc },
> +	{ .compatible = "waveshare,10.1-dsi-touch-a-4lane",
> +	  &ws_panel_10_1_inch_a_4lane_desc },
> +	{ .compatible = "waveshare,10.1-dsi-touch-a",

Is it the same panel but connected differently? Or are those two
different panels?

The same question applies to several other panels here.

> +	  &ws_panel_10_1_inch_a_desc },
> +	{ .compatible = "waveshare,10.1-dsi-touch-b,4lane",
> +	  &ws_panel_10_1_inch_b_4lane_desc },
> +	{ .compatible = "waveshare,10.1-dsi-touch-b",
> +	  &ws_panel_10_1_inch_b_desc },
> +	{ .compatible = "waveshare,9.0-dsi-touch-b,4lane",
> +	  &ws_panel_9_inch_b_4lane_desc },
> +	{ .compatible = "waveshare,9.0-dsi-touch-b",
> +	  &ws_panel_9_inch_b_desc },
> +	{ .compatible = "waveshare,8.8-dsi-touch-a",
> +	  &ws_panel_8_8_inch_a_desc },
> +	{ .compatible = "waveshare,8.0-dsi-touch-a-4lane",
> +	  &ws_panel_8_inch_a_4lane_desc },
> +	{ .compatible = "waveshare,8.0-dsi-touch-a", &ws_panel_8_inch_a_desc },
> +	{ .compatible = "waveshare,7.0-dsi-touch-a", &ws_panel_7_inch_a_desc },
> +	{ .compatible = "waveshare,7.0-dsi-touch-b", &ws_panel_7_inch_a_desc },
> +	{ .compatible = "waveshare,5.5-dsi-touch-a",
> +	  &ws_panel_5_5_inch_a_desc },
> +	{ .compatible = "waveshare,5.0-dsi-touch-a", &ws_panel_5_inch_a_desc },
> +	{ .compatible = "waveshare,4.0-dsi-touch-c", &ws_panel_4_inch_c_desc },
> +	{ .compatible = "waveshare,3.4-dsi-touch-c",
> +		&ws_panel_3_4_inch_c_desc },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, ws_panel_of_match);
> +
> +static struct mipi_dsi_driver ws_panel_dsi_driver = {
> +	.probe		= ws_panel_dsi_probe,
> +	.remove		= ws_panel_dsi_remove,
> +	.shutdown	= ws_panel_dsi_shutdown,
> +	.driver = {
> +		.name		= "waveshare-dsi",
> +		.of_match_table	= ws_panel_of_match,
> +	},
> +};
> +module_mipi_dsi_driver(ws_panel_dsi_driver);
> +
> +MODULE_AUTHOR("Waveshare Team <support@waveshare.com>");
> +MODULE_DESCRIPTION("Waveshare DSI panel driver");
> +MODULE_LICENSE("GPL");
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

