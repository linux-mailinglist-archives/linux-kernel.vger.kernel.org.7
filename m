Return-Path: <linux-kernel+bounces-879918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E0B8C24643
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 11:17:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 816B93A431E
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 10:15:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9736933DEC2;
	Fri, 31 Oct 2025 10:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="i1ngeOiu"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA0D033C508
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 10:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761905729; cv=none; b=qUOE2N+gUFgyNszF0sp5tC8oDkpGCzklyOV6hw21D9LoewUTLSD6T99STGY8jwX2oRmEuO9t6mHDfw0AV04slh1Q+9OK/1puoP1R8vTBoSJKDIjB4pbglDdvChiIG7GZP1sdlTCRUUihe7dk59y6GA43vOMJ3XoIBryeGbq47kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761905729; c=relaxed/simple;
	bh=SXqMJ6ZvizBcruBMmLuzkxA4/jxcW047LcnByCtXJ4c=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=FeyD2IixO8nHs+FjN7YZ7LeThYK4gZZRy9ZLj6VElPmUXkDKAlDJtMrXjMawET4SdFzBIjYIstsW5fE2DquWfvKUDx715Aqr3uzrhhxFOypPCvf4+icovKwTm+LUu9qEfVeUxUyzyZd2RkjTo8i/03+Te6g5kcq531YJ6zgdw2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=i1ngeOiu; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-471b80b994bso25743305e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 03:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761905726; x=1762510526; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eE+d1cXEHqkcosUss1w2NBrOE9cjfyKKBw4l7rwMmp0=;
        b=i1ngeOiuHQ9+h+YpzlKT0cQXbFsRK3lrL5HIronZZeql8/X/0HuelLT/Av5wovyZCc
         d+/pxMZSillIeSzk83f9DbbfHm9BuooYBaNRqwMhXTxD0OVOnpUsMZGqY7jAzQqYxMVq
         RvBW7l7sYD7Ovrlp66SMgPJFO40KN1RTle+w127uTXIt6CclbwF3LlpIvft+7b2OF5TG
         oqBsm0OawT/H+s08WXvHHywx5YDR+2seh8t5KnxpJGAjStz2rKMllHn1GzdLTPsAhSmL
         UrXOklcaWpW64eCR5BpAOlFJZvwbyD0I4yMoHp+wLT+o98FUDO8FY+AOeB4Cp2lGnFNJ
         7c0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761905726; x=1762510526;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=eE+d1cXEHqkcosUss1w2NBrOE9cjfyKKBw4l7rwMmp0=;
        b=F7/6goOSjdZAnbFsc/b61AJdn6XjN/y3jb0SWrd9YWZeAcJeObsa45usOESCmnHeHn
         GU3E7Jrkx1QWInfG7wECgID0yAlQ6szM3RVWoAVVpcQS+kMtm3DCjzBEeSPlaKXf/mE/
         XRunkjT/F5zgKZ/dGyQRVjtOwyhMx7CVX3grRjfPyfQM+FBEnJzOzuTfUXc1IdQP/bF1
         qN+O/LzrpLb8oa2bFZtdESJy+5nJQZc0rMiF+ehW/YA1FwsXl0N6Z8h9h54oR7HvrZyB
         4znQWCgFoL4az13GeUEZfBP+mA5XdHw7lRqJzITZ+2yQYtHKRHM19T+Y2U6XcPb4M+8w
         RlXQ==
X-Forwarded-Encrypted: i=1; AJvYcCVEmLg1U13iVyIux7xAEEWM3CisPG47hsTjFczIOnpkZ6+gSowDdJq20J0SbgtrvtcrPDU+pXkWq8g1v90=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9lfl/6K2o37LwqcKlUKSOXLP+fcPUQ7vHwJS3MCcosPADqDx+
	ADbG9RZ/vQkIs0FleX0oaEPIOognpAGDjTF1bj9orKad603XP3+QQvzmLdui60H5Sy4=
