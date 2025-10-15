Return-Path: <linux-kernel+bounces-854131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44ABCBDD9DA
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 11:10:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 823373BECC0
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 09:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F48630B51C;
	Wed, 15 Oct 2025 09:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L4YHBcf0"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C6A2C235F;
	Wed, 15 Oct 2025 09:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760519395; cv=none; b=GLdVwRyZE0j63U7+8i9/qSofRDc+G83w8sCPCdIfOoUrH8Jtvmu1vDVnouQjSesnSf76WLJlorTo+Zim6ztACxaa6zzP2roOBDz2W8o/YIx2QE8iiTnMdlSmWAQnS1vHZtg4nGh7kY3o7gK+KCi5NZvOpO+wfhNfLbh0C2hDgTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760519395; c=relaxed/simple;
	bh=Q2imepIRxy+Aja1u+zpiCtLeIutd0XvIW3gSO3TJT9s=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=GVw28lqH3Fa92MwvTO37kSBOr2TfOEFnx7JxSNGy5Rd7CkRswakZ3nTLlmWzL6jjLeBNGpqmBMKXwFw4CJ8MVGBKDiAk5/LHE1ruAESN9LxqYFkd9PU70n5X7p6MZ+syAc4QrKnZv+fih8c4j216u/Muqnk2CWw5oYMfk6TXQK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L4YHBcf0; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760519393; x=1792055393;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Q2imepIRxy+Aja1u+zpiCtLeIutd0XvIW3gSO3TJT9s=;
  b=L4YHBcf00G709QB3zX3U2d3QAQ94/FAO2zD1LYJN1vNO5Osgpj0ADdAE
   5aqZDWSBHwvE2I20aqCiNtu9BF8+Ei3VET7Wp6jzQojXJBoOchGRc27Fg
   cxMPJLkLR9ejcDKgvbGwS/zm0vP6WBXee0esl1AKIWSzM4QUQrKTWaxv/
   eB9hsVsKwT2itMbgQ7PzauRAb0FpVUu+bhZxHDkYaj4y6/gi4SkUjZihV
   26ESj1rgZ1kqP2QjFco3Y6pKHbtSnu+uwQWXrh4lxFMUuj6H0qOwniaNq
   qx9DaVeQ1UnOh/0jUAp8oFmV0s8H8dKSRgKudRKYniySJPpWL0vE+kjwR
   w==;
X-CSE-ConnectionGUID: HKg1bdNRSlGYSV2Y/WvR8g==
X-CSE-MsgGUID: /NJeQEQcT46sAAdxsqsJ2Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11582"; a="85307065"
X-IronPort-AV: E=Sophos;i="6.19,230,1754982000"; 
   d="scan'208";a="85307065"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 02:09:53 -0700
X-CSE-ConnectionGUID: 55vFJz8cQj2DJOAfWmUEaQ==
X-CSE-MsgGUID: Px+iTmhGSH+j5jIFkmZ1pQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,230,1754982000"; 
   d="scan'208";a="182537776"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.75])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 02:09:50 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 15 Oct 2025 12:09:45 +0300 (EEST)
To: Antheas Kapenekakis <lkml@antheas.dev>
cc: platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    linux-hwmon@vger.kernel.org, Hans de Goede <hansg@kernel.org>, 
    Derek John Clark <derekjohn.clark@gmail.com>, 
    =?ISO-8859-15?Q?Joaqu=EDn_Ignacio_Aramend=EDa?= <samsagax@gmail.com>, 
    Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v2 5/6] platform/x86: ayaneo-ec: Move Ayaneo devices from
 oxpec to ayaneo-ec
In-Reply-To: <20251015084414.1391595-6-lkml@antheas.dev>
Message-ID: <d25bba2d-c48c-e687-f349-c011f5f9a2a7@linux.intel.com>
References: <20251015084414.1391595-1-lkml@antheas.dev> <20251015084414.1391595-6-lkml@antheas.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-90264879-1760519385=:957"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-90264879-1760519385=:957
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 15 Oct 2025, Antheas Kapenekakis wrote:

