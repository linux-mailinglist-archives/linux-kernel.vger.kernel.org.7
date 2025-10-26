Return-Path: <linux-kernel+bounces-870656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A39BC0B616
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 23:36:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2AFF44EC2D4
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 22:36:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E72E26E165;
	Sun, 26 Oct 2025 22:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="Yocf8Grv"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96E59283121;
	Sun, 26 Oct 2025 22:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761518181; cv=none; b=iTw8JEAS6YXxfCPStMHBnLMizKnwykxv92KiIh0Hlek/SsmAutyuxRd7bAdwK3Tc78fDxgPh8//H0yWkIV2dPOYjXHDQYs9jwrADh2NmWnvtoFT0lEqepkKKfuzuhsKy+WDnLPze7xuo3iAy6F5BzKvHtUhc+6rioFTbs4L517Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761518181; c=relaxed/simple;
	bh=EKoVY/alxO1iyFgQL3Wpm6ak+AD1qY+LVOKicjZRDFA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UJ6i42PfRY+8Xzgnnl96fRARgFWwKiTZp/hQO6keXO4Sxz6wnAvjQu1v6CJ37Zq3bNxneKnkLfl5X67lQSI09VpIi8QP+RvOhd/wjMohHe5Ia4+9zZLakpew5SFMe6KywC76QoXAvXhyxNSI782Wa+4jm9SEUKO1wbfoOpaYteI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=Yocf8Grv; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1761518154; x=1762122954; i=w_armin@gmx.de;
	bh=dpRyJbrn6T6VziNE4RtfjpbiaVA5e6NFuESx6h/y5GE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Yocf8GrvIj6i6eJk2xM5xZsBWhAYPloo5MvUYP5LP9D5siU0gSQ4U2KYcUjm2xN8
	 HvB3azK+hzWyXfCmMDniSLzsKiWwsM/m4fVrFexev1GvGiVMAMqy3qQw21+tZOev/
	 kthQz6EC653zYx0HTPyittswiRHtIoGJfsi620l/GzWa9KJjOJnbjW/rkrH9TSxIU
	 e183tipUKnRiyb6sdC3RSPxyXkrllR26grzvnVz7uOgKQXfasD878g7ugLTVR9dnb
	 wgkYjRue8FPmXEiEIXFTuNPnpvh0wr8hJRDKWnRyGxgfv8fLVDtaimX4NNX1Cxh3o
	 2GNgU8E9J6Bd8lbPrg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.69] ([93.202.247.91]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mzyyk-1uGFpf43rK-00w9sA; Sun, 26
 Oct 2025 23:35:54 +0100
Message-ID: <7f215fa8-b355-4830-ab5c-a9f5c419e207@gmx.de>
Date: Sun, 26 Oct 2025 23:35:51 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/6] platform/x86: ayaneo-ec: Add charge control
 support
To: Antheas Kapenekakis <lkml@antheas.dev>,
 platform-driver-x86@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
 Hans de Goede <hansg@kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Derek John Clark <derekjohn.clark@gmail.com>,
 =?UTF-8?Q?Joaqu=C3=ADn_Ignacio_Aramend=C3=ADa?= <samsagax@gmail.com>,
 Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>
References: <20251015084414.1391595-1-lkml@antheas.dev>
 <20251015084414.1391595-4-lkml@antheas.dev>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <20251015084414.1391595-4-lkml@antheas.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:4brtZGBZTY0hwXq1/pgPcym6umNvoNcOQEXtphoYPpJGzZPhk6m
 EoLN1B6VSyEwXgz1plwRcT5Aj82GEKxEVuYG+7iZMZ0HPC36PXp9M4UYLP7VR+OFwbazMKr
 qvrGypXwL2kjAxdcTRpRcEgEfKfi1XoPWIdmEza4uowKflFxE33UhiPWkjYXoyPZdHd2ROm
 NDnQsQ37w2Bp8Q/OzhW5g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:E3udjlXOHCs=;MlZYZER5tKSaN1WXcs1c9r7+DVs
 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
 n82hHeylTk6EgpSWe2RhP9wT6o=

