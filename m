Return-Path: <linux-kernel+bounces-881953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 53782C294E8
	for <lists+linux-kernel@lfdr.de>; Sun, 02 Nov 2025 19:23:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 860A53475B8
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Nov 2025 18:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80A0C20E702;
	Sun,  2 Nov 2025 18:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="pv6Z/23X"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 650303B2A0;
	Sun,  2 Nov 2025 18:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762107775; cv=none; b=DSyC28T70+f7gEK/LqHYbiLWxvM8tl1SPF5Q7KpTxhlO9rbM74ZgeD15BWP9ND/poQqFI9lSmUZde/E5wQ9zPbwkzgmXQ7WW4vpLeCTlzmwIHVDndolJ8GnOVOLh7V6rIOMO36ye0Bt7wbqomO67uCSN3aGTIsmlPdyMlvKq6G0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762107775; c=relaxed/simple;
	bh=GryvnuiQ9Law3X+tGXky7OAc98f2jwyyxubkwOTLFIY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lCEn+QMdei0UleAwSElSi8OKp2gl2wjLsD34eAP/OUJ/1gQABBz8eZ9wwWcQOUz8I0d7NCa6H04xkaI3O/fJa6Zs8xuRw8ttzvlJSm/pCYIK41CoTISolbvBt6agGt4nsXpR/zLLohG0BDoP+sKEDwIkdjiEgCQ7u+RkZWEnXq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=pv6Z/23X; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1762107771; x=1762712571; i=w_armin@gmx.de;
	bh=JgrhhmMwd44O7pKwRL8PNs+E25dW+AXgqvfbiGXUesw=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=pv6Z/23XByHEZ6xsjLhMNBeU6CL91cyikQ7vkIA25U3hdcHmRIeC0W5nnlJs0LIS
	 3bSD0m5FVqbVnRtB7lr88cqMWe3xXV6uFf1rkRpVxDjJRza4UN9y5kBvJw9zbO77S
	 EYfJURz7NRacL0ZsClSKmJRMDCd4fDl0Zt9PFRJrcyXVwT3d8IUggUofn6JQQTIw6
	 Cy5dxwqSZoH88uFyjEg+eRVEzOSbp9Ebh4kSi/tdhVSD/EpI2Ql2QLwMhIF8N6H5h
	 dJGXfgT55pkiovAR1PAVK021uCj6quYzMZ/0jlWHwM6w7Hs9g1bJh3ToLY9eAW74d
	 HgQxU0WkM18O8DsVSw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.69] ([93.202.247.91]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MryXH-1w0Uil3N1p-00gXKt; Sun, 02
 Nov 2025 19:22:51 +0100
Message-ID: <cc2aa069-304a-4b38-951a-0891a4004804@gmx.de>
Date: Sun, 2 Nov 2025 19:22:49 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/6] platform/x86: ayaneo-ec: Add hwmon support
To: Antheas Kapenekakis <lkml@antheas.dev>,
 platform-driver-x86@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
 Hans de Goede <hansg@kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Derek John Clark <derekjohn.clark@gmail.com>,
 =?UTF-8?Q?Joaqu=C3=ADn_Ignacio_Aramend=C3=ADa?= <samsagax@gmail.com>,
 Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>
References: <20251031163651.1465981-1-lkml@antheas.dev>
 <20251031163651.1465981-3-lkml@antheas.dev>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <20251031163651.1465981-3-lkml@antheas.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:EyJwFNVJCGsu4jn1jmmhnd6fh7eVwtbQP50hC7xPeo4XvHhndRM
 MwELF/hm+VjhOU65C0Y2SvetwX2C3Zhe0Rw624kpsRJFVBgIbkhC03GalpPKbYDGG9/07lE
 ownspURdv9GSvldXZjIksbwxO7e+3bNpDV9WYAmfrP+SRHy4Xx/gke3kZ8PX/svD+IBqMnT
 lvhndso9jMm7Qjj9Zyj5w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:oao+AbzXsCI=;uDEWnZy1lSyYB3ZornPshRBSn10
 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

Am 31.10.25 um 17:36 schrieb Antheas Kapenekakis:

> Add hwmon single fan sensor reads and control for Ayaneo devices.
> The register and method of access is the same for all devices.

