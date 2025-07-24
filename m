Return-Path: <linux-kernel+bounces-744469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C5F3B10D44
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 16:22:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8C52B04170
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 14:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A57B62E267C;
	Thu, 24 Jul 2025 14:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="N/P4Yz5S"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED29F2DFA46
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 14:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753366714; cv=none; b=U/JFhjbjQO9e6lXcgJ5dPtTKVtIQZ0Q9XGVBepFOQ7TySWrmogbEKC6N2gerLco5ABloijqZjuhnvCn26aPq1CdlhUuncwCdtXsjus4/UG8v60HqoFO10kPvIIpEoUZzH3OI4o3qVTyo9Tkf4Sm9lvXIY5i+lZST2lhGooudbj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753366714; c=relaxed/simple;
	bh=k6whfQL2DLxlf2DinYDRVK6VlVRAAM/sca1UZVpaTuo=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Bo2JuSacv4CbN27iX04FvJTSK7xeN0mzn8za3F72v3yOy8mSAzqEn+HZXQlMQg+2Tf31ILEACx8gOI7CQPMev4gxv5TqImCZdjPv6yGaDTfB2O3vKciZOP9H9mWF0ZhJPrWz5/q4Ssy6iuw7rE51r4t03AyxTg2CoG4nPnEwf8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=N/P4Yz5S; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-45600581226so10956645e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 07:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753366711; x=1753971511; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lQ/MB2FO+4yMWNUQ+Y5yKNu4mLCulW5xaxB8WmNAsDo=;
        b=N/P4Yz5SHKID1g+bKOSc9uOyfz/2uZbUXOx4d+y58WLSB/GIj29AiciNNs8wDVTqHD
         Fw/Zx9okMGLN/78xHHU1zjCirlclOi12PPgNCUnd+wo7Cg9Z8kqwhfcH7Td9TFiMdmx6
         3YKROUgclTkS/hDMAaHQXvzfBva6F0Py0sSaIboGn1GJQ5LcutUa2vsuXkBJIauYKpeq
         yszBSmkWdKV0cIOImO4M0NJWExEp3JCrZLaXBqwAs58zy/JhcAcszhB5aq1kblNNsrqV
         r7eZVRM1V1qPyUODRj1J/CJodFlqRsRs8YzzfgVrhdxnvPv/ZBg+F/4SKl5FOjaV9c5+
         9trw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753366711; x=1753971511;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lQ/MB2FO+4yMWNUQ+Y5yKNu4mLCulW5xaxB8WmNAsDo=;
        b=wmAh1RrEy0iYPcFfC4JPzeQekSdSB2Z89uu9DXYCTrtKfyZuMicxFg9zWJ/XhzkvLI
         JQ7BiYSvuqzibrUGe7LqFHJlLpG0SRJZYUyxMSkI8+dP7QMCcNeUUHXUygQfnJta4K73
         Ru4nEQtuQ2w0ktC8DONfTjC/0Qo6lz42ltAOtnNlw0fKPURtCwF6b4JWnjmrxK3tq7h5
         SJlemYbOV1wMq9NfTMCXiJQYRmngEcrc2mKxPJNzSphTXQs2W3WeSVPudAmXso0mTqBq
         9HCmgmY6Z6nXG5m96sWSnoQNfEv7pI8dGotBw43f+XzJAtlcH3SwR+ZVaZSeXCZE3WzH
         EJRA==
X-Forwarded-Encrypted: i=1; AJvYcCWwWuvWR8nlFo3p/tRUmnp32YEovcqenIWFi4fzo7ckqvdU0L3hTV0i90eCwWzpXrBHstQynneInolUjPY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/UwHeVd6bE1LOJ62Y4bw2j5hzDURshOnCVaOMvSec4KEoI9Kw
	TE28SrJZts01LQp067966vtCmsWeObDCmRVDc981a0Q6Yh6kas2/+dYjg51LXmWSuhvqHb+wuhW
	jFe+D
X-Gm-Gg: ASbGncupl9TQsNCfiIhOdnNpN2Xi9sdhYJvRtkbqUBddbgZzQoKinOlvpEcJsWpTE0V
	hcluKsuJVZihXsP7oJzGaCw0QgeW1/aXz00AJ1H4RZ8pedTrNRKy7D8R76ash0uVT9z61u5y9T4
	DpZMcbM+Bl/Dd1IS3JLlLcjCO2uwziL2Y+IVeMaGxfwkTaYj1lRrJ4LdLXkWUBKfSEUiPtho72b
	ZhivVzW7AUHoFfhVBT0IEc/1k7ePlQ3bOpDBXRKIcMnOcBrNGARVUIqGn/dTwKB22VEHM0mZOQX
	djfIt+u1LKBZ0GcjETh5s5XV+xEU1jW+yExbsv7U0iSzP+2CqMpBWc91sFOfsUn3gvbpO6xMUt2
	0Vd2Wyu0g6WIqTXbK39ifmhbqTjmuiB3bG5rr6WoTemmedCgPiKsFJcjsioCuTMm/KQbhUnc2T5
	VP5lsW2NlymQ==
X-Google-Smtp-Source: AGHT+IFLUlbSd2mSrQRGoxUw7mtau3/gG9A7DGtu+3ENHPjDW/QeEUPPMGo49+vhbb8ipQI+kIijmQ==
X-Received: by 2002:a05:6000:2912:b0:3a5:8abe:a264 with SMTP id ffacd0b85a97d-3b768ef73fcmr5620891f8f.37.1753366711097;
        Thu, 24 Jul 2025 07:18:31 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:cad:2140:e2d3:d328:dc00:f187? ([2a01:e0a:cad:2140:e2d3:d328:dc00:f187])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-458705e39b1sm20784965e9.34.2025.07.24.07.18.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Jul 2025 07:18:30 -0700 (PDT)
Message-ID: <5f406084-6014-4f88-8dc2-74527a711e26@linaro.org>
Date: Thu, 24 Jul 2025 16:18:28 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH][next] drm/panel: Kconfig: Fix spelling mistake "pannel"
 -> "panel"
To: Colin Ian King <colin.i.king@gmail.com>,
 Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250724112358.142351-1-colin.i.king@gmail.com>
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
In-Reply-To: <20250724112358.142351-1-colin.i.king@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24/07/2025 13:23, Colin Ian King wrote:
> There is a spelling mistake in the LEDS_BD2606MVV config. Fix it.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>   drivers/gpu/drm/panel/Kconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/panel/Kconfig b/drivers/gpu/drm/panel/Kconfig
> index 09b9f7ff9340..af90ca62e57d 100644
> --- a/drivers/gpu/drm/panel/Kconfig
> +++ b/drivers/gpu/drm/panel/Kconfig
> @@ -971,7 +971,7 @@ config DRM_PANEL_STARTEK_KD070FHFID015
>   	depends on BACKLIGHT_CLASS_DEVICE
>   	help
>   	  Say Y here if you want to enable support for STARTEK KD070FHFID015 DSI panel
> -	  based on RENESAS-R69429 controller. The pannel is a 7-inch TFT LCD display
> +	  based on RENESAS-R69429 controller. The panel is a 7-inch TFT LCD display
>   	  with a resolution of 1024 x 600 pixels. It provides a MIPI DSI interface to
>   	  the host, a built-in LED backlight and touch controller.
>   

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

