Return-Path: <linux-kernel+bounces-892765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D26E8C45C13
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 10:54:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C4491890C8C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 09:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F8773081AC;
	Mon, 10 Nov 2025 09:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DTanp70k"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EF7C3043B2
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 09:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762768363; cv=none; b=VU/v3LrNjJ0jEeqhZzQz/MsKHI9Hbslp1cx8W+S+2VONIH8Er6V1rFY2jD7E4TCXFpw6vlul2AikZmkpNTDI+ozDSMdNsuGuEOFzN3vjANZFcBg66TS2xbqiOxcXozlsqZgyNu/LEsPUv1GYDl9UKjh6BZFqh5fDjM+WHRH59V4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762768363; c=relaxed/simple;
	bh=/7xhR+Vm7WW6F0L/UDUv4zh0j0pHhb3GvkNc0PZ4Ikg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ieth192CXqTJvg+hupbcCP+4paDuwygWEWRErq/Oh9PKVrA6dkQNdUtqa5bogtz2FtorDc7UdfRIUNp2mSANKN8Hx+skivSe8AqXO+bb/7++gem+Dou/YNAF2vzSKQABcLrfrGS2zoWC/v2sBnK3Oiz3ZH+cVqflmqrO2ChvjLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DTanp70k; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-47775fb6c56so17382145e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 01:52:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762768359; x=1763373159; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rhp4YgfhsRZMzX8NUUCQPo90BZ3bChzDwUAKuvs0tfk=;
        b=DTanp70kwhb67cMG9jqcNehRx9D9nrbaC8D3xwWVAiRd5lmJSLzF8MZtQskxmRRGYs
         SlF3ksNhpF+e041rG94xVUzRrc+gew3vjCqHQ95qV5CRh0g/h7xsvDUL7nmI7h1uoVN6
         Eq+EzaCS+RAUUPj16j8FH++epOSDljFVU25EG0oFfLzrpAM89N/nWdqtJ+HTZAfzRu7Q
         7ft5CixoAVqeA9TlkwahZQKvl3VdYXxBcpfMYllFpsmbmGrRHY5qtJ5pm5HIeA1gfRpG
         xrP+APQ0E3GYeqwcqZyH37hG6I41DvDmK/F4vqveWqnQemyHYivAP/k2DlXHejgM8x36
         tx4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762768359; x=1763373159;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rhp4YgfhsRZMzX8NUUCQPo90BZ3bChzDwUAKuvs0tfk=;
        b=o50caEgKfTctoNcpNs5P40jmGtiizMVWRnLrPbNupmkT/AsZv1w9rNflBI9/C3AO9G
         ++g3LcFwYOyR+IM3TFeEgP/fyNrUPBL8PDPRaO0CNEl6Fvy2PiXRe2vcdS4wCXfHJx1F
         PUHgc3Mb5h3gVgpgE0w+spMOEK/8Tbt4JLVbtmpYk8H9lZDVlRtSNpxeSD1lroXZ8RXR
         vplrU8Y+u0rZ1T1MsNNy3v1jTcWsScgJRDx2yLF4it4sLLoPJV3105cKp7yRelnoZwtw
         OH0O9rilEhzEyl18NDdHk+JpdMHc/bU2pxZwGR51TYUmQwiuYVfwwBQa/QA6LHKwltYT
         ArFw==
X-Forwarded-Encrypted: i=1; AJvYcCWio9SJNvUJuK/o9b3Whzob6bFnOhkptH8QYDkxnvxaAnpVPz0270S6VBIY/j6+JeLGIHd/1sAHMLHBlUg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxxn9zQXxhDR+8ptK2FsQFKLPpl6yEo1OJ0ts+83pH/IPeCXZRJ
	L1MCtkPEzvEozvfxTPsRf2zDwhgT82Q/8KnRIX1j+XsuRVk2UrqxtQtJ3HDsMwLCFEw=