Reviewed-by: Armin-Wolf <W_Armin@gmx.de>

> Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
> ---
>   drivers/platform/x86/Kconfig     |   2 +
>   drivers/platform/x86/ayaneo-ec.c | 136 +++++++++++++++++++++++++++++++
>   2 files changed, 138 insertions(+)
>
> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
> index ebe7d2ab8758..b3beaff4b03a 100644
> --- a/drivers/platform/x86/Kconfig
> +++ b/drivers/platform/x86/Kconfig
> @@ -318,6 +318,8 @@ config ASUS_TF103C_DOCK
>  =20
>   config AYANEO_EC
>   	tristate "Ayaneo EC platform control"
> +	depends on ACPI_EC
> +	depends on HWMON
>   	help
>   	  Enables support for the platform EC of Ayaneo devices. This
>   	  includes fan control, fan speed, charge limit, magic
> diff --git a/drivers/platform/x86/ayaneo-ec.c b/drivers/platform/x86/aya=
neo-ec.c
> index 2fe66c8a89f4..108a23458a4f 100644
> --- a/drivers/platform/x86/ayaneo-ec.c
> +++ b/drivers/platform/x86/ayaneo-ec.c
> @@ -7,14 +7,24 @@
>    * Copyright (C) 2025 Antheas Kapenekakis <lkml@antheas.dev>
>    */
>  =20
> +#include <linux/acpi.h>
>   #include <linux/dmi.h>
>   #include <linux/err.h>
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
> @@ -23,6 +33,7 @@ struct ayaneo_ec_platform_data {
>   };
>  =20
>   static const struct ayaneo_ec_quirk quirk_ayaneo3 =3D {
> +	.has_fan_control =3D true,
>   };
>  =20
>   static const struct dmi_system_id dmi_table[] =3D {
> @@ -36,10 +47,128 @@ static const struct dmi_system_id dmi_table[] =3D {
>   	{},
>   };
>  =20
> +/* Callbacks for hwmon interface */
> +static umode_t ayaneo_ec_hwmon_is_visible(const void *drvdata,
> +					  enum hwmon_sensor_types type, u32 attr,
> +					  int channel)
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
> +			  u32 attr, int channel, long *val)
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
> +			if (tmp > 100)
> +				return -EIO;
> +			*val =3D (255 * tmp) / 100;
> +			return 0;
> +		case hwmon_pwm_enable:
> +			ret =3D ec_read(AYANEO_PWM_ENABLE_REG, &tmp);
> +			if (ret)
> +				return ret;
> +			if (tmp =3D=3D AYANEO_PWM_MODE_MANUAL)
> +				*val =3D 1;
> +			else if (tmp =3D=3D AYANEO_PWM_MODE_AUTO)
> +				*val =3D 2;
> +			else
> +				return -EIO;
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
> +			   u32 attr, int channel, long val)
> +{
> +	switch (type) {
> +	case hwmon_pwm:
> +		switch (attr) {
> +		case hwmon_pwm_enable:
> +			switch (val) {
> +			case 1:
> +				return ec_write(AYANEO_PWM_ENABLE_REG,
> +						AYANEO_PWM_MODE_MANUAL);
> +			case 2:
> +				return ec_write(AYANEO_PWM_ENABLE_REG,
> +						AYANEO_PWM_MODE_AUTO);
> +			default:
> +				return -EINVAL;
> +			}
> +		case hwmon_pwm_input:
> +			if (val < 0 || val > 255)
> +				return -EINVAL;
> +			return ec_write(AYANEO_PWM_REG, (val * 100) / 255);
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
> @@ -53,6 +182,13 @@ static int ayaneo_ec_probe(struct platform_device *p=
dev)
>   	data->quirks =3D dmi_entry->driver_data;
>   	platform_set_drvdata(pdev, data);
>  =20
> +	if (data->quirks->has_fan_control) {
> +		hwdev =3D devm_hwmon_device_register_with_info(&pdev->dev,
> +			"ayaneo_ec", NULL, &ayaneo_ec_chip_info, NULL);
> +		if (IS_ERR(hwdev))
> +			return PTR_ERR(hwdev);
> +	}
> +
>   	return 0;
>   }
>  =20

