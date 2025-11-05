Return-Path: <linux-kernel+bounces-886456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84459C35AAA
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 13:34:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09A38466105
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 12:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDF16313E0E;
	Wed,  5 Nov 2025 12:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="LkUUQwYD"
Received: from relay12.grserver.gr (relay12.grserver.gr [88.99.38.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65BE72EB5CF
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 12:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=88.99.38.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762346048; cv=none; b=d73KqMSxlr7RU63poDbYXg1N98G37JttLyHftV5WruPc2ixyovGbsuTyxScGJ7ic3rKv1rFrJjJEdDp3+QjlVrb8eiHQ+cwIh8qTMmS2ORWIuUN4jIJJnLKyINfYzLibvrYVKEI6bg57Ft+fO/1Xt13ngUAHjqlJKjDmvDb9LbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762346048; c=relaxed/simple;
	bh=K2yWi6mDKbN0tfTM3bPsZiYuELPkjPpLjGsyVrFhO7w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eZg2EPFzjuzdrySGz3YKrwgf7nltoAAULGi9ttGdWoefU5wX+GWe/rNSfeivh87k2mSDLai9p6ylicTzDdbeD5pYs7TJkYIFjkE3G2LHdgXqEcrSSpuD1SshTDj7yEW8M8Rd4BYHzgYVub4RhTjeg+IwRZ3OoCFXN3LRji0vJpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=temperror (0-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=LkUUQwYD; arc=none smtp.client-ip=88.99.38.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from relay12 (localhost [127.0.0.1])
	by relay12.grserver.gr (Proxmox) with ESMTP id CEE86BDD94
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 14:33:57 +0200 (EET)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by relay12.grserver.gr (Proxmox) with ESMTPS id 692BBBDFE9
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 14:33:56 +0200 (EET)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	by linux3247.grserver.gr (Postfix) with ESMTPSA id 2597A1FE9DE
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 14:33:55 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1762346035;
	bh=3Ck5mfa/27W6TfoFZjiJPc87plpEJITq7ig75Z6X2A0=;
	h=Received:From:Subject:To;
	b=LkUUQwYDJ7X2TEqBGZJqNrToR5aGdpBwF7dOy6+uQmtnc1BH3mL5L5SllxbmiAwan
	 rohqpAVIHCwj5PMPeMIEGw1E7j0AFO4B/FLmlUZpxl8b1PEYMMR8z1fXXtefWpch3H
	 tXFG5qXmkz2bHGqmt1FAe5uyJ5SgEQnto0zZDsRGFPqxT1VESHoN/eIKkhpzE+un9R
	 am6TtPUX89gqgHd0z6gEgSOhGXV21l97fiqXysZ1h+vi7cfL80GplaxhCbJCeEHnok
	 1E5oDkf3uRgM3eAr5nkaajPnOxYcVCwK2WeVtD5wT9HUObMpIlJjwMUZmoEbDsRTin
	 CAqk6ZME6Owzw==
Authentication-Results: linux3247.grserver.gr;
        spf=pass (sender IP is 209.85.208.179) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-lj1-f179.google.com
Received-SPF: pass (linux3247.grserver.gr: connection is authenticated)
Received: by mail-lj1-f179.google.com with SMTP id
 38308e7fff4ca-378cffe5e1aso35995391fa.2
        for <linux-kernel@vger.kernel.org>;
 Wed, 05 Nov 2025 04:33:55 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCUblQT9leU/X22Xt9NLMojEC90EKvEsu1iNNAahBosi+oyqmuITiW77Cq8WxwlOwYc2IJQ8wNUK04qVbPU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRtKuuU+5Jpt+keJ6PGtyvf6BfyW/WS7PZx0Dk/LJnvFMAYq0O
	RbWlH1DXdhYTOLyOuWjapWCCjBNcWYui6OaAb7NWM88UCpGCDod1cjXsAfOkgCokDlKmlsIUO7O
	WMT5nIY+0HRY2CtE78G610JhmFReNk0E=
X-Google-Smtp-Source: 
 AGHT+IF93Zc/0fi8e/l73s5MwKxQ7O6Kos8iH+3S31Jcj0SgCWZ+ZwaKQJTERQwct3jIB+Gk4E7a7cPrQTDhZ+jYym8=
X-Received: by 2002:a05:651c:4009:b0:37a:4c29:3aaa with SMTP id
 38308e7fff4ca-37a513e7296mr6541951fa.12.1762346034524; Wed, 05 Nov 2025
 04:33:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251031163651.1465981-1-lkml@antheas.dev>
 <20251031163651.1465981-5-lkml@antheas.dev>
 <7c521e72-1b32-4172-90ec-6e793941a8ed@gmx.de>
 <CAGwozwFRF11dH02SRRNCyiYW7dNuoYoGWfPdEWPoim2r-KoZ0g@mail.gmail.com>
 <e0b29b59-b37d-4c44-ab97-9527b0f959b1@gmx.de>
In-Reply-To: <e0b29b59-b37d-4c44-ab97-9527b0f959b1@gmx.de>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Wed, 5 Nov 2025 13:33:43 +0100
X-Gmail-Original-Message-ID: 
 <CAGwozwFJiQeD3kCd-=vkkt4wcjwhL=ETaY7br+7+B7KdNXSL2w@mail.gmail.com>
X-Gm-Features: AWmQ_bl171p_2Z7F93USCA5AjAJlEhpEhBJLh2MTQb2QId8783pOywBHm2cYXgQ
Message-ID: 
 <CAGwozwFJiQeD3kCd-=vkkt4wcjwhL=ETaY7br+7+B7KdNXSL2w@mail.gmail.com>
Subject: Re: [PATCH v3 4/6] platform/x86: ayaneo-ec: Add controller power and
 modules attributes
To: Armin Wolf <W_Armin@gmx.de>
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hwmon@vger.kernel.org, Hans de Goede <hansg@kernel.org>,
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Derek John Clark <derekjohn.clark@gmail.com>,
	=?UTF-8?Q?Joaqu=C3=ADn_Ignacio_Aramend=C3=ADa?= <samsagax@gmail.com>,
	Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
X-PPP-Message-ID: 
 <176234603577.716796.16687060229128348945@linux3247.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 1.4.3 at linux3247.grserver.gr
X-Virus-Status: Clean

On Tue, 4 Nov 2025 at 21:04, Armin Wolf <W_Armin@gmx.de> wrote:
>
> Am 02.11.25 um 19:46 schrieb Antheas Kapenekakis:
>
> > On Sun, 2 Nov 2025 at 19:30, Armin Wolf <W_Armin@gmx.de> wrote:
> >> Am 31.10.25 um 17:36 schrieb Antheas Kapenekakis:
> >>
> >>> The Ayaneo 3 features hot-swappable controller modules. The ejection
> >>> and management is done through HID. However, after ejecting the modules,
> >>> the controller needs to be power cycled via the EC to re-initialize.
> >>>
> >>> For this, the EC provides a variable that holds whether the left or
> >>> right modules are connected, and a power control register to turn
> >>> the controller on or off. After ejecting the modules, the controller
> >>> should be turned off. Then, after both modules are reinserted,
> >>> the controller may be powered on again to re-initialize.
> >>>
> >>> This patch introduces two new sysfs attributes:
> >>>    - `controller_modules`: a read-only attribute that indicates whether
> >>>      the left and right modules are connected (none, left, right, both).
> >>>    - `controller_power`: a read-write attribute that allows the user
> >>>      to turn the controller on or off (with '1'/'0').
> >>>
> >>> Therefore, after ejection is complete, userspace can power off the
> >>> controller, then wait until both modules have been reinserted
> >>> (`controller_modules` will return 'both') to turn on the controller.
> >>>
> >>> Reviewed-by: Armin Wolf <W_Armin@gmx.de>
> >>> Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
> >>> ---
> >>>    .../ABI/testing/sysfs-platform-ayaneo-ec      |  19 ++++
> >>>    MAINTAINERS                                   |   1 +
> >>>    drivers/platform/x86/ayaneo-ec.c              | 106 ++++++++++++++++++
> >>>    3 files changed, 126 insertions(+)
> >>>    create mode 100644 Documentation/ABI/testing/sysfs-platform-ayaneo-ec
> >>>
> >>> diff --git a/Documentation/ABI/testing/sysfs-platform-ayaneo-ec b/Documentation/ABI/testing/sysfs-platform-ayaneo-ec
> >>> new file mode 100644
> >>> index 000000000000..3c9c3580c685
> >>> --- /dev/null
> >>> +++ b/Documentation/ABI/testing/sysfs-platform-ayaneo-ec
> >>> @@ -0,0 +1,19 @@
> >>> +What:                /sys/devices/platform/ayaneo-ec/controller_power
> >>> +Date:                Oct 2025
> >> I think you need to update those dates.
> >>
> >>> +KernelVersion:       6.19
> >>> +Contact:     "Antheas Kapenekakis" <lkml@antheas.dev>
> >>> +Description:
> >>> +             Current controller power state. Allows turning on and off
> >>> +             the controller power (e.g. for power savings). Write 1 to
> >>> +             turn on, 0 to turn off. File is readable and writable.
> >>> +
> >>> +What:                /sys/devices/platform/ayaneo-ec/controller_modules
> >>> +Date:                Oct 2025
> >>> +KernelVersion:       6.19
> >>> +Contact:     "Antheas Kapenekakis"  <lkml@antheas.dev>
> >>> +Description:
> >>> +             Shows which controller modules are currently connected to
> >>> +             the device. Possible values are "left", "right" and "both".
> >>> +             File is read-only. The Windows software for this device
> >>> +             will only set controller power to 1 if both module sides
> >>> +             are connected (i.e. this file returns "both").
> >>> diff --git a/MAINTAINERS b/MAINTAINERS
> >>> index da9498d8cc89..b4d62ea9a926 100644
> >>> --- a/MAINTAINERS
> >>> +++ b/MAINTAINERS
> >>> @@ -4191,6 +4191,7 @@ AYANEO PLATFORM EC DRIVER
> >>>    M:  Antheas Kapenekakis <lkml@antheas.dev>
> >>>    L:  platform-driver-x86@vger.kernel.org
> >>>    S:  Maintained
> >>> +F:   Documentation/ABI/testing/sysfs-platform-ayaneo
> >>>    F:  drivers/platform/x86/ayaneo-ec.c
> >>>
> >>>    AZ6007 DVB DRIVER
> >>> diff --git a/drivers/platform/x86/ayaneo-ec.c b/drivers/platform/x86/ayaneo-ec.c
> >>> index 697bb053a7d6..0652c044ad76 100644
> >>> --- a/drivers/platform/x86/ayaneo-ec.c
> >>> +++ b/drivers/platform/x86/ayaneo-ec.c
> >>> @@ -8,6 +8,7 @@
> >>>     */
> >>>
> >>>    #include <linux/acpi.h>
> >>> +#include <linux/bits.h>
> >>>    #include <linux/dmi.h>
> >>>    #include <linux/err.h>
> >>>    #include <linux/hwmon.h>
> >>> @@ -16,6 +17,7 @@
> >>>    #include <linux/module.h>
> >>>    #include <linux/platform_device.h>
> >>>    #include <linux/power_supply.h>
> >>> +#include <linux/sysfs.h>
> >>>    #include <acpi/battery.h>
> >>>
> >>>    #define AYANEO_PWM_ENABLE_REG        0x4A
> >>> @@ -32,9 +34,17 @@
> >>>    #define AYANEO_CHARGE_VAL_AUTO              0xaa
> >>>    #define AYANEO_CHARGE_VAL_INHIBIT   0x55
> >>>
> >>> +#define AYANEO_POWER_REG     0x2d
> >>> +#define AYANEO_POWER_OFF     0xfe
> >>> +#define AYANEO_POWER_ON              0xff
> >>> +#define AYANEO_MODULE_REG    0x2f
> >>> +#define AYANEO_MODULE_LEFT   BIT(0)
> >>> +#define AYANEO_MODULE_RIGHT  BIT(1)
> >> Using GENMASK() would make sense here.
> > Only a single bit is being used though? GENMASK is used for a contiguous series?
>
> I was thinking of using GENMASK() for both bits:
>
> #define AYANEO_MODULE_MASK      GENMASK(1, 0)
>
> You can then retrieve both bits using FIELD_GET() and simply use a switch statement
> together with an enum in controller_modules_show().

I will look at it closer if I revise the first 5 patches. The logic of
the register is complicated due to the flip, so I would not be eager
to.

I could do #define AYANEO_MODULE_MASK (AYANEO_MODULE_LEFT |
AYANEO_MODULE_RIGHT) for stylistic reasons.

@Ilpo: for the first 5 of this series is there something missing other
than perhaps the month? If not, I can respin the last patch on its own
later today. I would like this driver + the asus stuff to go into 6.19
if possible (there: i dealt with the asusctl bug by skipping the
quirk), I am unsure for the timeline for that. I want to say merge
window starts in two weeks?

Antheas

> Thanks,
> Armin Wolf
>
> >> With those issues being fixed:
> >> Reviewed-by: Armin Wolf <W_Armin@gmx.de>
> >>
> >>> +
> >>>    struct ayaneo_ec_quirk {
> >>>        bool has_fan_control;
> >>>        bool has_charge_control;
> >>> +     bool has_magic_modules;
> >>>    };
> >>>
> >>>    struct ayaneo_ec_platform_data {
> >>> @@ -46,6 +56,7 @@ struct ayaneo_ec_platform_data {
> >>>    static const struct ayaneo_ec_quirk quirk_ayaneo3 = {
> >>>        .has_fan_control = true,
> >>>        .has_charge_control = true,
> >>> +     .has_magic_modules = true,
> >>>    };
> >>>
> >>>    static const struct dmi_system_id dmi_table[] = {
> >>> @@ -266,6 +277,100 @@ static int ayaneo_remove_battery(struct power_supply *battery,
> >>>        return 0;
> >>>    }
> >>>
> >>> +static ssize_t controller_power_store(struct device *dev,
> >>> +                                   struct device_attribute *attr,
> >>> +                                   const char *buf,
> >>> +                                   size_t count)
> >>> +{
> >>> +     bool value;
> >>> +     int ret;
> >>> +
> >>> +     ret = kstrtobool(buf, &value);
> >>> +     if (ret)
> >>> +             return ret;
> >>> +
> >>> +     ret = ec_write(AYANEO_POWER_REG, value ? AYANEO_POWER_ON : AYANEO_POWER_OFF);
> >>> +     if (ret)
> >>> +             return ret;
> >>> +
> >>> +     return count;
> >>> +}
> >>> +
> >>> +static ssize_t controller_power_show(struct device *dev,
> >>> +                                  struct device_attribute *attr,
> >>> +                                  char *buf)
> >>> +{
> >>> +     int ret;
> >>> +     u8 val;
> >>> +
> >>> +     ret = ec_read(AYANEO_POWER_REG, &val);
> >>> +     if (ret)
> >>> +             return ret;
> >>> +
> >>> +     return sysfs_emit(buf, "%d\n", val == AYANEO_POWER_ON);
> >>> +}
> >>> +
> >>> +static DEVICE_ATTR_RW(controller_power);
> >>> +
> >>> +static ssize_t controller_modules_show(struct device *dev,
> >>> +                                    struct device_attribute *attr, char *buf)
> >>> +{
> >>> +     char *out;
> >>> +     int ret;
> >>> +     u8 val;
> >>> +
> >>> +     ret = ec_read(AYANEO_MODULE_REG, &val);
> >>> +     if (ret)
> >>> +             return ret;
> >>> +
> >>> +     switch (~val & (AYANEO_MODULE_LEFT | AYANEO_MODULE_RIGHT)) {
> >>> +     case AYANEO_MODULE_LEFT | AYANEO_MODULE_RIGHT:
> >>> +             out = "both";
> >>> +             break;
> >>> +     case AYANEO_MODULE_LEFT:
> >>> +             out = "left";
> >>> +             break;
> >>> +     case AYANEO_MODULE_RIGHT:
> >>> +             out = "right";
> >>> +             break;
> >>> +     default:
> >>> +             out = "none";
> >>> +             break;
> >>> +     }
> >>> +
> >>> +     return sysfs_emit(buf, "%s\n", out);
> >>> +}
> >>> +
> >>> +static DEVICE_ATTR_RO(controller_modules);
> >>> +
> >>> +static struct attribute *aya_mm_attrs[] = {
> >>> +     &dev_attr_controller_power.attr,
> >>> +     &dev_attr_controller_modules.attr,
> >>> +     NULL
> >>> +};
> >>> +
> >>> +static umode_t aya_mm_is_visible(struct kobject *kobj,
> >>> +                              struct attribute *attr, int n)
> >>> +{
> >>> +     struct device *dev = kobj_to_dev(kobj);
> >>> +     struct platform_device *pdev = to_platform_device(dev);
> >>> +     struct ayaneo_ec_platform_data *data = platform_get_drvdata(pdev);
> >>> +
> >>> +     if (data->quirks->has_magic_modules)
> >>> +             return attr->mode;
> >>> +     return 0;
> >>> +}
> >>> +
> >>> +static const struct attribute_group aya_mm_attribute_group = {
> >>> +     .is_visible = aya_mm_is_visible,
> >>> +     .attrs = aya_mm_attrs,
> >>> +};
> >>> +
> >>> +static const struct attribute_group *ayaneo_ec_groups[] = {
> >>> +     &aya_mm_attribute_group,
> >>> +     NULL
> >>> +};
> >>> +
> >>>    static int ayaneo_ec_probe(struct platform_device *pdev)
> >>>    {
> >>>        const struct dmi_system_id *dmi_entry;
> >>> @@ -307,6 +412,7 @@ static int ayaneo_ec_probe(struct platform_device *pdev)
> >>>    static struct platform_driver ayaneo_platform_driver = {
> >>>        .driver = {
> >>>                .name = "ayaneo-ec",
> >>> +             .dev_groups = ayaneo_ec_groups,
> >>>        },
> >>>        .probe = ayaneo_ec_probe,
> >>>    };
>


