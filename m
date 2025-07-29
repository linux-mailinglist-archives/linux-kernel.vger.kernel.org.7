Return-Path: <linux-kernel+bounces-748875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 24CCAB1470F
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 06:10:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C83C1897451
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 04:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 017CD229B15;
	Tue, 29 Jul 2025 04:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="VgXO0uB8"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEE2678F5E;
	Tue, 29 Jul 2025 04:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753762225; cv=none; b=DjPvG3lMBVZTWDypek3kSSXBYVBchT5Ij3GTOQdUFGJ8RB/P1X8bsZWkDPN8S0PKuCd62YDF4+2hHH3LnYRIjR8M2/ebyV9rvsymRfBwm8khXg0LfYXOwAN0Dtyd+mSkftSPJkKwvfIvfXs6XwwGCEZW6skXiF32LBhO8Ykk0fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753762225; c=relaxed/simple;
	bh=PYscKghsNjZdPufHkqzvMjxJhvBK5RlHYRLL0XFCQ+4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mGHT8ImWNh1+q29Jd9/18hWG7pVPemn1yOACfiip8RweZVelfQNJDgFij1sPkFcq4PPHKKb9+iHepz8SEuCmqJmmnv4OOf3y+i4oxiwVt3mAe4Q40mjc0jLehtDBBzg4rn8ZAxQi3OXLB/tPySdVz4imfQwT0+SLhIP9iKRJY6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=VgXO0uB8; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1753762196; x=1754366996; i=w_armin@gmx.de;
	bh=jiAAPIqhqBH3ei7+LEJPI34WYEDASc70cyZuO5C0z5w=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=VgXO0uB8Livi5Vw7JxbLoUhnsJohike7X0oAapMsSPiNCzqSecKD9AWGJgdpuRBB
	 QJFd/HJq5tjjbRdbo/6DUKErBj7Z6x/AwrBr6nauHdD2pSzYG3rXAyQYAI3vTCtzm
	 WgtRahqaa2q0E8Lm00/MfcM+0fIaplkp4vKV8bmZ/1NbyAwzpflC+HpskbPUIPQYl
	 u5PUFk9IPy5DjdPK1CkCwRitY8bZtOvoqhmvQ6aYNJ8WXt91z1SrwN+3MbtnB2llC
	 B000YOdz+EfJtTk7fJTWqXU+V7AuijObtmdemFNXu+wpd7l5kbMuOzYo93rpHKJpK
	 sdxyXfsZd0Zp+0+UMA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.69] ([87.177.78.219]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MOiDd-1v2H8t1lmB-00SSs7; Tue, 29
 Jul 2025 06:09:56 +0200
Message-ID: <404b9bfd-66c7-4524-a7ec-34fa9eb046eb@gmx.de>
Date: Tue, 29 Jul 2025 06:09:53 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] platform/x86: (ayn-ec) Add PWM Fan HWMON Interface
To: Derek John Clark <derekjohn.clark@gmail.com>
Cc: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Hans de Goede <hansg@kernel.org>, Jean Delvare <jdelvare@suse.com>,
 Guenter Roeck <linux@roeck-us.net>, Alok Tiwari <alok.a.tiwari@oracle.com>,
 David Box <david.e.box@linux.intel.com>,
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org
References: <20250726204041.516440-1-derekjohn.clark@gmail.com>
 <20250726204041.516440-2-derekjohn.clark@gmail.com>
 <5b061220-e04a-48b5-ba2c-92ccf240798e@gmx.de>
 <CAFqHKTnkPLEbMk+NeLaSridSJBGU+P4P5PFF7VmiQbcfv7CAkg@mail.gmail.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <CAFqHKTnkPLEbMk+NeLaSridSJBGU+P4P5PFF7VmiQbcfv7CAkg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:YlA8f12kuMsiRgcyjU2EPiPQ1/V+hJJIuJ/6TUABSnfcYnuVjRc
 6NZazd+QVQP2Pv3jxOSLAT5jm2qk5WD3g0+aDf76IiQO0peg27dULv7j+8LtI5nisYZM6IK
 1pEE9kokd7k0HMBksoneiDIslSYvr78kLCKWT7pCbUkFkYZi6AAR4B69KIzPorTKOb1zQwV
 Aqg/AgShkOHloRpU7QNIw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:FL30TT1hLAM=;RGWIHaOF0O5KSq4h/6ds4zECz9/
 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
 cPhFn7HEpOdIzE=

Am 29.07.25 um 04:58 schrieb Derek John Clark:

