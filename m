Return-Path: <linux-kernel+bounces-818159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18376B58DB7
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 07:03:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5AC92A1468
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 05:03:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F28A72610;
	Tue, 16 Sep 2025 05:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bGhrMo3q"
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B657F2264CC
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 05:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757998976; cv=none; b=HxgK45DL5JVu5O2FyX6CX1kJ+61HXODDh0WgqAV9d9Gdl3jmXUrA0UPBe1ePv7ULZguJBtzZ7CMVTfjFggL9WdmKkuexPw20e5eNUhtfF0jB3MgH8Km6z0aov5/8nWsaURxoTWeofBANbiPyQQQdnvs16G56yNy97QP9xICo0g4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757998976; c=relaxed/simple;
	bh=7Ond/6XS/Qp7aJ1U5Qboqmdb13ttXet1eJuaYoicB7s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cq80uhLUPWlG2Qs/8WGXUqnRLc51YTntQaqpaIMf/MA4C7eVm4FIUv46Xa+8xqRcuALilFTnXJtDsdKdS9ym16SbZZvWu4lVuhwip95oEF4ZDV2zaWp/Opd3IAps0mARh5LavhFnR5C/P2Lfs/8c+uUl2pdqVLcMarlHdSWP/K0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bGhrMo3q; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 16 Sep 2025 13:02:45 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757998971;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=utxZJdq4SZsBiWUz44H+KI3zwoW+fq5Bdwpbp1UmMaM=;
	b=bGhrMo3qD7K+HCnofyyIIrfk4PBklpsnn6mhm+nnnomjkuhNbl0aMLhDgOXLuQVZRjbGQh
	zPuKa+I1UyTPucizOnKO7cvvz1qTlbMNVYeAvHAWXZIgfXv0Cp3NYBQqQf6jHBhIUND63T
	nwHnPzMNNWdOvrV+MPAxAymAScWdD4M=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Troy Mitchell <troy.mitchell@linux.dev>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	Troy Mitchell <troy.mitchell@linux.dev>
Subject: Re: [PATCH 3/3] hwmon: (ctf2301) Add support for CTF2301
Message-ID: <aMjvdWUNF6vXH65_@LT-Guozexi>
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
X-Migadu-Flow: FLOW_OUT

On Tue, Sep 16, 2025 at 12:46:46PM +0800, Troy Mitchell wrote:
> This commit introduces driver for the Sensylink CTF2301
> system-level thermal management solution chip.
> 
> Currently, the driver does NOT support the Auto-Temp mode of the PWM
> fan controller, which provides closed-loop automatic fan speed control
> based on temperature.
> 
> Now this driver supports:
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
> +#define CTF2301_RMT_TEMP_MSB			0x01
> +#define CTF2301_ALERT_STATUS			0x02
> +#define CTF2301_GLOBAL_CFG			0x03
> +#define CTF2301_RMT_TEMP_LSB			0x10
> +#define CTF2301_LOCAL_TEMP_LSB			0x15
> +#define CTF2301_ALERT_MASK			0x16
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
> +struct ctf2301 {
> +	struct i2c_client *client;
> +
> +	struct regmap *regmap;
> +
> +	unsigned int pwm_freq_code;
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
> +
> +		if (channel == 1) {
> +			err = regmap_read(ctf2301->regmap, CTF2301_ALERT_STATUS, regval);
> +			if (err)
> +				return err;
> +
> +			if (regval[0] & ALERT_STATUS_RDFA)
> +				return -ENODEV;
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
> +
> +		dev_err(dev, "local temp: lsb->0x%x, msb->0x%x", regval[1], regval[0]);
Sry I forget to remove debug info.
I'll remove them in the next version.
There are some more below, please ignore.

                    - Troy
> +
> +		raw = (s16)((regval[0] << 8) | regval[1]);
> +
> +		raw >>= shift;
> +
> +		*val = raw * scale * flag;
> +
> +		break;
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +
> +	return 0;
> +}
> +
> +static int ctf2301_read_fan(struct device *dev, u32 attr, long *val)
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
> +
> +		speed = (regval[0] << 8) | regval[1];
> +
> +		*val = (unsigned int)(1 * (5400000 / speed));
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
> +
> +	switch (attr) {
> +	case hwmon_pwm_input:
> +		map_val = (val * ctf2301->pwm_freq_code * 2) / 255;
> +		dev_err(dev, "val:%ld, map_val: %d", val, map_val);
> +		err = regmap_write(ctf2301->regmap, CTF2301_PWM_VALUE, map_val);
> +		if (err)
> +			return err;
> +		break;
> +	case hwmon_pwm_freq:
> +		ctf2301->pwm_freq_code = DIV_ROUND_UP(PWM_PARENT_CLOCK, val) / 2;
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
> 
> -- 
> 2.51.0
> 

