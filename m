Return-Path: <linux-kernel+bounces-886538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41AF2C35E14
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 14:40:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CB013B9DEF
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 13:38:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 085FE2E2DFE;
	Wed,  5 Nov 2025 13:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="aKIKNvKA"
Received: from relay11.grserver.gr (relay11.grserver.gr [78.46.171.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B18E219A79
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 13:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.46.171.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762349922; cv=none; b=q9CRygzmdL8oPOI+vBA5hPTkm6VweeZyroDiVgrTW9krYh5MwyCVeK+sz3i7oLsl6IF359y7ztYPnTocSzEw6Wx+Z9giTFo7QUs+eXd4nWSQHQt2ksZQW8JQ9su6BScBoh7XHfZNmecrUkQOIm9cKVI2yqMw66d/pfhjLiB4EsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762349922; c=relaxed/simple;
	bh=9sTTN2rmgdR7RYZM9gBGQo2mQUWNTTJM50HIwEIB5ks=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O3uR9KyqaW9uC9+4DWbNNPBfupYslDh6r61rRq6/nX1lDC+rHyEgkFZ0b6bWm0s3glsdjUT1H5kpRqaSvcNlV3SLlw/iq39WNYjSCxiWK5L3sy21dRIQVTbb4oyaOh2oc7Y6DHGAV/RBbg9b0TA+RwTYnt8vn3Hr/o1w1gKLeLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=temperror (0-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=aKIKNvKA; arc=none smtp.client-ip=78.46.171.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from relay11 (localhost.localdomain [127.0.0.1])
	by relay11.grserver.gr (Proxmox) with ESMTP id A8A8BC370E
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 15:38:36 +0200 (EET)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by relay11.grserver.gr (Proxmox) with ESMTPS id 1580DC3747
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 15:38:35 +0200 (EET)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	by linux3247.grserver.gr (Postfix) with ESMTPSA id 71206201BCB
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 15:38:34 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1762349914;
	bh=ktusKQIN+ZSeJwMWzO3+6WWZAYX5kL+yyVazp2vUMBM=;
	h=Received:From:Subject:To;
	b=aKIKNvKAjPP15bqszEaRY9II8ke6o0m74W7Ef8IiXePsc/oiRXS9MSc/KzD1Yn+Bc
	 GVu0NLnB7srmm7MjhwmsWo5qfQ9xPkqd53moKxEoqb0DqK0a3nBzIXgN4GAXXLKWgN
	 VCGEb6RbSEnH0ULZjCY2hqVy9fpb9buesyAwOqPx+bu+gqTIC4f4QEy1doDcYtAJ8R
	 ytC8orWlPWv3hnzEyJokKcU5Lhne85rFNofQfxY7IArh8B5Vq+5g5dtcG52WrTs5Ku
	 7QmkifovijTa+6vX9Rj9LBOFwMAgG3fuQN+GeEppJ2+ga7vLMMjnZUdg2VdzgifWUJ
	 qrCC9JeA3QBvg==
Authentication-Results: linux3247.grserver.gr;
        spf=pass (sender IP is 209.85.208.179) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-lj1-f179.google.com
Received-SPF: pass (linux3247.grserver.gr: connection is authenticated)
Received: by mail-lj1-f179.google.com with SMTP id
 38308e7fff4ca-376466f1280so86812141fa.0
        for <linux-kernel@vger.kernel.org>;
 Wed, 05 Nov 2025 05:38:34 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCWO6nyrl5un2y2uk4QwRkjEL8zLCiPbydPz5iGGWShVXLBRLFDfjgwLdIS5UFGNlRjmwt6+6V5ZwlwO0BE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+tzmtL2m8nLkIi4y0q6+O+0noLiE8jIdjihvnvbdC+IsBqH+Q
	ZOz87eL1iWRARzvEDYkv/kH0Y6ZK6F2wEU0hE8YMpMGWntTt7DCFJyfnfuIC6Haga4tbaSv2O1t
	RqO4rxZWyg39mj0mhNcPKuzFWqiH3fqo=
X-Google-Smtp-Source: 
 AGHT+IFlsxFZr86rO3+aJyACsOSB5AXOWwj5lWh1ZzUnfsF8KlD1lcfmG8qpTESIdUNtQ66XL28dKU4uL5sPkCMXt4U=
X-Received: by 2002:a05:651c:2203:b0:37a:3ee3:988e with SMTP id
 38308e7fff4ca-37a51226149mr9344561fa.0.1762349913771; Wed, 05 Nov 2025
 05:38:33 -0800 (PST)
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
 <CAGwozwFJiQeD3kCd-=vkkt4wcjwhL=ETaY7br+7+B7KdNXSL2w@mail.gmail.com>
 <1e9d5311-45f9-15fa-ce3e-8098c288acbd@linux.intel.com>
In-Reply-To: <1e9d5311-45f9-15fa-ce3e-8098c288acbd@linux.intel.com>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Wed, 5 Nov 2025 14:38:21 +0100
X-Gmail-Original-Message-ID: 
 <CAGwozwGAAHZhc+1OtWX7Wa5OHbheAWxF8+C_iHLW3obqpVjEAg@mail.gmail.com>
X-Gm-Features: AWmQ_bkfsy61L-rOzkcRAj2fHlgU-eSxPps37PwRBesWUdv3YiBrki6NXfzC1xc
Message-ID: 
 <CAGwozwGAAHZhc+1OtWX7Wa5OHbheAWxF8+C_iHLW3obqpVjEAg@mail.gmail.com>
Subject: Re: [PATCH v3 4/6] platform/x86: ayaneo-ec: Add controller power and
 modules attributes
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Armin Wolf <W_Armin@gmx.de>, platform-driver-x86@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>, linux-hwmon@vger.kernel.org,
	Hans de Goede <hansg@kernel.org>,
 Derek John Clark <derekjohn.clark@gmail.com>,
	=?UTF-8?Q?Joaqu=C3=ADn_Ignacio_Aramend=C3=ADa?= <samsagax@gmail.com>,
	Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-PPP-Message-ID: 
 <176234991469.960835.2896391296227145624@linux3247.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 1.4.3 at linux3247.grserver.gr
X-Virus-Status: Clean

On Wed, 5 Nov 2025 at 14:25, Ilpo J=C3=A4rvinen
<ilpo.jarvinen@linux.intel.com> wrote:
>
> On Wed, 5 Nov 2025, Antheas Kapenekakis wrote:
>
> > On Tue, 4 Nov 2025 at 21:04, Armin Wolf <W_Armin@gmx.de> wrote:
> > >
> > > Am 02.11.25 um 19:46 schrieb Antheas Kapenekakis:
> > >
> > > > On Sun, 2 Nov 2025 at 19:30, Armin Wolf <W_Armin@gmx.de> wrote:
> > > >> Am 31.10.25 um 17:36 schrieb Antheas Kapenekakis:
> > > >>
> > > >>> The Ayaneo 3 features hot-swappable controller modules. The eject=
ion
> > > >>> and management is done through HID. However, after ejecting the m=
odules,
> > > >>> the controller needs to be power cycled via the EC to re-initiali=
ze.
> > > >>>
> > > >>> For this, the EC provides a variable that holds whether the left =
or
> > > >>> right modules are connected, and a power control register to turn
> > > >>> the controller on or off. After ejecting the modules, the control=
ler
> > > >>> should be turned off. Then, after both modules are reinserted,
> > > >>> the controller may be powered on again to re-initialize.
> > > >>>
> > > >>> This patch introduces two new sysfs attributes:
> > > >>>    - `controller_modules`: a read-only attribute that indicates w=
hether
> > > >>>      the left and right modules are connected (none, left, right,=
 both).
> > > >>>    - `controller_power`: a read-write attribute that allows the u=
ser
> > > >>>      to turn the controller on or off (with '1'/'0').
> > > >>>
> > > >>> Therefore, after ejection is complete, userspace can power off th=
e
> > > >>> controller, then wait until both modules have been reinserted
> > > >>> (`controller_modules` will return 'both') to turn on the controll=
er.
> > > >>>
> > > >>> Reviewed-by: Armin Wolf <W_Armin@gmx.de>
> > > >>> Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
> > > >>> ---
> > > >>>    .../ABI/testing/sysfs-platform-ayaneo-ec      |  19 ++++
> > > >>>    MAINTAINERS                                   |   1 +
> > > >>>    drivers/platform/x86/ayaneo-ec.c              | 106 ++++++++++=
++++++++
> > > >>>    3 files changed, 126 insertions(+)
> > > >>>    create mode 100644 Documentation/ABI/testing/sysfs-platform-ay=
aneo-ec
> > > >>>
> > > >>> diff --git a/Documentation/ABI/testing/sysfs-platform-ayaneo-ec b=
/Documentation/ABI/testing/sysfs-platform-ayaneo-ec
> > > >>> new file mode 100644
> > > >>> index 000000000000..3c9c3580c685
> > > >>> --- /dev/null
> > > >>> +++ b/Documentation/ABI/testing/sysfs-platform-ayaneo-ec
> > > >>> @@ -0,0 +1,19 @@
> > > >>> +What:                /sys/devices/platform/ayaneo-ec/controller_=
power
> > > >>> +Date:                Oct 2025
> > > >> I think you need to update those dates.
> > > >>
> > > >>> +KernelVersion:       6.19
> > > >>> +Contact:     "Antheas Kapenekakis" <lkml@antheas.dev>
> > > >>> +Description:
> > > >>> +             Current controller power state. Allows turning on a=
nd off
> > > >>> +             the controller power (e.g. for power savings). Writ=
e 1 to
> > > >>> +             turn on, 0 to turn off. File is readable and writab=
le.
> > > >>> +
> > > >>> +What:                /sys/devices/platform/ayaneo-ec/controller_=
modules
> > > >>> +Date:                Oct 2025
> > > >>> +KernelVersion:       6.19
> > > >>> +Contact:     "Antheas Kapenekakis"  <lkml@antheas.dev>
> > > >>> +Description:
> > > >>> +             Shows which controller modules are currently connec=
ted to
> > > >>> +             the device. Possible values are "left", "right" and=
 "both".
> > > >>> +             File is read-only. The Windows software for this de=
vice
> > > >>> +             will only set controller power to 1 if both module =
sides
> > > >>> +             are connected (i.e. this file returns "both").
> > > >>> diff --git a/MAINTAINERS b/MAINTAINERS
> > > >>> index da9498d8cc89..b4d62ea9a926 100644
> > > >>> --- a/MAINTAINERS
> > > >>> +++ b/MAINTAINERS
> > > >>> @@ -4191,6 +4191,7 @@ AYANEO PLATFORM EC DRIVER
> > > >>>    M:  Antheas Kapenekakis <lkml@antheas.dev>
> > > >>>    L:  platform-driver-x86@vger.kernel.org
> > > >>>    S:  Maintained
> > > >>> +F:   Documentation/ABI/testing/sysfs-platform-ayaneo
> > > >>>    F:  drivers/platform/x86/ayaneo-ec.c
> > > >>>
> > > >>>    AZ6007 DVB DRIVER
> > > >>> diff --git a/drivers/platform/x86/ayaneo-ec.c b/drivers/platform/=
x86/ayaneo-ec.c
> > > >>> index 697bb053a7d6..0652c044ad76 100644
> > > >>> --- a/drivers/platform/x86/ayaneo-ec.c
> > > >>> +++ b/drivers/platform/x86/ayaneo-ec.c
> > > >>> @@ -8,6 +8,7 @@
> > > >>>     */
> > > >>>
> > > >>>    #include <linux/acpi.h>
> > > >>> +#include <linux/bits.h>
> > > >>>    #include <linux/dmi.h>
> > > >>>    #include <linux/err.h>
> > > >>>    #include <linux/hwmon.h>
> > > >>> @@ -16,6 +17,7 @@
> > > >>>    #include <linux/module.h>
> > > >>>    #include <linux/platform_device.h>
> > > >>>    #include <linux/power_supply.h>
> > > >>> +#include <linux/sysfs.h>
> > > >>>    #include <acpi/battery.h>
> > > >>>
> > > >>>    #define AYANEO_PWM_ENABLE_REG        0x4A
> > > >>> @@ -32,9 +34,17 @@
> > > >>>    #define AYANEO_CHARGE_VAL_AUTO              0xaa
> > > >>>    #define AYANEO_CHARGE_VAL_INHIBIT   0x55
> > > >>>
> > > >>> +#define AYANEO_POWER_REG     0x2d
> > > >>> +#define AYANEO_POWER_OFF     0xfe
> > > >>> +#define AYANEO_POWER_ON              0xff
> > > >>> +#define AYANEO_MODULE_REG    0x2f
> > > >>> +#define AYANEO_MODULE_LEFT   BIT(0)
> > > >>> +#define AYANEO_MODULE_RIGHT  BIT(1)
> > > >> Using GENMASK() would make sense here.
> > > > Only a single bit is being used though? GENMASK is used for a conti=
guous series?
> > >
> > > I was thinking of using GENMASK() for both bits:
> > >
> > > #define AYANEO_MODULE_MASK      GENMASK(1, 0)
> > >
> > > You can then retrieve both bits using FIELD_GET() and simply use a sw=
itch statement
> > > together with an enum in controller_modules_show().
> >
> > I will look at it closer if I revise the first 5 patches. The logic of
> > the register is complicated due to the flip, so I would not be eager
> > to.
> >
> > I could do #define AYANEO_MODULE_MASK (AYANEO_MODULE_LEFT |
> > AYANEO_MODULE_RIGHT) for stylistic reasons.
>
> Hi,
>
> Quickly looking at the code below, a mask define certainly be useful to
> avoid having to embed that into the switch itself below.
>
> > @Ilpo: for the first 5 of this series is there something missing other
> > than perhaps the month? If not, I can respin the last patch on its own
> > later today. I would like this driver + the asus stuff to go into 6.19
> > if possible (there: i dealt with the asusctl bug by skipping the
> > quirk), I am unsure for the timeline for that. I want to say merge
> > window starts in two weeks?
>
> I've been sick for almost a week so I'm a bit lost with all the progress
> and status with various series so it takes time to catch up until can
> say something when it comes to any particular series (I'm sorry).
>
> However, we're only at -rc4 (since Nov 2) so there's 4 or 5 weeks until
> the merge window. And this is new driver so no regression potential other
> than build failures so I don't see big schedule pressure yet, tbh.
>
> I try to take it into the consideration with my review scheduling even
> under normal circumstances that submitters have the opportunity to make i=
t
> assuming one makes suggested changes (if any) in a reasonable time frame.
>
> It generally helps to pay attention to the kernel cycle as closer to the
> merge window we get, it usually helps to prioritize things right, e.g.,
> sending a series on the last week or close to it, getting trivial
> feedback, and not addressing it timely with an update will result in
> missing that kernel cycle; honestly, I always get a bit sad when I see
> people do that.
>

Good to know, so these are on track.

> > Antheas
> >
> > > Thanks,
> > > Armin Wolf
> > >
> > > >> With those issues being fixed:
> > > >> Reviewed-by: Armin Wolf <W_Armin@gmx.de>
> > > >>
> > > >>> +
> > > >>>    struct ayaneo_ec_quirk {
> > > >>>        bool has_fan_control;
> > > >>>        bool has_charge_control;
> > > >>> +     bool has_magic_modules;
> > > >>>    };
> > > >>>
> > > >>>    struct ayaneo_ec_platform_data {
> > > >>> @@ -46,6 +56,7 @@ struct ayaneo_ec_platform_data {
> > > >>>    static const struct ayaneo_ec_quirk quirk_ayaneo3 =3D {
> > > >>>        .has_fan_control =3D true,
> > > >>>        .has_charge_control =3D true,
> > > >>> +     .has_magic_modules =3D true,
> > > >>>    };
> > > >>>
> > > >>>    static const struct dmi_system_id dmi_table[] =3D {
> > > >>> @@ -266,6 +277,100 @@ static int ayaneo_remove_battery(struct pow=
er_supply *battery,
> > > >>>        return 0;
> > > >>>    }
> > > >>>
> > > >>> +static ssize_t controller_power_store(struct device *dev,
> > > >>> +                                   struct device_attribute *attr=
,
> > > >>> +                                   const char *buf,
> > > >>> +                                   size_t count)
> > > >>> +{
> > > >>> +     bool value;
> > > >>> +     int ret;
> > > >>> +
> > > >>> +     ret =3D kstrtobool(buf, &value);
> > > >>> +     if (ret)
> > > >>> +             return ret;
> > > >>> +
> > > >>> +     ret =3D ec_write(AYANEO_POWER_REG, value ? AYANEO_POWER_ON =
: AYANEO_POWER_OFF);
> > > >>> +     if (ret)
> > > >>> +             return ret;
> > > >>> +
> > > >>> +     return count;
> > > >>> +}
> > > >>> +
> > > >>> +static ssize_t controller_power_show(struct device *dev,
> > > >>> +                                  struct device_attribute *attr,
> > > >>> +                                  char *buf)
> > > >>> +{
> > > >>> +     int ret;
> > > >>> +     u8 val;
> > > >>> +
> > > >>> +     ret =3D ec_read(AYANEO_POWER_REG, &val);
> > > >>> +     if (ret)
> > > >>> +             return ret;
> > > >>> +
> > > >>> +     return sysfs_emit(buf, "%d\n", val =3D=3D AYANEO_POWER_ON);
> > > >>> +}
> > > >>> +
> > > >>> +static DEVICE_ATTR_RW(controller_power);
> > > >>> +
> > > >>> +static ssize_t controller_modules_show(struct device *dev,
> > > >>> +                                    struct device_attribute *att=
r, char *buf)
> > > >>> +{
> > > >>> +     char *out;
> > > >>> +     int ret;
> > > >>> +     u8 val;
> > > >>> +
> > > >>> +     ret =3D ec_read(AYANEO_MODULE_REG, &val);
> > > >>> +     if (ret)
> > > >>> +             return ret;
> > > >>> +
> > > >>> +     switch (~val & (AYANEO_MODULE_LEFT | AYANEO_MODULE_RIGHT)) =
{
>
> Why's the extra inversion here? Do those bits actually have the opposite
> meaning compared with their names?

The bits are active-low. So the register begins as 0xff, and when the
modules are plugged in, the respective bit turns to 0.

MODULE_LEFT/RIGHT are a bitmask so the defines are correct. They
cannot be flipped the other way.

It was a bit quirky to convert them into a switch statement.

Antheas

> --
>  i.
>
> > > >>> +     case AYANEO_MODULE_LEFT | AYANEO_MODULE_RIGHT:
> > > >>> +             out =3D "both";
> > > >>> +             break;
> > > >>> +     case AYANEO_MODULE_LEFT:
> > > >>> +             out =3D "left";
> > > >>> +             break;
> > > >>> +     case AYANEO_MODULE_RIGHT:
> > > >>> +             out =3D "right";
> > > >>> +             break;
> > > >>> +     default:
> > > >>> +             out =3D "none";
> > > >>> +             break;
> > > >>> +     }
> > > >>> +
> > > >>> +     return sysfs_emit(buf, "%s\n", out);
> > > >>> +}
> > > >>> +
> > > >>> +static DEVICE_ATTR_RO(controller_modules);
> > > >>> +
> > > >>> +static struct attribute *aya_mm_attrs[] =3D {
> > > >>> +     &dev_attr_controller_power.attr,
> > > >>> +     &dev_attr_controller_modules.attr,
> > > >>> +     NULL
> > > >>> +};
> > > >>> +
> > > >>> +static umode_t aya_mm_is_visible(struct kobject *kobj,
> > > >>> +                              struct attribute *attr, int n)
> > > >>> +{
> > > >>> +     struct device *dev =3D kobj_to_dev(kobj);
> > > >>> +     struct platform_device *pdev =3D to_platform_device(dev);
> > > >>> +     struct ayaneo_ec_platform_data *data =3D platform_get_drvda=
ta(pdev);
> > > >>> +
> > > >>> +     if (data->quirks->has_magic_modules)
> > > >>> +             return attr->mode;
> > > >>> +     return 0;
> > > >>> +}
> > > >>> +
> > > >>> +static const struct attribute_group aya_mm_attribute_group =3D {
> > > >>> +     .is_visible =3D aya_mm_is_visible,
> > > >>> +     .attrs =3D aya_mm_attrs,
> > > >>> +};
> > > >>> +
> > > >>> +static const struct attribute_group *ayaneo_ec_groups[] =3D {
> > > >>> +     &aya_mm_attribute_group,
> > > >>> +     NULL
> > > >>> +};
> > > >>> +
> > > >>>    static int ayaneo_ec_probe(struct platform_device *pdev)
> > > >>>    {
> > > >>>        const struct dmi_system_id *dmi_entry;
> > > >>> @@ -307,6 +412,7 @@ static int ayaneo_ec_probe(struct platform_de=
vice *pdev)
> > > >>>    static struct platform_driver ayaneo_platform_driver =3D {
> > > >>>        .driver =3D {
> > > >>>                .name =3D "ayaneo-ec",
> > > >>> +             .dev_groups =3D ayaneo_ec_groups,
> > > >>>        },
> > > >>>        .probe =3D ayaneo_ec_probe,
> > > >>>    };
> > >
> >
>


