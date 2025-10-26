Return-Path: <linux-kernel+bounces-870661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3432DC0B639
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 23:45:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11FB7189DC3C
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 22:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 321B2171C9;
	Sun, 26 Oct 2025 22:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="FoIGKjdi"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91CDD2FF14A;
	Sun, 26 Oct 2025 22:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761518711; cv=none; b=qljeg/HMpgPgNinfIiIKOdFM15bK/ciN1v40pH5AYbzplmwUC1xKorLmi60hWwEb7WAw2uHmLBLKPe9Qr5J6VLnwnuHNCJ8+422aEbLnU2g9kY86on1jz1s6OhcwgOCwuJRFxylLfB1Ep4n6R5Iqk+VwtYjIWtA4uQW4mJzOZps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761518711; c=relaxed/simple;
	bh=zaxV4JRRz/qn3O+6LLn9hdqTNFkO3h5a3GYhFgF1feU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XgmwDFl4POSmUIzc4vDW2TwlXvyXbuXf1aqF6ixT2G512TBYPA5cMuXbcd1Bk0Oi9VI82ji6DSf8lSqUmJiVJHv5Oj+puuZKw/ntTrrPvRGsNHWophBjA+r9KuIF1mYOsgVOdDcFaaofkJ1kUB0LJsa9d99VSv8QvpuakKAifXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=FoIGKjdi; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1761518705; x=1762123505; i=w_armin@gmx.de;
	bh=zkcgsk6sxZUElntgbbuwqEbnGX1osSWN9RIU1b4ZSaQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=FoIGKjdiGig2BcSh5PiWARw8hzGXZy3NY3uRKcpb8ekzh7soaiZLq+9KKOi3r5CX
	 YeercGIC/voK/a8HG0sggrI1WpkQcyUZujWsOTSHfTVHYvGQTpoeLB3WgQ8hvj3ja
	 2FXt3LPlkVARORKI/2PRVuQtebInPWoKW79ia7HJsZmkFPQ8mMAKFyHph9QOZPQCI
	 SZfN/HIC/vTdXLL/RauCJysIAAwK3WFdSiQtvSNBWq8b2f/TfjnN7KkTuC3gZgVuu
	 teWzBsr39PiGwnQR8fgW5zdl19+p9lhacB9FYWOevov7RE2zo7ZXX4usmQOhK1k/S
	 TrPOuS/jKye2mcwumQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.69] ([93.202.247.91]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MrhUK-1uPUqT1fTI-00mv2h; Sun, 26
 Oct 2025 23:45:05 +0100
Message-ID: <1fb87443-f1fa-45d1-ae87-3ec2be6ce3ce@gmx.de>
Date: Sun, 26 Oct 2025 23:45:03 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/6] platform/x86: ayaneo-ec: Move Ayaneo devices from
 oxpec to ayaneo-ec
To: Antheas Kapenekakis <lkml@antheas.dev>,
 platform-driver-x86@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
 Hans de Goede <hansg@kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Derek John Clark <derekjohn.clark@gmail.com>,
 =?UTF-8?Q?Joaqu=C3=ADn_Ignacio_Aramend=C3=ADa?= <samsagax@gmail.com>,
 Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>
References: <20251015084414.1391595-1-lkml@antheas.dev>
 <20251015084414.1391595-6-lkml@antheas.dev>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <20251015084414.1391595-6-lkml@antheas.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:BVcnPDZ6SGGdj+lZ4d38ZSA+P16MxEp5X16FffDoX7pzgy1i+lz
 juWvMTuwsDe6Bn536VEI2P2UP896KuW6TePMCNHfHWtz3qe9y7ytLc/LjceZEyrfMuMXpxo
 +w82ay0UK98G/ovPIftATBJmAagPIN37QQw0RIK2SjZVTdwjmKsOd3nSMiHYVPYyFL0VUtl
 kzFJyKs6Qrlmc34wvm1Bg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:9XRIPaopFbI=;qNdRa9lsC8fFIuMpiuqqgbOoaEJ
 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

Am 15.10.25 um 10:44 schrieb Antheas Kapenekakis:

