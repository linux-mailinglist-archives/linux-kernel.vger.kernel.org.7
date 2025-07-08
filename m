Return-Path: <linux-kernel+bounces-721348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C54E7AFC7F3
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 12:10:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37900188059D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 10:09:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1859926AAAA;
	Tue,  8 Jul 2025 10:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l707r4NI"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3BCC269885;
	Tue,  8 Jul 2025 10:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751969277; cv=none; b=YPKkl7FNpFAajuo4CDyi7qu0bBqNklxYl6Ri4sGAVIn4hhCyUhRxKv97d9ZQq/dFRIVyWK1b6Uk6EH9jDaAJYqCNibGdEqpcqMu6tUwAM6dm4lFgtHFDW0GxEI7MqI2bmM4HUiDDYtTrDx5tg28gyLREOXGcSQKqLOtKBu5eVjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751969277; c=relaxed/simple;
	bh=+mu09oHSFo0ENwJpcYeWTlUN02M1SVr8mPystHJp6wQ=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=oPOHS7MnHKsJTAWknu9XHJ7QtnZeoYBvf1YBTzC/WKpyZ1kIu/FDXNP8b9QFIYJU4IoFZhHIrlTcgFjZncdnTC7bmiMRtaryHWHWyd35STT1KdnoPqFJwofbEm8FhlBXewOLkkeDy0nmy1iA5uPa0GZQTcfIVONEmsnJyZXqNGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l707r4NI; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751969276; x=1783505276;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=+mu09oHSFo0ENwJpcYeWTlUN02M1SVr8mPystHJp6wQ=;
  b=l707r4NIwiqvXVYT3fdnQvxeJbhmJaWmbXHngwXYNMCR+YmYLRp2LW1W
   RstsZzy/mlFxQext0wt9SGe6gjmYmLulE1T7MM/HR+KobSlqmZrzBKU84
   wiGK3IhwidG7PC2Vdv+CHKXS4HvimEQC7UEy/BFgYsUrBVpjmz7EjmM9v
   WVmUuqHMs9OAVkA8OGex0DFHpIz/TTTO5CRp0ZCVLWyxiTLx2Zq72Omd9
   GJv0vXdiSiwx0q38wJEEWGectKCCDAM3pNOqI7cmPZq5hwFbcOHGPJCmd
   DSjyE6xndySYtGdId1oPqOTHO4THkyrtHlGpKA2V3li4so1Mp5EFlwOrs
   A==;
X-CSE-ConnectionGUID: SXWm8hGPS0ytn+ccywEdJQ==
X-CSE-MsgGUID: uSQJvVJyQqi1GIvNI1bOcQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="71783239"
X-IronPort-AV: E=Sophos;i="6.16,297,1744095600"; 
   d="scan'208";a="71783239"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 03:07:55 -0700
X-CSE-ConnectionGUID: 9ZDZ+X/JQsq5EMv95U/8CA==
X-CSE-MsgGUID: 5hv9hNiGSfeUKvS4LdxAVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,297,1744095600"; 
   d="scan'208";a="186410031"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.247])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 03:07:52 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 8 Jul 2025 13:07:49 +0300 (EEST)
To: Jackie Dong <xy-jackie@139.com>
cc: hansg@kernel.org, platform-driver-x86@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, dongeg1@lenovo.com
Subject: Re: [PATCH v3] lenovo-wmi-hotkey: Fixed a kernel error report for
 some Lenovo non-ThinkPad devices
In-Reply-To: <20250708094352.26850-1-xy-jackie@139.com>
Message-ID: <e45af10b-fa26-d7e4-8051-093a6f9ce552@linux.intel.com>
References: <20250708094352.26850-1-xy-jackie@139.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-2107425336-1751969014=:947"
Content-ID: <9fd99530-fdbe-d2e2-19c3-ed13e9c4f86a@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-2107425336-1751969014=:947
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <1601a485-9d89-d78d-7b0f-786d481b8ce7@linux.intel.com>

On Tue, 8 Jul 2025, Jackie Dong wrote:

> Not all of Lenovo non-ThinkPad devices support both mic mute LED (on F4)
> and audio mute LED (on F1). Some of them only support one mute LED, some
> of them don't have any mute LED. Add a decision to judge this device
> support mute LED or not. Without this decision, not support both of mic
> mute LED and audio mute LED Lenovo non-ThinkPad brand devices (including
> Ideapad/Yoga/Xiaoxin/Gaming/ThinkBook, etc.) will report a failed message
> with error -5.
>=20
> Signed-off-by: Jackie Dong <xy-jackie@139.com>
> Suggested-by: Hans de Goede <hansg@kernel.org>
> Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

