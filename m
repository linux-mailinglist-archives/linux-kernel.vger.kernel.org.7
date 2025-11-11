Return-Path: <linux-kernel+bounces-896225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 58A3AC4FE8D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 22:46:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12BC43BB14D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 21:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A5AA3546E9;
	Tue, 11 Nov 2025 21:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="OtK0GA7d"
Received: from relay13.grserver.gr (relay13.grserver.gr [178.156.171.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3358033D6D6
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 21:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.156.171.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762897427; cv=none; b=RSLA6G2IyQhOT3M1FjqYlvnPlL7ABIk+YehHpSKpnvz9lmGDUjoRklLTiwus0fRmGKafsf/eoZpXluZ2zjLBM0HdXg50c0dSJ3diA3OW0U0Doo3wF/FTkJndBfQV8nUBgmVF692dqSyhNtKlz27JG68TP1ecZ1bkaOvFjBKfhRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762897427; c=relaxed/simple;
	bh=O/SuGiAzHSSRRKVxWeuyO8lLFqaT1aW144KUCX0TpTE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aQiR7FgxkU/KTPiZgA7DkCaPxOIgvtbrBDHjmHMFOdxSlRmVFCAxiAePLDCs5eIjpGKJzp+n6r3RJdeg6TLtEtax5MiRnpxGyFiJPW2mQ3gt3rWkbPYzpW4I6aHeSKnf6ooMsekKRurmZXKuZlJLHA+++bg0V11aGl5TicqHdzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=temperror (0-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=OtK0GA7d; arc=none smtp.client-ip=178.156.171.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from relay13 (localhost [127.0.0.1])
	by relay13.grserver.gr (Proxmox) with ESMTP id CF32D5E4D8
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 23:43:36 +0200 (EET)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by relay13.grserver.gr (Proxmox) with ESMTPS id 223F35E07A
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 23:43:35 +0200 (EET)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	by linux3247.grserver.gr (Postfix) with ESMTPSA id 2C88F201C52
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 23:43:34 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1762897414;
	bh=58N4AkF/62rPzXyucAbag0c8oNPiWsFpePIz6U6wsgI=;
	h=Received:From:Subject:To;
	b=OtK0GA7dP9aR9tqMClguUex3B7McacL7fFJeELlYmN+tWVhvuv1QZT8A+SwScBbPV
	 vcY2pvBc7kV99hkarshNB1016nzBn648bzq48Vtj1eV5E2XOBVH+VtU2kOAxlEDbW4
	 UxTaVe2PIc97oYajabnqb6/JIDrgZCMqBYhImVh4X5ymZhkRqiVeb4tI4d0RJF/PF8
	 Tp24yHmpLAjRfsuDNFReWzW97fie1H8S8QFtdGqYexu/bEY1BcCTk43CP1qn4Wofw/
	 ib7BPXJdoQ8PkLv+PVBrGuDupIyo2oYSTyT7RuG290Xs0Ic0Ot9cii+CqgMVhPkRRp
	 bewLcQCl9vUcg==
Authentication-Results: linux3247.grserver.gr;
        spf=pass (sender IP is 209.85.208.169) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-lj1-f169.google.com
Received-SPF: pass (linux3247.grserver.gr: connection is authenticated)
Received: by mail-lj1-f169.google.com with SMTP id
 38308e7fff4ca-3737d0920e6so1777981fa.1
        for <linux-kernel@vger.kernel.org>;
 Tue, 11 Nov 2025 13:43:34 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCW9mPznFWs5ckcf/PcAA+EjpMH5am0g5hFK+MbjMgo+j1n9ovM1ZWQ46+RqNiU1ZXWXC4SKOKp0kla7sjw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTrtMAlabML6PJ3PFZcuw54XURCgSwQiWeaRE3AuI8/H/bS9fF
	XVCgC8a8OXUKRbxy9ZIPtcGHT5L9hMtNqUTUT6vBrKkotg0lWR2CYdWYqvqN0ty7ybldf30Isgm
	cCNSeh5hFxXv8dDQAb/1GUl37RjNjuqQ=
X-Google-Smtp-Source: 
 AGHT+IGjfVwzo/NpSCS45EieYVk2quw1vfmQyvqD3hNZwEOU/CQRP2qOp3AJ0hd3wDCrSVybTShJ9ZiZS//r21Qvqc0=
X-Received: by 2002:a2e:3a08:0:b0:37a:323c:3641 with SMTP id
 38308e7fff4ca-37b8c2e1713mr1783491fa.1.1762897413619; Tue, 11 Nov 2025
 13:43:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251110180846.1490726-1-lkml@antheas.dev>
 <20251110180846.1490726-5-lkml@antheas.dev>
 <888ff0d3-c613-b5a7-3b84-37ff3036e0a4@linux.intel.com>
In-Reply-To: <888ff0d3-c613-b5a7-3b84-37ff3036e0a4@linux.intel.com>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Tue, 11 Nov 2025 22:43:22 +0100
X-Gmail-Original-Message-ID: 
 <CAGwozwE7rSw43tKoStmcmwR3mup5bS0Btk0R3hr0XTwSus4A-w@mail.gmail.com>
X-Gm-Features: AWmQ_bn4UUWv7X6aph3NasS4pQ4HaEu1rsbZ0ni5h-plq3WZBhJwb6QSU0Encm8
Message-ID: 
 <CAGwozwE7rSw43tKoStmcmwR3mup5bS0Btk0R3hr0XTwSus4A-w@mail.gmail.com>
Subject: Re: [PATCH v4 4/6] platform/x86: ayaneo-ec: Add controller power and
 modules attributes
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
	linux-hwmon@vger.kernel.org, Hans de Goede <hansg@kernel.org>,
	Derek John Clark <derekjohn.clark@gmail.com>,
	=?UTF-8?Q?Joaqu=C3=ADn_Ignacio_Aramend=C3=ADa?= <samsagax@gmail.com>,
	Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>,
 Armin Wolf <W_Armin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-PPP-Message-ID: 
 <176289741434.2183670.14458628331899579687@linux3247.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 1.4.3 at linux3247.grserver.gr
X-Virus-Status: Clean

On Tue, 11 Nov 2025 at 14:41, Ilpo J=C3=A4rvinen
<ilpo.jarvinen@linux.intel.com> wrote:
>
> On Mon, 10 Nov 2025, Antheas Kapenekakis wrote:
>
> > The Ayaneo 3 features hot-swappable controller modules. The ejection
> > and management is done through HID. However, after ejecting the modules=
,
> > the controller needs to be power cycled via the EC to re-initialize.
> >
> > For this, the EC provides a variable that holds whether the left or
> > right modules are connected, and a power control register to turn
> > the controller on or off. After ejecting the modules, the controller
> > should be turned off. Then, after both modules are reinserted,
> > the controller may be powered on again to re-initialize.
> >
> > This patch introduces two new sysfs attributes:
> >  - `controller_modules`: a read-only attribute that indicates whether
> >    the left and right modules are connected (none, left, right, both).
> >  - `controller_power`: a read-write attribute that allows the user
> >    to turn the controller on or off (with '1'/'0').
> >
> > Therefore, after ejection is complete, userspace can power off the
> > controller, then wait until both modules have been reinserted
> > (`controller_modules` will return 'both') to turn on the controller.
> >
> > Reviewed-by: Armin Wolf <W_Armin@gmx.de>
> > Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
> > ---
> >  .../ABI/testing/sysfs-platform-ayaneo-ec      |  19 ++++
> >  MAINTAINERS                                   |   1 +
> >  drivers/platform/x86/ayaneo-ec.c              | 106 ++++++++++++++++++
> >  3 files changed, 126 insertions(+)
> >  create mode 100644 Documentation/ABI/testing/sysfs-platform-ayaneo-ec
> >
> > diff --git a/Documentation/ABI/testing/sysfs-platform-ayaneo-ec b/Docum=
entation/ABI/testing/sysfs-platform-ayaneo-ec
> > new file mode 100644
> > index 000000000000..4cffbf5fc7ca
> > --- /dev/null
> > +++ b/Documentation/ABI/testing/sysfs-platform-ayaneo-ec
> > @@ -0,0 +1,19 @@
> > +What:                /sys/devices/platform/ayaneo-ec/controller_power
> > +Date:                Nov 2025
> > +KernelVersion:       6.19
> > +Contact:     "Antheas Kapenekakis" <lkml@antheas.dev>
> > +Description:
> > +             Current controller power state. Allows turning on and off
> > +             the controller power (e.g. for power savings). Write 1 to
> > +             turn on, 0 to turn off. File is readable and writable.
> > +
> > +What:                /sys/devices/platform/ayaneo-ec/controller_module=
s
> > +Date:                Nov 2025
> > +KernelVersion:       6.19
> > +Contact:     "Antheas Kapenekakis"  <lkml@antheas.dev>
> > +Description:
> > +             Shows which controller modules are currently connected to
> > +             the device. Possible values are "left", "right" and "both=
".
> > +             File is read-only. The Windows software for this device
> > +             will only set controller power to 1 if both module sides
> > +             are connected (i.e. this file returns "both").
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index c5bf7207c45f..f8ab009b6224 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -4196,6 +4196,7 @@ AYANEO PLATFORM EC DRIVER
> >  M:   Antheas Kapenekakis <lkml@antheas.dev>
> >  L:   platform-driver-x86@vger.kernel.org
> >  S:   Maintained
> > +F:   Documentation/ABI/testing/sysfs-platform-ayaneo
> >  F:   drivers/platform/x86/ayaneo-ec.c
> >
> >  AZ6007 DVB DRIVER
> > diff --git a/drivers/platform/x86/ayaneo-ec.c b/drivers/platform/x86/ay=
aneo-ec.c
> > index 697bb053a7d6..0652c044ad76 100644
> > --- a/drivers/platform/x86/ayaneo-ec.c
> > +++ b/drivers/platform/x86/ayaneo-ec.c
> > @@ -8,6 +8,7 @@
> >   */
> >
> >  #include <linux/acpi.h>
> > +#include <linux/bits.h>
> >  #include <linux/dmi.h>
> >  #include <linux/err.h>
> >  #include <linux/hwmon.h>
> > @@ -16,6 +17,7 @@
> >  #include <linux/module.h>
> >  #include <linux/platform_device.h>
> >  #include <linux/power_supply.h>
> > +#include <linux/sysfs.h>
> >  #include <acpi/battery.h>
> >
> >  #define AYANEO_PWM_ENABLE_REG         0x4A
> > @@ -32,9 +34,17 @@
> >  #define AYANEO_CHARGE_VAL_AUTO               0xaa
> >  #define AYANEO_CHARGE_VAL_INHIBIT    0x55
> >
> > +#define AYANEO_POWER_REG     0x2d
> > +#define AYANEO_POWER_OFF     0xfe
> > +#define AYANEO_POWER_ON              0xff
> > +#define AYANEO_MODULE_REG    0x2f
> > +#define AYANEO_MODULE_LEFT   BIT(0)
> > +#define AYANEO_MODULE_RIGHT  BIT(1)
> > +
> >  struct ayaneo_ec_quirk {
> >       bool has_fan_control;
> >       bool has_charge_control;
> > +     bool has_magic_modules;
> >  };
> >
> >  struct ayaneo_ec_platform_data {
> > @@ -46,6 +56,7 @@ struct ayaneo_ec_platform_data {
> >  static const struct ayaneo_ec_quirk quirk_ayaneo3 =3D {
> >       .has_fan_control =3D true,
> >       .has_charge_control =3D true,
> > +     .has_magic_modules =3D true,
> >  };
> >
> >  static const struct dmi_system_id dmi_table[] =3D {
> > @@ -266,6 +277,100 @@ static int ayaneo_remove_battery(struct power_sup=
ply *battery,
> >       return 0;
> >  }
> >
> > +static ssize_t controller_power_store(struct device *dev,
> > +                                   struct device_attribute *attr,
> > +                                   const char *buf,
> > +                                   size_t count)
> > +{
> > +     bool value;
> > +     int ret;
> > +
> > +     ret =3D kstrtobool(buf, &value);
> > +     if (ret)
> > +             return ret;
> > +
> > +     ret =3D ec_write(AYANEO_POWER_REG, value ? AYANEO_POWER_ON : AYAN=
EO_POWER_OFF);
> > +     if (ret)
> > +             return ret;
> > +
> > +     return count;
> > +}
> > +
> > +static ssize_t controller_power_show(struct device *dev,
> > +                                  struct device_attribute *attr,
> > +                                  char *buf)
> > +{
> > +     int ret;
> > +     u8 val;
> > +
> > +     ret =3D ec_read(AYANEO_POWER_REG, &val);
> > +     if (ret)
> > +             return ret;
> > +
> > +     return sysfs_emit(buf, "%d\n", val =3D=3D AYANEO_POWER_ON);
> > +}
> > +
> > +static DEVICE_ATTR_RW(controller_power);
> > +
> > +static ssize_t controller_modules_show(struct device *dev,
> > +                                    struct device_attribute *attr, cha=
r *buf)
> > +{
> > +     char *out;
> > +     int ret;
> > +     u8 val;
> > +
> > +     ret =3D ec_read(AYANEO_MODULE_REG, &val);
> > +     if (ret)
> > +             return ret;
> > +
> > +     switch (~val & (AYANEO_MODULE_LEFT | AYANEO_MODULE_RIGHT)) {
>
> This too is constructing mask still here which is ugly.

I can bring back the bools :-)

I agree but that's what I came up with to remove them

> > +     case AYANEO_MODULE_LEFT | AYANEO_MODULE_RIGHT:
> > +             out =3D "both";
> > +             break;
> > +     case AYANEO_MODULE_LEFT:
> > +             out =3D "left";
> > +             break;
> > +     case AYANEO_MODULE_RIGHT:
> > +             out =3D "right";
> > +             break;
> > +     default:
> > +             out =3D "none";
> > +             break;
> > +     }
> > +
> > +     return sysfs_emit(buf, "%s\n", out);
> > +}
> > +
> > +static DEVICE_ATTR_RO(controller_modules);
> > +
> > +static struct attribute *aya_mm_attrs[] =3D {
> > +     &dev_attr_controller_power.attr,
> > +     &dev_attr_controller_modules.attr,
> > +     NULL
> > +};
> > +
> > +static umode_t aya_mm_is_visible(struct kobject *kobj,
> > +                              struct attribute *attr, int n)
> > +{
> > +     struct device *dev =3D kobj_to_dev(kobj);
> > +     struct platform_device *pdev =3D to_platform_device(dev);
> > +     struct ayaneo_ec_platform_data *data =3D platform_get_drvdata(pde=
v);
> > +
> > +     if (data->quirks->has_magic_modules)
> > +             return attr->mode;
> > +     return 0;
> > +}
> > +
> > +static const struct attribute_group aya_mm_attribute_group =3D {
> > +     .is_visible =3D aya_mm_is_visible,
> > +     .attrs =3D aya_mm_attrs,
> > +};
> > +
> > +static const struct attribute_group *ayaneo_ec_groups[] =3D {
> > +     &aya_mm_attribute_group,
> > +     NULL
> > +};
> > +
> >  static int ayaneo_ec_probe(struct platform_device *pdev)
> >  {
> >       const struct dmi_system_id *dmi_entry;
> > @@ -307,6 +412,7 @@ static int ayaneo_ec_probe(struct platform_device *=
pdev)
> >  static struct platform_driver ayaneo_platform_driver =3D {
> >       .driver =3D {
> >               .name =3D "ayaneo-ec",
> > +             .dev_groups =3D ayaneo_ec_groups,
> >       },
> >       .probe =3D ayaneo_ec_probe,
> >  };
> >
>
> --
>  i.
>
>


