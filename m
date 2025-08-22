Return-Path: <linux-kernel+bounces-781869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 125D7B317FB
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 14:38:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 445401CE2073
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 12:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABC342FC034;
	Fri, 22 Aug 2025 12:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="M61PcQbQ"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 346BB1B4141;
	Fri, 22 Aug 2025 12:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755866178; cv=none; b=pw42hufG+O/EtsPy6axY+Is5EvKAPeog3HnTVoAUtHS9K54742VRNEkrRIt1zJ4p29l6+803bnxOpafYzCF6JrDvm0OMHmnrqxIaJ0E/c7TcA8CZ7VJIpoCtxbJkxJ5XoKzPcAq0jNzg4OsS1urGgbgunkJa91a5h1Y3VwHvCKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755866178; c=relaxed/simple;
	bh=GTN5iYlm2NEQay0j4m/2nggl3gFYu+Zq/0taUpgFTTc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EhEJvoYefTdJkA2TrDfyxcWbW0NbjN6CysjNZERRWVpE8+AUQj7Elb0KPMZ/sTzb9BFVIz9e2Mijpovhye/8tr18+voANyO7teF1tlgvtLK660ohYDMU3wOYWBwrukp3uSVDb0uX9sNtQT3T4GAjD3Q2eDlBnfp44gzPl26sE8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=M61PcQbQ; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1755866147; x=1756470947; i=w_armin@gmx.de;
	bh=J7hewAWeourx/jg/PVIZSpVWmzGcoNnw8uXDRNSjrO0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=M61PcQbQduenzU/nZPp573xAyDb06FxYKZTgKzOU/bOa4GMPq6DBrpFptZ9pn5BM
	 p/kZTwMOQjG/cDJHu0U7HM2sB+Xlo+WLu8DK116E3Own1HO24CC783u3MRmJhohlA
	 dY16OHYp7dRQrvyImMPWnc+gjzxNJOTDbWY7LnGCPe+txV4XEY6vE/yFPt0gqu+VZ
	 77QiYzOPVz2cqNJ84ceb1WoCvPiXD+TGxctjMPzcKO9dRPKZtwYWiGCk6mVHaTDFL
	 3c/ElblZEPBhCUavgynpn2qTxVl6FmH8NAcu6Wi84LC5F02vEWn3xSseX6TVI7zHJ
	 wEkUS894f9Qjtvt1Yg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [10.189.91.1] ([176.5.63.45]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1ML9yS-1v7W6r07k2-00LaqK; Fri, 22
 Aug 2025 14:35:47 +0200
Message-ID: <44404f92-fd30-400c-9f80-64c5649d9849@gmx.de>
Date: Fri, 22 Aug 2025 14:35:42 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/5] platform/x86: ayaneo-ec: Add hwmon support
To: Antheas Kapenekakis <lkml@antheas.dev>,
 platform-driver-x86@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
 Hans de Goede <hansg@kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Derek John Clark <derekjohn.clark@gmail.com>,
 =?UTF-8?Q?Joaqu=C3=ADn_Ignacio_Aramend=C3=ADa?= <samsagax@gmail.com>,
 Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>
References: <20250820160628.99678-1-lkml@antheas.dev>
 <20250820160628.99678-3-lkml@antheas.dev>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <20250820160628.99678-3-lkml@antheas.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:c7jDHJY+Lv9by1x2l0SUCLZ4APxK3hCKgGNWAk3IrvcGj1woqUq
 azh6HPLcqY4hCquFO0MyNVizmCM/NgYapoPPE8h+C+JzeXZu5uBtGwZoQ5Hs59fHT0DhkU4
 oTzIMxG2cjo2BCOSIsBKcdQhFl1mJVZyX/0Oqw8hCPXAc6aadPif/ztt/OWtqW1sSNUpVoT
 KI4y7gaNCE+Eno1Mrw6yg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:/2dCdsgYZ5Q=;kEb59JWISmup0lXnFJ82wIyo5lU
 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

