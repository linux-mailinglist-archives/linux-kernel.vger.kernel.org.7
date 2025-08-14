Return-Path: <linux-kernel+bounces-769047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE00FB269BA
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 16:41:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63379606424
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 14:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D29BA1C8632;
	Thu, 14 Aug 2025 14:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ukoFt5Um"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3054C32142A
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 14:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755181211; cv=none; b=q0tZJqjOHZPNGfkeCpefkNNtMe/PtEC8ECDQcNViZOotgv4WgQm+I5K61QgZU1AiveCOFC98X/Bwww+hZUiYd7Rsgv+78QOBbnF8uD3oml/fWuHVGtW3tIQJpDt3JT33Zmp5kpDM1rreS0FYeOr0AxAa/+4LU44vuSUZKyqtYNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755181211; c=relaxed/simple;
	bh=aivxYLPLQLb20VBnhArwyGn66idMUCNQM3qDVz3S6O8=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=pGd1rt9g6yNxSEqbPZNPSuZibUTaaLAfIjSFyHG6S0rhQYyrgZGGZG6CwWaoTfSnRX9RjoM6pTgR9f/yrDWjnCU1Xm25qjzsc3SZhh1jfcUA7Ar1QVmlnZrgkb/FeyhVlSeLnc7H5eCTsGusZL26iGKJKvhL/hpgXZjLlj8G/eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ukoFt5Um; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3b916fda762so997138f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 07:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755181207; x=1755786007; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5bdQgEC7rZ77bKFkIIw8e//b55v9uHd60dNBACGWzhY=;
        b=ukoFt5UmI6KQptty6qB97DFTFbYMTh47jsOi7RuQGTNHStY9j/4lH8+00kiwC9LV8n
         SLcFGNh/w782AUUUddYXoLzmswQ8Zp/LqkJMoh1AznZMQ1MeWxLfyLTdieEelVXKY3aW
         xBVJwU9yT0yWEv3FtJt0tIuuadTitYYxDXDDmwnlR4vk748gwoaH0RCmfUUF+5GEYo9w
         5Vz1waXIZAom//VhVJxz4Yy46F/jxzuIdjZjh/7L6VWIZWJoeVxHdqqDW/OdF7LfIeEP
         AOzvpLgQqQNrNy0oc8YJtYB2LbM0h+ZLlwgHNxtUrlQWy52y9ytJ8I1uEzlKTsa1OmV9
         pmZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755181207; x=1755786007;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5bdQgEC7rZ77bKFkIIw8e//b55v9uHd60dNBACGWzhY=;
        b=j2MyqhPOLiFT15ZXPKauzXfpK3Nwev4xEbBenN87Uzr2qvtTKqBIFhClV0Y81s+IY8
         UmEL0VBcR68EhCRJCXuEa5d96yU9kspEfepjIPtP4uJAHX2iFdQ49dVrPpjtyCIBFufa
         M4psnzpUZJ0q+Cy5RxJu9QUI+Y1VwVCGo7BFXF9mN5CmLe097Imni+pAw8ekVedyapbK
         lZaP09Vzv3UfYfHZgWW+DOivhjfvVkLotNSA30E3bPAklDOmOMfLy2GA9QaMbU/Py6rH
         ZUejaNP8/B/qwjnnTRKk5afSMXmfOl0Xd02Iq6JmTJHIctNAXY8blRvAI51o1owp+Jje
         TRxA==
X-Forwarded-Encrypted: i=1; AJvYcCVX8uKDp3JfSNY+/dpvU90fuJ3h3yNbTje2cQMYVbNRogEJstJ2KRRJcqcmZLjU9ABqj/sdPJ6ZOkvAMIs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwghYIgPUMa4bs72h7QvT8HBBwiH2qdRH4kK1Y3+NmbKRTj7Zdx
	KHCLMwd6VHYVI6iq7hCn/uxZOa4SFUJuAFyje6AEHri9Cqrj36FdNVafM+Ph+LvTwlo=
X-Gm-Gg: ASbGncvXxIGyVB3hsFi96BIZEHiYOym8RiziT2yMITB8KnVug+SXeqltrTXkaubWanN
	iqE2l6EjXQqGPYeL8BFljInwuWyCodNYbR9/kfymocdGLAoWeRIU9OIMxm+77BHgKYTxK4BnL3l
	hgrB/ACeJYzqEeJNnqZO7J2tpDKwM2EU19eIWVEbPLVLfahXlh0Qt7RXv3h6/aDtJRVaBbj0n7k
	4HIgNCPXo9neTj1mX7HupREMR+bz3NqGMxeNjY1ZJplnLHUpIWtKz0/sBm6bHUoW4h2jTOM//xq
	dCcfNF/QZv3/L8ydbxtDJSRiVjFo5xJ9Ptc+tV3vB63RKzmu/vbwTqsRQ9VEvudqF8NfVmzeHCv
	zYhIzm1fcD38rCseSk8zxjnHUEouBfgyUn6nWITqAdIoSyYomfNix0Orfh3MQRKiDHVPxCqks
X-Google-Smtp-Source: AGHT+IHIriY44PvISGPQnuaFi77640VOHi2AzHePwqO5rLcVQO7pXXuzSy2y2TPprE6NsOwOB+2/OA==
X-Received: by 2002:a05:6000:2282:b0:3b7:8ba2:9818 with SMTP id ffacd0b85a97d-3ba50d4b1c4mr2635910f8f.22.1755181207507;
        Thu, 14 Aug 2025 07:20:07 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:7336:e60:7f9e:21e6? ([2a01:e0a:3d9:2080:7336:e60:7f9e:21e6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c3abedesm51508312f8f.3.2025.08.14.07.20.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Aug 2025 07:20:07 -0700 (PDT)
Message-ID: <382972ef-92e2-44b3-a510-37009fa2f781@linaro.org>
Date: Thu, 14 Aug 2025 16:20:06 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 17/21] rtc: remove unneeded 'fast_io' parameter in
 regmap_config
To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
 linux-kernel@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 linux-rtc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-amlogic@lists.infradead.org
References: <20250813161517.4746-1-wsa+renesas@sang-engineering.com>
 <20250813161517.4746-18-wsa+renesas@sang-engineering.com>
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
In-Reply-To: <20250813161517.4746-18-wsa+renesas@sang-engineering.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13/08/2025 18:15, Wolfram Sang wrote:
> When using MMIO with regmap, fast_io is implied. No need to set it
> again.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
> No dependencies, can be applied directly to the subsystem tree. Buildbot is
> happy, too.
> 
>   drivers/rtc/rtc-meson.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/rtc/rtc-meson.c b/drivers/rtc/rtc-meson.c
> index 47e9ebf58ffc..21eceb9e2e13 100644
> --- a/drivers/rtc/rtc-meson.c
> +++ b/drivers/rtc/rtc-meson.c
> @@ -72,7 +72,6 @@ static const struct regmap_config meson_rtc_peripheral_regmap_config = {
>   	.val_bits	= 32,
>   	.reg_stride	= 4,
>   	.max_register	= RTC_REG4,
> -	.fast_io	= true,
>   };
>   
>   /* RTC front-end serialiser controls */

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

