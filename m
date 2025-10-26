Return-Path: <linux-kernel+bounces-870478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C824C0AE71
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 18:08:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 194DB189DA9B
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 17:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EEB52749D6;
	Sun, 26 Oct 2025 17:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D84BdFED"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3814325DAF0
	for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 17:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761498491; cv=none; b=rnNOl83G9RUK96vAnC1470/KD9xwIZF5Mk/pZDPr0sCGFHiTIx3eH/WSUDHfgL4ef/1UNL0G6oeGTT8rkxc70IjR8tG3qBWLiYyHc9Pj+rnhXekdB/0sw1CMRTcaTF7uA3dDQ6QOxZVOBoLeX9q1Z/a9ezBxRgB8x65yi+ayoTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761498491; c=relaxed/simple;
	bh=JA0cr1WtMe66c0M16uNSBsyO/Qwn9wH3wOhl4kzL0lk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Nr1rWqLhfJ4+kPpEuRKwxYUAMb3wwPSlzD5xCYUvdlqnjZqBQrZG5+ZSQj9pnsVyuklVXqOseXUkuaaIjKpAqf1ycM15WOYMwJliQnLOEa9UFRdns086ril8KeF5FH/nBJh20M8qlEF+V/I7WIeNzsT1EIqyclRsm63uuEpvFr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D84BdFED; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-794e300e20dso4269174b3a.1
        for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 10:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761498486; x=1762103286; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=hB4lxzQaqQNs+IFIZTwj7uIEMnSmUmHwrwgY6tz9iZk=;
        b=D84BdFEDplnGpvzWtsQP+jgDooAgVfIs8S1MWRvGSxVIpX6vzH8XgAPkqqLf0HP4+Z
         6BEO9iTk+97Y8jufj5qXiKV3UIGY935d71Hjy9r01OpbTL8DOG2taZ4PkHiNlRuzBPdC
         Pihuz9ZlHRUTUBcZDg8bXreAJPVjaV4rBw+Lp/odhfmgZJ1hT9I8Vguosta8bEy6keZI
         8NYe82SFjzIQrH3tY92zF/fkOMLVYlCiNp6nbMSQ/Dql9DsvzvJdn+ugg3f56uEbmn4f
         QHoY4BE7MYXnBXPG1/GQ/JZ74HjxFe9rBCYzxz8wm5F2nhggT9LTTtQgnRGMZWKBtSk3
         FkeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761498486; x=1762103286;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hB4lxzQaqQNs+IFIZTwj7uIEMnSmUmHwrwgY6tz9iZk=;
        b=nwodifaAbhO2J/gcb3Cz2NOuVrgR+zEsWlF26AImzoMvdZalmPIqQXGRZWg7LjAn3h
         d/6GOjGxb6UO6fpAb49a+woqDch2OYCOnTPqVgzi5iBRcOXfh18CJ5ecBzTpEPgZkrnG
         1Q81meuKpYaqQkPLz+voP1kgulB02VIG/peC0V7yCHlKScMhUR0eL2HJEtwKYT7tSh72
         zdhkfQ8jR4xQkmrS3pKlrtyjroq+Zs+Uv1ypAskRmtWjpMWZ+SnqMfdN7VSCYYV6nTSE
         A9TtIE/xBgYq3+wQWQR5pj+C9r9j2Z3tEdisE12hS1QfiwJsh/LL8o41ZLoALjV1cTl2
         L54g==
X-Forwarded-Encrypted: i=1; AJvYcCVhRdyEwnoc8rQQkqbCsyaaVX+9hUK/TjoK/DnVJZW5fRCFS6AqqnK22yE1XBX9gFKF6ovV6CQCxQmWNoo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrpkDWSPMDdHHRAYGVNDv6Yg0G+BYPgTdvj3BjqcHPBaLxOr67
	ZcZJdw0u1xE0YSdHeVzWU/xgrpKE/TZKW2Fn2gDjlsM+dQuxVOP+gS9f
X-Gm-Gg: ASbGnctXWDZicaYNNWyOateVfS0Qqub3qO4s5Q6mnqtkLlDJ2B88ri5tKq9Bc1ra3kB
	pKWKph+vLuvQTL4a9Azp5+6uv8eiP2NzFsUzkm893WlCG5XHS00bnEmM+9hIPkYeAhaPsT9n96o
	WjD6w7j8pM9ftEkLtNRH67WRg8//3oFmYKPbsTrytzVB2kdwAyGbxLyVs9bn3U0rrhohjFk/UoD
	gtIR3ejigVKevSq5oTGGFL99fut4O2FYHdUaRyi/4U73COK1nA3Bg4CUw6c7qxpwxDyfXvlirhC
	d9g4dMJRfgj0rneOrrINbr6aD5s+8lvDBzALOyxEd5BzDcyLh28lSMYmarD4vxxcb32ggRapw0P
	pCVXcVL/LsKW2F+diMFPZPneVYKIsLFMLYDBo8sf8EhmaTVOfx0UOZIF52rao3SU4qOlYifxdBx
	wR0WhGZ55XneAIRuhvvn5WQEoRmZhhxSIi3MQIwO4un4grcjHe
