Return-Path: <linux-kernel+bounces-782700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70D9FB323D5
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 22:57:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29C351D6255D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 20:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 769502FF14A;
	Fri, 22 Aug 2025 20:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="aN0lddwR"
Received: from relay11.grserver.gr (relay11.grserver.gr [78.46.171.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C58126B769;
	Fri, 22 Aug 2025 20:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.46.171.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755896245; cv=none; b=AKHYdkCgrDIJkUdBaA0ymofvwZkiJAHyeCgnRUPa0pjwP/BzCHLHW6QS4sv2U8BVlh5E7YM7G9yHjZZ4qm3BYCTC9a58NEnk9x3S/thDuwjkhZDdxi4b7QECRbN5UuilOCZMjLEuzxGGNVt5NPIIZcBI5LKXyvN/Dda+MgbSRjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755896245; c=relaxed/simple;
	bh=/jhEs6l+OMdCVWAxzXsZPUrvBq1EvaJHH7jYkMx/QU0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KMHnyc+HZWBQkaVdMUI9W4EoNBBHBnVDwmH/ycHAX6L1HdjCzrqPd7pmIvuek5mRFGTZKyKe3LoxADiNgeMfnbJ3cdgX56OWfoNoqNFHCnnPJadCeHuukPM/EXjf/O9n/m5b91EmeU/xy9rdqgPttoxegBjxXTi83T5UZcduBcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=temperror (0-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=aN0lddwR; arc=none smtp.client-ip=78.46.171.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from relay11 (localhost.localdomain [127.0.0.1])
	by relay11.grserver.gr (Proxmox) with ESMTP id 9A9A6C7268;
	Fri, 22 Aug 2025 23:57:11 +0300 (EEST)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by relay11.grserver.gr (Proxmox) with ESMTPS id C6356C726F;
	Fri, 22 Aug 2025 23:57:10 +0300 (EEST)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	by linux3247.grserver.gr (Postfix) with ESMTPSA id 3E38C206E83;
	Fri, 22 Aug 2025 23:57:10 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1755896230;
	bh=vHZTQwqIG6KB6QchYLMzDiXe9ZC5BT9Pokb/Soa0KSk=;
	h=Received:From:Subject:To;
	b=aN0lddwRPw58Pu+OUI/Hs1idLgPHSu1VCn12vM55HcJ2Xgs3a4kq+HzuUo5HgEdyw
	 UitfEbosxU2ZHRQkuSvHuYi69pm6u61dvIXRMpPJveaxusynDISgTA+laDPDYGrcbf
	 6bVTA5SpN+vCp5ew+Jk1BUX6u3pqbCrE9aFCPBkBF6KTQpS0V230rkAvNQCCXLAsOX
	 nf6FDlme9Xr1+2C1eegOvKHynKSk53e+IDy3DxnLT6HGVnA+xq1ZsCjz5MDlaNz8lG
	 BIOJF8F0dOtlz91EkK0kNrz1vBOaHdhLlBxYffh9O0ef8lF8R/W27wkV5jSZUKcJuJ
	 alk02fT/iRi/g==
Authentication-Results: linux3247.grserver.gr;
        spf=pass (sender IP is 209.85.167.52) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-lf1-f52.google.com
Received-SPF: pass (linux3247.grserver.gr: connection is authenticated)
Received: by mail-lf1-f52.google.com with SMTP id
 2adb3069b0e04-55ce4b9c904so2885966e87.0;
        Fri, 22 Aug 2025 13:57:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCXiKWfIwOFGT1/ZOZyWyvRIb0cgDZdHrT9oj5TdbWvf32ZUINDSI7akRn6//WwP9CxQd2sztWxwg5O+QDr6@vger.kernel.org,
 AJvYcCXyI8hC4HPQkzmG9zEaPdOIROlZSrfW6W4b18jxVkTtide0D6ynyKUpBVscckS5S7TXLplntN813KPWsQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxUu+cFn02zUfHQ9MlonoOt84qWnUu41aZofahSARHs1AoxmIuP
	WqEY6HokQhbbMVFHCKR9+dUh48hrAXBuAhod4tEmEBnNBciPeCi8eorZI+/oETZWyFHd2+XfVE/
	+dypIKPbR3vWuWptUPf9TOMGHITh4q8M=
X-Google-Smtp-Source: 
 AGHT+IE+NwRqBu45IWNgGLSh96gl9LXioOB5GFrc1VlcPCfNJDAMO6vxPB/SLK8Pl/gFAq43R9xUq0IguIulTDgdSwE=
X-Received: by 2002:a05:6512:2251:b0:55a:4c3a:b122 with SMTP id
 2adb3069b0e04-55e0da1b3b7mr1876857e87.10.1755896229629; Fri, 22 Aug 2025
 13:57:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250820160628.99678-1-lkml@antheas.dev>
 <20250820160628.99678-3-lkml@antheas.dev>
 <44404f92-fd30-400c-9f80-64c5649d9849@gmx.de>
In-Reply-To: <44404f92-fd30-400c-9f80-64c5649d9849@gmx.de>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Fri, 22 Aug 2025 22:56:58 +0200
X-Gmail-Original-Message-ID: 
 <CAGwozwEV6QVqZKVfO++W0v0g7w9rWE2Joup=w9vPibP=hAzx4A@mail.gmail.com>
X-Gm-Features: Ac12FXyFoTHpw86McYPSJUvUUe6sGm3UnlVeenestqQLp3MkTm98Aqzlabq81vc
Message-ID: 
 <CAGwozwEV6QVqZKVfO++W0v0g7w9rWE2Joup=w9vPibP=hAzx4A@mail.gmail.com>
Subject: Re: [PATCH v1 2/5] platform/x86: ayaneo-ec: Add hwmon support
To: Armin Wolf <W_Armin@gmx.de>
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hwmon@vger.kernel.org, Hans de Goede <hansg@kernel.org>,
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Derek John Clark <derekjohn.clark@gmail.com>,
	=?UTF-8?Q?Joaqu=C3=ADn_Ignacio_Aramend=C3=ADa?= <samsagax@gmail.com>,
	Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
X-PPP-Message-ID: 
 <175589623044.2765837.14461084560824416966@linux3247.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 1.4.3 at linux3247.grserver.gr
X-Virus-Status: Clean

On Fri, 22 Aug 2025 at 14:35, Armin Wolf <W_Armin@gmx.de> wrote:
>
> Am 20.08.25 um 18:06 schrieb Antheas Kapenekakis:
>
> > Add hwmon single fan sensor reads and control for Ayaneo devices.
> > The register and method of access is the same for all devices.
> >
> > Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
> > ---
> >   drivers/platform/x86/Kconfig     |   2 +
> >   drivers/platform/x86/ayaneo-ec.c | 132 +++++++++++++++++++++++++++++++
> >   2 files changed, 134 insertions(+)
> >
> > diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
> > index 6d4a33791cc1..0a7ca2c78456 100644
> > --- a/drivers/platform/x86/Kconfig
> > +++ b/drivers/platform/x86/Kconfig
> > @@ -307,6 +307,8 @@ config ASUS_TF103C_DOCK
> >   config AYANEO_EC
> >       tristate "Ayaneo EC platform control"
> >       depends on X86
> > +     depends on ACPI_EC
> > +     depends on HWMON
> >       help
> >         Enables support for the platform EC of Ayaneo devices. This
> >         includes fan control, fan speed, charge limit, magic
> > diff --git a/drivers/platform/x86/ayaneo-ec.c b/drivers/platform/x86/ayaneo-ec.c
> > index 90b86527ab0d..8b1902706b81 100644
> > --- a/drivers/platform/x86/ayaneo-ec.c
> > +++ b/drivers/platform/x86/ayaneo-ec.c
> > @@ -7,13 +7,23 @@
> >    * Copyright (C) 2025 Antheas Kapenekakis <lkml@antheas.dev>
> >    */
> >
> > +#include <linux/acpi.h>
> >   #include <linux/dmi.h>
> > +#include <linux/hwmon.h>
> >   #include <linux/init.h>
> >   #include <linux/kernel.h>
> >   #include <linux/module.h>
> >   #include <linux/platform_device.h>
> >
> > +#define AYANEO_PWM_ENABLE_REG         0x4A
> > +#define AYANEO_PWM_REG                0x4B
> > +#define AYANEO_PWM_MODE_AUTO  0x00
> > +#define AYANEO_PWM_MODE_MANUAL        0x01
> > +
> > +#define AYANEO_FAN_REG                0x76
> > +
> >   struct ayaneo_ec_quirk {
> > +     bool has_fan_control;
> >   };
> >
> >   struct ayaneo_ec_platform_data {
> > @@ -22,6 +32,7 @@ struct ayaneo_ec_platform_data {
> >   };
> >
> >   static const struct ayaneo_ec_quirk ayaneo3 = {
> > +     .has_fan_control = true,
> >   };
> >
> >   static const struct dmi_system_id dmi_table[] = {
> > @@ -35,10 +46,124 @@ static const struct dmi_system_id dmi_table[] = {
> >       {},
> >   };
> >
> > +/* Callbacks for hwmon interface */
> > +static umode_t ayaneo_ec_hwmon_is_visible(const void *drvdata,
> > +                                    enum hwmon_sensor_types type, u32 attr,
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
> > +static int ayaneo_ec_read(struct device *dev, enum hwmon_sensor_types type,
> > +                          u32 attr, int channel, long *val)
> > +{
> > +     u8 tmp;
> > +     int ret;
> > +
> > +     switch (type) {
> > +     case hwmon_fan:
> > +             switch (attr) {
> > +             case hwmon_fan_input:
> > +                     ret = ec_read(AYANEO_FAN_REG, &tmp);
> > +                     if (ret)
> > +                             return ret;
> > +                     *val = tmp << 8;
> > +                     ret = ec_read(AYANEO_FAN_REG + 1, &tmp);
> > +                     if (ret)
> > +                             return ret;
> > +                     *val += tmp;
> > +                     return 0;
> > +             default:
> > +                     break;
> > +             }
> > +             break;
> > +     case hwmon_pwm:
> > +             switch (attr) {
> > +             case hwmon_pwm_input:
> > +                     ret = ec_read(AYANEO_PWM_REG, &tmp);
> > +                     if (ret)
> > +                             return ret;
> > +                     *val = (255 * tmp) / 100;
> > +                     if (*val < 0 || *val > 255)
> > +                             return -EINVAL;
> > +                     return 0;
> > +             case hwmon_pwm_enable:
> > +                     ret = ec_read(AYANEO_PWM_ENABLE_REG, &tmp);
> > +                     if (ret)
> > +                             return ret;
> > +                     if (tmp == AYANEO_PWM_MODE_MANUAL)
> > +                             *val = 1;
> > +                     else
> > +                             *val = 2;
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
> > +static int ayaneo_ec_write(struct device *dev, enum hwmon_sensor_types type,
> > +                           u32 attr, int channel, long val)
> > +{
> > +     switch (type) {
> > +     case hwmon_pwm:
> > +             switch (attr) {
> > +             case hwmon_pwm_enable:
> > +                     if (val == 1)
> > +                             return ec_write(AYANEO_PWM_ENABLE_REG,
> > +                                             AYANEO_PWM_MODE_MANUAL);
> > +                     else if (val == 2)
> > +                             return ec_write(AYANEO_PWM_ENABLE_REG,
> > +                                             AYANEO_PWM_MODE_AUTO);
> > +                     else
> > +                             return -EINVAL;
>
> Consider using a switch statement here.
>
> > +             case hwmon_pwm_input:
> > +                     if (val < 0 || val > 255)
> > +                             return -EINVAL;
> > +                     return ec_write(AYANEO_PWM_REG, (val * 100) / 255);
>
> Better use fixp_linear_interpolate() for that. Also you need to restore those registers
> after suspend. I suggest that you use regmap for that.

The registers appear to maintain their state after sleep. If I get a
report that some devices do not, I will amend the driver with a
suspend hook.

ack on the interpolate.

Antheas

> Thanks,
> Armin Wolf
>
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
> > +static const struct hwmon_ops ayaneo_ec_hwmon_ops = {
> > +     .is_visible = ayaneo_ec_hwmon_is_visible,
> > +     .read = ayaneo_ec_read,
> > +     .write = ayaneo_ec_write,
> > +};
> > +
> > +static const struct hwmon_channel_info *const ayaneo_ec_sensors[] = {
> > +     HWMON_CHANNEL_INFO(fan, HWMON_F_INPUT),
> > +     HWMON_CHANNEL_INFO(pwm, HWMON_PWM_INPUT | HWMON_PWM_ENABLE),
> > +     NULL,
> > +};
> > +
> > +static const struct hwmon_chip_info ayaneo_ec_chip_info = {
> > +     .ops = &ayaneo_ec_hwmon_ops,
> > +     .info = ayaneo_ec_sensors,
> > +};
> > +
> >   static int ayaneo_ec_probe(struct platform_device *pdev)
> >   {
> >       const struct dmi_system_id *dmi_entry;
> >       struct ayaneo_ec_platform_data *data;
> > +     struct device *hwdev;
> >
> >       dmi_entry = dmi_first_match(dmi_table);
> >       if (!dmi_entry)
> > @@ -52,6 +177,13 @@ static int ayaneo_ec_probe(struct platform_device *pdev)
> >       data->quirks = dmi_entry->driver_data;
> >       platform_set_drvdata(pdev, data);
> >
> > +     if (data->quirks->has_fan_control) {
> > +             hwdev = devm_hwmon_device_register_with_info(
> > +                     &pdev->dev, "ayaneo_ec", NULL, &ayaneo_ec_chip_info, NULL);
> > +             if (IS_ERR(hwdev))
> > +                     return PTR_ERR(hwdev);
> > +     }
> > +
> >       return 0;
> >   }
> >
>


