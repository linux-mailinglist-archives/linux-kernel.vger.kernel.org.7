Return-Path: <linux-kernel+bounces-897213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A25D8C52452
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 13:36:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1A181891E00
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 12:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7213032C921;
	Wed, 12 Nov 2025 12:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jLqJfT5f"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F59313E30;
	Wed, 12 Nov 2025 12:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762950854; cv=none; b=KA3pfPOkSCW1wg9u+RzUu4Ih9ok7kbeHV1etsfWP1oBCICksE5GgL0zDAX8QOA73P4uhkLrKpIvZkAyFKXynJAV5ZGPo9Bf70obxRzoXlz/BoVzeFGTRAj0NOam1VD1Yr1FZRQAEBT8xLAK2e8VCotPoSPcetssdTLGX3uvQqok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762950854; c=relaxed/simple;
	bh=c3K8qADb3/l4YKVHi3k+tTe3MlylnAC3xFlrhJB3drM=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=NvLZ7gBHudLdgEHM2Y3Nvn3Gy/xvYR7ynp2e3OExtXz0m3Am7K3W6KxlacNBle3uRNw/a03m5j0aCY3Wyi9Q0L/blVGRybVD1KB9Te1TvqFEbVmpXo+fQoeczZN2fzUpEtDe0Z7Cje52xx52bSmZH/1yUjalhHny56Zjv2lVJDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jLqJfT5f; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762950852; x=1794486852;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=c3K8qADb3/l4YKVHi3k+tTe3MlylnAC3xFlrhJB3drM=;
  b=jLqJfT5fb/+REc9LqRja3oes22sIG/vhwpSOZ4gEimKGeGW0mLr76hw6
   1OapRGNdpe1tLiAjxQ3aSWX/3OAgjwydQN+txwUuDL+iKeiwIdXaWAPLw
   aLxYV+BujsUiqOW+lBUWMZ74qJxZK2BOvpPhULX6+oDFJzpZwXuyGtx4v
   l7fiuRocYRQeixyzpD9urJRu9ehSTi+BA3dAMLncy2kSQ+MX/HfZ3m/jS
   +Lq6SEwjIazWRQHsJk/3d0L4HhXMIcn9isiQE43nyrh3BqEIreXJLknby
   hkYHegrHLBlInR9ndtAB3yMFCpPjFk74UwUuJq3tyCucRFQ6QVn4w7Lax
   g==;
X-CSE-ConnectionGUID: rzMdY8ecSfyFPte4n9L9yg==
X-CSE-MsgGUID: s4o5U9JLQ5mQsK4C6h6XWQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11610"; a="52571266"
X-IronPort-AV: E=Sophos;i="6.19,299,1754982000"; 
   d="scan'208";a="52571266"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2025 04:34:12 -0800
X-CSE-ConnectionGUID: CoPrUFJNSuC0rhksvSeFEw==
X-CSE-MsgGUID: aSZe2XosSm2hAT4Dk5BfJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,299,1754982000"; 
   d="scan'208";a="189061133"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.16])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2025 04:34:08 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 12 Nov 2025 14:34:04 +0200 (EET)
To: Antheas Kapenekakis <lkml@antheas.dev>
cc: platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    linux-hwmon@vger.kernel.org, Hans de Goede <hansg@kernel.org>, 
    Derek John Clark <derekjohn.clark@gmail.com>, 
    =?ISO-8859-15?Q?Joaqu=EDn_Ignacio_Aramend=EDa?= <samsagax@gmail.com>, 
    Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, 
    Armin Wolf <W_Armin@gmx.de>
Subject: Re: [PATCH v4 4/6] platform/x86: ayaneo-ec: Add controller power
 and modules attributes
In-Reply-To: <CAGwozwE7rSw43tKoStmcmwR3mup5bS0Btk0R3hr0XTwSus4A-w@mail.gmail.com>
Message-ID: <be9c6811-9960-b8ec-eddc-5b2d645d1c2b@linux.intel.com>
References: <20251110180846.1490726-1-lkml@antheas.dev> <20251110180846.1490726-5-lkml@antheas.dev> <888ff0d3-c613-b5a7-3b84-37ff3036e0a4@linux.intel.com> <CAGwozwE7rSw43tKoStmcmwR3mup5bS0Btk0R3hr0XTwSus4A-w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-219875036-1762950844=:955"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-219875036-1762950844=:955
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 11 Nov 2025, Antheas Kapenekakis wrote:

