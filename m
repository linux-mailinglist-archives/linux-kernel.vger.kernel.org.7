Return-Path: <linux-kernel+bounces-865282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B039BFCAE8
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 16:52:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 912D43582CD
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 14:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C05E2337B99;
	Wed, 22 Oct 2025 14:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lKMeMpWu"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77FE32F616A
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 14:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761144689; cv=none; b=RoawseVa76RODIjt2BzT9LfTwVEHqq6I7o114t9MYb4VKXvXTBpRo55IbYjtqGvr1rdPFFXJpw2zSnABK8iTwagg44E3nUrXyYAO4/U3+ldPeV+KqrsKp9/8ijuXakWUjeZkaYLY+ijYfpR5YAducH9xGC6kce4D0O6BW3qjHOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761144689; c=relaxed/simple;
	bh=QgkhqAoRJfvZwV2rrenini+2o5XJ2EJj5KcQ73udbyo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OFK70OpdcBBsnjy2By4y/oUx6SGOu0jL0iC/0HHUSxm2j8DZ9o+kpfhj44F0s8g3Au0DNuir+VsT7GAVVChtFMZIabx1psn6c8e/ivi+eS4uAP9f5Moga6fcJ3vblGWwIZRvFUc4kKrUV7cAwdKA3ffh0s7looR4Hq8uZhfUd/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lKMeMpWu; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b6cf1a95273so31906a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 07:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761144686; x=1761749486; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yyUmdnUTGm134LkLq2piC/4YI8QctlejGBCLe55TEhk=;
        b=lKMeMpWuBUBWcDHR2nyG4gjKGG7yo0Y7MaPiNbARn4QH3P42LbMYuq2+g75fWIfF/C
         AFQQCXqEyGYpJrRR2LuTlGEbqSlWrtmFXBsfkUMxbnKzmwO2Bc5BAasOHu/g+u+8+BTF
         5DJ56Vvs+FI2O7OlN7wrMKHagg/6U4/sJbSKvsWX/q/nF+tgS7J+szMGiM9MaBTmEnAr
         ovm8f2BkvdXV7BuffNtW5QPRhuZFqWidx32Jk4ffTF7l+GQVkNdPCcVBWwNQEoRZUm4M
         96TNZo1z02Se2XI4SmdhHembL3PTWpOVHG/bfSu+LbLtlIhxipv3yqw+EdudmGxT4/c+
         1CKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761144686; x=1761749486;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yyUmdnUTGm134LkLq2piC/4YI8QctlejGBCLe55TEhk=;
        b=AOD/NQVLQB+rn55pU6ZJgkHYSCwrLVIfXwQr91nvJXEQGzoox3offaT6N1ku+lQpFM
         DDFcLDqb0BByul7VqOI80I4vIiN2OcLUZusZJNcMgzGPyCwVk3f51+AJM8PlZGYRF/uV
         n6l5TWBAJ+iiOYxtIvCqKRn+EwiXEA8d1VoFMJIGi6GvHtqbqPB1J/+07LEUScrTJO5R
         2ex/frOZ5k1/8FJSmY6N1NZYFkySwicoBLr/KbqdwR1S5rwi5Ie/WZImZz4zWec8hwAB
         SUSHxJSXeGX2AGt3iw186t71nWbSEkeKI+wPWD01H+qIxO/C6v5toevSY3Zx8ph9F3Nw
         ocGw==
X-Forwarded-Encrypted: i=1; AJvYcCVNdOqFe5bWYHW38KKQyNEoSTl2tUWzupT+86kIbb/KInz9QXKF8NbplZNLedr/woI924GnvQSJ9LgsdQ8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yynrt7XLraINSRSofDhSWoW0PO2hYWrDKQsB1GlWFKla8mBMwtK
	FEujGiFK/v5nZoIL89cmBuzt7wnyW/KVTIU9n71pxZ/mYa/uDWnTrNZT
