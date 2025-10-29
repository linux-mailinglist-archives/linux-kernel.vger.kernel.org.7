Return-Path: <linux-kernel+bounces-877158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 602EAC1D550
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 22:00:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D8F4F34CAA6
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 21:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD05731329D;
	Wed, 29 Oct 2025 21:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="H2kmAjLr"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A20230F927
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 21:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761771605; cv=none; b=YbtZk0GTc2nkMpH5iG8BNcpbl52l56W//5dTifSdB8/fYMetZyLRiBJoxD/kh6TNPO+qZXT1ZOA2k1/uQODdAWZHq/RNhwBo+tyZIBFohVA3eKCjVq+uX7zl0IJE6Qx8qPt7RnT1WAp+QFML/5kGsp5XNk5BpdgVduHspewDH5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761771605; c=relaxed/simple;
	bh=Sgmo1BmSinosqS+HyzJZumAkEMTja5Et14ythky6X8Y=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Bmoy7/2HfQE93PtNvItGyHKhQeohOMwRNo+WLPjnMNz3rIl4vkQMRWnariph6f0Sk/CWwXd7EluZowRH466ukCXj7riG4jWY8HcL7zYEOoWM1muKS1TFcMSfZ3PvYgjZuRtiGkWb7G2xS2dxiGgCgvgrH/GbLWWSsJyK46QPlKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=H2kmAjLr; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-4283be7df63so148720f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 14:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761771602; x=1762376402; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bBDX2ZEzsZOG97itUGijq+eGPCPYlelSjBtwNakOTl8=;
        b=H2kmAjLrCK70g5Yeee2jJenWsLVm91MuGuJ6pnCV9zEvDh6EoasZKMu0g2/ZQ8P3Ul
         Thr+JpkvTa8AEbHO3rS6nwenY9y4/FNwa9Dnk1SmJk486U0FboWDYUZ/y6EmiyHtAJ5J
         gg7S1rYlGeYuPwzCLnB8tymKFXnsanBQ2ijXCAR50XyVDOrU0OPpZtXgc/8+K1cZIvZG
         a9kJaLekXhQ4/kYSi6DZ6CAHxV5hYrygtRL6dg/avuv7TmxRk5oWv4t70nsAnsfx1d+R
         oPGkraMXzdIWM5GrbKBd05GsXo6/6cQPCW29PGxtgvkT7GTz0W3UwtP3Go2XibIomgUF
         elrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761771602; x=1762376402;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bBDX2ZEzsZOG97itUGijq+eGPCPYlelSjBtwNakOTl8=;
        b=t9SXQqmA77zptQOSDe+fnktOyIZHkBfdGoOJ84n1QN6NTazHWyrG8+sodoRCmJz0kP
         SckLWa+DNW3JLXSdwcnSphPMC+Xc65vbRt/+7rIB0EpXjVJzTgmEJr971kYBG3fGV8Q2
         RLcTM/uLyccfnHrE2wvxqZDlc4AOnGnsSy8NJAnvKkB2SaHAKFL6mVFWh9BzgE8AYgZl
         ibbHWWFs/FimYxHHJzHliFHjhS0o/IMgjeP0yXz1IUQtSrNFY9FPFAT+7d49kv4JjJz3
         HYUBx9vIPnquA8tN30TDtII8lRP3kzKl46oamj65sJKfDQyBOjU32a354rA6w+7e0c0/
         Gy9Q==
X-Forwarded-Encrypted: i=1; AJvYcCVp24IDPvwfDtRPGr6+MKSmv8nIsbop5yaLaxd0oS7GGEINSJUAPer4hFABGq2Lj5iDa2khNCxPCykQzQ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDYPLF+finu25cfGONnPZi5uYbFpRTwxABTKfMuyUqH8p6ElFG
	pF509plNsm8gTcvedS6ugHXBTIty802Ggx04mZWFvqmiQ+x/MwBQVBC/KrbqZT8Vhdo=
