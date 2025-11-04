Return-Path: <linux-kernel+bounces-883975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7202C2EF74
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 03:27:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E1F63AC474
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 02:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E04124291B;
	Tue,  4 Nov 2025 02:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BSKU8eeM"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C33D71E231E
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 02:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762223233; cv=none; b=DJK4oRBnYJBFELxA5HWEu1HtSINjxsKcxWvXvLcpOhVLEuWLHRUsrvICIACwlkWv7d3WWRp2AlXgyeGVGPzP5aRzRuIJBVY6rsHtaoEGh3hpx91ncvQ9Bx4FIZNV/4LPUjSUi+iMs8wsLkBSwX1+HDiv0GhW0FDkWD7SGIk9o5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762223233; c=relaxed/simple;
	bh=J5CTR0KJE85vwJpFIu88hcabeTK9tFHGBH29DgsP7pQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KzOhtSI830IqSxWF/AzENvKz9f+2I8/1y1US2X2WsuvCBmh5V1q0/jUSAc9j5alrJQ41SOYST3Qv/nCCMQAGe6X3Ff7CrJSeXgNObGbJu8auoVTKf+0eqxw4iOmwI/cBtz02Nh11d/gbaV3xvk/23atyZa50q2LdSKoLsVcMAcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BSKU8eeM; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-33b5a3e8ae2so4952984a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 18:27:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762223230; x=1762828030; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=R705EYqyWLbfIosGnpm5IR0jYDwQ/KKTnNHDbSEtzBE=;
        b=BSKU8eeMit9CCn6MMw91LsKGjOjl9ORdMH9q/7MSZ/0qQLO3hLqb6vr6VG2XA1KuHv
         ltd6SZHw90J3zsRYhWZySb0OdPZUxmTB0h7G+Uw8jqDw5QMDb1YYVYf3oHPaKVIdUbb2
         88foIEB80xMWgNBFOSAHDHevMHI/SNqA021J55f91OI5yeStW0TB4DFYH8PMTK7vFMrz
         Y1L5uJx4AnQkPnBhxpaTtj00KisEf6Rgehh/DNxzUetWixXxE8zt1ilaiG8Ns95xwAp1
         1Wmh0jz4yXqW2XV0MksdrXobyOeB17p+0x+xcp8HIEdksZJN7Bg2nrT31vXFnG4VTRh+
         oZog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762223230; x=1762828030;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R705EYqyWLbfIosGnpm5IR0jYDwQ/KKTnNHDbSEtzBE=;
        b=FbTHEn8aGo5xzfUzfRpMVJQX4dVCWjwmj9o6FsWmNyUPKrXaS+iCqx3ABrXj3C99Zv
         yo5sR2UolhyPXOyWO+rITCOuewb+6RspdF6z75LYyni7AiymHlHDR668II3+r9ZJo41H
         LaINrHvhr16yfgH8yfkUoixG/7y82tE2uT3ATKnOLnRDcTsKkLllgmQu70OEXI17C814
         Hf/uRe5FRJIrYTCAFk6Q8yHYifVj9CJo/Pj2UAfg0bxpgn9DMBD37EZeRUBY8+hrMhjd
         rmQ6sXvmomOSLZkgVK4a7QdSY7ZzJsaGhBXTa3lDxBzsKKu6ISourWlGkFojLR9Hufef
         QXuw==
X-Forwarded-Encrypted: i=1; AJvYcCXh3CVILIC4HFTgXYwBn0v023JEsdjhuWpnBr7SlksZI5QkjlrkYKPHmVHGjGLrugmBXQKsog6ruhr9LbU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuTy0WXLjSY5GAUlyxTb3X4tuB6ZIu5bBxJYmS8VbyNkV2ElyZ
	2aeA1475xnFRPt8RQq4jxLjvZNpkPVVbNYEyJAnsxsUuWFZ5L6H+btN8
