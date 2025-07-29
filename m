Return-Path: <linux-kernel+bounces-748836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4476B14686
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 04:58:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1593189F39B
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 02:59:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C79220551C;
	Tue, 29 Jul 2025 02:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kBH8zWw/"
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27F9D515;
	Tue, 29 Jul 2025 02:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753757916; cv=none; b=XG9j+vJihG+ZF3eR2jr2fknQ4cFZA+qvq9k4gfp5AMK1fysLi2CaESRVTop0aBSwZ3pOQC0p5XgRnYzEy3ZHpwztpuTK2Uh3FmAm+gPxki9PhfDhj+ZQWpDi34j/rVaCvGj6t1wHMtQLZxvJqoH0bPXCceFC6oh73hW8hze8FEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753757916; c=relaxed/simple;
	bh=mvoWDq26XJYwZnIeURZE0dClTRC4VFMiPr61gjtMIUI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WviiJWrL0pBvTWBzS2gEKHS7/xrdg2pnnlZBgLQR4oyfeviIn3BGoaCRVublS7raoTChDbjhvr0qUCmRcmAohkXVPpnHOO4Y0EzqbfI+l4lF7q92bhig6eIqQwlZew3WMDqwdOCkEVDIY49PKR70Z3ojDxEHdMxJKOWqXk4rXSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kBH8zWw/; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-7074bad0523so12579446d6.3;
        Mon, 28 Jul 2025 19:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753757913; x=1754362713; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fPTBR6u6J1a3cpQ7B04cCruPrxwnkBg9T6DyZd7Qtzk=;
        b=kBH8zWw/8S8dyRPJrZuMChzcJ2TZvClmTf9lCWJleDlrRULP9v9hUGls62lPkfzupc
         UZCjk5k/jK+0U+1KKVUmaR797nFqHRyeT3UMKziYrbMQHTTneLszIP9MF2DmGBVQNVL8
         P38aEMk9HFY437p2WZj3BbSusNs+yXtwrg58StKT66cFDrjcfI+XvcchWBfi0eLDtWs2
         cNc2GC54TQs02LFDevdbB2iRCPh8G5rGJaxpX3rCkf6x/cd2wLwJ7N0mChV66bEdL4W2
         ELA/malJsEgzU9L+Yo3cPsFrLP8HgtY0Bh+yx0jsGJcMw4MkyAjsui42U0A4n9iQWMQC
         gN3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753757913; x=1754362713;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fPTBR6u6J1a3cpQ7B04cCruPrxwnkBg9T6DyZd7Qtzk=;
        b=XDOl3YCMoEcoKDzZ6VU1bbBXdJxq6lntE3vuXjX6ZKoejxynMprfEIMCAU8RNIFZDd
         DlYXUCdfgdm7+q/Ox4W9cyJ1EgGMURQWi5iRr/bjduE0P6gW1IlpPOBxyNZYdOHU/+/V
         xdo+LnqyHbaNzSQ8AoMSbmE5J8mg+09FiJa2s9HjFBB/xqAhWn6h2R0fNKFieJGY/OPm
         r0Ho2ekXvpjwYjzuRogz/MfVQMXcLCUuoKWIasxgBeGxrQa6LuYzEjT3KC27DEfONLCF
         z9a/bcRXt6CszNrXQ5qpQxtqN6dTWrZp6Bnt4CCqJ+O3QHOT+Uz2tSa/vK+i2hGTZ5H9
         9Pxg==
X-Forwarded-Encrypted: i=1; AJvYcCUZ1qSBZvkhixyL3s1Pq55maIdQFLNgk75pc5nOQ6+a51Y/ulEVi88PQzw6GuMFo0+Sb9le8u14jpE=@vger.kernel.org, AJvYcCWH4//zd/1GrEIZTp252aNO7GCPOwKblzcrAWNsOFsEcbsmjvqh6i336fx9AA3HtXtpgsKWnGaLcQqqbko=@vger.kernel.org, AJvYcCWryCb0xTjKMCTSpnHUJ8Us0u3/MjPs2BxBzhIkhGLmrWPYxWToy6jeH7TNVHUUrYadgT8dc0CRix6tOj+lGYwcfGTrkQ==@vger.kernel.org, AJvYcCXncHg8EBRTXsGt7ycYr1bSziuCvNtJGS7MgPPc/zYp5CmCSrtukLDyjxusSDgJG3wvMo6uCvc5xbl8ofHG@vger.kernel.org
X-Gm-Message-State: AOJu0YyMfYaC5AOpgYOdXL0Q00YEFL0CwoWlfPbGYsIQfy5fIIfniGxV
	XhUdq89aqhaL9h2DLN5ftxjwjpLg/pHhayYV8We5ggm+x9hzjRGhdc0ZU9J/ry5n8QMFA6rUJSJ
	pas4XDCAAgunkSkw9N+N9LwaVVc0HFh6k+w==
