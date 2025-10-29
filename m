Return-Path: <linux-kernel+bounces-877125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB6E7C1D43B
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 21:45:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23C2E3B84BD
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 20:45:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8869B260583;
	Wed, 29 Oct 2025 20:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pWFwKKuh"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E85E18A6DB
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 20:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761770729; cv=none; b=EgxBN3qDk8cHiH5ka87HdSxKf7srEmPI+Ibwc2sFGqecoQQDIMSgy/BnyAUg/RRYjo7HcOprAaZ6+fIQHAchy2v1seHdyd+hkbOesoZGTTCJYOJ7g1kSP/XojyiWIg6ohTRW33DwEEDY/XhM4ZqiKwiR2QHRUfQp/yeEQSy5wUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761770729; c=relaxed/simple;
	bh=98rrNheZrfHJq/URfTOqfdrKL7OndACz4UncPjNHSaA=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=mUikTE3ZMNhE7e21GiNA2S6tSXOLcW+gdaECz1SkvjArG/v+jXpTTpBRafqpkqz1aR/RuVCoT36E64Hn0f5w6zOS9uRCZywCRFGkJiQsklzHThEOOqExVhMifrVdDs+phkUDOLJ+7wi8VJZFQi6PCp0vhdvudpOUDtUt2W8mBGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pWFwKKuh; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-4285169c005so175830f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 13:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761770725; x=1762375525; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UoXVS+qfE2C1dcYGfRNGHKQoIeogweVupRDmQRwJ7hk=;
        b=pWFwKKuhbT2JEtdFskgw3oqJ/nl8d74sw7KMejD82jTGHcBQY1HouELE23cDdkaAf6
         uJTV675iBokCNCTwK6Xf35VI4H5WTyLn5UhHD8pDCrSW6bXXF43Ay/STo9qphVUtQq65
         c0BocsvZF2Vd05PDWHTxf8CBwcevJhRUIkW40JY6KTRirBibFPuw1f6DfgIx3DLqn+fF
         lDaunRUBGFzmQ0+eKPH8zD8MgmUM4Yazrjm6uv6/Vpj6qT+Nx6khnumgHC4yD1r1MwC7
         51RJMXMu1QxROImmHs4FkWH1EYMPYZkS+7hY37VwBccQUzJ6FohxcufNdsMMu71HUyfz
         cqyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761770725; x=1762375525;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UoXVS+qfE2C1dcYGfRNGHKQoIeogweVupRDmQRwJ7hk=;
        b=QGiNZZp10Ce2xs5kM148QDMlmei1fUF2zH90bLyzM5Mf+Fm3UaNNhAgse9kxZjl0Ia
         miW/TY8h/moO3mKq27Ne8Z2kNvYYh8XEh8gVggHhDC0SWmi9JJlXrDLjZKKfWOfs6zp/
         cuTzSjIxgWCaQeXfvhKsv8uh8t1Bw27mermPJq/iCdpijyWeFgBvY1Yaivar5JXGepXM
         G+CDzv2Js+7ABibX7Y1QT/LWkWZ2XiRZI+DdOqb7BSIorzevmytlk/adwhryf/k3nI/Z
         +he9Td2AQ8Q+B4qZCPmlOBipBV+BmgM6Bo76xK66Yr+hByLpOoYVgF36QnBtvKPjj9xA
         uPTA==
X-Forwarded-Encrypted: i=1; AJvYcCUatLN7aY5ZeI/BTRMZ1IN21nFWWCfiqPjK5EUx4XeJWUJKMLSQBDd+Xe9KetCkpvW3pUJfkuK8LbvrvpU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuagRCne9gu3ge0pdY7jRDWYk4/PWWDOr+hjmWtgr+A8+rx+jH
	zw/dhho1BsDEsi5M1QDGKgj7zJx/JWkOif/rBwcwqAQLDF2vtF2TLiehqBYjr2dFvNkD3xy4yQ6
	TCPJ9
