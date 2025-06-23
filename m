Return-Path: <linux-kernel+bounces-698320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2086DAE4072
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jun 2025 14:35:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2D37164580
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jun 2025 12:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD1D9244698;
	Mon, 23 Jun 2025 12:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F/Uau7QR"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 684FD23D2AE
	for <linux-kernel@vger.kernel.org>; Mon, 23 Jun 2025 12:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750681914; cv=none; b=pmWeCNvmj7OkbxqEGvhu2i88RcFFi7fFz3ltEgSSS0SEqSTtQIdPVmA6rPhdHYFrIDiJeeYTI/yyfldLyYNlD3Gopn81jvP6uR+JxKbBAfGAEJdXZ6qvywRWMCx4TZUFzxoQkXiWiXmECRdC8w27GFN7IygmLiPkVkae3Fuh3Ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750681914; c=relaxed/simple;
	bh=TaUyQeKYhgc4zl+3DnQxYD5JvJEoSa1gSj88BTfllVU=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=XoV8Nh3KmabYHXBwoOwSdHOrpO3EPKYy0A49K6eQQJbGGf2GSt8ElS5EFfP9s9x7RLwoIyljl7kIjUvwO78CSMrret8JKeOEEwha45iJuRwo890U8K6m9uqXS116NjURPT6Boh9Kuwp4ckCSa8+/1gr0w9EejpP5CjA5/EUf5Mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=F/Uau7QR; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3a589d99963so4035220f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jun 2025 05:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750681911; x=1751286711; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5BsUESEJVffI4oZaO5RphZPRSePWRjkMtfmD/4yLa1A=;
        b=F/Uau7QRViVvv2u0RCnLiOJ5MHkiwVjLVcKlxn8Tyemk96Q6fXuQtBCLtssQx9Pkod
         RhDGogONkozQvvp6gls2rb/nxYvNNDf5EC3RAjIsMg1lJZb575DxsrSGsWbij+q2EP8Y
         j3dl85MDGnas41/YmalI0WV+M69aXEU4LZdJlXo+rBkg2yYuajEe4PoSuRjTqbWxhq2K
         5CX+wu5bXumtD9QhTC3y/bGxb3LyfHzg4Dg/KCXcZPkJpZeFqkvw31wKdac3c4j7KW4K
         UjSU3VaOMQk9vTuQ9anzxWJluhY2Ci1TuDeruz+vcJ+NIFpoBR5CLvy03CPmf99RU/Eg
         RjQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750681911; x=1751286711;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5BsUESEJVffI4oZaO5RphZPRSePWRjkMtfmD/4yLa1A=;
        b=ZQEiono7kMqIxRpBgTlOAxy1Kw1DtifDaWKECv7h65l20YrQBd1AgpabcIms8K6/GK
         6teshZVElsiKlylXATD/X3Rms19b5tup8LTM71lTeGtSj1zrOJpv/xe8UjIxecqHnG/R
         nx6Q2EifUusRaUTTEHHyVNn4y9K0LEUzE7I/Fhi/hk1q18tjUuvy2f/q0S0XNbKoCiTu
         pH7bZQ1Uq+XKSrkefFMBcYO6XLcH3Bqgv8FBJjCNQJUq02BTOMggHF7XbOWLhHf0Gmuf
         y8fFN9hhEhADMcgDRpg5IoG9488WhMxhNjvbkSazrbaowYkEPsNLA2Ho4mvPS3tC53z3
         2YWw==
X-Forwarded-Encrypted: i=1; AJvYcCWSmtbcelAdsDEUqh3ERAG2V7g3ImV1sFGB/P7h/nmiS3ncm9ZZ9imD/RDGDFHQeT8yzqY5WAIXCKixw7A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJATydLYaxwOEDR85UF5b4nrB0gjRO+sdP0TVAUD+Xw5LYtM7y
	HjGYtvTbcGp+f3Iuca54wpEBwzK8R8a7hxP3fsLOLTGoSaeAiKODt4Hj+8zu7thVSHo=
X-Gm-Gg: ASbGncuW264QqZNswM5PM2Ja0n7Dx0L4b2rWEJGjbm3C+vTBTe8JGfkCiXUunekRpRC
	UWpNkycfmnB40l7iCVBM2r2fc6ftheRd7YGNO0nAet2SK2lEIKyLd4r3RGRhHyuYNS/JvnOq9iU
	eM06CvM8YoAQEGx9QCL9l6famCp2uiwaHUZJxobKKiwV+M64KEJlhf3hKPH0bMz84Fbkt4pKJOI
	0gmz8jElyBgutMhhoUYNDyoK7ds16NSOgqE9QKK1O3iVXs+wGtBYhF65CIjlKLVT57nC3WAaFER
	Zd0QJGJXmPIctuPxuIQM7feLt7ozJJT7ygJMvPbhM6WUd/GsjZF54RaLKH7ZcN9SCXxSQRjnZsP
	CQrRNCK+U5q6KLuYM7yArcAxbkRl21hq40CteAJE=
