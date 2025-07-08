Return-Path: <linux-kernel+bounces-721351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A0E6AFC806
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 12:12:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29C98166A6B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 10:12:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EA9A269808;
	Tue,  8 Jul 2025 10:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MXrXyGo7"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4C69267B9B;
	Tue,  8 Jul 2025 10:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751969531; cv=none; b=GTPvmHveyRVvgmar/m0lH+EgZ5wDhU17LuBvBPfJ1hllDfk/rUgP/4noX92iZ5+CVhXIfbuxACkntpsxNLH3muWr4TlhHMtd1Ve9itR4lPCJ8An3L1/bcSXvvJR1FYAGHxvCxA9aHLb04gMHeA0cwz8Lzm6bFsUQqJGkPfk9QI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751969531; c=relaxed/simple;
	bh=PJWJM3Ehu/5bBd9Wws7VR7DlxE3r9PIldJZ3RoWsnZU=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=gE5xy3UUPSbi+F25J6o56B+gWK/lMlBX0tTPM5N6ErGX4ttbVgRQjM/elCqJfdIFMIKk+VpbzQh252tyxaReF4ws4FbRSP7jxwIR4lwj6r1TINM3NFWOyQCcJap7xGF/sGI7w+OMNjIkXwQU/EUYAkzeunGNo9N7GuqZrfISYyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MXrXyGo7; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751969530; x=1783505530;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=PJWJM3Ehu/5bBd9Wws7VR7DlxE3r9PIldJZ3RoWsnZU=;
  b=MXrXyGo7Sr5boc/LZWm6E70lmt0m7FCnIaGpUk+F6raJPltE10l6V3nx
   35WVIgDxPinRgBw40jAMXuo+kBsyq9VR9LOSCfueuxCnHiq+ALuff0qAX
   2pztaqVieRV9vAxCbZJs1nltDgKxCgCIieIuiE+kk0bPx5iZmQmsGBlp/
   3TcakLMikUSm7fmQGh2SZE1JyRpPsdCFymPwOdzdR9nhitOy6L3Dj2221
   Lmvyw72lflFDrWfQnI9a+6keUoZbqxAk2SUvvfr3zOGHWzw2H3BMxm7W+
   /ndqLLvy9FPoCvXn5LnLouRHoiKLdc/QtPy/Ru9JjPu/6LVCAbH5C7tCg
   w==;
X-CSE-ConnectionGUID: QHwpdv0uSpG/uCyTyKXDww==
X-CSE-MsgGUID: mGyWhbOJT6KC6WLcL5m79Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="54174189"
X-IronPort-AV: E=Sophos;i="6.16,297,1744095600"; 
   d="scan'208";a="54174189"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 03:12:09 -0700
X-CSE-ConnectionGUID: HzfF7RAoQQ67Akk/Zj3SiQ==
X-CSE-MsgGUID: eNOwVlo4Sae1wf6PEnR5eg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,297,1744095600"; 
   d="scan'208";a="154870023"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.247])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 03:12:06 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 8 Jul 2025 13:12:03 +0300 (EEST)
To: Jackie Dong <xy-jackie@139.com>
cc: hansg@kernel.org, platform-driver-x86@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, dongeg1@lenovo.com
Subject: Re: [PATCH v3] lenovo-wmi-hotkey: Fixed a kernel error report for
 some Lenovo non-ThinkPad devices
In-Reply-To: <e45af10b-fa26-d7e4-8051-093a6f9ce552@linux.intel.com>
Message-ID: <d0eeb808-a57b-584d-1e92-c9ba7b0661fb@linux.intel.com>
References: <20250708094352.26850-1-xy-jackie@139.com> <e45af10b-fa26-d7e4-8051-093a6f9ce552@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1166893436-1751969523=:947"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1166893436-1751969523=:947
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

In addition, the shortlog should mention the error relates to not=20
supported mute LEDs.

I'd also drop "some Lenovo" from to make it shorter, I think the=20
explanation that is already in the changelog covers that (we cannot=20
put everything to the shortlog to keep it relatively short).

--=20
 i.

On Tue, 8 Jul 2025, Ilpo J=E4rvinen wrote:

