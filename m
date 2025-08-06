Return-Path: <linux-kernel+bounces-757871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 584FFB1C7AF
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 16:36:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A8987A74C2
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 14:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DEEB28DEE7;
	Wed,  6 Aug 2025 14:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="p03coX4q"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 213A728DEE3
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 14:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754490956; cv=none; b=UfpGfvA4038/NUFGIO6ralooXFKe4/Rc2IrM42bXvSylPY1DPyF1SJTEX5OVSEjT2d0pfIzrJSpRZpogAY+3RvkjsUY+80nMW5Xz3WOtSjImLEdJHU0j3PpbHxy8nX5sVvauJwfiYg2jYM1Ir6F7qCxd+PL57wa03kUEDQ9cJOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754490956; c=relaxed/simple;
	bh=dY/tO0jgG3YpNcuWPR2EGMa/x0QbG9DwwPYBjTtd6l4=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=SdSBY2VSEgrMA93AQ+rWH5gmA52oOY8qV+rykVNrAxMyMeHpifZSsPzMpUkhHYvamlqigAOT9slnW82OPaXEHoLoLJG11LcWNrwyJxqOejfICdsW4xxW8M1ReLojjDC6MuX0TFw3073TgLksY7eT5kbvum9RBwdSJQop4OC6TqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=p03coX4q; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-458aee6e86aso35697805e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Aug 2025 07:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754490953; x=1755095753; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WY4HFaq47tlT3tpQq6GZ2l+firWxt4pgUV7KeO9v8lI=;
        b=p03coX4qmqzLs2vNzvHO+V14IiA2ftNuezYYmVTWjbStyzNS/ltv7GLZD6BiGJAkOL
         MzFTgQyaeZfs71U9NTWMaCebz4kyYhkuwoStcHPzuEIX6tsixoUxsv6KfWZz017N3zjQ
         sSAIP5qEBBB7F7zGwSJ6XbuaZ54VXT4hgg1Vad+YO5TZG34ErZDUHJ4yEsZZNPOYB2fh
         jRDIsW0AL6ygusQN91frukI4ePmNGV+22ZwAB4SV1SDTU1k7OoNh20LBkJKf/2WISNW9
         msWyvwTycu0gPkVyt1nLWfn6xmg1upgicQV/ba7KO5nJ638QyddS9vtwtSMABLCc6rLG
         TLvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754490953; x=1755095753;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WY4HFaq47tlT3tpQq6GZ2l+firWxt4pgUV7KeO9v8lI=;
        b=tcDVm1EJnlL6Rc9nZQttHVAgvnhSRJCUPNUT7WSDxuSteIF8FoLkAzPiPGHEoAVsCc
         kZMDTBsutoO4WYORdfMFyZTSc5Rc0Alxio1/Eba6vrrRv5c1YBVRGputl4c8qro3279X
         0CeWvFf9VG6j51m5jwSGFu3eiJtxpgkVYpdU9OB0oM8lsXMDhrH0eY4b4gngErZMWy1b
         g1by9W1RwTb7IG4MrnDgYjZvIGHV+6IcZ0ZzKWfytSVu0XA/uNtCrLCJxuqeLHkDSVlT
         NyCHGv3ZGVfldpp50JLx3NorD/oq4votJJXCFPI8PsbDqLuINeyTEGN3GO3Xs/E5yMmI
         42kA==
X-Forwarded-Encrypted: i=1; AJvYcCWEK1dsYga4xGY2Tustb09zWHxwWX1Zx6DRYVHHPp/lNHVZkNUeC41DrmANMwHder1GLRQJ493KbxHj2WY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCfBNDvL75Jc1TdvQbbkGMU+bPkSTkYRYm57hZ2Aa50fV/6yy4
	cdiTx6XdqxDiLGhrQvP2Udf6XzlAQ8oJShiU7q59I0VCvVpJ5SnQFVqmL/bFXATA+Ys=
X-Gm-Gg: ASbGncugfzZLzV6INHSJbkSX88cxm0wTFqRqUuDHAHTyXW8OIGCqsF1nRSSfGbMpUIx
	GootGtSReCgz90MSyrUtLuNajCeplYUPSJ5F5pXFu1UcPRqr14QMk6Tj7F5SCelvR4/r6Js9Hxl
	xfnx0cuLeogJNTPy1ShcOksm9aJPIIg4GQzRmJ9yjceIf/lQNMRnljms+IUlmskjEVSf9RTzifF
	sNbcw+JhM8KX8hqzLQR+QEMDwIRzaD0w3H8w6OWEPNK08MetF81SuK2HBy8k0XXMqHZFYMOUkZp
	wM5M/B7aSSVfeThRXp5d5kk1tjUusI5IcUqGqGVoiwVpx6lir+zJe07S43gGGXURjqexPFtN6+g
	Swj/qGp5dVqkaIzK0xNxxPmc/gXiVPY+e/JAPYZua1IQt5au0ZQtqzXavrhcQ3ZlcfaDQx8SzQs
	R19E/AiHftjA==
X-Google-Smtp-Source: AGHT+IH16nZWd2JHtG04hD19AjAYcqMi0iTN0EJI8ZCyo5tiebO/fARHN9WAimBG+QbIgV0IeHxScw==
X-Received: by 2002:a05:600c:1c02:b0:459:df07:6db7 with SMTP id 5b1f17b1804b1-459e70800e9mr26588945e9.6.1754490953363;
        Wed, 06 Aug 2025 07:35:53 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:96df:e381:55b8:1990? ([2a01:e0a:3d9:2080:96df:e381:55b8:1990])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c3bc12csm23780039f8f.28.2025.08.06.07.35.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Aug 2025 07:35:52 -0700 (PDT)
Message-ID: <ede3c0a2-d174-4893-9550-6dcb51457053@linaro.org>
Date: Wed, 6 Aug 2025 16:35:52 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH] phy: ti: omap-usb2: enable compile testing
To: Johan Hovold <johan@kernel.org>, Vinod Koul <vkoul@kernel.org>
Cc: Kishon Vijay Abraham I <kishon@kernel.org>,
 linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250724131623.2662-1-johan@kernel.org>
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
In-Reply-To: <20250724131623.2662-1-johan@kernel.org>
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

