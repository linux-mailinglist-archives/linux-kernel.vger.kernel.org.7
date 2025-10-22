Return-Path: <linux-kernel+bounces-864826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55B50BFBA1D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 13:24:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 166FD5611BE
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 11:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5891C3321DB;
	Wed, 22 Oct 2025 11:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gK4c788o"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B324432861C
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 11:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761132277; cv=none; b=gPy0vmRFowDoK66b/5RBATuVBTfT1Kk3J1qJyU3Aa1m0VSWRhX09RbUhz2HKDfLzmYipek35LtKrwgVqSEs6VdKOtK2hY/YKREtfg6pFWsUr2bM0/dzOKXms2awvKNTNjAYDCFvPyN0QZrj9d9r8FoFOXan0jPdM37WY6rcDP1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761132277; c=relaxed/simple;
	bh=4D8tvphMGIr2s84sTEq6X1ry1GAv1OlmyNqaGX6YgUs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nZyrI+KgHKf+tldraYJ5EbJz3Ja7CcpFoPlqKMPnxcbaUxI/CcMuyy4fVc9Xi800/BiJXcnZLiP6/z0sAYiLj6kyb66zfEjwwHIbKZHUDqsJS7BHMCxAynlyV/gyD3OKZ9gBPKbvEXGvFGvxy6GalyadSgJlvu7CXlTbkywQ0vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gK4c788o; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-474975af41dso14397555e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 04:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761132274; x=1761737074; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NE6ALi4oCIm+yd7a3yOvtFqmufCiCdrMy/7EGT/KVX4=;
        b=gK4c788o2dUERwLeI5fVMForfuiRyVpYluEl/tRSkBoSWiDvE+fhYQHMY4v1RDEHmW
         Pn32t2Z9nrd2ltd0HzveMoV2j44OKM2spAJpQ/kTqrqa96vwz8mjQrHD6yztYlXqy0ek
         UZOiaWSWatF3L5vc7Yq8Shupkx8yzWitt7geBvedGjAczs5gM5KbSAmMo5EPGFA0huQt
         H+ED/Uy9kyRKkag3A5Iu24SLNSwT+4QWusL8lSpn+m86vQHp11JnLcL+XYAHQtTL2k+V
         ewP+h2jtRFI+U9PrZhDMfo5eEyK2v73AAd6S0ZGQJtGgZccm4VWQ9vlhRmuhFsxFzJF0
         p7Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761132274; x=1761737074;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NE6ALi4oCIm+yd7a3yOvtFqmufCiCdrMy/7EGT/KVX4=;
        b=jugIML824PY46JQdrZM3PPZA7bJYxbvW5u5va9vPBoRn6YXevK1RYTZS0C+rAol8t7
         ATB4Y4yadRAqIYfXRwzWl/L/uUfacH/+sWRAvbymORGh5HuUASg4Mp4UmvhTeh/Nqhms
         AIL/8EUxRL/XhXc/qq17jar8U+psERGGW7FalVP3F6FvvqRiuwGtpUHF8FV1PpTPSqGS
         4/8bqoLNBn8Wke82gTvJLEKZzXZQD+//vfooqow9BGuGuEPA81kA51sBzXqfL25k/t35
         nvJE2Tw2HTDY6YQecVMrfPFQEN26mRZQU0wBFS0xuCu0+AslTeFW98+mK/o78WqP3lcL
         Hx6Q==
X-Forwarded-Encrypted: i=1; AJvYcCW9MNN/IxlCQtAklRn5i2dPkXtn5zzFJCAYXi24MJQtNhB72QsEHgAen3PPDohZsbPXkbAO6/DE68q75PE=@vger.kernel.org
X-Gm-Message-State: AOJu0YylZxFMRFxCRSiZzSU6vjJDJ7izLBs1kXmM7UQcTpC/OQ7AHu1m
	P3Mb6GpOTgqy0d0Q2LenkGeODo7Dx7yfbcojzPlLChhJ+B8Dy359/4sywXEHrm7HnQM=
X-Gm-Gg: ASbGncvqcn9HYm3ZkIOGstNCHFFRiMkfbwqob0JuzFEMN1sPsGpkobE10Vs+b1l8kZN
	qnmmgRPBR2fan0/B+vNd7csJ4a3Lp+t+hICkXoX4LrqfvI6M7UdgU2H6taMPvyH4z+WPKBlYPH6
	xvjrNDSem2m9Rbpzjhwn/I22IvmfdA5Gpym3b2Etw3uc8HKQj5LaEF23ohX/YwZicFnmTP/Loua
	8ssvY83Q525X81MI4xQO3FT6mcgaRAV3O6wgzI4LIJaSoOyLR5xGqaMiPaWSaXXvTTCMALzoPjy
	CIkzSkqhr1FseCTTqsWR0m9uJOC5SaXF6yUtO24BVbAr5SL5HCqBJmluEjT5QTGi61u0wVugFQC
	70bwrdR+tew0KqAAMAX1yyy7GSlrxPNZSRykFZssdkBgMaYxqIl63WvWU7Bem+3o1C65mqBkXPV
	uczWiP6a2mC710wkH/ndI=