X-Gm-Gg: ASbGncusuUhXjVnKWGJpf1ps+IlfNXelYzZurdildkOiSjEeSW73BBEZuEbo6KfZdCC
	Iw8pV5D45wbrrpr9vsyz+3D0KItFEulosvatsw81Csu1pwzAY9ufWlYZO0DoTu5eRXDsr/G8GGa
	p4dOeIufJgFe2L65a4af19t8jJZBeJosD+pJSRVmN2ti7h1nbz1HXr0xqBPgGADtXb7FVliFif5
	1o4BRecN+RhWKQQyPDpFob+/G+h2jIxhqzB9mLodBJ1r1aE0GwmM1jOoBHTUTyb/I7L+ddvFc2f
	VutPJyp4yZGihrrC6XpK26hNRegYIBzB0c7FlWjgUp5Iy33doSu+mSVTAPaFAsdi47+5XK/ex4v
	Ecrq8LzMODQN/MqKRmep626qg1TU7ViyAnw6I8kdQQ3NC+yXQ9aehfpSRM4ss/g+NpMcZ488yh5
	GKaRoVnoZEx1zehICZAjLI7cml6g+Howf+5UxLmNT4eaP8KFQQ
X-Google-Smtp-Source: AGHT+IHvEdQlCceYQm+iD9DjaT/ROhRCF5MI+ckhZLYuepYL45kdlymwiXKDkUiS/Zec4WyzRSTW1A==
X-Received: by 2002:a17:90b:2dc1:b0:340:e103:bfd4 with SMTP id 98e67ed59e1d1-3417185c471mr2027933a91.2.1762223229822;
        Mon, 03 Nov 2025 18:27:09 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3417d1fd921sm330722a91.4.2025.11.03.18.27.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Nov 2025 18:27:09 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <3fa87e01-626c-4255-a57c-1c196d51ef4d@roeck-us.net>
Date: Mon, 3 Nov 2025 18:27:07 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] hwmon: Add TSC1641 I2C power monitor driver
To: Igor Reznichenko <igor@reznichenko.net>, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, corbet@lwn.net
Cc: david.hunter.linux@gmail.com, devicetree@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-hwmon@vger.kernel.org,
 linux-kernel@vger.kernel.org, skhan@linuxfoundation.org
References: <20251104003320.1120514-1-igor@reznichenko.net>
 <20251104003320.1120514-3-igor@reznichenko.net>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <20251104003320.1120514-3-igor@reznichenko.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/3/25 16:33, Igor Reznichenko wrote:
> Add a driver for the ST Microelectronics TSC1641 16-bit high-precision
> power monitor. The driver supports reading bus voltage, current, power,
> and temperature. Sysfs attributes are exposed for shunt resistor and
> update interval. The driver integrates with the hwmon subsystem and
> supports optional ALERT pin polarity configuration.
> 
> Signed-off-by: Igor Reznichenko <igor@reznichenko.net>
> ---
>   Documentation/hwmon/index.rst   |   1 +
>   Documentation/hwmon/tsc1641.rst |  87 ++++
>   drivers/hwmon/Kconfig           |  12 +
>   drivers/hwmon/Makefile          |   1 +
>   drivers/hwmon/tsc1641.c         | 748 ++++++++++++++++++++++++++++++++
>   5 files changed, 849 insertions(+)
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
> index 000000000000..425e25f7a7d1
> --- /dev/null
> +++ b/Documentation/hwmon/tsc1641.rst
> @@ -0,0 +1,87 @@
> +.. SPDX-License-Identifier: GPL-2.0-only
> +
> +Kernel driver tsc1641
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
> +monitoring analog front-end (AFE). It monitors bidirectional current into a
> +shunt resistor and load voltage up to 60 V in a synchronized way. Digital bus
> +interface is I2C/SMbus. The TSC1641 allows the assertion of several alerts
> +regarding the voltage, current, power and temperature.
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
> +Supported range of shunt resistor values is from 100 uOhm to 655.35 mOhm, in
> +10 uOhm steps.
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
> +Current          Bidirectional, dependent on shunt
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
> +in0_max              bus voltage max alarm limit (mV)
> +in0_max_alarm        bus voltage max alarm limit exceeded
> +in0_min              bus voltage min alarm limit (mV)
> +in0_min_alarm        bus voltage min alarm limit exceeded
> +
> +curr1_input          current measurement (mA)
> +curr1_max            current max alarm limit (mA)
> +curr1_max_alarm      current max alarm limit exceeded
> +curr1_min            current min alarm limit (mA)
> +curr1_min_alarm      current min alarm limit exceeded
> +
> +power1_input         power measurement (uW)
> +power1_max           power max alarm limit (uW)
> +power1_max_alarm     power max alarm limit exceeded
> +
> +shunt_resistor       shunt resistor value (uOhms)
> +
> +temp1_input          temperature measurement (mdegC)
> +temp1_max            temperature max alarm limit (mdegC)
> +temp1_max_alarm      temperature max alarm limit exceeded
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
> index 000000000000..b241206b07ac
> --- /dev/null
> +++ b/drivers/hwmon/tsc1641.c
> @@ -0,0 +1,748 @@
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
> +#include <linux/util_macros.h>
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
> +#define TSC1641_CONFIG_DEFAULT	0x003F /* Default mode and temperature sensor */
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
> +
> +#define TSC1641_ALERT_POL_MASK		BIT(1)
> +#define TSC1641_ALERT_LATCH_EN_MASK	BIT(0)
> +
> +/* Flags indicating alerts in TSC1641_FLAG register*/
> +#define TSC1641_SAT_FLAG		BIT(13)
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

