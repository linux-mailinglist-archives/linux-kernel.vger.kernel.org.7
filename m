Return-Path: <linux-kernel+bounces-795706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CEC79B3F6C5
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 09:34:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E8AB1A80B88
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 07:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E5C52E2EEE;
	Tue,  2 Sep 2025 07:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RpIy7DQA"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1243145355
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 07:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756798453; cv=none; b=Y7HaXLjqv3TeP9hdpc1DL4XOiiMtx/vSjW8rjJiw2vP/kCVCLx0nxNZpv3K79aeWUsw/oU48iAFD8f/TvdmvmpcXBwhZo2cNjImyU39Qmd8HYWTWWm1XdVCpwQiBu6OTVCE7nieP12cn6eiwJfekZGf9UfMdabZtSVUz3JDso7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756798453; c=relaxed/simple;
	bh=QExWaTGE2vxWmLeNo5O+limUoL+4ru1Std4bISfnAJg=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=GudApFC/9nSpSsD0hiiw+1Tn22UaVz8bvTKSNaRPf/pBF6c2blj0nkambvqggS7jM3E9Ia1xgVT5XmkmHvlUe4iC+63STyUS939LH86bzuBE8iZl8ffBTewvBIgNnN4ij1bQAR2/1tgKI6aH/5gaBIhd4TKyP3SKXyVJJBVbjAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RpIy7DQA; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3dad6252eacso82081f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 00:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756798450; x=1757403250; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I32gN7OFjznQLzjzVHId6kppg+GjM4YqrgK6h7SJVJE=;
        b=RpIy7DQAAi3I3+D1eUHITEXlXcrTNd/PyyZbhebDn9asF/UMdVwX3mg58VfrCszjjP
         otJHkVczGYKXvGx1NFubQBionCosnA12s7dgmnuni+9yb6Cg33DWBtGkm7goi96DodpB
         kpWTCtcjGIeMfFO+T9qU2WRZzWOXbi6hulL0QtQXJl383rxexMkGEjk5Stk7oH26o4X0
         c24t6/mqjcaBmlbASExcbWze92TMbMQx7pY+MRsDkPdDLme/NS97+sTNaXxGKaNOuNDE
         WPaaCKp5F8EJj/uRBLQuAIlvAJlDmdaTDaC9HlirbhSL0TJJ91+RgSB3RtDrUOUgvXhK
         elkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756798450; x=1757403250;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=I32gN7OFjznQLzjzVHId6kppg+GjM4YqrgK6h7SJVJE=;
        b=Fo9oW650dXQ3tdquGJktwXDXJU7WWvX5937A73oHDE15pfvIHfD7iHniGHg/3psHL4
         +PQ9yxe4n4rbu8tvwMrzWqyzTXakdxnSAz87orY//EpLhPt0y16hv50UqqT3JQXnAknV
         L2uWcalRk4jYljUVeUihKXjpmyIgv1nsK4a7n2k9xvHWBcYg8xgqbpsAjLLuyg87Zd0I
         KBEODMv2ORPuYTzlqkoZGFOdZUm5Gs4Xq0XG2WUuvz4XQSr7DlIV/bNxZ4nola9GCC2r
         JlG6rF6zY4PQO2WeXHApSibFj59b101KPxGzmeNwuTSXNNulEqZTyAf+3HcB5MC4ETm3
         IsKg==
X-Forwarded-Encrypted: i=1; AJvYcCV5P1+RBxIAF1HPYNjkkK3wahpbmx94JowOY1cy7pWYOkiJ2wEessKnii+TZLSFtjx4moMi/Zt4t4Zq1a4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJhghe+raAqikLxC+gMHzHDZt461KEi2z+cPzYnhqSoJ1THfKv
	9kR3ISZMPT/bja5DLwbi6hCUSMG6hRTCrcoJwyyeJ6+X4zFZcTGVgq6YzO46RSefVok=
X-Gm-Gg: ASbGncvoUdCIIk71zMFvdrtUG8/2PvBkY7UssTjk/7wV7FFACZlfssh/11rkxg5rHtl
	uKRs2nufc7fG2vF+JehxlZyKajGoS8WgBx+J72LZTZ79rN97ZXzDoj9crtRpK4yZQspbqn0Km3v
	cHU0pi82xT6bqFM3aamXX/KjHgObc4oGm8J5YzDgVCllPBo0qM5u6dLzGLcqAp52+QFtaKQrpA3
	rqbc3d9PSXCRn9ITYZHDbfgpVaqFZfCu7ca8c4kZRNw6dyic/nyBx+qGlo4CUIMLlmdVrd9D4cF
	3OPdeVhNfrEMrH/JT7BDZZIOMcCDJNbkb/fIoyNSyWaSnAGADfdrkTlE8Oy6+jOSZx1sfOyjncG
	x+VqBEwEKNWFW+YJCAUka8OeAzEYeHS1Sw35cv0HEIW7KqamLeV3XYfW/eYrFnnoI6Ag4zbqNuh
	H46e19Zr6Olw==
X-Google-Smtp-Source: AGHT+IFvYs68Buuceqmom9cK+b3tmxRcvwX+RCf/RKksGGfS++c275PvWsJMjWEvnt8iSrFclv8Jzw==
X-Received: by 2002:a5d:64e9:0:b0:3c8:d236:26bd with SMTP id ffacd0b85a97d-3d1dc5a29d4mr7689830f8f.11.1756798450078;
        Tue, 02 Sep 2025 00:34:10 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:5c8d:8a1e:ea2b:c939? ([2a01:e0a:3d9:2080:5c8d:8a1e:ea2b:c939])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b7e8ab093sm192349435e9.22.2025.09.02.00.34.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Sep 2025 00:34:09 -0700 (PDT)