X-Gm-Gg: ASbGncvNo18bT/nXcE1nvvLXCswsF3pn9A7HJ711cEkmUy2I4BVHeeBLPVY+mRt7WK0
	rnzgBvT04kvBrrL1UkMt3u54vkp8vVqmIwn2iLCFqgoMVUAqUFATqCd7HG9cap3OBMnX+MaR0iO
	+MxYl6FcIcfuMkbUmr4Vetpl7z9BcXzYyYr8FAK03ljIzPFkV42ZK3H64cNl6WJYoNf0AsUhERi
	aGOunL+RriPrMDtpuLaxvBnNWnuMiHjLNIo11kQTfDM/7pfaxmdA7ruUiQzJy5VRXYlaS6cxHAQ
	UM1vfZemtE0fNReo0HF0ZQtKNRr/+QQihHCPp6rHAptdQqBRSYwz1WCvnfWt5Ul3IZBhyX0NjyL
	Uz5+PTb/JdcoaW6LulufGNhV10i8nHh+yazfokOK0SxoC7o2s70vDu74DHUWqt7X+OIpyCYpIt1
	LeEHOZTSSNXiMVhsTB01aDpDX4QrfcZI3Gjkn2XtO0pzm6brqI8mijjGXCBKmyipfIVG+ggkMZj
	Q==
X-Google-Smtp-Source: AGHT+IEab5HAlvx0nr1OP9Rq6E4OTz6yEzuNxeSysSuw13E9/5p8UkZsu+Z/wlfJOqSRybyRR7JOsg==
X-Received: by 2002:a05:600c:848f:b0:477:25b9:3917 with SMTP id 5b1f17b1804b1-477308b1aa4mr25211875e9.39.1761905726051;
        Fri, 31 Oct 2025 03:15:26 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:cad:2140:d967:2bcf:d2d0:b324? ([2a01:e0a:cad:2140:d967:2bcf:d2d0:b324])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429c13e16f4sm2828576f8f.27.2025.10.31.03.15.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Oct 2025 03:15:25 -0700 (PDT)
Message-ID: <7642d4ba-72fe-4af7-a02a-96676f8945af@linaro.org>
Date: Fri, 31 Oct 2025 11:15:25 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v5 2/2] drm/panel: ilitek-ili9882t: Add support for Ilitek
 IL79900A-based panels
