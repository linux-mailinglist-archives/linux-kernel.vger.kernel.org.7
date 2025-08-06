Return-Path: <linux-kernel+bounces-757800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B22D7B1C6CE
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 15:28:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BEBF3B879E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 13:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E7A628C002;
	Wed,  6 Aug 2025 13:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rong.moe header.i=i@rong.moe header.b="XCAXcjz/"
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD9DD38FB9;
	Wed,  6 Aug 2025 13:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754486880; cv=pass; b=L6I8v2oZ1Nm7JuaPiUSw7Q18YJs0pyM3fdXOczM/1rOtcwour/Vzl7deB3KaIIKckiwUmfIec4HKpc6l/zY29rJvSFFfp+nNAmr6GybD6p3v4x5QHJm7s4BN0XDaUtGiXjgtQZ0/2qmnePg1JKPVcfQx+25Jkpw5ciVHtZV6YH4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754486880; c=relaxed/simple;
	bh=uwod64cGD3t3MPodVFrneCut/Qm+kw5RrWEjqJ4ExrI=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=Ufur/9x8P5C2QOEy8SRcAdJaFyTGxQfngCronsTgRrCjFjxK2PHjYJHKaj+YiWcDPiVwys/EWDaC8Rbv0LDzlHWdvgvvTa/JCLf5Ft6JDUj4RDodzc/kjnUF/X0wEdV6qz68SLVv2uD1dQ9UiWtDd+x0jHGsti27Z/TewussDec=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rong.moe; spf=pass smtp.mailfrom=rong.moe; dkim=pass (1024-bit key) header.d=rong.moe header.i=i@rong.moe header.b=XCAXcjz/; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rong.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rong.moe
ARC-Seal: i=1; a=rsa-sha256; t=1754486868; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=f1GEXlLRHeT8A0lYYL/9IXMl4mWE5bscHBPDZ3Wu04CltVP9MxmgK4JuvEMCaXeUTGfThupYBMhHrZ2+ttT33Um4roktjsF62/0nt8PhrIXoNI8i2vYhZuNxZVNgm/tmu8F54KvZeBddxDspJ3MHzbn1WdzdtQbszxOxsPTnKjw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1754486868; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Sjf1hR4mIQuk6UWa+bJ6/t1YFxeBe65cSA7XMVutELs=; 
	b=cgat9LO7C0HXBhQo8IOF+ALpQTdNHhYWIk0bsYLwgswh80WyCQ1NXdU9BCSTVxiZiC23xgB7jHtqVTOF3frOBNLbjzSb6jjte2Gb3aQJOq+iTVHjC13YbGOfhklRXdJRegwC6Uvz2f3TXdphwRUPw543LKaGEbeNl+Idm6zSR1Y=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=rong.moe;
	spf=pass  smtp.mailfrom=i@rong.moe;
	dmarc=pass header.from=<i@rong.moe>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1754486867;
	s=zmail; d=rong.moe; i=i@rong.moe;
	h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date:Date:MIME-Version:Message-Id:Reply-To;
	bh=Sjf1hR4mIQuk6UWa+bJ6/t1YFxeBe65cSA7XMVutELs=;
	b=XCAXcjz/ChR76acIMNgXP46EqRX2DiP0Jie7AbFHYXyLmaPSsNvblhq0FqgFRmjh
	2wmewukpE5g4J4ZGRh14uRTMeTtzE/aRbdn1et5Einl4AUCXYlyw+TeETxSUyXn54D6
	ivjuRUqZyYYSxdGUKkLSqbSIsPCHbymVpx2lAdtE=
Received: by mx.zohomail.com with SMTPS id 1754486864431704.8281568358202;
	Wed, 6 Aug 2025 06:27:44 -0700 (PDT)
Message-ID: <f99671f46a7c534f017fbe8912acde95e3186407.camel@rong.moe>
Subject: Re: [PATCH 1/2] platform/x86: ideapad-laptop: Decouple HW & cdev
 brightness for kbd backlight
