Return-Path: <linux-kernel+bounces-757801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6DC8B1C6D8
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 15:34:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19D6E560B20
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 13:34:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AC6328BA92;
	Wed,  6 Aug 2025 13:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rong.moe header.i=i@rong.moe header.b="ycv1EeXp"
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B3419A;
	Wed,  6 Aug 2025 13:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754487237; cv=pass; b=YrO8n+x7eCUptRExzYY5C8Rc0V4nBCJXX3+F46085AgQnFs+Qc1n6/VSASQ139X2Pbi5DJiIecrA0MATjT/65UZCLy/XzVBcoKU9A/ZatRWFXat/kB3sC6/gzN9AQy8LkU0Ka3C3w3WDoHFFeSIAywyJ6PIwfk7YEhGMEcrN0gk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754487237; c=relaxed/simple;
	bh=2dOpAIADWbF4C8PVCONYvk4DELIrO2AJVZvujBeeo7M=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=NuchVGziPdDv1XZiqciojwUui3QwdvEmxG9sj5hV9UxziCkJaoR74iAWspBEbzaT4b+dl/MEaL/i4HYwnVguaxIdAuDoRRZdbNR5v1vT2I8TQod7VxsMKiQShZgfNiv12V5tdK42Fk6H0oGWz1waTDQbL2FMpjNJq5SyXM1Ezqo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rong.moe; spf=pass smtp.mailfrom=rong.moe; dkim=pass (1024-bit key) header.d=rong.moe header.i=i@rong.moe header.b=ycv1EeXp; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rong.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rong.moe
ARC-Seal: i=1; a=rsa-sha256; t=1754487223; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=QqrnqNINOdK12q5QUx5zBkEhg6O06NIYbwLwR17IXka+miZamWzxsSvT8Ym8S5TROOsuhMiuHZgnPjELlYcVOy8qvODgolnnWyhHB+vvKItUZSByUxd+Swtq66FF066aOEGibNQFZplZW1wu1Q4ATED7QUs18D683vShDglFaF8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1754487223; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=pYCTlk/GK40nYVeUtUwS5qlXulOvqUMfkNed0naDUDQ=; 
	b=Fu+f6p//RMxGO8LhCP6kzcoP1RvvsPM1pNn4Es25dPOoUycjj6KqaTkehMd7bh9Eb7TTIiSo5sBDxb7fg+MlzXqbMYmS3Z1XmixBp4JX4jUnshQU/q1jfFdhUd+yM/qN8OW9Uxse5QfcQM4kZtONwf8MB38qff34ZbzWeV4HGWA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=rong.moe;
	spf=pass  smtp.mailfrom=i@rong.moe;
	dmarc=pass header.from=<i@rong.moe>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1754487223;
	s=zmail; d=rong.moe; i=i@rong.moe;
	h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date:Date:MIME-Version:Message-Id:Reply-To;
	bh=pYCTlk/GK40nYVeUtUwS5qlXulOvqUMfkNed0naDUDQ=;
	b=ycv1EeXpYpdUiOwi7KAYBWKa/KEUInXVL0JKZQfFZvej36pQQF4OVT5zAfE+xxnz
	PlRDC2CsPbViUBfGgrLQAF98A1L1/BhW9m4n/V+Y0fRetXZarwxI3dx15lF3HcSfFWR
	id9ybrcPE1vylacRimfJAZj2aa6tUElYS7ooEJLM=
Received: by mx.zohomail.com with SMTPS id 1754487219747607.5034324774383;
	Wed, 6 Aug 2025 06:33:39 -0700 (PDT)
Message-ID: <b7ad97009fa0a49b9229ade0af5f526057869a36.camel@rong.moe>
Subject: Re: [PATCH 2/2] platform/x86: ideapad-laptop: Fully support auto
 kbd backlight