X-Google-Smtp-Source: AGHT+IEjshJAWFlsLLahMVKqu5YCGhE93nY3QNNTTlWqTvFuBD+ZaCdK+sPHgpgal6EclL4tm3qs/w==
X-Received: by 2002:a17:90a:dfd0:b0:32b:7d35:a7e6 with SMTP id 98e67ed59e1d1-33fd3cecdbamr12080734a91.18.1761498486115;
        Sun, 26 Oct 2025 10:08:06 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b7127a09a8csm5073947a12.11.2025.10.26.10.08.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Oct 2025 10:08:05 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <d3365f32-dc92-4a55-91a1-c4a446558c5a@roeck-us.net>
Date: Sun, 26 Oct 2025 10:08:03 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] hwmon: Add TSC1641 I2C power monitor driver
To: Igor Reznichenko <igor@reznichenko.net>, linux-hwmon@vger.kernel.org
Cc: conor+dt@kernel.org, corbet@lwn.net, david.hunter.linux@gmail.com,
 devicetree@vger.kernel.org, krzk+dt@kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, robh@kernel.org, skhan@linuxfoundation.org
References: <20251022044708.314287-1-igor@reznichenko.net>
 <20251026065057.627276-1-igor@reznichenko.net>
 <20251026065057.627276-3-igor@reznichenko.net>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <20251026065057.627276-3-igor@reznichenko.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/25/25 23:50, Igor Reznichenko wrote:
> Add a driver for the ST Microelectronics TSC1641 16-bit high-precision
> power monitor. The driver supports reading bus voltage, current, power,
> and temperature. Sysfs attributes are exposed for shunt resistor and
> update interval. The driver integrates with the hwmon subsystem and
> supports optional ALERT pin polarity configuration.
> 
> Signed-off-by: Igor Reznichenko <igor@reznichenko.net>
> ---
>   Documentation/hwmon/index.rst   |   1 +
>   Documentation/hwmon/tsc1641.rst |  84 ++++
>   drivers/hwmon/Kconfig           |  12 +
>   drivers/hwmon/Makefile          |   1 +
>   drivers/hwmon/tsc1641.c         | 703 ++++++++++++++++++++++++++++++++
>   5 files changed, 801 insertions(+)
>   create mode 100644 Documentation/hwmon/tsc1641.rst
>   create mode 100644 drivers/hwmon/tsc1641.c
> 
> diff --git a/Documentation/hwmon/index.rst b/Documentation/hwmon/index.rst
> index 51a5bdf75b08..4fb9f91f83b3 100644
> --- a/Documentation/hwmon/index.rst
> +++ b/Documentation/hwmon/index.rst
> @@ -253,6 +253,7 @@ Hardware Monitoring Kernel Drivers
>      tps40422
>      tps53679
>      tps546d24
> +   tsc1641
>      twl4030-madc-hwmon
>      ucd9000
>      ucd9200
> diff --git a/Documentation/hwmon/tsc1641.rst b/Documentation/hwmon/tsc1641.rst
> new file mode 100644
> index 000000000000..f692a8ccbffc
> --- /dev/null
> +++ b/Documentation/hwmon/tsc1641.rst
> @@ -0,0 +1,84 @@
> +Kernel driver tsc1641

checkpatch:

WARNING: Missing or malformed SPDX-License-Identifier tag in line 1
#146: FILE: Documentation/hwmon/tsc1641.rst:1:
+Kernel driver tsc1641

