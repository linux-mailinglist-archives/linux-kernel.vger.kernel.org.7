Return-Path: <linux-kernel+bounces-757868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2993DB1C7A6
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 16:34:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CD66169232
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 14:34:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16F6A28C022;
	Wed,  6 Aug 2025 14:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tUja34AL"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF61C1A262D
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 14:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754490859; cv=none; b=qqxswg1uWI/CUSU9hC7eoBe1vcUzZe5KDMcRzybkisoFes56ltDDk3Tj8pUL8DT5MkO24QsuRSmbpHOMHbNxq6abq81utZRAcYUx7XvrtQUj/ycQr/hc9IhkFtxDmIT2O8iQUeGfx/VFm7/6PP9WFZ0AI2FFTPxtzWGCMbQamaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754490859; c=relaxed/simple;
	bh=U7uoxerm/sdlzPSvG+diWIIGv6JePPL+tR38XvDQwBk=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=nqaadwyq71q4hBfbZy12GNA8HGETn4tn5QXe4H9ZKObknTSmWW1cxa5s5ukajq0cJBol1I/xAw238D9H7YWmk6XGA1y2ACYSOUWqLWas/p6CUyxMFmbM1ARxDX4v6BB1apWd2ybb4z3e2P4wFjgtFpLY9QEKt65nhr+UmfjF3CY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tUja34AL; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3b7886bee77so5624019f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Aug 2025 07:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754490856; x=1755095656; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=96W7uwKlHpbfRFLEo9z4md6wRw17C44cZB3jokXIckE=;
        b=tUja34ALxUqwK/B8iLvy6fi60W4UI287t2cBGoV6eH20umwkDfNaQQRtpDo4oSHxig
         woKMLDb0nFMorfpjyRGPR0NCD6ZVLw2YjMfRz3R4gkF3Jb8ms+Y1l1cQkvxZhdrkOYxT
         3VOwBv0iCj0AZrmlmju2c4gC77hP64rZ8AFmgckLi/Bc2Duay6mwJ7ixgpWdn2pMCesu
         xZhdE7JU9VauHd3PUBWs2QVU4zF9li5u4WvGBUf+zkwDng5OGFK7lNb1koScEoVY9EHO
         5hCiwPNMeoLXbFkzqC/aYKLmrCnHd/mnBgywL7cElcUXnjVoN8SW5tYjWNDKPYglJ9bs
         035g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754490856; x=1755095656;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=96W7uwKlHpbfRFLEo9z4md6wRw17C44cZB3jokXIckE=;
        b=v4d+Q/gSXKhjt22z7hYEed+KN7ms2ocb5jC8CPbG3e9HwxDhNecNfiuy0YDwXxU4ez
         nD0JYpz3rOcyr50XALrTwdi5sZIYp/0yV7UQaTI2ZkM4hTe+ki/bw/jRKY63mtNOsnup
         8PqbfTFgVJR9koq9Ph1A9GlAdNTDKQVhBAJsSnzfHduXzJhiTZyRhRQkB4SOAgaEXDL0
         BN6SPec3SEdGohlQUMdEp2DxYeajR7VQEI82Hx1YNQGWH5qtYiCwUhhrKOxPGnWML/jW
         /b1VBd8Ovosqv2tJM9cUKfo5ALb4Bgte840WTsI8I2xZB+Z+RgS58QdGbZI6GRZKItSG
         2FSw==
X-Forwarded-Encrypted: i=1; AJvYcCVL8o1BgG7OHNm397JtGV5z0rh7GaWn3JQd0WdCiqqGNxkucZrZCn0rOp/svQ3svWMy7Jgrs1SZKZm5QfI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8giJiwDoikGj3YP4EL5F4B1BpGGKd6wTklNGlHnhrSHV9qsaO
	NUTAq8OFsejsQJKlivvVq6+kou2YWcv8IkhvWrmFQI2LS9YYn0CiWIrv5FYEjHfhJGw=
