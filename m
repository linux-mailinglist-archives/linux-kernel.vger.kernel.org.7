Return-Path: <linux-kernel+bounces-755375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB455B1A59E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 17:16:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53AD63AE8AA
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 15:16:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90CD11FDD;
	Mon,  4 Aug 2025 15:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QYvr2eC3"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10808C2FB
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 15:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754320582; cv=none; b=efSAu65R00L+blYnSHpAasoNGGlc98BRyPjcEvshoA2761Pic9O7DuW/wRonjfobKrBXgxJ/CANQtOPzIQJ+IBonPNBjhFEBF4IYYF3UqeaALivs93sAvNOUMnoS9gNGMAcj1oEKdR7uZ84QGggAq+nmyAbfzr1e13kDhaTvDLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754320582; c=relaxed/simple;
	bh=9YRdWSjdxgZIRwrd5rQDdKvT/vMdugq6cOXz9f33l+U=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=lxQx08XmtdW3TAsvwbQXpE0BmWnWlX1sFEnOUfgsjsduftfPUiOC/c1q6cVkd5rCqh8N6dwRB0RP5snfvkw9TZj5/XFiOS+eXft7YMNVPrtnT9/n+Gd4DYgsz7y4sgtezoxQuS0gjGwjB7KkQ1TzRBlM6E768O6XkxE6Cs3NTbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QYvr2eC3; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3b7920354f9so4088900f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 08:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754320579; x=1754925379; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ifdQYtMoMbUhaDaLztKpCS+6vqQS+9SK4PGyB6S6f3U=;
        b=QYvr2eC3aZt0lLXpkU2364elB7KrMOyC1AFYbnS6C/8pyPgBfhQEUpWulOoBNbL2nD
         PRL562VHB+Xiknr3u0VaKRETayA7m36Iph5ivRzUgrRB5ZyGythiHRjIQytj8Tgugwra
         hk2ElYUJsj3pPyHZy2m9jwhFWDLtMtuH0Pe9tSLAcst0ABvKCOB9enyQb2NCaZVle3JP
         PYp0yuQRRoo2fzupqHHLHu2GZ/h3Bm2aXs+mmgXHdCd+vgLjk61YaXmY+VkPF6qTWPJu
         yLmwO1zJ2nmbSB6Novjk4x+8YIgBcrIelooANlzuoPD5XSj0dKbhC3GYNEGZkmuTjxoS
         mKqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754320579; x=1754925379;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ifdQYtMoMbUhaDaLztKpCS+6vqQS+9SK4PGyB6S6f3U=;
        b=BE/qD29EPeeuFUuYVqgabORG7AmGb+BfjufPV7L8ituG1Z7thWjUUIh1rJvx8k/GdM
         4k8GyXAC0K5uwtfXVSq5AivAai/GLFY9Q83lUqSCjNHSPOp35ItWc0TJt0cgM7+bUNKy
         uX/BbyZaHUbMSFRxdKNYeKDnP/s4RAY6N305TufMvdVIKe/XY29MKFlTTiNgKpi+VUc0
         XQTE2IaZQ5n6jO8QEEtGaW8A3MNDFzm9p+Za58g5YO5zThAgy/4geQJ7cQFvwmSjKtBL
         jlCeGDCHEvKjSfm0lefYiEtx4bom+6w26Yckxt5CPW6qFa+zE17ARgJl7TAThuh9H/gp
         +Avw==
X-Forwarded-Encrypted: i=1; AJvYcCUTRLnAKwsnSmf8eVaxm0iwGW9i97ytFH26crQndhr740drCMv3CvHiyf9u8IfmY6TT7kQCHCqPyG+ygww=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3nw5Xk9PVHwZAPFZH11Bcjgjl2gWMIzPLz0vbOrGBCnNXcoGb
	CdLG86xXotGDbgQyhY7CAy0fznTzyrnv7WTVE+e3k5yzajlSvU0pS6WQjOvUMOvqeUs=
