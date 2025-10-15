Return-Path: <linux-kernel+bounces-854129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 79175BDD9C1
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 11:08:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C341C4FDDA7
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 09:08:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 795E0308F1B;
	Wed, 15 Oct 2025 09:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HF06BfBR"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E03C30ACE0;
	Wed, 15 Oct 2025 09:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760519294; cv=none; b=FrF6DVbfGXAYGnBYWU8XqnWrbh7if6hhHCtjzkG2hvAe6Is2LD0sKMwTclBh3+iYSYAxR8TK78REF6e3iyjvUpB/qRoGRTePmEBf2FmL1yqR5LtHgCyQSA1HZUH7r9yKexhF5kd874WVJR6xuuwMVsCDXsAyMrHYQm0H+UIKsX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760519294; c=relaxed/simple;
	bh=T5nj29Povwbfm14UALVwuvjwaIz/dm+TuXVcMVuZrO4=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=u/vFl8WUHchVIMlP2m0O5lWuSGhCdDCcRmdzXw995vcXrtGaHoQpPbrx/2T+zfYc2UA8M3X3/m/fSqx5L1PMvtf5zU+VXJCGjJzafJV5TcR2ndwM6hbym/N7T/GnDxuNVbru0D4/8Tn9EFaNngdf9VXc9uelThpnM2mpX/fvYnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HF06BfBR; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760519292; x=1792055292;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=T5nj29Povwbfm14UALVwuvjwaIz/dm+TuXVcMVuZrO4=;
  b=HF06BfBRoV/Oqi47iYMlmLzAcFGuiHlVTzMSE3Wn+4zJS+FjavnQ5+/x
   HlUMP3REZjLT585EXxNzYDbcqwURk7XOQ6TPyXWMBGvsTzyKEcg/2xKUo
   HnnaTm7OyFOfqxaoi7U8mva4Z+93Wy/tgivk/VOl8vgKxTbscwNi6CqDD
   Zkw4N/6V/do0ry6Df7rePNOZxckC3j4GlkqtvkK9pJS5Cd6jYO/UdYQrs
   vj6YzGiAfwpP/mZ8egZDkU2dthYZzxbf2nabgHndqsxRCf3mpReY+itbZ
   i9Df2sDceL2ZHOY59BOy/yBuW/XbgGKSrURbCuUEvo/vi6BHb7X/MQrBZ
   Q==;
X-CSE-ConnectionGUID: v0KwBDwgRvWMTqJ1ObZOdA==
X-CSE-MsgGUID: Kgp9mvW9R2y3n78UsJZSRg==
X-IronPort-AV: E=McAfee;i="6800,10657,11582"; a="85306799"
X-IronPort-AV: E=Sophos;i="6.19,230,1754982000"; 
   d="scan'208";a="85306799"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 02:08:12 -0700
X-CSE-ConnectionGUID: n2WJPEPdS/uZvVUFFdgjFQ==
X-CSE-MsgGUID: 9m3KTAFXQ3yG2R0VYEZIiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,230,1754982000"; 
   d="scan'208";a="182537630"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.75])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 02:08:08 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 15 Oct 2025 12:08:04 +0300 (EEST)
To: Antheas Kapenekakis <lkml@antheas.dev>
cc: platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    linux-hwmon@vger.kernel.org, Hans de Goede <hansg@kernel.org>, 
    Derek John Clark <derekjohn.clark@gmail.com>, 
    =?ISO-8859-15?Q?Joaqu=EDn_Ignacio_Aramend=EDa?= <samsagax@gmail.com>, 
    Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v2 4/6] platform/x86: ayaneo-ec: Add controller power
 and modules attributes
In-Reply-To: <9c482e01-88be-af7e-8a73-1e07b8781354@linux.intel.com>
Message-ID: <83ec8c7c-288f-f5dc-df9c-23094c1a21a0@linux.intel.com>
References: <20251015084414.1391595-1-lkml@antheas.dev> <20251015084414.1391595-5-lkml@antheas.dev> <9c482e01-88be-af7e-8a73-1e07b8781354@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-356696253-1760519197=:957"
Content-ID: <46914f32-1dcc-5bac-c137-8c5d5b95a975@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-356696253-1760519197=:957
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <b6490073-06b7-01d5-49c1-ebb25deb7ea3@linux.intel.com>