X-Gm-Gg: ASbGncurzv+mal4QZQd/2lcABsARAKrfjvlu9SBn3uL9kK3fFHu/6Lo4DBuNgPmF971
	D+dab1SHlNp2GtTkkvQAgCOgrMDouL3Gp6zmPUOnwpjhHDsPXrhixX4P0iNmDcuSYS5irwolhBR
	wgjLlIjHlJdCzlBEx7J6lgHeGn3LgTuFx1YNVUHYQKpkJh9xMy28L56t0ReQrASk4FRX0n8UooX
	VNW04wYH7Oghf1mE+V6CZb7SRx+1MybafY+SzNa3cK8v7WWaWuihTXh0KixEiwNBffPiMbrTDLs
	HMlq333gNh4mtp5QYDZmNM0hAL4knqIPqYH/+BahsLgi9WxV/K1a+wBxUN2qzu2A+CEluLdIByw
	jcVov/5kQCR8LFAKmpaTKDyYDJRHQ6WBujfpZgKGzqp5/kx9zrZ8j72ebjPKuoIySoDX37UVAH7
	QYkErdcg==
X-Google-Smtp-Source: AGHT+IHCMEptRrO3Xd4sJVJqG0K81DdTzjfPzWE+SEpDSUp7i+llvbmd/DfdXqcN55ZcAaess9TJ5w==
X-Received: by 2002:a05:600c:3011:b0:477:7975:30ea with SMTP id 5b1f17b1804b1-477797535a8mr26023715e9.29.1762768358611;
        Mon, 10 Nov 2025 01:52:38 -0800 (PST)
Received: from [10.11.12.107] ([5.12.85.52])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47774df2d80sm121261635e9.14.2025.11.10.01.52.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Nov 2025 01:52:38 -0800 (PST)
Message-ID: <513678ee-b93d-40a4-a565-ca6ae41bdde7@linaro.org>
Date: Mon, 10 Nov 2025 11:52:34 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] nvmem: add Samsung Exynos OTP support
To: Krzysztof Kozlowski <krzk@kernel.org>,
 Srinivas Kandagatla <srini@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>,
 Peter Griffin <peter.griffin@linaro.org>,
 =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Cc: semen.protsenko@linaro.org, willmcvicker@google.com,
 kernel-team@android.com, linux-kernel@vger.kernel.org,
 linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20251031-gs101-otp-v1-0-2a54f6c4e7b6@linaro.org>
 <20251031-gs101-otp-v1-2-2a54f6c4e7b6@linaro.org>
 <93d5636b-a515-4976-b68c-9606924eab8f@kernel.org>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <93d5636b-a515-4976-b68c-9606924eab8f@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/4/25 9:19 AM, Krzysztof Kozlowski wrote:
> On 31/10/2025 13:45, Tudor Ambarus wrote:
>> Add support for the Samsung Exynos OTP controller. On the Google GS101
>> SoC, this controller provides 32 Kbit of OTP memory space that can be
>> read/program/lock using a specific sequence of register accesses.
>>
>> The OTP controller register space is of interest as well because it
>> contains dedicated registers for the Product ID and the Chip ID (apart
>> other things like TMU or ASV info). Register the OTP controller
>> register space as a nvmem device so that other drivers can access its
>> contents using nvmem cells.
>>
>> Support for the OTP memory space can follow and be modeled as a
>> dedicated nvmem device.
>>
>> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
>> ---
>>  drivers/nvmem/Kconfig      | 10 +++++
>>  drivers/nvmem/Makefile     |  2 +
>>  drivers/nvmem/exynos-otp.c | 98 ++++++++++++++++++++++++++++++++++++++++++++++
>>  3 files changed, 110 insertions(+)
>>
>> diff --git a/drivers/nvmem/Kconfig b/drivers/nvmem/Kconfig
>> index e0d88d3199c11a3b71cc274b2114e9554ac486fc..f973e009737f2fbdc8511e50f1aa9e6003286065 100644
>> --- a/drivers/nvmem/Kconfig
>> +++ b/drivers/nvmem/Kconfig
>> @@ -84,6 +84,16 @@ config NVMEM_BRCM_NVRAM
>>  	  This driver provides support for Broadcom's NVRAM that can be accessed
>>  	  using I/O mapping.
>>  
>> +config NVMEM_EXYNOS_OTP
>> +	tristate "Samsung Exynos OTP support"
>> +	depends on ARCH_EXYNOS || COMPILE_TEST
>> +	help
>> +	  This driver provides support for the OTP controller found on some
>> +	  Samsung Exynos SoCs.
>> +
>> +	  This driver can also be built as a module. If so, the module
>> +	  will be called exynos-otp.
>> +
>>  config NVMEM_IMX_IIM
>>  	tristate "i.MX IC Identification Module support"
>>  	depends on ARCH_MXC || COMPILE_TEST
>> diff --git a/drivers/nvmem/Makefile b/drivers/nvmem/Makefile
>> index 70a4464dcb1e25cf9116280a32f4a0f4f9941a75..920a536fc359a5a7d8f3aabba6a712e85c277ee7 100644
>> --- a/drivers/nvmem/Makefile
>> +++ b/drivers/nvmem/Makefile
>> @@ -20,6 +20,8 @@ obj-$(CONFIG_NVMEM_BCM_OCOTP)		+= nvmem-bcm-ocotp.o
>>  nvmem-bcm-ocotp-y			:= bcm-ocotp.o
>>  obj-$(CONFIG_NVMEM_BRCM_NVRAM)		+= nvmem_brcm_nvram.o
>>  nvmem_brcm_nvram-y			:= brcm_nvram.o
>> +obj-$(CONFIG_NVMEM_EXYNOS_OTP)		+= nvmem-exynos-otp.o
>> +nvmem-exynos-otp-y			:= exynos-otp.o
>>  obj-$(CONFIG_NVMEM_IMX_IIM)		+= nvmem-imx-iim.o
>>  nvmem-imx-iim-y				:= imx-iim.o
>>  obj-$(CONFIG_NVMEM_IMX_OCOTP)		+= nvmem-imx-ocotp.o
>> diff --git a/drivers/nvmem/exynos-otp.c b/drivers/nvmem/exynos-otp.c
>> new file mode 100644
>> index 0000000000000000000000000000000000000000..3bff9421e6f2b80a8f20533b490a289687d117e8
>> --- /dev/null
>> +++ b/drivers/nvmem/exynos-otp.c
>> @@ -0,0 +1,98 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Copyright 2025 Linaro Ltd.
>> + *
>> + * Samsung Exynos OTP driver.
>> + */
>> +
>> +#include <linux/clk.h>
>> +#include <linux/device.h>
>> +#include <linux/err.h>
>> +#include <linux/ioport.h>
>> +#include <linux/module.h>
>> +#include <linux/nvmem-provider.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/regmap.h>
>> +#include <linux/mod_devicetable.h>
>> +
>> +struct exynos_otp {
>> +	struct clk *pclk;
>> +	struct regmap *regmap;
>> +};
>> +
>> +static int exynos_otp_read(void *context, unsigned int offset, void *val,
>> +			   size_t bytes)
>> +{
>> +	struct exynos_otp *eotp = context;
>> +
>> +	return regmap_bulk_read(eotp->regmap, offset, val, bytes / 4);
> 
> 
> So you are just reading MMIO and pretending this is NVMEM?

Right. I thought of registering the OTP register space as a nvmem
device, so that consumers can read it. The OTP memory space (32Kbit,
the one accessed via OTP commands) can then be registered as another
nvmem device.

> 
> Is it possible to actually do the other actions from your commit msg
> "read/program/lock"? If not, then you just created NVMEM abstraction

It is possible to add support for the OTP memory space (32Kbit) and model
it as a nvmem device, but I don't really care about it because downstream
does not use the OTP memory space in the kernel.

I now think that the correct way to handle the chipid for gs101 is to
register to the SoC interface directly from the efuse driver. Support
for the OTP memory space can come later on if needed, I don't really need
to register any nvmem space for now.

Thanks,
ta

> over existing chipid completely duplicating the driver (with more
> translation layers).
> 
> Best regards,
> Krzysztof