> On Tue, 11 Nov 2025 at 14:41, Ilpo J=C3=A4rvinen
> <ilpo.jarvinen@linux.intel.com> wrote:
> >
> > On Mon, 10 Nov 2025, Antheas Kapenekakis wrote:
> >
> > > The Ayaneo 3 features hot-swappable controller modules. The ejection
> > > and management is done through HID. However, after ejecting the modul=
es,
> > > the controller needs to be power cycled via the EC to re-initialize.
> > >
> > > For this, the EC provides a variable that holds whether the left or
> > > right modules are connected, and a power control register to turn
> > > the controller on or off. After ejecting the modules, the controller
> > > should be turned off. Then, after both modules are reinserted,
> > > the controller may be powered on again to re-initialize.
> > >
> > > This patch introduces two new sysfs attributes:
> > >  - `controller_modules`: a read-only attribute that indicates whether
> > >    the left and right modules are connected (none, left, right, both)=
=2E
> > >  - `controller_power`: a read-write attribute that allows the user
> > >    to turn the controller on or off (with '1'/'0').
> > >
> > > Therefore, after ejection is complete, userspace can power off the
> > > controller, then wait until both modules have been reinserted
> > > (`controller_modules` will return 'both') to turn on the controller.
> > >
> > > Reviewed-by: Armin Wolf <W_Armin@gmx.de>
> > > Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
> > > ---
> > >  .../ABI/testing/sysfs-platform-ayaneo-ec      |  19 ++++
> > >  MAINTAINERS                                   |   1 +
> > >  drivers/platform/x86/ayaneo-ec.c              | 106 ++++++++++++++++=
++
> > >  3 files changed, 126 insertions(+)
> > >  create mode 100644 Documentation/ABI/testing/sysfs-platform-ayaneo-e=
c
> > >
> > > diff --git a/Documentation/ABI/testing/sysfs-platform-ayaneo-ec b/Doc=
umentation/ABI/testing/sysfs-platform-ayaneo-ec
> > > new file mode 100644
> > > index 000000000000..4cffbf5fc7ca
> > > --- /dev/null
> > > +++ b/Documentation/ABI/testing/sysfs-platform-ayaneo-ec
> > > @@ -0,0 +1,19 @@
> > > +What:                /sys/devices/platform/ayaneo-ec/controller_powe=
r
> > > +Date:                Nov 2025
> > > +KernelVersion:       6.19
> > > +Contact:     "Antheas Kapenekakis" <lkml@antheas.dev>
> > > +Description:
> > > +             Current controller power state. Allows turning on and o=
ff
> > > +             the controller power (e.g. for power savings). Write 1 =
to
> > > +             turn on, 0 to turn off. File is readable and writable.
> > > +
> > > +What:                /sys/devices/platform/ayaneo-ec/controller_modu=
les
> > > +Date:                Nov 2025
> > > +KernelVersion:       6.19
> > > +Contact:     "Antheas Kapenekakis"  <lkml@antheas.dev>
> > > +Description:
> > > +             Shows which controller modules are currently connected =
to
> > > +             the device. Possible values are "left", "right" and "bo=
th".
> > > +             File is read-only. The Windows software for this device
> > > +             will only set controller power to 1 if both module side=
s
> > > +             are connected (i.e. this file returns "both").
> > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > index c5bf7207c45f..f8ab009b6224 100644
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -4196,6 +4196,7 @@ AYANEO PLATFORM EC DRIVER
> > >  M:   Antheas Kapenekakis <lkml@antheas.dev>
> > >  L:   platform-driver-x86@vger.kernel.org
> > >  S:   Maintained
> > > +F:   Documentation/ABI/testing/sysfs-platform-ayaneo
> > >  F:   drivers/platform/x86/ayaneo-ec.c
> > >
> > >  AZ6007 DVB DRIVER
> > > diff --git a/drivers/platform/x86/ayaneo-ec.c b/drivers/platform/x86/=
ayaneo-ec.c
> > > index 697bb053a7d6..0652c044ad76 100644
> > > --- a/drivers/platform/x86/ayaneo-ec.c
> > > +++ b/drivers/platform/x86/ayaneo-ec.c
> > > @@ -8,6 +8,7 @@
> > >   */
> > >
> > >  #include <linux/acpi.h>
> > > +#include <linux/bits.h>
> > >  #include <linux/dmi.h>
> > >  #include <linux/err.h>
> > >  #include <linux/hwmon.h>
> > > @@ -16,6 +17,7 @@
> > >  #include <linux/module.h>
> > >  #include <linux/platform_device.h>
> > >  #include <linux/power_supply.h>
> > > +#include <linux/sysfs.h>
> > >  #include <acpi/battery.h>
> > >
> > >  #define AYANEO_PWM_ENABLE_REG         0x4A
> > > @@ -32,9 +34,17 @@
> > >  #define AYANEO_CHARGE_VAL_AUTO               0xaa
> > >  #define AYANEO_CHARGE_VAL_INHIBIT    0x55
> > >
> > > +#define AYANEO_POWER_REG     0x2d
> > > +#define AYANEO_POWER_OFF     0xfe
> > > +#define AYANEO_POWER_ON              0xff
> > > +#define AYANEO_MODULE_REG    0x2f
> > > +#define AYANEO_MODULE_LEFT   BIT(0)
> > > +#define AYANEO_MODULE_RIGHT  BIT(1)
> > > +
> > >  struct ayaneo_ec_quirk {
> > >       bool has_fan_control;
> > >       bool has_charge_control;
> > > +     bool has_magic_modules;
> > >  };
> > >
> > >  struct ayaneo_ec_platform_data {
> > > @@ -46,6 +56,7 @@ struct ayaneo_ec_platform_data {
> > >  static const struct ayaneo_ec_quirk quirk_ayaneo3 =3D {
> > >       .has_fan_control =3D true,
> > >       .has_charge_control =3D true,
> > > +     .has_magic_modules =3D true,
> > >  };
> > >
> > >  static const struct dmi_system_id dmi_table[] =3D {
> > > @@ -266,6 +277,100 @@ static int ayaneo_remove_battery(struct power_s=
upply *battery,
> > >       return 0;
> > >  }
> > >
> > > +static ssize_t controller_power_store(struct device *dev,
> > > +                                   struct device_attribute *attr,
> > > +                                   const char *buf,
> > > +                                   size_t count)
> > > +{
> > > +     bool value;
> > > +     int ret;
> > > +
> > > +     ret =3D kstrtobool(buf, &value);
> > > +     if (ret)
> > > +             return ret;
> > > +
> > > +     ret =3D ec_write(AYANEO_POWER_REG, value ? AYANEO_POWER_ON : AY=
ANEO_POWER_OFF);
> > > +     if (ret)
> > > +             return ret;
> > > +
> > > +     return count;
> > > +}
> > > +
> > > +static ssize_t controller_power_show(struct device *dev,
> > > +                                  struct device_attribute *attr,
> > > +                                  char *buf)
> > > +{
> > > +     int ret;
> > > +     u8 val;
> > > +
> > > +     ret =3D ec_read(AYANEO_POWER_REG, &val);
> > > +     if (ret)
> > > +             return ret;
> > > +
> > > +     return sysfs_emit(buf, "%d\n", val =3D=3D AYANEO_POWER_ON);
> > > +}
> > > +
> > > +static DEVICE_ATTR_RW(controller_power);
> > > +
> > > +static ssize_t controller_modules_show(struct device *dev,
> > > +                                    struct device_attribute *attr, c=
har *buf)
> > > +{
> > > +     char *out;
> > > +     int ret;
> > > +     u8 val;
> > > +
> > > +     ret =3D ec_read(AYANEO_MODULE_REG, &val);
> > > +     if (ret)
> > > +             return ret;
> > > +
> > > +     switch (~val & (AYANEO_MODULE_LEFT | AYANEO_MODULE_RIGHT)) {
> >
> > This too is constructing mask still here which is ugly.
>=20
> I can bring back the bools :-)
>=20
> I agree but that's what I came up with to remove them

Just Add a define for the mask instead as was requested. There's no need=20
to make this any harder than that.

--=20
 i.

> > > +     case AYANEO_MODULE_LEFT | AYANEO_MODULE_RIGHT:
> > > +             out =3D "both";
> > > +             break;
> > > +     case AYANEO_MODULE_LEFT:
> > > +             out =3D "left";
> > > +             break;
> > > +     case AYANEO_MODULE_RIGHT:
> > > +             out =3D "right";
> > > +             break;
> > > +     default:
> > > +             out =3D "none";
> > > +             break;
> > > +     }
> > > +
> > > +     return sysfs_emit(buf, "%s\n", out);
> > > +}
> > > +
> > > +static DEVICE_ATTR_RO(controller_modules);
> > > +
> > > +static struct attribute *aya_mm_attrs[] =3D {
> > > +     &dev_attr_controller_power.attr,
> > > +     &dev_attr_controller_modules.attr,
> > > +     NULL
> > > +};
> > > +
> > > +static umode_t aya_mm_is_visible(struct kobject *kobj,
> > > +                              struct attribute *attr, int n)
> > > +{
> > > +     struct device *dev =3D kobj_to_dev(kobj);
> > > +     struct platform_device *pdev =3D to_platform_device(dev);
> > > +     struct ayaneo_ec_platform_data *data =3D platform_get_drvdata(p=
dev);
> > > +
> > > +     if (data->quirks->has_magic_modules)
> > > +             return attr->mode;
> > > +     return 0;
> > > +}
> > > +
> > > +static const struct attribute_group aya_mm_attribute_group =3D {
> > > +     .is_visible =3D aya_mm_is_visible,
> > > +     .attrs =3D aya_mm_attrs,
> > > +};
> > > +
> > > +static const struct attribute_group *ayaneo_ec_groups[] =3D {
> > > +     &aya_mm_attribute_group,
> > > +     NULL
> > > +};
> > > +
> > >  static int ayaneo_ec_probe(struct platform_device *pdev)
> > >  {
> > >       const struct dmi_system_id *dmi_entry;
> > > @@ -307,6 +412,7 @@ static int ayaneo_ec_probe(struct platform_device=
 *pdev)
> > >  static struct platform_driver ayaneo_platform_driver =3D {
> > >       .driver =3D {
> > >               .name =3D "ayaneo-ec",
> > > +             .dev_groups =3D ayaneo_ec_groups,
> > >       },
> > >       .probe =3D ayaneo_ec_probe,
> > >  };
> > >
> >
> > --
> >  i.
> >
> >
>=20

--8323328-219875036-1762950844=:955--