On Wed, 15 Oct 2025, Ilpo J=E4rvinen wrote:

> On Wed, 15 Oct 2025, Antheas Kapenekakis wrote:
>=20
> > The Ayaneo 3 features hot-swappable controller modules. The ejection
> > and management is done through HID. However, after ejecting the modules=
,
> > the controller needs to be power cycled via the EC to re-initialize.
> >=20
> > For this, the EC provides a variable that holds whether the left or
> > right modules are connected, and a power control register to turn
> > the controller on or off. After ejecting the modules, the controller
> > should be turned off. Then, after both modules are reinserted,
> > the controller may be powered on again to re-initialize.
> >=20
> > This patch introduces two new sysfs attributes:
> >  - `controller_modules`: a read-only attribute that indicates whether
> >    the left and right modules are connected (none, left, right, both).
> >  - `controller_power`: a read-write attribute that allows the user
> >    to turn the controller on or off (with '1'/'0').
> >=20
> > Therefore, after ejection is complete, userspace can power off the
> > controller, then wait until both modules have been reinserted
> > (`controller_modules` will return 'both') to turn on the controller.
> >=20
> > Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
> > ---
> >  .../ABI/testing/sysfs-platform-ayaneo         |  19 ++++
> >  MAINTAINERS                                   |   1 +
> >  drivers/platform/x86/ayaneo-ec.c              | 100 ++++++++++++++++++
> >  3 files changed, 120 insertions(+)
> >  create mode 100644 Documentation/ABI/testing/sysfs-platform-ayaneo
> >=20
> > diff --git a/Documentation/ABI/testing/sysfs-platform-ayaneo b/Document=
ation/ABI/testing/sysfs-platform-ayaneo
> > new file mode 100644
> > index 000000000000..1fa32ba60fd0
> > --- /dev/null
> > +++ b/Documentation/ABI/testing/sysfs-platform-ayaneo
> > @@ -0,0 +1,19 @@
> > +What:=09=09/sys/devices/platform/<platform>/controller_power
> > +Date:=09=09Oct 2025
> > +KernelVersion:=096.9
> > +Contact:=09"Antheas Kapenekakis" <lkml@antheas.dev>
> > +Description:
> > +=09=09Current controller power state. Allows turning on and off
> > +=09=09the controller power (e.g. for power savings). Write 1 to
> > +=09=09turn on, 0 to turn off. File is readable and writable.
> > +
> > +What:=09=09/sys/devices/platform/<platform>/controller_modules
> > +Date:=09=09Oct 2025
> > +KernelVersion:=096.9
> > +Contact:=09"Antheas Kapenekakis"  <lkml@antheas.dev>
> > +Description:
> > +=09=09Shows which controller modules are currently connected to
> > +=09=09the device. Possible values are "left", "right" and "both".
> > +=09=09File is read-only. The Windows software for this device
> > +=09=09will only set controller power to 1 if both module sides
> > +=09=09are connected (i.e. this file returns "both").
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 8c4d0c26ca77..3dfa004555dd 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -4191,6 +4191,7 @@ AYANEO PLATFORM EC DRIVER
> >  M:=09Antheas Kapenekakis <lkml@antheas.dev>
> >  L:=09platform-driver-x86@vger.kernel.org
> >  S:=09Maintained
> > +F:=09Documentation/ABI/testing/sysfs-platform-ayaneo
> >  F:=09drivers/platform/x86/ayaneo-ec.c
> > =20
> >  AZ6007 DVB DRIVER
> > diff --git a/drivers/platform/x86/ayaneo-ec.c b/drivers/platform/x86/ay=
aneo-ec.c
> > index 23c283f5eb61..363b61fc6e12 100644
> > --- a/drivers/platform/x86/ayaneo-ec.c
> > +++ b/drivers/platform/x86/ayaneo-ec.c
> > @@ -30,9 +30,17 @@
> >  #define AYANEO_CHARGE_VAL_AUTO=09=090xaa
> >  #define AYANEO_CHARGE_VAL_INHIBIT=090x55
> > =20
> > +#define AYANEO_POWER_REG=090x2d
> > +#define AYANEO_POWER_OFF=090xfe
> > +#define AYANEO_POWER_ON=09=090xff
> > +#define AYANEO_MODULE_REG=090x2f
> > +#define AYANEO_MODULE_LEFT=09BIT(0)
> > +#define AYANEO_MODULE_RIGHT=09BIT(1)

