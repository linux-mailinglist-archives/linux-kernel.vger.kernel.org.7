Return-Path: <linux-kernel+bounces-789824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3BD3B39B29
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 13:12:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFF973B4FDC
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 11:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DACCA30EF80;
	Thu, 28 Aug 2025 11:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M8bO3mpG"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C90E30ACFF;
	Thu, 28 Aug 2025 11:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756379531; cv=none; b=pN+NhOPoUt8sRcPqsuPb7zdSaUxQG2ce4SAdtH32TRpVWApgAJzB2NEqv9NVvbF70zqu+Cn3oEN4KHOnm9VLwObyfd2rnk/dnd1ObMQ94WAw4TtHATEBaEC7BnAMQb+iq2vsPgo04DaWi4JCi/E63172VGCOBIekbzSm9yjvOFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756379531; c=relaxed/simple;
	bh=enPpz+S5NA4WcrnMqKzmIzvOUg4UyZY6UIMIUDD5itk=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Bsd+77J1LAKW4On/V003olq1MqcpP6ZFbVdRLSwvtBwFAa3D2OXRgYtLQ3418jh8ZlHmAaoXPr5TExecEH+G9diyoXO+eX6CXK9WfDpHvrFQEPEahZFzyLQWG/qfbEeueoodADJx6KhYG7Up/IoaPQbjtpH9tkFVbPgnfeWmyMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M8bO3mpG; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756379530; x=1787915530;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=enPpz+S5NA4WcrnMqKzmIzvOUg4UyZY6UIMIUDD5itk=;
  b=M8bO3mpG8XYDfFwrzCKGYE9hbAJiPCdIs/uwdqZb/VmrBkh8uqboTYKl
   RF6fAg7OzWfbwT7dlJFwVVBcxzLOGCD0Yw3V/CA7icYK8uotTEi+de3Q5
   uv9bozvzikUdR3k0fMxDXXS7G19ESp0vJdXHiyVBkjsyNmOv0b9aGRXfu
   UhB8AAe4K7qVwvbuGCkAOt+Hz980/9VDQbZDfj+FKtgsSz6lNTFZdcY0K
   wacSPTPlmCZisZCBqTPm04w33eKWLEenD+F9lzzLWTORjuphOMp/0sK6Z
   gFK3vn/AcYU9vs/LX8bZOYueNu91Eg5tZmAtPSMMxxljBeNWe77AOjaqy
   w==;
X-CSE-ConnectionGUID: BYpAnJHAQHeoS+yFv6sHOw==
X-CSE-MsgGUID: 5tBzekpLT4SXFEaQDFxo4w==
X-IronPort-AV: E=McAfee;i="6800,10657,11535"; a="68918213"
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="68918213"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2025 04:12:10 -0700
X-CSE-ConnectionGUID: FYSft+80Ru2S/q5QxssThQ==
X-CSE-MsgGUID: KFUx9/SbSxyywDuCdO00NQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="175358714"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.99])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2025 04:12:06 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 28 Aug 2025 14:12:03 +0300 (EEST)
To: Daniel <dany97@live.ca>
cc: matan@svgalib.org, platform-driver-x86@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] platform/x86: lg-laptop: Fix WMAB call in
 fan_mode_store
In-Reply-To: <2fdc2487-aaae-aa3c-9aa6-0c2bf2379e5a@linux.intel.com>
Message-ID: <d2e91809-8872-7a3f-743f-b4091e8196d2@linux.intel.com>
References: <MN2PR06MB55982D694628BC31FD980FD2DC3DA@MN2PR06MB5598.namprd06.prod.outlook.com> <2fdc2487-aaae-aa3c-9aa6-0c2bf2379e5a@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-105747440-1756379523=:938"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-105747440-1756379523=:938
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 28 Aug 2025, Ilpo J=E4rvinen wrote:

> On Fri, 22 Aug 2025, Daniel wrote:
>=20
> > On my LG Gram 16Z95P-K.AA75A8 (2022), writes to
> > /sys/devices/platform/lg-laptop/fan_mode have no effect and reads alway=
s
> > report a status of 0.
> >=20
> > Disassembling the relevant ACPI tables reveals that in the call
> >=20
> > =09lg_wmab(dev, WM_FAN_MODE, WM_SET, x)
> >=20
> > the new mode is read from either the upper nibble or the lower nibble o=
f x,
> > depending on the value of some other EC register.  Crucially, when WMAB
> > is called twice (once with the fan mode in the upper nibble, once with
> > it in the lower nibble), the result of the second call can overwrite
> > the first call.