> On Tue, 8 Jul 2025, Jackie Dong wrote:
>=20
> > Not all of Lenovo non-ThinkPad devices support both mic mute LED (on F4=
)
> > and audio mute LED (on F1). Some of them only support one mute LED, som=
e
> > of them don't have any mute LED. Add a decision to judge this device
> > support mute LED or not. Without this decision, not support both of mic
> > mute LED and audio mute LED Lenovo non-ThinkPad brand devices (includin=
g
> > Ideapad/Yoga/Xiaoxin/Gaming/ThinkBook, etc.) will report a failed messa=
ge
> > with error -5.
> >=20
> > Signed-off-by: Jackie Dong <xy-jackie@139.com>
> > Suggested-by: Hans de Goede <hansg@kernel.org>
> > Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>
>=20
> Hi Jackie,
>=20
> Please don't add Reviewed-by nor Tested-by tags unless they were=20
> explicitly given to you.
> =20
> > ---
> > Changes in v3:
> >  - Reverse orignal logic  (obj && obj->type =3D=3D ACPI_TYPE_INTEGER)=
=20
> >    and add new decision for led_version =3D=3D 0.
> >  - Optimize the descriptions based on reviewer comments.
> >=20
> > Changes in v2:
> >  - Add warning message and then return 0 if the device support mute LED
> >    abnormaly, based on Hans suggestion and Armin previous patch.
> >=20
> >=20
> >  .../x86/lenovo-wmi-hotkey-utilities.c         | 24 ++++++++++++++-----
> >  1 file changed, 18 insertions(+), 6 deletions(-)
> >=20
> > diff --git a/drivers/platform/x86/lenovo-wmi-hotkey-utilities.c b/drive=
rs/platform/x86/lenovo-wmi-hotkey-utilities.c
> > index 89153afd7015..1850992f2ea8 100644
> > --- a/drivers/platform/x86/lenovo-wmi-hotkey-utilities.c
> > +++ b/drivers/platform/x86/lenovo-wmi-hotkey-utilities.c
> > @@ -127,21 +127,30 @@ static int lenovo_super_hotkey_wmi_led_init(enum =
mute_led_type led_type, struct
> >  =09else
> >  =09=09return -EIO;
>=20
> The logic was not reversed as requested. Please change this code to:
>=20
> =09union acpi_object *obj __free(kfree) =3D output.pointer;
> =09if (!obj || obj->type !=3D ACPI_TYPE_INTEGER)
> =09=09return -EIO;
>=20
> =09led_version =3D obj->integer.value;
>=20
> > -=09wpriv->cdev[led_type].max_brightness =3D LED_ON;
> > -=09wpriv->cdev[led_type].flags =3D LED_CORE_SUSPENDRESUME;
> > +=09/*
> > +=09 * Output parameters define: 0 means mute LED is not supported, Non=
-zero means
> > +=09 * mute LED can be supported.
> > +=09 */
> > +=09if (led_version =3D=3D 0)
> > +=09=09return 0;
> > +
> > =20
> >  =09switch (led_type) {
> >  =09case MIC_MUTE:
> > -=09=09if (led_version !=3D WMI_LUD_SUPPORT_MICMUTE_LED_VER)
> > -=09=09=09return -EIO;
> > +=09=09if (led_version !=3D WMI_LUD_SUPPORT_MICMUTE_LED_VER) {
> > +=09=09=09pr_warn("The MIC_MUTE LED of this device isn't supported now.=
\n");
>=20
> Drop "now" (or change it to more precise explanation why).
>=20
> > +=09=09=09return 0;
> > +=09=09}
> > =20
> >  =09=09wpriv->cdev[led_type].name =3D "platform::micmute";
> >  =09=09wpriv->cdev[led_type].brightness_set_blocking =3D &lsh_wmi_micmu=
te_led_set;
> >  =09=09wpriv->cdev[led_type].default_trigger =3D "audio-micmute";
> >  =09=09break;
> >  =09case AUDIO_MUTE:
> > -=09=09if (led_version !=3D WMI_LUD_SUPPORT_AUDIOMUTE_LED_VER)
> > -=09=09=09return -EIO;
> > +=09=09if (led_version !=3D WMI_LUD_SUPPORT_AUDIOMUTE_LED_VER) {
> > +=09=09=09pr_warn("The AUDIO_MUTE LED of this device isn't supported no=
w.\n");
>=20
> Ditto.
>=20
> > +=09=09=09return 0;
> > +=09=09}
> > =20
> >  =09=09wpriv->cdev[led_type].name =3D "platform::mute";
> >  =09=09wpriv->cdev[led_type].brightness_set_blocking =3D &lsh_wmi_audio=
mute_led_set;
> > @@ -152,6 +161,9 @@ static int lenovo_super_hotkey_wmi_led_init(enum mu=
te_led_type led_type, struct
> >  =09=09return -EINVAL;
> >  =09}
> > =20
> > +=09wpriv->cdev[led_type].max_brightness =3D LED_ON;
> > +=09wpriv->cdev[led_type].flags =3D LED_CORE_SUSPENDRESUME;
> > +
> >  =09err =3D devm_led_classdev_register(dev, &wpriv->cdev[led_type]);
> >  =09if (err < 0) {
> >  =09=09dev_err(dev, "Could not register mute LED %d : %d\n", led_type, =
err);
> >=20
>=20
>=20
--8323328-1166893436-1751969523=:947--

