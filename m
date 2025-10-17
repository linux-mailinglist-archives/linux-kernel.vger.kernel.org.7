Return-Path: <linux-kernel+bounces-857763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 74E71BE7E35
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 11:49:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A9CE420F71
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 09:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E59B2DAFAC;
	Fri, 17 Oct 2025 09:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hMnG4GUl"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A712DA774
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 09:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760694565; cv=none; b=Foeip0IPI7axiUEbPh8CJKPDIxfBPXpXCLWwvMgrveTlzeCPYD2XU9p+sYfpRJtyYz5UXCRSycuLnchw16a5GtSj87LhjBjOvNoBsnjNNIEhC/L0FeckfNlZfzPZlU2vmTGVPDloTVf94RcOxGQ9i+HEUTvjW8FBHXH9jv1/VgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760694565; c=relaxed/simple;
	bh=p1l1EMB0E/1R3B7t2iBpGx6TGq5LupRC6wvL5LvYLCg=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=QnZjzHHtzSmHtFqy4B0Jxp8f87a4hEkcuoe2izvoMr3HksY0mzWHgepnwfn/Cle3Oe0fvYRjYVVQIrJ8YDLViB6A79iBMc6MUyGuNPTia6Wd+/xXZqPwKmksy3jzoGEi3HC6JEf+dHpHXX2R7k2wkRh41XvEu67Xf0iPsQolTvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hMnG4GUl; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-42557c5cedcso981569f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 02:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760694562; x=1761299362; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S8JPhxrGotYF3QDvlp9yLVE5fcIkI/cq1aRqnIuBpzQ=;
        b=hMnG4GUlywoqU8535YK7M3Vzg+6NGJa0qYGfLYHqYlMAd52ZREmBrJ8s8cFZpTLwpM
         +45Qsh2kXHPxtIMWmDtYtxcEs2LY/3IFlNS8xAHzuD1KEOycmLyhtYy8UBn9Zw7itbmy
         ptmwa8vMdSlL+Q1vTL9bmz208kuubqauxTPYXoQMG3nsx73c/OHFzyUnMm+Ot3imbldA
         ZACxUX2GVkh73S7AsPDJxJ0rqDU3eV8bHEKyF0NXxrSbgisW928ZlSnWmLHymyJ1izn2
         qTb+h+D2UEBkJlQy+M7w4ORljCqcgKOvJBHBP/8/V6rKL27vzpjZQ1FZsJOaSsXFEtwA
         vyuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760694562; x=1761299362;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=S8JPhxrGotYF3QDvlp9yLVE5fcIkI/cq1aRqnIuBpzQ=;
        b=hEL7HZnoo2WhpfYtWQdKtRP0LfLd1c/S6Tqtrey2IF8sPsVCLoUXIBM7ehhamZNHZ6
         /ECEPhR/rjm+6Q6RRhl4PRMYIpa6jivQMoMDaeI8TkwHYBoYn3p14teEH9G7p3xuAn1B
         7iDvR44H696BGt9DBwJSrBZ+98ggucs16arXaqeniIcDQi5KpMOQMG+ugDeollEFSXHV
         Dd/usrg9xGy0iKunieaYGjPmbH+yulPHlFd1VEPfn91+UfTnjv1Pbg+wKIs5G1ovX4tt
         6DcoNwKKKN31bxz1fASwPjVCz1BC14OhwBKdORXOrwLgJY9d+09Neh66AiXHjNIjlicn
         TKdg==
X-Forwarded-Encrypted: i=1; AJvYcCXtve6btKOGB0AjJSbIsTUsmUU6zX+DQSzBJ9MBSyOeM+uTFv74AoOBMW3Zi0FcvZrctQJko3LwEGz/9fw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8UaJtKN8DGEAYs9ZCC0fI2Cwl3YgGMQUN1aRy5+rF6IRLzUQG
	jQcdSNlBKSu9R38XywIVwa6+rAINjbBd79VhODWolE7w9f/U19M4o1XCpjSlBTOE41o=