X-Gm-Gg: ASbGnctfSrhEX8xmLTtT3yHr0J2f37/Z7Fcf09fjjskis4yV+5YAeNspkkmNNIv3RG+
	YTB9yq3kY9Mq9sJIHORuJwxcItXR6G6RU0J0yxLAqG/fxbsiQzxhREUVAEim1BQMTVK+d8y1noM
	hMBV6bSaVzv0UI/749SRb+V3/VpvoynZrajhMxQW3OUg/QOMuhSdB5qn1lb9MjRi2DicE7bXkJd
	ZuMN7tvNduxN3Z7sgPkqxVc5vMeLJDgOnwl2vI/27lOsF4OrWOm9i286dPLPs3wPl737H+8HFde
	ivbjlxFega6j3ob/7jgcS+b9XpiGKAK5TT/6Dn1ufJ/AgmV9HDr09vgP4U1KDjvSJRbjngtqCBv
	ak5ApOO57qlSPkTtVgR5RjkqHCUGrJe/1XBekULSSH4O+GRr+kFtp6aEa0+pCSI+8JznT+BGXEz
	/zL2Sbgrkq9Oku3WH2+JbJZZTOsGzUElkHTYa2KI/QP50/VrQ3Yg==
X-Google-Smtp-Source: AGHT+IExwnxy/9osHt7gWbhxm82ojkLSOcp9n6A+1Eon+Vn35zldezaF8A7fthBjfdQiKMD6Bk2CJg==
X-Received: by 2002:a05:6000:26ca:b0:3ee:1586:6c73 with SMTP id ffacd0b85a97d-429aef83dbcmr3214428f8f.19.1761771601653;
        Wed, 29 Oct 2025 14:00:01 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:cad:2140:3447:eb7a:cb9f:5e0? ([2a01:e0a:cad:2140:3447:eb7a:cb9f:5e0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952cbb20sm27942388f8f.18.2025.10.29.14.00.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Oct 2025 14:00:01 -0700 (PDT)
Message-ID: <7b165177-083d-4940-89d0-d81a163d7c1f@linaro.org>
Date: Wed, 29 Oct 2025 22:00:00 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH RESEND v5 2/2] drm: panel: add support for Synaptics TDDI
 series DSI panels
To: Kaustabh Chakraborty <kauschluss@disroot.org>,
 Jessica Zhang <quic_jesszhan@quicinc.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Jessica Zhang <jessica.zhang@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251009-panel-synaptics-tddi-v5-0-59390997644e@disroot.org>
 <20251009-panel-synaptics-tddi-v5-2-59390997644e@disroot.org>
Content-Language: en-US, fr
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro
In-Reply-To: <20251009-panel-synaptics-tddi-v5-2-59390997644e@disroot.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/9/25 18:22, Kaustabh Chakraborty wrote:
> Synaptics TDDI (Touch/Display Integration) panels utilize a single chip
> for display and touch controllers. Implement a simple device driver for
> such panels, along with its built-in LED backlight controller, and add
> support for TD4101 and TD4300 panels in the driver.
> 
> Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
> ---
>   drivers/gpu/drm/panel/Kconfig                |  11 ++
>   drivers/gpu/drm/panel/Makefile               |   1 +
>   drivers/gpu/drm/panel/panel-synaptics-tddi.c | 276 +++++++++++++++++++++++++++
>   3 files changed, 288 insertions(+)
> 
> diff --git a/drivers/gpu/drm/panel/Kconfig b/drivers/gpu/drm/panel/Kconfig
> index 407c5f6a268b2ec66e5d0eddae26b3368e4cb2cb..98708979ab45281628620bbe803fe8b597eb812d 100644
> --- a/drivers/gpu/drm/panel/Kconfig
> +++ b/drivers/gpu/drm/panel/Kconfig
> @@ -1045,6 +1045,17 @@ config DRM_PANEL_SYNAPTICS_R63353
>   	  Say Y if you want to enable support for panels based on the
>   	  Synaptics R63353 controller.
>   
> +config DRM_PANEL_SYNAPTICS_TDDI
> +	tristate "Synaptics TDDI display panels"
> +	depends on OF
> +	depends on DRM_MIPI_DSI
> +	depends on BACKLIGHT_CLASS_DEVICE
> +	help
> +	  Say Y if you want to enable support for the Synaptics TDDI display
> +	  panels. There are multiple MIPI DSI panels manufactured under the TDDI
> +	  namesake, with varying resolutions and data lanes. They also have a
> +	  built-in LED backlight and a touch controller.
> +
>   config DRM_PANEL_TDO_TL070WSH30
>   	tristate "TDO TL070WSH30 DSI panel"
>   	depends on OF
> diff --git a/drivers/gpu/drm/panel/Makefile b/drivers/gpu/drm/panel/Makefile
> index 3615a761b44f9de0b4a653be157d8e0bcbc8f6b7..2535e1c9df76451d1c66d7d211ac9bfbf18dc80e 100644
> --- a/drivers/gpu/drm/panel/Makefile
> +++ b/drivers/gpu/drm/panel/Makefile
> @@ -100,6 +100,7 @@ obj-$(CONFIG_DRM_PANEL_SITRONIX_ST7703) += panel-sitronix-st7703.o
>   obj-$(CONFIG_DRM_PANEL_SITRONIX_ST7789V) += panel-sitronix-st7789v.o
>   obj-$(CONFIG_DRM_PANEL_SUMMIT) += panel-summit.o
>   obj-$(CONFIG_DRM_PANEL_SYNAPTICS_R63353) += panel-synaptics-r63353.o
> +obj-$(CONFIG_DRM_PANEL_SYNAPTICS_TDDI) += panel-synaptics-tddi.o
>   obj-$(CONFIG_DRM_PANEL_SONY_ACX565AKM) += panel-sony-acx565akm.o
>   obj-$(CONFIG_DRM_PANEL_SONY_TD4353_JDI) += panel-sony-td4353-jdi.o
>   obj-$(CONFIG_DRM_PANEL_SONY_TULIP_TRULY_NT35521) += panel-sony-tulip-truly-nt35521.o
> diff --git a/drivers/gpu/drm/panel/panel-synaptics-tddi.c b/drivers/gpu/drm/panel/panel-synaptics-tddi.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..a4b3cbdebb6ca4062c02c6e7ac184f3ec245926a
> --- /dev/null
> +++ b/drivers/gpu/drm/panel/panel-synaptics-tddi.c
> @@ -0,0 +1,276 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Synaptics TDDI display panel driver.
> + *
> + * Copyright (C) 2025 Kaustabh Chakraborty <kauschluss@disroot.org>
> + */
> +
> +#include <linux/backlight.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +
> +#include <video/mipi_display.h>
> +
> +#include <drm/drm_mipi_dsi.h>
> +#include <drm/drm_modes.h>
> +#include <drm/drm_panel.h>
> +#include <drm/drm_probe_helper.h>
> +
> +struct tddi_panel_data {
> +	u8 lanes;
> +	/* wait timings for panel enable */
> +	u8 delay_ms_sleep_exit;
> +	u8 delay_ms_display_on;
> +	/* wait timings for panel disable */
> +	u8 delay_ms_display_off;
> +	u8 delay_ms_sleep_enter;
> +};
> +
> +struct tddi_ctx {
> +	struct drm_panel panel;
> +	struct mipi_dsi_device *dsi;
> +	struct drm_display_mode mode;
> +	struct backlight_device *backlight;
> +	const struct tddi_panel_data *data;
> +	struct regulator_bulk_data *supplies;
> +	struct gpio_desc *reset_gpio;
> +	struct gpio_desc *backlight_gpio;
> +};
> +
> +static const struct regulator_bulk_data tddi_supplies[] = {
> +	{ .supply = "vio" },
> +	{ .supply = "vsn" },
> +	{ .supply = "vsp" },
> +};
> +
> +static inline struct tddi_ctx *to_tddi_ctx(struct drm_panel *panel)
> +{
> +	return container_of(panel, struct tddi_ctx, panel);
> +}
> +
> +static int tddi_update_status(struct backlight_device *backlight)
> +{
> +	struct tddi_ctx *ctx = bl_get_data(backlight);
> +	struct mipi_dsi_multi_context dsi = { .dsi = ctx->dsi };
> +	u8 brightness = backlight_get_brightness(backlight);
> +
> +	if (!ctx->panel.enabled)
> +		return 0;
> +
> +	mipi_dsi_dcs_set_display_brightness_multi(&dsi, brightness);
> +
> +	return dsi.accum_err;
> +}
> +
> +static int tddi_prepare(struct drm_panel *panel)
> +{
> +	struct tddi_ctx *ctx = to_tddi_ctx(panel);
> +	struct device *dev = &ctx->dsi->dev;
> +	int ret;
> +
> +	ret = regulator_bulk_enable(ARRAY_SIZE(tddi_supplies), ctx->supplies);
> +	if (ret < 0) {
> +		dev_err(dev, "failed to enable regulators: %d\n", ret);
> +		return ret;
> +	}
> +
> +	gpiod_set_value_cansleep(ctx->reset_gpio, 0);
> +	usleep_range(5000, 6000);
> +	gpiod_set_value_cansleep(ctx->reset_gpio, 1);
> +	usleep_range(5000, 6000);
> +	gpiod_set_value_cansleep(ctx->reset_gpio, 0);
> +	usleep_range(10000, 11000);
> +
> +	gpiod_set_value_cansleep(ctx->backlight_gpio, 0);
> +	usleep_range(5000, 6000);
> +
> +	return 0;
> +}
> +
> +static int tddi_unprepare(struct drm_panel *panel)
> +{
> +	struct tddi_ctx *ctx = to_tddi_ctx(panel);
> +
> +	gpiod_set_value_cansleep(ctx->backlight_gpio, 1);
> +	usleep_range(5000, 6000);
> +
> +	gpiod_set_value_cansleep(ctx->reset_gpio, 1);
> +	usleep_range(5000, 6000);
> +
> +	regulator_bulk_disable(ARRAY_SIZE(tddi_supplies), ctx->supplies);
> +
> +	return 0;
> +}
> +
> +static int tddi_enable(struct drm_panel *panel)
> +{
> +	struct tddi_ctx *ctx = to_tddi_ctx(panel);
> +	struct mipi_dsi_multi_context dsi = { .dsi = ctx->dsi };
> +	u8 brightness = ctx->backlight->props.brightness;
> +
> +	mipi_dsi_dcs_write_seq_multi(&dsi, MIPI_DCS_WRITE_POWER_SAVE, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(&dsi, MIPI_DCS_WRITE_CONTROL_DISPLAY, 0x0c);
> +
> +	mipi_dsi_dcs_exit_sleep_mode_multi(&dsi);
> +	mipi_dsi_msleep(&dsi, ctx->data->delay_ms_sleep_exit);
> +
> +	/* sync the panel with the backlight's brightness level */
> +	mipi_dsi_dcs_set_display_brightness_multi(&dsi, brightness);
> +
> +	mipi_dsi_dcs_set_display_on_multi(&dsi);
> +	mipi_dsi_msleep(&dsi, ctx->data->delay_ms_display_on);
> +
> +	return dsi.accum_err;
> +};
> +
> +static int tddi_disable(struct drm_panel *panel)
> +{
> +	struct tddi_ctx *ctx = to_tddi_ctx(panel);
> +	struct mipi_dsi_multi_context dsi = { .dsi = ctx->dsi };
> +
> +	mipi_dsi_dcs_set_display_off_multi(&dsi);
> +	mipi_dsi_msleep(&dsi, ctx->data->delay_ms_display_off);
> +
> +	mipi_dsi_dcs_enter_sleep_mode_multi(&dsi);
> +	mipi_dsi_msleep(&dsi, ctx->data->delay_ms_sleep_enter);
> +
> +	return dsi.accum_err;
> +}
> +
> +static int tddi_get_modes(struct drm_panel *panel,
> +			  struct drm_connector *connector)
> +{
> +	struct tddi_ctx *ctx = to_tddi_ctx(panel);
> +
> +	return drm_connector_helper_get_modes_fixed(connector, &ctx->mode);
> +}
> +
> +static const struct backlight_ops tddi_bl_ops = {
> +	.update_status = tddi_update_status,
> +};
> +
> +static const struct backlight_properties tddi_bl_props = {
> +	.type = BACKLIGHT_PLATFORM,
> +	.brightness = 255,
> +	.max_brightness = 255,
> +};
> +
> +static const struct drm_panel_funcs tddi_drm_panel_funcs = {
> +	.prepare = tddi_prepare,
> +	.unprepare = tddi_unprepare,
> +	.enable = tddi_enable,
> +	.disable = tddi_disable,
> +	.get_modes = tddi_get_modes,
> +};
> +
> +static int tddi_probe(struct mipi_dsi_device *dsi)
> +{
> +	struct device *dev = &dsi->dev;
> +	struct tddi_ctx *ctx;
> +	int ret;
> +
> +	ctx = devm_drm_panel_alloc(dev, struct tddi_ctx, panel,
> +				   &tddi_drm_panel_funcs, DRM_MODE_CONNECTOR_DSI);
> +	if (IS_ERR(ctx))
> +		return PTR_ERR(ctx);
> +
> +	ctx->data = of_device_get_match_data(dev);
> +
> +	ctx->dsi = dsi;
> +	mipi_dsi_set_drvdata(dsi, ctx);
> +
> +	ret = devm_regulator_bulk_get_const(dev, ARRAY_SIZE(tddi_supplies),
> +					    tddi_supplies, &ctx->supplies);
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret, "failed to get regulators\n");
> +
> +	ctx->backlight_gpio = devm_gpiod_get_optional(dev, "backlight", GPIOD_ASIS);
> +	if (IS_ERR(ctx->backlight_gpio))
> +		return dev_err_probe(dev, PTR_ERR(ctx->backlight_gpio),
> +				     "failed to get backlight-gpios\n");
> +
> +	ctx->reset_gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_ASIS);
> +	if (IS_ERR(ctx->reset_gpio))
> +		return dev_err_probe(dev, PTR_ERR(ctx->reset_gpio),
> +				     "failed to get reset-gpios\n");
> +
> +	ret = of_get_drm_panel_display_mode(dev->of_node, &ctx->mode, NULL);
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret, "failed to get panel timings\n");
> +
> +	ctx->backlight = devm_backlight_device_register(dev, dev_name(dev), dev,
> +							ctx, &tddi_bl_ops,
> +							&tddi_bl_props);
> +	if (IS_ERR(ctx->backlight))
> +		return dev_err_probe(dev, PTR_ERR(ctx->backlight),
> +				     "failed to register backlight device");
> +
> +	dsi->lanes = ctx->data->lanes;
> +	dsi->format = MIPI_DSI_FMT_RGB888;
> +	dsi->mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_BURST |
> +			  MIPI_DSI_MODE_VIDEO_NO_HFP;
> +
> +	ctx->panel.prepare_prev_first = true;
> +	drm_panel_add(&ctx->panel);
> +
> +	ret = devm_mipi_dsi_attach(dev, dsi);
> +	if (ret < 0) {
> +		drm_panel_remove(&ctx->panel);
> +		return dev_err_probe(dev, ret, "failed to attach to DSI host\n");
> +	}
> +
> +	return 0;
> +}
> +
> +static void tddi_remove(struct mipi_dsi_device *dsi)
> +{
> +	struct tddi_ctx *ctx = mipi_dsi_get_drvdata(dsi);
> +
> +	drm_panel_remove(&ctx->panel);
> +}
> +
> +static const struct tddi_panel_data td4101_panel_data = {
> +	.lanes = 2,
> +	/* wait timings for panel enable */
> +	.delay_ms_sleep_exit = 100,
> +	.delay_ms_display_on = 0,
> +	/* wait timings for panel disable */
> +	.delay_ms_display_off = 20,
> +	.delay_ms_sleep_enter = 90,
> +};
> +
> +static const struct tddi_panel_data td4300_panel_data = {
> +	.lanes = 4,
> +	/* wait timings for panel enable */
> +	.delay_ms_sleep_exit = 100,
> +	.delay_ms_display_on = 0,
> +	/* wait timings for panel disable */
> +	.delay_ms_display_off = 0,
> +	.delay_ms_sleep_enter = 0,
> +};
> +
> +static const struct of_device_id tddi_of_device_id[] = {
> +	{
> +		.compatible = "syna,td4101-panel",
> +		.data = &td4101_panel_data,
> +	}, {
> +		.compatible = "syna,td4300-panel",
> +		.data = &td4300_panel_data,
> +	}, { }
> +};
> +MODULE_DEVICE_TABLE(of, tddi_of_device_id);
> +
> +static struct mipi_dsi_driver tddi_dsi_driver = {
> +	.probe = tddi_probe,
> +	.remove = tddi_remove,
> +	.driver = {
> +		.name = "panel-synaptics-tddi",
> +		.of_match_table = tddi_of_device_id,
> +	},
> +};
> +module_mipi_dsi_driver(tddi_dsi_driver);
> +
> +MODULE_AUTHOR("Kaustabh Chakraborty <kauschluss@disroot.org>");
> +MODULE_DESCRIPTION("Synaptics TDDI Display Panel Driver");
> +MODULE_LICENSE("GPL");
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