X-Gm-Gg: ASbGncsUrTIk3GuXhxy+iWNh/tYRqKFcE2bVipeE4Juru4LaYuvH6zNMazvl73efn0A
	uGKES6NWkvOeFtBBUcxbkpwIeLoiKwwl9cjGa2KrTeoAiclQirQDutqZVN2fmy1QHMeoRIWwanz
	hwa89Kz57YE3E4FdzSIIXvFMKgQmL0dViZCI3DajZyPMDs981wK/FUkIPqF2s4W3EENayrEdCav
	HN6LJ78E2O55grIfae/ZNk700hvnuAAw4rhuxR1zN8C6Z6ZYuUYTnF3G2gMF447AnFU0xwZrns3
	93k9YkvpjejQiCLikwJySgm466y2v/LClVswdUmOyXuLREllrLUzAGumhpk/Jhx3AOewG58XITI
	8eXANe0odrY0xf8qUt79/3hOc+V8X6p1AOEYeCF/sRJXPcBmH4iECqWbroUict1BvHuLPbtjo3K
	lTjfAMSqApe+z5QruIWhxP9aj7nCf8EwGBdtwIekW3BixKqXPY3MuWlu8HopTN
X-Google-Smtp-Source: AGHT+IGlXbWUL37PZfkCg0DwX/+vcFNKwziwmmbzw9qqwdbrc/FE4E3vm3nTCiJWrpz3CYQcS4VUqg==
X-Received: by 2002:a5d:64c8:0:b0:3df:c5e3:55fe with SMTP id ffacd0b85a97d-429aefb9cffmr3752913f8f.29.1761770725354;
        Wed, 29 Oct 2025 13:45:25 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:cad:2140:3447:eb7a:cb9f:5e0? ([2a01:e0a:cad:2140:3447:eb7a:cb9f:5e0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952cb7e8sm28441586f8f.19.2025.10.29.13.45.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Oct 2025 13:45:24 -0700 (PDT)
Message-ID: <c47fc9bd-c041-4fc7-b08d-8f15622f4fba@linaro.org>
Date: Wed, 29 Oct 2025 21:45:24 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 2/3] drm/panel: Add support for the Leadtek LTK08QV25BYL
 panel
To: Herve Codina <herve.codina@bootlin.com>,
 Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@bootlin.com>
References: <20251021073408.195959-1-herve.codina@bootlin.com>
 <20251021073408.195959-3-herve.codina@bootlin.com>
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
In-Reply-To: <20251021073408.195959-3-herve.codina@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/21/25 09:34, Herve Codina wrote:
> The Leadtek LTK08QV25BYL is a 2.8" 240x320 DSI display.
> 
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> ---
>   drivers/gpu/drm/panel/Kconfig                 |  12 +
>   drivers/gpu/drm/panel/Makefile                |   1 +
>   .../drm/panel/panel-leadtek-ltk028qv25byl.c   | 304 ++++++++++++++++++
>   3 files changed, 317 insertions(+)
>   create mode 100644 drivers/gpu/drm/panel/panel-leadtek-ltk028qv25byl.c
> 
> diff --git a/drivers/gpu/drm/panel/Kconfig b/drivers/gpu/drm/panel/Kconfig
> index 407c5f6a268b..faa417195b6e 100644
> --- a/drivers/gpu/drm/panel/Kconfig
> +++ b/drivers/gpu/drm/panel/Kconfig
> @@ -367,6 +367,18 @@ config DRM_PANEL_KINGDISPLAY_KD097D04
>   	  24 bit RGB per pixel. It provides a MIPI DSI interface to
>   	  the host and has a built-in LED backlight.
>   
> +config DRM_PANEL_LEADTEK_LTK028QV25BYL
> +	tristate "Leadtek LTK028QV25BYL panel"
> +	depends on OF
> +	depends on DRM_MIPI_DSI
> +	depends on BACKLIGHT_CLASS_DEVICE
> +	help
> +	  Say Y here if you want to enable support for Leadtek LTK028QV25BYL
> +	  TFT-LCD modules. The panel has a 240x320 resolution and uses
> +	  18 bit RGB per pixel. It provides a MIPI DSI interface to
> +	  the host and has a built-in LED backlight.
> +
> +
>   config DRM_PANEL_LEADTEK_LTK050H3146W
>   	tristate "Leadtek LTK050H3146W panel"
>   	depends on OF
> diff --git a/drivers/gpu/drm/panel/Makefile b/drivers/gpu/drm/panel/Makefile
> index 3615a761b44f..12073c34e0f5 100644
> --- a/drivers/gpu/drm/panel/Makefile
> +++ b/drivers/gpu/drm/panel/Makefile
> @@ -37,6 +37,7 @@ obj-$(CONFIG_DRM_PANEL_JDI_LPM102A188A) += panel-jdi-lpm102a188a.o
>   obj-$(CONFIG_DRM_PANEL_JDI_R63452) += panel-jdi-fhd-r63452.o
>   obj-$(CONFIG_DRM_PANEL_KHADAS_TS050) += panel-khadas-ts050.o
>   obj-$(CONFIG_DRM_PANEL_KINGDISPLAY_KD097D04) += panel-kingdisplay-kd097d04.o
> +obj-$(CONFIG_DRM_PANEL_LEADTEK_LTK028QV25BYL) += panel-leadtek-ltk028qv25byl.o
>   obj-$(CONFIG_DRM_PANEL_LEADTEK_LTK050H3146W) += panel-leadtek-ltk050h3146w.o
>   obj-$(CONFIG_DRM_PANEL_LEADTEK_LTK500HD1829) += panel-leadtek-ltk500hd1829.o
>   obj-$(CONFIG_DRM_PANEL_LINCOLNTECH_LCD197) += panel-lincolntech-lcd197.o
> diff --git a/drivers/gpu/drm/panel/panel-leadtek-ltk028qv25byl.c b/drivers/gpu/drm/panel/panel-leadtek-ltk028qv25byl.c
> new file mode 100644
> index 000000000000..2e3482b2b95c
> --- /dev/null
> +++ b/drivers/gpu/drm/panel/panel-leadtek-ltk028qv25byl.c
> @@ -0,0 +1,304 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Leadtek LTK08QV25BYL 2.8" MIPI-DSI panel driver
> + * Copyright (c) 2025, Bootlin
> + *
> + * base on panel-leadtek-ltk050h346w.c
> + * Copyright (C) 2020 Theobroma Systems Design und Consulting GmbH
> + */
> +
> +#include <linux/delay.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/regulator/consumer.h>
> +
> +#include <video/mipi_display.h>
> +
> +#include <drm/drm_mipi_dsi.h>
> +#include <drm/drm_modes.h>
> +#include <drm/drm_panel.h>
> +
> +struct ltk028qv25byl {
> +	struct device *dev;
> +	struct drm_panel panel;
> +	struct gpio_desc *reset_gpio;
> +	struct regulator *vci;
> +	struct regulator *iovcc;
> +};
> +
> +static inline struct ltk028qv25byl *panel_to_ltk028qv25byl(struct drm_panel *panel)
> +{
> +	return container_of(panel, struct ltk028qv25byl, panel);
> +}
> +
> +static int ltk028qv25byl_init_sequence(struct ltk028qv25byl *ctx)
> +{
> +	struct mipi_dsi_device *dsi = to_mipi_dsi_device(ctx->dev);
> +	struct mipi_dsi_multi_context dsi_ctx = { .dsi = dsi };
> +
> +	/*
> +	 * Init sequence was supplied by the panel vendor. All documentation
> +	 * provided by the vendor (i.e comments in the provided init sequence)
> +	 * is also given here as comments without modification.
> +	 */
> +
> +	/* Password */
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xdf, 0x98, 0x51, 0xe9);
> +
> +	/* Page 0 */
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xde, 0x00);
> +
> +	/* VGMP, VGSP, VGMN, VGSN 4.3 */
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xb7, 0x1e, 0x85, 0x1e, 0x33);
> +
> +	/* Set_R_GAMMA */
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xc8, 0x3f, 0x2e, 0x25, 0x21, 0x23,
> +				     0x25, 0x1f, 0x1e, 0x1c, 0x1b, 0x19, 0x11,
> +				     0x0e, 0x0a, 0x06, 0x0e, 0x3f, 0x2e, 0x26,
> +				     0x21, 0x24, 0x25, 0x1f, 0x1f, 0x1d, 0x1c,
> +				     0x19,  0x11,  0x0e,  0x0a,  0x06,  0x0e);
> +
> +	/* POW_CTRL */
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xb9, 0x33, 0x08, 0xcc);
> +
> +	/* DCDC_SEL */
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xbb, 0x44, 0x7a, 0x30, 0x40, 0x7c,
> +				     0x60, 0x70, 0x70);
> +
> +	/* VDD_CTRL */
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xbc, 0x38, 0x3c);
> +
> +	/* SETSTBA */
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xc0, 0x31, 0x20);
> +
> +	/* SETPANEL(default) */
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xc1, 0x12);
> +
> +	/* SETRGBCYC */
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xc3, 0x08, 0x00, 0x0a, 0x10, 0x08,
> +				     0x54, 0x45, 0x71, 0x2c);
> +
> +	/* SETRGBCYC(default) */
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xc4, 0x00, 0xa0, 0x79, 0x0e, 0x0a,
> +				     0x16, 0x79, 0x0e, 0x0a, 0x16, 0x79, 0x0e,
> +				     0x0a, 0x16, 0x82, 0x00, 0x03);
> +
> +	/* SET_GD(default) */
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xd0, 0x04, 0x0c, 0x6a, 0x0f, 0x00, 0x03);
> +
> +	/* RAMCTRL(default) */
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx,  0xd7,  0x13,  0x00);
> +
> +	/* Page 2 */
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx,  0xde,  0x02);
> +
> +	/* DCDC_SET */
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xb8, 0x1d, 0xa0, 0x2f, 0x2c, 0x2b);
> +
> +	/* SETRGBCYC2 */
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xc1, 0x10, 0x66, 0x66, 0x01);
> +
> +	/* Page 0 */
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xde, 0x00);
> +
> +	/* SLPOUT  + 120ms delay */
> +	mipi_dsi_dcs_exit_sleep_mode_multi(&dsi_ctx);
> +	mipi_dsi_msleep(&dsi_ctx, 120);
> +
> +	/* Page 2 */
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xde,  0x02);
> +
> +	/* OSCM */
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xc5, 0x4e, 0x00, 0x00);
> +
> +	/* SETMIPI_2 */
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xca, 0x30, 0x20, 0xf4);
> +
> +	/* Page 4 */
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xde, 0x04);
> +
> +	/* SETPHY3 */
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xd3, 0x3c);
> +
> +	/* Page 0 */
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xde, 0x00);
> +
> +	/* Display on + 20ms delay */
> +	mipi_dsi_dcs_set_display_on_multi(&dsi_ctx);
> +	mipi_dsi_msleep(&dsi_ctx, 20);
> +
> +	return dsi_ctx.accum_err;
> +}
> +
> +static int ltk028qv25byl_unprepare(struct drm_panel *panel)
> +{
> +	struct ltk028qv25byl *ctx = panel_to_ltk028qv25byl(panel);
> +	struct mipi_dsi_device *dsi = to_mipi_dsi_device(ctx->dev);
> +	struct mipi_dsi_multi_context dsi_ctx = { .dsi = dsi };
> +
> +	mipi_dsi_dcs_set_display_off_multi(&dsi_ctx);
> +	mipi_dsi_dcs_enter_sleep_mode_multi(&dsi_ctx);
> +	if (dsi_ctx.accum_err)
> +		return dsi_ctx.accum_err;
> +
> +	gpiod_set_value_cansleep(ctx->reset_gpio, 1);
> +
> +	regulator_disable(ctx->iovcc);
> +	regulator_disable(ctx->vci);
> +
> +	return 0;
> +}
> +
> +static int ltk028qv25byl_prepare(struct drm_panel *panel)
> +{
> +	struct ltk028qv25byl *ctx = panel_to_ltk028qv25byl(panel);
> +	int ret;
> +
> +	ret = regulator_enable(ctx->vci);
> +	if (ret < 0) {
> +		dev_err(ctx->dev, "Failed to enable vcc supply (%d)\n", ret);
> +		return ret;
> +	}
> +	ret = regulator_enable(ctx->iovcc);
> +	if (ret < 0) {
> +		dev_err(ctx->dev, "Failed to enable iovcc supply (%d)\n", ret);
> +		goto disable_vci;
> +	}
> +
> +	gpiod_set_value_cansleep(ctx->reset_gpio, 1);
> +	usleep_range(5000, 6000);
> +	gpiod_set_value_cansleep(ctx->reset_gpio, 0);
> +	msleep(20);
> +
> +	ret = ltk028qv25byl_init_sequence(ctx);
> +	if (ret)
> +		goto force_reset;
> +
> +	return 0;
> +
> +force_reset:
> +	gpiod_set_value_cansleep(ctx->reset_gpio, 1);
> +	regulator_disable(ctx->iovcc);
> +disable_vci:
> +	regulator_disable(ctx->vci);
> +	return ret;
> +}
> +
> +static const struct drm_display_mode ltk028qv25byl_mode = {
> +	.hdisplay       = 240,
> +	.hsync_start    = 240 + 120,
> +	.hsync_end      = 240 + 120 + 4,
> +	.htotal         = 240 + 120 + 4 + 120,
> +	.vdisplay       = 320,
> +	.vsync_start    = 320 + 8,
> +	.vsync_end      = 320 + 8 + 2,
> +	.vtotal         = 320 + 8 + 2 + 6,
> +	.clock          = 10000000 / 1000,

Usually we calculate the clock from the mode parameters, won't it work here ?

> +	.flags          = DRM_MODE_FLAG_NVSYNC | DRM_MODE_FLAG_NHSYNC,
> +	.width_mm       = 45,
> +	.height_mm      = 62,
> +};
> +
> +static int ltk028qv25byl_get_modes(struct drm_panel *panel,
> +				   struct drm_connector *connector)
> +{
> +	struct drm_display_mode *mode;
> +
> +	mode = drm_mode_duplicate(connector->dev, &ltk028qv25byl_mode);
> +	if (!mode)
> +		return -ENOMEM;
> +
> +	drm_mode_set_name(mode);
> +
> +	mode->type = DRM_MODE_TYPE_DRIVER | DRM_MODE_TYPE_PREFERRED;
> +	connector->display_info.width_mm = mode->width_mm;
> +	connector->display_info.height_mm = mode->height_mm;
> +	drm_mode_probed_add(connector, mode);
> +
> +	return 1;
> +}
> +
> +static const struct drm_panel_funcs ltk028qv25byl_funcs = {
> +	.unprepare = ltk028qv25byl_unprepare,
> +	.prepare = ltk028qv25byl_prepare,
> +	.get_modes = ltk028qv25byl_get_modes,
> +};
> +
> +static int ltk028qv25byl_probe(struct mipi_dsi_device *dsi)
> +{
> +	struct device *dev = &dsi->dev;
> +	struct ltk028qv25byl *ctx;
> +	int ret;
> +
> +	ctx = devm_drm_panel_alloc(dev, __typeof(*ctx), panel,
> +				   &ltk028qv25byl_funcs,
> +				   DRM_MODE_CONNECTOR_DSI);
> +	if (IS_ERR(ctx))
> +		return PTR_ERR(ctx);
> +
> +	ctx->reset_gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_LOW);
> +	if (IS_ERR(ctx->reset_gpio))
> +		return dev_err_probe(dev, PTR_ERR(ctx->reset_gpio),
> +				     "Failed to get reset gpio\n");
> +
> +	ctx->vci = devm_regulator_get(dev, "vci");
> +	if (IS_ERR(ctx->vci))
> +		return dev_err_probe(dev, PTR_ERR(ctx->vci),
> +				     "Failed to get vcc regulator\n");
> +
> +	ctx->iovcc = devm_regulator_get(dev, "iovcc");
> +	if (IS_ERR(ctx->iovcc))
> +		return dev_err_probe(dev, PTR_ERR(ctx->iovcc),
> +				     "Failed to get iovcc regulator\n");