X-Gm-Gg: ASbGncudoR9Gj0BsoRd3SnWuQLGaYENutvvhWO5C7f+j0hYZct4vw07Xb4K+u/xnlKU
	wzFipAfRySMOHlwn4n6AqnAeKmptRSXCVXbYcimqsV2u1prfC8QLp3Yoo3nqj7Qw7jvqhugiN5U
	LWKqGsLaypEftA1IdNFxEW0HMFepMWvIitQ/0+Zy+kZDY7HXK5IHem38pcZmFd4BDn4i1Eu001F
	QkFVKdQOdDPliD0c2Or2Sl2ch56ef/4vePGqvIE1QU5M0MOUS3u8K5RF1oelhKCopJge0o4qaPh
	wU/fYuSwWMEysab/bZyGRuowsz00NgDK5w5b53B+UpupBkCVyb8OIxNeNFqouyZMBcq0Vbu4P11
	QtZDx3tzx8bTCfqYkBRHpG1pSJhMbxy8NReRlaw7T6SzKqxHeY8YLo+h8Lf30XPK2rPdjDz1WBC
	X7Xc4aUI9H34fgSIVFNMpyqSY=
X-Google-Smtp-Source: AGHT+IFtnKPQqH5yr4lXUP+X1PCfATSUoGm7r0eUpPKNBNLtefh9p8MyyXncCQmUf8VBaI78JwFhQQ==
X-Received: by 2002:a17:903:298c:b0:27e:eabd:4b41 with SMTP id d9443c01a7336-290c9c89eabmr267917365ad.7.1761144685481;
        Wed, 22 Oct 2025 07:51:25 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-292471d585bsm140234805ad.64.2025.10.22.07.51.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 07:51:24 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 22 Oct 2025 07:51:23 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Igor Reznichenko <igor@reznichenko.net>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	corbet@lwn.net, skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com, linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH 1/5] drivers/hwmon: Add TSC1641 I2C power monitor driver
Message-ID: <be691214-bac6-43d4-be62-daa57c833fe7@roeck-us.net>
References: <20251022044708.314287-1-igor@reznichenko.net>
 <20251022044708.314287-2-igor@reznichenko.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251022044708.314287-2-igor@reznichenko.net>

On Tue, Oct 21, 2025 at 09:47:04PM -0700, Igor Reznichenko wrote:
> Add a new I2C hwmon driver for the ST Microelectronics TSC1641 16-bit
> high-precision power monitor. The driver supports reading bus voltage,
> current, power, and temperature. Sysfs attributes are exposed for
> shunt resistor value, raw shunt voltage and update interval.
> The driver integrates with the hwmon subsystem and supports optional
> ALERT pin polarity configuration.
> 
> Signed-off-by: Igor Reznichenko <igor@reznichenko.net>

Please send a register dump.

> ---
>  drivers/hwmon/tsc1641.c | 801 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 801 insertions(+)
>  create mode 100644 drivers/hwmon/tsc1641.c
> 
> diff --git a/drivers/hwmon/tsc1641.c b/drivers/hwmon/tsc1641.c
> new file mode 100644
> index 000000000000..22b49a7918cf
> --- /dev/null
> +++ b/drivers/hwmon/tsc1641.c
> @@ -0,0 +1,801 @@
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
> +#include <linux/delay.h>
> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/hwmon.h>
> +#include <linux/i2c.h>
> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/regmap.h>
> +#include <linux/sysfs.h>
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
> +#define TSC1641_RSHUNT_DEFAULT	0x0000

This should be a reasonable value, such as 1mOhm, not 0.

> +#define TSC1641_CONFIG_DEFAULT	0x003F /* Enable temperature sensor */
> +
> +/* Bit mask for conversion time in the configuration register */
> +#define TSC1641_CONV_TIME_MASK	GENMASK(7, 4)
> +
> +#define TSC1641_CONV_TIME_DEFAULT	1024
> +#define TSC1641_MIN_UPDATE_INTERVAL	1024
> +
> +/* LSB value of different registers */
> +#define TSC1641_VLOAD_LSB_MILLIVOLT	2
> +#define TSC1641_POWER_LSB_MICROWATT	25000
> +#define TSC1641_VSHUNT_LSB_NANOVOLT	2500	/* Use nanovolts to make it integer */
> +#define TSC1641_RSHUNT_LSB_UOHM		10
> +#define TSC1641_TEMP_LSB_MILLIDEGC	500
> +
> +/* Bit masks for enabling limit alerts in TSC1641_MASK*/
> +#define TSC1641_SHUNT_OV_MASK		BIT(15)
> +#define TSC1641_SHUNT_UV_MASK		BIT(14)
> +#define TSC1641_LOAD_OV_MASK		BIT(13)
> +#define TSC1641_LOAD_UV_MASK		BIT(12)
> +#define TSC1641_POWER_OVER_MASK		BIT(11)
> +#define TSC1641_TEMP_OVER_MASK		BIT(10)
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
> +	long current_lsb_uA;

