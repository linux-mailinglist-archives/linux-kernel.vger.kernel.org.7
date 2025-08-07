Return-Path: <linux-kernel+bounces-758815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 23092B1D427
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 10:16:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC0DE1887362
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 08:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FCBC1DFDB8;
	Thu,  7 Aug 2025 08:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="X2jB3dII"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16EA9182D3
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 08:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754554588; cv=none; b=fYlwp+r0hP8o2Hd4tj3SYBew2q0C9f6q4kw473/A8sLNZxNKrkmC4DxmBw4QVw+SqbOQVBhSmkMdEGELZ9D9ErsSUBJe2AYFls2caT1BImgdiobRIZDIf6GfOkkFO8fqq5h9fXedtml3AXEbNGFdF0NX+EfDxELJvGJUqnsDq/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754554588; c=relaxed/simple;
	bh=dY/tO0jgG3YpNcuWPR2EGMa/x0QbG9DwwPYBjTtd6l4=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=hhpwiL3FoHRoISyMlaQiOO8GBFD+gWo/n+t98NjMQ2F/o/DegGUw+ra5gLpjF/vAasBf7kml3YFWlGxclps5f9102zmnB1cuqPix8Nj9VtcGz1DZv2ymt2G14At/TnsU398b/vWeSS9a0lY37zYjQ/KBrv1qwpeG76JtkrhvQfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=X2jB3dII; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-459e210bd2dso5914525e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Aug 2025 01:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754554585; x=1755159385; darn=vger.kernel.org;
        h=content-transfer-encoding:organization:autocrypt:in-reply-to
         :content-language:references:cc:to:reply-to:subject:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WY4HFaq47tlT3tpQq6GZ2l+firWxt4pgUV7KeO9v8lI=;
        b=X2jB3dII2/0cIbfK/c+35rYEDp78iItsMt/6Q9VyBbS1+fWfDQ1B3qak7Z33Yji5nN
         sHLGXq+t/xbRDEg9wacyR8nJ4NLEI4ncqrxTVvlpUklK6r+7Y7MiIR79dqrgAxsj+0Sa
         a/b4QU4lmHccpwicDLb1ZEgbNa+Hz77zPlLemglV0INoL80gdPMZLRgEXBILGH6n57Es
         ZbLrgufAzyAf58Bhjs2e839pC8MIa61p3zg3d5RoFpu6A5g6lNDIHOTruZzuNYpYMhO+
         K2VzI1u0GiT7g7vEQweSoTOaln1Xysn7Fx00Vp17oU7PfNLb7pcoCSg0u0RVES4Lvq1j
         C3Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754554585; x=1755159385;
        h=content-transfer-encoding:organization:autocrypt:in-reply-to
         :content-language:references:cc:to:reply-to:subject:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WY4HFaq47tlT3tpQq6GZ2l+firWxt4pgUV7KeO9v8lI=;
        b=iFcdfA0wap5K5gEexOenyA2BJBx8PsX4cygdoE9+NTSCvLZ71MJrII/09CkzHaHvXN
         fUEhFUd+kdqjdyW/lJdxBCXWgCPDbAFqQupkbTBxPYiDKB5x8yXDe0dtKN7yBohA9oS1
         6BZtQYf5O5eDpBsbqx7vCZQ8ZcMof9UtaBoJcnPZW2m6w/0lTgXVpnY4fxJFvvQo0oDH
         TjwVxeUVvYuVIyaBf4sSHnvsY92sq/0/KokgSLwi94nw0KK70P7LFk/JG17hEGiqFJ2T
         0/1wPKlDgQn+1+k0o02CdCozmRR0DjngCokFrRkiLGB+QiTFtgbdrN+A0ziDrfUywpdq
         9sEA==
X-Forwarded-Encrypted: i=1; AJvYcCWOAaVKVcBHAB/xhZ8kHvMBWc8Ih5WAnLLs8U297dtu8f+fRJi1AmGPJ/S7v/h3oLg648xK4+8yjc2Yc4s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/fJDAtS26nFQCpUMJjt6ukHhsL0MvonBvgHUJFZwFDrQEDjUr
	bYZ/Fhh/LeB99eWMr2Letors2XewMdfoqmyypoChZ745FEAXOIhWKraAYMSgpzvRRBc=
X-Gm-Gg: ASbGnct54tx/T99Zm8aaQ/Bj+nECN/zswOnV4eVfUCtG/YGl44XSvfbiKSe/9ASVCIu
	ziwuS0eKTvDMiyzTe7VRDHfl9F7lGrTW2Lp4ztKu+2CDctDg8kivs6Szek4LYmjL9hTHhRGPWvC
	fLBQ8/nt8yLC5EMEATb8suqBI6cLFOYuKMjWdPG/e4UwWdEiiPJ81TzGQDLwYOtZiuFahnSkvyJ
	vX5E0eTfoShMF8vU8iYBJFHuf789zymD9pt+05LHZKzGfD6x8CIaBu/TULDkMVJNH1Fwj9Amb/k
	oECtdIdArPJWNEZRbDvhbMWL0G24s7w+OvjbYOJuyf2hG0tb61NoTJ5KJ32YSNcrFMAYQIwUT84
	NEY1W//XrxXhnVp7uzT5qzI2E1gbSuMKZSFz87zTGIqUpX4e2jieBgQIuTCKfZKkrgc7zDrZBBs
	0=
X-Google-Smtp-Source: AGHT+IHE2H+JtDiHVg75yF/+EZzsaupqXfOXiG/R3nCARRikQYg2a0QwLqAvC10oGOycd0mXhQsOsA==
X-Received: by 2002:a05:6000:18ad:b0:3a5:8934:4959 with SMTP id ffacd0b85a97d-3b8f97f5070mr2018365f8f.27.1754554585271;
        Thu, 07 Aug 2025 01:16:25 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:5bf9:b40c:d741:ea95? ([2a01:e0a:3d9:2080:5bf9:b40c:d741:ea95])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-458b4f9e952sm222067015e9.9.2025.08.07.01.16.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Aug 2025 01:16:24 -0700 (PDT)
Message-ID: <1370b493-2026-4988-a8a2-d9595c0fb02b@linaro.org>
Date: Thu, 7 Aug 2025 10:16:24 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Subject: Re: [PATCH] phy: ti: omap-usb2: enable compile testing
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
To: Johan Hovold <johan@kernel.org>, Vinod Koul <vkoul@kernel.org>
Cc: Kishon Vijay Abraham I <kishon@kernel.org>,
 linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250724131623.2662-1-johan@kernel.org>
Content-Language: en-US, fr
In-Reply-To: <20250724131623.2662-1-johan@kernel.org>
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

On 24/07/2025 15:16, Johan Hovold wrote:
> Nothing seems to prevent the driver from being built on non-TI platforms
> so enable compile testing for wider build coverage.
> 
> Signed-off-by: Johan Hovold <johan@kernel.org>
> ---
>   drivers/phy/ti/Kconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/phy/ti/Kconfig b/drivers/phy/ti/Kconfig
> index b905902d5750..b40f28019131 100644
> --- a/drivers/phy/ti/Kconfig
> +++ b/drivers/phy/ti/Kconfig
> @@ -62,7 +62,7 @@ config OMAP_CONTROL_PHY
>   
>   config OMAP_USB2
>   	tristate "OMAP USB2 PHY Driver"
> -	depends on ARCH_OMAP2PLUS || ARCH_K3
> +	depends on ARCH_OMAP2PLUS || ARCH_K3 || COMPILE_TEST
>   	depends on USB_SUPPORT
>   	select GENERIC_PHY
>   	select USB_PHY

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>


