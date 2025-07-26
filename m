Return-Path: <linux-kernel+bounces-746920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D7500B12D14
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 01:33:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D22717B4F7
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 23:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2236B22AE75;
	Sat, 26 Jul 2025 23:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="FjwTHybT"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 578989460;
	Sat, 26 Jul 2025 23:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753572794; cv=none; b=DAcierk4zfIRXQeW7gNWDW5luT5CDGuC5n7ZDsgK4SC0FVflthNcYIeTnMHlSwW/9aD/ZgCIV6LSKjD/0tJmynVA6BLGZdPlCDVWV7ddYjlmwLVG8Dmo0amlBfpsrTVoH1krpxykDbzO3zpwq9iUw6qfmGgHxn+/Zgnhdz2kG10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753572794; c=relaxed/simple;
	bh=oh//U3G7volzqHi70VCDaOMpSnWAJY/m5DSQFvF/uI8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rlMnYDIIQDn0Xqno2WYtSvu+Vq/ZwJ5Vna5bnJL8rPBBXyfHcaGusqdyCXf109bxeHjU9ZlXo99BxLTyhyCi3SVKCz7EhhHmpzF4TCrwuYfR1oJIvhPg5bjPyiwokRkKUXUi+KRhKq9sH/1l9YZHk8sTIda4oyeNOnuj6Rd5HNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=FjwTHybT; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1753572760; x=1754177560; i=w_armin@gmx.de;
	bh=za782JTfn+1dblU27u61QQNKAqMSR5S/EfLxV7dv7wE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=FjwTHybTD2J7nFF4u8cQzLL7fgiSMEzjzPzuj7blJSnTw5TlpMD7rd5jePK7QGzW
	 acDEeB1uSR8+QudqW/udXdQJJrqaudKfQxfY+7Vdz7quVGEak+sBw2ervJIPHysNc
	 kiXOyP0iZltc5MbqMS6lLuNG3yMzN8EKk+PSPdKybeJpFh/pRTzy70KoB97QAj1Ue
	 sUy48OPrQ8h7MVCKYoTJBpE4p2C62IC0uytmjsnLdxYpXpj3Lq/WWAecUq1AAxS21
	 76SV7BDjxS9Zrz+gFIX9KAFiKDaX4rZXLnx/XCQfHrGWpzgB7L61apKhtT1vAZe/T
	 6W+FflOzpF5G+Ytmyw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.69] ([87.177.78.219]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N2E1G-1uYhdB2ecg-014rJW; Sun, 27
 Jul 2025 01:32:39 +0200
Message-ID: <5b061220-e04a-48b5-ba2c-92ccf240798e@gmx.de>
Date: Sun, 27 Jul 2025 01:32:36 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] platform/x86: (ayn-ec) Add PWM Fan HWMON Interface
To: "Derek J. Clark" <derekjohn.clark@gmail.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Hans de Goede <hansg@kernel.org>
Cc: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>,
 Alok Tiwari <alok.a.tiwari@oracle.com>,
 David Box <david.e.box@linux.intel.com>,
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org
References: <20250726204041.516440-1-derekjohn.clark@gmail.com>
 <20250726204041.516440-2-derekjohn.clark@gmail.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <20250726204041.516440-2-derekjohn.clark@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:DVIi7s15tJKDApKdqhMBWqDsUoF7k2SM0TPEuFQSm6UGf/FfEYS
 zZ+xiTc/ejpbEzS0imiTCDIZop+zz9UT+uKu0pzq3ASnWg2AlWnroVvxelYXCJbt9UKwliL
 P+wEMabmIfg+RksZnTWPFhIOyY0EeS1rRQEf9xuB1knX6JtlUG4TinSn1yvuKHJISHuQjVQ
 wBb6fRdWQyONJrOWTyg4w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ZcpF44kiKuY=;oUSrmiBIadY4mc6jfayMd5m6r0w
 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

Am 26.07.25 um 22:40 schrieb Derek J. Clark:

> Adds platform driver for AYN Loki and Tectoy Zeenix lines of handheld
> devices. This patch implements a hwmon interface for EC provided manual
> PWM fan control and user defined fan curves. A global ACPI lock is used
> when reading or writing from the EC.
>
> There are 4 fan modes implemented in this patch. Modes 0-3 act in
> accordance with the standard hwmon logic where 0 is 100% fan speed, 1 is
> manual control, and 2 is automatic control. As the EC only provides 3
> modes by default, mode 0 is implemented by setting the device to manual
> and then setting fan speed to 100% directly. In mode 1 the PWM duty cycl=
e
> is set in sysfs with values [0-255], which are then scaled to the EC max
> of 128. Mode 4 is an automatic mode where the fan curve is user defined.
> There are 5 total set points and each set point takes a temperature in
> Celsius [0-100] and a PWM duty cycle [0-255]. When the CPU temperature
> reaches a given set point, the corresponding duty cycle is automatically
> set by the EC.
>
> Signed-off-by: Derek J. Clark <derekjohn.clark@gmail.com>
>
> space

Interesting, do you have access to such a device? If yes then i would be v=
ery interested
in looking at the ACPI tables shipped with said device.

> ---
>   MAINTAINERS                   |   6 +
>   drivers/platform/x86/Kconfig  |  12 +
>   drivers/platform/x86/Makefile |   3 +
>   drivers/platform/x86/ayn-ec.c | 520 ++++++++++++++++++++++++++++++++++
>   4 files changed, 541 insertions(+)
>   create mode 100644 drivers/platform/x86/ayn-ec.c
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d61b004005fd..5b816883fe7d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4035,6 +4035,12 @@ W:	https://ez.analog.com/linux-software-drivers
>   F:	Documentation/devicetree/bindings/pwm/adi,axi-pwmgen.yaml
>   F:	drivers/pwm/pwm-axi-pwmgen.c
>  =20
> +AYN PLATFORM EC DRIVER
> +M:	Derek J. Clark <derekjohn.clark@gmail.com>
> +L:	platform-driver-x86@vger.kernel.org
> +S:	Maintained
> +F:	drivers/platform/x86/ayn-ec.c
> +
>   AZ6007 DVB DRIVER
>   M:	Mauro Carvalho Chehab <mchehab@kernel.org>
>   L:	linux-media@vger.kernel.org
> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
> index 6d238e120dce..4819bfcffb6b 100644
> --- a/drivers/platform/x86/Kconfig
> +++ b/drivers/platform/x86/Kconfig
> @@ -304,6 +304,18 @@ config ASUS_TF103C_DOCK
>   	  If you have an Asus TF103C tablet say Y or M here, for a generic x8=
6
>   	  distro config say M here.
>  =20
> +config AYN_EC
> +	tristate "AYN x86 devices EC platform control"
> +	depends on ACPI
> +	depends on HWMON
> +	help
> +	  This is a driver for AYN and Tectoy x86 handheld devices. It provide=
s
> +	  temperature monitoring, manual fan speed control, fan curve control,
> +	  and chassis RGB settings.
> +
> +	  If you have an x86 AYN or Tectoy handheld device say M here. The mod=
ule
> +	  will be called ayn-platform.
> +
>   config MERAKI_MX100
>   	tristate "Cisco Meraki MX100 Platform Driver"
>   	depends on GPIOLIB
> diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefi=
le
> index a0c5848513e3..d32504b89365 100644
> --- a/drivers/platform/x86/Makefile
> +++ b/drivers/platform/x86/Makefile
> @@ -38,6 +38,9 @@ obj-$(CONFIG_ASUS_TF103C_DOCK)	+=3D asus-tf103c-dock.o
>   obj-$(CONFIG_EEEPC_LAPTOP)	+=3D eeepc-laptop.o
>   obj-$(CONFIG_EEEPC_WMI)		+=3D eeepc-wmi.o
>  =20
> +# Ayn
> +obj-$(CONFIG_AYN_EC)	+=3D ayn-ec.o
> +
>   # Cisco/Meraki
>   obj-$(CONFIG_MERAKI_MX100)	+=3D meraki-mx100.o
>  =20
> diff --git a/drivers/platform/x86/ayn-ec.c b/drivers/platform/x86/ayn-ec=
.c
> new file mode 100644
> index 000000000000..8bd3ed1c69eb
> --- /dev/null
> +++ b/drivers/platform/x86/ayn-ec.c
> @@ -0,0 +1,520 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Platform driver for AYN x86 Handhelds.
> + *
> + * Implements multiple attributes provided by the EC. Fan reading and c=
ontrol,
> + * as well as temperature sensor readings are exposed via hwmon sysfs. =
EC RGB
> + * control is exposed via an led-class-multicolor interface.
> + *
> + * Fan control is provided via a pwm interface in the range [0-255]. AY=
N use
> + * [0-128] as the range in the EC, the written value is scaled to accom=
modate.
> + * The EC also provides a configurable fan curve with five set points t=
hat
> + * associate a temperature in Celcius [0-100] with a fan speed [0-128].=
 The