From: Rong Zhang <i@rong.moe>
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Ike Panhc <ikepanhc@gmail.com>, "Derek J. Clark"
 <derekjohn.clark@gmail.com>,  Mark Pearson <mpearson-lenovo@squebb.ca>,
 Hans de Goede <hansg@kernel.org>, 	platform-driver-x86@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <9a2fad3c-66d5-c877-698b-a9b5a589f081@linux.intel.com>
References: <20250805140131.284122-1-i@rong.moe>
	 <20250805140131.284122-3-i@rong.moe>
	 <9a2fad3c-66d5-c877-698b-a9b5a589f081@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 06 Aug 2025 21:28:39 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.56.1-1 
X-ZohoMailClient: External

Hi Ilpo,

On Wed, 2025-08-06 at 14:26 +0300, Ilpo J=C3=A4rvinen wrote:
> On Tue, 5 Aug 2025, Rong Zhang wrote:
>=20
> > Currently, the auto brightness mode of keyboard backlight maps to
> > brightness=3D0 in LED classdev. The only method to switch to such a mod=
e
> > is by pressing the manufacturer-defined shortcut (Fn+Space). However, 0
> > is a multiplexed brightness value; writing 0 simply results in the
> > backlight being turned off.
> >=20
> > With brightness processing code decoupled from LED classdev, we can now
> > fully support the auto brightness mode. In this mode, the keyboard
> > backlight is controlled by the EC according to the ambient light sensor
> > (ALS).
> >=20
> > To utilize this, a sysfs node is exposed to the userspace:
> > /sys/class/leds/platform::kbd_backlight/als_enabled. The name is chosen
> > to align with dell-laptop, which provides a similar feature.
> >=20
> > Signed-off-by: Rong Zhang <i@rong.moe>
> > ---
> >  .../ABI/testing/sysfs-platform-ideapad-laptop | 12 ++++
> >  drivers/platform/x86/lenovo/ideapad-laptop.c  | 65 ++++++++++++++++++-
> >  2 files changed, 75 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/Documentation/ABI/testing/sysfs-platform-ideapad-laptop b/=
Documentation/ABI/testing/sysfs-platform-ideapad-laptop
> > index 5ec0dee9e707..a2b78aa60aaa 100644
> > --- a/Documentation/ABI/testing/sysfs-platform-ideapad-laptop
> > +++ b/Documentation/ABI/testing/sysfs-platform-ideapad-laptop
> > @@ -50,3 +50,15 @@ Description:
> >  		Controls whether the "always on USB charging" feature is
> >  		enabled or not. This feature enables charging USB devices
> >  		even if the computer is not turned on.
> > +
> > +What:		/sys/class/leds/platform::kbd_backlight/als_enabled
> > +Date:		July 2025
> > +KernelVersion:	6.17
>=20
> This ship has sailed.

How time flies! It is embarrassing that I wrote this several weeks ago
but forgot to update it before finishing the patch. Thanks for your
reminder and I will update this in v2.

>=20
> > +Contact:	platform-driver-x86@vger.kernel.org
> > +Description:
> > +		This file allows to control the automatic keyboard
>=20
> Please avoid using "This file" entirely in the description.
>=20
> Start with "Controls ..."

Sure.

> > +		illumination mode on some systems that have an ambient
> > +		light sensor. Write 1 to this file to enable the auto
> > +		mode, 0 to disable it. In this mode, the actual
>=20
> What is "this mode" ? Did you mean, e.g., "When the auto mode is enabled,=
"
> ?

It does sound more understandable to describe it that way. Thanks for
your suggestion and I will improve the wording in v2.

