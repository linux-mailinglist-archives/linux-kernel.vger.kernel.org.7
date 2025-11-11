Return-Path: <linux-kernel+bounces-894713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 97466C4BABE
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 07:26:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1911A4F3F35
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 06:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09ABA2D73A6;
	Tue, 11 Nov 2025 06:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vGDmdTxE"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 356D12D3EF2
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 06:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762842272; cv=none; b=XDS69mvxnbLca3KijRYoRJC3eCdV2MlSZoWuBH7bCa9t3hGHUH03WgSIRAvW22dD9UAtLWZIm0QqawM2GRrThn9ukgTIRoEpQcBPNzwgck+8tlgBFXRNkqWf4zLkwYpcPTX73/GF7p/DEKpqggpaUywfk4xkby77KmKmTS61xjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762842272; c=relaxed/simple;
	bh=y9YBY5nmgnF60OnDvu066csi7ngCJh8D2RBv/5Dgjlo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VDL/d14mEO5tC/PhJZQrGzXOFYb96Q3HkNJXQQYkZCbfUw20bJ3HK6a9IlxJfGFm7VL5Lu4yzp/HHIzYLb18YPQt/+vMP7CehMFpM2SMnNnft4gG8fxmu+MtiUM/GRS0zW8KYPdC9+QJ6KMMAqACKd9uG+AYgChuUUidbuacl1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vGDmdTxE; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-42b3d4d9ca6so1127067f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 22:24:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762842267; x=1763447067; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HX5LjJrt33C/D0Ly5cmrRNsaiFn37WGMaBfVEduzpQg=;
        b=vGDmdTxEl9g1iKOKlyDfvEzgRkVCAx8yi796ySQ/JUjDBS/8M/png0bgZpZhAwl1Dz
         8HAVoTcguIaU3hlKVO3Q9HHEnmoGbjDCPIVDTZq37CkR2jGoOJYwQX8K8DM/NLbec/Fc
         pVSpysucmH/UHetZ8TxZREZsV82NaLznTuSc44CojoF4Vfy42nGfPHpOlrKewh1748hI
         NwZu5S+4EhU5sLVCYVvX0HW+gCvAq/Gav2V+J1U8xLfvI8AEmPDbuGbtYBcjra82QaqS
         M2Ki4xfawi95mqPiTaTbpK4S+gy8TWa+ESHblTED4Txw4CNHWmpw7njQhUa9oFgwa/ty
         e++Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762842267; x=1763447067;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HX5LjJrt33C/D0Ly5cmrRNsaiFn37WGMaBfVEduzpQg=;
        b=R77F/OKur2Y0tBJvD0+MwahUtJTQ6KfSR6r6lAlRmBWFd71rAcsjaXabPiBP8XfxVq
         GsDfs62u168XJRNYPJu0FhhOCXYpSW0ZsE+d7MNMokeZu3y7FH81PkKqfdnNCPjzVe+j
         AZ8UwXrXHufrKrEyvtVk+XgTXas5Nb2DY/cPqBDGgmGEcj1XHSrTvANFaO3fGoy+pGaT
         wdJpVhiW+CrvUgrS3m2gdschPrTXchFfSCjSsvYw2tFPeXJJsTumzEJxjX3/DJrES1iZ
         ynQtusYyGC7Q1cvXQqiV9QS+5V8kOa4nqoCBwvoYY6/g2+YxkztNZh5NtTZiiAM07Cjh
         0xiw==
X-Gm-Message-State: AOJu0Yxjleb3r20rey3emAYncs7RXKPbT+Pu1mkJZm4mMYrfziMLBfGf
	hE1BBI7uIHDD5M60N+cqY9+6szDctGa0uj8yqpyJ3dfVWHmaHQmJ+jA3ADcVBVNlv/k=
X-Gm-Gg: ASbGncsH+5a6ZFSYEBq4QZHnfRPK/3vJbvUQV4jTOVUpf4Qzx+pmd7Vz59EhYpF1y1P
	lFgDczyYYbf7xULObbFtPo2H6WJqd/hmbJdyZ3WjeUQMFDukd0B+zCOz1PIBILisnnvWrglXPGP
	GJY1+FoVrG5HxkiCOhZjhln9C8ygxqQDSj7089TEboyzWsBAI9aG4/X7DPtpUIHs0HEXdNZMAoU
	bbwfRTgYpfHtjlYIqV1rysJXVjdbVV5IUiynOMZnfyFmIn67sPgbpqYpqTZEGJ7sViVQmeraPts
	gqQYEjK8A0ZBnyyXnFMfh1MF8ovmW1GpGz/Zcgn16U+RkwOGY4LDwyJLJl8bDCb++vBBmTLa/A0
	g1GyiWvVrXY+jjRmzGfk4AGpNv3kh0lLc8yFGrLTHG1QuSIbNj90hcWc5Q5AhUrM0xdCS2OsE2P
	HjZR9p5aIlLs/vSHq1