> + * auto_point fan speeds are also scaled from the range [0-255]. Temper=
ature
> + * readings are scaled from degrees to millidegrees when read.
> + *
> + * RGB control is provided using 4 registers. One each for the colors r=
ed,
> + * green, and blue are [0-255]. There is also a effect register that ta=
kes
> + * switches between an EC controlled breathing that cycles through all =
colors
> + * and fades in/out, and manual, which enables setting a user defined c=
olor.
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
> +/* Fan speed and PWM registers */
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
> +/* AYN EC PWM Fan modes */
> +#define AYN_PWM_FAN_MODE_MANUAL	0x00
> +#define AYN_PWM_FAN_MODE_AUTO		0x01
> +#define AYN_PWM_FAN_MODE_EC_CURVE	0x02
> +
> +/* hwmon fan modes */
> +#define HWMON_PWM_FAN_MODE_FULL	0x00
> +#define HWMON_PWM_FAN_MODE_MANUAL	0x01
> +#define HWMON_PWM_FAN_MODE_AUTO	0x02
> +#define HWMON_PWM_FAN_MODE_EC_CURVE	0x03
> +
> +/* Handle ACPI lock mechanism */
> +#define ACPI_LOCK_DELAY_MS 500
> +
> +int ayn_pwm_curve_registers[10] =3D {

Please declare this array as static const.

> +	AYN_SENSOR_PWM_FAN_SPEED_1_REG,
> +	AYN_SENSOR_PWM_FAN_SPEED_2_REG,
> +	AYN_SENSOR_PWM_FAN_SPEED_3_REG,
> +	AYN_SENSOR_PWM_FAN_SPEED_4_REG,
> +	AYN_SENSOR_PWM_FAN_SPEED_5_REG,
> +	AYN_SENSOR_PWM_FAN_TEMP_1_REG,
> +	AYN_SENSOR_PWM_FAN_TEMP_2_REG,
> +	AYN_SENSOR_PWM_FAN_TEMP_3_REG,
> +	AYN_SENSOR_PWM_FAN_TEMP_4_REG,
> +	AYN_SENSOR_PWM_FAN_TEMP_5_REG,
> +};
> +
> +struct ayn_device {
> +	u32 ayn_lock; /* ACPI EC Lock */
> +} drvdata;

Please declare drvdata as static.

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
> +	*val =3D 0;
> +	for (i =3D 0; i < size; i++) {
> +		ret =3D ec_read(reg + i, &buf);
> +		if (ret)
> +			return ret;
> +		*val <<=3D i * 8;
> +		*val +=3D buf;

Could it be that "i * 8" should have been just "8"?-

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
> +	ret =3D ec_write(reg, val);
> +
> +	if (!unlock_global_acpi_lock())
> +		return -EBUSY;
> +
> +	return ret;
> +}

Why not using regmap for that?

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
> +	ret =3D write_to_ec(AYN_SENSOR_PWM_FAN_ENABLE_REG, 0x00);
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
> + * ayn_pwm_ec_curve() - Enable manually setting the fan curve for autom=
atic
> + * EC control of the fan.
> + */
> +static int ayn_pwm_ec_curve(void)
> +{
> +	return write_to_ec(AYN_SENSOR_PWM_FAN_ENABLE_REG, 0x02);
> +}
> +
> +/**
> + * ayn_ec_hwmon_is_visible() - Determines RO or RW for hwmon attribute =
sysfs.
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
> +static int ayn_pwm_fan_read(struct device *dev, enum hwmon_sensor_types=
 type,
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
> +			ret =3D read_from_ec(AYN_SENSOR_PWM_FAN_ENABLE_REG, 1,
> +					   val);
> +			if (ret)
> +				return ret;
> +
> +			/* EC uses 0 for manual, 1 for automatic, 2 for user
> +			 * fan curve. Reflect hwmon usage instead.
> +			 */
> +			if (*val =3D=3D 1) {
> +				*val =3D 2;
> +				return 0;
> +			}
> +
> +			if (*val =3D=3D 2) {
> +				*val =3D 3;
> +				return 0;
> +			}
> +
> +			/* Return 0 when fan at max, otherwise 1 for manual. */
> +			ret =3D read_from_ec(AYN_SENSOR_PWM_FAN_SET_REG, 1, val);
> +			if (ret)
> +				return ret;

