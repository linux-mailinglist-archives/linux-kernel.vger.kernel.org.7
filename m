Return-Path: <linux-kernel+bounces-831013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17283B9B269
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 19:58:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C70264E4D22
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 17:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCBE03164DF;
	Wed, 24 Sep 2025 17:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TSOLvU/f"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 811593128B0;
	Wed, 24 Sep 2025 17:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758736722; cv=none; b=b4pkw65IPWdvdg/GUj0/6rhZ5Pt7GOpRSO5ubC6E70arEuI3Iy2iWwwd0auO9STfhzcmqBfFXkthQgySyjG5jK0fCOGoUiqqUPjte2VtmZlAEIax4R1hQ7/yuT3BuKIci66sua7qzfbIjHHeI0+1J1yOZ3AsygHROsW2lbA7UfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758736722; c=relaxed/simple;
	bh=xpzfl0iM/yVcytRq5VSh7tfIPE227Dq5u9TqwhpPuY4=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=lCUQvCR9JSChwlMAiT5dInTzuyRVe9npn/QDY2xNfA2xEYxsd0DqaBDXuxQf3TgW61m+BmfBhGr4X90Y8uraNkLJhsLpcrvU8AkeGxEdKXGEE093o5hO5iD5g0lwC6wFhngRAPr4L35fsfcSswNn6jGbZxGUi6sA3olmVv7EQPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TSOLvU/f; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758736721; x=1790272721;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=xpzfl0iM/yVcytRq5VSh7tfIPE227Dq5u9TqwhpPuY4=;
  b=TSOLvU/frg1x6HMlU88vAnXkr9JuSOGh71H/Yi3wC9+db9GOjwi6HH5c
   xjTUDX8eGrOmnng6ZLQEhWNZFyag0BVz9yi1ypBFk0gjeGtOKWo3mLMiV
   7ce55wKRwOE+OmyY0cl0yIf9Byy5P+4xNQGYGTAqZVN4D+ertVUJMl2n/
   9za7ieg2FpYqxSvYExLrvdDQ2tGmpKFLZ4iGzFliU9ZHa3/IUSpH4mPB4
   dY1y3O2nJF0zKAv0m3VcAR1nXjBooWwZvhFy2aX3CnbUS2qpUBWblGAAJ
   SXjvoZiKODioKAAqftgxNdbROwJRZ3+xdvUYPv4N1HEhF9DdqK8TUUN+g
   Q==;
X-CSE-ConnectionGUID: inMSObH7RYWxrIxEMiutbQ==
X-CSE-MsgGUID: JFblzqJETDCjDU5ANQ3nSg==
X-IronPort-AV: E=McAfee;i="6800,10657,11563"; a="86488669"
X-IronPort-AV: E=Sophos;i="6.18,291,1751266800"; 
   d="scan'208";a="86488669"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2025 10:58:40 -0700
X-CSE-ConnectionGUID: f+3GSkoUSXiIkhMO1V4L+A==
X-CSE-MsgGUID: jwQkIeZvQR6owqZfivnjog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,291,1751266800"; 
   d="scan'208";a="181108010"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.210])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2025 10:58:36 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 24 Sep 2025 20:58:33 +0300 (EEST)
To: Daniel <dany97@live.ca>
cc: Markus.Elfring@web.de, Hans de Goede <hansg@kernel.org>, 
    LKML <linux-kernel@vger.kernel.org>, matan@svgalib.org, 
    platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v5] platform/x86: lg-laptop: Fix WMAB call in
 fan_mode_store()
In-Reply-To: <MN2PR06MB5598AC9C807A8D3929E6C30BDC1CA@MN2PR06MB5598.namprd06.prod.outlook.com>
Message-ID: <98afb5a6-c47f-23c8-84c7-a494a086df27@linux.intel.com>
References: <78e9dde3-9f21-9b06-663b-e7a23451b9e7@linux.intel.com> <MN2PR06MB55984287A9BAB69F1711640DDC11A@MN2PR06MB5598.namprd06.prod.outlook.com> <ea57d978-3fd3-fd86-aec7-e814359e3e02@linux.intel.com> <MN2PR06MB559873DBA3BA4491E08949ACDC1DA@MN2PR06MB5598.namprd06.prod.outlook.com>
 <175871961048.19584.6234729612579222383.b4-ty@linux.intel.com> <MN2PR06MB5598AC9C807A8D3929E6C30BDC1CA@MN2PR06MB5598.namprd06.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1672963698-1758736713=:938"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1672963698-1758736713=:938
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 24 Sep 2025, Daniel wrote:

