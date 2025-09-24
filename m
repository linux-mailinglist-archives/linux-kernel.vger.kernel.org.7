Return-Path: <linux-kernel+bounces-830871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C834B9AC18
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 17:44:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70A4816BDDF
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 15:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAB3830FC29;
	Wed, 24 Sep 2025 15:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TGdQdJPO"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B7B22127E
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 15:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758728621; cv=none; b=lw2SjxnWB4tYK8NgS2OzQOzpzjp5Nw7tkc5LtBbeAn/YtBtQMdicPB+qZ8SUctPBJcyUqEKyTYzGlPZfK+COwgTCo/uqi1gzOZwQ2R+uFV0b4t0Av7D0uy1q7jexzfVXTLc1mPRoQq2XvgyhRlmGZ4voaB/ysveSLL7neJFHQnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758728621; c=relaxed/simple;
	bh=WZRb7+DjF8QMNDop0D/1YN7VeclqiJu6gRcLKIIT+mc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CmnKWFfsoJG5s5Kb9iY7lIO5fBqNkze2cXPbsgeFTDbQuzsNIYLBnvkutz8liBExN0nnkb5m5wzRdHosQjHjGbPc8AUlWYowoxfemMF73/IN3MshIE5nofDatcUZWGXi01Pq71VOTdGc041ft3A1PmUOOUQ1ktb0kjDCoOBV4PQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TGdQdJPO; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-76e2ea933b7so1242179b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 08:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758728617; x=1759333417; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1ks4dFIz8QLAwcsWBUKnpEizXKioYep0ojUM+hoTX+s=;
        b=TGdQdJPOm5mdvUlruXmOTk+WCTakn1zJqYk8/lH2NcJk8Z2ljc3sRa3JxENiaVKThk
         1UaR7sJspd4Dzli9xFq7jLL4X1Ie1n+Vj/NUabvlMTd2DeX+gmUDC8F9yNq34ndeTvOd
         4xmoBKxtp+AXTZkKxlhCIc5iuBtvT/V3cuNhI2VVv4qUjVN3Rm+/uZN69G7aweQ0z6M+
         xIt0mrQVH2uTX9OBk94WBY3BAbiP/Btf6mfjY7cbKT3akhgLh82L5hJEHuXCnku5dHRf
         97QqYrYT9q4ovgmNIrnwOSvKPyg6lU9BPgRtausqRAkp5GUIZ6r4ZTdq/8VSXXnZOslQ
         29+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758728617; x=1759333417;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1ks4dFIz8QLAwcsWBUKnpEizXKioYep0ojUM+hoTX+s=;
        b=UwSkce3h2NXuriiqL0+XRhlBhe5+G0WL8QlEjGH6rS98sDHBzNetfvZgUDH+9rn2KB
         AQ+ULpPWFn2Yp4Cmal80XO76+3YQpAhL6k7UMpbS+yZmw1BIgORjxTzyQ0lhivwplGtI
         4PdBtvS9jW8LpnX2oy3SwR6ler2hVU+FYV3g40ysBAQ7M+Jo9nenUG16fQARn9oeprCz
         1PxSn6TA39HKW2GC1zJ3gz11s3Mow4rWrWVnC/wvOcUWSK8HKi+a/cLiX6cpDvMIlUh7
         aPRe5LlRv9tIhfIIFsxli6Bx4gVNLF96zPtMZJGiWa43hG61UuwDEARo00Zjb9I4Wnwm
         Lerw==
X-Forwarded-Encrypted: i=1; AJvYcCVTooM8hV2olpnirwDxYoELiLcI5zeCxT6FOwk1y3/Cd6M03p4Dpk4ukUf000CuvU1wZVbwhjgaysTlK6E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9LUlsb4x1YcRbyb5/UTCxLD28285k+Qtl0/+YJJGFebapORcT
	fZA28wFWzrRPwIFSe6RELR+t546gkrY2L3sI4P+SM6caxF7Xo0xDR3+p
