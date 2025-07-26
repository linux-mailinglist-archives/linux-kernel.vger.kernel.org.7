Return-Path: <linux-kernel+bounces-746791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D43D0B12B23
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 17:47:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53E443B4691
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 15:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5F1D246781;
	Sat, 26 Jul 2025 15:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UBzuko0t"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 430301BD01D;
	Sat, 26 Jul 2025 15:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753544832; cv=none; b=AGEbn5CrGLS1BKqbyk7GmbW1iFkJs1hbMv6ejKqadAoDgdF918AD77r08mRbawGQkysCZn0IUdBltmE9LA0pWdvjjCKlqN1fEmpYnpz3G4ehIdNWhPBl0H3T7otlj0TlhnkXDDkENeYQHLTVdQgyljF3Vsg3In/gqcIzUilZsDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753544832; c=relaxed/simple;
	bh=5JxJKAyMlnM/c06/dwR2ySk47CPq6kqAB3pNSAqxaWI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DllVSAzpKAbV5FZEsS6AHiyCtkrYqT5zFo7d/bdesjT4gq9hm7bj3NQNGpT4U5AyEP5AbM2hIOOL3RJSifx2seQZbGsUjvvJ2gZ6olbN8zd/SGCFpPsvXBgePN539JPpKSM6q0gSgJ3kNDNe0MJmmfYf16UTbzmr9J8oIAScTfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UBzuko0t; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753544830; x=1785080830;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5JxJKAyMlnM/c06/dwR2ySk47CPq6kqAB3pNSAqxaWI=;
  b=UBzuko0te44An5ruK5xmW2VE+SKfog3YchITMxZMwgyMalf3tOvvGsxd
   BomTZBJZBwFqlODq5MLJ+ZuwpDbuYVmwoaki7EKMEoGq0TCLh3+vwKY2j
   mNd9ixM9klVUe0MK7DaCQKmv8cItZ+jl6+tp6JlZqLP8f2n1zjRyB+xEq
   mc2E8/6GteaykpN98MHoEjRmgOQx2fUuQMEvbxflf4Tav9mofxO0cDHt1
   +3auLEBxrv/17nWVQZej0OZcTpUf3OGCOafWj4jbaHowDLOuxdBRBJSRz
   m+irprIYJ++hF1SQK3DVbyW8tjp16TKv58oSkyVyTmKXQ9SBAvmdT5yrQ
   A==;
X-CSE-ConnectionGUID: +86ToCtXRKmKCwxGXNYLqw==
X-CSE-MsgGUID: DUk1Y98mRBKGP67bDpqjsw==
X-IronPort-AV: E=McAfee;i="6800,10657,11504"; a="67207106"
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="67207106"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2025 08:47:10 -0700
X-CSE-ConnectionGUID: 06UZg2vIRUyCS/VAlQOq1g==
X-CSE-MsgGUID: UHxJ/NkMSgmt53Pl16xBoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="160910299"
Received: from smoehrl-linux.amr.corp.intel.com (HELO localhost) ([10.124.220.149])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2025 08:47:09 -0700
Date: Sat, 26 Jul 2025 08:47:06 -0700
From: David Box <david.e.box@linux.intel.com>
To: "Derek J. Clark" <derekjohn.clark@gmail.com>
Cc: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, 
	Hans de Goede <hansg@kernel.org>, Jean Delvare <jdelvare@suse.com>, 
	Guenter Roeck <linux@roeck-us.net>, platform-driver-x86@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org
Subject: Re: [PATCH 1/4] platform/x86: (ayn-ec) Add PWM Fan HWMON Interface
Message-ID: <g7uqyudwzmveyqmpjohtgmx5clhdqvw5qhe7rtyki72khxrnjv@aejuyvqmqbqn>
References: <20250725004533.63537-1-derekjohn.clark@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250725004533.63537-1-derekjohn.clark@gmail.com>

Hi,