No CamelCase variables, please.

> +	/* protects register data during updates */
> +	struct mutex update_lock;

Locking is handled by the hwmon core and not needed here.

> +	struct regmap *regmap;
> +	struct i2c_client *client;
> +};
> +
> +static int tsc1641_set_shunt(struct tsc1641_data *data, u32 val)

The calling code 'val' variable is unsigned long, so this will cause overflows.

> +{
> +	struct regmap *regmap = data->regmap;
> +
> +	if (!val)
> +		return 0;

Either use claml() to limit the valid range, or return -EINVAL.

> +
> +	data->rshunt_uohm = val;
> +	long mohm = DIV_ROUND_CLOSEST(data->rshunt_uohm, 1000);

Please keep variable declarations at the beginning of functions.

if val < 500, mohm == 0, and

> +
> +	data->current_lsb_uA = DIV_ROUND_CLOSEST(TSC1641_VSHUNT_LSB_NANOVOLT, mohm);

there will be a nice divice-by-zero crash here. Also, shunt resistor values
of, for example, 1,500 uOhm will result in substantial measurement errors.
That seems unnecessary.

> +	/* RSHUNT register LSB is 10uOhm so need to divide further*/
> +	long rshunt_reg = DIV_ROUND_CLOSEST(data->rshunt_uohm, TSC1641_RSHUNT_LSB_UOHM);
> +	int ret = regmap_write(regmap, TSC1641_RSHUNT, rshunt_reg);
> +
> +	if (ret < 0)
> +		return ret;
> +
> +	return 0;

regmap_write() returns a negative error code or 0, so all this complexity
is unnecessary. A simple
	return regmap_write(regmap, TSC1641_RSHUNT, rshunt_reg);
would do.

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

	interval = clamp_val(interval, 1, 33) * 1000;

would do just as well without extra variable.

> +	int conv_bits = find_closest(conv, tsc1641_conv_times,
> +				 ARRAY_SIZE(tsc1641_conv_times));
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
> +		break;
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +	return 0;
> +}
> +
> +static int tsc1641_reg_to_value(struct tsc1641_data *data, u8 reg, unsigned int regval)
> +{
> +	int val;
> +
> +	switch (reg) {
> +	case TSC1641_SHUNT_VOLTAGE:
> +		val = (s16)regval * TSC1641_VSHUNT_LSB_NANOVOLT;
> +		/* Return microvolts */
> +		return DIV_ROUND_CLOSEST(val, 1000);
> +	case TSC1641_SOL:
> +		fallthrough;

fallthrough is unnecessary here.

> +	case TSC1641_SUL:
> +		/* Used for current limits only, so return current in mA */
> +		val = (s16)regval * data->current_lsb_uA;
> +		return DIV_ROUND_CLOSEST(val, 1000);
> +	case TSC1641_LOL:
> +		fallthrough;

fallthrough is unnecessary here.

> +	case TSC1641_LUL:

fallthrough is unnecessary here.

> +		fallthrough;
> +	case TSC1641_LOAD_VOLTAGE:
> +		return (regval * TSC1641_VLOAD_LSB_MILLIVOLT);
> +	case TSC1641_POWER:
> +		fallthrough;

fallthrough is unnecessary here.

> +	case TSC1641_POL:
> +		return (regval * TSC1641_POWER_LSB_MICROWATT);
> +	case TSC1641_CURRENT:
> +		val = regval * data->current_lsb_uA;
> +		/* Current in milliamps */
> +		return DIV_ROUND_CLOSEST(val, 1000);
> +	case TSC1641_TEMP:
> +		fallthrough;

fallthrough is unnecessary here.

> +	case TSC1641_TOL:
> +		return (regval * TSC1641_TEMP_LSB_MILLIDEGC);
> +	default:
> +		WARN_ON_ONCE(1);

I would strongly suggest to drop tsc1641_reg_to_value() as well as
tsc1641_value_to_reg() and do the conversions where needed.

> +		return 0;
> +	}
> +}
> +
> +static int tsc1641_value_to_reg(struct tsc1641_data *data, u8 reg, unsigned int val)
> +{
> +	int regval;
> +
> +	switch (reg) {
> +	case TSC1641_SOL:
> +		fallthrough;

Not needed.

> +	case TSC1641_SUL:
> +		/* value is in milliamps, so convert to voltage first */
> +		regval = (s16)val * data->rshunt_uohm;
> +		regval = DIV_ROUND_CLOSEST(regval, TSC1641_VSHUNT_LSB_NANOVOLT);
> +		return clamp_val(regval, SHRT_MIN, SHRT_MAX);
> +	case TSC1641_LOL:
> +		fallthrough;

Not needed.

> +	case TSC1641_LUL:
> +		regval = DIV_ROUND_CLOSEST(val, TSC1641_VLOAD_LSB_MILLIVOLT);
> +		return clamp_val(regval, 0, USHRT_MAX);
> +	case TSC1641_POL:
> +		regval = DIV_ROUND_CLOSEST(val, TSC1641_POWER_LSB_MICROWATT);
> +		return clamp_val(regval, 0, USHRT_MAX);
> +	case TSC1641_TOL:
> +		regval = DIV_ROUND_CLOSEST(val, TSC1641_TEMP_LSB_MILLIDEGC);
> +		return clamp_val(regval, 0, USHRT_MAX);
> +	default:
> +		/* shouldn't be here */
> +		WARN_ON_ONCE(1);
> +		return 0;
> +	}
> +}
> +
> +static int tsc1641_alert_limit_read(struct tsc1641_data *data, u32 mask, int reg, long *val)
> +{
> +	struct regmap *regmap = data->regmap;
> +	int regval;
> +	int ret;
> +
> +	mutex_lock(&data->update_lock);
> +	ret = regmap_read(regmap, TSC1641_MASK, &regval);
> +	if (ret)
> +		goto abort;
> +
> +	if (regval & mask) {
> +		ret = regmap_read(regmap, reg, &regval);
> +		if (ret)
> +			goto abort;
> +		*val = tsc1641_reg_to_value(data, reg, regval);
> +	} else {
> +		*val = 0;

If limits are masked, and the situation is static, the attributes
should not be created in the first place. Returning 0 if a limit is
masked is wrong.

Actually, looking into the datasheets, the mask register only enables
the ALERT mask and reporting if limits are exceeeded. Setting and reading
the limits is always supported.

> +	}
> +abort:
> +	mutex_unlock(&data->update_lock);
> +	return ret;
> +}
> +
> +static int tsc1641_alert_limit_write(struct tsc1641_data *data, u32 mask, int limit_reg,
> +				     long val)
> +{
> +	struct regmap *regmap = data->regmap;
> +	int ret;
> +
> +	if (val < 0)
> +		return -EINVAL;

The alert limit range should be clamped.

> +
> +	/*
> +	 * Disable alert mask first, then write the value and enable alert mask

Why ? 

> +	 */
> +	mutex_lock(&data->update_lock);
> +	ret = regmap_update_bits(regmap, TSC1641_MASK, mask, 0);
> +	if (ret < 0)
> +		goto abort;
> +	ret = regmap_write(regmap, limit_reg, tsc1641_value_to_reg(data, limit_reg, val));
> +	if (ret < 0)
> +		goto abort;
> +
> +	if (val)
> +		ret = regmap_update_bits(regmap, TSC1641_MASK, mask, mask);

Disabling alerts if the limit is 0 is wrong: The limit can be set
to 0 on purpose. Only unmasking the limit if a limit is set is just as wrong.
Either limits are enabled and reported, or they are disabled and the attributes
must not be generated. Mis-using the ABI to declare "If the limit value is
0, mask the limit. Otherwise set the limit and unmask it" is unacceptable.

> +abort:
> +	mutex_unlock(&data->update_lock);
> +	return ret;
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
> +	int ret;
> +
> +	switch (attr) {
> +	case hwmon_in_input:
> +		ret = regmap_read(regmap, TSC1641_LOAD_VOLTAGE, &regval);
> +		if (ret)
> +			return ret;
> +		*val = tsc1641_reg_to_value(data, TSC1641_LOAD_VOLTAGE, regval);
> +		break;
> +	case hwmon_in_lcrit:
> +		return tsc1641_alert_limit_read(data, TSC1641_LOAD_UV_MASK, TSC1641_LUL, val);
> +	case hwmon_in_crit:
> +		return tsc1641_alert_limit_read(data, TSC1641_LOAD_OV_MASK, TSC1641_LOL, val);
> +	case hwmon_in_lcrit_alarm:
> +		return tsc1641_alert_read(regmap, TSC1641_LOAD_UV_FLAG, val);
> +	case hwmon_in_crit_alarm:
> +		return tsc1641_alert_read(regmap, TSC1641_LOAD_OV_FLAG, val);
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +	return 0;
> +}
> +
> +static int tsc1641_curr_read(struct device *dev, u32 attr, long *val)
> +{
> +	struct tsc1641_data *data = dev_get_drvdata(dev);
> +	struct regmap *regmap = data->regmap;
> +	unsigned int regval;
> +	int ret;
> +
> +	/* Current limits are the shunt under/over voltage limits */
> +	switch (attr) {
> +	case hwmon_curr_input:
> +		ret = regmap_read(regmap, TSC1641_CURRENT, &regval);
> +		if (ret)
> +			return ret;
> +		*val = tsc1641_reg_to_value(data, TSC1641_CURRENT, regval);
> +		break;
> +	case hwmon_curr_lcrit:
> +		return tsc1641_alert_limit_read(data, TSC1641_SHUNT_UV_MASK,
> +						TSC1641_SUL, val);
> +	case hwmon_curr_crit:
> +		return tsc1641_alert_limit_read(data, TSC1641_SHUNT_OV_MASK,
> +						TSC1641_SOL, val);
> +	case hwmon_curr_lcrit_alarm:
> +		return tsc1641_alert_read(regmap, TSC1641_SHUNT_UV_FLAG, val);
> +	case hwmon_curr_crit_alarm:
> +		return tsc1641_alert_read(regmap, TSC1641_SHUNT_OV_FLAG, val);
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +	return 0;
> +}
> +
> +static int tsc1641_power_read(struct device *dev, u32 attr, long *val)
> +{
> +	struct tsc1641_data *data = dev_get_drvdata(dev);
> +	struct regmap *regmap = data->regmap;
> +	unsigned int regval;
> +	int ret;
> +
> +	switch (attr) {
> +	case hwmon_power_input:
> +		ret = regmap_read(regmap, TSC1641_POWER, &regval);
> +		if (ret)
> +			return ret;
> +		*val = tsc1641_reg_to_value(data, TSC1641_POWER, regval);
> +		break;
> +	case hwmon_power_crit:
> +		return tsc1641_alert_limit_read(data, TSC1641_POWER_OVER_MASK,
> +						TSC1641_POL, val);
> +	case hwmon_power_crit_alarm:
> +		return tsc1641_alert_read(regmap, TSC1641_POWER_OVER_FLAG, val);
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +	return 0;
> +}
> +
> +static int tsc1641_temp_read(struct device *dev, u32 attr, long *val)
> +{
> +	struct tsc1641_data *data = dev_get_drvdata(dev);
> +	struct regmap *regmap = data->regmap;
> +	unsigned int regval;
> +	int ret;
> +
> +	switch (attr) {
> +	case hwmon_temp_input:
> +		ret = regmap_read(regmap, TSC1641_TEMP, &regval);
> +		if (ret)
> +			return ret;
> +		*val = tsc1641_reg_to_value(data, TSC1641_TEMP, regval);
> +		break;
> +	case hwmon_temp_crit:
> +		return tsc1641_alert_limit_read(data, TSC1641_TEMP_OVER_MASK,
> +						TSC1641_TOL, val);
> +	case hwmon_temp_crit_alarm:
> +		return tsc1641_alert_read(regmap, TSC1641_TEMP_OVER_FLAG, val);
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +	return 0;
> +}
> +
> +static int tsc1641_in_write(struct device *dev, u32 attr, long val)
> +{
> +	struct tsc1641_data *data = dev_get_drvdata(dev);
> +
> +	switch (attr) {
> +	case hwmon_in_lcrit:
> +		return tsc1641_alert_limit_write(data, TSC1641_LOAD_UV_MASK, TSC1641_LUL, val);
> +	case hwmon_in_crit:
> +		return tsc1641_alert_limit_write(data, TSC1641_LOAD_OV_MASK, TSC1641_LOL, val);
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +	return 0;
> +}
> +
> +static int tsc1641_curr_write(struct device *dev, u32 attr, long val)
> +{
> +	struct tsc1641_data *data = dev_get_drvdata(dev);
> +
> +	switch (attr) {
> +	case hwmon_curr_lcrit:
> +		return tsc1641_alert_limit_write(data, TSC1641_SHUNT_UV_MASK,
> +						TSC1641_SUL, val);
> +	case hwmon_curr_crit:
> +		return tsc1641_alert_limit_write(data, TSC1641_SHUNT_OV_MASK,
> +						TSC1641_SOL, val);
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +	return 0;
> +}
> +
> +static int tsc1641_power_write(struct device *dev, u32 attr, long val)
> +{
> +	struct tsc1641_data *data = dev_get_drvdata(dev);
> +
> +	switch (attr) {
> +	case hwmon_power_crit:
> +		return tsc1641_alert_limit_write(data, TSC1641_POWER_OVER_MASK,
> +						 TSC1641_POL, val);
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +	return 0;
> +}
> +
> +static int tsc1641_temp_write(struct device *dev, u32 attr, long val)
> +{
> +	struct tsc1641_data *data = dev_get_drvdata(dev);
> +
> +	switch (attr) {
> +	case hwmon_temp_crit:
> +		return tsc1641_alert_limit_write(data, TSC1641_TEMP_OVER_MASK,
> +						 TSC1641_TOL, val);
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +	return 0;
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
> +static ssize_t shunt_voltage_uvolts_show(struct device *dev,
> +					 struct device_attribute *da, char *buf)
> +{
> +	struct tsc1641_data *data = dev_get_drvdata(dev);
> +	struct regmap *regmap = data->regmap;
> +	unsigned int regval;
> +	int ret;
> +
> +	ret = regmap_read(regmap, TSC1641_SHUNT_VOLTAGE, &regval);
> +	if (ret)
> +		return ret;
> +	int val = tsc1641_reg_to_value(data, TSC1641_SHUNT_VOLTAGE, regval);
> +
> +	return sysfs_emit(buf, "%d\n", val);
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
> +	mutex_lock(&data->update_lock);
> +	ret = tsc1641_set_shunt(data, val);
> +	mutex_unlock(&data->update_lock);
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
> +static DEVICE_ATTR_RO(shunt_voltage_uvolts);
> +
> +/* Rshunt and shunt voltage value is exposed via sysfs attributes */
> +static struct attribute *tsc1641_attrs[] = {
> +	&dev_attr_shunt_resistor.attr,
> +	&dev_attr_shunt_voltage_uvolts.attr,

Either report as standard voltage (in0_input) or drop entirely.
The shunt voltage can be calculated from the shunt resisor value and
the current. A non-standard attribute to report it does not add value.

> +	NULL,
> +};
> +ATTRIBUTE_GROUPS(tsc1641);
> +
> +static int tsc1641_init(struct device *dev, struct tsc1641_data *data)
> +{
> +	struct regmap *regmap = data->regmap;
> +	u32 shunt;
> +	int ret;
> +
> +	if (device_property_read_u32(dev, "shunt-resistor", &shunt) < 0) {
> +		shunt = TSC1641_RSHUNT_DEFAULT;
> +		dev_info(dev, "using default shunt-resistor value =%u uOhm\n",

The "=" does not add any value here.

> +			 shunt);
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
> +	bool active_high = device_property_read_bool(dev, "st,alert-polarity-active-high");
> +
> +	regmap_update_bits(regmap, TSC1641_MASK, TSC1641_ALERT_POL_MASK,
> +			   FIELD_PREP(TSC1641_ALERT_POL_MASK, active_high));

Why ignore errors here ?

> +
> +	return 0;
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
> +	mutex_init(&data->update_lock);
> +
> +	data->regmap = devm_regmap_init_i2c(client, &tsc1641_regmap_config);
> +	if (IS_ERR(data->regmap)) {
> +		dev_err(dev, "failed to allocate register map\n");
> +		return PTR_ERR(data->regmap);
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

Rshunt is displayed twice if the default is set. This is unnecessary noise.

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
> +

Unnecessary empty line.