X-Gm-Gg: ASbGncum5Cbw3M/c5QAG5Djot4scNIsDv89PaDqdGvYjlvKOzhSUGgGxg5dz9p3UHp1
	/6xXMMeNJkMFga1Mm3URezfl7HLO4pz5Cah/dIszGmUCW3KH9A/zp8QXqt+SF789NcfSEakolFl
	fon6om5aKS9+s0A9TBTlyjVvEGxgVn7pKjRgJ9GubQVjGCdqULDRlxYDVg+nDgt3C7C8Q0qbh2B
	bMp6+4V
X-Google-Smtp-Source: AGHT+IGQ4vsQL3QXsstKMS0svuiMxuAtWJW19SY8B2ZgCJcAZ84o1BTlu1bLANAIg1NQr2zDMpNomet+Jma/Zae/YAc=
X-Received: by 2002:ad4:5d47:0:b0:6fb:3579:8f07 with SMTP id
 6a1803df08f44-707205aeb62mr225817286d6.31.1753757912419; Mon, 28 Jul 2025
 19:58:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250726204041.516440-1-derekjohn.clark@gmail.com>
 <20250726204041.516440-2-derekjohn.clark@gmail.com> <5b061220-e04a-48b5-ba2c-92ccf240798e@gmx.de>
In-Reply-To: <5b061220-e04a-48b5-ba2c-92ccf240798e@gmx.de>
From: Derek John Clark <derekjohn.clark@gmail.com>
Date: Mon, 28 Jul 2025 19:58:21 -0700
X-Gm-Features: Ac12FXz8s8atgPx5pwCA726qutxGU26Kw1NKodYLVE04_6XIGpNTG9jHBcTQwQw
Message-ID: <CAFqHKTnkPLEbMk+NeLaSridSJBGU+P4P5PFF7VmiQbcfv7CAkg@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] platform/x86: (ayn-ec) Add PWM Fan HWMON Interface
To: Armin Wolf <W_Armin@gmx.de>
Cc: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Hans de Goede <hansg@kernel.org>, Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, 
	Alok Tiwari <alok.a.tiwari@oracle.com>, David Box <david.e.box@linux.intel.com>, 
	platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 26, 2025 at 4:32=E2=80=AFPM Armin Wolf <W_Armin@gmx.de> wrote:
>
> Am 26.07.25 um 22:40 schrieb Derek J. Clark:
>
> > Adds platform driver for AYN Loki and Tectoy Zeenix lines of handheld
> > devices. This patch implements a hwmon interface for EC provided manual
> > PWM fan control and user defined fan curves. A global ACPI lock is used
> > when reading or writing from the EC.
> >
> > There are 4 fan modes implemented in this patch. Modes 0-3 act in
> > accordance with the standard hwmon logic where 0 is 100% fan speed, 1 i=
s
> > manual control, and 2 is automatic control. As the EC only provides 3
> > modes by default, mode 0 is implemented by setting the device to manual
> > and then setting fan speed to 100% directly. In mode 1 the PWM duty cyc=
le
> > is set in sysfs with values [0-255], which are then scaled to the EC ma=
x
> > of 128. Mode 4 is an automatic mode where the fan curve is user defined=
.
> > There are 5 total set points and each set point takes a temperature in
> > Celsius [0-100] and a PWM duty cycle [0-255]. When the CPU temperature
> > reaches a given set point, the corresponding duty cycle is automaticall=
y
> > set by the EC.
> >
> > Signed-off-by: Derek J. Clark <derekjohn.clark@gmail.com>
> >
> > space
>
> Interesting, do you have access to such a device? If yes then i would be =
very interested
> in looking at the ACPI tables shipped with said device.

Hi Armin,

I have a Loki Max, and know someone with a Loki Zero. Do you want
plain text acpidump or a decoded DSDT.dat attached?