> +=====================
> +
> +Supported chips:
> +
> +  * ST TSC1641
> +
> +    Prefix: 'tsc1641'
> +
> +    Addresses scanned: -
> +
> +    Datasheet:
> +	https://www.st.com/resource/en/datasheet/tsc1641.pdf
> +
> +Author:
> +	- Igor Reznichenko <igor@reznichenko.net>
> +
> +
> +Description
> +-----------
> +
> +The TSC1641 is a high-precision current, voltage, power, and temperature
> +monitoring analog front-end (AFE). It monitors current into a shunt resistor and
> +load voltage up to 60 V in a synchronized way. Digital bus interface is
> +I2C/SMbus. The TSC1641 allows the assertion of several alerts regarding the
> +voltage, current, power and temperature.
> +
> +Usage Notes
> +-----------
> +
> +The TSC1641 driver requires the value of the external shunt resistor to
> +correctly compute current and power measurements. The resistor value, in
> +micro-ohms, should be provided either through the device tree property
> +"shunt-resistor-micro-ohms" or via writable sysfs attribute "shunt_resistor".
> +Please refer to the Documentation/devicetree/bindings/hwmon/st,tsc1641.yaml
> +for bindings if the device tree is used.
> +
> +Supported range of shunt resistor values is from 100 uOhm to 655.35 mOhm.
> +When selecting the value keep in mind device maximum DC power measurement is
> +1600W. See datasheet p.22 for ST recommendations on selecting shunt value.
> +
> +If the shunt resistor value is not specified in the device tree, the driver
> +initializes it to 1000 uOhm by default. Users may configure the correct shunt
> +resistor value at runtime by writing to the "shunt_resistor" sysfs attribute.
> +
> +The driver only supports continuous operating mode.
> +Measurement ranges:
> +
> +================ ===============================================================
> +Current          Dependent on shunt
> +Bus voltage      0-60V
> +Maximum DC power 1600W
> +Temperature      -40C to +125C
> +================ ===============================================================
> +
> +Sysfs entries
> +-------------
> +
> +==================== ===========================================================
> +in0_input            bus voltage (mV)
> +in0_crit             bus voltage crit alarm limit (mV)
> +in0_crit_alarm       bus voltage crit alarm limit exceeded
> +in0_lcrit            bus voltage low-crit alarm limit (mV)
> +in0_lcrit_alarm      bus voltage low-crit alarm limit exceeded
> +
> +curr1_input          current measurement (mA)
> +curr1_crit           current crit alarm limit (mA)
> +curr1_crit_alarm     current crit alarm limit exceeded
> +curr1_lcrit          current low-crit alarm limit (mA)
> +curr1_lcrit_alarm    current low-crit alarm limit exceeded
> +
> +power1_input         power measurement (uW)
> +power1_crit          power crit alarm limit (uW)
> +power1_crit_alarm    power crit alarm limit exceeded
> +
> +shunt_resistor       shunt resistor value (uOhms)
> +
> +temp1_input          temperature measurement (mdegC)
> +temp1_crit           temperature crit alarm limit (mdegC)
> +temp1_crit_alarm     temperature crit alarm limit exceeded
> +
> +update_interval      data conversion time (1 - 33ms), longer conversion time
> +                     corresponds to higher effective resolution in bits
> +==================== ===========================================================
> \ No newline at end of file
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index 2760feb9f83b..b9d7b02932a6 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -2434,6 +2434,18 @@ config SENSORS_TMP513
>   	  This driver can also be built as a module. If so, the module
>   	  will be called tmp513.
>   
> +config SENSORS_TSC1641
> +	tristate "ST Microelectronics TSC1641 Power Monitor"
> +	depends on I2C
> +	select REGMAP_I2C
> +	help
> +	  If you say yes here you get support for TSC1641 power  monitor chip.
> +	  The TSC1641 driver is configured for the default configuration of
> +	  the part except temperature is enabled by default.
> +
> +	  This driver can also be built as a module. If so, the module
> +	  will be called tsc1641.
> +
>   config SENSORS_VEXPRESS
>   	tristate "Versatile Express"
>   	depends on VEXPRESS_CONFIG
> diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
> index 73b2abdcc6dd..a8de5bc69f2a 100644
> --- a/drivers/hwmon/Makefile
> +++ b/drivers/hwmon/Makefile
> @@ -233,6 +233,7 @@ obj-$(CONFIG_SENSORS_TMP401)	+= tmp401.o
>   obj-$(CONFIG_SENSORS_TMP421)	+= tmp421.o
>   obj-$(CONFIG_SENSORS_TMP464)	+= tmp464.o
>   obj-$(CONFIG_SENSORS_TMP513)	+= tmp513.o
> +obj-$(CONFIG_SENSORS_TSC1641)	+= tsc1641.o
>   obj-$(CONFIG_SENSORS_VEXPRESS)	+= vexpress-hwmon.o
>   obj-$(CONFIG_SENSORS_VIA_CPUTEMP)+= via-cputemp.o
>   obj-$(CONFIG_SENSORS_VIA686A)	+= via686a.o
> diff --git a/drivers/hwmon/tsc1641.c b/drivers/hwmon/tsc1641.c
> new file mode 100644
> index 000000000000..56f6d0ba2b49
> --- /dev/null
> +++ b/drivers/hwmon/tsc1641.c
> @@ -0,0 +1,703 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Driver for ST Microelectronics TSC1641 I2C power monitor
> + *
> + * 60 V, 16-bit high-precision power monitor with I2C and MIPI I3C interface
> + * Datasheet: https://www.st.com/resource/en/datasheet/tsc1641.pdf
> + *
> + * Copyright (C) 2025 Igor Reznichenko <igor@reznichenko.net>
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/bits.h>
> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/hwmon.h>
> +#include <linux/i2c.h>
> +#include <linux/module.h>
> +#include <linux/regmap.h>
> +#include <linux/sysfs.h>

Using find_closest() requires including linux/util_macros.h.

> +
> +/* I2C registers */
> +#define TSC1641_CONFIG		0x00
> +#define TSC1641_SHUNT_VOLTAGE	0x01
> +#define TSC1641_LOAD_VOLTAGE	0x02
> +#define TSC1641_POWER		0x03
> +#define TSC1641_CURRENT		0x04
> +#define TSC1641_TEMP		0x05
> +#define TSC1641_MASK		0x06
> +#define TSC1641_FLAG		0x07
> +#define TSC1641_RSHUNT		0x08 /* Shunt resistance */
> +#define TSC1641_SOL		0x09
> +#define TSC1641_SUL		0x0A
> +#define TSC1641_LOL		0x0B
> +#define TSC1641_LUL		0x0C
> +#define TSC1641_POL		0x0D
> +#define TSC1641_TOL		0x0E
> +#define TSC1641_MANUF_ID	0xFE /* 0x0006 */
> +#define TSC1641_DIE_ID		0xFF /* 0x1000 */
> +#define TSC1641_MAX_REG		0xFF
> +
> +#define TSC1641_RSHUNT_DEFAULT	1000   /* 1mOhm */
> +#define TSC1641_CONFIG_DEFAULT	0x003F /* Enable temperature sensor */
> +#define TSC1641_MASK_DEFAULT	0xFC00 /* Unmask all alerts */
> +
> +/* Bit mask for conversion time in the configuration register */
> +#define TSC1641_CONV_TIME_MASK	GENMASK(7, 4)
> +
> +#define TSC1641_CONV_TIME_DEFAULT	1024
> +#define TSC1641_MIN_UPDATE_INTERVAL	1024
> +
> +/* LSB value of different registers */
> +#define TSC1641_VLOAD_LSB_MVOLT		2
> +#define TSC1641_POWER_LSB_UWATT		25000
> +#define TSC1641_VSHUNT_LSB_NVOLT	2500 /* Use nanovolts to make it integer */
> +#define TSC1641_RSHUNT_LSB_UOHM		10
> +#define TSC1641_TEMP_LSB_MDEGC		500
> +
> +/* Limits based on datasheet */
> +#define TSC1641_RSHUNT_MIN_UOHM		100
> +#define TSC1641_RSHUNT_MAX_UOHM		655350
> +#define TSC1641_VLOAD_MAX_MVOLT		60000
> +#define TSC1641_CURRENT_MIN_MAMP	(-819175)
> +#define TSC1641_CURRENT_MAX_MAMP	819175
> +#define TSC1641_TEMP_MIN_MDEGC		(-20000)