Oh, one more thing. I think this would warrant a Fixes tag pointing to the=
=20
original commit.

--
 i.

> > Fix this by calling WMAB once, with the fan mode set in both nibbles.
> > As a bonus, the driver now supports the "Performance" mode seen in
> > the Windows LG Control Center app (less aggressive CPU throttling, but
> > louder fan noise and shorter battery life).  I can confirm that with
> > this patch writing/reading the fan mode works as expected on my laptop,
> > although I haven't tested it on any other LG laptops.
> >=20
> > Also, correct the documentation to reflect that a value of 0 correspond=
s
> > to the default mode (what the LG app calls "Optimal") and a value of 1
> > corresponds to the silent mode.
> >
> > Tested-by: Daniel <dany97@live.ca>
> > Signed-off-by: Daniel <dany97@live.ca>
> > ---
> >  .../admin-guide/laptops/lg-laptop.rst         |  4 ++--
> >  drivers/platform/x86/lg-laptop.c              | 22 +++++--------------
> >  2 files changed, 8 insertions(+), 18 deletions(-)
> >=20
> > diff --git a/Documentation/admin-guide/laptops/lg-laptop.rst b/Document=
ation/admin-guide/laptops/lg-laptop.rst
> > index 67fd6932c..c4dd534f9 100644
> > --- a/Documentation/admin-guide/laptops/lg-laptop.rst
> > +++ b/Documentation/admin-guide/laptops/lg-laptop.rst
> > @@ -48,8 +48,8 @@ This value is reset to 100 when the kernel boots.
> >  Fan mode
> >  --------
> > =20
> > -Writing 1/0 to /sys/devices/platform/lg-laptop/fan_mode disables/enabl=
es
> > -the fan silent mode.
> > +Writing 0/1/2 to /sys/devices/platform/lg-laptop/fan_mode sets fan mod=
e to
> > +Optimal/Silent/Performance respectively.
> > =20
> > =20
> >  USB charge
> > diff --git a/drivers/platform/x86/lg-laptop.c b/drivers/platform/x86/lg=
-laptop.c
> > index 4b57102c7..b8de6e568 100644
> > --- a/drivers/platform/x86/lg-laptop.c
> > +++ b/drivers/platform/x86/lg-laptop.c
> > @@ -274,29 +274,19 @@ static ssize_t fan_mode_store(struct device *dev,
> >  =09=09=09      struct device_attribute *attr,
> >  =09=09=09      const char *buffer, size_t count)
> >  {
> > -=09bool value;
> > +=09unsigned long value;
> >  =09union acpi_object *r;
> > -=09u32 m;
> >  =09int ret;
> > =20
> > -=09ret =3D kstrtobool(buffer, &value);
> > +=09ret =3D kstrtoul(buffer, 10, &value);
> >  =09if (ret)
> >  =09=09return ret;
> > +=09if (value >=3D 3)
> > +=09=09return -EINVAL;
> > =20
> > -=09r =3D lg_wmab(dev, WM_FAN_MODE, WM_GET, 0);
> > +=09r =3D lg_wmab(dev, WM_FAN_MODE, WM_SET, (value << 4) | value);
>=20
> Is it okay to remove preserving the other bits?
>=20
> Please name these field with defined GENMASK() and then use FIELD_PREP()=
=20
> here for both fields.
>=20
> >  =09if (!r)
> >  =09=09return -EIO;
> > -
> > -=09if (r->type !=3D ACPI_TYPE_INTEGER) {
> > -=09=09kfree(r);
> > -=09=09return -EIO;
> > -=09}
> > -
> > -=09m =3D r->integer.value;
> > -=09kfree(r);
> > -=09r =3D lg_wmab(dev, WM_FAN_MODE, WM_SET, (m & 0xffffff0f) | (value <=
< 4));
> > -=09kfree(r);
> > -=09r =3D lg_wmab(dev, WM_FAN_MODE, WM_SET, (m & 0xfffffff0) | value);
> >  =09kfree(r);
> > =20
> >  =09return count;
> > @@ -317,7 +307,7 @@ static ssize_t fan_mode_show(struct device *dev,
> >  =09=09return -EIO;
> >  =09}
> > =20
> > -=09status =3D r->integer.value & 0x01;
> > +=09status =3D r->integer.value & 0x03;
>=20
> This looks also like a field so should be named with a define?
>=20
> >  =09kfree(r);
> > =20
> >  =09return sysfs_emit(buffer, "%d\n", status);
> >=20
>=20
>=20
--8323328-105747440-1756379523=:938--