X-Gm-Gg: ASbGncv2AsJgu2KbRhAwD44Y8/6bf7iskH4FtuxfoTVtfu0nFvUOCUu4JXBdIjR4zNP
	GnXnOjo9DKZZeCU/eUf5X24DLn4dBCIu9lrE1We32w0JuTn77WXinO40Bwcg3dBI089v3Lw5O/r
	3JJ46NFc011TlwnEzLbHt+1UpckB+oU5Bplv/lmsSrWnyoUsiSF4/nddvVmRtJRSqjaKUFW3cL6
	FGQJkgK6Xlt1UPUn0uI6bhCKG3Ye/PEPapOOX2Al2wABXmYjvzXeLIDU7lFIt3jq6Mp/uyV5nBu
	mZY0a3QCl087nDi+HQij6kw+yUzNadpZzdis7Ua4/g4ZfZQFloJIIS1RfvoT1RMG7pw3mGIo+Yr
	7K5eCqtp20SFABFu1SKQxg/o9MFDOp7kfcfw1xddE1yZ0Pg==
X-Google-Smtp-Source: AGHT+IH9DTmvZ9j43eoOq3wKSwDjqQ7cjXTS3KNKJ5Aq0iTju+ao3EARcSu2svEj2MLfjzAkHaP+SA==
X-Received: by 2002:a05:6a20:3ca7:b0:263:bee9:1af0 with SMTP id adf61e73a8af0-2e7ca028460mr104782637.2.1758728616701;
        Wed, 24 Sep 2025 08:43:36 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3341bda1085sm2792940a91.10.2025.09.24.08.43.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 08:43:36 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 24 Sep 2025 08:43:35 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Troy Mitchell <troy.mitchell@linux.dev>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jean Delvare <jdelvare@suse.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org
Subject: Re: [PATCH 3/3] hwmon: (ctf2301) Add support for CTF2301
Message-ID: <53f1d5d2-c871-4823-ab13-8c3dfd86dbfe@roeck-us.net>
References: <20250916-ctl2301-v1-0-97e7c84f2c47@linux.dev>
 <20250916-ctl2301-v1-3-97e7c84f2c47@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250916-ctl2301-v1-3-97e7c84f2c47@linux.dev>

On Tue, Sep 16, 2025 at 12:46:46PM +0800, Troy Mitchell wrote:
> This commit introduces driver for the Sensylink CTF2301
> system-level thermal management solution chip.
> 
Documentation/process/submitting-patches.rst:

"Describe your changes in imperative mood, e.g. "make xyzzy do frotz"
 instead of "[This patch] makes xyzzy do frotz" or "[I] changed xyzzy
 to do frotz", as if you are giving orders to the codebase to change
 its behaviour."

-->

"Add support for ..."

> Currently, the driver does NOT support the Auto-Temp mode of the PWM
> fan controller, which provides closed-loop automatic fan speed control
> based on temperature.
> 
> Now this driver supports:

Now -> Currently

