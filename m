Return-Path: <linux-kernel+bounces-748284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F0FE7B13F0A
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 17:45:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AA4B3AB75B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 15:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 787D6272E55;
	Mon, 28 Jul 2025 15:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UU7WRzLA"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0263F26F47D
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 15:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753717325; cv=none; b=XlEilLRaXRJrfCTBS8jb6Psch0+Qou5RLv//jspkDt03hNo5C8jLZuyjPHHJMKCcj0zF9BUnKbsRTvomtVzgL4mzEO55r0jZ20j3BWcuYbnbmN+WDyJBeSvbCiG8/Ggwj0Xqq18K/hwpCffl7Pja22LvgtfStcktudbcX7RQkVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753717325; c=relaxed/simple;
	bh=Ljd2711VUc5AdDbKNMzWCPvoI44Vvb8vHP0R1L8KX+E=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=VGcg4CzP988OnIBy8LY3IPZmq2gA5ftWrfW67FVPa5wmb8sgICFU9avUccDM4sImHgXPYNcsYlywRgpyyl+uCQnskR+sddk1giRt6Rk10DAl9mSPGwbIkgLynO5/8wiEQjMb6YAllPRkyB92/YqUF7T3FfpsHSPQtYeNhHVsvVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UU7WRzLA; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-451d3f72391so42689015e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 08:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753717322; x=1754322122; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+uBYu8MhPKwRmm5lVAPvrfaketU2wvZx8p9YAnLBD6c=;
        b=UU7WRzLAJ0FwKQnHtbxg6O2Uxh7eRyGRLuMRafwQb/3lTxUN25q6BS3414l7GkCm25
         1wJznXFrtEZQQHnZ2B2nR4g3VSfOOdX8jZ3gkCJLJnOW/Souv1xtC0QNq2UG4JBpvul3
         QwtCXHwGzpUQEZ8aGU8Cjuf5RHwXNJaj8xCMrxpzDziUsJ+tOI35udzLn3XR3m85c5lc
         YdPoc+IFb4fv4y2gL7xnISrtvxcOvCDSm0ABIRvGwkVDEGpKxzoVCrmbtKQ8N5A4A3xS
         iaBNKi5vSnP9OJ/llZyzoSLimP+NmzXAUupPdhJ/r761a4qcTexJMtGpMgCNk132Er7b
         hOrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753717322; x=1754322122;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+uBYu8MhPKwRmm5lVAPvrfaketU2wvZx8p9YAnLBD6c=;
        b=ZI4MxBrhaL43wnCzxYk9QZ4TxkJibDucis0/+7buJ0rcTK88oL9CrAvSKQW526O6Vk
         7qWY3zxKNxggGrkIzc4SWE5N0klSYBjacQL6KKP77c1QRznjGmW+kwQbBZ293IYNJ8xW
         LCuSLie9LjHJ/7e9LYTlvRedilAjZKLClVuQ6gMbERjoQXTZDJisMKVPW8Pm/OzkkZAO
         bQZEb8UmsGHNVlCBbc/VXxCsihBQRwyyopNA3ezwJE7vwK3gpkaErjijTM2v6Ur+Tgrc
         rxiArN5oi7+kIEgbTLS6YTlAb1AMXDFOF6U6X16r1rgI2JbMPjrLiB0iwh4tcK7/Jt1N
         h4Jg==
X-Forwarded-Encrypted: i=1; AJvYcCV9jreehhfAMTyUVrgIUyAUKU230P8ZoyytsWpNf4KSB8U5b3JuWUIwKeRC6fDc88mG10QLAw/gA5nMwvE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWzkf6DH5N6+F6PGn18jAdNhnWbAUU96gCFlSFjIZYMQMd8UA9
	+vjNuW+7WE5yOYXbmmH8esUeduc+4gTi9gCUXqYqNqnXCKCacWJ4gz9a/HMSWWRQDr0=
X-Gm-Gg: ASbGncsRs4SgbpTKMxptqgYZVsFrJQQnTt5eg0VZCYh/tkcLC8xgEfa+AZVSiqXlwNz
	Q/FQP9gM92JBay3NgZ+mRXKSX5832BwXM0S18bqm+5heEBDOUXyBoWeqbelOYf0aWi9yXtzExdW
	sbvLA+r7fWTjwadwGHiGS3arljhWD4OQgkI5oA0bgngD3G4+C6dJX1JiQ4MBL9jyOR/Oey4EMED
	efoduZPqpdVafRmdqFUUfvxyvzc70hjm55O8LWLi7qWmBIg8zlLfpArQ4bpSx8giSNuDosiQFaN
	X8Rh76reoocM6lX4gRVQjkfz3J1tF1UVnJjo1f09k7OhBA15fllUqP4YjT5chcgNkoR761YguPs
	/5uvxhvqDtm+0WcORmNAyxikMWTTKpnqVi3GL8evMGmsyT1DMF4xlJEXKcinLTua2u7nQ/dH5gu
	1EIqd55QRhvQ==
X-Google-Smtp-Source: AGHT+IF16ueRFmcMUJj81YYHrfcVJcrUX9Qm6yjH1RlY1iznSiPQLVNTJ/XAc9Sx/Gr1FOUaunJoWQ==
X-Received: by 2002:a05:600c:4f03:b0:456:1b8b:b8c6 with SMTP id 5b1f17b1804b1-4587dcce981mr70825915e9.14.1753717322137;
        Mon, 28 Jul 2025 08:42:02 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:9019:46ec:c6f1:c165? ([2a01:e0a:3d9:2080:9019:46ec:c6f1:c165])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b78b26a43asm1852232f8f.34.2025.07.28.08.42.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Jul 2025 08:42:01 -0700 (PDT)
Message-ID: <4eacd669-9967-4ad7-a3a6-d124477100fe@linaro.org>
Date: Mon, 28 Jul 2025 17:42:00 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH] firmware: firmware: meson-sm: fix compile-test default
To: Johan Hovold <johan@kernel.org>
Cc: Kevin Hilman <khilman@baylibre.com>, Jerome Brunet
 <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Carlo Caione <ccaione@baylibre.com>, linux-amlogic@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20250725075429.10056-1-johan@kernel.org>
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
In-Reply-To: <20250725075429.10056-1-johan@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 25/07/2025 09:54, Johan Hovold wrote:
> Enabling compile testing should not enable every individual driver (we
> have "allyesconfig" for that).
> 
> Fixes: 4a434abc40d2 ("firmware: meson-sm: enable build as module")
> Signed-off-by: Johan Hovold <johan@kernel.org>
> ---
>   drivers/firmware/meson/Kconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/firmware/meson/Kconfig b/drivers/firmware/meson/Kconfig
> index f2fdd3756648..179f5d46d8dd 100644
> --- a/drivers/firmware/meson/Kconfig
> +++ b/drivers/firmware/meson/Kconfig
> @@ -5,7 +5,7 @@
>   config MESON_SM
>   	tristate "Amlogic Secure Monitor driver"
>   	depends on ARCH_MESON || COMPILE_TEST
> -	default y
> +	default ARCH_MESON
>   	depends on ARM64_4K_PAGES
>   	help
>   	  Say y here to enable the Amlogic secure monitor driver

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

