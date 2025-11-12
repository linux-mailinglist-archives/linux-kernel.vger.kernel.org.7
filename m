Return-Path: <linux-kernel+bounces-897237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DC5BC52597
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 13:59:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71C063AAD61
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 12:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67D823358A6;
	Wed, 12 Nov 2025 12:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UOSIUQ8K"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5670932C33C;
	Wed, 12 Nov 2025 12:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762951748; cv=none; b=CSfLhG9quFaEhsAhu78IqvvIenbZVpPmi+y3z+YzX2ggmZ5sGaLJZzeAHRnlK4OwWgGHLGeDVBHOzTR5Kt3mRuBYIMbrAXBo2COH6cq13fv0JCP7veM4tx2IUvoheM1VSDI7fZ4x8DS/1bd5vKQmWuFOjXAVcRslwJswpgzzGTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762951748; c=relaxed/simple;
	bh=7Ch1Z7Ossjf7YMHRIa/Qz0DEanlre0LCi2qSNJylKR4=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=B79gfEpEG0gFe0Dub5qxw6OqdCmmT4oo0/kYxYsbQv+DN2lf3YfFzX+rSZnqRzTUlE98nCiferCT1+jrL3k1pisCXejf2anOXJ7Lnd59tqA0Nidk0D2vpglUU+5iaLSO+MbTEJ8zBYwwpO+d+0uuGy/KuutDrgUeh3X87AcpROk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UOSIUQ8K; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762951746; x=1794487746;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=7Ch1Z7Ossjf7YMHRIa/Qz0DEanlre0LCi2qSNJylKR4=;
  b=UOSIUQ8KWYHw0nSap3jhhNXUrWvgJl/gpA0ch6lTvQZS3zRD/jqjNUyY
   qBMZbnauISNkwwZ37s/m8Xv0Z1Z4Ho0Q6tW7UC9oEYB/MAUeIcalNTPCY
   OYXpvPiNLhd1xUdsFw4AHpoPJwtrOocsM+XHVaLCzu9M/TwNg9SO4bnrg
   +w6U0C8Zr12gktftSsSGlEvdAk8JvXZL80GvS+jKmjmuObKdNihYuGEFr
   gF9GS0Pk5xNIX02FbBWonl+0FRWtRlpseAA3YxE/HRK6m3jf7Y0qtz9rJ
   NJx2Vh4c36rY79LCQtFE/83RTK2XBWykKg07zzt3WTxNdKyzfL5bzGIDq
   w==;
X-CSE-ConnectionGUID: LoyGep6rRKubM2wZJcsuCQ==
X-CSE-MsgGUID: J/oXyj5HRReDEK8dn1q0Yw==
X-IronPort-AV: E=McAfee;i="6800,10657,11610"; a="76361677"
X-IronPort-AV: E=Sophos;i="6.19,299,1754982000"; 
   d="scan'208";a="76361677"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2025 04:49:06 -0800
X-CSE-ConnectionGUID: FKTZW1iRT4qy1WTOKrn7BA==
X-CSE-MsgGUID: othsPioNQdKjv7KyZdBjYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,299,1754982000"; 
   d="scan'208";a="194192978"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.16])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2025 04:49:01 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 12 Nov 2025 14:48:58 +0200 (EET)
To: Antheas Kapenekakis <lkml@antheas.dev>
cc: platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    linux-hwmon@vger.kernel.org, Hans de Goede <hansg@kernel.org>, 
    Derek John Clark <derekjohn.clark@gmail.com>, 
    =?ISO-8859-15?Q?Joaqu=EDn_Ignacio_Aramend=EDa?= <samsagax@gmail.com>, 
    Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, 
    Armin Wolf <W_Armin@gmx.de>
Subject: Re: [PATCH v4 4/6] platform/x86: ayaneo-ec: Add controller power
 and modules attributes
In-Reply-To: <CAGwozwGF5x3wWkcz7sDpS=i+n0VPQpcuBr0r4ycH8b0YTLOJ5w@mail.gmail.com>
Message-ID: <acc13faa-998e-60de-8636-a1c08b9a274d@linux.intel.com>
References: <20251110180846.1490726-1-lkml@antheas.dev> <20251110180846.1490726-5-lkml@antheas.dev> <888ff0d3-c613-b5a7-3b84-37ff3036e0a4@linux.intel.com> <CAGwozwE7rSw43tKoStmcmwR3mup5bS0Btk0R3hr0XTwSus4A-w@mail.gmail.com> <be9c6811-9960-b8ec-eddc-5b2d645d1c2b@linux.intel.com>
 <CAGwozwGF5x3wWkcz7sDpS=i+n0VPQpcuBr0r4ycH8b0YTLOJ5w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1345560233-1762951738=:955"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1345560233-1762951738=:955
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 12 Nov 2025, Antheas Kapenekakis wrote:

> On Wed, 12 Nov 2025 at 13:34, Ilpo J=C3=A4rvinen
> <ilpo.jarvinen@linux.intel.com> wrote:
> >
> > On Tue, 11 Nov 2025, Antheas Kapenekakis wrote:
> >
> > > On Tue, 11 Nov 2025 at 14:41, Ilpo J=C3=A4rvinen
> > > <ilpo.jarvinen@linux.intel.com> wrote:
> > > >
> > > > On Mon, 10 Nov 2025, Antheas Kapenekakis wrote:
> > > >
> > > > > The Ayaneo 3 features hot-swappable controller modules. The eject=
ion
> > > > > and management is done through HID. However, after ejecting the m=
odules,
> > > > > the controller needs to be power cycled via the EC to re-initiali=
ze.
> > > > >
> > > > > For this, the EC provides a variable that holds whether the left =
or
> > > > > right modules are connected, and a power control register to turn
> > > > > the controller on or off. After ejecting the modules, the control=
ler
> > > > > should be turned off. Then, after both modules are reinserted,
> > > > > the controller may be powered on again to re-initialize.
> > > > >
> > > > > This patch introduces two new sysfs attributes:
> > > > >  - `controller_modules`: a read-only attribute that indicates whe=
ther
> > > > >    the left and right modules are connected (none, left, right, b=
oth).
> > > > >  - `controller_power`: a read-write attribute that allows the use=
r
> > > > >    to turn the controller on or off (with '1'/'0').
> > > > >
> > > > > Therefore, after ejection is complete, userspace can power off th=
e
> > > > > controller, then wait until both modules have been reinserted
> > > > > (`controller_modules` will return 'both') to turn on the controll=
er.
> > > > >
> > > > > Reviewed-by: Armin Wolf <W_Armin@gmx.de>
> > > > > Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
> > > > > ---
> > > > >  .../ABI/testing/sysfs-platform-ayaneo-ec      |  19 ++++
> > > > >  MAINTAINERS                                   |   1 +
> > > > >  drivers/platform/x86/ayaneo-ec.c              | 106 ++++++++++++=
++++++
> > > > >  3 files changed, 126 insertions(+)
> > > > >  create mode 100644 Documentation/ABI/testing/sysfs-platform-ayan=
eo-ec
> > > > >
> > > > > diff --git a/Documentation/ABI/testing/sysfs-platform-ayaneo-ec b=
/Documentation/ABI/testing/sysfs-platform-ayaneo-ec
> > > > > new file mode 100644
> > > > > index 000000000000..4cffbf5fc7ca
> > > > > --- /dev/null
> > > > > +++ b/Documentation/ABI/testing/sysfs-platform-ayaneo-ec
> > > > > @@ -0,0 +1,19 @@
> > > > > +What:                /sys/devices/platform/ayaneo-ec/controller_=
power
> > > > > +Date:                Nov 2025
> > > > > +KernelVersion:       6.19
> > > > > +Contact:     "Antheas Kapenekakis" <lkml@antheas.dev>
> > > > > +Description:
> > > > > +             Current controller power state. Allows turning on a=
nd off
> > > > > +             the controller power (e.g. for power savings). Writ=
e 1 to
> > > > > +             turn on, 0 to turn off. File is readable and writab=
le.
> > > > > +
> > > > > +What:                /sys/devices/platform/ayaneo-ec/controller_=
modules
> > > > > +Date:                Nov 2025
> > > > > +KernelVersion:       6.19
> > > > > +Contact:     "Antheas Kapenekakis"  <lkml@antheas.dev>
> > > > > +Description:
> > > > > +             Shows which controller modules are currently connec=
ted to
> > > > > +             the device. Possible values are "left", "right" and=
 "both".