Why -20000 ? The chip limit is -40 degrees C.

> +#define TSC1641_TEMP_MAX_MDEGC		145000
> +#define TSC1641_POWER_MAX_UWATT		1600000000
> +
> +#define TSC1641_ALERT_POL_MASK		BIT(1)
> +#define TSC1641_ALERT_LATCH_EN_MASK	BIT(0)
> +
> +/* Flags indicating alerts in TSC1641_FLAG register*/
> +#define TSC1641_SHUNT_OV_FLAG		BIT(6)
> +#define TSC1641_SHUNT_UV_FLAG		BIT(5)
> +#define TSC1641_LOAD_OV_FLAG		BIT(4)
> +#define TSC1641_LOAD_UV_FLAG		BIT(3)
> +#define TSC1641_POWER_OVER_FLAG		BIT(2)
> +#define TSC1641_TEMP_OVER_FLAG		BIT(1)
> +
> +static bool tsc1641_writeable_reg(struct device *dev, unsigned int reg)
> +{
> +	switch (reg) {
> +	case TSC1641_CONFIG:
> +	case TSC1641_MASK:
> +	case TSC1641_RSHUNT:
> +	case TSC1641_SOL:
> +	case TSC1641_SUL:
> +	case TSC1641_LOL:
> +	case TSC1641_LUL:
> +	case TSC1641_POL:
> +	case TSC1641_TOL:
> +		return true;
> +	default:
> +		return false;
> +	}
> +}
> +
> +static bool tsc1641_volatile_reg(struct device *dev, unsigned int reg)
> +{
> +	switch (reg) {
> +	case TSC1641_SHUNT_VOLTAGE:
> +	case TSC1641_LOAD_VOLTAGE:
> +	case TSC1641_POWER:
> +	case TSC1641_CURRENT:
> +	case TSC1641_TEMP:
> +	case TSC1641_FLAG:
> +	case TSC1641_MANUF_ID:
> +	case TSC1641_DIE_ID:
> +		return true;
> +	default:
> +		return false;
> +	}
> +}
> +
> +static const struct regmap_config tsc1641_regmap_config = {
> +	.reg_bits = 8,
> +	.val_bits = 16,
> +	.use_single_write = true,
> +	.use_single_read = true,
> +	.max_register = TSC1641_MAX_REG,
> +	.cache_type = REGCACHE_MAPLE,
> +	.volatile_reg = tsc1641_volatile_reg,
> +	.writeable_reg = tsc1641_writeable_reg,
> +};
> +
> +struct tsc1641_data {
> +	long rshunt_uohm;
> +	long current_lsb_ua;
> +	struct regmap *regmap;
> +	struct i2c_client *client;

client is not used anywhere and can be dropped.

> +};
> +
> +/*
> + * Upper limit due to chip 16-bit shunt register, lower limit to
> + * prevent current and power registers overflow
> + */
> +static inline int tsc1641_validate_shunt(u32 val)
> +{
> +	if (val < TSC1641_RSHUNT_MIN_UOHM || val > TSC1641_RSHUNT_MAX_UOHM)
> +		return -EINVAL;

In some way this is inconsistent: It accepts a shunt resistor value of, say, 105
even though the chip can only accept multiples of 10 uOhm. In situations like this
I suggest to expect devicetree values to be accurate and to clamp values entered
through sysfs. More on that below.

> +	return 0;
> +}
> +
> +static int tsc1641_set_shunt(struct tsc1641_data *data, u32 val)
> +{
> +	struct regmap *regmap = data->regmap;
> +	long rshunt_reg;
> +
> +	if (tsc1641_validate_shunt(val) < 0)
> +		return -EINVAL;
> +
> +	data->rshunt_uohm = val;
> +	data->current_lsb_ua = DIV_ROUND_CLOSEST(TSC1641_VSHUNT_LSB_NVOLT * 1000,
> +						 data->rshunt_uohm);
> +	/* RSHUNT register LSB is 10uOhm so need to divide further*/
> +	rshunt_reg = DIV_ROUND_CLOSEST(data->rshunt_uohm, TSC1641_RSHUNT_LSB_UOHM);

This means that all calculations do not use the actual shunt resistor values used
by the chip, but an approximation. I would suggest to store and use the actual shunt
resistor value instead, not the one entered by the user.

> +	return regmap_write(regmap, TSC1641_RSHUNT, clamp_val(rshunt_reg, 0, USHRT_MAX));

The shunt resistor value is already validated, so the additional clamp here is
unnecessary.

> +}
> +
> +/*
> + * Conversion times in uS, value in CONFIG[CT3:CT0] corresponds to index in this array
> + * See "Table 14. CT3 to CT0: conversion time" in:
> + * https://www.st.com/resource/en/datasheet/tsc1641.pdf
> + */
> +static const int tsc1641_conv_times[] = { 128, 256, 512, 1024, 2048, 4096, 8192, 16384, 32768 };
> +
> +static int tsc1641_reg_to_upd_interval(u16 config)
> +{
> +	int idx = FIELD_GET(TSC1641_CONV_TIME_MASK, config);
> +
> +	idx = clamp_val(idx, 0, ARRAY_SIZE(tsc1641_conv_times) - 1);
> +	int conv_time = tsc1641_conv_times[idx];
> +
> +	/* Don't support sub-millisecond update interval as it's not supported in hwmon */
> +	conv_time = max(conv_time, TSC1641_MIN_UPDATE_INTERVAL);
> +	/* Return nearest value in milliseconds */
> +	return DIV_ROUND_CLOSEST(conv_time, 1000);
> +}
> +
> +static u16 tsc1641_upd_interval_to_reg(long interval)
> +{
> +	/* Supported interval is 1ms - 33ms */
> +	interval = clamp_val(interval, 1, 33);
> +
> +	int conv = interval * 1000;
> +	int conv_bits = find_closest(conv, tsc1641_conv_times,
> +				     ARRAY_SIZE(tsc1641_conv_times));
> +
> +	return FIELD_PREP(TSC1641_CONV_TIME_MASK, conv_bits);
> +}
> +
> +static int tsc1641_chip_write(struct device *dev, u32 attr, long val)
> +{
> +	struct tsc1641_data *data = dev_get_drvdata(dev);
> +
> +	switch (attr) {
> +	case hwmon_chip_update_interval:
> +		return regmap_update_bits(data->regmap, TSC1641_CONFIG,
> +					  TSC1641_CONV_TIME_MASK,
> +					  tsc1641_upd_interval_to_reg(val));
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +}
> +
> +static int tsc1641_chip_read(struct device *dev, u32 attr, long *val)
> +{
> +	struct tsc1641_data *data = dev_get_drvdata(dev);
> +	u32 regval;
> +	int ret;
> +
> +	switch (attr) {
> +	case hwmon_chip_update_interval:
> +		ret = regmap_read(data->regmap, TSC1641_CONFIG, &regval);
> +		if (ret)
> +			return ret;
> +
> +		*val = tsc1641_reg_to_upd_interval(regval);
> +		return 0;
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +}
> +
> +static int tsc1641_alert_read(struct regmap *regmap, u32 flag, long *val)
> +{
> +	unsigned int regval;
> +	int ret;
> +
> +	ret = regmap_read_bypassed(regmap, TSC1641_FLAG, &regval);
> +	if (ret)
> +		return ret;
> +
> +	*val = !!(regval & flag);
> +	return 0;
> +}
> +
> +static int tsc1641_in_read(struct device *dev, u32 attr, long *val)
> +{
> +	struct tsc1641_data *data = dev_get_drvdata(dev);
> +	struct regmap *regmap = data->regmap;
> +	unsigned int regval;
> +	int ret, reg;
> +
> +	switch (attr) {
> +	case hwmon_in_input:
> +		reg = TSC1641_LOAD_VOLTAGE;
> +		break;
> +	case hwmon_in_lcrit:
> +		reg = TSC1641_LUL;
> +		break;
> +	case hwmon_in_crit:
> +		reg = TSC1641_LOL;
> +		break;
> +	case hwmon_in_lcrit_alarm:
> +		return tsc1641_alert_read(regmap, TSC1641_LOAD_UV_FLAG, val);
> +	case hwmon_in_crit_alarm:
> +		return tsc1641_alert_read(regmap, TSC1641_LOAD_OV_FLAG, val);
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +
> +	ret = regmap_read(regmap, reg, &regval);
> +	if (ret)
> +		return ret;
> +
> +	*val = regval * TSC1641_VLOAD_LSB_MVOLT;

This applies to many of the registers:

if regval == 0x0000 or 0x7fff, and the SATF bit is set in the status register,
the voltage is out of range. This should be checked and -ENODATA should be
returned if it happens. Also, apparently, the register is only 15 bit wide and
should never have bit 15 set.

> +	return 0;
> +}
> +
> +static int tsc1641_curr_read(struct device *dev, u32 attr, long *val)
> +{
> +	struct tsc1641_data *data = dev_get_drvdata(dev);
> +	struct regmap *regmap = data->regmap;
> +	int regval;
> +	int ret, reg;
> +
> +	/* Current limits are the shunt under/over voltage limits */
> +	switch (attr) {
> +	case hwmon_curr_input:
> +		reg = TSC1641_CURRENT;
> +		break;
> +	case hwmon_curr_lcrit:
> +		reg = TSC1641_SUL;
> +		break;
> +	case hwmon_curr_crit:
> +		reg = TSC1641_SOL;
> +		break;
> +	case hwmon_curr_lcrit_alarm:
> +		return tsc1641_alert_read(regmap, TSC1641_SHUNT_UV_FLAG, val);
> +	case hwmon_curr_crit_alarm:
> +		return tsc1641_alert_read(regmap, TSC1641_SHUNT_OV_FLAG, val);
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +
> +	ret = regmap_read(regmap, reg, &regval);
> +	if (ret)
> +		return ret;
> +
> +	/* Current in milliamps */
> +	*val = DIV_ROUND_CLOSEST((s16)regval * data->current_lsb_ua, 1000);
> +	return 0;
> +}
> +
> +static int tsc1641_power_read(struct device *dev, u32 attr, long *val)
> +{
> +	struct tsc1641_data *data = dev_get_drvdata(dev);
> +	struct regmap *regmap = data->regmap;
> +	unsigned int regval;
> +	int ret, reg;
> +
> +	switch (attr) {
> +	case hwmon_power_input:
> +		reg = TSC1641_POWER;
> +		break;
> +	case hwmon_power_crit:
> +		reg = TSC1641_POL;
> +		break;
> +	case hwmon_power_crit_alarm:
> +		return tsc1641_alert_read(regmap, TSC1641_POWER_OVER_FLAG, val);
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +
> +	ret = regmap_read(regmap, reg, &regval);
> +	if (ret)
> +		return ret;
> +
> +	*val = regval * TSC1641_POWER_LSB_UWATT;
> +	return 0;
> +}
> +
> +static int tsc1641_temp_read(struct device *dev, u32 attr, long *val)
> +{
> +	struct tsc1641_data *data = dev_get_drvdata(dev);
> +	struct regmap *regmap = data->regmap;
> +	unsigned int regval;
> +	int ret, reg;
> +
> +	switch (attr) {
> +	case hwmon_temp_input:
> +		reg = TSC1641_TEMP;
> +		break;
> +	case hwmon_temp_crit:
> +		reg = TSC1641_TOL;
> +		break;
> +	case hwmon_temp_crit_alarm:
> +		return tsc1641_alert_read(regmap, TSC1641_TEMP_OVER_FLAG, val);
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +
> +	ret = regmap_read(regmap, reg, &regval);
> +	if (ret)
> +		return ret;
> +
> +	*val = (s16)regval * TSC1641_TEMP_LSB_MDEGC;
> +	return 0;
> +}
> +
> +static int tsc1641_in_write(struct device *dev, u32 attr, long val)
> +{
> +	struct tsc1641_data *data = dev_get_drvdata(dev);
> +	struct regmap *regmap = data->regmap;
> +	unsigned int regval;
> +	int reg;
> +
> +	switch (attr) {
> +	case hwmon_in_lcrit:
> +		reg = TSC1641_LUL;
> +		break;
> +	case hwmon_in_crit:
> +		reg = TSC1641_LOL;
> +		break;
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +
> +	val = clamp_val(val, 0, TSC1641_VLOAD_MAX_MVOLT);
> +	regval = DIV_ROUND_CLOSEST(val, TSC1641_VLOAD_LSB_MVOLT);
> +
> +	return regmap_write(regmap, reg, clamp_val(regval, 0, USHRT_MAX));

Another unnecessary clamp. Please only clamp when necessary.

Also, I notice that the above limits the value range to [0, 60000],
and the register value to [0, 30000].

According to the datasheet, the chip should accept the complete register
range from 0 to 0xffff, or 131,070 mV, as limit values. That means it is
possible for someone to write 0xffff into a register which would then be
reported as limit when reading it, but writing that limit back would
actually change it. I recommend against doing that.

[ Yes, I know, a voltage above 60V might damage the chip, but that
   doesn't mean that accepting higher limit values should be rejected.
   Some BIOS / ROMMON vendor could decide to write a limit value of 0xffff
   to indicate no limit. It is not our business to reject that.
]

The same applies to all other limit registers as far as I can see.

> +}
> +
> +static int tsc1641_curr_write(struct device *dev, u32 attr, long val)
> +{
> +	struct tsc1641_data *data = dev_get_drvdata(dev);
> +	struct regmap *regmap = data->regmap;
> +	int reg, regval;
> +
> +	switch (attr) {
> +	case hwmon_curr_lcrit:
> +		reg = TSC1641_SUL;
> +		break;
> +	case hwmon_curr_crit:
> +		reg = TSC1641_SOL;
> +		break;
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +
> +	/* Clamp to max 16-bit represantable current at min Rshunt */
> +	val = clamp_val(val, TSC1641_CURRENT_MIN_MAMP, TSC1641_CURRENT_MAX_MAMP);
> +	/* Convert val in milliamps to voltage */
> +	regval = DIV_ROUND_CLOSEST(val * data->rshunt_uohm, TSC1641_VSHUNT_LSB_NVOLT);
> +
> +	return regmap_write(regmap, reg, clamp_val(regval, SHRT_MIN, SHRT_MAX));

See below - clamping is insufficient for negative values, and it is not clear to me if
the limit register is signed or unsigned.

> +}
> +
> +static int tsc1641_power_write(struct device *dev, u32 attr, long val)
> +{
> +	struct tsc1641_data *data = dev_get_drvdata(dev);
> +	struct regmap *regmap = data->regmap;
> +	unsigned int regval;
> +
> +	switch (attr) {
> +	case hwmon_power_crit:
> +		val = clamp_val(val, 0, TSC1641_POWER_MAX_UWATT);
> +		regval = DIV_ROUND_CLOSEST(val, TSC1641_POWER_LSB_UWATT);
> +		return regmap_write(regmap, TSC1641_POL, clamp_val(regval, 0, USHRT_MAX));

regval is already guaranteed to be <= 64000, so the additional clamp here is unencessary.

> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +}
> +
> +static int tsc1641_temp_write(struct device *dev, u32 attr, long val)
> +{
> +	struct tsc1641_data *data = dev_get_drvdata(dev);
> +	struct regmap *regmap = data->regmap;
> +	int regval;
> +
> +	switch (attr) {
> +	case hwmon_temp_crit:
> +		val = clamp_val(val, TSC1641_TEMP_MIN_MDEGC, TSC1641_TEMP_MAX_MDEGC);
> +		regval = DIV_ROUND_CLOSEST(val, TSC1641_TEMP_LSB_MDEGC);
> +		return regmap_write(regmap, TSC1641_TOL, clamp_val(regval, SHRT_MIN, SHRT_MAX));

This doesn't work as intended for negative values. regmap doesn't expect to see
negative register values and returns an error if trying to write one, so clamping
against SHRT_MIN and SHRT_MAX is insufficient. You also need to mask the result
against 0xffff.

Also, the datasheet doesn't say that the limit value would be signed. Did you verify
that negative temperature limit values are actually treated as negative values ?

> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +}
> +
> +static umode_t tsc1641_is_visible(const void *data, enum hwmon_sensor_types type,
> +				  u32 attr, int channel)
> +{
> +	switch (type) {
> +	case hwmon_chip:
> +		switch (attr) {
> +		case hwmon_chip_update_interval:
> +			return 0644;
> +		default:
> +			break;
> +		}
> +		break;
> +	case hwmon_in:
> +		switch (attr) {
> +		case hwmon_in_input:
> +			return 0444;
> +		case hwmon_in_lcrit:
> +		case hwmon_in_crit:
> +			return 0644;
> +		case hwmon_in_lcrit_alarm:
> +		case hwmon_in_crit_alarm:
> +			return 0444;
> +		default:
> +			break;
> +		}
> +		break;
> +	case hwmon_curr:
> +		switch (attr) {
> +		case hwmon_curr_input:
> +			return 0444;
> +		case hwmon_curr_lcrit:
> +		case hwmon_curr_crit:
> +			return 0644;
> +		case hwmon_curr_lcrit_alarm:
> +		case hwmon_curr_crit_alarm:
> +			return 0444;
> +		default:
> +			break;
> +		}
> +		break;
> +	case hwmon_power:
> +		switch (attr) {
> +		case hwmon_power_input:
> +			return 0444;
> +		case hwmon_power_crit:
> +			return 0644;
> +		case hwmon_power_crit_alarm:
> +			return 0444;
> +		default:
> +			break;
> +		}
> +		break;
> +	case hwmon_temp:
> +		switch (attr) {
> +		case hwmon_temp_input:
> +			return 0444;
> +		case hwmon_temp_crit:
> +			return 0644;
> +		case hwmon_temp_crit_alarm:
> +			return 0444;
> +		default:
> +			break;
> +		}
> +		break;
> +	default:
> +		break;
> +	}
> +	return 0;
> +}
> +
> +static int tsc1641_read(struct device *dev, enum hwmon_sensor_types type,
> +			u32 attr, int channel, long *val)
> +{
> +	switch (type) {
> +	case hwmon_chip:
> +		return tsc1641_chip_read(dev, attr, val);
> +	case hwmon_in:
> +		return tsc1641_in_read(dev, attr, val);
> +	case hwmon_curr:
> +		return tsc1641_curr_read(dev, attr, val);
> +	case hwmon_power:
> +		return tsc1641_power_read(dev, attr, val);
> +	case hwmon_temp:
> +		return tsc1641_temp_read(dev, attr, val);
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +}
> +
> +static int tsc1641_write(struct device *dev, enum hwmon_sensor_types type,
> +			 u32 attr, int channel, long val)
> +{
> +	switch (type) {
> +	case hwmon_chip:
> +		return tsc1641_chip_write(dev, attr, val);
> +	case hwmon_in:
> +		return tsc1641_in_write(dev, attr, val);
> +	case hwmon_curr:
> +		return tsc1641_curr_write(dev, attr, val);
> +	case hwmon_power:
> +		return tsc1641_power_write(dev, attr, val);
> +	case hwmon_temp:
> +		return tsc1641_temp_write(dev, attr, val);
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +}
> +
> +static const struct hwmon_channel_info * const tsc1641_info[] = {
> +	HWMON_CHANNEL_INFO(chip,
> +			   HWMON_C_UPDATE_INTERVAL),
> +	HWMON_CHANNEL_INFO(in,
> +			   HWMON_I_INPUT | HWMON_I_CRIT | HWMON_I_CRIT_ALARM |
> +			   HWMON_I_LCRIT | HWMON_I_LCRIT_ALARM),

Why did you choose lcrit/crit attributes instead of min/max ? If there is only
one alert limit, that usually means the first level of alert, not a critical level.
Raising an alert does not mean it is a critical alert. Please reconsider.

> +	HWMON_CHANNEL_INFO(curr,
> +			   HWMON_C_INPUT | HWMON_C_CRIT | HWMON_C_CRIT_ALARM |
> +			   HWMON_C_LCRIT | HWMON_C_LCRIT_ALARM),
> +	HWMON_CHANNEL_INFO(power,
> +			   HWMON_P_INPUT | HWMON_P_CRIT | HWMON_P_CRIT_ALARM),
> +	HWMON_CHANNEL_INFO(temp,
> +			   HWMON_T_INPUT | HWMON_T_CRIT | HWMON_T_CRIT_ALARM),
> +	NULL
> +};
> +
> +static ssize_t shunt_resistor_show(struct device *dev,
> +				   struct device_attribute *da, char *buf)
> +{
> +	struct tsc1641_data *data = dev_get_drvdata(dev);
> +
> +	return sysfs_emit(buf, "%li\n", data->rshunt_uohm);
> +}
> +
> +static ssize_t shunt_resistor_store(struct device *dev,
> +				    struct device_attribute *da,
> +				    const char *buf, size_t count)
> +{
> +	struct tsc1641_data *data = dev_get_drvdata(dev);
> +	unsigned long val;
> +	int ret;
> +
> +	ret = kstrtoul(buf, 10, &val);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (val > U32_MAX)
> +		return -EINVAL;
> +

Use kstrtouint() instead.

> +	ret = tsc1641_set_shunt(data, (u32)val);
> +	if (ret < 0)
> +		return ret;
> +	return count;
> +}
> +
> +static const struct hwmon_ops tsc1641_hwmon_ops = {
> +	.is_visible = tsc1641_is_visible,
> +	.read = tsc1641_read,
> +	.write = tsc1641_write,
> +};
> +
> +static const struct hwmon_chip_info tsc1641_chip_info = {
> +	.ops = &tsc1641_hwmon_ops,
> +	.info = tsc1641_info,
> +};
> +
> +static DEVICE_ATTR_RW(shunt_resistor);
> +
> +/* Shunt resistor value is exposed via sysfs attribute */
> +static struct attribute *tsc1641_attrs[] = {
> +	&dev_attr_shunt_resistor.attr,
> +	NULL,
> +};
> +ATTRIBUTE_GROUPS(tsc1641);
> +
> +static int tsc1641_init(struct device *dev, struct tsc1641_data *data)
> +{
> +	struct regmap *regmap = data->regmap;
> +	bool active_high;
> +	u32 shunt;
> +	int ret;
> +
> +	if (device_property_read_u32(dev, "shunt-resistor-micro-ohms", &shunt) < 0)
> +		shunt = TSC1641_RSHUNT_DEFAULT;
> +
> +	if (tsc1641_validate_shunt(shunt) < 0) {
> +		dev_err(dev, "invalid shunt resistor value %u\n", shunt);
> +		return -EINVAL;
> +	}
> +
> +	ret = tsc1641_set_shunt(data, shunt);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = regmap_write(regmap, TSC1641_CONFIG, TSC1641_CONFIG_DEFAULT);
> +	if (ret < 0)
> +		return ret;
> +
> +	active_high = device_property_read_bool(dev, "st,alert-polarity-active-high");
> +
> +	return regmap_write(regmap, TSC1641_MASK, TSC1641_MASK_DEFAULT |
> +			    FIELD_PREP(TSC1641_ALERT_POL_MASK, active_high));
> +}
> +
> +static int tsc1641_probe(struct i2c_client *client)
> +{
> +	struct device *dev = &client->dev;
> +	struct tsc1641_data *data;
> +	struct device *hwmon_dev;
> +	int ret;
> +
> +	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	data->client = client;
> +
> +	data->regmap = devm_regmap_init_i2c(client, &tsc1641_regmap_config);
> +	if (IS_ERR(data->regmap)) {
> +		dev_err(dev, "failed to allocate register map\n");
> +		return PTR_ERR(data->regmap);

Use dev_err_probe() here as well.

> +	}
> +
> +	ret = tsc1641_init(dev, data);
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret, "failed to configure device\n");
> +
> +	hwmon_dev = devm_hwmon_device_register_with_info(dev, client->name,
> +							 data, &tsc1641_chip_info, tsc1641_groups);
> +	if (IS_ERR(hwmon_dev))
> +		return PTR_ERR(hwmon_dev);
> +
> +	dev_info(dev, "power monitor %s (Rshunt = %li uOhm)\n",
> +		 client->name, data->rshunt_uohm);
> +
> +	return 0;
> +}
> +
> +static const struct i2c_device_id tsc1641_id[] = {
> +	{ "tsc1641", 0 },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, tsc1641_id);
> +
> +static const struct of_device_id __maybe_unused tsc1641_of_match[] = {
> +	{ .compatible = "st,tsc1641" },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, tsc1641_of_match);
> +
> +static struct i2c_driver tsc1641_driver = {
> +	.driver = {
> +		.name = "tsc1641",
> +		.of_match_table = of_match_ptr(tsc1641_of_match),
> +	},
> +	.probe = tsc1641_probe,
> +	.id_table = tsc1641_id,
> +};
> +
> +module_i2c_driver(tsc1641_driver);
> +
> +MODULE_AUTHOR("Igor Reznichenko <igor@reznichenko.net>");
> +MODULE_DESCRIPTION("tsc1641 driver");
> +MODULE_LICENSE("GPL");