>   - Reading local temperature.
>   - Reading remote temperature.
>   - Controlling the PWM fan output in Direct-DCY mode (direct duty cycle control).
>   - Monitoring fan speed via the TACH input (RPM measurement).
> 
> Signed-off-by: Troy Mitchell <troy.mitchell@linux.dev>
> ---
>  drivers/hwmon/Kconfig   |  11 ++
>  drivers/hwmon/Makefile  |   1 +
>  drivers/hwmon/ctf2301.c | 326 ++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 338 insertions(+)
> 
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index 9d28fcf7cd2a6f9e2f54694a717bd85ff4047b46..2120d891e549795c3f3416d08f71916af714f6b6 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -537,6 +537,17 @@ config SENSORS_CROS_EC
>  	  This driver can also be built as a module. If so, the module
>  	  will be called cros_ec_hwmon.
>  
> +config SENSORS_CTF2301
> +	tristate "Sensylink CTF2301"
> +	depends on I2C
> +	select REGMAP
> +	help
> +	  If you say yes here you get support for Sensylink CTF2301
> +	  sensor chip.
> +
> +	  This driver can also be built as a module. If so, the module
> +	  will be called ctf2301.
> +
>  config SENSORS_DRIVETEMP
>  	tristate "Hard disk drives with temperature sensors"
>  	depends on SCSI && ATA
> diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
> index cd8bc4752b4dbf015c6eb46157626f4e8f87dfae..12f2894ce8d5fbfd942409f6c43d78fbdece57b4 100644
> --- a/drivers/hwmon/Makefile
> +++ b/drivers/hwmon/Makefile
> @@ -65,6 +65,7 @@ obj-$(CONFIG_SENSORS_CORETEMP)	+= coretemp.o
>  obj-$(CONFIG_SENSORS_CORSAIR_CPRO) += corsair-cpro.o
>  obj-$(CONFIG_SENSORS_CORSAIR_PSU) += corsair-psu.o
>  obj-$(CONFIG_SENSORS_CROS_EC)	+= cros_ec_hwmon.o
> +obj-$(CONFIG_SENSORS_CTF2301)	+= ctf2301.o
>  obj-$(CONFIG_SENSORS_DA9052_ADC)+= da9052-hwmon.o
>  obj-$(CONFIG_SENSORS_DA9055)+= da9055-hwmon.o
>  obj-$(CONFIG_SENSORS_DELL_SMM)	+= dell-smm-hwmon.o
> diff --git a/drivers/hwmon/ctf2301.c b/drivers/hwmon/ctf2301.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..2fea4d195519ea34c1d4bf67456098b225d4d13c
> --- /dev/null
> +++ b/drivers/hwmon/ctf2301.c
> @@ -0,0 +1,326 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Driver for CTF2301 system-level thermal management solution chip
> + * Datasheet: https://www.sensylink.com/upload/1/net.sensylink.portal/1689557281035.pdf
> + *
> + * Copyright (C) 2025 Troy Mitchell <troy.mitchell@linux.dev>
> + */
> +
> +#include <linux/hwmon.h>
> +#include <linux/i2c.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/regmap.h>
> +
> +#define PWM_PARENT_CLOCK			360000
> +
> +#define CTF2301_LOCAL_TEMP_MSB			0x00
	LM90_REG_LOCAL_TEMP
> +#define CTF2301_RMT_TEMP_MSB			0x01
	LM90_REG_REMOTE_TEMPH
> +#define CTF2301_ALERT_STATUS			0x02
	LM90_REG_STATUS
> +#define CTF2301_GLOBAL_CFG			0x03
	LM90_REG_CONFIG1
> +#define CTF2301_RMT_TEMP_LSB			0x10
	LM90_REG_REMOTE_TEMPL
> +#define CTF2301_LOCAL_TEMP_LSB			0x15
	TMP451_REG_LOCAL_TEMPL
> +#define CTF2301_ALERT_MASK			0x16
	TMP461_REG_CHEN

So far this looks like a chip based on LM90 or TMP451/TMP461
with an added fan controller. I can not immediatey determine
if it would be better to add the pwm/tach support to the lm90
driver. Given that the chip (based on registers) does support
limits, which is not implemented here but essential for a chip
like this, I would very much prefer adding support for it to the
lm90 driver if possible.

The public datasheet does not provide register details, making it
all but impossible to do a real evaluation. Any idea how to get
a complete datasheet ?