> > ---
> >   MAINTAINERS                   |   6 +
> >   drivers/platform/x86/Kconfig  |  12 +
> >   drivers/platform/x86/Makefile |   3 +
> >   drivers/platform/x86/ayn-ec.c | 520 +++++++++++++++++++++++++++++++++=
+
> >   4 files changed, 541 insertions(+)
> >   create mode 100644 drivers/platform/x86/ayn-ec.c
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index d61b004005fd..5b816883fe7d 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -4035,6 +4035,12 @@ W:     https://ez.analog.com/linux-software-driv=
ers
> >   F:  Documentation/devicetree/bindings/pwm/adi,axi-pwmgen.yaml
> >   F:  drivers/pwm/pwm-axi-pwmgen.c
> >
> > +AYN PLATFORM EC DRIVER
> > +M:   Derek J. Clark <derekjohn.clark@gmail.com>
> > +L:   platform-driver-x86@vger.kernel.org
> > +S:   Maintained
> > +F:   drivers/platform/x86/ayn-ec.c
> > +
> >   AZ6007 DVB DRIVER
> >   M:  Mauro Carvalho Chehab <mchehab@kernel.org>
> >   L:  linux-media@vger.kernel.org
> > diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfi=
g
> > index 6d238e120dce..4819bfcffb6b 100644
> > --- a/drivers/platform/x86/Kconfig
> > +++ b/drivers/platform/x86/Kconfig
> > @@ -304,6 +304,18 @@ config ASUS_TF103C_DOCK
> >         If you have an Asus TF103C tablet say Y or M here, for a generi=
c x86
> >         distro config say M here.
> >
> > +config AYN_EC
> > +     tristate "AYN x86 devices EC platform control"
> > +     depends on ACPI
> > +     depends on HWMON
> > +     help
> > +       This is a driver for AYN and Tectoy x86 handheld devices. It pr=
ovides
> > +       temperature monitoring, manual fan speed control, fan curve con=
trol,
> > +       and chassis RGB settings.
> > +
> > +       If you have an x86 AYN or Tectoy handheld device say M here. Th=
e module
> > +       will be called ayn-platform.
> > +
> >   config MERAKI_MX100
> >       tristate "Cisco Meraki MX100 Platform Driver"
> >       depends on GPIOLIB
> > diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makef=
ile
> > index a0c5848513e3..d32504b89365 100644
> > --- a/drivers/platform/x86/Makefile
> > +++ b/drivers/platform/x86/Makefile
> > @@ -38,6 +38,9 @@ obj-$(CONFIG_ASUS_TF103C_DOCK)      +=3D asus-tf103c-=
dock.o
> >   obj-$(CONFIG_EEEPC_LAPTOP)  +=3D eeepc-laptop.o
> >   obj-$(CONFIG_EEEPC_WMI)             +=3D eeepc-wmi.o
> >
> > +# Ayn
> > +obj-$(CONFIG_AYN_EC) +=3D ayn-ec.o
> > +
> >   # Cisco/Meraki
> >   obj-$(CONFIG_MERAKI_MX100)  +=3D meraki-mx100.o
> >
> > diff --git a/drivers/platform/x86/ayn-ec.c b/drivers/platform/x86/ayn-e=
c.c
> > new file mode 100644
> > index 000000000000..8bd3ed1c69eb
> > --- /dev/null
> > +++ b/drivers/platform/x86/ayn-ec.c
> > @@ -0,0 +1,520 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +/*
> > + * Platform driver for AYN x86 Handhelds.
> > + *
> > + * Implements multiple attributes provided by the EC. Fan reading and =
control,
> > + * as well as temperature sensor readings are exposed via hwmon sysfs.=
 EC RGB
> > + * control is exposed via an led-class-multicolor interface.
> > + *
> > + * Fan control is provided via a pwm interface in the range [0-255]. A=
YN use
> > + * [0-128] as the range in the EC, the written value is scaled to acco=
mmodate.
> > + * The EC also provides a configurable fan curve with five set points =
that
> > + * associate a temperature in Celcius [0-100] with a fan speed [0-128]=
. The
> > + * auto_point fan speeds are also scaled from the range [0-255]. Tempe=
rature
> > + * readings are scaled from degrees to millidegrees when read.
> > + *
> > + * RGB control is provided using 4 registers. One each for the colors =
red,
> > + * green, and blue are [0-255]. There is also a effect register that t=
akes
> > + * switches between an EC controlled breathing that cycles through all=
 colors
> > + * and fades in/out, and manual, which enables setting a user defined =
color.
> > + *
> > + * Copyright (C) 2025 Derek J. Clark <derekjohn.clark@gmail.com>
> > + */
> > +
> > +#include <linux/acpi.h>
> > +#include <linux/device.h>
> > +#include <linux/dmi.h>
> > +#include <linux/hwmon-sysfs.h>
> > +#include <linux/hwmon.h>
> > +#include <linux/init.h>
> > +#include <linux/kernel.h>
> > +#include <linux/module.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/sysfs.h>
> > +#include <linux/types.h>
> > +
> > +/* Fan speed and PWM registers */
> > +#define AYN_SENSOR_PWM_FAN_ENABLE_REG        0x10 /* PWM operating mod=
e */
> > +#define AYN_SENSOR_PWM_FAN_SET_REG   0x11 /* PWM duty cycle */
> > +#define AYN_SENSOR_PWM_FAN_SPEED_REG 0x20 /* Fan speed */
> > +
> > +/* EC controlled fan curve registers */
> > +#define AYN_SENSOR_PWM_FAN_SPEED_1_REG       0x12
> > +#define AYN_SENSOR_PWM_FAN_SPEED_2_REG       0x14
> > +#define AYN_SENSOR_PWM_FAN_SPEED_3_REG       0x16
> > +#define AYN_SENSOR_PWM_FAN_SPEED_4_REG       0x18
> > +#define AYN_SENSOR_PWM_FAN_SPEED_5_REG       0x1A
> > +#define AYN_SENSOR_PWM_FAN_TEMP_1_REG        0x13
> > +#define AYN_SENSOR_PWM_FAN_TEMP_2_REG        0x15
> > +#define AYN_SENSOR_PWM_FAN_TEMP_3_REG        0x17
> > +#define AYN_SENSOR_PWM_FAN_TEMP_4_REG        0x19
> > +#define AYN_SENSOR_PWM_FAN_TEMP_5_REG        0x1B
> > +
> > +/* AYN EC PWM Fan modes */
> > +#define AYN_PWM_FAN_MODE_MANUAL      0x00
> > +#define AYN_PWM_FAN_MODE_AUTO                0x01
> > +#define AYN_PWM_FAN_MODE_EC_CURVE    0x02
> > +
> > +/* hwmon fan modes */
> > +#define HWMON_PWM_FAN_MODE_FULL      0x00
> > +#define HWMON_PWM_FAN_MODE_MANUAL    0x01
> > +#define HWMON_PWM_FAN_MODE_AUTO      0x02
> > +#define HWMON_PWM_FAN_MODE_EC_CURVE  0x03
> > +
> > +/* Handle ACPI lock mechanism */
> > +#define ACPI_LOCK_DELAY_MS 500
> > +
> > +int ayn_pwm_curve_registers[10] =3D {
>
> Please declare this array as static const.
>
> > +     AYN_SENSOR_PWM_FAN_SPEED_1_REG,
> > +     AYN_SENSOR_PWM_FAN_SPEED_2_REG,
> > +     AYN_SENSOR_PWM_FAN_SPEED_3_REG,
> > +     AYN_SENSOR_PWM_FAN_SPEED_4_REG,
> > +     AYN_SENSOR_PWM_FAN_SPEED_5_REG,
> > +     AYN_SENSOR_PWM_FAN_TEMP_1_REG,
> > +     AYN_SENSOR_PWM_FAN_TEMP_2_REG,
> > +     AYN_SENSOR_PWM_FAN_TEMP_3_REG,
> > +     AYN_SENSOR_PWM_FAN_TEMP_4_REG,
> > +     AYN_SENSOR_PWM_FAN_TEMP_5_REG,
> > +};
> > +
> > +struct ayn_device {
> > +     u32 ayn_lock; /* ACPI EC Lock */
> > +} drvdata;
>
> Please declare drvdata as static.
>
> > +
> > +/* Handle ACPI lock mechanism */
> > +#define ACPI_LOCK_DELAY_MS 500
> > +
> > +static bool lock_global_acpi_lock(void)
> > +{
> > +     return ACPI_SUCCESS(acpi_acquire_global_lock(ACPI_LOCK_DELAY_MS,
> > +                                                  &drvdata.ayn_lock));
> > +}
> > +
> > +static bool unlock_global_acpi_lock(void)
> > +{
> > +     return ACPI_SUCCESS(acpi_release_global_lock(drvdata.ayn_lock));
> > +}
> > +
> > +/**
> > + * read_from_ec() - Reads a value from the embedded controller.
> > + *
> > + * @reg: The register to start the read from.
> > + * @size: The number of sequential registers the data is contained in.
> > + * @val: Pointer to return the data with.
> > + *
> > + * Return: 0, or an error.
> > + */
> > +static int read_from_ec(u8 reg, int size, long *val)
> > +{
> > +     int ret, i;
> > +     u8 buf;
> > +
> > +     if (!lock_global_acpi_lock())
> > +             return -EBUSY;
> > +
> > +     *val =3D 0;
> > +     for (i =3D 0; i < size; i++) {
> > +             ret =3D ec_read(reg + i, &buf);
> > +             if (ret)
> > +                     return ret;
> > +             *val <<=3D i * 8;
> > +             *val +=3D buf;
>
> Could it be that "i * 8" should have been just "8"?-

Seems to work as is. This should bitshift the stored value by 0 (none)
for the first register (MSB) and 8 for the second register (LSB). Not
sure how well it would work for 3 or more registers but everything is
either 1 or 2.

> > +     }
> > +
> > +     if (!unlock_global_acpi_lock())
> > +             return -EBUSY;
> > +
> > +     return 0;
> > +}
> > +
> > +/**
> > + * write_to_ec() - Writes a value to the embedded controller.
> > + *
> > + * @reg: The register to write to.
> > + * @val: Value to write
> > + *
> > + * Return: 0, or an error.
> > + */
> > +static int write_to_ec(u8 reg, u8 val)
> > +{
> > +     int ret;
> > +
> > +     if (!lock_global_acpi_lock())
> > +             return -EBUSY;
> > +
> > +     pr_info("Writing EC value %d to register %u\n", val, reg);
> > +     ret =3D ec_write(reg, val);
> > +
> > +     if (!unlock_global_acpi_lock())
> > +             return -EBUSY;
> > +
> > +     return ret;
> > +}
>
> Why not using regmap for that?
>
> > +/**
> > + * ayn_pwm_manual() - Enable manual control of the fan.
> > + */
> > +static int ayn_pwm_manual(void)
> > +{
> > +     return write_to_ec(AYN_SENSOR_PWM_FAN_ENABLE_REG, 0x00);
> > +}
> > +
> > +/**
> > + * ayn_pwm_full() - Set fan to 100% speed.
> > + */
> > +static int ayn_pwm_full(void)
> > +{
> > +     int ret;
> > +
> > +     ret =3D write_to_ec(AYN_SENSOR_PWM_FAN_ENABLE_REG, 0x00);
> > +     if (ret)
> > +             return ret;
> > +
> > +     return write_to_ec(AYN_SENSOR_PWM_FAN_SET_REG, 128);
> > +}
> > +
> > +/**
> > + * ayn_pwm_auto() - Enable automatic EC control of the fan.
> > + */
> > +static int ayn_pwm_auto(void)
> > +{
> > +     return write_to_ec(AYN_SENSOR_PWM_FAN_ENABLE_REG, 0x01);
> > +}
> > +
> > +/**
> > + * ayn_pwm_ec_curve() - Enable manually setting the fan curve for auto=
matic
> > + * EC control of the fan.
> > + */
> > +static int ayn_pwm_ec_curve(void)
> > +{
> > +     return write_to_ec(AYN_SENSOR_PWM_FAN_ENABLE_REG, 0x02);
> > +}
> > +
> > +/**
> > + * ayn_ec_hwmon_is_visible() - Determines RO or RW for hwmon attribute=
 sysfs.
> > + *
> > + * @drvdata: Unused void pointer to context data.
> > + * @type: The hwmon_sensor_types type.
> > + * @attr: The attribute to set RO/RW on.
> > + * @channel: HWMON subsystem usage flags for the attribute.
> > + *
> > + * Return: Permission level.
> > + */
> > +static umode_t ayn_ec_hwmon_is_visible(const void *drvdata,
> > +                                    enum hwmon_sensor_types type, u32 =
attr,
> > +                                    int channel)
> > +{
> > +     switch (type) {
> > +     case hwmon_fan:
> > +             return 0444;
> > +     case hwmon_pwm:
> > +             return 0644;
> > +     default:
> > +             return 0;
> > +     }
> > +}
> > +
> > +/**
> > + * ayn_pwm_fan_read() - Read from a hwmon pwm or fan attribute.
> > + *
> > + * @dev: parent device of the given attribute.
> > + * @type: The hwmon_sensor_types type.
> > + * @attr: The attribute to read from.
> > + * @channel: HWMON subsystem usage flags for the attribute.
> > + * @val: Pointer to return the read value from.
> > + *
> > + * Return: 0, or an error.
> > + */
> > +static int ayn_pwm_fan_read(struct device *dev, enum hwmon_sensor_type=
s type,
> > +                         u32 attr, int channel, long *val)
> > +{
> > +     int ret;
> > +
> > +     switch (type) {
> > +     case hwmon_fan:
> > +             switch (attr) {
> > +             case hwmon_fan_input:
> > +                     return read_from_ec(AYN_SENSOR_PWM_FAN_SPEED_REG,=
 2,
> > +                                         val);
> > +             default:
> > +                     break;
> > +             }
> > +             break;
> > +     case hwmon_pwm:
> > +             switch (attr) {
> > +             case hwmon_pwm_enable:
> > +                     ret =3D read_from_ec(AYN_SENSOR_PWM_FAN_ENABLE_RE=
G, 1,
> > +                                        val);
> > +                     if (ret)
> > +                             return ret;
> > +
> > +                     /* EC uses 0 for manual, 1 for automatic, 2 for u=
ser
> > +                      * fan curve. Reflect hwmon usage instead.
> > +                      */
> > +                     if (*val =3D=3D 1) {
> > +                             *val =3D 2;
> > +                             return 0;
> > +                     }
> > +
> > +                     if (*val =3D=3D 2) {
> > +                             *val =3D 3;
> > +                             return 0;
> > +                     }
> > +
> > +                     /* Return 0 when fan at max, otherwise 1 for manu=
al. */
> > +                     ret =3D read_from_ec(AYN_SENSOR_PWM_FAN_SET_REG, =
1, val);
> > +                     if (ret)
> > +                             return ret;
>
> This might confuse userspace fan control software that might not expect t=
he value of pwm1_enable
> to suddenly change when setting pwm1 to 255. Maybe it would be better to =
not support pwm mode 0 as the
> underlying EC seems to not provide a separate fan mode for setting the fa=
n to full speed.
>

I have no strong feelings either way. We did this for the oxp-ec
driver so I was just looking to be consistent.

> > +
> > +                     if (*val =3D=3D 128)
> > +                             *val =3D 0;
> > +                     else
> > +                             *val =3D 1;
> > +
> > +                     return ret;
> > +             case hwmon_pwm_input:
> > +                     ret =3D read_from_ec(AYN_SENSOR_PWM_FAN_SET_REG, =
1, val);
> > +                     if (ret)
> > +                             return ret;
> > +
> > +                     *val =3D *val << 1; /* Max value is 128, scale to=
 255 */
> > +
> > +                     return 0;
> > +             default:
> > +                     break;
> > +             }
> > +             break;
> > +     default:
> > +             break;
> > +     }
> > +     return -EOPNOTSUPP;
> > +}
> > +
> > +/**
> > + * ayn_pwm_fan_write() - Write to a hwmon pwm attribute.
> > + *
> > + * @dev: parent device of the given attribute.
> > + * @type: The hwmon_sensor_types type.
> > + * @attr: The attribute to write to.
> > + * @channel: HWMON subsystem usage flags for the attribute.
> > + * @val: Value to write.
> > + *
> > + * Return: 0, or an error.
> > + */
> > +static int ayn_pwm_fan_write(struct device *dev, enum hwmon_sensor_typ=
es type,
> > +                          u32 attr, int channel, long val)
> > +{
> > +     if (type !=3D hwmon_pwm)
> > +             return -EOPNOTSUPP;
> > +     switch (attr) {
> > +     case hwmon_pwm_enable:
> > +             switch (val) {
> > +             case HWMON_PWM_FAN_MODE_FULL:
> > +                     return ayn_pwm_full();
> > +             case HWMON_PWM_FAN_MODE_MANUAL:
> > +                     return ayn_pwm_manual();
> > +             case HWMON_PWM_FAN_MODE_AUTO:
> > +                     return ayn_pwm_auto();
> > +             case HWMON_PWM_FAN_MODE_EC_CURVE:
> > +                     return ayn_pwm_ec_curve();
> > +             default:
> > +                     return -EINVAL;
> > +             }
> > +     case hwmon_pwm_input:
> > +             if (val < 0 || val > 255)
> > +                     return -EINVAL;
> > +
> > +             val =3D val >> 1; /* Max value is 128, scale from 255 */
> > +
> > +             return write_to_ec(AYN_SENSOR_PWM_FAN_SET_REG, val);
> > +     default:
> > +             return -EOPNOTSUPP;
> > +     }
> > +}
> > +
> > +static const struct hwmon_channel_info *ayn_ec_sensors[] =3D {
> > +     HWMON_CHANNEL_INFO(fan, HWMON_F_INPUT),
> > +     HWMON_CHANNEL_INFO(pwm, HWMON_PWM_INPUT | HWMON_PWM_ENABLE),
> > +     NULL,
> > +};
> > +
> > +static const struct hwmon_ops ayn_ec_hwmon_ops =3D {
> > +     .is_visible =3D ayn_ec_hwmon_is_visible,
> > +     .read =3D ayn_pwm_fan_read,
> > +     .write =3D ayn_pwm_fan_write,
> > +};
> > +
> > +static const struct hwmon_chip_info ayn_ec_chip_info =3D {
> > +     .ops =3D &ayn_ec_hwmon_ops,
> > +     .info =3D ayn_ec_sensors,
> > +};
> > +
> > +/**
> > + * pwm_curve_store() - Write a fan curve speed or temperature value.
> > + *
> > + * @dev: The attribute's parent device.
> > + * @attr: The attribute to read.
> > + * @buf: Input value string from sysfs write.
> > + *
> > + * Return: Number of bytes read, or an error.
> > + */
> > +static ssize_t pwm_curve_store(struct device *dev,
> > +                            struct device_attribute *attr, const char =
*buf,
> > +                            size_t count)
> > +{
> > +     int i =3D to_sensor_dev_attr(attr)->index;
> > +     int ret, val;
> > +     u8 reg;
> > +
> > +     ret =3D kstrtoint(buf, 0, &val);
>
> Please use "10" for the second argument of kstrtoint() instead of "0".
>
> > +     if (ret)
> > +             return ret;
> > +
> > +     if (i < 5) {
> > +             if (val < 0 || val > 255)
> > +                     return -EINVAL;
> > +             val =3D val >> 1; /* Max EC value is 128, scale from 255 =
*/
> > +     } else
> > +             if (val < 0 || val > 100)
> > +                     return -EINVAL;
>
> Please keep in mind that temperature values are submitted in milidegrees =
celsius, so you need
> to perform some scaling here.
>

Small oversight, thanks for pointing that out.

> > +
> > +     reg =3D ayn_pwm_curve_registers[i];
> > +
> > +     ret =3D write_to_ec(reg, val);
> > +     if (ret)
> > +             return ret;
> > +
> > +     return count;
> > +}
> > +
> > +/**
> > + * pwm_curve_show() - Read a fan curve speed or temperature value.
> > + *
> > + * @dev: The attribute's parent device.
> > + * @attr: The attribute to read.
> > + * @buf: Output buffer.
> > + *
> > + * Return: Number of bytes read, or an error.
> > + */
> > +static ssize_t pwm_curve_show(struct device *dev, struct device_attrib=
ute *attr,
> > +                           char *buf)
> > +{
> > +     int i =3D to_sensor_dev_attr(attr)->index;
> > +     long val;
> > +     int ret;
> > +     u8 reg;
> > +
> > +     reg =3D ayn_pwm_curve_registers[i];
> > +
> > +     ret =3D read_from_ec(reg, 1, &val);
> > +     if (ret)
> > +             return ret;
> > +
> > +     if (i < 5)
> > +             val =3D val << 1; /* Max EC value is 128, scale to 255 */
>
> Please convert the temperature values to milidegrees celsius here.
>
> > +
> > +     return sysfs_emit(buf, "%ld\n", val);
> > +}
> > +
> > +/* Fan curve attributes */
> > +static SENSOR_DEVICE_ATTR_RW(pwm1_auto_point1_pwm, pwm_curve, 0);
> > +static SENSOR_DEVICE_ATTR_RW(pwm1_auto_point2_pwm, pwm_curve, 1);
> > +static SENSOR_DEVICE_ATTR_RW(pwm1_auto_point3_pwm, pwm_curve, 2);
> > +static SENSOR_DEVICE_ATTR_RW(pwm1_auto_point4_pwm, pwm_curve, 3);
> > +static SENSOR_DEVICE_ATTR_RW(pwm1_auto_point5_pwm, pwm_curve, 4);
> > +static SENSOR_DEVICE_ATTR_RW(pwm1_auto_point1_temp, pwm_curve, 5);
> > +static SENSOR_DEVICE_ATTR_RW(pwm1_auto_point2_temp, pwm_curve, 6);
> > +static SENSOR_DEVICE_ATTR_RW(pwm1_auto_point3_temp, pwm_curve, 7);
> > +static SENSOR_DEVICE_ATTR_RW(pwm1_auto_point4_temp, pwm_curve, 8);
> > +static SENSOR_DEVICE_ATTR_RW(pwm1_auto_point5_temp, pwm_curve, 9);
> > +
> > +static struct attribute *ayn_sensors_attrs[] =3D {
> > +     &sensor_dev_attr_pwm1_auto_point1_pwm.dev_attr.attr,
> > +     &sensor_dev_attr_pwm1_auto_point1_temp.dev_attr.attr,
> > +     &sensor_dev_attr_pwm1_auto_point2_pwm.dev_attr.attr,
> > +     &sensor_dev_attr_pwm1_auto_point2_temp.dev_attr.attr,
> > +     &sensor_dev_attr_pwm1_auto_point3_pwm.dev_attr.attr,
> > +     &sensor_dev_attr_pwm1_auto_point3_temp.dev_attr.attr,
> > +     &sensor_dev_attr_pwm1_auto_point4_pwm.dev_attr.attr,
> > +     &sensor_dev_attr_pwm1_auto_point4_temp.dev_attr.attr,
> > +     &sensor_dev_attr_pwm1_auto_point5_pwm.dev_attr.attr,
> > +     &sensor_dev_attr_pwm1_auto_point5_temp.dev_attr.attr,
> > +     NULL,
> > +};
> > +
> > +ATTRIBUTE_GROUPS(ayn_sensors);
> > +
> > +static int ayn_ec_probe(struct platform_device *pdev)
> > +{
> > +     struct device *dev =3D &pdev->dev;
> > +     struct device *hwdev;
> > +
> > +     hwdev =3D devm_hwmon_device_register_with_info(dev, "aynec", NULL=
,
> > +                                                  &ayn_ec_chip_info,
> > +                                                  ayn_sensors_groups);
> > +     return PTR_ERR_OR_ZERO(hwdev);
> > +}
> > +
> > +static struct platform_driver ayn_ec_driver =3D {
> > +     .driver =3D {
> > +             .name =3D "ayn-ec",
> > +     },
> > +     .probe =3D ayn_ec_probe,
> > +};
>
> How do you restore the fan curve settings when resuming from suspend? I s=
uggest that you
> convert this driver to use the regmap mechanism as doing so would also gi=
ve you:
>
> - caching of register values
> - restoring cached register values during resume
>
> You can the a look at the sch5627 driver on how to implement suspend usin=
g regmap. You can also
> take some inspirations from drivers/hwmon/sch56xx-common.c on how to impl=
ement your own regmap
> backend.

