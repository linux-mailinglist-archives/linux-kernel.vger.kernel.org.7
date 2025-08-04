Return-Path: <linux-kernel+bounces-755381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C475B1A5B2
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 17:18:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9B6E3A4D5C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 15:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D13C1E5B9A;
	Mon,  4 Aug 2025 15:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gfsuDqXx"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F2521A421
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 15:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754320719; cv=none; b=nbuwczVeti5AzrHC1sdkBleqo6pL/dG3QRlCFhEbMmHZVjZqfGTP5lQlKfPZO4sAy4qWZDmSHIkivvhHX7iV9euWMSWDdwUoINqLmfQcJYuCF+ie2Wkn0L22egtDm9KCePEGkG3NzLqNioF9Ozp4DVSNpMhmHxmOXqXiOMhWV8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754320719; c=relaxed/simple;
	bh=A/bWwKLbYWIm1iZ/1RF0/c2bgmEW1/g5qESGyScpvYg=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=F76SHIVW133K+xBg9bRdoDTUeK+2gMsOsPXjqSjZcbvP7OsePD7oA6yusQJb4lp0IgGJ3gnBJNidxyNSQkyRls99XpU6cj2+VbkvPW5KFgeESNMkib0G+J0LY+yNJutHiha+bE8nvPZnqkGnbdycP8k4mIiQ74MMzFKCvfa6Xy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gfsuDqXx; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3b7892609a5so2981396f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 08:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754320715; x=1754925515; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iL7IFMvc8wLKq8rBuGiTsCRRIzIzTfNl4qmdrsNEzFY=;
        b=gfsuDqXxfG2lePlALT8mMMpJwRUIINF7V1UOOvUQqGNiawt79M+wr2dRh2wXFfsvvZ
         DSI1aWVukv9QMJMIijUqOfWXj9gozy7TypmgV5+VHJEw/qgrKWDbdKyK7IIbXZoQ13mZ
         lQxj7UTXCbO3L/I4NBuLbr21Hl7GzW01NQiwbAXD5LH7JjHxW1LvxDVkKrt4ewQmPg/D
         mJmYv31NymxP4ADYc8sBRaXcx6RTvZVQqbRcTAKSfAA1J0hN+WEdRp/Lq8fYTbFL2nly
         1ul9F7jRg/D2dqpxFp6eUn1OSpXMFdo5XIdtxA4iKFpuFyEm2KzEKvEUJowyMo3CFRyN
         oqCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754320715; x=1754925515;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=iL7IFMvc8wLKq8rBuGiTsCRRIzIzTfNl4qmdrsNEzFY=;
        b=LveTEPXLXtTZfDmy7RCf14g6uyjUlokC0qoskfzMezm9SgdYHnJJ9RXO/cxxHwb6v4
         x4+t5ikuwCQmsAUBthGNFcCC3ii/0/gErn66uWN5sJo71Ydb6XJdqPy94bfp2CxZrISZ
         Gtq8CuN7XZaPMqzzXHcyAG6LNvs/3eayjA8tYGaCCsH+zLFYvQUndSznuCuQQ0dXLX8q
         K+y/2C49XCNant4Z6XyWSk4gIpvxhFvpzZwPiaV4HN8bt3PE+GsSAncFB/enNoz9URHp
         1xJpIu2yzAPxfdAqoW7+3+nU4bLSoJvvUt8Rpiinl4Dum1mmfinkhYOOcJ/oCWDMdZUC
         d+6g==
X-Forwarded-Encrypted: i=1; AJvYcCUewdFCbEXW6CGUkKQs/F4aWC1SoU43yoaEl7bMcFSPYF7mCIuxYw8ZH+OkHHlsONfw17MAIeTYiiN5Y8Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+AUmH8mOQGkw8zOC551MCCLOcVgcUw/fJQsM2qtb2h+73ZSHQ
	KSZf5NI8PjbXyonGTXSr/MDWqRdvhsFXcSr3eA1G5/5M/3tZsOeGEIp28CHUnTPe6zE=
X-Gm-Gg: ASbGncvO9mIEPglwhqCVlZ/k2NwIYmN0f3TzzXdovyonWu1KygyWBgQDDWNyysGuipR
	d7y9bdGJ0Hs1KSzJxqXu/BD+dtdRNnPFaSyLRtWTvOUbGVRf8WwYisodNMbcSulBAUq+SPi+qMm
	LHvj3ChebIVX5rEW8ybVf2Rb8dBnPspfk3nU6GC6Tk9h5ilGU8Fwm6++hDdn2hJVq0WZVH6FdEM
	eS4HMUXsfX9+Nanmp+rpHTdm7xtrxClQOx8tnevka04XrDXC15DVV41oxhyTZ/tt4Gd3HgKIFgl
	Caom/uCdk1DFEAWV4L1mTghI8OiFvfypSnu1uUUxNRva8yv+H5zZ+sGVG9u0wjUg7tpmF/1NQX0
	OCu64LS0h2DbsaMH2m9aNib3j83oOKthdLc4jEeLLN8Nsrzh39J5BRUAaFNwqqOFyLL1sxbWpIH
	w=
X-Google-Smtp-Source: AGHT+IFfE2FIPhBXbo+AP0ydJZgR6yekMgYlyMJQkdPFgTiEDAAmafTjclkHiPKnRWkqltGUi4iXnw==
X-Received: by 2002:a5d:5d0e:0:b0:3b7:9a01:e4f7 with SMTP id ffacd0b85a97d-3b8d94d3819mr7248306f8f.54.1754320714882;
        Mon, 04 Aug 2025 08:18:34 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:3030:f63e:fedd:700f? ([2a01:e0a:3d9:2080:3030:f63e:fedd:700f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c3c51e2sm15538840f8f.32.2025.08.04.08.18.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Aug 2025 08:18:34 -0700 (PDT)
Message-ID: <740e6f22-632b-4f67-a61c-2b207570b4b0@linaro.org>
Date: Mon, 4 Aug 2025 17:18:33 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH] drm/panel: sitronix-st7703: fix typo in comments
To: Hugo Villeneuve <hugo@hugovil.com>, =?UTF-8?Q?Guido_G=C3=BCnther?=
 <agx@sigxcpu.org>, Purism Kernel Team <kernel@puri.sm>,
 Ondrej Jirman <megi@xff.cz>, Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: Hugo Villeneuve <hvilleneuve@dimonoff.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20250721152818.1891212-1-hugo@hugovil.com>
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
In-Reply-To: <20250721152818.1891212-1-hugo@hugovil.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 21/07/2025 17:28, Hugo Villeneuve wrote:
> From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> 
> Fix typo in comments:
>      souch -> such.
> 
> Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> ---
>   drivers/gpu/drm/panel/panel-sitronix-st7703.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-sitronix-st7703.c b/drivers/gpu/drm/panel/panel-sitronix-st7703.c
> index 1a007a244d84..6c348fe28955 100644
> --- a/drivers/gpu/drm/panel/panel-sitronix-st7703.c
> +++ b/drivers/gpu/drm/panel/panel-sitronix-st7703.c
> @@ -1,6 +1,6 @@
>   // SPDX-License-Identifier: GPL-2.0
>   /*
> - * Driver for panels based on Sitronix ST7703 controller, souch as:
> + * Driver for panels based on Sitronix ST7703 controller, such as:
>    *
>    * - Rocktech jh057n00900 5.5" MIPI-DSI panel
>    *
> 
> base-commit: ba0f4c4c0f9d0f90300578fc8d081f43be281a71

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