> +#define	CTF2301_ENHANCED_CFG			0x45
> +#define CTF2301_TACH_COUNT_LSB			0x46
> +#define CTF2301_TACH_COUNT_MSB			0x47
> +#define CTF2301_PWM_AND_TACH_CFG		0x4a
> +#define CTF2301_PWM_VALUE			0x4c
> +#define CTF2301_PWM_FREQ			0x4d
> +#define CTF2301_RMT_DIODE_TEMP_FILTER		0xbf
> +
> +/* remote diode fault alarm */
> +#define ALERT_STATUS_RDFA			BIT(2)
> +
> +/* alert interrupts enable  */
> +#define GLOBAL_CFG_ALERT_MASK			BIT(7)
> +/* tach input enable  */
> +#define GLOBAL_CFG_TACH_SEL			BIT(2)
> +
> +/* local high temperature alarm mask */
> +#define ALERT_MASK_LHAM				BIT(6)
> +/* remote high temperature alarm mask */
> +#define ALERT_MASK_RHAM				BIT(4)
> +/* remote low temperature alarm mask */
> +#define ALERT_MASK_RLAM				BIT(3)
> +/* remote t_crit alarm mask */
> +#define ALERT_MASK_RCAM				BIT(1)
> +/* tachometer alarm mask */
> +#define ALERT_MASK_TCHAM			BIT(0)
> +
> +#define ALERT_MASK_ALL				(ALERT_MASK_LHAM | ALERT_MASK_RHAM | \
> +						ALERT_MASK_RLAM | ALERT_MASK_RCAM | \
> +						ALERT_MASK_TCHAM)
> +
> +/* enables signed format for high and t_crit setpoints */
> +#define ENHANGCED_CFG_USF			BIT(3)
> +
> +/* PWM Programming enable */
> +#define PWM_AND_TACH_CFG_PWPGM			BIT(5)
> +
> +#define PWM_DEFAULT_FREQ_CODE			0x17
> +
> +

No mode than one empty line. checkpatch --strict would tell.
And, indeed, it reports:

total: 0 errors, 4 warnings, 3 checks, 350 lines checked

where

WARNING: Prefer a maximum 75 chars per line (possible unwrapped commit description?)
CHECK: Please don't use multiple blank lines
CHECK: Alignment should match open parenthesis

are relevant and need to be fixed.

