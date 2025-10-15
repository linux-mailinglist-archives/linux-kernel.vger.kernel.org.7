Return-Path: <linux-kernel+bounces-854180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B2FDBDDC77
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 11:29:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 63E47502E90
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 09:28:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B449231B138;
	Wed, 15 Oct 2025 09:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kkBjVXrp"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E98ED31B13F;
	Wed, 15 Oct 2025 09:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760520442; cv=none; b=qDFyD/cxgamVGUEnMP/WZNtcP0qgkgcB/G/3wDqhP/IWOTzPughanObzjOBt/OALe8Nu1m9J6iA038tNKUgWSv11NCjkA1o99+oASRzGLsgfYC5QD1m3I4TrTAiX73mFFLd1DuJ5YGmkeTzLXntHo3NID6uzdq5fNwwAm3qDSUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760520442; c=relaxed/simple;
	bh=FXPuebbMfYiOLZFgI038hnYDViLtuUcQU1rzllrzeLg=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=UPDPvWqC5yr3y2QVmJlCjG8HgCN/4QuB7BwH40JAJfyDn3Ac6OJizuz8Q1ra1ARrCqY2tKOOOEXx+rZY8tKCKe8uXmoBoHHER3x5Q2FDczWQrGlkBg8/XtvxwAq01ue6NxdEcgjaJhBohmnwN3CH6LhSVK7kjJpkDjYskiwUaw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kkBjVXrp; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760520440; x=1792056440;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=FXPuebbMfYiOLZFgI038hnYDViLtuUcQU1rzllrzeLg=;
  b=kkBjVXrp3PEYnzejxZ1ZtLw267P9xQAg5tZ76jbuBpdL/Pm/u4go2U6B
   W4y9J+SsSnsb3cxwpTatWN3K17XYVdb6wv5ynGkg9D888uth5HeskqceC
   nbr1ggAmTuxp+U12sn9ODPxoOud6YQKpxCRBzsGcB7R5UDh+mRwMze5p0
   rmohUaq5qD6GPuXps9QraMnICf4MKZUIhHcpBx3j2qG/i5eHzecOys6Nk
   BOLizeDUTdT6z0C0q58E7kuNw98rs/NrwxFVI8Z6pY0WTw0eaOGvRgoGc
   c87KOwPCRwytHpZufAVfI0JfCH/yb9R2rlRYB1Z1MHea1/DKPsKo7rGte
   w==;
X-CSE-ConnectionGUID: lZzcNnEXSKykr433Emm1Aw==
X-CSE-MsgGUID: onndMpY5SnGfFFoZ7Cm24Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11582"; a="74031252"
X-IronPort-AV: E=Sophos;i="6.19,230,1754982000"; 
   d="scan'208";a="74031252"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 02:27:19 -0700
X-CSE-ConnectionGUID: jEqvMQxTQLiRYS0lL07pUg==
X-CSE-MsgGUID: H8Jp3NiOSKaYzqMUMtPmNQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,230,1754982000"; 
   d="scan'208";a="187207519"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.75])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 02:27:15 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 15 Oct 2025 12:27:11 +0300 (EEST)
To: Antheas Kapenekakis <lkml@antheas.dev>
cc: platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    linux-hwmon@vger.kernel.org, Hans de Goede <hansg@kernel.org>, 
    Derek John Clark <derekjohn.clark@gmail.com>, 
    =?ISO-8859-15?Q?Joaqu=EDn_Ignacio_Aramend=EDa?= <samsagax@gmail.com>, 
    Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v2 6/6] platform/x86: ayaneo-ec: Add suspend hook
In-Reply-To: <CAGwozwHsMErRA+eDSCH+3XU6Q4Up7qTSqJ5y29-SdP0aMErUTg@mail.gmail.com>
Message-ID: <f4f51eef-424e-2290-f6e3-ba4e5c3427e9@linux.intel.com>
References: <20251015084414.1391595-1-lkml@antheas.dev> <20251015084414.1391595-7-lkml@antheas.dev> <de1f9cd3-183e-7b01-72aa-23fa4d30334e@linux.intel.com> <CAGwozwHsMErRA+eDSCH+3XU6Q4Up7qTSqJ5y29-SdP0aMErUTg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1544826445-1760520431=:957"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1544826445-1760520431=:957
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 15 Oct 2025, Antheas Kapenekakis wrote:

> On Wed, 15 Oct 2025 at 11:11, Ilpo J=C3=A4rvinen
> <ilpo.jarvinen@linux.intel.com> wrote:
> >
> > On Wed, 15 Oct 2025, Antheas Kapenekakis wrote:
> >
> > > The Ayaneo EC resets after hibernation, losing the charge control sta=
te.
> > > Add a small PM hook to restore this state on hibernation resume.
> > >
> > > The fan speed is also lost during hibernation, but since hibernation
> > > failures are common with this class of devices, setting a low fan spe=
ed
> > > when the userspace program controlling the fan will potentially not
> > > take over could cause the device to overheat, so it is not restored.
> > >
> > > Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
> > > ---
> > >  drivers/platform/x86/ayaneo-ec.c | 42 ++++++++++++++++++++++++++++++=
++
> > >  1 file changed, 42 insertions(+)
> > >
> > > diff --git a/drivers/platform/x86/ayaneo-ec.c b/drivers/platform/x86/=
ayaneo-ec.c
> > > index 73e9dd39c703..8529f6f8dc69 100644
> > > --- a/drivers/platform/x86/ayaneo-ec.c
> > > +++ b/drivers/platform/x86/ayaneo-ec.c
> > > @@ -37,6 +37,8 @@
> > >  #define AYANEO_MODULE_LEFT   BIT(0)
> > >  #define AYANEO_MODULE_RIGHT  BIT(1)
> > >
> > > +#define AYANEO_CACHE_LEN     1
> > > +
> > >  struct ayaneo_ec_quirk {
> > >       bool has_fan_control;
> > >       bool has_charge_control;
> > > @@ -47,6 +49,8 @@ struct ayaneo_ec_platform_data {
> > >       struct platform_device *pdev;
> > >       struct ayaneo_ec_quirk *quirks;
> > >       struct acpi_battery_hook battery_hook;
> > > +
> > > +     u8 cache[AYANEO_CACHE_LEN];
> > >  };
> > >
> > >  static const struct ayaneo_ec_quirk quirk_fan =3D {
> > > @@ -464,10 +468,48 @@ static int ayaneo_ec_probe(struct platform_devi=
ce *pdev)
> > >       return 0;
> > >  }
> > >
> > > +static int ayaneo_freeze(struct device *dev)
> > > +{
> > > +     struct platform_device *pdev =3D to_platform_device(dev);
> > > +     struct ayaneo_ec_platform_data *data =3D platform_get_drvdata(p=
dev);
> > > +     int ret, i =3D 0;
> > > +
> > > +     if (data->quirks->has_charge_control) {
> > > +             ret =3D ec_read(AYANEO_CHARGE_REG, &data->cache[i]);
> > > +             if (ret)
> > > +                     return ret;
> > > +             i++;
> >
> > What is this for?
>=20
> Adding additional registers to restore. Currently, there is only one
> so it looks out of place.

When are patches for those additional registers going to be submitted?
If it's not like right around the corner, I'd prefer i be added only=20
at that time.

In any case, please mention in the changelog there's going to be more to=20
registers cache so it becomes justified why you're using an array for the=
=20
cache.

--=20
 i.

> > > +     }
> > > +
> > > +     return 0;
> > > +}
> > > +
> > > +static int ayaneo_thaw(struct device *dev)
> > > +{
> > > +     struct platform_device *pdev =3D to_platform_device(dev);
> > > +     struct ayaneo_ec_platform_data *data =3D platform_get_drvdata(p=
dev);
> > > +     int ret, i =3D 0;
> > > +
> > > +     if (data->quirks->has_charge_control) {
> > > +             ret =3D ec_write(AYANEO_CHARGE_REG, data->cache[i]);
> > > +             if (ret)
> > > +                     return ret;
> > > +             i++;
> >
> > Same question here.
> >
> > > +     }
> > > +
> > > +     return 0;
> > > +}
> > > +
> > > +static const struct dev_pm_ops ayaneo_pm_ops =3D {
> > > +     .freeze =3D ayaneo_freeze,
> > > +     .thaw =3D ayaneo_thaw,
> > > +};
> > > +
> > >  static struct platform_driver ayaneo_platform_driver =3D {
> > >       .driver =3D {
> > >               .name =3D "ayaneo-ec",
> > >               .dev_groups =3D ayaneo_ec_groups,
> > > +             .pm =3D &ayaneo_pm_ops,
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
--8323328-1544826445-1760520431=:957--