This might confuse userspace fan control software that might not expect th=
e value of pwm1_enable
to suddenly change when setting pwm1 to 255. Maybe it would be better to n=
ot support pwm mode 0 as the
underlying EC seems to not provide a separate fan mode for setting the fan=
 to full speed.

> +
> +			if (*val =3D=3D 128)
> +				*val =3D 0;
> +			else
> +				*val =3D 1;
> +
> +			return ret;
> +		case hwmon_pwm_input:
> +			ret =3D read_from_ec(AYN_SENSOR_PWM_FAN_SET_REG, 1, val);
> +			if (ret)
> +				return ret;
> +
> +			*val =3D *val << 1; /* Max value is 128, scale to 255 */
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
> +static int ayn_pwm_fan_write(struct device *dev, enum hwmon_sensor_type=
s type,
> +			     u32 attr, int channel, long val)
> +{
> +	if (type !=3D hwmon_pwm)
> +		return -EOPNOTSUPP;
> +	switch (attr) {
> +	case hwmon_pwm_enable:
> +		switch (val) {
> +		case HWMON_PWM_FAN_MODE_FULL:
> +			return ayn_pwm_full();
> +		case HWMON_PWM_FAN_MODE_MANUAL:
> +			return ayn_pwm_manual();
> +		case HWMON_PWM_FAN_MODE_AUTO:
> +			return ayn_pwm_auto();
> +		case HWMON_PWM_FAN_MODE_EC_CURVE:
> +			return ayn_pwm_ec_curve();
> +		default:
> +			return -EINVAL;
> +		}
> +	case hwmon_pwm_input:
> +		if (val < 0 || val > 255)
> +			return -EINVAL;
> +
> +		val =3D val >> 1; /* Max value is 128, scale from 255 */
> +
> +		return write_to_ec(AYN_SENSOR_PWM_FAN_SET_REG, val);
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +}
> +
> +static const struct hwmon_channel_info *ayn_ec_sensors[] =3D {
> +	HWMON_CHANNEL_INFO(fan, HWMON_F_INPUT),
> +	HWMON_CHANNEL_INFO(pwm, HWMON_PWM_INPUT | HWMON_PWM_ENABLE),
> +	NULL,
> +};
> +
> +static const struct hwmon_ops ayn_ec_hwmon_ops =3D {
> +	.is_visible =3D ayn_ec_hwmon_is_visible,
> +	.read =3D ayn_pwm_fan_read,
> +	.write =3D ayn_pwm_fan_write,
> +};
> +
> +static const struct hwmon_chip_info ayn_ec_chip_info =3D {
> +	.ops =3D &ayn_ec_hwmon_ops,
> +	.info =3D ayn_ec_sensors,
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
> +	int i =3D to_sensor_dev_attr(attr)->index;
> +	int ret, val;
> +	u8 reg;
> +
> +	ret =3D kstrtoint(buf, 0, &val);

Please use "10" for the second argument of kstrtoint() instead of "0".

> +	if (ret)
> +		return ret;
> +
> +	if (i < 5) {
> +		if (val < 0 || val > 255)
> +			return -EINVAL;
> +		val =3D val >> 1; /* Max EC value is 128, scale from 255 */
> +	} else
> +		if (val < 0 || val > 100)
> +			return -EINVAL;

Please keep in mind that temperature values are submitted in milidegrees c=
elsius, so you need
to perform some scaling here.

> +
> +	reg =3D ayn_pwm_curve_registers[i];
> +
> +	ret =3D write_to_ec(reg, val);
> +	if (ret)
> +		return ret;
> +
> +	return count;
> +}
> +
> +/**
> + * pwm_curve_show() - Read a fan curve speed or temperature value.
> + *
> + * @dev: The attribute's parent device.
> + * @attr: The attribute to read.
> + * @buf: Output buffer.
> + *
> + * Return: Number of bytes read, or an error.
> + */
> +static ssize_t pwm_curve_show(struct device *dev, struct device_attribu=
te *attr,
> +			      char *buf)
> +{
> +	int i =3D to_sensor_dev_attr(attr)->index;
> +	long val;
> +	int ret;
> +	u8 reg;
> +
> +	reg =3D ayn_pwm_curve_registers[i];
> +
> +	ret =3D read_from_ec(reg, 1, &val);
> +	if (ret)
> +		return ret;
> +
> +	if (i < 5)
> +		val =3D val << 1; /* Max EC value is 128, scale to 255 */

Please convert the temperature values to milidegrees celsius here.

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
> +static struct attribute *ayn_sensors_attrs[] =3D {
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
> +	struct device *dev =3D &pdev->dev;
> +	struct device *hwdev;
> +
> +	hwdev =3D devm_hwmon_device_register_with_info(dev, "aynec", NULL,
> +						     &ayn_ec_chip_info,
> +						     ayn_sensors_groups);
> +	return PTR_ERR_OR_ZERO(hwdev);
> +}
> +
> +static struct platform_driver ayn_ec_driver =3D {
> +	.driver =3D {
> +		.name =3D "ayn-ec",
> +	},
> +	.probe =3D ayn_ec_probe,
> +};

How do you restore the fan curve settings when resuming from suspend? I su=
ggest that you
convert this driver to use the regmap mechanism as doing so would also giv=
e you:

- caching of register values
- restoring cached register values during resume

You can the a look at the sch5627 driver on how to implement suspend using=
 regmap. You can also
take some inspirations from drivers/hwmon/sch56xx-common.c on how to imple=
ment your own regmap
backend.

> +
> +static struct platform_device *ayn_ec_device;
> +
> +static int __init ayn_ec_init(void)
> +{
> +	ayn_ec_device =3D platform_create_bundle(&ayn_ec_driver, ayn_ec_probe,
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
> +static const struct dmi_system_id ayn_dmi_table[] =3D {
> +	{
> +		.ident =3D "AYN Loki Max",
> +		.matches =3D {
> +			DMI_EXACT_MATCH(DMI_BOARD_VENDOR, "ayn"),
> +			DMI_EXACT_MATCH(DMI_BOARD_NAME, "Loki Max"),
> +		},
> +	},
> +	{
> +		.ident =3D "AYN Loki MiniPro",
> +		.matches =3D {
> +			DMI_EXACT_MATCH(DMI_BOARD_VENDOR, "ayn"),
> +			DMI_EXACT_MATCH(DMI_BOARD_NAME, "Loki MiniPro"),
> +		},
> +	},
> +	{
> +		.ident =3D "AYN Loki Zero",
> +		.matches =3D {
> +			DMI_EXACT_MATCH(DMI_BOARD_VENDOR, "ayn"),
> +			DMI_EXACT_MATCH(DMI_BOARD_NAME, "Loki Zero"),
> +		},
> +	},
> +	{
> +		.ident =3D "Tectoy Zeenix Lite",
> +		.matches =3D {
> +			DMI_EXACT_MATCH(DMI_BOARD_VENDOR, "Tectoy"),
> +			DMI_EXACT_MATCH(DMI_BOARD_NAME, "Zeenix Lite"),
> +		},
> +	},
> +	{},
> +};

Please declare the DMI table as being __initconst, as doing so will free s=
ome memory after the driver
has been loaded. Additionally please check this DMI table inside ayn_ec_in=
it() using dmi_first_match()
just in case someone configures this module as builtin.

Thanks,
Armin Wolf

> +
> +MODULE_DEVICE_TABLE(dmi, ayn_dmi_table);
> +
> +module_init(ayn_ec_init);
> +module_exit(ayn_ec_exit);
> +
> +MODULE_AUTHOR("Derek J. Clark <derekjohn.clark@gmail.com>");
> +MODULE_DESCRIPTION("Platform driver that handles EC sensors of AYN x86 =
devices");
> +MODULE_LICENSE("GPL");

