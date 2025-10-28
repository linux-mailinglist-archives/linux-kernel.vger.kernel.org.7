Return-Path: <linux-kernel+bounces-873449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E0CFC13F44
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 10:57:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2D24C50035C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 09:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95C9A3016F8;
	Tue, 28 Oct 2025 09:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jkGqoYfT"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08DC2302CC2
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 09:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761645233; cv=none; b=Zm5fr9TbtKKjqsxHbdXtX+hmY3nu66UOs5cwWQDXHaG8ZIX+9t2uWx1cUsrb6VwAGg93JJMIb8LOvkAEDhVbvorEuOK30kXXYmHkwB4/ckTPia6V4XBtgvAfZSbXHAVOdbs+Pj20ZVdJGexHpmLxang+wQ6BBbwkReYQOq6LPLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761645233; c=relaxed/simple;
	bh=L40eWwxPkCYUpMmLkv9h8QruB34rpCY3EV+gN9QOtWk=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=UMuv4xV5kO2CVEOEgIgVC2T2JlqMI7QdqrpfECVxVujxST1HBPRlXp6isa3nSIt8XogIGrW1oLEYTLA5dnF+n9jnP5DFjnNaXgpcoy0pxlITdzFSeUkCYn6TpKxTg17xUL6Y+52YFpQgbQW7psP34CHbbMMkHu2YVKPxG/H/T38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jkGqoYfT; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4711b95226dso71553175e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 02:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761645230; x=1762250030; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8I8yp/MiZ7ri17yJV9kzL93n+BFpQFCc+/QSsi4tVMs=;
        b=jkGqoYfTyqWGuiiBYryZXuCtMwXHvUUAGdIk1RJkXECQfS6RyTr1kjVZBCHQ+QB7Id
         E8BGN8h9mJfr5k4y1ew8ibQQ5nDF7AMTBHnnOGdNZho3gMi/jSMT0JButOeevwpgo1N5
         DZxSqFPMGbcVN4EV4MMoM8LQQSre4UG3rDJD05cLl/vKoVAnuUNweTal0RPo3berC/w+
         FOvfsP17st3eE6Rm19bCxoLliTFh3LdY49w1DuT/aVnRN4mTh/Ayq7b+PY/vUb/VAiZK
         MvGeHniD0uIZ61edWc8uFWQgN85X97v2pkdwyCKUoTm8D2Z+GKH+U4GAp6VzLJpJdsc8
         Afcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761645230; x=1762250030;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8I8yp/MiZ7ri17yJV9kzL93n+BFpQFCc+/QSsi4tVMs=;
        b=Tzk54k8q/2AxDLDXYVBUt9ozUQrzEUlLwO76FPf/GxgeA19wR97VnDrPfpT0qh33Ae
         Th1PDKq8ci8eVEQKVY1H7XUrZmHh/CWikXfxB7eCBurJztguCfIsID9X70/3TNI3D0++
         Zlir5kxYNHP4RPfv3BWMZFGDmYYKsUdagzFuskDJOqZl5lqdPXuIov9/vCUMcrocQQAq
         YeZjFwvAjYi8DC5TUB3c4HP+m1c05KvoTXpPisT5/VCaH+lCBrYaPjOFuGYJqjmoY4P9
         s+zObY4xsyWDy/smEZX4v2v1IHQKxi0ltNd0GeAEn9Rzj+pWw6DUG1PjqJECDA59hU4K
         IDyw==
X-Forwarded-Encrypted: i=1; AJvYcCXYeX1PhTgzUJ1BdnlxfOpMAipftSmLCeuhT7DRRxpqFuBCGySW+uBsM7UetoyS5vbaEH/C1ynckPkYluM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVpfjbUwE99UGlQVFxHIb6X4mIWRPqWfNDa9q6ccjse9Pr1uIm
	/36RlNkGtSZZdsVjeIP+wqRlvaahGCSXWPNk39aSWhrFQD3vMZyNyiWDH+6CE7/yr+0=
