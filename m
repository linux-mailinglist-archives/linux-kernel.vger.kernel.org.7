Return-Path: <linux-kernel+bounces-757989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD6BBB1C963
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 17:57:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06E5F1747FC
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 15:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9A54292B3F;
	Wed,  6 Aug 2025 15:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="W6cKUfGC"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45AB81B040B
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 15:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754495827; cv=none; b=uifGRQ4WQgJUz8d1fKOVtOgcczNL9spX5s603W21ttW/VydAHAy1Q2sOUuYTV3qqU9XgIcObi5bbFBgxV4lkKomRXPJKBzPmmuo+WEwuqxfJ5yyptQER0LlpNBYnYUVIe3MiAkosJ7nLDU2PjoTtAqTg5nC2Vc6kqAc0xE/uvY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754495827; c=relaxed/simple;
	bh=U7uoxerm/sdlzPSvG+diWIIGv6JePPL+tR38XvDQwBk=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=aC4H7aNuIAyVDQSDiGu4tKGJHK5DCAa56zc/R2n4/XA+pV+9AesMD4OrpChlCDV0Ra+eQUYWTCY+F39haCAJBYS9LxuLWEGek1wiuIVTfj4YCJEXe9zsE1aaIJji4+azKdVHpzohsDqta1+08th9vkD+vHzRDqHD/Ry5Z8GKV7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=W6cKUfGC; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4589b3e3820so764105e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Aug 2025 08:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754495823; x=1755100623; darn=vger.kernel.org;
        h=content-transfer-encoding:organization:autocrypt:in-reply-to
         :content-language:references:cc:to:reply-to:subject:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=96W7uwKlHpbfRFLEo9z4md6wRw17C44cZB3jokXIckE=;
        b=W6cKUfGCHwB6Za/W66po1bRtnKKVg86KEywT/NEwfYsYkl2xFVxKdosDboT2u8Tmy4
         ywAXeDQ8155zZ8mfF+/KKKRjOo7OX08Jg8pxwYxOJX2Cx+ZdtJQozlYrOoNfwy6IshOK
         uxYTAqsPumPJCuHXbX/69fY7ypb/ioV4NabDQfemqp6jGgS3R2BrcvicmU6r0R94frOg
         HUA6jE0vnFBwcaPvosOQSN+xE65SdJEMiCeOcMmlFZ5Dw4qBS2rpW8dZnZOuDKflNMyk
         BAmn1V1hFKqy0TaZDZRKqgGh4G7KupOrc3rmHCx0I3lZQZ2zkq/6Ixcegp7JAI/Supu5
         S1Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754495823; x=1755100623;
        h=content-transfer-encoding:organization:autocrypt:in-reply-to
         :content-language:references:cc:to:reply-to:subject:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=96W7uwKlHpbfRFLEo9z4md6wRw17C44cZB3jokXIckE=;
        b=Ryh4lajNdpNLfhzjkNI9YXVw2wMXmKpRG0m5M1Mto8QieFQvib8Tb32hwirmQz03tD
         iZDIh3qRObIF5PupsofiMPznHOakhdrzvZxQ6/qZeDkVKnc54xpLHelG0cGutRVpsZrB
         UkHJiF0Io1CbePmpDtzi9PeZBm86CG2TLW9R512Gvls+nrC/svbLC7YAtAV8qmNughvq
         2lNwyR60JNt2xksGLVLeC4rCfpmfTLARCqGeS1HUoppAeQQal/K+5n1RiaeSr5aary47
         WKQrurfB8ygOBJThm6QtNiuulxUx0iZZ2bSgnUSv40X45qdx41RTKn9v+Pa7hH8l9Cmh
         Zqiw==
X-Forwarded-Encrypted: i=1; AJvYcCU/CbBrNJAmMFM0EOuD0gcj+sEyB04teU+AVl87v+rnt3EE1ySSuBZCEWUumOaakzR4LVatGtxDSbDqEXw=@vger.kernel.org
X-Gm-Message-State: AOJu0YznSgHW9DPG8RA6aMDvmXba/9XqV2Pmhqs71Tx+McWMYlCwaCiu
	+GR29JmtdI7pzDFtUod1V3gaG4FYgo05PyqibHe8yP3v0ulnWeTkTQyKeOzqI4ceEto=
X-Gm-Gg: ASbGncvg2pIVyNkXUZfKlhZuvFVty04BBZXpaShfrG1LnC4FPD7V5howAJmdz7foL9n
	2hKmPcNqKZQGg1p18+a9e78/DlFYV34bKaFCgW7JOwb8WQqyQOh9n7/OSIri7e+TDqeqEYvp512
	2jReoSje4vKjhxj3SLJoswh/Jd/YY5H+dWsOExj4DKvRxw6dIl8qGwKe/nzwc5x8FiP/rvRJ/5n
	zyrfaPRMe20ybnSE3Q+24wuIO5L9Yro3vrFZ5QJAmudArPAbJokezOAD1QiMvk+aEDUxHOtYlOF
	Mhyfk/Urt3qZlo6YFaPKPny5WlhtIgTz1gFFg+xM2MWUWIcttk01YuOTwvmhen92UZ4rO8Xc75v
	bfhUFv8NrHLm/3fb/hnsxHbIHpL8HvoVTOHPj+edUJ5oe0Zdt7/yFTjBKPkfQjpkhdwGWv1DA5w
	gn0eVR8nFUYg==
X-Google-Smtp-Source: AGHT+IHGLHNn1kN0J6PwjJjw74PpNaOuAm5Zj48JGv0mBJzoVMk+XWDaoq/829VYh8bGLXdX56kq/w==
X-Received: by 2002:a05:600c:4506:b0:456:1923:7549 with SMTP id 5b1f17b1804b1-459e70e877fmr29064575e9.26.1754495823518;
        Wed, 06 Aug 2025 08:57:03 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:96df:e381:55b8:1990? ([2a01:e0a:3d9:2080:96df:e381:55b8:1990])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-458953cfd10sm319363385e9.21.2025.08.06.08.57.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Aug 2025 08:57:03 -0700 (PDT)
Message-ID: <3a073dc8-bda5-46ea-9db0-48155b0bce37@linaro.org>
Date: Wed, 6 Aug 2025 17:57:02 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Subject: Re: [PATCH 00/11] phy: drop unused module aliases
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
To: Johan Hovold <johan@kernel.org>, Vinod Koul <vkoul@kernel.org>
Cc: Kishon Vijay Abraham I <kishon@kernel.org>,
 Justin Chen <justin.chen@broadcom.com>, Al Cooper <alcooperx@gmail.com>,
 Sylwester Nawrocki <s.nawrocki@samsung.com>, linux-phy@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20250724154823.15998-1-johan@kernel.org>
Content-Language: en-US, fr
In-Reply-To: <20250724154823.15998-1-johan@kernel.org>
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