Am 15.10.25 um 10:44 schrieb Antheas Kapenekakis:

> Ayaneo devices support charge inhibition via the EC. This inhibition
> only works while the device is powered on, and resets between restarts.
> However, it is maintained across suspend/resume cycles.
>
> The EC does not support charge threshold control. Instead, userspace
> software on Windows manually toggles charge inhibition depending on
> battery level.
>
> Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
> ---
>   drivers/platform/x86/Kconfig     |   1 +
>   drivers/platform/x86/ayaneo-ec.c | 111 +++++++++++++++++++++++++++++++
>   2 files changed, 112 insertions(+)
>
> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
> index f132a87fcee9..f5b2edc6bc67 100644
> --- a/drivers/platform/x86/Kconfig
> +++ b/drivers/platform/x86/Kconfig
> @@ -320,6 +320,7 @@ config AYANEO_EC
>   	tristate "Ayaneo EC platform control"
>   	depends on X86
>   	depends on ACPI_EC
> +	depends on ACPI_BATTERY
>   	depends on HWMON
>   	help
>   	  Enables support for the platform EC of Ayaneo devices. This
> diff --git a/drivers/platform/x86/ayaneo-ec.c b/drivers/platform/x86/aya=
neo-ec.c
> index 9884eed0cc84..23c283f5eb61 100644
> --- a/drivers/platform/x86/ayaneo-ec.c
> +++ b/drivers/platform/x86/ayaneo-ec.c
> @@ -14,6 +14,7 @@
>   #include <linux/kernel.h>
>   #include <linux/module.h>
>   #include <linux/platform_device.h>
> +#include <acpi/battery.h>

You should also include <linux/power_supply.h>. With that being fixed:

Reviewed-by: Armin Wolf <W_Armin@gmx.de>

>  =20
>   #define AYANEO_PWM_ENABLE_REG	 0x4A
>   #define AYANEO_PWM_REG		 0x4B
> @@ -22,17 +23,27 @@
>  =20
>   #define AYANEO_FAN_REG		 0x76
>  =20
> +#define EC_CHARGE_CONTROL_BEHAVIOURS                         \
> +	(BIT(POWER_SUPPLY_CHARGE_BEHAVIOUR_AUTO) |           \
> +	 BIT(POWER_SUPPLY_CHARGE_BEHAVIOUR_INHIBIT_CHARGE))
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
>   static const struct ayaneo_ec_quirk ayaneo3 =3D {
>   	.has_fan_control =3D true,
> +	.has_charge_control =3D true,
>   };
>  =20
>   static const struct dmi_system_id dmi_table[] =3D {
> @@ -161,11 +172,102 @@ static const struct hwmon_chip_info ayaneo_ec_chi=
p_info =3D {
>   	.info =3D ayaneo_ec_sensors,
>   };
>  =20
> +static int ayaneo_psy_ext_get_prop(struct power_supply *psy,
> +				const struct power_supply_ext *ext,
> +				void *data,
> +				enum power_supply_property psp,
> +				union power_supply_propval *val)
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
> +				const struct power_supply_ext *ext,
> +				void *data,
> +				enum power_supply_property psp,
> +				const union power_supply_propval *val)
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
> +				     const struct power_supply_ext *ext,
> +				     void *data,
> +				     enum power_supply_property psp)
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
> +			   struct acpi_battery_hook *hook)
> +{
> +	struct ayaneo_ec_platform_data *data =3D
> +		container_of(hook, struct ayaneo_ec_platform_data, battery_hook);
> +
> +	return power_supply_register_extension(battery, &ayaneo_psy_ext,
> +					       &data->pdev->dev, NULL);
> +}
> +
> +static int ayaneo_remove_battery(struct power_supply *battery,
> +			      struct acpi_battery_hook *hook)
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
> @@ -186,6 +288,15 @@ static int ayaneo_ec_probe(struct platform_device *=
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