X-Gm-Gg: ASbGnctc9YAf/WjtPeOyf1/J/TVuwkdp+9tRVrdOyKUp/tYqSzK9Fy+PLae8wQqYrPJ
	7pkYfUq8rkKGLabyAyeE8tzdkEad8zWrX0xU/yXAQY67DOVoujAvgLnwTU2M0Qg5T1pO6a+M7Gc
	qpcaNBJ2lQHAzVytT+BCU9hNV83/P9iDnc0hO3Y5mGj7NWLBuSntKlqUgsDM4XcI1JFOq4ays8V
	IL4r6r3K/9hqWqNvZwHPxzaYRiIXjjkSZVfjM8tPvoZaHVq7ndMa6sEzc8DB3tK9Dg1ON4ObpUH
	OyA8x4PHRm67Hx9IXpGgxSc3TPoJBmd5lmQztuQkUXAzxBDQOG7lj7Hint7y2OApbjnD9tP8ewc
	F2NM94Pzvx+AOnr6j6oEr2nEYA/fPflWx3OwSr02VOsRQJddHWpDP50AF8prJkm2CwLBVXUkDUs
	3dhd5ICg2G/RrcUjqB5Pn10RNJqRpErrtiKZvb9Nw7ZPktt9IUi9I/
X-Google-Smtp-Source: AGHT+IGYXVXXR9soou2QlY5fvmDy0emyM8wDru5hxk0Z/Fux+gUxcfzTmBtEgW/PNyfNdNzJPuVz6g==
X-Received: by 2002:a05:6000:186a:b0:3ec:db13:89e with SMTP id ffacd0b85a97d-42704d1441cmr1773044f8f.7.1760694561592;
        Fri, 17 Oct 2025 02:49:21 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:5849:4623:6b2a:2be9? ([2a01:e0a:3d9:2080:5849:4623:6b2a:2be9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4710ed57cedsm43662085e9.2.2025.10.17.02.49.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Oct 2025 02:49:21 -0700 (PDT)
Message-ID: <dff86c02-996b-4aba-9f6b-013d1fcb040f@linaro.org>
Date: Fri, 17 Oct 2025 11:49:20 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v2] drm/panel: visionox-rm69299: Depend on
 BACKLIGHT_CLASS_DEVICE
To: =?UTF-8?Q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>,
 Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 phone-devel <phone-devel@vger.kernel.org>,
 Gustavo Padovan <gus@collabora.com>, "kernelci.org bot" <bot@kernelci.org>
References: <20251017-visionox-rm69299-bl-v2-1-9dfa06606754@sigxcpu.org>
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
In-Reply-To: <20251017-visionox-rm69299-bl-v2-1-9dfa06606754@sigxcpu.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/17/25 10:27, Guido Günther wrote:
> We handle backlight so need that dependency.
> 
> Fixes: 49802972d116 ("drm/panel: visionox-rm69299: Add backlight support")
> Reported-by: kernelci.org bot <bot@kernelci.org>
> Signed-off-by: Guido Günther <agx@sigxcpu.org>
> ---
> Changes in v2:
> - Add Reported-by: kernelci.org bot <bot@kernelci.org>
> - Link to v1: https://lore.kernel.org/r/20251016-visionox-rm69299-bl-v1-1-d3b817ae5a26@sigxcpu.org
> ---
>   drivers/gpu/drm/panel/Kconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/panel/Kconfig b/drivers/gpu/drm/panel/Kconfig
> index 407c5f6a268b..59f5a31f3381 100644
> --- a/drivers/gpu/drm/panel/Kconfig
> +++ b/drivers/gpu/drm/panel/Kconfig
> @@ -1112,6 +1112,7 @@ config DRM_PANEL_VISIONOX_RM69299
>   	tristate "Visionox RM69299"
>   	depends on OF
>   	depends on DRM_MIPI_DSI
> +	depends on BACKLIGHT_CLASS_DEVICE
>   	help
>   	  Say Y here if you want to enable support for Visionox
>   	  RM69299  DSI Video Mode panel.
> 
> ---
> base-commit: 7ea30958b3054f5e488fa0b33c352723f7ab3a2a
> change-id: 20251016-visionox-rm69299-bl-7e6a2e30626d
> 
> Best regards,

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

