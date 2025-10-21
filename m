Return-Path: <linux-kernel+bounces-862651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A608BF5D80
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 12:40:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFD2118963EF
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 10:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E997FA926;
	Tue, 21 Oct 2025 10:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mCO8/qph"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32BF22E7F0D
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 10:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761043198; cv=none; b=SAfg8QTN5InYRdGR+Pv7n3om1PsD6X/fzECEJKkZfOqRbslXaowEVPeo5pd/ExYs9X7FiZbzcSX396e3unAJPmqepwiRqf2/jXBSEZSWabrZhq9pjtLmQtaOU0ImDgya/R/hOQQbMc//Egiimv1avKymIYZcnmYiyRyeCGQYxu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761043198; c=relaxed/simple;
	bh=HiT61yHt9RlARiij/oOCBEVR1Y9KWEKKGEyCGUCBbRs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=d5JbVoS5APMShi+s55eACyC8PXt8R/IUejUhJL2sGh1C4gN4uLpOiVUhWofXlqIY94lsPdHBe8Oei2EApbBWvhdR4rmAh6/NEh6QyhEezkDSTvFGhTRdMm/Wh6cNyLyOVC7GYa8AowVgKz85m7XuE5vyiqg89zDk9qmC9T6gVh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mCO8/qph; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-47103531eeeso2546885e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 03:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761043194; x=1761647994; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=A/OnagZOd49kquzcKUZUnNV3KCB913TBK/QbnvmKKOM=;
        b=mCO8/qph7cpNcr/3B5f+NwRs9AhdYFgh5R4lH+D4j/uc5dsiTkjdMJ4wpujqZhMF6y
         LLAA3m5zeXvDaHx279Fv0LH7L+rjK5J9FTuQOJodOnx/RftngyPmsJ9WW1930yoJyUma
         a/GbvjNvClUag33MxijW1bi05TMQvQikCiZ3nE5BFvL3IbQLyrRMhSoNvvVZl84P5BNS
         LUrQ8wkIa2qEWnvbH/IaLqJ3WT4+p2QWh4/cOr7sHFSqSGCBgt46J46hemFQ2JaRY4IB
         MCOhrZ4qBni2ms4MDipVdLfSkkKx8GoT++0GeRbiszdvC0M7JJynzA6JKG3U6mLw3JA4
         xFMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761043194; x=1761647994;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A/OnagZOd49kquzcKUZUnNV3KCB913TBK/QbnvmKKOM=;
        b=oiln6RIWZ/VVJcMNSCGm3/PVnuE3OhGjdVcq0jbuNmP5NaHMFfCGwY9BQsTh20k7u8
         VWTZXYXkT3vhGYxIUeczE2Vxf19SP0akBzjCtdeIdNwlMQNDD5KTkFfhHt2EkDIFXeXB
         GNH8GJAURtY76tUfmtGZlNxOs51/yCtQb+qFCKnwvjs4s+QlP6fusrp54l6MYenPD2A6
         434cyIsVtWWAGpoWah/rnh9sWGXsj1nlpDZVECKpTrmwOYQXZq9eSJfT/ONvdj/snp6e
         aK3JEg/t2bKqdOaN6zRfOs1EAWPQ21APqRCQje3ZafnTVkK7aHCi0j3vZvxK6EMC2qbP
         quFw==
X-Forwarded-Encrypted: i=1; AJvYcCWk2P/i2+9JOmt5hXedH/tBE5DMPlVrMCMEcSngscjuhAnFssA/ZTIU8c+g4CNrjER9pwZ7ufEQKzXEOo8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbC+ey3Nx+aIBN96AXVKNrqOJXe+k5I0agVTGk6N8PBxIe5Tp+
	hAMRRit2n7suj809RqZGyhUE9KWo3ce1eKmt/ByoYlvc7WM/gr+LdszmzjhB7aGOWRo=
X-Gm-Gg: ASbGncs8FapVC5wnekfw6DePUwnF12mR0Cg7QCWI9TOuFzLdMAt2vC2UzVYI/0a0jWH
	bIlga616SlK8XHM2PxMw+ZLpFOTzisCB+iOsqZIBRYadwv43Nxib/1zAyEAHTockmzmEor+UWTn
	F7DetCZK2pvDEKEv8BsmaUK2+2ByGTGznMX9WX4dc1TCyqyobUZsxir1Gu4Auipks1KFI24AmHS
	CSTOk46scRir/Ee01MY+2NnKbSHjBSJ6YT3UPEmgJPWTfUKAwMa8ej2g2s1ssjybyiVNFiU0Vub
	jKw0n1r72Fy8Sf2FE9O4DJL0ch7NMns5qOUPffNsS956m3PaMXpFCguJF+IYmKmIdt1Se3shXF0
	mzW49lAqlp6FewCtncoRm4qqwbLufR4jjpLEytLaUAAf6er+KMm2U3HOat1o3nHlLlDryfPbMvf
	F7XtKEYN6ATP9oxgQSbMhy/9de2Cg9z8I=
