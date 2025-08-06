Return-Path: <linux-kernel+bounces-757872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 73426B1C7B0
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 16:36:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73F8A18A5A1E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 14:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E648F28D8EF;
	Wed,  6 Aug 2025 14:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="V+XSUtSO"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C9DB28C5D1
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 14:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754490962; cv=none; b=WqwJKd/zHq0vkIJGfVbT3n/jojLBZlSDcsMEtogFII9pPR9GlvHFdWpkp1RbK53SYTjOaxy0QaMUAHSEbXQip0WNIIA7ft1HEsqm0Yd2GmFTJ8LFKiDMXPQgWSuxPwQwMwaOOjgI7k7TGjdpKtW/xWy+ZxcY6qC0ZLt37aRryIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754490962; c=relaxed/simple;
	bh=dY/tO0jgG3YpNcuWPR2EGMa/x0QbG9DwwPYBjTtd6l4=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=IGX/TsSbmcItKkxf5s0y/sKWUHDvsJ+mCdxmP81sLEu83MPNOwtlRx/F8Vu5rUCnxqc+qba4osE9WzZTkWa0FuNJZz8Ert8Bd8kn0IARdzt3LRL1Vtej3G6S+xGrVq3Km1r8sLGXbur4MLg5OgISvGykuILBVa0zebDTSwxWDDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=V+XSUtSO; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4538bc52a8dso42947245e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Aug 2025 07:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754490959; x=1755095759; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WY4HFaq47tlT3tpQq6GZ2l+firWxt4pgUV7KeO9v8lI=;
        b=V+XSUtSO1DQhllj1k+N0UgcMmC334hLvzJz+NMRbADxfVOCM8vVvbow2iuPH63BXlK
         U/og193/+nXKc+Dm2zZdhHBHa7jw0cLaZ9wLS5qWTKn212sUq0miXaCz3cywumX1gWYx
         L313oaM7Fnq5+Oo5ZidJgBnq67yCiB9hwFaijb90TXs7W3P82XCcMMhi+p5SeiKYLfoI
         DD+Um1OnaLmpejNTzGxsPgRODL+dt/gtxUVLnjnUOXVIZBeJsa0KUtGb87RelG1Mbu7a
         ht1RH5eD4YObvjWBEYhBYRy/GozL0bp9bSLix5MW/F8r3a49Cmnl4KQhmYB2XZ7SLkqy
         Uh3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754490959; x=1755095759;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WY4HFaq47tlT3tpQq6GZ2l+firWxt4pgUV7KeO9v8lI=;
        b=b9+6dPfDttBnxE7GZBUJUn2VTAH+Ydb8fQBoi3c4SXkYx+MX8vl5kto1jDC2gntZa9
         sp/aUFE1TvEKDMJfG3++peVWpX7EJ80PIdI+3I9Unp2exuGY/emkt8r01z+EEOYlNazX
         ImlQy8Ho9B4bNImA4U69izBrobdJle0MGtI9D4inT7dNfctKbWE0Tbmwf2GClE7lEXq+
         gpMEpBM5lHP9rdttIjejW9XhfLcvRlBLeQem6eeK4yNl69IKcfT7I3qkhpqN52XI12bR
         hA+UJie/tF+jrSlF1Aq2/wfZsplRpl3SU3/NDG3xZF1Urj1Nve/JLASn5Ml96H1YadI8
         dV/A==
X-Forwarded-Encrypted: i=1; AJvYcCXLqbsjtZH1PjCDicdQsdgLuVGRKo/nj/6bC7awwLjmkvWcEJem3bqFCy74RiYi6h7zi/6YAJaLSl744OA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLxP5gwfbIxupVirI98/5ne1Ql/NY4oBoBgx0z5WVCUTqk1rlk
	ZFlDvTF6ZeNOZo42IurYnrInaBBiFqN+yxImvtI8E05IdI9kGSxi+8zt07RS8QS4Fqs=
X-Gm-Gg: ASbGncu6vsogziN1VEM4NdPY6UmbUQsskOvOkQrnh8wUJ5ARBpwjqAabJ7yjWY/ho90
	I+1xWkf0lJIzg35e/ZKYLCd9ysIka3oKUvKgpZDRNiF0h2C2g1OcwCwhlFW6MYeHDslb72JdQXv
	yqnOQnTI3B/CGUo8JrS3+mQ+NLPEuO9Anc2eyMLlvTKCtY14phUah7bODUVKRH6DhfJ/tf9qDwQ
	6afGDkLaQdSlPw3R6QO8sU4b2d3pWhVYls/X4ucl57ONZaTpBeCrM3a3yMiioTTNk1dYkTHq6LU
	tFIYIzX6RM91RieL1vJy2A1P/xQqNWrXiCXLBFKjMgqClrj6JiMDprwJn5R1m0RStQrJ+UjWh3L
	YYDOI7WzqB86Zpc0vnQaZRhYGXUzwkvB/AEAIkAK9bGIcxNeGT7kkuZXmvdOKkakHl9+5cbTEZI
	aYqO5Ywo72Tg==
X-Google-Smtp-Source: AGHT+IHZ4gClnKq5LjnIy9aDSbR616qh1rBaFjTEtlutR4EzQgDWiLdvxCUHjB1OtH5/MqFyNd1crw==
X-Received: by 2002:a05:600c:b93:b0:458:a7b6:c683 with SMTP id 5b1f17b1804b1-459e707f5ffmr25267615e9.1.1754490958766;
        Wed, 06 Aug 2025 07:35:58 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:96df:e381:55b8:1990? ([2a01:e0a:3d9:2080:96df:e381:55b8:1990])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459db13fc9fsm125335815e9.7.2025.08.06.07.35.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Aug 2025 07:35:58 -0700 (PDT)
Message-ID: <4b224859-bee3-49ca-ba06-cf07c55b8ac7@linaro.org>
Date: Wed, 6 Aug 2025 16:35:57 +0200
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