X-Google-Smtp-Source: AGHT+IFHudZFCqpsdF3BziLjxKHgkZc7fTsjSbocAq1uyR2DAIJq/pryZEZ8IbOeeE5y3RSm6MSLNg==
X-Received: by 2002:a05:600c:3e12:b0:45b:7d77:b592 with SMTP id 5b1f17b1804b1-471178a74demr147513535e9.12.1761132274047;
        Wed, 22 Oct 2025 04:24:34 -0700 (PDT)
Received: from [10.11.12.107] ([79.115.63.145])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475c428a534sm45864405e9.6.2025.10.22.04.24.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Oct 2025 04:24:33 -0700 (PDT)
Message-ID: <61813f89-3015-4fdb-a182-5c4159f7bb1e@linaro.org>
Date: Wed, 22 Oct 2025 12:24:31 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] hwrng: exynos: enable GS101 TRNG support
To: =?UTF-8?Q?=C5=81ukasz_Stelmach?= <l.stelmach@samsung.com>,
 Olivia Mackall <olivia@selenic.com>, Herbert Xu
 <herbert@gondor.apana.org.au>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>,
 Peter Griffin <peter.griffin@linaro.org>,
 =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, semen.protsenko@linaro.org,
 willmcvicker@google.com, kernel-team@android.com,
 linux-samsung-soc@vger.kernel.org, linux-crypto@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20251022-gs101-trng-v1-0-8817e2d7a6fc@linaro.org>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20251022-gs101-trng-v1-0-8817e2d7a6fc@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 10/22/25 12:19 PM, Tudor Ambarus wrote:
> Hi,
> 
> I propose the bindings to go through the Samsung tree as well so that we
> can match the compatible with the schema when pulling the DT patch.
> 
> Thanks!
> ta
> 
> ---
> Enable GS101 TRNG support. It works well with the current Exynos850 TRNG
> support. Tested on pixel 6 like this:
> 

the commands started with # and were removed from the cover letter.
I fill them in to avoid a resubmit:

# cat /sys/devices/virtual/misc/hw_random/rng_current> 10141400.rng
> 

dd if=/dev/hwrng bs=100000 count=1 > /dev/null> 1+0 records in
> 1+0 records out
> 100000 bytes (100 kB, 98 KiB) copied, 2.03619 s, 49.1 kB/s
> 

# rngtest -c 1000 < /dev/hwrng> rngtest 6.17
> ...
> rngtest: starting FIPS tests...
> rngtest: bits received from input: 20000032
> rngtest: FIPS 140-2 successes: 1000
> rngtest: FIPS 140-2 failures: 0
> rngtest: FIPS 140-2(2001-10-10) Monobit: 0
> rngtest: FIPS 140-2(2001-10-10) Poker: 0
> rngtest: FIPS 140-2(2001-10-10) Runs: 0
> rngtest: FIPS 140-2(2001-10-10) Long run: 0
> rngtest: FIPS 140-2(2001-10-10) Continuous run: 0
> rngtest: input channel speed: (min=380.570; avg=385.422; max=386.964)Kibits/s
> rngtest: FIPS tests speed: (min=75.092; avg=81.784; max=84.771)Mibits/s
> rngtest: Program run time: 50908949 microseconds
> 
> To: Łukasz Stelmach <l.stelmach@samsung.com>
> To: Olivia Mackall <olivia@selenic.com>
> To: Herbert Xu <herbert@gondor.apana.org.au>
> To: Rob Herring <robh@kernel.org>
> To: Krzysztof Kozlowski <krzk+dt@kernel.org>
> To: Conor Dooley <conor+dt@kernel.org>
> To: Alim Akhtar <alim.akhtar@samsung.com>
> To: Peter Griffin <peter.griffin@linaro.org>
> To: André Draszik <andre.draszik@linaro.org>
> Cc: Krzysztof Kozlowski <krzk@kernel.org>
> Cc: semen.protsenko@linaro.org
> Cc: willmcvicker@google.com
> Cc: kernel-team@android.com
> Cc: linux-samsung-soc@vger.kernel.org
> Cc: linux-crypto@vger.kernel.org
> Cc: devicetree@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> 
> ---
> Tudor Ambarus (2):
>       dt-bindings: rng: add google,gs101-trng compatible
>       arm64: dts: exynos: gs101: add TRNG node
> 
>  .../devicetree/bindings/rng/samsung,exynos5250-trng.yaml       | 10 +++++++---
>  arch/arm64/boot/dts/exynos/google/gs101.dtsi                   |  9 +++++++++
>  2 files changed, 16 insertions(+), 3 deletions(-)
> ---
> base-commit: 8ebc2add3e2d076adc5cc3e8c9bef268f7f1cb31
> change-id: 20251022-gs101-trng-54b710218424
> 
> Best regards,


