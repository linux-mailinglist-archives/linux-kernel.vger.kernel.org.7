Return-Path: <linux-kernel+bounces-781873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBEABB31814
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 14:40:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56B80AA4D92
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 12:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26EB52FB997;
	Fri, 22 Aug 2025 12:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="CtNtCq64"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C3C271443;
	Fri, 22 Aug 2025 12:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755866320; cv=none; b=XlkipzkCd11DhC0JnZ4cKXaN7iGBJD8mZgDigwd6IiXHxY0Mw0ytW9HNYLW2dLxQCOH+pTVHCurhmsfbFNTG6TE+GbnAgnu0ipWPZOX+GMP1zrMSW0L/rkd9qdTu3VnlQjSMw4ilpbrvphouX8kPwkJIFafOpQ41uw2w92T88xA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755866320; c=relaxed/simple;
	bh=hM+TeLiteO72E6orWvZWdrAK0qnL7xyaj5+78dJ4l5c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FZsXSPY9UI7IU22/7aBy9FOoxnvaa+F4BWnAc9nLyhExGW3WjalXpJ4UCwx/+LCb7ZiLgXQjK3ixpzRQYwxo0t90Tgwg+s0qjluDzygh7G5rKLNCt0PLCzJzK3rnSrl06rztp6Zh+80yF98KBEjwzgWn5tYHgVeebRuFy3BIEXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=CtNtCq64; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1755866293; x=1756471093; i=w_armin@gmx.de;
	bh=IySqPJHpUNkQtIzzzofRZi7KzHRH6UZZHrEmJ6KR33I=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=CtNtCq64+QDReaNKcM7CvLT2wgQ398TKeYU0hlUlxN7BFSbiIAaEf0GADbowOTxR
	 9NMxSYCdkp7Fe4TOvBkUm04pAtvk0F5nLE7P8g7tLGXo2nhcMSY6viuYFf7mo99K6
	 PtGVq+b5EGX8MDfe3Q5l0BKdk//1GHRu9KM4+qlUxuD5zzXQ/+XJvoC+s9OtZzUaQ
	 VURt8rjQxnR+Hvtx0rBwJFOTDHmGlTR+0ozD5XMtqiDmqqCIHUMU0TVgtPp5F03Lo
	 Mb1nr3GUwqtbbEaYm5F30J9d6zszQIsaW5BWGqo5lhDdD+SB9oOtkpNrqSfR/kjst
	 zGZyXj3b0z/evWNsbg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [10.189.91.1] ([176.5.63.45]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MmlT2-1u9Bic3Rkk-00iOcI; Fri, 22
 Aug 2025 14:38:13 +0200
Message-ID: <bb62de69-4bf6-480c-8385-c5e69887563f@gmx.de>
Date: Fri, 22 Aug 2025 14:38:06 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/5] platform/x86: ayaneo-ec: Add charge control
 support
To: Antheas Kapenekakis <lkml@antheas.dev>,
 platform-driver-x86@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
 Hans de Goede <hansg@kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Derek John Clark <derekjohn.clark@gmail.com>,
 =?UTF-8?Q?Joaqu=C3=ADn_Ignacio_Aramend=C3=ADa?= <samsagax@gmail.com>,
 Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>
References: <20250820160628.99678-1-lkml@antheas.dev>
 <20250820160628.99678-4-lkml@antheas.dev>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <20250820160628.99678-4-lkml@antheas.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:EX8++cfx+uG0Iczh4+S0aqMO2EtOOckKhH4t0juUtGJ04VFCA0K
 sgSehc1Ari5ek7JFDsUrsDRrT0UCpcY+cbkchVOvKSlu1HW+yP+3FiT1fPMsLZK+NmT279D
 jT8WPEsJdPXkO+BNnKQIlVEw2UeVxred82HFbSTXU/pEfpCM7fHwHm6HJ91ypOjZhs6NLnL
 c8gNmFZUhuhrFDELAJBhA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:c17PgXgRiog=;p1QQuQq/1uPYn9uZ91JtcR8rWN0
 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

Am 20.08.25 um 18:06 schrieb Antheas Kapenekakis:

> Ayaneo devices support charge inhibition via the EC. This inhibition
> only works while the device is powered on, and resets between restarts.
> However, it is maintained across suspend/resume cycles.

Does this include hibernation?

Thanks,
Armin Wolf

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
> index 0a7ca2c78456..c871a722e5ef 100644
> --- a/drivers/platform/x86/Kconfig
> +++ b/drivers/platform/x86/Kconfig
> @@ -308,6 +308,7 @@ config AYANEO_EC
>   	tristate "Ayaneo EC platform control"
>   	depends on X86
>   	depends on ACPI_EC
> +	depends on ACPI_BATTERY
>   	depends on HWMON
>   	help
>   	  Enables support for the platform EC of Ayaneo devices. This
> diff --git a/drivers/platform/x86/ayaneo-ec.c b/drivers/platform/x86/aya=
neo-ec.c
> index 8b1902706b81..a4bdc6ae7af7 100644
> --- a/drivers/platform/x86/ayaneo-ec.c
> +++ b/drivers/platform/x86/ayaneo-ec.c
> @@ -14,6 +14,7 @@
>   #include <linux/kernel.h>
>   #include <linux/module.h>
>   #include <linux/platform_device.h>
> +#include <acpi/battery.h>
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
> @@ -159,11 +170,102 @@ static const struct hwmon_chip_info ayaneo_ec_chi=
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
> @@ -184,6 +286,15 @@ static int ayaneo_ec_probe(struct platform_device *=
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