On Thu, Jul 24, 2025 at 05:45:30PM -0700, Derek J. Clark wrote:
> Adds platform driver for Ayn Loki and Tactoy Zeenix lines of handheld
> devices. This patch implements a hwmon interface for EC provided manual
> PWM fan control and user defined fan curves. A global ACPI lock is used
> when reading or writing from the EC.
> 
> There are 4 fan modes implemented in this patch. Modes 0-3 act in
> accordance with the standard hwmon logic where 0 is 100% fan speed, 1 is
> manual control, and 2 is automatic control. As the EC only provides 3
> modes by default, mode 0 is implemented by setting the device to manual
> and then setting fan speed to 100% directly. In mode 1 the PWM duty cycle
> is set in sysfs with values [0-255], which are then scaled to the EC max
> of 128. Mode 4 is an automatic mode where the fan curve is user defined.
> There are 5 total set points and each set point takes a temperature in
> Celsius [0-100] and a PWM duty cycle [0-255]. When the CPU temperature
> reaches a given set point, the corresponding duty cycle is automatically
> set by the EC.
> 
> Signed-off-by: Derek J. Clark <derekjohn.clark@gmail.com>
> ---
>  MAINTAINERS                   |   6 +
>  drivers/platform/x86/Kconfig  |  14 +
>  drivers/platform/x86/Makefile |   3 +
>  drivers/platform/x86/ayn-ec.c | 596 ++++++++++++++++++++++++++++++++++
>  4 files changed, 619 insertions(+)
>  create mode 100644 drivers/platform/x86/ayn-ec.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d61b004005fd..5b816883fe7d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4035,6 +4035,12 @@ W:	https://ez.analog.com/linux-software-drivers
>  F:	Documentation/devicetree/bindings/pwm/adi,axi-pwmgen.yaml
>  F:	drivers/pwm/pwm-axi-pwmgen.c
>  
> +AYN PLATFORM EC DRIVER
> +M:	Derek J. Clark <derekjohn.clark@gmail.com>
> +L:	platform-driver-x86@vger.kernel.org
> +S:	Maintained
> +F:	drivers/platform/x86/ayn-ec.c
> +
>  AZ6007 DVB DRIVER
>  M:	Mauro Carvalho Chehab <mchehab@kernel.org>
>  L:	linux-media@vger.kernel.org
> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
> index 6d238e120dce..61391be65a7b 100644
> --- a/drivers/platform/x86/Kconfig
> +++ b/drivers/platform/x86/Kconfig
> @@ -304,6 +304,20 @@ config ASUS_TF103C_DOCK
>  	  If you have an Asus TF103C tablet say Y or M here, for a generic x86
>  	  distro config say M here.
>  
> +config AYN_EC
> +	tristate "Ayn x86 devices EC platform control"
> +	depends on ACPI
> +	depends on HWMON
> +	select LEDS_CLASS
> +	select LEDS_CLASS_MULTICOLOR
> +	help
> +	  This is a driver for Ayn and Tactoy x86 handheld devices. It provides
> +	  temperature monitoring, manual fan speed control, fan curve control,
> +	  and chassis RGB settings.
> +
> +	  If you have an x86 Ayn or Tactoy handheld device say M here. The module
> +	  will be called ayn-platform.
> +
>  config MERAKI_MX100
>  	tristate "Cisco Meraki MX100 Platform Driver"
>  	depends on GPIOLIB
> diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
> index a0c5848513e3..d32504b89365 100644
> --- a/drivers/platform/x86/Makefile
> +++ b/drivers/platform/x86/Makefile
> @@ -38,6 +38,9 @@ obj-$(CONFIG_ASUS_TF103C_DOCK)	+= asus-tf103c-dock.o
>  obj-$(CONFIG_EEEPC_LAPTOP)	+= eeepc-laptop.o
>  obj-$(CONFIG_EEEPC_WMI)		+= eeepc-wmi.o
>  
> +# Ayn
> +obj-$(CONFIG_AYN_EC)	+= ayn-ec.o
> +
>  # Cisco/Meraki
>  obj-$(CONFIG_MERAKI_MX100)	+= meraki-mx100.o
>  
> diff --git a/drivers/platform/x86/ayn-ec.c b/drivers/platform/x86/ayn-ec.c
> new file mode 100644
> index 000000000000..06f232bd10fa
> --- /dev/null
> +++ b/drivers/platform/x86/ayn-ec.c
> @@ -0,0 +1,596 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Platform driver for Ayn x86 Handhelds.
> + *
> + * Implements multiple attributes provided by the EC. Fan reading and control,
> + * as well as temperature sensor readings are exposed via hwmon sysfs. EC RGB
> + * control is exposed via an led-class-multicolor interface.
> + *
> + * Fan control is provided via a pwm interface in the range [0-255]. Ayn use
> + * [0-128] as the range in the EC, the written value is scaled to accommodate.
> + * The EC also provides a configurable fan curve with five set points that
> + * associate a temperature in Celcius [0-100] with a fan speed [0-128]. The
> + * auto_point fan speeds are also scaled from the range [0-255]. Temperature
> + * readings are scaled from degrees to millidegrees when read.
> + *
> + * RGB control is provided using 4 registers. One each for the colors red,
> + * green, and blue are [0-255]. There is also a effect register that takes
> + * switches between an EC controlled breathing that cycles through all colors
> + * and fades in/out, and manual, which enables setting a user defined color.
> + *
> + * Copyright (C) 2025 Derek J. Clark <derekjohn.clark@gmail.com>
> + */
> +
> +#include <linux/acpi.h>
> +#include <linux/device.h>
> +#include <linux/dmi.h>
> +#include <linux/hwmon-sysfs.h>
> +#include <linux/hwmon.h>
> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/sysfs.h>
> +#include <linux/types.h>
> +
> +/* Fan reading and PWM */
> +#define AYN_SENSOR_PWM_FAN_ENABLE_REG	0x10 /* PWM operating mode */
> +#define AYN_SENSOR_PWM_FAN_SET_REG	0x11 /* PWM duty cycle */
> +#define AYN_SENSOR_PWM_FAN_SPEED_REG	0x20 /* Fan speed */
> +
> +/* EC controlled fan curve registers */
> +#define AYN_SENSOR_PWM_FAN_SPEED_1_REG	0x12
> +#define AYN_SENSOR_PWM_FAN_SPEED_2_REG	0x14
> +#define AYN_SENSOR_PWM_FAN_SPEED_3_REG	0x16
> +#define AYN_SENSOR_PWM_FAN_SPEED_4_REG	0x18
> +#define AYN_SENSOR_PWM_FAN_SPEED_5_REG	0x1A
> +#define AYN_SENSOR_PWM_FAN_TEMP_1_REG	0x13
> +#define AYN_SENSOR_PWM_FAN_TEMP_2_REG	0x15
> +#define AYN_SENSOR_PWM_FAN_TEMP_3_REG	0x17
> +#define AYN_SENSOR_PWM_FAN_TEMP_4_REG	0x19
> +#define AYN_SENSOR_PWM_FAN_TEMP_5_REG	0x1B
> +
> +/* Handle ACPI lock mechanism */
> +#define ACPI_LOCK_DELAY_MS 500
> +enum ayn_model {
> +	ayn_loki_max = 1,
> +	ayn_loki_minipro,
> +	ayn_loki_zero,
> +	tactoy_zeenix_lite,
> +};
> +
> +struct ayn_device {
> +	u32 ayn_lock; /* ACPI EC Lock */
> +} drvdata;
> +
> +/* Handle ACPI lock mechanism */
> +#define ACPI_LOCK_DELAY_MS 500
> +
> +static bool lock_global_acpi_lock(void)
> +{
> +	return ACPI_SUCCESS(acpi_acquire_global_lock(ACPI_LOCK_DELAY_MS,
> +						     &drvdata.ayn_lock));
> +}
> +
> +static bool unlock_global_acpi_lock(void)
> +{
> +	return ACPI_SUCCESS(acpi_release_global_lock(drvdata.ayn_lock));
> +}
> +
> +/**
> + * read_from_ec() - Reads a value from the embedded controller.
> + *
> + * @reg: The register to start the read from.
> + * @size: The number of sequential registers the data is contained in.
> + * @val: Pointer to return the data with.
> + *
> + * Return: 0, or an error.
> + */
> +static int read_from_ec(u8 reg, int size, long *val)
> +{
> +	int ret, i;
> +	u8 buf;
> +
> +	if (!lock_global_acpi_lock())
> +		return -EBUSY;
> +
> +	*val = 0;
> +	for (i = 0; i < size; i++) {
> +		ret = ec_read(reg + i, &buf);
> +		if (ret)
> +			return ret;
> +		*val <<= i * 8;
> +		*val += buf;
> +	}
> +
> +	if (!unlock_global_acpi_lock())
> +		return -EBUSY;
> +
> +	return 0;
> +}
> +
> +/**
> + * write_to_ec() - Writes a value to the embedded controller.
> + *
> + * @reg: The register to write to.
> + * @val: Value to write
> + *
> + * Return: 0, or an error.
> + */
> +static int write_to_ec(u8 reg, u8 val)
> +{
> +	int ret;
> +
> +	if (!lock_global_acpi_lock())
> +		return -EBUSY;
> +
> +	pr_info("Writing EC value %d to register %u\n", val, reg);

pr_debug? You don't want to write out to the log every time.

> +	ret = ec_write(reg, val);
> +
> +	if (!unlock_global_acpi_lock())
> +		return -EBUSY;
> +
> +	return ret;
> +}
> +
> +/**
> + * ayn_pwm_manual() - Enable manual control of the fan.
> + */
> +static int ayn_pwm_manual(void)
> +{
> +	return write_to_ec(AYN_SENSOR_PWM_FAN_ENABLE_REG, 0x00);
> +}
> +
> +/**
> + * ayn_pwm_full() - Set fan to 100% speed.
> + */
> +static int ayn_pwm_full(void)
> +{
> +	int ret;
> +
> +	ret = write_to_ec(AYN_SENSOR_PWM_FAN_ENABLE_REG, 0x00);
> +	if (ret)
> +		return ret;
> +
> +	return write_to_ec(AYN_SENSOR_PWM_FAN_SET_REG, 128);
> +}
> +
> +/**
> + * ayn_pwm_auto() - Enable automatic EC control of the fan.
> + */
> +static int ayn_pwm_auto(void)
> +{
> +	return write_to_ec(AYN_SENSOR_PWM_FAN_ENABLE_REG, 0x01);
> +}
> +
> +/**
> + * ayn_pwm_auto() - Enable manually setting the fan curve for automatic
> + * EC control of the fan.
> + */
> +static int ayn_pwm_user(void)
> +{
> +	return write_to_ec(AYN_SENSOR_PWM_FAN_ENABLE_REG, 0x02);
> +}
> +
> +/**
> + * ayn_ec_hwmon_is_visible() - Determines RO or RW for hwmon attribute sysfs.
> + *
> + * @drvdata: Unused void pointer to context data.
> + * @type: The hwmon_sensor_types type.
> + * @attr: The attribute to set RO/RW on.
> + * @channel: HWMON subsystem usage flags for the attribute.
> + *
> + * Return: Permission level.
> + */
> +static umode_t ayn_ec_hwmon_is_visible(const void *drvdata,
> +				       enum hwmon_sensor_types type, u32 attr,
> +				       int channel)
> +{
> +	switch (type) {
> +	case hwmon_fan:
> +		return 0444;
> +	case hwmon_pwm:
> +		return 0644;
> +	default:
> +		return 0;
> +	}
> +}
> +
> +/**
> + * ayn_pwm_fan_read() - Read from a hwmon pwm or fan attribute.
> + *
> + * @dev: parent device of the given attribute.
> + * @type: The hwmon_sensor_types type.
> + * @attr: The attribute to read from.
> + * @channel: HWMON subsystem usage flags for the attribute.
> + * @val: Pointer to return the read value from.
> + *
> + * Return: 0, or an error.
> + */
> +static int ayn_pwm_fan_read(struct device *dev, enum hwmon_sensor_types type,
> +			    u32 attr, int channel, long *val)
> +{
> +	int ret;
> +
> +	switch (type) {
> +	case hwmon_fan:
> +		switch (attr) {
> +		case hwmon_fan_input:
> +			return read_from_ec(AYN_SENSOR_PWM_FAN_SPEED_REG, 2,
> +					    val);
> +		default:
> +			break;
> +		}
> +		break;
> +	case hwmon_pwm:
> +		switch (attr) {
> +		case hwmon_pwm_enable:
> +			ret = read_from_ec(AYN_SENSOR_PWM_FAN_ENABLE_REG, 1,
> +					   val);
> +			if (ret)
> +				return ret;
> +
> +			/* EC uses 0 for manual, 1 for automatic, 2 for user
> +			 * fan curve. Reflect hwmon usage instead.
> +			 */

If values have meaning then use #define.

> +			if (*val == 1) {
> +				*val = 2;
> +				return 0;
> +			}
> +
> +			if (*val == 2) {
> +				*val = 3;
> +				return 0;
> +			}
> +
> +			/* Return 0 when fan at max, otherwise 1 for manual. */
> +			ret = read_from_ec(AYN_SENSOR_PWM_FAN_SET_REG, 1, val);
> +			if (ret)
> +				return ret;
> +
> +			if (*val == 128)
> +				*val = 0;
> +			else
> +				*val = 1;
> +
> +			return ret;
> +		case hwmon_pwm_input:
> +			ret = read_from_ec(AYN_SENSOR_PWM_FAN_SET_REG, 1, val);
> +			if (ret)
> +				return ret;
> +
> +			*val = *val << 1; /* Max value is 128, scale to 255 */
> +
> +			return 0;
> +		default:
> +			break;
> +		}
> +		break;
> +	default:
> +		break;
> +	}
> +	return -EOPNOTSUPP;
> +}
> +
> +/**
> + * ayn_pwm_fan_write() - Write to a hwmon pwm attribute.
> + *
> + * @dev: parent device of the given attribute.
> + * @type: The hwmon_sensor_types type.
> + * @attr: The attribute to write to.
> + * @channel: HWMON subsystem usage flags for the attribute.
> + * @val: Value to write.
> + *
> + * Return: 0, or an error.
> + */
> +static int ayn_pwm_fan_write(struct device *dev, enum hwmon_sensor_types type,
> +			     u32 attr, int channel, long val)
> +{
> +	switch (type) {
> +	case hwmon_pwm:
> +		switch (attr) {
> +		case hwmon_pwm_enable:
> +			switch (val) {
> +			case 0:
> +				return ayn_pwm_full();
> +			case 1:
> +				return ayn_pwm_manual();
> +			case 2:
> +				return ayn_pwm_auto();
> +			case 3:
> +				return ayn_pwm_user();
> +			default:
> +				return -EINVAL;
> +			}
> +		case hwmon_pwm_input:
> +			if (val < 0 || val > 255)
> +				return -EINVAL;
> +
> +			val = val >> 1; /* Max value is 128, scale from 255 */
> +
> +			return write_to_ec(AYN_SENSOR_PWM_FAN_SET_REG, val);
> +		default:
> +			break;
> +		}
> +		break;

Why a switch for 1 case? If expecting more that's okay, but if not
consider just doing a check for hwmon_pwm at the top,

	if (type != hwmon_pwm)
		return -EOPNOTSUPP;

> +	default:
> +		break;
> +	}
> +	return -EOPNOTSUPP;
> +}
> +
> +static const struct hwmon_channel_info *ayn_ec_sensors[] = {
> +	HWMON_CHANNEL_INFO(fan, HWMON_F_INPUT),
> +	HWMON_CHANNEL_INFO(pwm, HWMON_PWM_INPUT | HWMON_PWM_ENABLE),
> +	NULL,
> +};
> +
> +static const struct hwmon_ops ayn_ec_hwmon_ops = {
> +	.is_visible = ayn_ec_hwmon_is_visible,
> +	.read = ayn_pwm_fan_read,
> +	.write = ayn_pwm_fan_write,
> +};
> +
> +static const struct hwmon_chip_info ayn_ec_chip_info = {
> +	.ops = &ayn_ec_hwmon_ops,
> +	.info = ayn_ec_sensors,
> +};
> +
> +/**
> + * pwm_curve_store() - Write a fan curve speed or temperature value.
> + *
> + * @dev: The attribute's parent device.
> + * @attr: The attribute to read.
> + * @buf: Input value string from sysfs write.
> + *
> + * Return: Number of bytes read, or an error.
> + */
> +static ssize_t pwm_curve_store(struct device *dev,
> +			       struct device_attribute *attr, const char *buf,
> +			       size_t count)
> +{
> +	int ret, i, val;
> +	u8 reg;
> +
> +	ret = kstrtoint(buf, 0, &val);
> +	if (ret)
> +		return ret;
> +
> +	i = to_sensor_dev_attr(attr)->index;
> +	switch (i) {
> +	case 0:
> +		reg = AYN_SENSOR_PWM_FAN_SPEED_1_REG;
> +		break;
> +	case 1:
> +		reg = AYN_SENSOR_PWM_FAN_SPEED_2_REG;
> +		break;
> +	case 2:
> +		reg = AYN_SENSOR_PWM_FAN_SPEED_3_REG;
> +		break;
> +	case 3:
> +		reg = AYN_SENSOR_PWM_FAN_SPEED_4_REG;
> +		break;
> +	case 4:
> +		reg = AYN_SENSOR_PWM_FAN_SPEED_5_REG;
> +		break;
> +	case 5:
> +		reg = AYN_SENSOR_PWM_FAN_TEMP_1_REG;
> +		break;
> +	case 6:
> +		reg = AYN_SENSOR_PWM_FAN_TEMP_2_REG;
> +		break;
> +	case 7:
> +		reg = AYN_SENSOR_PWM_FAN_TEMP_3_REG;
> +		break;
> +	case 8:
> +		reg = AYN_SENSOR_PWM_FAN_TEMP_4_REG;
> +		break;
> +	case 9:
> +		reg = AYN_SENSOR_PWM_FAN_TEMP_5_REG;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}

If it doesn't break future extentions, you could put these values in an
array and just do,

        if (i >= ARRAY_SIZE(ayn_sensor_pwm_mode))
                return -EINVAL;

        reg = ayn_sensor_pwm_mode[i];

Or you could split into separate speed and temp array and mangage the
offset for temp.

> +
> +	switch (i) {
> +	case 0:
> +	case 1:
> +	case 2:
> +	case 3:
> +	case 4:
> +		if (val < 0 || val > 255)
> +			return -EINVAL;
> +		val = val >> 1; /* Max EC value is 128, scale from 255 */
> +		break;
> +	case 5:
> +	case 6:
> +	case 7:
> +	case 8:
> +	case 9:
> +		if (val < 0 || val > 100)
> +			return -EINVAL;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	ret = write_to_ec(reg, val);
> +	if (ret)
> +		return ret;
> +	return count;
> +}
> +
> +/**
> + * pwm_curve_show() - Read a fan curve speed or temperature value.
> + *
> + * @dev: The attribute's parent device.
> + * @attr: The attribute to read.
> + * @buf: Buffer to read to.
> + *
> + * Return: Number of bytes read, or an error.
> + */
> +static ssize_t pwm_curve_show(struct device *dev, struct device_attribute *attr,
> +			      char *buf)
> +{
> +	int i, ret;
> +	long val;
> +	u8 reg;
> +
> +	i = to_sensor_dev_attr(attr)->index;
> +	switch (i) {
> +	case 0:
> +		reg = AYN_SENSOR_PWM_FAN_SPEED_1_REG;
> +		break;
> +	case 1:
> +		reg = AYN_SENSOR_PWM_FAN_SPEED_2_REG;
> +		break;
> +	case 2:
> +		reg = AYN_SENSOR_PWM_FAN_SPEED_3_REG;
> +		break;
> +	case 3:
> +		reg = AYN_SENSOR_PWM_FAN_SPEED_4_REG;
> +		break;
> +	case 4:
> +		reg = AYN_SENSOR_PWM_FAN_SPEED_5_REG;
> +		break;
> +	case 5:
> +		reg = AYN_SENSOR_PWM_FAN_TEMP_1_REG;
> +		break;
> +	case 6:
> +		reg = AYN_SENSOR_PWM_FAN_TEMP_2_REG;
> +		break;
> +	case 7:
> +		reg = AYN_SENSOR_PWM_FAN_TEMP_3_REG;
> +		break;
> +	case 8:
> +		reg = AYN_SENSOR_PWM_FAN_TEMP_4_REG;
> +		break;
> +	case 9:
> +		reg = AYN_SENSOR_PWM_FAN_TEMP_5_REG;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}

Same here.

David

> +
> +	ret = read_from_ec(reg, 1, &val);
> +	if (ret)
> +		return ret;
> +
> +	switch (i) {
> +	case 0:
> +	case 1:
> +	case 2:
> +	case 3:
> +	case 4:
> +		val = val << 1; /* Max EC value is 128, scale to 255 */
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	return sysfs_emit(buf, "%ld\n", val);
> +}
> +
> +/* Fan curve attributes */
> +static SENSOR_DEVICE_ATTR_RW(pwm1_auto_point1_pwm, pwm_curve, 0);
> +static SENSOR_DEVICE_ATTR_RW(pwm1_auto_point2_pwm, pwm_curve, 1);
> +static SENSOR_DEVICE_ATTR_RW(pwm1_auto_point3_pwm, pwm_curve, 2);
> +static SENSOR_DEVICE_ATTR_RW(pwm1_auto_point4_pwm, pwm_curve, 3);
> +static SENSOR_DEVICE_ATTR_RW(pwm1_auto_point5_pwm, pwm_curve, 4);
> +static SENSOR_DEVICE_ATTR_RW(pwm1_auto_point1_temp, pwm_curve, 5);
> +static SENSOR_DEVICE_ATTR_RW(pwm1_auto_point2_temp, pwm_curve, 6);
> +static SENSOR_DEVICE_ATTR_RW(pwm1_auto_point3_temp, pwm_curve, 7);
> +static SENSOR_DEVICE_ATTR_RW(pwm1_auto_point4_temp, pwm_curve, 8);
> +static SENSOR_DEVICE_ATTR_RW(pwm1_auto_point5_temp, pwm_curve, 9);
> +
> +static struct attribute *ayn_sensors_attrs[] = {
> +	&sensor_dev_attr_pwm1_auto_point1_pwm.dev_attr.attr,
> +	&sensor_dev_attr_pwm1_auto_point1_temp.dev_attr.attr,
> +	&sensor_dev_attr_pwm1_auto_point2_pwm.dev_attr.attr,
> +	&sensor_dev_attr_pwm1_auto_point2_temp.dev_attr.attr,
> +	&sensor_dev_attr_pwm1_auto_point3_pwm.dev_attr.attr,
> +	&sensor_dev_attr_pwm1_auto_point3_temp.dev_attr.attr,
> +	&sensor_dev_attr_pwm1_auto_point4_pwm.dev_attr.attr,
> +	&sensor_dev_attr_pwm1_auto_point4_temp.dev_attr.attr,
> +	&sensor_dev_attr_pwm1_auto_point5_pwm.dev_attr.attr,
> +	&sensor_dev_attr_pwm1_auto_point5_temp.dev_attr.attr,
> +	NULL,
> +};
> +
> +ATTRIBUTE_GROUPS(ayn_sensors);
> +
> +static int ayn_ec_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct device *hwdev;
> +	int ret;
> +
> +	hwdev = devm_hwmon_device_register_with_info(dev, "aynec", NULL,
> +						     &ayn_ec_chip_info,
> +						     ayn_sensors_groups);
> +	return PTR_ERR_OR_ZERO(hwdev);
> +}
> +
> +static struct platform_driver ayn_ec_driver = {
> +	.driver = {
> +		.name = "ayn-ec",
> +	},
> +	.probe = ayn_ec_probe,
> +};
> +
> +static struct platform_device *ayn_ec_device;
> +
> +static int __init ayn_ec_init(void)
> +{
> +	ayn_ec_device = platform_create_bundle(&ayn_ec_driver, ayn_ec_probe,
> +					       NULL, 0, NULL, 0);
> +
> +	return PTR_ERR_OR_ZERO(ayn_ec_device);
> +}
> +
> +static void __exit ayn_ec_exit(void)
> +{
> +	platform_device_unregister(ayn_ec_device);
> +	platform_driver_unregister(&ayn_ec_driver);
> +}
> +
> +static const struct dmi_system_id ayn_dmi_table[] = {
> +	{
> +		.matches = {
> +			DMI_EXACT_MATCH(DMI_BOARD_VENDOR, "ayn"),
> +			DMI_EXACT_MATCH(DMI_BOARD_NAME, "Loki Max"),
> +		},
> +		.driver_data = (void *)ayn_loki_max,
> +	},
> +	{
> +		.matches = {
> +			DMI_EXACT_MATCH(DMI_BOARD_VENDOR, "ayn"),
> +			DMI_EXACT_MATCH(DMI_BOARD_NAME, "Loki MiniPro"),
> +		},
> +		.driver_data = (void *)ayn_loki_minipro,
> +	},
> +	{
> +		.matches = {
> +			DMI_EXACT_MATCH(DMI_BOARD_VENDOR, "ayn"),
> +			DMI_EXACT_MATCH(DMI_BOARD_NAME, "Loki Zero"),
> +		},
> +		.driver_data = (void *)ayn_loki_zero,
> +	},
> +	{
> +		.matches = {
> +			DMI_EXACT_MATCH(DMI_BOARD_VENDOR, "Tectoy"),
> +			DMI_EXACT_MATCH(DMI_BOARD_NAME, "Zeenix Lite"),
> +		},
> +		.driver_data = (void *)tactoy_zeenix_lite,
> +	},
> +	{},
> +};
> +
> +MODULE_DEVICE_TABLE(dmi, ayn_dmi_table);
> +
> +module_init(ayn_ec_init);
> +module_exit(ayn_ec_exit);
> +
> +MODULE_AUTHOR("Derek J. Clark <derekjohn.clark@gmail.com>");
> +MODULE_DESCRIPTION("Platform driver that handles EC sensors of Ayn x86 devices");
> +MODULE_LICENSE("GPL");
> -- 
> 2.50.0
> 
> 