Can you switch to devm_regulator_bulk_get_const() ?

> +
> +	mipi_dsi_set_drvdata(dsi, ctx);
> +
> +	ctx->dev = dev;
> +
> +	dsi->lanes = 1;
> +	dsi->format = MIPI_DSI_FMT_RGB888;
> +	dsi->mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_BURST |
> +			  MIPI_DSI_MODE_LPM | MIPI_DSI_MODE_NO_EOT_PACKET;
> +
> +	ret = drm_panel_of_backlight(&ctx->panel);
> +	if (ret)
> +		return ret;
> +
> +	drm_panel_add(&ctx->panel);
> +
> +	ret = devm_mipi_dsi_attach(dev, dsi);
> +	if (ret < 0) {
> +		drm_panel_remove(&ctx->panel);
> +		return dev_err_probe(dev, ret, "Failed to attach to DSI host\n");
> +	}
> +
> +	return 0;
> +}
> +
> +static void ltk028qv25byl_remove(struct mipi_dsi_device *dsi)
> +{
> +	struct ltk028qv25byl *ctx = mipi_dsi_get_drvdata(dsi);
> +
> +	drm_panel_remove(&ctx->panel);
> +}
> +
> +static const struct of_device_id ltk028qv25byl_of_match[] = {
> +	{ .compatible = "leadtek,ltk028qv25byl" },
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, ltk028qv25byl_of_match);
> +
> +static struct mipi_dsi_driver ltk028qv25byl_driver = {
> +	.driver = {
> +		.name = "panel-leadtek-ltk028qv25byl",
> +		.of_match_table = ltk028qv25byl_of_match,
> +	},
> +	.probe	= ltk028qv25byl_probe,
> +	.remove = ltk028qv25byl_remove,
> +};
> +module_mipi_dsi_driver(ltk028qv25byl_driver);
> +
> +MODULE_AUTHOR("Herve Codina <herve.codina@bootlin.com>");
> +MODULE_DESCRIPTION("DRM driver for Leadtek LTK028QV25BYL MIPI DSI panel");
> +MODULE_LICENSE("GPL");

Thanks,
Neil