> On 2025-09-24 09:13, Ilpo J=C3=A4rvinen wrote:
>=20
> > Thank you for your contribution, it has been applied to my local
> > review-ilpo-fixes branch. Note it will show up in the public
> > platform-drivers-x86/review-ilpo-fixes branch only once I've pushed my
> > local branch there, which might take a while.
>=20
> Thanks a lot, but I was actually thinking about rewording the body of the
> commit message.  Could I ask that this version be the one to eventually b=
e
> pushed to the public repo?

I can replace it but please send the new version into a new thread as=20
in the same thread won't necessarily end up properly into patchwork and=20
may confuse other tools as well.

> Also, this patch fixes an issue raised in this comment on the kernel bugz=
illa:
> (https://bugzilla.kernel.org/show_bug.cgi?id=3D204913#c4), but crucially =
not
> the issue itself.  Do I mention this anywhere in the commit message?

Just use a Link: tag, preferably directly to the comment.

--=20
 i.

> -- >8 --
> Subject: [PATCH v6] platform/x86: lg-laptop: Fix WMAB call in fan_mode_st=
ore()
>=20
> When WMAB is called to set the fan mode, the new mode is read from either
> bits 0-1 or bits 4-5 (depending on the value of some other EC register).
> Thus when WMAB is called with bits 4-5 zeroed and called again with
> bits 0-1 zeroed, the second call undoes the effect of the first call.
> This causes writes to /sys/devices/platform/lg-laptop/fan_mode to have
> no effect (and causes reads to always report a status of zero).
>=20
> Fix this by calling WMAB once, with the mode set in bits 0,1 and 4,5.
> When the fan mode is returned from WMAB it always has this form, so
> there is no need to preserve the other bits.  As a bonus, the driver
> now supports the "Performance" fan mode seen in the LG-provided Windows
> control app, which provides less aggressive CPU throttling but louder
> fan noise and shorter battery life.
>=20
> Also correct the documentation to reflect that 0 corresponds to the
> default mode (what the Windows app calls "Optimal") and 1 corresponds
> to the silent mode.
>=20
> Signed-off-by: Daniel Lee <dany97@live.ca>
> Tested-by: Daniel Lee <dany97@live.ca>
> Fixes: dbf0c5a6b1f8 ("platform/x86: Add LG Gram laptop special features d=
river")
> ---
> V1 -> V2: Replace bitops with GENMASK() and FIELD_PREP()
> V2 -> V3: Add parentheses next to function name in summary line
>           Use full name in signoff
> V3 -> V4: Add include for linux/bitfield.h
>           Remove "FIELD" from bitmask macro names
> V4 -> V5: Rename `status` to `mode` in fan_mode_show()
> V5 -> V6: Reword commit message body
>=20
>  .../admin-guide/laptops/lg-laptop.rst         |  4 +--
>  drivers/platform/x86/lg-laptop.c              | 34 ++++++++-----------
>  2 files changed, 16 insertions(+), 22 deletions(-)
>=20
> diff --git a/Documentation/admin-guide/laptops/lg-laptop.rst b/Documentat=
ion/admin-guide/laptops/lg-laptop.rst
> index 67fd6932c..c4dd534f9 100644
> --- a/Documentation/admin-guide/laptops/lg-laptop.rst
> +++ b/Documentation/admin-guide/laptops/lg-laptop.rst
> @@ -48,8 +48,8 @@ This value is reset to 100 when the kernel boots.
>  Fan mode
>  --------
> =20
> -Writing 1/0 to /sys/devices/platform/lg-laptop/fan_mode disables/enables
> -the fan silent mode.
> +Writing 0/1/2 to /sys/devices/platform/lg-laptop/fan_mode sets fan mode =
to
> +Optimal/Silent/Performance respectively.
> =20
> =20
>  USB charge
> diff --git a/drivers/platform/x86/lg-laptop.c b/drivers/platform/x86/lg-l=
aptop.c
> index 4b57102c7..6af6cf477 100644
> --- a/drivers/platform/x86/lg-laptop.c
> +++ b/drivers/platform/x86/lg-laptop.c
> @@ -8,6 +8,7 @@
>  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> =20
>  #include <linux/acpi.h>
> +#include <linux/bitfield.h>
>  #include <linux/bits.h>
>  #include <linux/device.h>
>  #include <linux/dev_printk.h>
> @@ -75,6 +76,9 @@ MODULE_PARM_DESC(fw_debug, "Enable printing of firmware=
 debug messages");
>  #define WMBB_USB_CHARGE 0x10B
>  #define WMBB_BATT_LIMIT 0x10C
> =20
> +#define FAN_MODE_LOWER GENMASK(1, 0)
> +#define FAN_MODE_UPPER GENMASK(5, 4)
> +
>  #define PLATFORM_NAME   "lg-laptop"
> =20
>  MODULE_ALIAS("wmi:" WMI_EVENT_GUID0);
> @@ -274,29 +278,19 @@ static ssize_t fan_mode_store(struct device *dev,
>  =09=09=09      struct device_attribute *attr,
>  =09=09=09      const char *buffer, size_t count)
>  {
> -=09bool value;
> +=09unsigned long value;
>  =09union acpi_object *r;
> -=09u32 m;
>  =09int ret;
> =20
> -=09ret =3D kstrtobool(buffer, &value);
> +=09ret =3D kstrtoul(buffer, 10, &value);
>  =09if (ret)
>  =09=09return ret;
> +=09if (value >=3D 3)
> +=09=09return -EINVAL;
> =20
> -=09r =3D lg_wmab(dev, WM_FAN_MODE, WM_GET, 0);
> -=09if (!r)
> -=09=09return -EIO;
> -
> -=09if (r->type !=3D ACPI_TYPE_INTEGER) {
> -=09=09kfree(r);
> -=09=09return -EIO;
> -=09}
> -
> -=09m =3D r->integer.value;
> -=09kfree(r);
> -=09r =3D lg_wmab(dev, WM_FAN_MODE, WM_SET, (m & 0xffffff0f) | (value << =
4));
> -=09kfree(r);
> -=09r =3D lg_wmab(dev, WM_FAN_MODE, WM_SET, (m & 0xfffffff0) | value);
> +=09r =3D lg_wmab(dev, WM_FAN_MODE, WM_SET,
> +=09=09FIELD_PREP(FAN_MODE_LOWER, value) |
> +=09=09FIELD_PREP(FAN_MODE_UPPER, value));
>  =09kfree(r);
> =20
>  =09return count;
> @@ -305,7 +299,7 @@ static ssize_t fan_mode_store(struct device *dev,
>  static ssize_t fan_mode_show(struct device *dev,
>  =09=09=09     struct device_attribute *attr, char *buffer)
>  {
> -=09unsigned int status;
> +=09unsigned int mode;
>  =09union acpi_object *r;
> =20
>  =09r =3D lg_wmab(dev, WM_FAN_MODE, WM_GET, 0);
> @@ -317,10 +311,10 @@ static ssize_t fan_mode_show(struct device *dev,
>  =09=09return -EIO;
>  =09}
> =20
> -=09status =3D r->integer.value & 0x01;
> +=09mode =3D FIELD_GET(FAN_MODE_LOWER, r->integer.value);
>  =09kfree(r);
> =20
> -=09return sysfs_emit(buffer, "%d\n", status);
> +=09return sysfs_emit(buffer, "%d\n", mode);
>  }
> =20
>  static ssize_t usb_charge_store(struct device *dev,
>=20
--8323328-1672963698-1758736713=:938--

