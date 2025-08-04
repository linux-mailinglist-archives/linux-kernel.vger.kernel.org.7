Return-Path: <linux-kernel+bounces-755374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C768AB1A59C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 17:16:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C36DD3ACE3B
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 15:15:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFFC521D590;
	Mon,  4 Aug 2025 15:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="znGLXXip"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDBAF21C9E7
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 15:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754320547; cv=none; b=Y2H+BvzbU8J0vZis84BDqgFq25GbxgpbKsSOIKuqvGQdklL7AA5PWz4C9g7/0NH71fmahBRsbu9imo/sweAKqkfEhjA0xr9fhqPYRZmgJt+4O0XhH5Zj5CtbQDxBDi/eDJuhmd7jH9km7PXT3L4cnHV3m4O2A3JOiugMYkot3TQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754320547; c=relaxed/simple;
	bh=FS/FFxGKTYfI3IfnDcjGHM6goIVdaC0gmyiuU1wiKjc=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=IwSt/sxSpUKFraRs1+YSUOIMn0OEE/QR517B2kzBIoEk3A+6ifenEictiaJIPomvqmtky1POfF+ZI7WnRRI73dLju6ReIA6sIs9RsZIVkeyMlgE8wbJOVk0f1qkwU7JsDs9KjtASxwvWkJlSVNmoiGYxZ+9+u2yS6Zh7zXDRlTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=znGLXXip; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-458bece40fcso10082045e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 08:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754320543; x=1754925343; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CMYiRXMoedjydkMWi7aq5mntKyVVNxUPoNVSwHHbIuI=;
        b=znGLXXipoZuJNWhfIPam6EAdxU7n61uqtYhy+t1uw82zP1Td/02OmuNqwO++FEBUaz
         J3NrrUVsE65DPvFiSvQkg0N6J5WT9XUIU9eFwOGbKkYPPVdA00cKsfDEIwK0RJevc/dX
         hF3kJcI+8snRmUR9Q+JML1WwTMBi9krI1FS9MfrPrjQyjKAvboG8x9bQNBH2YGa+IDvb
         5DzMkJJRMzbEfXDmRR12aTz7pvv0VIxxyRPlfnwLeC08Ar5sjpmWbNazMGmbMsT02kJQ
         xCmCTyW/puMNXYEOD8YWR2vjP0HCeD0dvgDuhEB+BDaPN0FEKqV51lqunvdmzl2TEcB/
         0FIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754320543; x=1754925343;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CMYiRXMoedjydkMWi7aq5mntKyVVNxUPoNVSwHHbIuI=;
        b=JxxLzioI6tA1qmBrcM50rXJphxCo04kZY7PuiNTZkg+WJk57WfsxNTIaumvWlxThmE
         GY3ESApCvgwXpOBPPBEWN7d7xX/hPVnssCXNuqiQbUSUdxGHzDg3bwEMyMu9fKI9d5jQ
         SfOzLTzxwFSyLSMl/nItBEgDmuAMqPcx1fGZ55PIXsquhBlctiJEEK3UzcjUe0oRaoHp
         YE8h89uMmrQX8ut4wvGtySbgqTU2M20FLowQz3W1zGMBRcvlBFc5OApeJB8vshi1H+EE
         xzi5phE+QIB5DdpXpRjBenKQ0EnFGXsCTTqLluZnirFQJsjLBOV0BU5TKYOgrllix31/
         FHIQ==
X-Forwarded-Encrypted: i=1; AJvYcCX94rT0wXBcoVIJhjP0lJtXvwfqPLfXsU8BYPp1HpWiZDyVwYvjLTJK0h8iqDMckauBRe8/EVWvPxPhMsM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7C+hhKrZHx2WKwYxOYmlLsT50QR968ihEloT2C+0rdakkOy0y
	MJJmNf4qIL2gMRtHksDjm5uJSvoIY0dJwgARV4TwDOr3KNL21p3hyb7F6UGd0KCYmEs=
X-Gm-Gg: ASbGncvoIvp14maMuSO39hkh/K30RiD+HldBfoDet65mLQa1thnB6bBofHg4g4KF917
	5v9sMwxnX7cdQyEiVfzlNx4iGOXJ+4Eg665Nq3A7Iqeu+QOfQJZRutxLbdWqGkULTMUgoYluwmo
	/mCe8XGXdhF8ExJnzLf8e3dPMj4EUQKNaabSXyj2V5B7ThVX/PMCW+ATmuhyZVv/fq5/BNrPkJx
	vIxsIudbVaq/ZjXNgyZVwd52vbR68+yWZnH5caiP8lYi7ai7Oxph+axWKvy178oosaU31OxZGhw
	TP96+9Ntysuq3rj4VvhU4WcZ7yAh4gGShFaMsBgN7+bo2OY+FlY4X3eU8qKoTVrQYXHJIa5YnFc
	7PcmdrZsbhb2wrYMBkMFs6WYCKBd9O+5F8/kJwSWYF+45oqLYQcFYFQM9H6A2eOXkYDWuCr52ge
	DjfFpZG+3PIjKEOBc8SGuY