Okay, I'll take a look at it.

> > +
> > +static struct platform_device *ayn_ec_device;
> > +
> > +static int __init ayn_ec_init(void)
> > +{
> > +     ayn_ec_device =3D platform_create_bundle(&ayn_ec_driver, ayn_ec_p=
robe,
> > +                                            NULL, 0, NULL, 0);
> > +
> > +     return PTR_ERR_OR_ZERO(ayn_ec_device);
> > +}
> > +
> > +static void __exit ayn_ec_exit(void)
> > +{
> > +     platform_device_unregister(ayn_ec_device);
> > +     platform_driver_unregister(&ayn_ec_driver);
> > +}
> > +
> > +static const struct dmi_system_id ayn_dmi_table[] =3D {
> > +     {
> > +             .ident =3D "AYN Loki Max",
> > +             .matches =3D {
> > +                     DMI_EXACT_MATCH(DMI_BOARD_VENDOR, "ayn"),
> > +                     DMI_EXACT_MATCH(DMI_BOARD_NAME, "Loki Max"),
> > +             },
> > +     },
> > +     {
> > +             .ident =3D "AYN Loki MiniPro",
> > +             .matches =3D {
> > +                     DMI_EXACT_MATCH(DMI_BOARD_VENDOR, "ayn"),
> > +                     DMI_EXACT_MATCH(DMI_BOARD_NAME, "Loki MiniPro"),
> > +             },
> > +     },
> > +     {
> > +             .ident =3D "AYN Loki Zero",
> > +             .matches =3D {
> > +                     DMI_EXACT_MATCH(DMI_BOARD_VENDOR, "ayn"),
> > +                     DMI_EXACT_MATCH(DMI_BOARD_NAME, "Loki Zero"),
> > +             },
> > +     },
> > +     {
> > +             .ident =3D "Tectoy Zeenix Lite",
> > +             .matches =3D {
> > +                     DMI_EXACT_MATCH(DMI_BOARD_VENDOR, "Tectoy"),
> > +                     DMI_EXACT_MATCH(DMI_BOARD_NAME, "Zeenix Lite"),
> > +             },
> > +     },
> > +     {},
> > +};
>
> Please declare the DMI table as being __initconst, as doing so will free =
some memory after the driver
> has been loaded. Additionally please check this DMI table inside ayn_ec_i=
nit() using dmi_first_match()
> just in case someone configures this module as builtin.

Makes sense.

Thanks,
Derek

> Thanks,
> Armin Wolf
>
> > +
> > +MODULE_DEVICE_TABLE(dmi, ayn_dmi_table);
> > +
> > +module_init(ayn_ec_init);
> > +module_exit(ayn_ec_exit);
> > +
> > +MODULE_AUTHOR("Derek J. Clark <derekjohn.clark@gmail.com>");
> > +MODULE_DESCRIPTION("Platform driver that handles EC sensors of AYN x86=
 devices");
> > +MODULE_LICENSE("GPL");