X-Gm-Gg: ASbGncvPHePByIYDnmujajHJljxwkmsvSIxZ+tn5wP7K6W2kcDR8DstN1JUO4azSsul
	2bbmvUYGSogBUEsM58dhQJyXMbmQ5PcBIfT8UbWTHdeTNDN5nNe3xsYdxqDYUkmCk+/zDRYyNkH
	RbNyWLtE8SbgOulRJPSFOHTYAZog2Dr7ueZf5unQBTryE1DS77U9Fe5ASXR2nIp9I9oi9vTQUO9
	dP7ZgO+2NiH668RErc/nKQtVB3ACv7t9a059LLxQAGbacsZWltqwktPlqkd8/gVwAWYYgMUMYYs
	rNTiENly3CKjX+202INkIeQ8GrEljFWd6HyKqaBpYeDpC+XoFsMLJXtVzOyNW5kohvU/P0mjqdp
	HDUKeNLQIRnEEqhLP+EC94WRXk6ZzBPkgOhWJ9HHb8gr1h0FR28SBKpfaB50VdhYLx6wKhv4/3o
	Q=
X-Google-Smtp-Source: AGHT+IH5NdVXeu1oZSdfbgFBpXIoYLhYEjIi4XFRmFUbfUSxI7TR/XoNEjgGb0ZYv271ynVnNLSc3Q==
X-Received: by 2002:a5d:5f8a:0:b0:3b7:9aff:db60 with SMTP id ffacd0b85a97d-3b8f4160c8fmr2393490f8f.10.1754490855942;
        Wed, 06 Aug 2025 07:34:15 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:96df:e381:55b8:1990? ([2a01:e0a:3d9:2080:96df:e381:55b8:1990])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-458f713eb44sm165058795e9.14.2025.08.06.07.34.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Aug 2025 07:34:15 -0700 (PDT)
Message-ID: <0befef79-561d-4b8b-827b-e6258f0d7a89@linaro.org>
Date: Wed, 6 Aug 2025 16:29:54 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 00/11] phy: drop unused module aliases
To: Johan Hovold <johan@kernel.org>, Vinod Koul <vkoul@kernel.org>
Cc: Kishon Vijay Abraham I <kishon@kernel.org>,
 Justin Chen <justin.chen@broadcom.com>, Al Cooper <alcooperx@gmail.com>,
 Sylwester Nawrocki <s.nawrocki@samsung.com>, linux-phy@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20250724154823.15998-1-johan@kernel.org>
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
In-Reply-To: <20250724154823.15998-1-johan@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24/07/2025 17:48, Johan Hovold wrote:
> When fixing up some device leaks in the TI drivers I noticed that the
> commits introducing the leaks had also converted the drivers to only
> support OF probe.
> 
> This series drops the unused platform module alias from the PHY drivers
> that never have supported or no longer supports anything but OF probing.
> 
> Johan
> 
> 
> Johan Hovold (11):
>    phy: broadcom: brcm-sata: drop unused module alias
>    phy: broadcom: brcm-usb: drop unused module alias
>    phy: cadence: Sierra: drop unused module alias
>    phy: hisilicon: hi6220-usb: drop unused module alias
>    phy: qualcomm: ipq806x-usb: drop unused module alias
>    phy: samsung: exynos5-usbdrd: drop unused module alias
>    phy: samsung: usb2: drop unused module alias
>    phy: ti: omap-usb2: drop unused module alias
>    phy: ti: ti-pipe3: drop unused module alias
>    phy: ti: dm816x-usb: drop unused module alias
>    phy: ti: omap-control: drop unused module alias
> 
>   drivers/phy/broadcom/phy-brcm-sata.c        | 1 -
>   drivers/phy/broadcom/phy-brcm-usb.c         | 1 -
>   drivers/phy/cadence/phy-cadence-sierra.c    | 1 -
>   drivers/phy/hisilicon/phy-hi6220-usb.c      | 1 -
>   drivers/phy/qualcomm/phy-qcom-ipq806x-usb.c | 1 -
>   drivers/phy/samsung/phy-exynos5-usbdrd.c    | 1 -
>   drivers/phy/samsung/phy-samsung-usb2.c      | 1 -
>   drivers/phy/ti/phy-dm816x-usb.c             | 1 -
>   drivers/phy/ti/phy-omap-control.c           | 1 -
>   drivers/phy/ti/phy-omap-usb2.c              | 1 -
>   drivers/phy/ti/phy-ti-pipe3.c               | 1 -
>   11 files changed, 11 deletions(-)
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