X-Google-Smtp-Source: AGHT+IEr6cmOOwDSjxgdpQtx4m7PijiOu0vwQxDdoA1/nkq5lSHu7HpzwGQERaUKnohUCx/+2yzIag==
X-Received: by 2002:a05:600c:4f08:b0:459:dfa8:b854 with SMTP id 5b1f17b1804b1-459dfa8bb6dmr14866075e9.5.1754320542960;
        Mon, 04 Aug 2025 08:15:42 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:3030:f63e:fedd:700f? ([2a01:e0a:3d9:2080:3030:f63e:fedd:700f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4589edf5638sm171780825e9.4.2025.08.04.08.15.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Aug 2025 08:15:42 -0700 (PDT)
Message-ID: <16537c3f-824a-4268-a51e-5efc88a671bf@linaro.org>
Date: Mon, 4 Aug 2025 17:15:41 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 02/13] drm/panel: ilitek-ili9881c: move display_on/_off
 dcs calls to (un-)prepare
To: Heiko Stuebner <heiko@sntech.de>
Cc: quic_jesszhan@quicinc.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, hjc@rock-chips.com,
 andy.yan@rock-chips.com, andyshrk@163.com, nicolas.frattaroli@collabora.com,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org
References: <20250707164906.1445288-1-heiko@sntech.de>
 <20250707164906.1445288-3-heiko@sntech.de>
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
In-Reply-To: <20250707164906.1445288-3-heiko@sntech.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 07/07/2025 18:48, Heiko Stuebner wrote:
> At least for panel-bridges, the atomic_enable call is defined as being
> called right after the preceding element in the display pipe is enabled.
> 
> It is also stated that "The bridge can assume that the display pipe (i.e.
> clocks and timing signals) feeding it is running when this callback is
> called"
> 
> This means the DSI controller driving this display would have already
> switched over to video-mode from command mode and thus dcs functions
> should not be called anymore at this point.
> 
> This caused a non-working display for me, when trying to enable
> the rk3576 dsi controller using a display using this controller.
> 
> Therefore move the display_on/off calls the more appropriate
> prepare/unprepare callbacks.
> 
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
>   drivers/gpu/drm/panel/panel-ilitek-ili9881c.c | 27 +++++--------------
>   1 file changed, 7 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-ilitek-ili9881c.c b/drivers/gpu/drm/panel/panel-ilitek-ili9881c.c
> index d7a17dca2a9c..a20b52181ea0 100644
> --- a/drivers/gpu/drm/panel/panel-ilitek-ili9881c.c
> +++ b/drivers/gpu/drm/panel/panel-ilitek-ili9881c.c
> @@ -1315,35 +1315,24 @@ static int ili9881c_prepare(struct drm_panel *panel)
>   	if (ret)
>   		goto disable_power;
>   
> -	return 0;
> -
> -disable_power:
> -	regulator_disable(ctx->power);
> -	return ret;
> -}
> -
> -static int ili9881c_enable(struct drm_panel *panel)
> -{
> -	struct ili9881c *ctx = panel_to_ili9881c(panel);
> -
>   	msleep(120);
>   
> -	mipi_dsi_dcs_set_display_on(ctx->dsi);
> +	ret = mipi_dsi_dcs_set_display_on(ctx->dsi);
> +	if (ret)
> +		goto disable_power;
>   
>   	return 0;
> -}
>   
> -static int ili9881c_disable(struct drm_panel *panel)
> -{
> -	struct ili9881c *ctx = panel_to_ili9881c(panel);
> -
> -	return mipi_dsi_dcs_set_display_off(ctx->dsi);
> +disable_power:
> +	regulator_disable(ctx->power);
> +	return ret;
>   }
>   
>   static int ili9881c_unprepare(struct drm_panel *panel)
>   {
>   	struct ili9881c *ctx = panel_to_ili9881c(panel);
>   
> +	mipi_dsi_dcs_set_display_off(ctx->dsi);
>   	mipi_dsi_dcs_enter_sleep_mode(ctx->dsi);
>   	regulator_disable(ctx->power);
>   	gpiod_set_value_cansleep(ctx->reset, 1);
> @@ -1499,8 +1488,6 @@ static enum drm_panel_orientation ili9881c_get_orientation(struct drm_panel *pan
>   static const struct drm_panel_funcs ili9881c_funcs = {
>   	.prepare	= ili9881c_prepare,
>   	.unprepare	= ili9881c_unprepare,
> -	.enable		= ili9881c_enable,
> -	.disable	= ili9881c_disable,
>   	.get_modes	= ili9881c_get_modes,
>   	.get_orientation = ili9881c_get_orientation,
>   };

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

