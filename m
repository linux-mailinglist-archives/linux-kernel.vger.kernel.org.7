Return-Path: <linux-kernel+bounces-881958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D281BC29500
	for <lists+linux-kernel@lfdr.de>; Sun, 02 Nov 2025 19:27:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 577C9347203
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Nov 2025 18:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BD5F22FDFF;
	Sun,  2 Nov 2025 18:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="qloSk6cI"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D950212564;
	Sun,  2 Nov 2025 18:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762108028; cv=none; b=eWA2CXFAtVXKnNnZnt+nhEZn+aRGgDDt+M6fjJMaJcoWHGeVO8KocNV1Q0z7LFjYpqw1eLeKM3xOQjlZdKx9zM8IOAj3IRhAX0NGWkxBaTz6PRjkdXYIx9cXHeUbs1WtKpZCdw2zGwkX02OjRkv7JrKFhfWLdr8vZkY+DGvfcPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762108028; c=relaxed/simple;
	bh=JXKy89z592rFdkXcbngnrhu582Fp9T0xv1pcbRndFDk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z9Jjnml3kwe5Fm2tUaHxB6bq2yjbw+BhEgNcXTe65oS4DBC4+akKj7FR5bDZDl3aceezM8Pg6BEhQsMqr9Q4lmRpUH94wFCGQSv31pkM8DVSDg4QYcdK/0nYjLLApQzVcH8Yg1TQu0DrLZxLU1PFRUsVZxe40pe3B6Ox4wxazCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=qloSk6cI; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1762108015; x=1762712815; i=w_armin@gmx.de;
	bh=gMZWzka9xpBaYfApmHUHxyKIfH3YvOo8ZqtcMvvYczU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=qloSk6cIerjJo1GKMAS+f+OKaH2NeUHHWnRAIkzizW1z5E7MCjrSLgi99Kai63Su
	 vN+XTZQeaELy8gUa4sRxKyxe6rVhXnIMu9h4UeTugS9dO0NcN+xuWTKF56+akqkNG
	 Nw0CC0KVC4wmyyu+gZwn6sXE2E+x2P8OL57ufCa9TJtIVPplUew0pSqLQYNVHCJhH
	 6j1bHkbzmVMAtZOS5mtk4+S3t7V4EcmfGDlH1NmOyZd/G9flS/9peSE9ggtbwihGj
	 Rg4PwnoNQhywzH7kdCu3L6cFCTHh2cB5V4PmBiBARfo9VQoTEzDGRRCWfyOI2bucc
	 XJEnmhalSziAbYGLzQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.69] ([93.202.247.91]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M5wPh-1vLQLk1pDn-00EKNE; Sun, 02
 Nov 2025 19:26:55 +0100
Message-ID: <b075b605-4cdd-4fbf-aa1a-78f7f34a1c50@gmx.de>
Date: Sun, 2 Nov 2025 19:26:53 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/6] platform/x86: ayaneo-ec: Add charge control
 support
To: Antheas Kapenekakis <lkml@antheas.dev>,
 platform-driver-x86@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
 Hans de Goede <hansg@kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Derek John Clark <derekjohn.clark@gmail.com>,
 =?UTF-8?Q?Joaqu=C3=ADn_Ignacio_Aramend=C3=ADa?= <samsagax@gmail.com>,
 Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>
References: <20251031163651.1465981-1-lkml@antheas.dev>
 <20251031163651.1465981-4-lkml@antheas.dev>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <20251031163651.1465981-4-lkml@antheas.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:FtFeiY3TlD4IwThmeiOYSvC+PIaLNz8OwHh8/V5dNml9N4ly77e
 hGv51H71fHNz7/DdjuMI1Uc/4UzR+R4SDHnACNwRYqIV6G3jTFUY1X+ktRwToos2t1/FE+v
 GYsX8bbsBtJYLhCvTTS5RwBvzdx9BifnwAmELjMohOP8zBXNOTRLdLLSvp9OrID3Zs76RK8
 QRqwOmqKlCx5hPSxa96Mg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:JymbkTILC08=;jTtBV3iv3NLm/JRY9n078e72qEG
 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

