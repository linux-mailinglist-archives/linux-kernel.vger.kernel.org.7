Return-Path: <linux-kernel+bounces-795704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC2C2B3F6BF
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 09:33:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C81D3BC87B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 07:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C56E62E2DDD;
	Tue,  2 Sep 2025 07:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Tmx1MBDU"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9FA21F428C
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 07:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756798411; cv=none; b=ZXukNV3z6hQFfVegKxHOZVMcCLXKpgtow7qpebbmFyTOAhT21QLjnC/Wy+RDQUpNvFzL0cHLD+plm5Q0h8Sje+9nOqy7bj8dsWefCSCoEuH/EvztTd7zV9VYwA3jy8mlHxtwEnPW3lyLEQRsJCmLKTvCmv/odfnz7r+dmXfVzcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756798411; c=relaxed/simple;
	bh=D4V+odKYeGr6EvtL8HDmeKNp13epht8jRQKStbKvYR8=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=lQZsIN24982CB3FdMZWVfULjI201QYvLSJysoXNW6nVuloaQAEEtJdwmTOZPYT3U0h6hISNreMbhtx5dkNp2zQhQsj+eJVhB4+/xmfxlM2GN2Yggvy2f6szt/Zg3aJyLfyFzkz9DXiU62PG5qDkcAfjUd/6Ax2fJKUyNKmjBm0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Tmx1MBDU; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3cf48bde952so3424995f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 00:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756798407; x=1757403207; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zzGEH5SzoJb0QREXsJ+codvGvPzyIv09C4e6DjWnFbs=;
        b=Tmx1MBDUYh/Ox+qMe+U76L3e6cRvGRNpqPbI+OjhtUwGeJSw2roBVrDtB8mQhhL5Ip
         1JGxcckCKjt635WMR0UxHfyGow5nQJ3PyaLdUGJFFEn7tHvGSldfhyaKJoozuG65O8jG
         rLTshLi4J1GUfB0O3pPeD9Wxe7/suzYUpIM0UrFK+xx9LjSmgHpJcMNtuumpVezKzeoo
         7my0eI5Hss41b258IcA5J9O/0ubo9Q5jWhhuFmL/mRRKiFBh2crIXEUXnCdq29ZI3XG+
         /pBwxKstrg6Ga1RUU4lDCmstq+uf2NGgeGrnPuEo8d5yuFk4UCynco9WibMGIun5wRi+
         2dxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756798407; x=1757403207;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zzGEH5SzoJb0QREXsJ+codvGvPzyIv09C4e6DjWnFbs=;
        b=qDzHuSKiSlkxysF0uVxe1WP6pYKFPPNYvWiE7RuF8eGmMrNfrkbbmBPlJwvILrXaf+
         ZROIaJXoi89jRZaPtSDoZsGRso86lsyhNz8bNdM72aomd3DuiRCUt0hF77h+KM5K+FXr
         twwZ5e2XMw6zmVsFbEiDyFqex+wRGE/uSAFgZ325DKoI4IN30wAf/pQSI5sD35RLkJKU
         8LHHwUC0vV4Hl6o1XyuhmdNviEGTtN8UfmcYaJBOw+ReNQqQ8aUbP9aeny0FGxXBpd01
         EKcir50ZHvDSMTQKOTsWAzqefN4y58frhN9/YN0tfxvkMedCaVZrpDLVIugjN+EwDfq+
         +JIQ==
X-Forwarded-Encrypted: i=1; AJvYcCVXoRJoNjiXr70Ye1ZpZ9yNVguD39PAmc6Nn3eNCg8Uh8DTFmtbP0Mz3o/A/Qc8fopJUR3mpCSIbES6ChE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywhe6V8cSAGMydsfPTOIL2MazWKa9+Ag/B7rQYPtdbteqFcJCPY
	0bvy7Mz9tQPb/YuiwygWeqtDHgKBXKSjHrO5A+1I+FF4xPwnAd2N6Tgn1gs0TMfJDSg=