> > +		brightness level is not available and reading the
> > +		"brightness" file always returns 0.
> > diff --git a/drivers/platform/x86/lenovo/ideapad-laptop.c b/drivers/pla=
tform/x86/lenovo/ideapad-laptop.c
> > index 5014c1d0b633..49f2fc68add4 100644
> > --- a/drivers/platform/x86/lenovo/ideapad-laptop.c
> > +++ b/drivers/platform/x86/lenovo/ideapad-laptop.c
> > @@ -1712,6 +1712,57 @@ static void ideapad_kbd_bl_notify(struct ideapad=
_private *priv)
> >  	ideapad_kbd_bl_notify_known(priv, brightness);
> >  }
> > =20
> > +static ssize_t als_enabled_show(struct device *dev,
> > +				struct device_attribute *attr,
> > +				char *buf)
> > +{
> > +	struct led_classdev *led_cdev =3D dev_get_drvdata(dev);
> > +	struct ideapad_private *priv =3D container_of(led_cdev, struct ideapa=
d_private, kbd_bl.led);
> > +	int hw_brightness;
> > +
> > +	hw_brightness =3D ideapad_kbd_bl_hw_brightness_get(priv);
> > +	if (hw_brightness < 0)
> > +		return hw_brightness;
> > +
> > +	return sysfs_emit(buf, "%d\n", hw_brightness =3D=3D KBD_BL_AUTO_MODE_=
HW_BRIGHTNESS);
> > +}
> > +
> > +static ssize_t als_enabled_store(struct device *dev,
> > +				 struct device_attribute *attr,
> > +				 const char *buf, size_t count)
> > +{
> > +	struct led_classdev *led_cdev =3D dev_get_drvdata(dev);
> > +	struct ideapad_private *priv =3D container_of(led_cdev, struct ideapa=
d_private, kbd_bl.led);
> > +	bool state;
> > +	int err;
> > +
> > +	err =3D kstrtobool(buf, &state);
> > +	if (err)
> > +		return err;
> > +
> > +	/*
> > +	 * Auto (ALS) mode uses a predefined HW brightness value. It is
> > +	 * impossible to disable it without setting another brightness value.
> > +	 * Set the brightness to 0 when disabling is requested.
> > +	 */
> > +	err =3D ideapad_kbd_bl_hw_brightness_set(priv, state ? KBD_BL_AUTO_MO=
DE_HW_BRIGHTNESS : 0);
> > +	if (err)
> > +		return err;
> > +
> > +	/* Both HW brightness values map to 0 in the LED classdev. */
> > +	ideapad_kbd_bl_notify_known(priv, 0);
> > +
> > +	return count;
> > +}
> > +
> > +static DEVICE_ATTR_RW(als_enabled);
> > +
> > +static struct attribute *ideapad_kbd_bl_als_attrs[] =3D {
> > +	&dev_attr_als_enabled.attr,
> > +	NULL,
> > +};
> > +ATTRIBUTE_GROUPS(ideapad_kbd_bl_als);
> > +
> >  static int ideapad_kbd_bl_init(struct ideapad_private *priv)
> >  {
> >  	int brightness, err;
> > @@ -1722,10 +1773,20 @@ static int ideapad_kbd_bl_init(struct ideapad_p=
rivate *priv)
> >  	if (WARN_ON(priv->kbd_bl.initialized))
> >  		return -EEXIST;
> > =20
> > -	if (ideapad_kbd_bl_check_tristate(priv->kbd_bl.type)) {
> > +	switch (priv->kbd_bl.type) {
> > +	case KBD_BL_TRISTATE_AUTO:
> > +		/* The sysfs node will be /sys/class/leds/platform::kbd_backlight/al=
s_enabled */
> > +		priv->kbd_bl.led.groups =3D ideapad_kbd_bl_als_groups;
> > +		fallthrough;
> > +	case KBD_BL_TRISTATE:
> >  		priv->kbd_bl.led.max_brightness =3D 2;
> > -	} else {
> > +		break;
> > +	case KBD_BL_STANDARD:
> >  		priv->kbd_bl.led.max_brightness =3D 1;
> > +		break;
> > +	default:
> > +		/* This has already been validated by ideapad_check_features(). */
> > +		unreachable();
> >  	}
> > =20
> >  	brightness =3D ideapad_kbd_bl_brightness_get(priv);
> >=20

Thanks for your review,
Rong