> On Sat, Jul 26, 2025 at 4:32=E2=80=AFPM Armin Wolf <W_Armin@gmx.de> wrot=
e:
>> Am 26.07.25 um 22:40 schrieb Derek J. Clark:
>>
>>> Adds platform driver for AYN Loki and Tectoy Zeenix lines of handheld
>>> devices. This patch implements a hwmon interface for EC provided manua=
l
>>> PWM fan control and user defined fan curves. A global ACPI lock is use=
d
>>> when reading or writing from the EC.
>>>
>>> There are 4 fan modes implemented in this patch. Modes 0-3 act in
>>> accordance with the standard hwmon logic where 0 is 100% fan speed, 1 =
is
>>> manual control, and 2 is automatic control. As the EC only provides 3
>>> modes by default, mode 0 is implemented by setting the device to manua=
l
>>> and then setting fan speed to 100% directly. In mode 1 the PWM duty cy=
cle
>>> is set in sysfs with values [0-255], which are then scaled to the EC m=
ax
>>> of 128. Mode 4 is an automatic mode where the fan curve is user define=
d.
>>> There are 5 total set points and each set point takes a temperature in
>>> Celsius [0-100] and a PWM duty cycle [0-255]. When the CPU temperature
>>> reaches a given set point, the corresponding duty cycle is automatical=
ly
>>> set by the EC.
>>>
>>> Signed-off-by: Derek J. Clark <derekjohn.clark@gmail.com>
>>>
>>> space
>> Interesting, do you have access to such a device? If yes then i would b=
e very interested
>> in looking at the ACPI tables shipped with said device.
> Hi Armin,
>
> I have a Loki Max, and know someone with a Loki Zero. Do you want
> plain text acpidump or a decoded DSDT.dat attached?

I would prefer the plain text acpidump, as the SSDT tables often contain i=
mportant data.