X-Gm-Gg: ASbGncuYzVQNucsVT9knmoti3Mr9TfeNEj3+4dc6/fOHxY3ZUh1Zl09zFnfTlRbYW7E
	vPnfqOc/ityVuC9Uuom6Kgp6jzP3jUCBHQPKwVqNfWHnrbe4m1rG32OKyZyKavsFgUOqrzr+Quc
	LX+HLVuV+xNZCVN+wbBrHdxZOxql/oY3AmPr2dIwK8pW0+4p2l5hahbA0gmLiv8UDupl3b8PMVr
	rgyoSn5myfn6jVRKQkp0Qe8E2D5qd2o/WaVmurHOW4OlQFN8syU5WQprpti+WbOysSovyk1IjTn
	J2tt2yvLvbT8wnPS0v5dHbPcWkRGELmeHEkNcGhBiYjROb68EKNPu/bs4DHgFRJKq1f4+gxu7r0
	f9lm2b95+ImXKMNP5V/tLBP7mclvZ5lKthKewYHopgSWhmnty9Uqt9IxnhxRebO77rD5qiPbw5s
	7NqMHcw4qEWvvYkz+SVaVW5uCdKcSw+wd16RCyywSH7D6fwQsBVA==
X-Google-Smtp-Source: AGHT+IEqG+78yGFGY+SL/zvW3Zf5gXKbhNU8p6clS9qReHpKKpmAUUwL60SMqhqOg8eCmjLjilEooQ==
X-Received: by 2002:a05:600c:4f0b:b0:476:4efc:8edc with SMTP id 5b1f17b1804b1-47717dfe1fdmr20085705e9.15.1761645230249;
        Tue, 28 Oct 2025 02:53:50 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:cad:2140:ebe6:df10:d28d:aa5? ([2a01:e0a:cad:2140:ebe6:df10:d28d:aa5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475dd48942dsm189090425e9.4.2025.10.28.02.53.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Oct 2025 02:53:49 -0700 (PDT)
Message-ID: <fbc3237e-0185-4c06-a6ea-f061a2afbd64@linaro.org>
Date: Tue, 28 Oct 2025 10:53:48 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH] drm/meson: Fix reference count leak in
 meson_encoder_dsi_probe
To: Miaoqian Lin <linmq006@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Nicolas Belin <nbelin@baylibre.com>, Jagan Teki
 <jagan@amarulasolutions.com>, dri-devel@lists.freedesktop.org,
 linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
References: <20251027084258.79180-1-linmq006@gmail.com>
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
In-Reply-To: <20251027084258.79180-1-linmq006@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/27/25 09:42, Miaoqian Lin wrote:
> The of_graph_get_remote_node() function returns a device node with its
> reference count incremented. The caller is responsible for calling
> of_node_put() to release this reference when done.
> 
> Fixes: 42dcf15f901c ("drm/meson: add DSI encoder")
> Cc: stable@vger.kernel.org
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> ---
>   drivers/gpu/drm/meson/meson_encoder_dsi.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/meson/meson_encoder_dsi.c b/drivers/gpu/drm/meson/meson_encoder_dsi.c
> index 6c6624f9ba24..01edf46e30d0 100644
> --- a/drivers/gpu/drm/meson/meson_encoder_dsi.c
> +++ b/drivers/gpu/drm/meson/meson_encoder_dsi.c
> @@ -121,6 +121,7 @@ int meson_encoder_dsi_probe(struct meson_drm *priv)
>   	}
>   
>   	meson_encoder_dsi->next_bridge = of_drm_find_bridge(remote);
> +	of_node_put(remote);
>   	if (!meson_encoder_dsi->next_bridge)
>   		return dev_err_probe(priv->dev, -EPROBE_DEFER,
>   				     "Failed to find DSI transceiver bridge\n");

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