X-Google-Smtp-Source: AGHT+IFBYADieesRozqati0Og3HqjFZ4qF4AW4MAaR2o7qWHxdawiisFSvlI4HQoLhvY8O0xdado+g==
X-Received: by 2002:a5d:5d88:0:b0:429:c8e4:b691 with SMTP id ffacd0b85a97d-42b2dcb7b45mr8038733f8f.55.1762842266938;
        Mon, 10 Nov 2025 22:24:26 -0800 (PST)
Received: from [10.11.12.107] ([5.12.85.52])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b3123036bsm17839426f8f.28.2025.11.10.22.24.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Nov 2025 22:24:26 -0800 (PST)
Message-ID: <c5db97fa-8789-447f-909a-edbdb55383f8@linaro.org>
Date: Tue, 11 Nov 2025 08:24:21 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/6] clk: samsung: add Exynos ACPM clock driver
To: Stephen Boyd <sboyd@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>,
 =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Chanwoo Choi <cw00.choi@samsung.com>, Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>,
 Peter Griffin <peter.griffin@linaro.org>, Rob Herring <robh@kernel.org>,
 Sylwester Nawrocki <s.nawrocki@samsung.com>, Will Deacon <will@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-clk@vger.kernel.org, willmcvicker@google.com, kernel-team@android.com
References: <20251010-acpm-clk-v6-0-321ee8826fd4@linaro.org>
 <20251010-acpm-clk-v6-4-321ee8826fd4@linaro.org>
 <92f1c027-bacc-4537-a158-2e0890e2e8ee@kernel.org>
 <17695fcf-f33c-4246-8d5c-b2120e9e03b1@linaro.org>
 <176282517011.11952.1566372681481575091@lazor>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <176282517011.11952.1566372681481575091@lazor>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/11/25 3:39 AM, Stephen Boyd wrote:

Hi, Stephen!

> Quoting Tudor Ambarus (2025-10-20 00:45:58)
>>
>>
>> On 10/20/25 7:54 AM, Krzysztof Kozlowski wrote:
>>>> diff --git a/drivers/clk/samsung/Kconfig b/drivers/clk/samsung/Kconfig
>>>> index 76a494e95027af26272e30876a87ac293bd56dfa..70a8b82a0136b4d0213d8ff95e029c52436e5c7f 100644
>>>> --- a/drivers/clk/samsung/Kconfig
>>>> +++ b/drivers/clk/samsung/Kconfig
>>>> @@ -95,6 +95,16 @@ config EXYNOS_CLKOUT
>>>>        status of the certains clocks from SoC, but it could also be tied to
>>>>        other devices as an input clock.
>>>>  
>>>> +config EXYNOS_ACPM_CLK
>>>> +    tristate "Clock driver controlled via ACPM interface"
>>>> +    depends on EXYNOS_ACPM_PROTOCOL || (COMPILE_TEST && !EXYNOS_ACPM_PROTOCOL)
>>>
>>> I merged the patches but I don't get why we are not enabling it by
>>> default, just like every other clock driver. What is so special here?
>>
>> Thanks! Are you referring to the depends on line? I needed it otherwise
>> on randconfigs where COMPILE_TEST=y and EXYNOS_ACPM_PROTOCOL=n I get:
>>
>> ERROR: modpost: "devm_acpm_get_by_node" [drivers/clk/samsung/clk-acpm.ko] undefined!
>>
> 
> I don't understand that part. The depends on statement "COMPILE_TEST &&
> !EXYNOS_ACPM_PROTOCOL" is equivalent to COMPILE_TEST=y and
> EXYNOS_ACPM_PROTOCOL=n, so are you trying to avoid
> EXYNOS_ACPM_PROTOCOL=y when COMPILE_TEST=y?

My previous comment was misleading.
The depends on line allows CONFIG_EXYNOS_ACPM_CLK to be selected in two
main scenarios:
1/ if EXYNOS_ACPM_PROTOCOL is enabled the clock driver that uses it can
   be enabled (the normal case).
2/ COMPILE_TEST is enabled AND EXYNOS_ACPM_PROTOCOL is NOT enabled. This
   is the special scenario for build testing. I want to build test the
   clock driver even if EXYNOS_ACPM_PROTOCOL is NOT enabled. For that I
   also needed the following patch:

https://lore.kernel.org/linux-samsung-soc/20251021-fix-acpm-clk-build-test-v1-1-236a3d6db7f5@linaro.org/

Cheers,
ta