>>> ---
>>>    MAINTAINERS                   |   6 +
>>>    drivers/platform/x86/Kconfig  |  12 +
>>>    drivers/platform/x86/Makefile |   3 +
>>>    drivers/platform/x86/ayn-ec.c | 520 +++++++++++++++++++++++++++++++=
+++
>>>    4 files changed, 541 insertions(+)
>>>    create mode 100644 drivers/platform/x86/ayn-ec.c
>>>
>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>> index d61b004005fd..5b816883fe7d 100644
>>> --- a/MAINTAINERS
>>> +++ b/MAINTAINERS
>>> @@ -4035,6 +4035,12 @@ W:     https://ez.analog.com/linux-software-dri=
vers
>>>    F:  Documentation/devicetree/bindings/pwm/adi,axi-pwmgen.yaml
>>>    F:  drivers/pwm/pwm-axi-pwmgen.c
>>>
>>> +AYN PLATFORM EC DRIVER
>>> +M:   Derek J. Clark <derekjohn.clark@gmail.com>
>>> +L:   platform-driver-x86@vger.kernel.org
>>> +S:   Maintained
>>> +F:   drivers/platform/x86/ayn-ec.c
>>> +
>>>    AZ6007 DVB DRIVER
>>>    M:  Mauro Carvalho Chehab <mchehab@kernel.org>
>>>    L:  linux-media@vger.kernel.org
>>> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconf=
ig
>>> index 6d238e120dce..4819bfcffb6b 100644
>>> --- a/drivers/platform/x86/Kconfig
>>> +++ b/drivers/platform/x86/Kconfig
>>> @@ -304,6 +304,18 @@ config ASUS_TF103C_DOCK
>>>          If you have an Asus TF103C tablet say Y or M here, for a gene=
ric x86
>>>          distro config say M here.
>>>
>>> +config AYN_EC
>>> +     tristate "AYN x86 devices EC platform control"
>>> +     depends on ACPI
>>> +     depends on HWMON
>>> +     help
>>> +       This is a driver for AYN and Tectoy x86 handheld devices. It p=
rovides
>>> +       temperature monitoring, manual fan speed control, fan curve co=
ntrol,
>>> +       and chassis RGB settings.
>>> +
>>> +       If you have an x86 AYN or Tectoy handheld device say M here. T=
he module
>>> +       will be called ayn-platform.
>>> +
>>>    config MERAKI_MX100
>>>        tristate "Cisco Meraki MX100 Platform Driver"
>>>        depends on GPIOLIB
>>> diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Make=
file
>>> index a0c5848513e3..d32504b89365 100644
>>> --- a/drivers/platform/x86/Makefile
>>> +++ b/drivers/platform/x86/Makefile
>>> @@ -38,6 +38,9 @@ obj-$(CONFIG_ASUS_TF103C_DOCK)      +=3D asus-tf103c=
-dock.o
>>>    obj-$(CONFIG_EEEPC_LAPTOP)  +=3D eeepc-laptop.o
>>>    obj-$(CONFIG_EEEPC_WMI)             +=3D eeepc-wmi.o
>>>
>>> +# Ayn
>>> +obj-$(CONFIG_AYN_EC) +=3D ayn-ec.o
>>> +
>>>    # Cisco/Meraki
>>>    obj-$(CONFIG_MERAKI_MX100)  +=3D meraki-mx100.o
>>>
>>> diff --git a/drivers/platform/x86/ayn-ec.c b/drivers/platform/x86/ayn-=
ec.c
>>> new file mode 100644
>>> index 000000000000..8bd3ed1c69eb
>>> --- /dev/null
>>> +++ b/drivers/platform/x86/ayn-ec.c
>>> @@ -0,0 +1,520 @@
>>> +// SPDX-License-Identifier: GPL-2.0-or-later
>>> +/*
>>> + * Platform driver for AYN x86 Handhelds.
>>> + *
>>> + * Implements multiple attributes provided by the EC. Fan reading and=
 control,
>>> + * as well as temperature sensor readings are exposed via hwmon sysfs=
. EC RGB
>>> + * control is exposed via an led-class-multicolor interface.
>>> + *
>>> + * Fan control is provided via a pwm interface in the range [0-255]. =
AYN use
>>> + * [0-128] as the range in the EC, the written value is scaled to acc=
ommodate.
>>> + * The EC also provides a configurable fan curve with five set points=
 that
>>> + * associate a temperature in Celcius [0-100] with a fan speed [0-128=
]. The
>>> + * auto_point fan speeds are also scaled from the range [0-255]. Temp=
erature
>>> + * readings are scaled from degrees to millidegrees when read.
>>> + *
>>> + * RGB control is provided using 4 registers. One each for the colors=
 red,
>>> + * green, and blue are [0-255]. There is also a effect register that =
takes
>>> + * switches between an EC controlled breathing that cycles through al=
l colors
>>> + * and fades in/out, and manual, which enables setting a user defined=
 color.
>>> + *
>>> + * Copyright (C) 2025 Derek J. Clark <derekjohn.clark@gmail.com>
>>> + */
>>> +
>>> +#include <linux/acpi.h>
>>> +#include <linux/device.h>
>>> +#include <linux/dmi.h>
>>> +#include <linux/hwmon-sysfs.h>
>>> +#include <linux/hwmon.h>
>>> +#include <linux/init.h>
>>> +#include <linux/kernel.h>
>>> +#include <linux/module.h>
>>> +#include <linux/platform_device.h>
>>> +#include <linux/sysfs.h>
>>> +#include <linux/types.h>
>>> +
>>> +/* Fan speed and PWM registers */
>>> +#define AYN_SENSOR_PWM_FAN_ENABLE_REG        0x10 /* PWM operating mo=
de */
>>> +#define AYN_SENSOR_PWM_FAN_SET_REG   0x11 /* PWM duty cycle */
>>> +#define AYN_SENSOR_PWM_FAN_SPEED_REG 0x20 /* Fan speed */
>>> +
>>> +/* EC controlled fan curve registers */
>>> +#define AYN_SENSOR_PWM_FAN_SPEED_1_REG       0x12
>>> +#define AYN_SENSOR_PWM_FAN_SPEED_2_REG       0x14
>>> +#define AYN_SENSOR_PWM_FAN_SPEED_3_REG       0x16
>>> +#define AYN_SENSOR_PWM_FAN_SPEED_4_REG       0x18
>>> +#define AYN_SENSOR_PWM_FAN_SPEED_5_REG       0x1A
>>> +#define AYN_SENSOR_PWM_FAN_TEMP_1_REG        0x13
>>> +#define AYN_SENSOR_PWM_FAN_TEMP_2_REG        0x15
>>> +#define AYN_SENSOR_PWM_FAN_TEMP_3_REG        0x17
>>> +#define AYN_SENSOR_PWM_FAN_TEMP_4_REG        0x19
>>> +#define AYN_SENSOR_PWM_FAN_TEMP_5_REG        0x1B
>>> +
>>> +/* AYN EC PWM Fan modes */
>>> +#define AYN_PWM_FAN_MODE_MANUAL      0x00
>>> +#define AYN_PWM_FAN_MODE_AUTO                0x01
>>> +#define AYN_PWM_FAN_MODE_EC_CURVE    0x02
>>> +
>>> +/* hwmon fan modes */
>>> +#define HWMON_PWM_FAN_MODE_FULL      0x00
>>> +#define HWMON_PWM_FAN_MODE_MANUAL    0x01
>>> +#define HWMON_PWM_FAN_MODE_AUTO      0x02
>>> +#define HWMON_PWM_FAN_MODE_EC_CURVE  0x03
>>> +
>>> +/* Handle ACPI lock mechanism */
>>> +#define ACPI_LOCK_DELAY_MS 500
>>> +
>>> +int ayn_pwm_curve_registers[10] =3D {
>> Please declare this array as static const.
>>
>>> +     AYN_SENSOR_PWM_FAN_SPEED_1_REG,
>>> +     AYN_SENSOR_PWM_FAN_SPEED_2_REG,
>>> +     AYN_SENSOR_PWM_FAN_SPEED_3_REG,
>>> +     AYN_SENSOR_PWM_FAN_SPEED_4_REG,
>>> +     AYN_SENSOR_PWM_FAN_SPEED_5_REG,
>>> +     AYN_SENSOR_PWM_FAN_TEMP_1_REG,
>>> +     AYN_SENSOR_PWM_FAN_TEMP_2_REG,
>>> +     AYN_SENSOR_PWM_FAN_TEMP_3_REG,
>>> +     AYN_SENSOR_PWM_FAN_TEMP_4_REG,
>>> +     AYN_SENSOR_PWM_FAN_TEMP_5_REG,
>>> +};
>>> +
>>> +struct ayn_device {
>>> +     u32 ayn_lock; /* ACPI EC Lock */
>>> +} drvdata;
>> Please declare drvdata as static.
>>
>>> +
>>> +/* Handle ACPI lock mechanism */
>>> +#define ACPI_LOCK_DELAY_MS 500
>>> +
>>> +static bool lock_global_acpi_lock(void)
>>> +{
>>> +     return ACPI_SUCCESS(acpi_acquire_global_lock(ACPI_LOCK_DELAY_MS,
>>> +                                                  &drvdata.ayn_lock))=
;
>>> +}
>>> +
>>> +static bool unlock_global_acpi_lock(void)
>>> +{
>>> +     return ACPI_SUCCESS(acpi_release_global_lock(drvdata.ayn_lock));
>>> +}
>>> +
>>> +/**
>>> + * read_from_ec() - Reads a value from the embedded controller.
>>> + *
>>> + * @reg: The register to start the read from.
>>> + * @size: The number of sequential registers the data is contained in=
.
>>> + * @val: Pointer to return the data with.
>>> + *
>>> + * Return: 0, or an error.
>>> + */
>>> +static int read_from_ec(u8 reg, int size, long *val)
>>> +{
>>> +     int ret, i;
>>> +     u8 buf;
>>> +
>>> +     if (!lock_global_acpi_lock())
>>> +             return -EBUSY;
>>> +
>>> +     *val =3D 0;
>>> +     for (i =3D 0; i < size; i++) {
>>> +             ret =3D ec_read(reg + i, &buf);
>>> +             if (ret)
>>> +                     return ret;
>>> +             *val <<=3D i * 8;
>>> +             *val +=3D buf;
>> Could it be that "i * 8" should have been just "8"?-
> Seems to work as is. This should bitshift the stored value by 0 (none)
> for the first register (MSB) and 8 for the second register (LSB). Not
> sure how well it would work for 3 or more registers but everything is
> either 1 or 2.

The thing is that this limitation is not documented anywhere. People might=
 assume that
that this function can read more than 2 registers when they extend the dri=
ver in the future.

I suggest that you either:

1. Fix or at least document this limitation.

2. Use regmap and regmap_read_bulk() instead.

>>> +     }
>>> +
>>> +     if (!unlock_global_acpi_lock())
>>> +             return -EBUSY;
>>> +
>>> +     return 0;
>>> +}
>>> +
>>> +/**
>>> + * write_to_ec() - Writes a value to the embedded controller.
>>> + *
>>> + * @reg: The register to write to.
>>> + * @val: Value to write
>>> + *
>>> + * Return: 0, or an error.
>>> + */
>>> +static int write_to_ec(u8 reg, u8 val)
>>> +{
>>> +     int ret;
>>> +
>>> +     if (!lock_global_acpi_lock())
>>> +             return -EBUSY;
>>> +
>>> +     pr_info("Writing EC value %d to register %u\n", val, reg);
>>> +     ret =3D ec_write(reg, val);
>>> +
>>> +     if (!unlock_global_acpi_lock())
>>> +             return -EBUSY;
>>> +
>>> +     return ret;
>>> +}
>> Why not using regmap for that?
>>
>>> +/**
>>> + * ayn_pwm_manual() - Enable manual control of the fan.
>>> + */
>>> +static int ayn_pwm_manual(void)
>>> +{
>>> +     return write_to_ec(AYN_SENSOR_PWM_FAN_ENABLE_REG, 0x00);
>>> +}
>>> +
>>> +/**
>>> + * ayn_pwm_full() - Set fan to 100% speed.
>>> + */
>>> +static int ayn_pwm_full(void)
>>> +{
>>> +     int ret;
>>> +
>>> +     ret =3D write_to_ec(AYN_SENSOR_PWM_FAN_ENABLE_REG, 0x00);
>>> +     if (ret)
>>> +             return ret;
>>> +
>>> +     return write_to_ec(AYN_SENSOR_PWM_FAN_SET_REG, 128);
>>> +}
>>> +
>>> +/**
>>> + * ayn_pwm_auto() - Enable automatic EC control of the fan.
>>> + */
>>> +static int ayn_pwm_auto(void)
>>> +{
>>> +     return write_to_ec(AYN_SENSOR_PWM_FAN_ENABLE_REG, 0x01);
>>> +}
>>> +
>>> +/**
>>> + * ayn_pwm_ec_curve() - Enable manually setting the fan curve for aut=
omatic
>>> + * EC control of the fan.
>>> + */
>>> +static int ayn_pwm_ec_curve(void)
>>> +{
>>> +     return write_to_ec(AYN_SENSOR_PWM_FAN_ENABLE_REG, 0x02);
>>> +}
>>> +
>>> +/**
>>> + * ayn_ec_hwmon_is_visible() - Determines RO or RW for hwmon attribut=
e sysfs.
>>> + *
>>> + * @drvdata: Unused void pointer to context data.
>>> + * @type: The hwmon_sensor_types type.
>>> + * @attr: The attribute to set RO/RW on.
>>> + * @channel: HWMON subsystem usage flags for the attribute.
>>> + *
>>> + * Return: Permission level.
>>> + */
>>> +static umode_t ayn_ec_hwmon_is_visible(const void *drvdata,
>>> +                                    enum hwmon_sensor_types type, u32=
 attr,
>>> +                                    int channel)
>>> +{
>>> +     switch (type) {
>>> +     case hwmon_fan:
>>> +             return 0444;
>>> +     case hwmon_pwm:
>>> +             return 0644;
>>> +     default:
>>> +             return 0;
>>> +     }
>>> +}
>>> +
>>> +/**
>>> + * ayn_pwm_fan_read() - Read from a hwmon pwm or fan attribute.
>>> + *
>>> + * @dev: parent device of the given attribute.
>>> + * @type: The hwmon_sensor_types type.
>>> + * @attr: The attribute to read from.
>>> + * @channel: HWMON subsystem usage flags for the attribute.
>>> + * @val: Pointer to return the read value from.
>>> + *
>>> + * Return: 0, or an error.
>>> + */
>>> +static int ayn_pwm_fan_read(struct device *dev, enum hwmon_sensor_typ=
es type,
>>> +                         u32 attr, int channel, long *val)
>>> +{
>>> +     int ret;
>>> +
>>> +     switch (type) {
>>> +     case hwmon_fan:
>>> +             switch (attr) {
>>> +             case hwmon_fan_input:
>>> +                     return read_from_ec(AYN_SENSOR_PWM_FAN_SPEED_REG=
, 2,
>>> +                                         val);
>>> +             default:
>>> +                     break;
>>> +             }
>>> +             break;
>>> +     case hwmon_pwm:
>>> +             switch (attr) {
>>> +             case hwmon_pwm_enable:
>>> +                     ret =3D read_from_ec(AYN_SENSOR_PWM_FAN_ENABLE_R=
EG, 1,
>>> +                                        val);
>>> +                     if (ret)
>>> +                             return ret;
>>> +
>>> +                     /* EC uses 0 for manual, 1 for automatic, 2 for =
user
>>> +                      * fan curve. Reflect hwmon usage instead.
>>> +                      */
>>> +                     if (*val =3D=3D 1) {
>>> +                             *val =3D 2;
>>> +                             return 0;
>>> +                     }
>>> +
>>> +                     if (*val =3D=3D 2) {
>>> +                             *val =3D 3;
>>> +                             return 0;
>>> +                     }
>>> +
>>> +                     /* Return 0 when fan at max, otherwise 1 for man=
ual. */
>>> +                     ret =3D read_from_ec(AYN_SENSOR_PWM_FAN_SET_REG,=
 1, val);
>>> +                     if (ret)
>>> +                             return ret;
>> This might confuse userspace fan control software that might not expect=
 the value of pwm1_enable
>> to suddenly change when setting pwm1 to 255. Maybe it would be better t=
o not support pwm mode 0 as the
>> underlying EC seems to not provide a separate fan mode for setting the =
fan to full speed.
>>
> I have no strong feelings either way. We did this for the oxp-ec
> driver so I was just looking to be consistent.

Maybe Guenter Roeck can give us some guidance here?

Thanks,
Armin Wolf

>>> +
>>> +                     if (*val =3D=3D 128)
>>> +                             *val =3D 0;
>>> +                     else
>>> +                             *val =3D 1;
>>> +
>>> +                     return ret;
>>> +             case hwmon_pwm_input:
>>> +                     ret =3D read_from_ec(AYN_SENSOR_PWM_FAN_SET_REG,=
 1, val);
>>> +                     if (ret)
>>> +                             return ret;
>>> +
>>> +                     *val =3D *val << 1; /* Max value is 128, scale t=
o 255 */
>>> +
>>> +                     return 0;
>>> +             default:
>>> +                     break;
>>> +             }
>>> +             break;
>>> +     default:
>>> +             break;
>>> +     }
>>> +     return -EOPNOTSUPP;
>>> +}
>>> +
>>> +/**
>>> + * ayn_pwm_fan_write() - Write to a hwmon pwm attribute.
>>> + *
>>> + * @dev: parent device of the given attribute.
>>> + * @type: The hwmon_sensor_types type.
>>> + * @attr: The attribute to write to.
>>> + * @channel: HWMON subsystem usage flags for the attribute.
>>> + * @val: Value to write.
>>> + *
>>> + * Return: 0, or an error.
>>> + */
>>> +static int ayn_pwm_fan_write(struct device *dev, enum hwmon_sensor_ty=
pes type,
>>> +                          u32 attr, int channel, long val)
>>> +{
>>> +     if (type !=3D hwmon_pwm)
>>> +             return -EOPNOTSUPP;
>>> +     switch (attr) {
>>> +     case hwmon_pwm_enable:
>>> +             switch (val) {
>>> +             case HWMON_PWM_FAN_MODE_FULL:
>>> +                     return ayn_pwm_full();
>>> +             case HWMON_PWM_FAN_MODE_MANUAL:
>>> +                     return ayn_pwm_manual();
>>> +             case HWMON_PWM_FAN_MODE_AUTO:
>>> +                     return ayn_pwm_auto();
>>> +             case HWMON_PWM_FAN_MODE_EC_CURVE:
>>> +                     return ayn_pwm_ec_curve();
>>> +             default:
>>> +                     return -EINVAL;
>>> +             }
>>> +     case hwmon_pwm_input:
>>> +             if (val < 0 || val > 255)
>>> +                     return -EINVAL;
>>> +
>>> +             val =3D val >> 1; /* Max value is 128, scale from 255 */
>>> +
>>> +             return write_to_ec(AYN_SENSOR_PWM_FAN_SET_REG, val);
>>> +     default:
>>> +             return -EOPNOTSUPP;
>>> +     }
>>> +}
>>> +
>>> +static const struct hwmon_channel_info *ayn_ec_sensors[] =3D {
>>> +     HWMON_CHANNEL_INFO(fan, HWMON_F_INPUT),
>>> +     HWMON_CHANNEL_INFO(pwm, HWMON_PWM_INPUT | HWMON_PWM_ENABLE),
>>> +     NULL,
>>> +};
>>> +
>>> +static const struct hwmon_ops ayn_ec_hwmon_ops =3D {
>>> +     .is_visible =3D ayn_ec_hwmon_is_visible,
>>> +     .read =3D ayn_pwm_fan_read,
>>> +     .write =3D ayn_pwm_fan_write,
>>> +};
>>> +
>>> +static const struct hwmon_chip_info ayn_ec_chip_info =3D {
>>> +     .ops =3D &ayn_ec_hwmon_ops,
>>> +     .info =3D ayn_ec_sensors,
>>> +};
>>> +
>>> +/**
>>> + * pwm_curve_store() - Write a fan curve speed or temperature value.
>>> + *
>>> + * @dev: The attribute's parent device.
>>> + * @attr: The attribute to read.
>>> + * @buf: Input value string from sysfs write.
>>> + *
>>> + * Return: Number of bytes read, or an error.
>>> + */
>>> +static ssize_t pwm_curve_store(struct device *dev,
>>> +                            struct device_attribute *attr, const char=
 *buf,
>>> +                            size_t count)
>>> +{
>>> +     int i =3D to_sensor_dev_attr(attr)->index;
>>> +     int ret, val;
>>> +     u8 reg;
>>> +
>>> +     ret =3D kstrtoint(buf, 0, &val);
>> Please use "10" for the second argument of kstrtoint() instead of "0".
>>
>>> +     if (ret)
>>> +             return ret;
>>> +
>>> +     if (i < 5) {
>>> +             if (val < 0 || val > 255)
>>> +                     return -EINVAL;
>>> +             val =3D val >> 1; /* Max EC value is 128, scale from 255=
 */
>>> +     } else
>>> +             if (val < 0 || val > 100)
>>> +                     return -EINVAL;
>> Please keep in mind that temperature values are submitted in milidegree=
s celsius, so you need
>> to perform some scaling here.
>>
> Small oversight, thanks for pointing that out.
>
>>> +
>>> +     reg =3D ayn_pwm_curve_registers[i];
>>> +
>>> +     ret =3D write_to_ec(reg, val);
>>> +     if (ret)
>>> +             return ret;
>>> +
>>> +     return count;
>>> +}
>>> +
>>> +/**
>>> + * pwm_curve_show() - Read a fan curve speed or temperature value.
>>> + *
>>> + * @dev: The attribute's parent device.
>>> + * @attr: The attribute to read.
>>> + * @buf: Output buffer.
>>> + *
>>> + * Return: Number of bytes read, or an error.
>>> + */
>>> +static ssize_t pwm_curve_show(struct device *dev, struct device_attri=
bute *attr,
>>> +                           char *buf)
>>> +{
>>> +     int i =3D to_sensor_dev_attr(attr)->index;
>>> +     long val;
>>> +     int ret;
>>> +     u8 reg;
>>> +
>>> +     reg =3D ayn_pwm_curve_registers[i];
>>> +
>>> +     ret =3D read_from_ec(reg, 1, &val);
>>> +     if (ret)
>>> +             return ret;
>>> +
>>> +     if (i < 5)
>>> +             val =3D val << 1; /* Max EC value is 128, scale to 255 *=
/
>> Please convert the temperature values to milidegrees celsius here.
>>
>>> +
>>> +     return sysfs_emit(buf, "%ld\n", val);
>>> +}
>>> +
>>> +/* Fan curve attributes */
>>> +static SENSOR_DEVICE_ATTR_RW(pwm1_auto_point1_pwm, pwm_curve, 0);
>>> +static SENSOR_DEVICE_ATTR_RW(pwm1_auto_point2_pwm, pwm_curve, 1);
>>> +static SENSOR_DEVICE_ATTR_RW(pwm1_auto_point3_pwm, pwm_curve, 2);
>>> +static SENSOR_DEVICE_ATTR_RW(pwm1_auto_point4_pwm, pwm_curve, 3);
>>> +static SENSOR_DEVICE_ATTR_RW(pwm1_auto_point5_pwm, pwm_curve, 4);
>>> +static SENSOR_DEVICE_ATTR_RW(pwm1_auto_point1_temp, pwm_curve, 5);
>>> +static SENSOR_DEVICE_ATTR_RW(pwm1_auto_point2_temp, pwm_curve, 6);
>>> +static SENSOR_DEVICE_ATTR_RW(pwm1_auto_point3_temp, pwm_curve, 7);
>>> +static SENSOR_DEVICE_ATTR_RW(pwm1_auto_point4_temp, pwm_curve, 8);
>>> +static SENSOR_DEVICE_ATTR_RW(pwm1_auto_point5_temp, pwm_curve, 9);
>>> +
>>> +static struct attribute *ayn_sensors_attrs[] =3D {
>>> +     &sensor_dev_attr_pwm1_auto_point1_pwm.dev_attr.attr,
>>> +     &sensor_dev_attr_pwm1_auto_point1_temp.dev_attr.attr,
>>> +     &sensor_dev_attr_pwm1_auto_point2_pwm.dev_attr.attr,
>>> +     &sensor_dev_attr_pwm1_auto_point2_temp.dev_attr.attr,
>>> +     &sensor_dev_attr_pwm1_auto_point3_pwm.dev_attr.attr,
>>> +     &sensor_dev_attr_pwm1_auto_point3_temp.dev_attr.attr,
>>> +     &sensor_dev_attr_pwm1_auto_point4_pwm.dev_attr.attr,
>>> +     &sensor_dev_attr_pwm1_auto_point4_temp.dev_attr.attr,
>>> +     &sensor_dev_attr_pwm1_auto_point5_pwm.dev_attr.attr,
>>> +     &sensor_dev_attr_pwm1_auto_point5_temp.dev_attr.attr,
>>> +     NULL,
>>> +};
>>> +
>>> +ATTRIBUTE_GROUPS(ayn_sensors);
>>> +
>>> +static int ayn_ec_probe(struct platform_device *pdev)
>>> +{
>>> +     struct device *dev =3D &pdev->dev;
>>> +     struct device *hwdev;
>>> +
>>> +     hwdev =3D devm_hwmon_device_register_with_info(dev, "aynec", NUL=
L,
>>> +                                                  &ayn_ec_chip_info,
>>> +                                                  ayn_sensors_groups)=
;
>>> +     return PTR_ERR_OR_ZERO(hwdev);
>>> +}
>>> +
>>> +static struct platform_driver ayn_ec_driver =3D {
>>> +     .driver =3D {
>>> +             .name =3D "ayn-ec",
>>> +     },
>>> +     .probe =3D ayn_ec_probe,
>>> +};
>> How do you restore the fan curve settings when resuming from suspend? I=
 suggest that you
>> convert this driver to use the regmap mechanism as doing so would also =
give you:
>>
>> - caching of register values
>> - restoring cached register values during resume
>>
>> You can the a look at the sch5627 driver on how to implement suspend us=
ing regmap. You can also
>> take some inspirations from drivers/hwmon/sch56xx-common.c on how to im=
plement your own regmap
>> backend.
> Okay, I'll take a look at it.
>
>>> +
>>> +static struct platform_device *ayn_ec_device;
>>> +
>>> +static int __init ayn_ec_init(void)
>>> +{
>>> +     ayn_ec_device =3D platform_create_bundle(&ayn_ec_driver, ayn_ec_=
probe,
>>> +                                            NULL, 0, NULL, 0);
>>> +
>>> +     return PTR_ERR_OR_ZERO(ayn_ec_device);
>>> +}
>>> +
>>> +static void __exit ayn_ec_exit(void)
>>> +{
>>> +     platform_device_unregister(ayn_ec_device);
>>> +     platform_driver_unregister(&ayn_ec_driver);
>>> +}
>>> +
>>> +static const struct dmi_system_id ayn_dmi_table[] =3D {
>>> +     {
>>> +             .ident =3D "AYN Loki Max",
>>> +             .matches =3D {
>>> +                     DMI_EXACT_MATCH(DMI_BOARD_VENDOR, "ayn"),
>>> +                     DMI_EXACT_MATCH(DMI_BOARD_NAME, "Loki Max"),
>>> +             },
>>> +     },
>>> +     {
>>> +             .ident =3D "AYN Loki MiniPro",
>>> +             .matches =3D {
>>> +                     DMI_EXACT_MATCH(DMI_BOARD_VENDOR, "ayn"),
>>> +                     DMI_EXACT_MATCH(DMI_BOARD_NAME, "Loki MiniPro"),
>>> +             },
>>> +     },
>>> +     {
>>> +             .ident =3D "AYN Loki Zero",
>>> +             .matches =3D {
>>> +                     DMI_EXACT_MATCH(DMI_BOARD_VENDOR, "ayn"),
>>> +                     DMI_EXACT_MATCH(DMI_BOARD_NAME, "Loki Zero"),
>>> +             },
>>> +     },
>>> +     {
>>> +             .ident =3D "Tectoy Zeenix Lite",
>>> +             .matches =3D {
>>> +                     DMI_EXACT_MATCH(DMI_BOARD_VENDOR, "Tectoy"),
>>> +                     DMI_EXACT_MATCH(DMI_BOARD_NAME, "Zeenix Lite"),
>>> +             },
>>> +     },
>>> +     {},
>>> +};
>> Please declare the DMI table as being __initconst, as doing so will fre=
e some memory after the driver
>> has been loaded. Additionally please check this DMI table inside ayn_ec=
_init() using dmi_first_match()
>> just in case someone configures this module as builtin.
> Makes sense.
>
> Thanks,
> Derek
>
>> Thanks,
>> Armin Wolf
>>
>>> +
>>> +MODULE_DEVICE_TABLE(dmi, ayn_dmi_table);
>>> +
>>> +module_init(ayn_ec_init);
>>> +module_exit(ayn_ec_exit);
>>> +
>>> +MODULE_AUTHOR("Derek J. Clark <derekjohn.clark@gmail.com>");
>>> +MODULE_DESCRIPTION("Platform driver that handles EC sensors of AYN x8=
6 devices");
>>> +MODULE_LICENSE("GPL");