This is validated twice if called from tsc1641_init().

Here:
	TSC1641_RSHUNT_MIN_UOHM <= val <= TSC1641_RSHUNT_MAX_UOHM

> +	/* RSHUNT register LSB is 10uOhm so need to divide further */
> +	rshunt_reg = DIV_ROUND_CLOSEST(val, TSC1641_RSHUNT_LSB_UOHM);

	rshunt_reg >= (TSC1641_RSHUNT_MIN_UOHM / TSC1641_RSHUNT_LSB_UOHM)
		   >= 10
		   <= (TSC1641_RSHUNT_MAX_UOHM / TSC1641_RSHUNT_LSB_UOHM)
		   <= 655350 / 10 == 65535

> +	/*
> +	 * Clamp value to the nearest multiple of TSC1641_RSHUNT_LSB_UOHM
> +	 * in case shunt value provided was not a multiple
> +	 */
> +	data->rshunt_uohm = rshunt_reg * TSC1641_RSHUNT_LSB_UOHM;

	rshunt_reg >= 10 * TSC1641_RSHUNT_LSB_UOHM
		   >= 10 * 10 == 100
		   <= 65535 * 10 == 655350

> +	data->current_lsb_ua = DIV_ROUND_CLOSEST(TSC1641_VSHUNT_LSB_NVOLT * 1000,
> +						 data->rshunt_uohm);

	current_lsb_us >= TSC1641_VSHUNT_LSB_NVOLT * 1000 / 655350
		       >= 2500 * 1000 / 655350
		       >= 3.81 ~= 4

So current_lsb_us will never be 0, and the WARN_ONCE above is unnecessary.

If you don't trust the calculations (or they are wrong ;-), add

	if (!data->current_lsb_ua)
		return -EINVAL;

but please drop the WARN_ONCE() above.