> Currently, the oxpec driver contains Ayaneo devices. Move them to the
> new ayaneo-ec driver, which is dedicated to them.
>=20
> As this driver supports charge inhibition for Ayaneo, add support for it
> for the AIR, AIR 1S, AB05-Medoncino, AIR Pro, and Kun, referenced from
> the out-of-tree ayaneo-platform driver.
>=20
> In addition, update the readmes of oxpec to reflect this change.
>=20
> Link: https://github.com/ShadowBlip/ayaneo-platform
> Tested-by: Derek J. Clark <derekjohn.clark@gmail.com>
> Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
> ---
>  drivers/platform/x86/Kconfig     |   4 +-
>  drivers/platform/x86/ayaneo-ec.c |  65 +++++++++++++++++
>  drivers/platform/x86/oxpec.c     | 115 +------------------------------
>  3 files changed, 67 insertions(+), 117 deletions(-)
>=20
> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
> index f5b2edc6bc67..4d4be1634152 100644
> --- a/drivers/platform/x86/Kconfig
> +++ b/drivers/platform/x86/Kconfig
> @@ -1043,9 +1043,7 @@ config OXP_EC
>  =09help
>  =09=09Enables support for the platform EC of OneXPlayer and AOKZOE
>  =09=09handheld devices. This includes fan speed, fan controls, and
> -=09=09disabling the default TDP behavior of the device. Due to legacy
> -=09=09reasons, this driver also provides hwmon functionality to Ayaneo
> -=09=09devices and the OrangePi Neo.
> +=09=09disabling the default TDP behavior of the device.
> =20
>  source "drivers/platform/x86/tuxedo/Kconfig"
> =20
> diff --git a/drivers/platform/x86/ayaneo-ec.c b/drivers/platform/x86/ayan=
eo-ec.c
> index 363b61fc6e12..73e9dd39c703 100644
> --- a/drivers/platform/x86/ayaneo-ec.c
> +++ b/drivers/platform/x86/ayaneo-ec.c
> @@ -49,6 +49,15 @@ struct ayaneo_ec_platform_data {
>  =09struct acpi_battery_hook battery_hook;
>  };
> =20
> +static const struct ayaneo_ec_quirk quirk_fan =3D {
> +=09.has_fan_control =3D true,
> +};
> +
> +static const struct ayaneo_ec_quirk quirk_charge_limit =3D {
> +=09.has_fan_control =3D true,
> +=09.has_charge_control =3D true,
> +};
> +
>  static const struct ayaneo_ec_quirk ayaneo3 =3D {
>  =09.has_fan_control =3D true,
>  =09.has_charge_control =3D true,
> @@ -56,6 +65,62 @@ static const struct ayaneo_ec_quirk ayaneo3 =3D {
>  };
> =20
>  static const struct dmi_system_id dmi_table[] =3D {
> +=09{
> +=09=09.matches =3D {
> +=09=09=09DMI_MATCH(DMI_BOARD_VENDOR, "AYANEO"),
> +=09=09=09DMI_MATCH(DMI_BOARD_NAME, "AYANEO 2"),
> +=09=09},
> +=09=09.driver_data =3D (void *)&quirk_fan,
> +=09},
> +=09{
> +=09=09.matches =3D {
> +=09=09=09DMI_MATCH(DMI_BOARD_VENDOR, "AYANEO"),
> +=09=09=09DMI_MATCH(DMI_BOARD_NAME, "FLIP"),
> +=09=09},
> +=09=09.driver_data =3D (void *)&quirk_fan,
> +=09},
> +=09{
> +=09=09.matches =3D {
> +=09=09=09DMI_MATCH(DMI_BOARD_VENDOR, "AYANEO"),
> +=09=09=09DMI_MATCH(DMI_BOARD_NAME, "GEEK"),
> +=09=09},
> +=09=09.driver_data =3D (void *)&quirk_fan,
> +=09},
> +=09{
> +=09=09.matches =3D {
> +=09=09=09DMI_MATCH(DMI_BOARD_VENDOR, "AYANEO"),
> +=09=09=09DMI_EXACT_MATCH(DMI_BOARD_NAME, "AIR"),
> +=09=09},
> +=09=09.driver_data =3D (void *)&quirk_charge_limit,
> +=09},
> +=09{
> +=09=09.matches =3D {
> +=09=09=09DMI_MATCH(DMI_BOARD_VENDOR, "AYANEO"),
> +=09=09=09DMI_EXACT_MATCH(DMI_BOARD_NAME, "AIR 1S"),
> +=09=09},
> +=09=09.driver_data =3D (void *)&quirk_charge_limit,
> +=09},
> +=09{
> +=09=09.matches =3D {
> +=09=09=09DMI_MATCH(DMI_BOARD_VENDOR, "AYANEO"),
> +=09=09=09DMI_EXACT_MATCH(DMI_BOARD_NAME, "AB05-Mendocino"),
> +=09=09},
> +=09=09.driver_data =3D (void *)&quirk_charge_limit,
> +=09},
> +=09{
> +=09=09.matches =3D {
> +=09=09=09DMI_MATCH(DMI_BOARD_VENDOR, "AYANEO"),
> +=09=09=09DMI_EXACT_MATCH(DMI_BOARD_NAME, "AIR Pro"),
> +=09=09},
> +=09=09.driver_data =3D (void *)&quirk_charge_limit,
> +=09},
> +=09{
> +=09=09.matches =3D {
> +=09=09=09DMI_MATCH(DMI_BOARD_VENDOR, "AYANEO"),
> +=09=09=09DMI_EXACT_MATCH(DMI_BOARD_NAME, "KUN"),
> +=09=09},
> +=09=09.driver_data =3D (void *)&quirk_charge_limit,
> +=09},
>  =09{
>  =09=09.matches =3D {
>  =09=09=09DMI_MATCH(DMI_BOARD_VENDOR, "AYANEO"),
> diff --git a/drivers/platform/x86/oxpec.c b/drivers/platform/x86/oxpec.c
> index 54377b282ff8..144a454103b9 100644
> --- a/drivers/platform/x86/oxpec.c
> +++ b/drivers/platform/x86/oxpec.c
> @@ -1,8 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0+
>  /*
> - * Platform driver for OneXPlayer and AOKZOE devices. For the time being=
,
> - * it also exposes fan controls for AYANEO, and OrangePi Handhelds via
> - * hwmon sysfs.
> + * Platform driver for OneXPlayer and AOKZOE devices.
>   *
>   * Fan control is provided via pwm interface in the range [0-255].
>   * Old AMD boards use [0-100] as range in the EC, the written value is
> @@ -43,14 +41,6 @@ static bool unlock_global_acpi_lock(void)
> =20
>  enum oxp_board {
>  =09aok_zoe_a1 =3D 1,
> -=09aya_neo_2,
> -=09aya_neo_air,
> -=09aya_neo_air_1s,
> -=09aya_neo_air_plus_mendo,
> -=09aya_neo_air_pro,
> -=09aya_neo_flip,
> -=09aya_neo_geek,
> -=09aya_neo_kun,
>  =09orange_pi_neo,
>  =09oxp_2,
>  =09oxp_fly,
> @@ -131,62 +121,6 @@ static const struct dmi_system_id dmi_table[] =3D {
>  =09=09},
>  =09=09.driver_data =3D (void *)oxp_fly,
>  =09},
> -=09{
> -=09=09.matches =3D {
> -=09=09=09DMI_MATCH(DMI_BOARD_VENDOR, "AYANEO"),
> -=09=09=09DMI_MATCH(DMI_BOARD_NAME, "AYANEO 2"),
> -=09=09},
> -=09=09.driver_data =3D (void *)aya_neo_2,
> -=09},
> -=09{
> -=09=09.matches =3D {
> -=09=09=09DMI_MATCH(DMI_BOARD_VENDOR, "AYANEO"),
> -=09=09=09DMI_EXACT_MATCH(DMI_BOARD_NAME, "AIR"),
> -=09=09},
> -=09=09.driver_data =3D (void *)aya_neo_air,
> -=09},
> -=09{
> -=09=09.matches =3D {
> -=09=09=09DMI_MATCH(DMI_BOARD_VENDOR, "AYANEO"),
> -=09=09=09DMI_EXACT_MATCH(DMI_BOARD_NAME, "AIR 1S"),
> -=09=09},
> -=09=09.driver_data =3D (void *)aya_neo_air_1s,
> -=09},
> -=09{
> -=09=09.matches =3D {
> -=09=09=09DMI_MATCH(DMI_BOARD_VENDOR, "AYANEO"),
> -=09=09=09DMI_EXACT_MATCH(DMI_BOARD_NAME, "AB05-Mendocino"),
> -=09=09},
> -=09=09.driver_data =3D (void *)aya_neo_air_plus_mendo,
> -=09},
> -=09{
> -=09=09.matches =3D {
> -=09=09=09DMI_MATCH(DMI_BOARD_VENDOR, "AYANEO"),
> -=09=09=09DMI_EXACT_MATCH(DMI_BOARD_NAME, "AIR Pro"),
> -=09=09},
> -=09=09.driver_data =3D (void *)aya_neo_air_pro,
> -=09},
> -=09{
> -=09=09.matches =3D {
> -=09=09=09DMI_MATCH(DMI_BOARD_VENDOR, "AYANEO"),
> -=09=09=09DMI_MATCH(DMI_BOARD_NAME, "FLIP"),
> -=09=09},
> -=09=09.driver_data =3D (void *)aya_neo_flip,
> -=09},
> -=09{
> -=09=09.matches =3D {
> -=09=09=09DMI_MATCH(DMI_BOARD_VENDOR, "AYANEO"),
> -=09=09=09DMI_MATCH(DMI_BOARD_NAME, "GEEK"),
> -=09=09},
> -=09=09.driver_data =3D (void *)aya_neo_geek,
> -=09},
> -=09{
> -=09=09.matches =3D {
> -=09=09=09DMI_MATCH(DMI_BOARD_VENDOR, "AYANEO"),
> -=09=09=09DMI_EXACT_MATCH(DMI_BOARD_NAME, "KUN"),
> -=09=09},
> -=09=09.driver_data =3D (void *)aya_neo_kun,
> -=09},
>  =09{
>  =09=09.matches =3D {
>  =09=09=09DMI_MATCH(DMI_BOARD_VENDOR, "OrangePi"),
> @@ -672,13 +606,6 @@ static int oxp_pwm_enable(void)
>  =09case orange_pi_neo:
>  =09=09return write_to_ec(ORANGEPI_SENSOR_PWM_ENABLE_REG, PWM_MODE_MANUAL=
);
>  =09case aok_zoe_a1:
> -=09case aya_neo_2:
> -=09case aya_neo_air:
> -=09case aya_neo_air_plus_mendo:
> -=09case aya_neo_air_pro:
> -=09case aya_neo_flip:
> -=09case aya_neo_geek:
> -=09case aya_neo_kun:
>  =09case oxp_2:
>  =09case oxp_fly:
>  =09case oxp_mini_amd:
> @@ -699,14 +626,6 @@ static int oxp_pwm_disable(void)
>  =09case orange_pi_neo:
>  =09=09return write_to_ec(ORANGEPI_SENSOR_PWM_ENABLE_REG, PWM_MODE_AUTO);
>  =09case aok_zoe_a1:
> -=09case aya_neo_2:
> -=09case aya_neo_air:
> -=09case aya_neo_air_1s:
> -=09case aya_neo_air_plus_mendo:
> -=09case aya_neo_air_pro:
> -=09case aya_neo_flip:
> -=09case aya_neo_geek:
> -=09case aya_neo_kun:
>  =09case oxp_2:
>  =09case oxp_fly:
>  =09case oxp_mini_amd:
> @@ -727,14 +646,6 @@ static int oxp_pwm_read(long *val)
>  =09case orange_pi_neo:
>  =09=09return read_from_ec(ORANGEPI_SENSOR_PWM_ENABLE_REG, 1, val);
>  =09case aok_zoe_a1:
> -=09case aya_neo_2:
> -=09case aya_neo_air:
> -=09case aya_neo_air_1s:
> -=09case aya_neo_air_plus_mendo:
> -=09case aya_neo_air_pro:
> -=09case aya_neo_flip:
> -=09case aya_neo_geek:
> -=09case aya_neo_kun:
>  =09case oxp_2:
>  =09case oxp_fly:
>  =09case oxp_mini_amd:
> @@ -774,14 +685,6 @@ static int oxp_pwm_fan_speed(long *val)
>  =09case oxp_g1_i:
>  =09=09return read_from_ec(OXP_2_SENSOR_FAN_REG, 2, val);
>  =09case aok_zoe_a1:
> -=09case aya_neo_2:
> -=09case aya_neo_air:
> -=09case aya_neo_air_1s:
> -=09case aya_neo_air_plus_mendo:
> -=09case aya_neo_air_pro:
> -=09case aya_neo_flip:
> -=09case aya_neo_geek:
> -=09case aya_neo_kun:
>  =09case oxp_fly:
>  =09case oxp_mini_amd:
>  =09case oxp_mini_amd_a07:
> @@ -810,14 +713,6 @@ static int oxp_pwm_input_write(long val)
>  =09=09/* scale to range [0-184] */
>  =09=09val =3D (val * 184) / 255;
>  =09=09return write_to_ec(OXP_SENSOR_PWM_REG, val);
> -=09case aya_neo_2:
> -=09case aya_neo_air:
> -=09case aya_neo_air_1s:
> -=09case aya_neo_air_plus_mendo:
> -=09case aya_neo_air_pro:
> -=09case aya_neo_flip:
> -=09case aya_neo_geek:
> -=09case aya_neo_kun:
>  =09case oxp_mini_amd:
>  =09case oxp_mini_amd_a07:
>  =09=09/* scale to range [0-100] */
> @@ -854,14 +749,6 @@ static int oxp_pwm_input_read(long *val)
>  =09=09/* scale from range [0-184] */
>  =09=09*val =3D (*val * 255) / 184;
>  =09=09break;
> -=09case aya_neo_2:
> -=09case aya_neo_air:
> -=09case aya_neo_air_1s:
> -=09case aya_neo_air_plus_mendo:
> -=09case aya_neo_air_pro:
> -=09case aya_neo_flip:
> -=09case aya_neo_geek:
> -=09case aya_neo_kun:
>  =09case oxp_mini_amd:
>  =09case oxp_mini_amd_a07:
>  =09=09ret =3D read_from_ec(OXP_SENSOR_PWM_REG, 1, val);
>=20

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.

--8323328-90264879-1760519385=:957--