X-Gm-Gg: ASbGncv6RtcYgTtrwkch2KA0dg/ZoiJ49176ufhBxyAU5VEKbde272CbgWcCyMTRgu1
	yT8P3kg3uErxN5q0b7/UrXRI03pIgd/q4Z5m2QHr8rzlh82O4H/pGD3ioogJUt4z5Go9UtN5GMR
	g33sdfD3KnzMUhLpUr/bvA/FyqMM3Tk9HavC6cGIeu0pGRlZ1LrgkM7SKNn9r7Kg4ZxLXCt9wPw
	RyETrO5dtjJ/bG++Uv8oYGWUkBBLUZXbQhG0OdqI6t8x6Bgb3Inhuf+jrU69aozjvVpFAoSEQyZ
	4SSlGFmLqkj02eknUYN1a0KmMiwy5t0xKHe2UFB57kqMFvE4STdcht+qCEKkoWNR6GDyAV9nx27
	QuFLpmCeIJ7ZXd9eGT4T02tGzTaTVcYTdpGPnA1aWVdGrWssENCopZRJAlSRi6StdYqxTGJA34o
	TX/Wp7hAwxwg==
X-Google-Smtp-Source: AGHT+IFE/+Dwxh2SBZShvvP5BRxfoJkpvnPruwR5LDCLB7pxR9NVHiJHNxUuG89GACIWOjRNGeP2PA==
X-Received: by 2002:a05:6000:430a:b0:3d7:4e2d:1e41 with SMTP id ffacd0b85a97d-3d74e2d22efmr3577647f8f.40.1756798406910;
        Tue, 02 Sep 2025 00:33:26 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:5c8d:8a1e:ea2b:c939? ([2a01:e0a:3d9:2080:5c8d:8a1e:ea2b:c939])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cf34491a7fsm18044897f8f.57.2025.09.02.00.33.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Sep 2025 00:33:26 -0700 (PDT)
Message-ID: <3c8571cc-ab41-4231-9950-45d3e207927e@linaro.org>
Date: Tue, 2 Sep 2025 09:33:25 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 2/3] drm/panel: visionox-rm69299: Don't clear all mode
 flags
To: =?UTF-8?Q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>,
 Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 phone-devel@vger.kernel.org
References: <20250901-shift6mq-panel-v1-0-444b4abbfaea@sigxcpu.org>
 <20250901-shift6mq-panel-v1-2-444b4abbfaea@sigxcpu.org>
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
In-Reply-To: <20250901-shift6mq-panel-v1-2-444b4abbfaea@sigxcpu.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 01/09/2025 16:22, Guido Günther wrote:
> Don't clear all mode flags. We only want to maek sure we use HS mode
> during unprepare.
> 
> Signed-off-by: Guido Günther <agx@sigxcpu.org>
> ---
>   drivers/gpu/drm/panel/panel-visionox-rm69299.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-visionox-rm69299.c b/drivers/gpu/drm/panel/panel-visionox-rm69299.c
> index e65697ce6f51c7d64b786da18cf44b16de5d6919..2216d38366ea37368d15480f9d8a8ccbfe77ba3b 100644
> --- a/drivers/gpu/drm/panel/panel-visionox-rm69299.c
> +++ b/drivers/gpu/drm/panel/panel-visionox-rm69299.c
> @@ -192,7 +192,7 @@ static int visionox_rm69299_unprepare(struct drm_panel *panel)
>   	struct visionox_rm69299 *ctx = panel_to_ctx(panel);
>   	struct mipi_dsi_multi_context dsi_ctx = { .dsi = ctx->dsi };
>   
> -	ctx->dsi->mode_flags = 0;
> +	ctx->dsi->mode_flags &= ~MIPI_DSI_MODE_LPM;
>   
>   	mipi_dsi_dcs_set_display_off_multi(&dsi_ctx);
>   
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