> +
> +	return regmap_write(regmap, TSC1641_RSHUNT, rshunt_reg);
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
> +static int tsc1641_flag_read(struct regmap *regmap, u32 flag, long *val)
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
> +	long sat_flag;
> +
> +	switch (attr) {
> +	case hwmon_in_input:
> +		reg = TSC1641_LOAD_VOLTAGE;
> +		break;
> +	case hwmon_in_min:
> +		reg = TSC1641_LUL;
> +		break;
> +	case hwmon_in_max:
> +		reg = TSC1641_LOL;
> +		break;
> +	case hwmon_in_min_alarm:
> +		return tsc1641_flag_read(regmap, TSC1641_LOAD_UV_FLAG, val);
> +	case hwmon_in_max_alarm:
> +		return tsc1641_flag_read(regmap, TSC1641_LOAD_OV_FLAG, val);
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +
> +	ret = regmap_read(regmap, reg, &regval);
> +	if (ret)
> +		return ret;
> +
> +	/* Check if load voltage is out of range */
> +	if (reg == TSC1641_LOAD_VOLTAGE) {
> +		/* Register is 15-bit max */
> +		if (regval & 0x8000)
> +			return -ENODATA;
> +
> +		ret  = tsc1641_flag_read(regmap, TSC1641_SAT_FLAG, &sat_flag);
> +		if (ret)
> +			return ret;
> +		/* Out of range conditions per datasheet */
> +		if (sat_flag && (regval == 0x7FFF || !regval))
> +			return -ENODATA;
> +	}
> +
> +	*val = regval * TSC1641_VLOAD_LSB_MVOLT;
> +	return 0;
> +}
> +
> +/* Chip supports bidirectional (positive or negative) current */
> +static int tsc1641_curr_read(struct device *dev, u32 attr, long *val)
> +{
> +	struct tsc1641_data *data = dev_get_drvdata(dev);
> +	struct regmap *regmap = data->regmap;
> +	int regval;
> +	int ret, reg;
> +	long sat_flag;
> +
> +	/* Current limits are the shunt under/over voltage limits */
> +	switch (attr) {
> +	case hwmon_curr_input:
> +		reg = TSC1641_CURRENT;
> +		break;
> +	case hwmon_curr_min:
> +		reg = TSC1641_SUL;
> +		break;
> +	case hwmon_curr_max:
> +		reg = TSC1641_SOL;
> +		break;
> +	case hwmon_curr_min_alarm:
> +		return tsc1641_flag_read(regmap, TSC1641_SHUNT_UV_FLAG, val);
> +	case hwmon_curr_max_alarm:
> +		return tsc1641_flag_read(regmap, TSC1641_SHUNT_OV_FLAG, val);
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +	/*
> +	 * Current uses shunt voltage, so check if it's out of range.
> +	 * We report current register in sysfs to stay consistent with internal
> +	 * power calculations which use current register values
> +	 */
> +	if (reg == TSC1641_CURRENT) {
> +		ret = regmap_read(regmap, TSC1641_SHUNT_VOLTAGE, &regval);
> +		if (ret)
> +			return ret;
> +
> +		ret = tsc1641_flag_read(regmap, TSC1641_SAT_FLAG, &sat_flag);
> +		if (ret)
> +			return ret;
> +
> +		if (sat_flag && (regval == 0x7FFF || regval == 0x8000))
> +			return -ENODATA;
> +	}
> +
> +	ret = regmap_read(regmap, reg, &regval);
> +	if (ret)
> +		return ret;
> +
> +	/* Current in milliamps, signed */
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
> +	case hwmon_power_max:
> +		reg = TSC1641_POL;
> +		break;
> +	case hwmon_power_max_alarm:
> +		return tsc1641_flag_read(regmap, TSC1641_POWER_OVER_FLAG, val);
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
> +	case hwmon_temp_max:
> +		reg = TSC1641_TOL;
> +		break;
> +	case hwmon_temp_max_alarm:
> +		return tsc1641_flag_read(regmap, TSC1641_TEMP_OVER_FLAG, val);
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +
> +	ret = regmap_read(regmap, reg, &regval);
> +	if (ret)
> +		return ret;
> +
> +	/* 0x8000 means that TEMP measurement not enabled */
> +	if (reg == TSC1641_TEMP && regval == 0x8000)
> +		return -ENODATA;
> +
> +	/* Both temperature and limit registers are signed */
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
> +	case hwmon_in_min:
> +		reg = TSC1641_LUL;
> +		break;
> +	case hwmon_in_max:
> +		reg = TSC1641_LOL;
> +		break;
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +	/* Clamp to full register range */
> +	val = clamp_val(val, 0, TSC1641_VLOAD_LSB_MVOLT * USHRT_MAX);
> +	regval = DIV_ROUND_CLOSEST(val, TSC1641_VLOAD_LSB_MVOLT);
> +
> +	return regmap_write(regmap, reg, regval);
> +}
> +
> +static int tsc1641_curr_write(struct device *dev, u32 attr, long val)
> +{
> +	struct tsc1641_data *data = dev_get_drvdata(dev);
> +	struct regmap *regmap = data->regmap;
> +	int reg, regval;
> +
> +	switch (attr) {
> +	case hwmon_curr_min:
> +		reg = TSC1641_SUL;
> +		break;
> +	case hwmon_curr_max:
> +		reg = TSC1641_SOL;
> +		break;
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +
> +	/* Should never happen if init was ok */
> +	if (WARN_ON_ONCE(!data->current_lsb_ua))
> +		return -EINVAL;
> +

The code should make sure that this never happens, making this check
unnecessary. Also see above.

> +	/* Convert val in milliamps to register */
> +	regval = DIV_ROUND_CLOSEST(val * 1000, data->current_lsb_ua);

curr1_min: Suspected underflow: [min=-81920, read 0, written -9223372036854775808]
curr1_max: Suspected underflow: [min=-81920, read 0, written -9223372036854775808]

You'll need to clamp 'val' first before multiplying it.


> +	/*
> +	 * Prevent signed 16-bit overflow.
> +	 * Integer arithmetic and shunt scaling can quantize values near 0x7FFF/0x8000,
> +	 * so reading and writing back may not preserve the exact original register value.
> +	 */
> +	regval = clamp_val(regval, SHRT_MIN, SHRT_MAX);
> +	/* SUL and SOL registers are signed */
> +	return regmap_write(regmap, reg, regval & 0xFFFF);
> +}
> +
> +static int tsc1641_power_write(struct device *dev, u32 attr, long val)
> +{
> +	struct tsc1641_data *data = dev_get_drvdata(dev);
> +	struct regmap *regmap = data->regmap;
> +	unsigned int regval;
> +
> +	switch (attr) {
> +	case hwmon_power_max:
> +		/* Clamp to full register range */
> +		val = clamp_val(val, 0, TSC1641_POWER_LSB_UWATT * USHRT_MAX);
> +		regval = DIV_ROUND_CLOSEST(val, TSC1641_POWER_LSB_UWATT);
> +		return regmap_write(regmap, TSC1641_POL, regval);
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
> +	case hwmon_temp_max:
> +		/* Clamp to full register range */
> +		val = clamp_val(val, TSC1641_TEMP_LSB_MDEGC * SHRT_MIN,
> +				TSC1641_TEMP_LSB_MDEGC * SHRT_MAX);
> +		regval = DIV_ROUND_CLOSEST(val, TSC1641_TEMP_LSB_MDEGC);
> +		/* TOL register is signed */
> +		return regmap_write(regmap, TSC1641_TOL, regval & 0xFFFF);
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
> +		case hwmon_in_min:
> +		case hwmon_in_max:
> +			return 0644;
> +		case hwmon_in_min_alarm:
> +		case hwmon_in_max_alarm:
> +			return 0444;
> +		default:
> +			break;
> +		}
> +		break;
> +	case hwmon_curr:
> +		switch (attr) {
> +		case hwmon_curr_input:
> +			return 0444;
> +		case hwmon_curr_min:
> +		case hwmon_curr_max:
> +			return 0644;
> +		case hwmon_curr_min_alarm:
> +		case hwmon_curr_max_alarm:
> +			return 0444;
> +		default:
> +			break;
> +		}
> +		break;
> +	case hwmon_power:
> +		switch (attr) {
> +		case hwmon_power_input:
> +			return 0444;
> +		case hwmon_power_max:
> +			return 0644;
> +		case hwmon_power_max_alarm:
> +			return 0444;
> +		default:
> +			break;
> +		}
> +		break;
> +	case hwmon_temp:
> +		switch (attr) {
> +		case hwmon_temp_input:
> +			return 0444;
> +		case hwmon_temp_max:
> +			return 0644;
> +		case hwmon_temp_max_alarm:
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
> +			   HWMON_I_INPUT | HWMON_I_MAX | HWMON_I_MAX_ALARM |
> +			   HWMON_I_MIN | HWMON_I_MIN_ALARM),
> +	HWMON_CHANNEL_INFO(curr,
> +			   HWMON_C_INPUT | HWMON_C_MAX | HWMON_C_MAX_ALARM |
> +			   HWMON_C_MIN | HWMON_C_MIN_ALARM),
> +	HWMON_CHANNEL_INFO(power,
> +			   HWMON_P_INPUT | HWMON_P_MAX | HWMON_P_MAX_ALARM),
> +	HWMON_CHANNEL_INFO(temp,
> +			   HWMON_T_INPUT | HWMON_T_MAX | HWMON_T_MAX_ALARM),
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
> +	unsigned int val;
> +	int ret;
> +
> +	ret = kstrtouint(buf, 10, &val);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = tsc1641_set_shunt(data, val);
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
> +	data->regmap = devm_regmap_init_i2c(client, &tsc1641_regmap_config);
> +	if (IS_ERR(data->regmap))
> +		return dev_err_probe(dev, PTR_ERR(data->regmap),
> +				     "failed to allocate register map\n");
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