Am 20.08.25 um 18:06 schrieb Antheas Kapenekakis:

> Add hwmon single fan sensor reads and control for Ayaneo devices.
> The register and method of access is the same for all devices.
>
> Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
> ---
>   drivers/platform/x86/Kconfig     |   2 +
>   drivers/platform/x86/ayaneo-ec.c | 132 +++++++++++++++++++++++++++++++
>   2 files changed, 134 insertions(+)
>
> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
> index 6d4a33791cc1..0a7ca2c78456 100644
> --- a/drivers/platform/x86/Kconfig
> +++ b/drivers/platform/x86/Kconfig
> @@ -307,6 +307,8 @@ config ASUS_TF103C_DOCK
>   config AYANEO_EC
>   	tristate "Ayaneo EC platform control"
>   	depends on X86
> +	depends on ACPI_EC
> +	depends on HWMON
>   	help
>   	  Enables support for the platform EC of Ayaneo devices. This
>   	  includes fan control, fan speed, charge limit, magic
> diff --git a/drivers/platform/x86/ayaneo-ec.c b/drivers/platform/x86/aya=
neo-ec.c
> index 90b86527ab0d..8b1902706b81 100644
> --- a/drivers/platform/x86/ayaneo-ec.c
> +++ b/drivers/platform/x86/ayaneo-ec.c
> @@ -7,13 +7,23 @@
>    * Copyright (C) 2025 Antheas Kapenekakis <lkml@antheas.dev>
>    */
>  =20
> +#include <linux/acpi.h>
>   #include <linux/dmi.h>
> +#include <linux/hwmon.h>
>   #include <linux/init.h>
>   #include <linux/kernel.h>
>   #include <linux/module.h>
>   #include <linux/platform_device.h>
>  =20
> +#define AYANEO_PWM_ENABLE_REG	 0x4A
> +#define AYANEO_PWM_REG		 0x4B
> +#define AYANEO_PWM_MODE_AUTO	 0x00
> +#define AYANEO_PWM_MODE_MANUAL	 0x01
> +
> +#define AYANEO_FAN_REG		 0x76
> +
>   struct ayaneo_ec_quirk {
> +	bool has_fan_control;
>   };
>  =20
>   struct ayaneo_ec_platform_data {
> @@ -22,6 +32,7 @@ struct ayaneo_ec_platform_data {
>   };
>  =20
>   static const struct ayaneo_ec_quirk ayaneo3 =3D {
> +	.has_fan_control =3D true,
>   };
>  =20
>   static const struct dmi_system_id dmi_table[] =3D {
> @@ -35,10 +46,124 @@ static const struct dmi_system_id dmi_table[] =3D {
>   	{},
>   };
>  =20
> +/* Callbacks for hwmon interface */
> +static umode_t ayaneo_ec_hwmon_is_visible(const void *drvdata,
> +				       enum hwmon_sensor_types type, u32 attr,
> +				       int channel)
> +{
> +	switch (type) {
> +	case hwmon_fan:
> +		return 0444;
> +	case hwmon_pwm:
> +		return 0644;
> +	default:
> +		return 0;
> +	}
> +}
> +
> +static int ayaneo_ec_read(struct device *dev, enum hwmon_sensor_types t=
ype,
> +			     u32 attr, int channel, long *val)
> +{
> +	u8 tmp;
> +	int ret;
> +
> +	switch (type) {
> +	case hwmon_fan:
> +		switch (attr) {
> +		case hwmon_fan_input:
> +			ret =3D ec_read(AYANEO_FAN_REG, &tmp);
> +			if (ret)
> +				return ret;
> +			*val =3D tmp << 8;
> +			ret =3D ec_read(AYANEO_FAN_REG + 1, &tmp);
> +			if (ret)
> +				return ret;
> +			*val +=3D tmp;
> +			return 0;
> +		default:
> +			break;
> +		}
> +		break;
> +	case hwmon_pwm:
> +		switch (attr) {
> +		case hwmon_pwm_input:
> +			ret =3D ec_read(AYANEO_PWM_REG, &tmp);
> +			if (ret)
> +				return ret;
> +			*val =3D (255 * tmp) / 100;
> +			if (*val < 0 || *val > 255)
> +				return -EINVAL;
> +			return 0;
> +		case hwmon_pwm_enable:
> +			ret =3D ec_read(AYANEO_PWM_ENABLE_REG, &tmp);
> +			if (ret)
> +				return ret;
> +			if (tmp =3D=3D AYANEO_PWM_MODE_MANUAL)
> +				*val =3D 1;
> +			else
> +				*val =3D 2;
> +			return 0;
> +		default:
> +			break;
> +		}
> +		break;
> +	default:
> +		break;
> +	}
> +	return -EOPNOTSUPP;
> +}
> +
> +static int ayaneo_ec_write(struct device *dev, enum hwmon_sensor_types =
type,
> +			      u32 attr, int channel, long val)
> +{
> +	switch (type) {
> +	case hwmon_pwm:
> +		switch (attr) {
> +		case hwmon_pwm_enable:
> +			if (val =3D=3D 1)
> +				return ec_write(AYANEO_PWM_ENABLE_REG,
> +						AYANEO_PWM_MODE_MANUAL);
> +			else if (val =3D=3D 2)
> +				return ec_write(AYANEO_PWM_ENABLE_REG,
> +						AYANEO_PWM_MODE_AUTO);
> +			else
> +				return -EINVAL;

Consider using a switch statement here.

> +		case hwmon_pwm_input:
> +			if (val < 0 || val > 255)
> +				return -EINVAL;
> +			return ec_write(AYANEO_PWM_REG, (val * 100) / 255);

Better use fixp_linear_interpolate() for that. Also you need to restore th=
ose registers
after suspend. I suggest that you use regmap for that.

Thanks,
Armin Wolf

> +		default:
> +			break;
> +		}
> +		break;
> +	default:
> +		break;
> +	}
> +	return -EOPNOTSUPP;
> +}
> +
> +static const struct hwmon_ops ayaneo_ec_hwmon_ops =3D {
> +	.is_visible =3D ayaneo_ec_hwmon_is_visible,
> +	.read =3D ayaneo_ec_read,
> +	.write =3D ayaneo_ec_write,
> +};
> +
> +static const struct hwmon_channel_info *const ayaneo_ec_sensors[] =3D {
> +	HWMON_CHANNEL_INFO(fan, HWMON_F_INPUT),
> +	HWMON_CHANNEL_INFO(pwm, HWMON_PWM_INPUT | HWMON_PWM_ENABLE),
> +	NULL,
> +};
> +
> +static const struct hwmon_chip_info ayaneo_ec_chip_info =3D {
> +	.ops =3D &ayaneo_ec_hwmon_ops,
> +	.info =3D ayaneo_ec_sensors,
> +};
> +
>   static int ayaneo_ec_probe(struct platform_device *pdev)
>   {
>   	const struct dmi_system_id *dmi_entry;
>   	struct ayaneo_ec_platform_data *data;
> +	struct device *hwdev;
>  =20
>   	dmi_entry =3D dmi_first_match(dmi_table);
>   	if (!dmi_entry)
> @@ -52,6 +177,13 @@ static int ayaneo_ec_probe(struct platform_device *p=
dev)
>   	data->quirks =3D dmi_entry->driver_data;
>   	platform_set_drvdata(pdev, data);
>  =20
> +	if (data->quirks->has_fan_control) {
> +		hwdev =3D devm_hwmon_device_register_with_info(
> +			&pdev->dev, "ayaneo_ec", NULL, &ayaneo_ec_chip_info, NULL);
> +		if (IS_ERR(hwdev))
> +			return PTR_ERR(hwdev);
> +	}
> +
>   	return 0;
>   }
>  =20