From: Rong Zhang <i@rong.moe>
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Ike Panhc <ikepanhc@gmail.com>, "Derek J. Clark"
 <derekjohn.clark@gmail.com>,  Mark Pearson <mpearson-lenovo@squebb.ca>,
 Hans de Goede <hansg@kernel.org>, 	platform-driver-x86@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <21b856ae-eec2-ac32-fd2f-12a505e8e539@linux.intel.com>
References: <20250805140131.284122-1-i@rong.moe>
	 <20250805140131.284122-2-i@rong.moe>
	 <21b856ae-eec2-ac32-fd2f-12a505e8e539@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 06 Aug 2025 21:22:43 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.56.1-1 
X-ZohoMailClient: External

Hi Ilpo,

On Wed, 2025-08-06 at 14:19 +0300, Ilpo J=C3=A4rvinen wrote:
> On Tue, 5 Aug 2025, Rong Zhang wrote:
>=20
> > Some recent models come with an ambient light sensor (ALS). On these
> > models, their EC will automatically set the keyboard backlight to an
> > appropriate brightness when the effective "HW brightness" is 3. The ter=
m
> > "HW brightness" means that it cannot be perfectly mapped to an LED
> > classdev brightness, but the EC does use this predefined brightness
> > value to represent such a mode.
> >=20
> > Currently, the code processing keyboard backlight is coupled with LED
> > classdev, making it hard to expose the auto brightness (ALS) mode to th=
e
> > userspace.
> >=20
> > As the first step toward the goal, decouple HW brightness from LED
> > classdev brightness, and update comments about corresponding backlight
> > modes.
> >=20
> > Signed-off-by: Rong Zhang <i@rong.moe>
> > ---
> >  drivers/platform/x86/lenovo/ideapad-laptop.c | 125 +++++++++++++------
> >  1 file changed, 90 insertions(+), 35 deletions(-)
> >=20
> > diff --git a/drivers/platform/x86/lenovo/ideapad-laptop.c b/drivers/pla=
tform/x86/lenovo/ideapad-laptop.c
> > index fcebfbaf0460..5014c1d0b633 100644
> > --- a/drivers/platform/x86/lenovo/ideapad-laptop.c
> > +++ b/drivers/platform/x86/lenovo/ideapad-laptop.c
> > @@ -119,17 +119,40 @@ enum {
> >  };
> > =20
> >  /*
> > - * These correspond to the number of supported states - 1
> > - * Future keyboard types may need a new system, if there's a collision
> > - * KBD_BL_TRISTATE_AUTO has no way to report or set the auto state
> > - * so it effectively has 3 states, but needs to handle 4
> > + * The enumeration has two purposes:
> > + *   - as an internal identifier for all known types of keyboard backl=
ight
> > + *   - as a mandatory parameter of the KBLC command
> > + *
> > + * For each type, the HW brightness values are defined as follows:
> > + * +--------------------------+----------+-----+------+------+
> > + * |            HW brightness |        0 |   1 |    2 |    3 |
> > + * | Type                     |          |     |      |      |
> > + * +--------------------------+----------+-----+------+------+
> > + * | KBD_BL_STANDARD          |      off |  on |  N/A |  N/A |
> > + * +--------------------------+----------+-----+------+------+
> > + * | KBD_BL_TRISTATE          |      off | low | high |  N/A |
> > + * +--------------------------+----------+-----+------+------+
> > + * | KBD_BL_TRISTATE_AUTO     |      off | low | high | auto |
> > + * +--------------------------+----------+-----+------+------+
> > + *
> > + * We map LED classdev brightness for KBD_BL_TRISTATE_AUTO as follows:
> > + * +--------------------------+----------+-----+------+
> > + * |  LED classdev brightness |        0 |   1 |    2 |
> > + * | Operation                |          |     |      |
> > + * +--------------------------+----------+-----+------+
> > + * | Read                     | off/auto | low | high |
> > + * +--------------------------+----------+-----+------+
> > + * | Write                    |      off | low | high |
> > + * +--------------------------+----------+-----+------+
> >   */
> >  enum {
> > -	KBD_BL_STANDARD      =3D 1,
> > -	KBD_BL_TRISTATE      =3D 2,
> > -	KBD_BL_TRISTATE_AUTO =3D 3,
> > +	KBD_BL_STANDARD		=3D	1,
> > +	KBD_BL_TRISTATE		=3D	2,
> > +	KBD_BL_TRISTATE_AUTO	=3D	3,
>=20
> Pure space change for no reason. Please leave as is.

Sure. Will remove the change in v2.

> >  };
> > =20
> > +#define KBD_BL_AUTO_MODE_HW_BRIGHTNESS	3
> > +
> >  #define KBD_BL_QUERY_TYPE		0x1
> >  #define KBD_BL_TRISTATE_TYPE		0x5
> >  #define KBD_BL_TRISTATE_AUTO_TYPE	0x7
> > @@ -1559,7 +1582,25 @@ static int ideapad_kbd_bl_check_tristate(int typ=
e)
> >  	return (type =3D=3D KBD_BL_TRISTATE) || (type =3D=3D KBD_BL_TRISTATE_=
AUTO);
> >  }
> > =20
> > -static int ideapad_kbd_bl_brightness_get(struct ideapad_private *priv)
> > +static int ideapad_kbd_bl_brightness_parse(struct ideapad_private *pri=
v,
> > +					   unsigned int hw_brightness)
> > +{
> > +	/* Off, low or high */
> > +	if (hw_brightness <=3D priv->kbd_bl.led.max_brightness)
> > +		return hw_brightness;
> > +
> > +	/* Auto (controlled by EC according to ALS), report as off */
> > +	if (priv->kbd_bl.type =3D=3D KBD_BL_TRISTATE_AUTO &&
> > +	    hw_brightness =3D=3D KBD_BL_AUTO_MODE_HW_BRIGHTNESS)
> > +		return 0;
>=20
> There seems to be code move/function refactoring (split to get+parse)=20
> and changes mixed up in here as this doesn't match to what was there=20
> beforehand AFAICT.
>=20
> Could you please try to separate the pure function refactoring from the=
=20
> changes to make the real changes easier to understand/see.

Sure. Will move real changes into [PATCH v2 2/2]. Besides, the macro
KBD_BL_AUTO_MODE_HW_BRIGHTNESS will then be unused in [PATCH v2 1/2],
so I will also move it into [PATCH v2 2/2].

> > +	/* Unknown value */
> > +	dev_warn(&priv->platform_device->dev,
> > +		 "Unknown keyboard backlight value: %u", hw_brightness);
> > +	return -EINVAL;
> > +}
> > +
> > +static int ideapad_kbd_bl_hw_brightness_get(struct ideapad_private *pr=
iv)
> >  {
> >  	unsigned long value;
> >  	int err;
> > @@ -1573,21 +1614,7 @@ static int ideapad_kbd_bl_brightness_get(struct =
ideapad_private *priv)
> >  		if (err)
> >  			return err;
> > =20
> > -		/* Convert returned value to brightness level */
> > -		value =3D FIELD_GET(KBD_BL_GET_BRIGHTNESS, value);
> > -
> > -		/* Off, low or high */
> > -		if (value <=3D priv->kbd_bl.led.max_brightness)
> > -			return value;
> > -
> > -		/* Auto, report as off */
> > -		if (value =3D=3D priv->kbd_bl.led.max_brightness + 1)
> > -			return 0;
> > -
> > -		/* Unknown value */
> > -		dev_warn(&priv->platform_device->dev,
> > -			 "Unknown keyboard backlight value: %lu", value);
> > -		return -EINVAL;
> > +		return FIELD_GET(KBD_BL_GET_BRIGHTNESS, value);
> >  	}
> > =20
> >  	err =3D eval_hals(priv->adev->handle, &value);
> > @@ -1597,6 +1624,16 @@ static int ideapad_kbd_bl_brightness_get(struct =
ideapad_private *priv)
> >  	return !!test_bit(HALS_KBD_BL_STATE_BIT, &value);
> >  }
> > =20
> > +static int ideapad_kbd_bl_brightness_get(struct ideapad_private *priv)
> > +{
> > +	int hw_brightness =3D ideapad_kbd_bl_hw_brightness_get(priv);
> > +
> > +	if (hw_brightness < 0)
> > +		return hw_brightness;
> > +
> > +	return ideapad_kbd_bl_brightness_parse(priv, hw_brightness);
> > +}
> > +
> >  static enum led_brightness ideapad_kbd_bl_led_cdev_brightness_get(stru=
ct led_classdev *led_cdev)
> >  {
> >  	struct ideapad_private *priv =3D container_of(led_cdev, struct ideapa=
d_private, kbd_bl.led);
> > @@ -1604,24 +1641,37 @@ static enum led_brightness ideapad_kbd_bl_led_c=
dev_brightness_get(struct led_cla
> >  	return ideapad_kbd_bl_brightness_get(priv);
> >  }
> > =20
> > -static int ideapad_kbd_bl_brightness_set(struct ideapad_private *priv,=
 unsigned int brightness)
> > +static int ideapad_kbd_bl_hw_brightness_set(struct ideapad_private *pr=
iv,
> > +					    unsigned int hw_brightness)
> >  {
> >  	int err;
> >  	unsigned long value;
> >  	int type =3D priv->kbd_bl.type;
> > =20
> >  	if (ideapad_kbd_bl_check_tristate(type)) {
> > -		if (brightness > priv->kbd_bl.led.max_brightness)
> > -			return -EINVAL;
> > -
> > -		value =3D FIELD_PREP(KBD_BL_SET_BRIGHTNESS, brightness) |
> > +		value =3D FIELD_PREP(KBD_BL_SET_BRIGHTNESS, hw_brightness) |
> >  			FIELD_PREP(KBD_BL_COMMAND_TYPE, type) |
> >  			KBD_BL_COMMAND_SET;
> >  		err =3D exec_kblc(priv->adev->handle, value);
> >  	} else {
> > -		err =3D exec_sals(priv->adev->handle, brightness ? SALS_KBD_BL_ON : =
SALS_KBD_BL_OFF);
> > +		err =3D exec_sals(priv->adev->handle,
> > +				hw_brightness ? SALS_KBD_BL_ON : SALS_KBD_BL_OFF);
> >  	}
> > =20
> > +	if (err)
> > +		return err;
> > +
> > +	return 0;
> > +}
> > +
> > +static int ideapad_kbd_bl_brightness_set(struct ideapad_private *priv,=
 unsigned int brightness)
> > +{
> > +	int err;
> > +
> > +	if (brightness > priv->kbd_bl.led.max_brightness)
> > +		return -EINVAL;
> > +
> > +	err =3D ideapad_kbd_bl_hw_brightness_set(priv, brightness);
> >  	if (err)
> >  		return err;
> > =20
> > @@ -1638,6 +1688,16 @@ static int ideapad_kbd_bl_led_cdev_brightness_se=
t(struct led_classdev *led_cdev,
> >  	return ideapad_kbd_bl_brightness_set(priv, brightness);
> >  }
> > =20
> > +static void ideapad_kbd_bl_notify_known(struct ideapad_private *priv, =
unsigned int brightness)
> > +{
> > +	if (brightness =3D=3D priv->kbd_bl.last_brightness)
> > +		return;
> > +
> > +	priv->kbd_bl.last_brightness =3D brightness;
> > +
> > +	led_classdev_notify_brightness_hw_changed(&priv->kbd_bl.led, brightne=
ss);
> > +}
> > +
> >  static void ideapad_kbd_bl_notify(struct ideapad_private *priv)
> >  {
> >  	int brightness;
> > @@ -1649,12 +1709,7 @@ static void ideapad_kbd_bl_notify(struct ideapad=
_private *priv)
> >  	if (brightness < 0)
> >  		return;
> > =20
> > -	if (brightness =3D=3D priv->kbd_bl.last_brightness)
> > -		return;
> > -
> > -	priv->kbd_bl.last_brightness =3D brightness;
> > -
> > -	led_classdev_notify_brightness_hw_changed(&priv->kbd_bl.led, brightne=
ss);
> > +	ideapad_kbd_bl_notify_known(priv, brightness);
> >  }
> > =20
> >  static int ideapad_kbd_bl_init(struct ideapad_private *priv)
> >=20

Thanks for your review,
Rong