X-Google-Smtp-Source: AGHT+IHaPhLV7BB64wJ54i+PRTDFMAI1xBSKbX9CFXttTtVDg0OzsIpGIzpsgLpaaXop+qHd9i2Kdw==
X-Received: by 2002:a05:6000:2902:b0:3a4:d367:c591 with SMTP id ffacd0b85a97d-3a6d128a58fmr9608741f8f.10.1750681910714;
        Mon, 23 Jun 2025 05:31:50 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:8c08:7c51:bbb1:5a2d? ([2a01:e0a:3d9:2080:8c08:7c51:bbb1:5a2d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a6d0f19e7dsm9599607f8f.38.2025.06.23.05.31.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jun 2025 05:31:50 -0700 (PDT)
Message-ID: <6070afbd-39f8-4f60-9230-794889e7012e@linaro.org>
Date: Mon, 23 Jun 2025 14:31:49 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH] drm/bridge: panel: move prepare_prev_first handling to
 drm_panel_bridge_add_typed
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Andrzej Hajda <andrzej.hajda@intel.com>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 Jagan Teki <jagan@amarulasolutions.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Svyatoslav Ryhel <clamor95@gmail.com>
References: <20250220-panel_prev_first-v1-1-b9e787825a1a@linaro.org>
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
In-Reply-To: <20250220-panel_prev_first-v1-1-b9e787825a1a@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20/02/2025 16:07, Dmitry Baryshkov wrote:
> The commit 5ea6b1702781 ("drm/panel: Add prepare_prev_first flag to
> drm_panel") and commit 0974687a19c3 ("drm/bridge: panel: Set
> pre_enable_prev_first from drmm_panel_bridge_add") added handling of
> panel's prepare_prev_first to devm_panel_bridge_add() and
> drmm_panel_bridge_add(). However if the driver calls
> drm_panel_bridge_add_typed() directly, then the flag won't be handled
> and thus the drm_bridge.pre_enable_prev_first will not be set.
> 
> Move prepare_prev_first handling to the drm_panel_bridge_add_typed() so
> that there is no way to miss the flag.
> 
> Fixes: 5ea6b1702781 ("drm/panel: Add prepare_prev_first flag to drm_panel")
> Fixes: 0974687a19c3 ("drm/bridge: panel: Set pre_enable_prev_first from drmm_panel_bridge_add")
> Reported-by: Svyatoslav Ryhel <clamor95@gmail.com>
> Closes: https://lore.kernel.org/dri-devel/CAPVz0n3YZass3Bns1m0XrFxtAC0DKbEPiW6vXimQx97G243sXw@mail.gmail.com/
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>   drivers/gpu/drm/bridge/panel.c | 5 +----
>   1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/panel.c b/drivers/gpu/drm/bridge/panel.c
> index c57036b06493a6922e2cae38bcd1733930ff0073..ed23de0478312a26a5d3434e63bd2fe4a6099bfc 100644
> --- a/drivers/gpu/drm/bridge/panel.c
> +++ b/drivers/gpu/drm/bridge/panel.c
> @@ -302,6 +302,7 @@ struct drm_bridge *drm_panel_bridge_add_typed(struct drm_panel *panel,
>   	panel_bridge->bridge.of_node = panel->dev->of_node;
>   	panel_bridge->bridge.ops = DRM_BRIDGE_OP_MODES;
>   	panel_bridge->bridge.type = connector_type;
> +	panel_bridge->bridge.pre_enable_prev_first = panel->prepare_prev_first;
>   
>   	drm_bridge_add(&panel_bridge->bridge);
>   
> @@ -416,8 +417,6 @@ struct drm_bridge *devm_drm_panel_bridge_add_typed(struct device *dev,
>   		return bridge;
>   	}
>   
> -	bridge->pre_enable_prev_first = panel->prepare_prev_first;
> -
>   	*ptr = bridge;
>   	devres_add(dev, ptr);
>   
> @@ -459,8 +458,6 @@ struct drm_bridge *drmm_panel_bridge_add(struct drm_device *drm,
>   	if (ret)
>   		return ERR_PTR(ret);
>   
> -	bridge->pre_enable_prev_first = panel->prepare_prev_first;
> -
>   	return bridge;
>   }
>   EXPORT_SYMBOL(drmm_panel_bridge_add);
> 
> ---
> base-commit: 8936cec5cb6e27649b86fabf383d7ce4113bba49
> change-id: 20250220-panel_prev_first-fc90c6c8aefa
> 
> Best regards,

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