Hi Jackie,

Please don't add Reviewed-by nor Tested-by tags unless they were=20
explicitly given to you.
=20
> ---
> Changes in v3:
>  - Reverse orignal logic  (obj && obj->type =3D=3D ACPI_TYPE_INTEGER)=20
>    and add new decision for led_version =3D=3D 0.
>  - Optimize the descriptions based on reviewer comments.
>=20
> Changes in v2:
>  - Add warning message and then return 0 if the device support mute LED
>    abnormaly, based on Hans suggestion and Armin previous patch.
>=20
>=20
>  .../x86/lenovo-wmi-hotkey-utilities.c         | 24 ++++++++++++++-----
>  1 file changed, 18 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/platform/x86/lenovo-wmi-hotkey-utilities.c b/drivers=
/platform/x86/lenovo-wmi-hotkey-utilities.c
> index 89153afd7015..1850992f2ea8 100644
> --- a/drivers/platform/x86/lenovo-wmi-hotkey-utilities.c
> +++ b/drivers/platform/x86/lenovo-wmi-hotkey-utilities.c
> @@ -127,21 +127,30 @@ static int lenovo_super_hotkey_wmi_led_init(enum mu=
te_led_type led_type, struct
>  =09else
>  =09=09return -EIO;

The logic was not reversed as requested. Please change this code to:

=09union acpi_object *obj __free(kfree) =3D output.pointer;
=09if (!obj || obj->type !=3D ACPI_TYPE_INTEGER)
=09=09return -EIO;

=09led_version =3D obj->integer.value;

> -=09wpriv->cdev[led_type].max_brightness =3D LED_ON;
> -=09wpriv->cdev[led_type].flags =3D LED_CORE_SUSPENDRESUME;
> +=09/*
> +=09 * Output parameters define: 0 means mute LED is not supported, Non-z=
ero means
> +=09 * mute LED can be supported.
> +=09 */
> +=09if (led_version =3D=3D 0)
> +=09=09return 0;
> +
> =20
>  =09switch (led_type) {
>  =09case MIC_MUTE:
> -=09=09if (led_version !=3D WMI_LUD_SUPPORT_MICMUTE_LED_VER)
> -=09=09=09return -EIO;
> +=09=09if (led_version !=3D WMI_LUD_SUPPORT_MICMUTE_LED_VER) {
> +=09=09=09pr_warn("The MIC_MUTE LED of this device isn't supported now.\n=
");

Drop "now" (or change it to more precise explanation why).

> +=09=09=09return 0;
> +=09=09}
> =20
>  =09=09wpriv->cdev[led_type].name =3D "platform::micmute";
>  =09=09wpriv->cdev[led_type].brightness_set_blocking =3D &lsh_wmi_micmute=
_led_set;
>  =09=09wpriv->cdev[led_type].default_trigger =3D "audio-micmute";
>  =09=09break;
>  =09case AUDIO_MUTE:
> -=09=09if (led_version !=3D WMI_LUD_SUPPORT_AUDIOMUTE_LED_VER)
> -=09=09=09return -EIO;
> +=09=09if (led_version !=3D WMI_LUD_SUPPORT_AUDIOMUTE_LED_VER) {
> +=09=09=09pr_warn("The AUDIO_MUTE LED of this device isn't supported now.=
\n");

Ditto.

> +=09=09=09return 0;
> +=09=09}
> =20
>  =09=09wpriv->cdev[led_type].name =3D "platform::mute";
>  =09=09wpriv->cdev[led_type].brightness_set_blocking =3D &lsh_wmi_audiomu=
te_led_set;
> @@ -152,6 +161,9 @@ static int lenovo_super_hotkey_wmi_led_init(enum mute=
_led_type led_type, struct
>  =09=09return -EINVAL;
>  =09}
> =20
> +=09wpriv->cdev[led_type].max_brightness =3D LED_ON;
> +=09wpriv->cdev[led_type].flags =3D LED_CORE_SUSPENDRESUME;
> +
>  =09err =3D devm_led_classdev_register(dev, &wpriv->cdev[led_type]);
>  =09if (err < 0) {
>  =09=09dev_err(dev, "Could not register mute LED %d : %d\n", led_type, er=
r);
>=20

--=20
 i.
--8323328-2107425336-1751969014=:947--