Am 31.10.25 um 17:36 schrieb Antheas Kapenekakis:

> Ayaneo devices support charge inhibition via the EC. This inhibition
> only works while the device is powered on, and resets between restarts.
> However, it is maintained across suspend/resume cycles.
>
> The EC does not support charge threshold control. Instead, userspace
> software on Windows manually toggles charge inhibition depending on
> battery level.
>
> Reviewed-by: Armin Wolf <W_Armin@gmx.de>
> Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
> ---
>   drivers/platform/x86/Kconfig     |   1 +
>   drivers/platform/x86/ayaneo-ec.c | 112 +++++++++++++++++++++++++++++++
>   2 files changed, 113 insertions(+)
>
> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
> index b3beaff4b03a..a45449ae83f8 100644
> --- a/drivers/platform/x86/Kconfig
> +++ b/drivers/platform/x86/Kconfig
> @@ -319,6 +319,7 @@ config ASUS_TF103C_DOCK
>   config AYANEO_EC
>   	tristate "Ayaneo EC platform control"
>   	depends on ACPI_EC
> +	depends on ACPI_BATTERY
>   	depends on HWMON
>   	help
>   	  Enables support for the platform EC of Ayaneo devices. This
> diff --git a/drivers/platform/x86/ayaneo-ec.c b/drivers/platform/x86/aya=
neo-ec.c
> index 108a23458a4f..697bb053a7d6 100644
> --- a/drivers/platform/x86/ayaneo-ec.c
> +++ b/drivers/platform/x86/ayaneo-ec.c
> @@ -15,6 +15,8 @@
>   #include <linux/kernel.h>
>   #include <linux/module.h>
>   #include <linux/platform_device.h>
> +#include <linux/power_supply.h>
> +#include <acpi/battery.h>
>  =20
>   #define AYANEO_PWM_ENABLE_REG	 0x4A
>   #define AYANEO_PWM_REG		 0x4B
> @@ -23,17 +25,27 @@
>  =20
>   #define AYANEO_FAN_REG		 0x76
>  =20
> +#define EC_CHARGE_CONTROL_BEHAVIOURS                         \
> +	(BIT(POWER_SUPPLY_CHARGE_BEHAVIOUR_AUTO) |           \
> +	 BIT(POWER_SUPPLY_CHARGE_BEHAVIOUR_INHIBIT_CHARGE))

I think POWER_SUPPLY_CHARGE_BEHAVIOUR_INHIBIT_CHARGE_AWAKE would be more s=
uitable here.

Other than that:
Reviewed-by: Armin Wolf <W_Armin@gmx.de>