To: Langyan Ye <yelangyan@huaqin.corp-partner.google.com>, airlied@gmail.com,
 simona@ffwll.ch, maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, dianders@chromium.org
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251031100447.253164-1-yelangyan@huaqin.corp-partner.google.com>
 <20251031100447.253164-3-yelangyan@huaqin.corp-partner.google.com>
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
In-Reply-To: <20251031100447.253164-3-yelangyan@huaqin.corp-partner.google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/31/25 11:04, Langyan Ye wrote:
> The Ilitek IL79900A display controller is similar to the ILI9882T and can
> be supported within the existing `panel-ilitek-ili9882t.c` driver.
> 
> This patch extends the ILI9882T driver to handle IL79900A-based panels,
> such as the Tianma TL121BVMS07-00. The IL79900A uses a similar command
> sequence and initialization flow, with minor differences in power supply
> configuration and timing.
> 
> Signed-off-by: Langyan Ye <yelangyan@huaqin.corp-partner.google.com>
> ---
>   drivers/gpu/drm/panel/panel-ilitek-ili9882t.c | 69 +++++++++++++++++++
>   1 file changed, 69 insertions(+)
> 
> diff --git a/drivers/gpu/drm/panel/panel-ilitek-ili9882t.c b/drivers/gpu/drm/panel/panel-ilitek-ili9882t.c
> index 85c7059be214..c52f20863fc7 100644
> --- a/drivers/gpu/drm/panel/panel-ilitek-ili9882t.c
> +++ b/drivers/gpu/drm/panel/panel-ilitek-ili9882t.c
> @@ -61,6 +61,13 @@ struct ili9882t {
>   	mipi_dsi_dcs_write_seq_multi(ctx, ILI9882T_DCS_SWITCH_PAGE, \
>   				     0x98, 0x82, (page))
>   
> +/* IL79900A-specific commands, add new commands as you decode them */
> +#define IL79900A_DCS_SWITCH_PAGE	0xFF
> +
> +#define il79900a_switch_page(ctx, page) \
> +	mipi_dsi_dcs_write_seq_multi(ctx, IL79900A_DCS_SWITCH_PAGE, \
> +				     0x5a, 0xa5, (page))
> +
>   static int starry_ili9882t_init(struct ili9882t *ili)
>   {
>   	struct mipi_dsi_multi_context ctx = { .dsi = ili->dsi };
> @@ -413,6 +420,38 @@ static int starry_ili9882t_init(struct ili9882t *ili)
>   	return ctx.accum_err;
>   };
>   
> +static int tianma_il79900a_init(struct ili9882t *ili)
> +{
> +	struct mipi_dsi_multi_context ctx = { .dsi = ili->dsi };
> +
> +	mipi_dsi_usleep_range(&ctx, 5000, 5100);
> +
> +	il79900a_switch_page(&ctx, 0x06);
> +	mipi_dsi_dcs_write_seq_multi(&ctx, 0x3e, 0x62);
> +
> +	il79900a_switch_page(&ctx, 0x02);
> +	mipi_dsi_dcs_write_seq_multi(&ctx, 0x1b, 0x20);
> +	mipi_dsi_dcs_write_seq_multi(&ctx, 0x5d, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(&ctx, 0x5e, 0x40);
> +
> +	il79900a_switch_page(&ctx, 0x07);
> +	mipi_dsi_dcs_write_seq_multi(&ctx, 0X29, 0x00);
> +
> +	il79900a_switch_page(&ctx, 0x06);
> +	mipi_dsi_dcs_write_seq_multi(&ctx, 0x92, 0x22);
> +
> +	il79900a_switch_page(&ctx, 0x00);
> +	mipi_dsi_dcs_exit_sleep_mode_multi(&ctx);
> +
> +	mipi_dsi_msleep(&ctx, 120);
> +
> +	mipi_dsi_dcs_set_display_on_multi(&ctx);
> +
> +	mipi_dsi_msleep(&ctx, 80);
> +
> +	return 0;
> +};
> +
>   static inline struct ili9882t *to_ili9882t(struct drm_panel *panel)
>   {
>   	return container_of(panel, struct ili9882t, base);
> @@ -529,6 +568,19 @@ static const struct drm_display_mode starry_ili9882t_default_mode = {
>   	.type = DRM_MODE_TYPE_DRIVER | DRM_MODE_TYPE_PREFERRED,
>   };
>   
> +static const struct drm_display_mode tianma_il79900a_default_mode = {
> +	.clock = 264355,
> +	.hdisplay = 1600,
> +	.hsync_start = 1600 + 20,
> +	.hsync_end = 1600 + 20 + 4,
> +	.htotal = 1600 + 20 + 4 + 20,
> +	.vdisplay = 2560,
> +	.vsync_start = 2560 + 82,
> +	.vsync_end = 2560 + 82 + 2,
> +	.vtotal = 2560 + 82 + 2 + 36,
> +	.type = DRM_MODE_TYPE_DRIVER | DRM_MODE_TYPE_PREFERRED,
> +};
> +
>   static const struct panel_desc starry_ili9882t_desc = {
>   	.modes = &starry_ili9882t_default_mode,
>   	.bpc = 8,
> @@ -543,6 +595,20 @@ static const struct panel_desc starry_ili9882t_desc = {
>   	.init = starry_ili9882t_init,
>   };
>   
> +static const struct panel_desc tianma_tl121bvms07_desc = {
> +	.modes = &tianma_il79900a_default_mode,
> +	.bpc = 8,
> +	.size = {
> +		.width_mm = 163,
> +		.height_mm = 260,
> +	},
> +	.lanes = 3,
> +	.format = MIPI_DSI_FMT_RGB888,
> +	.mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_SYNC_PULSE |
> +		      MIPI_DSI_MODE_LPM,
> +	.init = tianma_il79900a_init,
> +};
> +
>   static int ili9882t_get_modes(struct drm_panel *panel,
>   			      struct drm_connector *connector)
>   {
> @@ -680,6 +746,9 @@ static const struct of_device_id ili9882t_of_match[] = {
>   	{ .compatible = "starry,ili9882t",
>   	  .data = &starry_ili9882t_desc
>   	},
> +	{ .compatible = "tianma,tl121bvms07-00",
> +	  .data = &tianma_tl121bvms07_desc
> +	},
>   	{ /* sentinel */ }
>   };
>   MODULE_DEVICE_TABLE(of, ili9882t_of_match);

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