X-Google-Smtp-Source: AGHT+IGKmEbIyGIWYasVJF582yyEbV5sDX37Ylv4mXv7hL6gmWX36S89JOQB3kSZ/4mOFvKH7u8hEA==
X-Received: by 2002:a05:600c:1d25:b0:471:152a:e574 with SMTP id 5b1f17b1804b1-474942c4fa0mr15074935e9.2.1761043194470;
        Tue, 21 Oct 2025 03:39:54 -0700 (PDT)
Received: from [192.168.1.29] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47496c43f68sm14035415e9.5.2025.10.21.03.39.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 03:39:53 -0700 (PDT)
Message-ID: <406c40be-757b-44d1-b6a1-a5d6d4d07e6f@linaro.org>
Date: Tue, 21 Oct 2025 12:39:52 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/4] mfd: sony-cronos-smc: Add driver for Sony Cronos
 SMC
To: Timothy Pearson <tpearson@raptorengineering.com>,
 devicetree <devicetree@vger.kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>, Rob Herring
 <robh+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Lee Jones <lee@kernel.org>, Georgy Yakovlev <Georgy.Yakovlev@sony.com>
References: <1787448596.1802034.1760983830792.JavaMail.zimbra@raptorengineeringinc.com>
 <1587929609.1802041.1760983921227.JavaMail.zimbra@raptorengineeringinc.com>
 <13657666.1802042.1760984066594.JavaMail.zimbra@raptorengineeringinc.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 xsFNBFVDQq4BEAC6KeLOfFsAvFMBsrCrJ2bCalhPv5+KQF2PS2+iwZI8BpRZoV+Bd5kWvN79
 cFgcqTTuNHjAvxtUG8pQgGTHAObYs6xeYJtjUH0ZX6ndJ33FJYf5V3yXqqjcZ30FgHzJCFUu
 JMp7PSyMPzpUXfU12yfcRYVEMQrmplNZssmYhiTeVicuOOypWugZKVLGNm0IweVCaZ/DJDIH
 gNbpvVwjcKYrx85m9cBVEBUGaQP6AT7qlVCkrf50v8bofSIyVa2xmubbAwwFA1oxoOusjPIE
 J3iadrwpFvsZjF5uHAKS+7wHLoW9hVzOnLbX6ajk5Hf8Pb1m+VH/E8bPBNNYKkfTtypTDUCj
 NYcd27tjnXfG+SDs/EXNUAIRefCyvaRG7oRYF3Ec+2RgQDRnmmjCjoQNbFrJvJkFHlPeHaeS
 BosGY+XWKydnmsfY7SSnjAzLUGAFhLd/XDVpb1Een2XucPpKvt9ORF+48gy12FA5GduRLhQU
 vK4tU7ojoem/G23PcowM1CwPurC8sAVsQb9KmwTGh7rVz3ks3w/zfGBy3+WmLg++C2Wct6nM
 Pd8/6CBVjEWqD06/RjI2AnjIq5fSEH/BIfXXfC68nMp9BZoy3So4ZsbOlBmtAPvMYX6U8VwD
 TNeBxJu5Ex0Izf1NV9CzC3nNaFUYOY8KfN01X5SExAoVTr09ewARAQABzTRLcnp5c3p0b2Yg
 S296bG93c2tpIDxrcnp5c3p0b2Yua296bG93c2tpQGxpbmFyby5vcmc+wsGUBBMBCgA+AhsD
 BQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAFiEEm9B+DgxR+NWWd7dUG5NDfTtBYpsFAmgXUEoF
 CRaWdJoACgkQG5NDfTtBYpudig/+Inb3Kjx1B7w2IpPKmpCT20QQQstx14Wi+rh2FcnV6+/9
 tyHtYwdirraBGGerrNY1c14MX0Tsmzqu9NyZ43heQB2uJuQb35rmI4dn1G+ZH0BD7cwR+M9m
 lSV9YlF7z3Ycz2zHjxL1QXBVvwJRyE0sCIoe+0O9AW9Xj8L/dmvmRfDdtRhYVGyU7fze+lsH
 1pXaq9fdef8QsAETCg5q0zxD+VS+OoZFx4ZtFqvzmhCs0eFvM7gNqiyczeVGUciVlO3+1ZUn
 eqQnxTXnqfJHptZTtK05uXGBwxjTHJrlSKnDslhZNkzv4JfTQhmERyx8BPHDkzpuPjfZ5Jp3
 INcYsxgttyeDS4prv+XWlT7DUjIzcKih0tFDoW5/k6OZeFPba5PATHO78rcWFcduN8xB23B4
 WFQAt5jpsP7/ngKQR9drMXfQGcEmqBq+aoVHobwOfEJTErdku05zjFmm1VnD55CzFJvG7Ll9
 OsRfZD/1MKbl0k39NiRuf8IYFOxVCKrMSgnqED1eacLgj3AWnmfPlyB3Xka0FimVu5Q7r1H/
 9CCfHiOjjPsTAjE+Woh+/8Q0IyHzr+2sCe4g9w2tlsMQJhixykXC1KvzqMdUYKuE00CT+wdK
 nXj0hlNnThRfcA9VPYzKlx3W6GLlyB6umd6WBGGKyiOmOcPqUK3GIvnLzfTXR5DOwU0EVUNc
 NAEQAM2StBhJERQvgPcbCzjokShn0cRA4q2SvCOvOXD+0KapXMRFE+/PZeDyfv4dEKuCqeh0
 hihSHlaxTzg3TcqUu54w2xYskG8Fq5tg3gm4kh1Gvh1LijIXX99ABA8eHxOGmLPRIBkXHqJY
 oHtCvPc6sYKNM9xbp6I4yF56xVLmHGJ61KaWKf5KKWYgA9kfHufbja7qR0c6H79LIsiYqf92
 H1HNq1WlQpu/fh4/XAAaV1axHFt/dY/2kU05tLMj8GjeQDz1fHas7augL4argt4e+jum3Nwt
 yupodQBxncKAUbzwKcDrPqUFmfRbJ7ARw8491xQHZDsP82JRj4cOJX32sBg8nO2N5OsFJOcd
 5IE9v6qfllkZDAh1Rb1h6DFYq9dcdPAHl4zOj9EHq99/CpyccOh7SrtWDNFFknCmLpowhct9
 5ZnlavBrDbOV0W47gO33WkXMFI4il4y1+Bv89979rVYn8aBohEgET41SpyQz7fMkcaZU+ok/
 +HYjC/qfDxT7tjKXqBQEscVODaFicsUkjheOD4BfWEcVUqa+XdUEciwG/SgNyxBZepj41oVq
 FPSVE+Ni2tNrW/e16b8mgXNngHSnbsr6pAIXZH3qFW+4TKPMGZ2rZ6zITrMip+12jgw4mGjy
 5y06JZvA02rZT2k9aa7i9dUUFggaanI09jNGbRA/ABEBAAHCwXwEGAEKACYCGwwWIQSb0H4O
 DFH41ZZ3t1Qbk0N9O0FimwUCaBdQXwUJFpZbKgAKCRAbk0N9O0Fim07TD/92Vcmzn/jaEBcq
 yT48ODfDIQVvg2nIDW+qbHtJ8DOT0d/qVbBTU7oBuo0xuHo+MTBp0pSTWbThLsSN1AuyP8wF
 KChC0JPcwOZZRS0dl3lFgg+c+rdZUHjsa247r+7fvm2zGG1/u+33lBJgnAIH5lSCjhP4VXiG
 q5ngCxGRuBq+0jNCKyAOC/vq2cS/dgdXwmf2aL8G7QVREX7mSl0x+CjWyrpFc1D/9NV/zIWB
 G1NR1fFb+oeOVhRGubYfiS62htUQjGLK7qbTmrd715kH9Noww1U5HH7WQzePt/SvC0RhQXNj
 XKBB+lwwM+XulFigmMF1KybRm7MNoLBrGDa3yGpAkHMkJ7NM4iSMdSxYAr60RtThnhKc2kLI
 zd8GqyBh0nGPIL+1ZVMBDXw1Eu0/Du0rWt1zAKXQYVAfBLCTmkOnPU0fjR7qVT41xdJ6KqQM
 NGQeV+0o9X91X6VBeK6Na3zt5y4eWkve65DRlk1aoeBmhAteioLZlXkqu0pZv+PKIVf+zFKu
 h0At/TN/618e/QVlZPbMeNSp3S3ieMP9Q6y4gw5CfgiDRJ2K9g99m6Rvlx1qwom6QbU06ltb
 vJE2K9oKd9nPp1NrBfBdEhX8oOwdCLJXEq83vdtOEqE42RxfYta4P3by0BHpcwzYbmi/Et7T
 2+47PN9NZAOyb771QoVr8A==
