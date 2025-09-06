Return-Path: <linux-kernel+bounces-804282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17A78B46FE4
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 16:06:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC0743ADE61
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 14:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83FDE1CEAD6;
	Sat,  6 Sep 2025 14:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N8JMyqrM"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 776E81A2389;
	Sat,  6 Sep 2025 14:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757167583; cv=none; b=LbP7ONUw892kvE7yEedqUkJWC7UEWddCB2y3GtfymL+rrmHlc0Zx1NR5idhp21znaBphN4st0x4skUAQ/cSOkzHAgvDkw3fw2si/ozeyQxbmP7NYSOtP42FbjEaZhERuElHiyRCXbeFGFckb60qljwrmiArUbT1F0GoXO2csEwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757167583; c=relaxed/simple;
	bh=0hmzZXYxNKjIhDz+m1zGKrFgn23Dpx3WLUp+j6lBU5o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b2cANXLXHUqMDz6tEd5LFHKIjoVdlECdmicRP6zIYEm17PdoFnAvjcqWUeR23WbvINyifW9zuZgtUqkFA5ExlHwpTlQUSa4aZkR8icKKDqD1jV5EH/NODnWZnlUbO2mo6ga/J1GbmXzwwqZ1Hl/WmH5FeOPPMG8LwGAOZQ0Vfqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N8JMyqrM; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2445806e03cso39733365ad.1;
        Sat, 06 Sep 2025 07:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757167581; x=1757772381; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=rJqmB1Acck+ApY3q4nwCXeXJnDu3kt/0e3WOirNx8ss=;
        b=N8JMyqrMDu2lR833xIue5m+AQicipbimLUy5g4xxtAbDCLZpgLNTgS7NuE5odBEUJD
         rCVEfIAyhjoGKGYo4sxFMDIXNv6OIgjkmoelNtNmLbn0aiDNC3OSkeXYnGo4D40iOOgY
         pRaVhc28sq6C2kX0SjToC9/t7BZFVN53NchKA7ZMxJeliUe7Nzk3kFn78eHyqsgNzCkQ
         iMKYw2SS6ZK0JlpFMgEOSr0tQdbYzWHrr1t0jKuxT0VA+vWLwcVmhm0cpqerEkpOcXy7
         mw0uLmQYY0Vp/Vz4Gry3Fkyjkm9ukPi+E5ZD7pS+phzAGE5cWED/DAeUnE4bToOgnQLR
         28og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757167581; x=1757772381;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rJqmB1Acck+ApY3q4nwCXeXJnDu3kt/0e3WOirNx8ss=;
        b=ZrYw082ZtgVY4kK9broIA2Wqj9AjG6VTaF0bw8BMiWWrPTdzt2OnOVOy6nHEVE8opw
         XDJNBvNCddn5SbUEv6jEIlbL4L0nK9f2f3FL+Q3O6IP7dfacEbi/2Di+cl5fJnAf1Drb
         UrNP9RWx1fddfJ7w0RLoZ7nY0VtlquNJUDThEwXegWeuQOpEM/v9sIGlLIiTAmuNr6KF
         sGnIqQRCEv3B+r5t/bJkOvrqgjYEEylZAdeag+Vvz98p8r+4QuFx84ge6LlwPbH4Qhoc
         DCa4DLGelLJR/G0bXP8DiQna9JYDHTTwucOY293C598dyL29ug7WqIZuVZvbYMPNW4Mn
         rCow==
X-Forwarded-Encrypted: i=1; AJvYcCUNQL9LofsuMtIsKgoATy4uG0LaFafhXk3AiIzkgHWxQPF8RECbiT+U9SoLM3oB78RazThdVTGSmIikF/0=@vger.kernel.org, AJvYcCV1R497L033x3AgUJzQFa/8aBM0FWLeWq5di4EWgxwMl+CV1AZZNEG7ejYMyW1d1aBSn+mPOKgrdGU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVvADWrXIoDSYtGu5xBqF129r0z2SA/aQ/V6BTIo2+XL1JV4Ig
	XhfUJiNPodjsCbjRbrF3twXTP7uuMmgbC/t08LU+LR5rJuHY1lc0hmUq