> +struct ctf2301 {
> +	struct i2c_client *client;

Not used anywhere.

> +
> +	struct regmap *regmap;
> +
> +	unsigned int pwm_freq_code;

Unnecessary empty lines.

> +};
> +
> +static int ctf2301_read_temp(struct device *dev, u32 attr, int channel, long *val)
> +{
> +	int regval[2], raw, err, flag = 1, shift = 4, scale = 625;
> +	struct ctf2301 *ctf2301 = dev_get_drvdata(dev);
> +	unsigned int reg_msb = CTF2301_LOCAL_TEMP_MSB,
> +		     reg_lsb = CTF2301_LOCAL_TEMP_LSB;
> +
> +	switch (attr) {
> +	case hwmon_temp_input:
> +		if (channel != 0 && channel != 1)
> +			return -EOPNOTSUPP;

Should have been handled in is_visible function. It is, therefore
this check is unnecessary.

> +
> +		if (channel == 1) {
> +			err = regmap_read(ctf2301->regmap, CTF2301_ALERT_STATUS, regval);
> +			if (err)
> +				return err;
> +
> +			if (regval[0] & ALERT_STATUS_RDFA)
> +				return -ENODEV;

Wrong return value. The device does obviously exist. This should return
-ENODATA.

> +
> +			shift = 5;
> +			scale = 1250;
> +			reg_msb = CTF2301_RMT_TEMP_MSB;
> +			reg_lsb = CTF2301_RMT_TEMP_LSB;
> +		}
> +
> +		err = regmap_read(ctf2301->regmap, reg_msb, regval);
> +		if (err)
> +			return err;
> +
> +		err = regmap_read(ctf2301->regmap, reg_lsb, regval + 1);
> +		if (err)
> +			return err;

Consider using regmap_multi_reg_read() instead.

> +
> +		dev_err(dev, "local temp: lsb->0x%x, msb->0x%x", regval[1], regval[0]);

Really ?

Stopping complete review here. The driver is obviously not ready
for submission. Some more obvious comments below.


> +
> +		raw = (s16)((regval[0] << 8) | regval[1]);
> +
> +		raw >>= shift;
> +
> +		*val = raw * scale * flag;
> +
> +		break;

Drop empty lines.

> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +
> +	return 0;
> +}
> +
> +static int ctf2301_read_fan(struct device *dev, u32 attr, long *val)

There is only a single supported attribute, so passing its vbalue
to this function and checking it adds unnecessary complexity.
Just drop the parameter and all its complexity.

> +{
> +	struct ctf2301 *ctf2301 = dev_get_drvdata(dev);
> +	int regval[2], err, speed;
> +
> +	switch (attr) {
> +	case hwmon_fan_input:
> +		err = regmap_read(ctf2301->regmap, CTF2301_TACH_COUNT_MSB, regval);
> +		if (err)
> +			return err;
> +
> +		err = regmap_read(ctf2301->regmap, CTF2301_TACH_COUNT_LSB, regval + 1);
> +		if (err)
> +			return err;

CTF2301_TACH_COUNT_LSB and CTF2301_TACH_COUNT_MSB are consecutive registers,
so it should be possible to use regmap_bulk_read(). If not, consider using
regmap_multi_reg_read() and explain why regmap_bulk_read() does not work.

> +
> +		speed = (regval[0] << 8) | regval[1];
> +

speed can be 0.

> +		*val = (unsigned int)(1 * (5400000 / speed));
				      ^^^^ what is this for ?

The typecast is unnecessary, and speed needs to be checked to
ensure that there is no divide by zero error.

> +		break;
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +
> +	return 0;
> +}
> +
> +static int ctf2301_write_pwm(struct device *dev, u32 attr, long val)
> +{
> +	struct ctf2301 *ctf2301 = dev_get_drvdata(dev);
> +	int err, map_val;
> +
> +	dev_err(dev, "write pwm: %d", attr);

Not commmenting on those any further.

> +
> +	switch (attr) {
> +	case hwmon_pwm_input:
> +		map_val = (val * ctf2301->pwm_freq_code * 2) / 255;

val needs to be range checked, and the function needs to return
-EINVAL if it is out of range. Also consider using DIV_ROUND_CLOSEST().

> +		dev_err(dev, "val:%ld, map_val: %d", val, map_val);
> +		err = regmap_write(ctf2301->regmap, CTF2301_PWM_VALUE, map_val);
> +		if (err)
> +			return err;
> +		break;
> +	case hwmon_pwm_freq:
> +		ctf2301->pwm_freq_code = DIV_ROUND_UP(PWM_PARENT_CLOCK, val) / 2;

val needs to be clamped to its valid range.

> +		dev_err(dev, "pwm_freq_code: %d", ctf2301->pwm_freq_code);
> +		err = regmap_write(ctf2301->regmap, CTF2301_PWM_FREQ, ctf2301->pwm_freq_code);
> +		if (err)
> +			return err;
> +		break;
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +
> +	return 0;
> +}
> +
> +static umode_t ctf2301_is_visible(const void *drvdata,
> +				 enum hwmon_sensor_types type,
> +				 u32 attr, int channel)
> +{
> +	switch (type) {
> +	case hwmon_temp:
> +		switch (attr) {
> +		case hwmon_temp_input:
> +			return 0444;
> +		default:
> +			return 0;
> +		}
> +	case hwmon_fan:
> +		switch (attr) {
> +		case hwmon_fan_input:
> +			return 0444;
> +		default:
> +			return 0;
> +		}
> +	case hwmon_pwm:
> +		switch (attr) {
> +		case hwmon_pwm_input:
> +		case hwmon_pwm_freq:
> +			return 0644;
> +		default:
> +			return 0;
> +		}
> +	default:
> +		return 0;
> +	}
> +}
> +
> +static int ctf2301_read(struct device *dev, enum hwmon_sensor_types type,
> +		       u32 attr, int channel, long *val)
> +{
> +	switch (type) {
> +	case hwmon_temp:
> +		return ctf2301_read_temp(dev, attr, channel, val);
> +	case hwmon_fan:
> +		return ctf2301_read_fan(dev, attr, val);
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +	return 0;
> +}
> +
> +static int ctf2301_write(struct device *dev, enum hwmon_sensor_types type,
> +			 u32 attr, int channel, long val)
> +{
> +	switch (type) {
> +	case hwmon_pwm:
> +		return ctf2301_write_pwm(dev, attr, val);
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +	return 0;
> +}
> +
> +static const struct hwmon_channel_info * const ctf2301_info[] = {
> +	HWMON_CHANNEL_INFO(temp, HWMON_T_INPUT, HWMON_T_INPUT),
> +	HWMON_CHANNEL_INFO(pwm, HWMON_PWM_INPUT | HWMON_PWM_FREQ),
> +	HWMON_CHANNEL_INFO(fan, HWMON_F_INPUT),
> +	NULL
> +};
> +
> +static const struct hwmon_ops ctf2301_hwmon_ops = {
> +	.is_visible = ctf2301_is_visible,
> +	.read = ctf2301_read,
> +	.write = ctf2301_write
> +};
> +
> +static const struct hwmon_chip_info ctf2301_chip_info = {
> +	.ops = &ctf2301_hwmon_ops,
> +	.info = ctf2301_info,
> +};
> +
> +static const struct regmap_config ctf2301_regmap_config = {
> +	.max_register = CTF2301_RMT_DIODE_TEMP_FILTER,
> +	.reg_bits = 8,
> +	.val_bits = 8,
> +};
> +
> +static int ctf2301_probe(struct i2c_client *client)
> +{
> +	struct device *dev = &client->dev;
> +	struct device *hwmon_dev;
> +	struct ctf2301 *ctf2301;
> +	int err;
> +
> +	ctf2301 = devm_kzalloc(dev, sizeof(*ctf2301), GFP_KERNEL);
> +	if (!ctf2301)
> +		return -ENOMEM;
> +	ctf2301->client = client;
> +
> +	ctf2301->regmap = devm_regmap_init_i2c(client, &ctf2301_regmap_config);
> +	if (IS_ERR(ctf2301->regmap))
> +		return dev_err_probe(dev, PTR_ERR(ctf2301->regmap),
> +				     "failed to allocate register map");
> +
> +	err = regmap_write(ctf2301->regmap, CTF2301_GLOBAL_CFG,
> +			   GLOBAL_CFG_ALERT_MASK | GLOBAL_CFG_TACH_SEL);
> +	if (err)
> +		return dev_err_probe(dev, err,
> +				     "failed to write CTF2301_GLOBAL_CFG register");
> +
> +	/*err = regmap_write(ctf2301->regmap, CTF2301_ALERT_MASK, ALERT_MASK_ALL);*/
> +	/*if (err)*/
> +		/*return dev_err_probe(dev, err,*/
> +				     /*"failed to write CTF2301_ALERT_MASK");*/
> +
> +	err = regmap_write(ctf2301->regmap, CTF2301_ENHANCED_CFG, ENHANGCED_CFG_USF);
> +	if (err)
> +		return dev_err_probe(dev, err,
> +				     "failed to write CTF2301_ENHANCED_CFG");
> +
> +	err = regmap_write(ctf2301->regmap, CTF2301_PWM_AND_TACH_CFG, PWM_AND_TACH_CFG_PWPGM);
> +	if (err)
> +		return dev_err_probe(dev, err,
> +				     "failed to write CTF2301_PWM_AND_TACH_CFG");
> +
> +	ctf2301->pwm_freq_code = PWM_DEFAULT_FREQ_CODE;
> +
> +	hwmon_dev = devm_hwmon_device_register_with_info(dev, client->name, ctf2301,
> +							 &ctf2301_chip_info,
> +							 NULL);
> +	if (IS_ERR(hwmon_dev))
> +		return dev_err_probe(dev, PTR_ERR(hwmon_dev),
> +				     "failed to register hwmon device");
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id ctf2301_of_match[] = {
> +	{ .compatible = "sensylink,ctf2301", },
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, ctf2301_of_match);
> +
> +static struct i2c_driver ctf2301_driver = {
> +	.driver = {
> +		.name	= "ctf2301",
> +		.of_match_table = of_match_ptr(ctf2301_of_match),
> +	},
> +	.probe		= ctf2301_probe,
> +};
> +module_i2c_driver(ctf2301_driver);
> +
> +MODULE_AUTHOR("Troy Mitchell <troy.mitchell@linux.dev>");
> +MODULE_DESCRIPTION("ctf2301 driver");
> +MODULE_LICENSE("GPL");