In-Reply-To: <13657666.1802042.1760984066594.JavaMail.zimbra@raptorengineeringinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 20/10/2025 20:14, Timothy Pearson wrote:
> The Sony Cronos Platform Controller is a multi-purpose platform controller
> that provides both a watchdog timer and an LED controller for the Sony
> Interactive Entertainment Cronos x86 server platform. As both functions
> are provided by the same CPLD, a multi-function device is exposed as the
> parent of both functions.
> 
> Signed-off-by: Timothy Pearson <tpearson@raptorengineering.com>
> Signed-off-by: Shawn Anastasio <sanastasio@raptorengineering.com>

Your threading is completely broken. git format-patch -v4 -4 --cover-letter.

Or just use b4.

https://elixir.bootlin.com/linux/v6.16-rc2/source/Documentation/process/submitting-patches.rst#L830

> ---
>  MAINTAINERS                     |   7 ++
>  drivers/mfd/Kconfig             |  11 ++
>  drivers/mfd/Makefile            |   2 +
>  drivers/mfd/sony-cronos-smc.c   | 212 ++++++++++++++++++++++++++++++++
>  include/linux/mfd/sony-cronos.h |  61 +++++++++
>  5 files changed, 293 insertions(+)
>  create mode 100644 drivers/mfd/sony-cronos-smc.c
>  create mode 100644 include/linux/mfd/sony-cronos.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 545a4776795e..8570b12a3f66 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -23881,6 +23881,13 @@ S:	Maintained
>  F:	drivers/ssb/
>  F:	include/linux/ssb/
>  
> +SONY CRONOS SMC DRIVER
> +M:	Georgy Yakovlev <Georgy.Yakovlev@sony.com>
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/mfd/sony,cronos-smc.yaml
> +F:	drivers/mfd/sony-cronos-smc.c
> +F:	include/linux/mfd/sony-cronos.h
> +
>  SONY IMX208 SENSOR DRIVER
>  M:	Sakari Ailus <sakari.ailus@linux.intel.com>
>  L:	linux-media@vger.kernel.org
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index 6cec1858947b..1b08f5ae648d 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -2382,6 +2382,17 @@ config MFD_QCOM_PM8008
>  	  under it in the device tree. Additional drivers must be enabled in
>  	  order to use the functionality of the device.
>  
> +config MFD_SONY_CRONOS_SMC
> +	tristate "Sony Cronos System Management Controller"
> +	select MFD_CORE
> +	select REGMAP_I2C
> +	depends on I2C && OF
> +	help
> +      Support for the Sony Cronos system controller. Additional drivers must
> +      be enabled in order to use the functionality of the device, including LED
> +      control and the system watchdog. The controller itself is a custom design
> +      tailored to the specific needs of the Sony Cronos hardware platform.
> +
>  menu "Multimedia Capabilities Port drivers"
>  	depends on ARCH_SA1100
>  
> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> index 865e9f12faff..99700f423fe7 100644
> --- a/drivers/mfd/Makefile
> +++ b/drivers/mfd/Makefile
> @@ -300,6 +300,8 @@ obj-$(CONFIG_MFD_QNAP_MCU)	+= qnap-mcu.o
>  obj-$(CONFIG_MFD_RSMU_I2C)	+= rsmu_i2c.o rsmu_core.o
>  obj-$(CONFIG_MFD_RSMU_SPI)	+= rsmu_spi.o rsmu_core.o
>  
> +obj-$(CONFIG_MFD_SONY_CRONOS_SMC)	+= sony-cronos-smc.o
> +
>  obj-$(CONFIG_MFD_UPBOARD_FPGA)	+= upboard-fpga.o
>  
>  obj-$(CONFIG_MFD_LOONGSON_SE)	+= loongson-se.o
> diff --git a/drivers/mfd/sony-cronos-smc.c b/drivers/mfd/sony-cronos-smc.c
> new file mode 100644
> index 000000000000..9d9b5402f89b
> --- /dev/null
> +++ b/drivers/mfd/sony-cronos-smc.c
> @@ -0,0 +1,212 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Device driver for Sony Cronos SMCs
> + * Copyright (C) 2015-2017  Dialog Semiconductor
> + * Copyright (C) 2022-2025  Raptor Engineering, LLC
> + */
> +
> +#include <linux/device.h>
> +#include <linux/i2c.h>
> +#include <linux/init.h>
> +#include <linux/interrupt.h>
> +#include <linux/kernel.h>
> +#include <linux/mfd/core.h>
> +#include <linux/mfd/sony-cronos.h>
> +#include <linux/module.h>
> +#include <linux/regmap.h>
> +
> +static const struct mfd_cell cronos_smc_devs[] = {
> +	{
> +		.name = "cronos-watchdog",
> +		.of_compatible = "sony,cronos-watchdog",

Undocumented compatible drop.

Best regards,
Krzysztof