X-Gm-Gg: ASbGnctAYAMf+fybWe2N9sJqnvwTOy23xy1VxYa5eqkRkdwYum21dhDeHW2z0WUSzTA
	rs44JHJPub6y0K4FaXsLUm0uZFns8Q1khLjH1pIoj76nJ1NrjC6hDdMo/F8wtnqd801xCw0Obu2
	JFqgnkUIfYhXNDyAP9kVA0QBWBAYOE5KheI6jxUAaicJ00DHVzzbFpkuqWsObKPqz13Bo378mCU
	4TZaayyFRJc8fuMRmEkwBjDU8Z6ThKHgjH9x/otfS5l/4+rPI1bdg0b5/5WkjSuIuQIBCrZU1s7
	i4/qRsV69iIWmlBqYEowZv2J2vpBwlkIGf+DNnsd6Prx+zOOn0chR03gzBKzY/yjF3RWiIsjQX8
	CuWw4RqMGtk52u/O2f7ZCjez7zAO3pbfGhe5h4YKFp7okJX4xwyJWyT4q9/VhCXuYXWDvJebVsA
	w=
X-Google-Smtp-Source: AGHT+IHPPDD9D0qxXu9jHrNySpU2UAtNfOEP8mZOWyrtTy6JCiloSri0pkmDPr9668JfOlIhW9A5cA==
X-Received: by 2002:a05:6000:2881:b0:3b7:8146:4642 with SMTP id ffacd0b85a97d-3b8d9472439mr6472193f8f.20.1754320579282;
        Mon, 04 Aug 2025 08:16:19 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:3030:f63e:fedd:700f? ([2a01:e0a:3d9:2080:3030:f63e:fedd:700f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-458b73868a4sm99448145e9.11.2025.08.04.08.16.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Aug 2025 08:16:18 -0700 (PDT)
Message-ID: <a8c59d2c-4c4f-4eb8-a371-03c1169c479e@linaro.org>
Date: Mon, 4 Aug 2025 17:16:18 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 03/13] drm/panel: ilitek-ili9881c: convert (un-)prepare to
 mipi_dsi_multi_context
To: Heiko Stuebner <heiko@sntech.de>
Cc: quic_jesszhan@quicinc.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, hjc@rock-chips.com,
 andy.yan@rock-chips.com, andyshrk@163.com, nicolas.frattaroli@collabora.com,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org
References: <20250707164906.1445288-1-heiko@sntech.de>
 <20250707164906.1445288-4-heiko@sntech.de>
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
In-Reply-To: <20250707164906.1445288-4-heiko@sntech.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 07/07/2025 18:48, Heiko Stuebner wrote:
> This saves some lines for error handling.
> 
> For the address mode change, that value is always an u8, so switching
> to dcs_write_buffer function should be appropriate.
> 
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
>   drivers/gpu/drm/panel/panel-ilitek-ili9881c.c | 66 ++++++-------------
>   1 file changed, 21 insertions(+), 45 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-ilitek-ili9881c.c b/drivers/gpu/drm/panel/panel-ilitek-ili9881c.c
> index a20b52181ea0..154eea5f4d77 100644
> --- a/drivers/gpu/drm/panel/panel-ilitek-ili9881c.c
> +++ b/drivers/gpu/drm/panel/panel-ilitek-ili9881c.c
> @@ -1239,33 +1239,24 @@ static inline struct ili9881c *panel_to_ili9881c(struct drm_panel *panel)
>    * So before any attempt at sending a command or data, we have to be
>    * sure if we're in the right page or not.
>    */
> -static int ili9881c_switch_page(struct ili9881c *ctx, u8 page)
> +static void ili9881c_switch_page(struct mipi_dsi_multi_context *mctx, u8 page)
>   {
>   	u8 buf[4] = { 0xff, 0x98, 0x81, page };
> -	int ret;
> -
> -	ret = mipi_dsi_dcs_write_buffer(ctx->dsi, buf, sizeof(buf));
> -	if (ret < 0)
> -		return ret;
>   
> -	return 0;
> +	mipi_dsi_dcs_write_buffer_multi(mctx, buf, sizeof(buf));
>   }
>   
> -static int ili9881c_send_cmd_data(struct ili9881c *ctx, u8 cmd, u8 data)
> +static void ili9881c_send_cmd_data(struct mipi_dsi_multi_context *mctx, u8 cmd, u8 data)
>   {
>   	u8 buf[2] = { cmd, data };
> -	int ret;
>   
> -	ret = mipi_dsi_dcs_write_buffer(ctx->dsi, buf, sizeof(buf));
> -	if (ret < 0)
> -		return ret;
> -
> -	return 0;
> +	mipi_dsi_dcs_write_buffer_multi(mctx, buf, sizeof(buf));
>   }
>   
>   static int ili9881c_prepare(struct drm_panel *panel)
>   {
>   	struct ili9881c *ctx = panel_to_ili9881c(panel);
> +	struct mipi_dsi_multi_context mctx = { .dsi = ctx->dsi };
>   	unsigned int i;
>   	int ret;
>   
> @@ -1286,54 +1277,39 @@ static int ili9881c_prepare(struct drm_panel *panel)
>   		const struct ili9881c_instr *instr = &ctx->desc->init[i];
>   
>   		if (instr->op == ILI9881C_SWITCH_PAGE)
> -			ret = ili9881c_switch_page(ctx, instr->arg.page);
> +			ili9881c_switch_page(&mctx, instr->arg.page);
>   		else if (instr->op == ILI9881C_COMMAND)
> -			ret = ili9881c_send_cmd_data(ctx, instr->arg.cmd.cmd,
> -						      instr->arg.cmd.data);
> -
> -		if (ret)
> -			goto disable_power;
> -	}
> -
> -	ret = ili9881c_switch_page(ctx, 0);
> -	if (ret)
> -		return ret;
> -
> -	if (ctx->address_mode) {
> -		ret = mipi_dsi_dcs_write(ctx->dsi, MIPI_DCS_SET_ADDRESS_MODE,
> -					 &ctx->address_mode,
> -					 sizeof(ctx->address_mode));
> -		if (ret < 0)
> -			goto disable_power;
> +			ili9881c_send_cmd_data(&mctx, instr->arg.cmd.cmd,
> +					       instr->arg.cmd.data);
>   	}
>   
> -	ret = mipi_dsi_dcs_set_tear_on(ctx->dsi, MIPI_DSI_DCS_TEAR_MODE_VBLANK);
> -	if (ret)
> -		goto disable_power;
> -
> -	ret = mipi_dsi_dcs_exit_sleep_mode(ctx->dsi);
> -	if (ret)
> -		goto disable_power;
> +	ili9881c_switch_page(&mctx, 0);
>   
> -	msleep(120);
> +	if (ctx->address_mode)
> +		ili9881c_send_cmd_data(&mctx, MIPI_DCS_SET_ADDRESS_MODE,
> +				       ctx->address_mode);
>   
> -	ret = mipi_dsi_dcs_set_display_on(ctx->dsi);
> -	if (ret)
> +	mipi_dsi_dcs_set_tear_on_multi(&mctx, MIPI_DSI_DCS_TEAR_MODE_VBLANK);
> +	mipi_dsi_dcs_exit_sleep_mode_multi(&mctx);
> +	mipi_dsi_msleep(&mctx, 120);
> +	mipi_dsi_dcs_set_display_on_multi(&mctx);
> +	if (mctx.accum_err)
>   		goto disable_power;
>   
>   	return 0;
>   
>   disable_power:
>   	regulator_disable(ctx->power);
> -	return ret;
> +	return mctx.accum_err;
>   }
>   
>   static int ili9881c_unprepare(struct drm_panel *panel)
>   {
>   	struct ili9881c *ctx = panel_to_ili9881c(panel);
> +	struct mipi_dsi_multi_context mctx = { .dsi = ctx->dsi };
>   
> -	mipi_dsi_dcs_set_display_off(ctx->dsi);
> -	mipi_dsi_dcs_enter_sleep_mode(ctx->dsi);
> +	mipi_dsi_dcs_set_display_off_multi(&mctx);
> +	mipi_dsi_dcs_enter_sleep_mode_multi(&mctx);
>   	regulator_disable(ctx->power);
>   	gpiod_set_value_cansleep(ctx->reset, 1);
>   

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