> > > > > +             File is read-only. The Windows software for this de=
vice
> > > > > +             will only set controller power to 1 if both module =
sides
> > > > > +             are connected (i.e. this file returns "both").
> > > > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > > > index c5bf7207c45f..f8ab009b6224 100644
> > > > > --- a/MAINTAINERS
> > > > > +++ b/MAINTAINERS
> > > > > @@ -4196,6 +4196,7 @@ AYANEO PLATFORM EC DRIVER
> > > > >  M:   Antheas Kapenekakis <lkml@antheas.dev>
> > > > >  L:   platform-driver-x86@vger.kernel.org
> > > > >  S:   Maintained
> > > > > +F:   Documentation/ABI/testing/sysfs-platform-ayaneo
> > > > >  F:   drivers/platform/x86/ayaneo-ec.c
> > > > >
> > > > >  AZ6007 DVB DRIVER
> > > > > diff --git a/drivers/platform/x86/ayaneo-ec.c b/drivers/platform/=
x86/ayaneo-ec.c
> > > > > index 697bb053a7d6..0652c044ad76 100644
> > > > > --- a/drivers/platform/x86/ayaneo-ec.c
> > > > > +++ b/drivers/platform/x86/ayaneo-ec.c
> > > > > @@ -8,6 +8,7 @@
> > > > >   */
> > > > >
> > > > >  #include <linux/acpi.h>
> > > > > +#include <linux/bits.h>
> > > > >  #include <linux/dmi.h>
> > > > >  #include <linux/err.h>
> > > > >  #include <linux/hwmon.h>
> > > > > @@ -16,6 +17,7 @@
> > > > >  #include <linux/module.h>
> > > > >  #include <linux/platform_device.h>
> > > > >  #include <linux/power_supply.h>
> > > > > +#include <linux/sysfs.h>
> > > > >  #include <acpi/battery.h>
> > > > >
> > > > >  #define AYANEO_PWM_ENABLE_REG         0x4A
> > > > > @@ -32,9 +34,17 @@
> > > > >  #define AYANEO_CHARGE_VAL_AUTO               0xaa
> > > > >  #define AYANEO_CHARGE_VAL_INHIBIT    0x55
> > > > >
> > > > > +#define AYANEO_POWER_REG     0x2d
> > > > > +#define AYANEO_POWER_OFF     0xfe
> > > > > +#define AYANEO_POWER_ON              0xff
> > > > > +#define AYANEO_MODULE_REG    0x2f
> > > > > +#define AYANEO_MODULE_LEFT   BIT(0)
> > > > > +#define AYANEO_MODULE_RIGHT  BIT(1)
> > > > > +
> > > > >  struct ayaneo_ec_quirk {
> > > > >       bool has_fan_control;
> > > > >       bool has_charge_control;
> > > > > +     bool has_magic_modules;
> > > > >  };
> > > > >
> > > > >  struct ayaneo_ec_platform_data {
> > > > > @@ -46,6 +56,7 @@ struct ayaneo_ec_platform_data {
> > > > >  static const struct ayaneo_ec_quirk quirk_ayaneo3 =3D {
> > > > >       .has_fan_control =3D true,
> > > > >       .has_charge_control =3D true,
> > > > > +     .has_magic_modules =3D true,
> > > > >  };
> > > > >
> > > > >  static const struct dmi_system_id dmi_table[] =3D {
> > > > > @@ -266,6 +277,100 @@ static int ayaneo_remove_battery(struct pow=
er_supply *battery,
> > > > >       return 0;
> > > > >  }
> > > > >
> > > > > +static ssize_t controller_power_store(struct device *dev,
> > > > > +                                   struct device_attribute *attr=
,
> > > > > +                                   const char *buf,
> > > > > +                                   size_t count)
> > > > > +{
> > > > > +     bool value;
> > > > > +     int ret;
> > > > > +
> > > > > +     ret =3D kstrtobool(buf, &value);
> > > > > +     if (ret)
> > > > > +             return ret;
> > > > > +
> > > > > +     ret =3D ec_write(AYANEO_POWER_REG, value ? AYANEO_POWER_ON =
: AYANEO_POWER_OFF);
> > > > > +     if (ret)
> > > > > +             return ret;
> > > > > +
> > > > > +     return count;
> > > > > +}
> > > > > +
> > > > > +static ssize_t controller_power_show(struct device *dev,
> > > > > +                                  struct device_attribute *attr,
> > > > > +                                  char *buf)
> > > > > +{
> > > > > +     int ret;
> > > > > +     u8 val;
> > > > > +
> > > > > +     ret =3D ec_read(AYANEO_POWER_REG, &val);
> > > > > +     if (ret)
> > > > > +             return ret;
> > > > > +
> > > > > +     return sysfs_emit(buf, "%d\n", val =3D=3D AYANEO_POWER_ON);
> > > > > +}
> > > > > +
> > > > > +static DEVICE_ATTR_RW(controller_power);
> > > > > +
> > > > > +static ssize_t controller_modules_show(struct device *dev,
> > > > > +                                    struct device_attribute *att=
r, char *buf)
> > > > > +{
> > > > > +     char *out;
> > > > > +     int ret;
> > > > > +     u8 val;
> > > > > +
> > > > > +     ret =3D ec_read(AYANEO_MODULE_REG, &val);
> > > > > +     if (ret)
> > > > > +             return ret;
> > > > > +
> > > > > +     switch (~val & (AYANEO_MODULE_LEFT | AYANEO_MODULE_RIGHT)) =
{
> > > >
> > > > This too is constructing mask still here which is ugly.
> > >
> > > I can bring back the bools :-)
> > >
> > > I agree but that's what I came up with to remove them
> >
> > Just Add a define for the mask instead as was requested. There's no nee=
d
> > to make this any harder than that.
>=20
> Should the mask be:
>=20
> (AYANEO_MODULE_LEFT | AYANEO_MODULE_RIGHT)
>=20
> or
>=20
> GENMASK(2,0)ish

This has a wrong bit index.

> I find the latter a bit more error prone since it redefines. I can
> move forward with the former one later today if there arent any other
> comments

Either way is fine with me, as long as it's not in the switch itself.
I think I lean a bit more to the former one.

--=20
 i.

--8323328-1345560233-1762951738=:955--