> Currently, the oxpec driver contains Ayaneo devices. Move them to the
> new ayaneo-ec driver, which is dedicated to them.
>
> As this driver supports charge inhibition for Ayaneo, add support for it
> for the AIR, AIR 1S, AB05-Medoncino, AIR Pro, and Kun, referenced from
> the out-of-tree ayaneo-platform driver.
>
> In addition, update the readmes of oxpec to reflect this change.

Reviewed-by: Armin Wolf <W_Armin@gmx.de>

>
> Link: https://github.com/ShadowBlip/ayaneo-platform
> Tested-by: Derek J. Clark <derekjohn.clark@gmail.com>
> Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
> ---
>   drivers/platform/x86/Kconfig     |   4 +-
>   drivers/platform/x86/ayaneo-ec.c |  65 +++++++++++++++++
>   drivers/platform/x86/oxpec.c     | 115 +------------------------------
>   3 files changed, 67 insertions(+), 117 deletions(-)
>
> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
> index f5b2edc6bc67..4d4be1634152 100644
> --- a/drivers/platform/x86/Kconfig
> +++ b/drivers/platform/x86/Kconfig
> @@ -1043,9 +1043,7 @@ config OXP_EC
>   	help
>   		Enables support for the platform EC of OneXPlayer and AOKZOE
>   		handheld devices. This includes fan speed, fan controls, and
> -		disabling the default TDP behavior of the device. Due to legacy
> -		reasons, this driver also provides hwmon functionality to Ayaneo
> -		devices and the OrangePi Neo.
> +		disabling the default TDP behavior of the device.
>  =20
>   source "drivers/platform/x86/tuxedo/Kconfig"
>  =20
> diff --git a/drivers/platform/x86/ayaneo-ec.c b/drivers/platform/x86/aya=
neo-ec.c
> index 363b61fc6e12..73e9dd39c703 100644
> --- a/drivers/platform/x86/ayaneo-ec.c
> +++ b/drivers/platform/x86/ayaneo-ec.c
> @@ -49,6 +49,15 @@ struct ayaneo_ec_platform_data {
>   	struct acpi_battery_hook battery_hook;
>   };
>  =20
> +static const struct ayaneo_ec_quirk quirk_fan =3D {
> +	.has_fan_control =3D true,
> +};
> +
> +static const struct ayaneo_ec_quirk quirk_charge_limit =3D {
> +	.has_fan_control =3D true,
> +	.has_charge_control =3D true,
> +};
> +
>   static const struct ayaneo_ec_quirk ayaneo3 =3D {
>   	.has_fan_control =3D true,
>   	.has_charge_control =3D true,
> @@ -56,6 +65,62 @@ static const struct ayaneo_ec_quirk ayaneo3 =3D {
>   };
>  =20
>   static const struct dmi_system_id dmi_table[] =3D {
> +	{
> +		.matches =3D {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "AYANEO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "AYANEO 2"),
> +		},
> +		.driver_data =3D (void *)&quirk_fan,
> +	},
> +	{
> +		.matches =3D {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "AYANEO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "FLIP"),
> +		},
> +		.driver_data =3D (void *)&quirk_fan,
> +	},
> +	{
> +		.matches =3D {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "AYANEO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "GEEK"),
> +		},
> +		.driver_data =3D (void *)&quirk_fan,
> +	},
> +	{
> +		.matches =3D {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "AYANEO"),
> +			DMI_EXACT_MATCH(DMI_BOARD_NAME, "AIR"),
> +		},
> +		.driver_data =3D (void *)&quirk_charge_limit,
> +	},
> +	{
> +		.matches =3D {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "AYANEO"),
> +			DMI_EXACT_MATCH(DMI_BOARD_NAME, "AIR 1S"),
> +		},
> +		.driver_data =3D (void *)&quirk_charge_limit,
> +	},
> +	{
> +		.matches =3D {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "AYANEO"),
> +			DMI_EXACT_MATCH(DMI_BOARD_NAME, "AB05-Mendocino"),
> +		},
> +		.driver_data =3D (void *)&quirk_charge_limit,
> +	},
> +	{
> +		.matches =3D {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "AYANEO"),
> +			DMI_EXACT_MATCH(DMI_BOARD_NAME, "AIR Pro"),
> +		},
> +		.driver_data =3D (void *)&quirk_charge_limit,
> +	},
> +	{
> +		.matches =3D {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "AYANEO"),
> +			DMI_EXACT_MATCH(DMI_BOARD_NAME, "KUN"),
> +		},
> +		.driver_data =3D (void *)&quirk_charge_limit,
> +	},
>   	{
>   		.matches =3D {
>   			DMI_MATCH(DMI_BOARD_VENDOR, "AYANEO"),
> diff --git a/drivers/platform/x86/oxpec.c b/drivers/platform/x86/oxpec.c
> index 54377b282ff8..144a454103b9 100644
> --- a/drivers/platform/x86/oxpec.c
> +++ b/drivers/platform/x86/oxpec.c
> @@ -1,8 +1,6 @@
>   // SPDX-License-Identifier: GPL-2.0+
>   /*
> - * Platform driver for OneXPlayer and AOKZOE devices. For the time bein=
g,
> - * it also exposes fan controls for AYANEO, and OrangePi Handhelds via
> - * hwmon sysfs.
> + * Platform driver for OneXPlayer and AOKZOE devices.
>    *
>    * Fan control is provided via pwm interface in the range [0-255].
>    * Old AMD boards use [0-100] as range in the EC, the written value is
> @@ -43,14 +41,6 @@ static bool unlock_global_acpi_lock(void)
>  =20
>   enum oxp_board {
>   	aok_zoe_a1 =3D 1,
> -	aya_neo_2,
> -	aya_neo_air,
> -	aya_neo_air_1s,
> -	aya_neo_air_plus_mendo,
> -	aya_neo_air_pro,
> -	aya_neo_flip,
> -	aya_neo_geek,
> -	aya_neo_kun,
>   	orange_pi_neo,
>   	oxp_2,
>   	oxp_fly,
> @@ -131,62 +121,6 @@ static const struct dmi_system_id dmi_table[] =3D {
>   		},
>   		.driver_data =3D (void *)oxp_fly,
>   	},
> -	{
> -		.matches =3D {
> -			DMI_MATCH(DMI_BOARD_VENDOR, "AYANEO"),
> -			DMI_MATCH(DMI_BOARD_NAME, "AYANEO 2"),
> -		},
> -		.driver_data =3D (void *)aya_neo_2,
> -	},
> -	{
> -		.matches =3D {
> -			DMI_MATCH(DMI_BOARD_VENDOR, "AYANEO"),
> -			DMI_EXACT_MATCH(DMI_BOARD_NAME, "AIR"),
> -		},
> -		.driver_data =3D (void *)aya_neo_air,
> -	},
> -	{
> -		.matches =3D {
> -			DMI_MATCH(DMI_BOARD_VENDOR, "AYANEO"),
> -			DMI_EXACT_MATCH(DMI_BOARD_NAME, "AIR 1S"),
> -		},
> -		.driver_data =3D (void *)aya_neo_air_1s,
> -	},
> -	{
> -		.matches =3D {
> -			DMI_MATCH(DMI_BOARD_VENDOR, "AYANEO"),
> -			DMI_EXACT_MATCH(DMI_BOARD_NAME, "AB05-Mendocino"),
> -		},
> -		.driver_data =3D (void *)aya_neo_air_plus_mendo,
> -	},
> -	{
> -		.matches =3D {
> -			DMI_MATCH(DMI_BOARD_VENDOR, "AYANEO"),
> -			DMI_EXACT_MATCH(DMI_BOARD_NAME, "AIR Pro"),
> -		},
> -		.driver_data =3D (void *)aya_neo_air_pro,
> -	},
> -	{
> -		.matches =3D {
> -			DMI_MATCH(DMI_BOARD_VENDOR, "AYANEO"),
> -			DMI_MATCH(DMI_BOARD_NAME, "FLIP"),
> -		},
> -		.driver_data =3D (void *)aya_neo_flip,
> -	},
> -	{
> -		.matches =3D {
> -			DMI_MATCH(DMI_BOARD_VENDOR, "AYANEO"),
> -			DMI_MATCH(DMI_BOARD_NAME, "GEEK"),
> -		},
> -		.driver_data =3D (void *)aya_neo_geek,
> -	},
> -	{
> -		.matches =3D {
> -			DMI_MATCH(DMI_BOARD_VENDOR, "AYANEO"),
> -			DMI_EXACT_MATCH(DMI_BOARD_NAME, "KUN"),
> -		},
> -		.driver_data =3D (void *)aya_neo_kun,
> -	},
>   	{
>   		.matches =3D {
>   			DMI_MATCH(DMI_BOARD_VENDOR, "OrangePi"),
> @@ -672,13 +606,6 @@ static int oxp_pwm_enable(void)
>   	case orange_pi_neo:
>   		return write_to_ec(ORANGEPI_SENSOR_PWM_ENABLE_REG, PWM_MODE_MANUAL);
>   	case aok_zoe_a1:
> -	case aya_neo_2:
> -	case aya_neo_air:
> -	case aya_neo_air_plus_mendo:
> -	case aya_neo_air_pro:
> -	case aya_neo_flip:
> -	case aya_neo_geek:
> -	case aya_neo_kun:
>   	case oxp_2:
>   	case oxp_fly:
>   	case oxp_mini_amd:
> @@ -699,14 +626,6 @@ static int oxp_pwm_disable(void)
>   	case orange_pi_neo:
>   		return write_to_ec(ORANGEPI_SENSOR_PWM_ENABLE_REG, PWM_MODE_AUTO);
>   	case aok_zoe_a1:
> -	case aya_neo_2:
> -	case aya_neo_air:
> -	case aya_neo_air_1s:
> -	case aya_neo_air_plus_mendo:
> -	case aya_neo_air_pro:
> -	case aya_neo_flip:
> -	case aya_neo_geek:
> -	case aya_neo_kun:
>   	case oxp_2:
>   	case oxp_fly:
>   	case oxp_mini_amd:
> @@ -727,14 +646,6 @@ static int oxp_pwm_read(long *val)
>   	case orange_pi_neo:
>   		return read_from_ec(ORANGEPI_SENSOR_PWM_ENABLE_REG, 1, val);
>   	case aok_zoe_a1:
> -	case aya_neo_2:
> -	case aya_neo_air:
> -	case aya_neo_air_1s:
> -	case aya_neo_air_plus_mendo:
> -	case aya_neo_air_pro:
> -	case aya_neo_flip:
> -	case aya_neo_geek:
> -	case aya_neo_kun:
>   	case oxp_2:
>   	case oxp_fly:
>   	case oxp_mini_amd:
> @@ -774,14 +685,6 @@ static int oxp_pwm_fan_speed(long *val)
>   	case oxp_g1_i:
>   		return read_from_ec(OXP_2_SENSOR_FAN_REG, 2, val);
>   	case aok_zoe_a1:
> -	case aya_neo_2:
> -	case aya_neo_air:
> -	case aya_neo_air_1s:
> -	case aya_neo_air_plus_mendo:
> -	case aya_neo_air_pro:
> -	case aya_neo_flip:
> -	case aya_neo_geek:
> -	case aya_neo_kun:
>   	case oxp_fly:
>   	case oxp_mini_amd:
>   	case oxp_mini_amd_a07:
> @@ -810,14 +713,6 @@ static int oxp_pwm_input_write(long val)
>   		/* scale to range [0-184] */
>   		val =3D (val * 184) / 255;
>   		return write_to_ec(OXP_SENSOR_PWM_REG, val);
> -	case aya_neo_2:
> -	case aya_neo_air:
> -	case aya_neo_air_1s:
> -	case aya_neo_air_plus_mendo:
> -	case aya_neo_air_pro:
> -	case aya_neo_flip:
> -	case aya_neo_geek:
> -	case aya_neo_kun:
>   	case oxp_mini_amd:
>   	case oxp_mini_amd_a07:
>   		/* scale to range [0-100] */
> @@ -854,14 +749,6 @@ static int oxp_pwm_input_read(long *val)
>   		/* scale from range [0-184] */
>   		*val =3D (*val * 255) / 184;
>   		break;
> -	case aya_neo_2:
> -	case aya_neo_air:
> -	case aya_neo_air_1s:
> -	case aya_neo_air_plus_mendo:
> -	case aya_neo_air_pro:
> -	case aya_neo_flip:
> -	case aya_neo_geek:
> -	case aya_neo_kun:
>   	case oxp_mini_amd:
>   	case oxp_mini_amd_a07:
>   		ret =3D read_from_ec(OXP_SENSOR_PWM_REG, 1, val);