> +#define AYANEO_CHARGE_REG		0x1e
> +#define AYANEO_CHARGE_VAL_AUTO		0xaa
> +#define AYANEO_CHARGE_VAL_INHIBIT	0x55
> +
>   struct ayaneo_ec_quirk {
>   	bool has_fan_control;
> +	bool has_charge_control;
>   };
>  =20
>   struct ayaneo_ec_platform_data {
>   	struct platform_device *pdev;
>   	struct ayaneo_ec_quirk *quirks;
> +	struct acpi_battery_hook battery_hook;
>   };
>  =20
>   static const struct ayaneo_ec_quirk quirk_ayaneo3 =3D {
>   	.has_fan_control =3D true,
> +	.has_charge_control =3D true,
>   };
>  =20
>   static const struct dmi_system_id dmi_table[] =3D {
> @@ -164,11 +176,102 @@ static const struct hwmon_chip_info ayaneo_ec_chi=
p_info =3D {
>   	.info =3D ayaneo_ec_sensors,
>   };
>  =20
> +static int ayaneo_psy_ext_get_prop(struct power_supply *psy,
> +				   const struct power_supply_ext *ext,
> +				   void *data,
> +				   enum power_supply_property psp,
> +				   union power_supply_propval *val)
> +{
> +	int ret;
> +	u8 tmp;
> +
> +	switch (psp) {
> +	case POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR:
> +		ret =3D ec_read(AYANEO_CHARGE_REG, &tmp);
> +		if (ret)
> +			return ret;
> +
> +		if (tmp =3D=3D AYANEO_CHARGE_VAL_INHIBIT)
> +			val->intval =3D POWER_SUPPLY_CHARGE_BEHAVIOUR_INHIBIT_CHARGE;
> +		else
> +			val->intval =3D POWER_SUPPLY_CHARGE_BEHAVIOUR_AUTO;
> +		return 0;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int ayaneo_psy_ext_set_prop(struct power_supply *psy,
> +				   const struct power_supply_ext *ext,
> +				   void *data,
> +				   enum power_supply_property psp,
> +				   const union power_supply_propval *val)
> +{
> +	u8 raw_val;
> +
> +	switch (psp) {
> +	case POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR:
> +		switch (val->intval) {
> +		case POWER_SUPPLY_CHARGE_BEHAVIOUR_AUTO:
> +			raw_val =3D AYANEO_CHARGE_VAL_AUTO;
> +			break;
> +		case POWER_SUPPLY_CHARGE_BEHAVIOUR_INHIBIT_CHARGE:
> +			raw_val =3D AYANEO_CHARGE_VAL_INHIBIT;
> +			break;
> +		default:
> +			return -EINVAL;
> +		}
> +		return ec_write(AYANEO_CHARGE_REG, raw_val);
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int ayaneo_psy_prop_is_writeable(struct power_supply *psy,
> +					const struct power_supply_ext *ext,
> +					void *data,
> +					enum power_supply_property psp)
> +{
> +	return true;
> +}
> +
> +static const enum power_supply_property ayaneo_psy_ext_props[] =3D {
> +	POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR,
> +};
> +
> +static const struct power_supply_ext ayaneo_psy_ext =3D {
> +	.name			=3D "ayaneo-charge-control",
> +	.properties		=3D ayaneo_psy_ext_props,
> +	.num_properties		=3D ARRAY_SIZE(ayaneo_psy_ext_props),
> +	.charge_behaviours	=3D EC_CHARGE_CONTROL_BEHAVIOURS,
> +	.get_property		=3D ayaneo_psy_ext_get_prop,
> +	.set_property		=3D ayaneo_psy_ext_set_prop,
> +	.property_is_writeable	=3D ayaneo_psy_prop_is_writeable,
> +};
> +
> +static int ayaneo_add_battery(struct power_supply *battery,
> +			      struct acpi_battery_hook *hook)
> +{
> +	struct ayaneo_ec_platform_data *data =3D
> +		container_of(hook, struct ayaneo_ec_platform_data, battery_hook);
> +
> +	return power_supply_register_extension(battery, &ayaneo_psy_ext,
> +					       &data->pdev->dev, NULL);
> +}
> +
> +static int ayaneo_remove_battery(struct power_supply *battery,
> +				 struct acpi_battery_hook *hook)
> +{
> +	power_supply_unregister_extension(battery, &ayaneo_psy_ext);
> +	return 0;
> +}
> +
>   static int ayaneo_ec_probe(struct platform_device *pdev)
>   {
>   	const struct dmi_system_id *dmi_entry;
>   	struct ayaneo_ec_platform_data *data;
>   	struct device *hwdev;
> +	int ret;
>  =20
>   	dmi_entry =3D dmi_first_match(dmi_table);
>   	if (!dmi_entry)
> @@ -189,6 +292,15 @@ static int ayaneo_ec_probe(struct platform_device *=
pdev)
>   			return PTR_ERR(hwdev);
>   	}
>  =20
> +	if (data->quirks->has_charge_control) {
> +		data->battery_hook.add_battery =3D ayaneo_add_battery;
> +		data->battery_hook.remove_battery =3D ayaneo_remove_battery;
> +		data->battery_hook.name =3D "Ayaneo Battery";
> +		ret =3D devm_battery_hook_register(&pdev->dev, &data->battery_hook);
> +		if (ret)
> +			return ret;
> +	}
> +
>   	return 0;
>   }
>  =20