Also, add include for BIT().

> > +
> >  struct ayaneo_ec_quirk {
> >  =09bool has_fan_control;
> >  =09bool has_charge_control;
> > +=09bool has_magic_modules;
> >  };
> > =20
> >  struct ayaneo_ec_platform_data {
> > @@ -44,6 +52,7 @@ struct ayaneo_ec_platform_data {
> >  static const struct ayaneo_ec_quirk ayaneo3 =3D {
> >  =09.has_fan_control =3D true,
> >  =09.has_charge_control =3D true,
> > +=09.has_magic_modules =3D true,
> >  };
> > =20
> >  static const struct dmi_system_id dmi_table[] =3D {
> > @@ -262,6 +271,96 @@ static int ayaneo_remove_battery(struct power_supp=
ly *battery,
> >  =09return 0;
> >  }
> > =20
> > +static ssize_t controller_power_store(struct device *dev,
> > +=09=09=09    struct device_attribute *attr, const char *buf,
> > +=09=09=09    size_t count)
> > +{
> > +=09bool value;
> > +=09int ret;
> > +
> > +=09ret =3D kstrtobool(buf, &value);
> > +=09if (ret)
> > +=09=09return ret;
> > +
> > +=09ret =3D ec_write(AYANEO_POWER_REG, value ? AYANEO_POWER_ON : AYANEO=
_POWER_OFF);
> > +=09if (ret)
> > +=09=09return ret;
> > +
> > +=09return count;
> > +}
> > +
> > +static ssize_t controller_power_show(struct device *dev,
> > +=09=09=09   struct device_attribute *attr, char *buf)
> > +{
> > +=09int ret;
> > +=09u8 val;
> > +
> > +=09ret =3D ec_read(AYANEO_POWER_REG, &val);
> > +=09if (ret)
> > +=09=09return ret;
> > +
> > +=09return sysfs_emit(buf, "%d\n", val =3D=3D AYANEO_POWER_ON);

Add include.

--=20
 i.

> > +}
> > +
> > +static DEVICE_ATTR_RW(controller_power);
> > +
> > +static ssize_t controller_modules_show(struct device *dev,
> > +=09=09=09=09       struct device_attribute *attr, char *buf)
> > +{
> > +=09bool left, right;
> > +=09char *out;
> > +=09int ret;
> > +=09u8 val;
> > +
> > +=09ret =3D ec_read(AYANEO_MODULE_REG, &val);
> > +=09if (ret)
> > +=09=09return ret;
> > +
> > +=09left =3D !(val & AYANEO_MODULE_LEFT);
> > +=09right =3D !(val & AYANEO_MODULE_RIGHT);
> > +
> > +=09if (left && right)
> > +=09=09out =3D "both";
> > +=09else if (left)
> > +=09=09out =3D "left";
> > +=09else if (right)
> > +=09=09out =3D "right";
> > +=09else
> > +=09=09out =3D "none";
>=20
> I suggest using switch/case for this so you don't need the internal=20
> booleans at all.
>=20
> BTW, I appreciate it very much this series is split per feature, it's so=
=20
> much less daunting to start a review when I know I can actually finish=20
> before the next interruption (and having to flush context from my
> mind). :-)
>=20
>=20
--8323328-356696253-1760519197=:957--