Message-ID: <b49e2a94-695e-42ec-99de-aed42e62572d@linaro.org>
Date: Tue, 2 Sep 2025 09:34:09 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 3/3] drm/panel: visionox-rm69299: Add backlight support
To: =?UTF-8?Q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>,
 Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 phone-devel@vger.kernel.org
References: <20250901-shift6mq-panel-v1-0-444b4abbfaea@sigxcpu.org>
 <20250901-shift6mq-panel-v1-3-444b4abbfaea@sigxcpu.org>
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
In-Reply-To: <20250901-shift6mq-panel-v1-3-444b4abbfaea@sigxcpu.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 01/09/2025 16:22, Guido Günther wrote:
> The shift6mq's variant supports controlling the backlight via DSI
> commands. Use that if a max_brightness is set in the device specific
> data.
> 
> Signed-off-by: Guido Günther <agx@sigxcpu.org>
> ---
>   drivers/gpu/drm/panel/panel-visionox-rm69299.c | 67 ++++++++++++++++++++++++++
>   1 file changed, 67 insertions(+)
> 
> diff --git a/drivers/gpu/drm/panel/panel-visionox-rm69299.c b/drivers/gpu/drm/panel/panel-visionox-rm69299.c
> index 2216d38366ea37368d15480f9d8a8ccbfe77ba3b..5e5ff6056c80e67a5bf8fe4911cdbc588db5d03b 100644
> --- a/drivers/gpu/drm/panel/panel-visionox-rm69299.c
> +++ b/drivers/gpu/drm/panel/panel-visionox-rm69299.c
> @@ -3,6 +3,7 @@
>    * Copyright (c) 2019, The Linux Foundation. All rights reserved.
>    */
>   
> +#include <linux/backlight.h>
>   #include <linux/delay.h>
>   #include <linux/module.h>
>   #include <linux/property.h>
> @@ -20,6 +21,8 @@ struct visionox_rm69299_panel_desc {
>   	const struct drm_display_mode *mode;
>   	const u8 *init_seq;
>   	unsigned int init_seq_len;
> +	int max_brightness;
> +	int initial_brightness;
>   };
>   
>   struct visionox_rm69299 {
> @@ -285,6 +288,63 @@ static const struct drm_panel_funcs visionox_rm69299_drm_funcs = {
>   	.get_modes = visionox_rm69299_get_modes,
>   };
>   
> +static int visionox_rm69299_bl_get_brightness(struct backlight_device *bl)
> +{
> +	struct mipi_dsi_device *dsi = bl_get_data(bl);
> +	u16 brightness;
> +	int ret;
> +
> +	dsi->mode_flags &= ~MIPI_DSI_MODE_LPM;
> +
> +	ret = mipi_dsi_dcs_get_display_brightness(dsi, &brightness);
> +	if (ret < 0)
> +		return ret;
> +
> +	dsi->mode_flags |= MIPI_DSI_MODE_LPM;
> +
> +	return brightness;
> +}
> +
> +static int visionox_rm69299_bl_update_status(struct backlight_device *bl)
> +{
> +	struct mipi_dsi_device *dsi = bl_get_data(bl);
> +	u16 brightness = backlight_get_brightness(bl);
> +	int ret;
> +
> +	dsi->mode_flags &= ~MIPI_DSI_MODE_LPM;
> +
> +	ret = mipi_dsi_dcs_set_display_brightness(dsi, brightness);
> +	if (ret < 0)
> +		return ret;
> +
> +	dsi->mode_flags |= MIPI_DSI_MODE_LPM;
> +
> +	return 0;
> +}
> +
> +static const struct backlight_ops visionox_rm69299_bl_ops = {
> +	.update_status = visionox_rm69299_bl_update_status,
> +	.get_brightness = visionox_rm69299_bl_get_brightness,
> +};
> +
> +static struct backlight_device *
> +visionox_rm69299_create_backlight(struct visionox_rm69299 *ctx)
> +{
> +	struct device *dev = &ctx->dsi->dev;
> +	const struct backlight_properties props = {
> +		.type = BACKLIGHT_RAW,
> +		.brightness = ctx->desc->initial_brightness,
> +		.max_brightness = ctx->desc->max_brightness,
> +	};
> +
> +	if (!ctx->desc->max_brightness)
> +		return 0;
> +
> +	return devm_backlight_device_register(dev, dev_name(dev), dev, ctx->dsi,
> +					      &visionox_rm69299_bl_ops,
> +					      &props);
> +}
> +
>   static int visionox_rm69299_probe(struct mipi_dsi_device *dsi)
>   {
>   	struct device *dev = &dsi->dev;
> @@ -316,6 +376,11 @@ static int visionox_rm69299_probe(struct mipi_dsi_device *dsi)
>   		return PTR_ERR(ctx->reset_gpio);
>   	}
>   
> +	ctx->panel.backlight = visionox_rm69299_create_backlight(ctx);
> +	if (IS_ERR(ctx->panel.backlight))
> +		return dev_err_probe(dev, PTR_ERR(ctx->panel.backlight),
> +				     "Failed to create backlight\n");
> +
>   	drm_panel_add(&ctx->panel);
>   
>   	dsi->lanes = 4;
> @@ -353,6 +418,8 @@ const struct visionox_rm69299_panel_desc visionox_rm69299_shift_desc = {
>   	.mode = &visionox_rm69299_1080x2160_60hz,
>   	.init_seq = (const u8 *)visionox_rm69299_1080x2160_60hz_init_seq,
>   	.init_seq_len = ARRAY_SIZE(visionox_rm69299_1080x2160_60hz_init_seq),
> +	.max_brightness = 255,
> +	.initial_brightness = 50,
>   };
>   
>   static const struct of_device_id visionox_rm69299_of_match[] = {
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