X-Gm-Gg: ASbGncuxrQsF65wSrye48MAIMeOTMVsMvcC4AWy/Qf2hXv0JJol5HDBRgl1Q4Ve5u8J
	fQ2YxyCj3a3RDYuFNxd9OSkHwcjEYZDmIL+SOR4acpAYGd0Ls21x9rXWHB+6pxUMqJeW/Z3H6I5
	qBjh3kmXGGD4HtLPmGSq+uqPAVwC30CvPy320/V3GdA0sEPfBhzCaIkSHzdEXj5d4aV3ZtvE0sx
	Ky2YpevyGUatFhkUvrJU7adluv50dNk9uFu8L10MziTwcJNi+iChejQo4E2GjbLCiNwrYQjbWYp
	wMYnj/+qky68Vo/w5NnTO5O7uxot6x+qNxHlqFmiXJ3WuKlTGNYwSHjJyN23MNC70lXc50EY5j+
	jmC4t7dPP3dpGmI6UUiabbYo64hlAkUO+ycG8XhLinDjAKy+4Cs8iftnpAtJMNsJc28mPUrdTDP
	C5wd6CJw==
X-Google-Smtp-Source: AGHT+IFLO2aMTzUGaIbcHtiVgPQuMiIUV2cpKCgHWEqJFjdACMtSFQ31JYoq/lo0xxJFF1dBxmgTeg==
X-Received: by 2002:a17:902:fc44:b0:24b:62ef:9d38 with SMTP id d9443c01a7336-2516e887fd5mr30289215ad.19.1757167580556;
        Sat, 06 Sep 2025 07:06:20 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24e18bf05dcsm39013605ad.147.2025.09.06.07.06.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 Sep 2025 07:06:19 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <c6694917-fbfd-432d-ab17-f5f9b7232e7c@roeck-us.net>
Date: Sat, 6 Sep 2025 07:06:18 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 1/2] hwmon: add GPD devices sensor driver
To: cryolitia@uniontech.com, Jean Delvare <jdelvare@suse.com>,
 Jonathan Corbet <corbet@lwn.net>
Cc: linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
 linux-doc@vger.kernel.org, Celeste Liu <CoelacanthusHex@gmail.com>,
 Yao Zi <ziyao@disroot.org>, Derek John Clark <derekjohn.clark@gmail.com>,
 Jun Zhan <zhanjun@uniontech.com>, Cheng Nie <niecheng1@uniontech.com>,
 =?UTF-8?Q?Marcin_Str=C4=85gowski?= <marcin@stragowski.com>,
 someone5678 <someone5678.dev@gmail.com>,
 Justin Weiss <justin@justinweiss.com>, Antheas Kapenekakis
 <lkml@antheas.dev>, command_block <mtf@ik.me>, derjohn <himself@derjohn.de>,
 Crashdummyy <crashdummy1337@proton.me>
References: <20250904-gpd_fan-v8-0-0752584f16da@uniontech.com>
 <20250904-gpd_fan-v8-1-0752584f16da@uniontech.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <20250904-gpd_fan-v8-1-0752584f16da@uniontech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/4/25 01:33, Cryolitia PukNgae via B4 Relay wrote:
> From: Cryolitia PukNgae <cryolitia@uniontech.com>
> 
> Sensors driver for GPD Handhelds that expose fan reading and control via
> hwmon sysfs.
> 
> Shenzhen GPD Technology Co., Ltd. manufactures a series of handheld
> devices. This driver implements these functions through x86 port-mapped
> IO.
> 
> Tested-by: Marcin Strągowski <marcin@stragowski.com>
> Tested-by: someone5678 <someone5678.dev@gmail.com>
> Tested-by: Justin Weiss <justin@justinweiss.com>
> Tested-by: Antheas Kapenekakis <lkml@antheas.dev>
> Tested-by: command_block <mtf@ik.me>
> Tested-by: derjohn <himself@derjohn.de>
> Tested-by: Crashdummyy <crashdummy1337@proton.me>
> Signed-off-by: Cryolitia PukNgae <cryolitia@uniontech.com>
> ---
>   MAINTAINERS             |   6 +
>   drivers/hwmon/Kconfig   |  10 +
>   drivers/hwmon/Makefile  |   1 +
>   drivers/hwmon/gpd-fan.c | 786 ++++++++++++++++++++++++++++++++++++++++++++++++
>   4 files changed, 803 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 6dcfbd11efef87927041f5cf58d70633dbb4b18d..14a616be5ff08aaeee52436dff54a86c4a81e5fb 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -10421,6 +10421,12 @@ F:	drivers/phy/samsung/phy-gs101-ufs.c
>   F:	include/dt-bindings/clock/google,gs101.h
>   K:	[gG]oogle.?[tT]ensor
>   
> +GPD FAN DRIVER
> +M:	Cryolitia PukNgae <cryolitia@uniontech.com>
> +L:	linux-hwmon@vger.kernel.org
> +S:	Maintained
> +F:	drivers/hwmon/gpd-fan.c
> +
>   GPD POCKET FAN DRIVER
>   M:	Hans de Goede <hansg@kernel.org>
>   L:	platform-driver-x86@vger.kernel.org
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index 9d28fcf7cd2a6f9e2f54694a717bd85ff4047b46..a552a5ced64d0fee2c80a5399ce9d1f0dbd7d763 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -769,6 +769,16 @@ config SENSORS_GL520SM
>   	  This driver can also be built as a module. If so, the module
>   	  will be called gl520sm.
>   
> +config SENSORS_GPD
> +	tristate "GPD handhelds"
> +	depends on X86
> +	help
> +	  If you say yes here you get support for fan readings and
> +	  control over GPD handheld devices.
> +
> +	  Can also be built as a module. In that case it will be
> +	  called gpd-fan.
> +
>   config SENSORS_G760A
>   	tristate "GMT G760A"
>   	depends on I2C
> diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
> index cd8bc4752b4dbf015c6eb46157626f4e8f87dfae..051981eb8a5089608e9eb351a1d5857805c728c8 100644
> --- a/drivers/hwmon/Makefile
> +++ b/drivers/hwmon/Makefile
> @@ -88,6 +88,7 @@ obj-$(CONFIG_SENSORS_GIGABYTE_WATERFORCE) += gigabyte_waterforce.o
>   obj-$(CONFIG_SENSORS_GL518SM)	+= gl518sm.o
>   obj-$(CONFIG_SENSORS_GL520SM)	+= gl520sm.o
>   obj-$(CONFIG_SENSORS_GSC)	+= gsc-hwmon.o
> +obj-$(CONFIG_SENSORS_GPD)	+= gpd-fan.o
>   obj-$(CONFIG_SENSORS_GPIO_FAN)	+= gpio-fan.o
>   obj-$(CONFIG_SENSORS_GXP_FAN_CTRL) += gxp-fan-ctrl.o
>   obj-$(CONFIG_SENSORS_HIH6130)	+= hih6130.o
> diff --git a/drivers/hwmon/gpd-fan.c b/drivers/hwmon/gpd-fan.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..4a9ae049a78524caa0fd608c119eb34c333429ae
> --- /dev/null
> +++ b/drivers/hwmon/gpd-fan.c
> @@ -0,0 +1,786 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +
> +/* Platform driver for GPD devices that expose fan control via hwmon sysfs.
> + *
> + * Fan control is provided via pwm interface in the range [0-255].
> + * Each model has a different range in the EC, the written value is scaled to
> + * accommodate for that.
> + *
> + * Based on this repo:
> + * https://github.com/Cryolitia/gpd-fan-driver
> + *
> + * Copyright (c) 2024 Cryolitia PukNgae
> + */
> +
> +#include <linux/acpi.h>
> +#include <linux/dmi.h>
> +#include <linux/hwmon.h>
> +#include <linux/ioport.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +
> +#define DRIVER_NAME "gpdfan"
> +#define GPD_PWM_CTR_OFFSET 0x1841
> +
> +static char *gpd_fan_board = "";
> +module_param(gpd_fan_board, charp, 0444);
> +
> +// EC read/write locker, protecting single EC access
> +// Should never access EC at the same time, otherwise system down.
> +static DEFINE_MUTEX(gpd_fan_atomic_lock);

Why keep this lock ? Each access sequence is now locked in the top
level read/write function, which should make this lock redundant.

Guenter


