Return-Path: <linux-kernel+bounces-881963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9BCCC29521
	for <lists+linux-kernel@lfdr.de>; Sun, 02 Nov 2025 19:35:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0352A188DF5C
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Nov 2025 18:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21DF521FF46;
	Sun,  2 Nov 2025 18:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="GQLmubim"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A44F5322A;
	Sun,  2 Nov 2025 18:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762108542; cv=none; b=dHA4qVx33Q1sT8BfFU0WgRvqC0bybIMyNr+BkEnfuKB/NlPPnvujSuYOCjCU0htRqMgDL2UKs64vDrHPsER2wbz5yHYI6w8fMk6BGqg5oAnj+qKbgkr8fyrfqfIXBWbro8w+UlZbSkVXpia33aNDDcNppTWz9FBzniMMCdBPBkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762108542; c=relaxed/simple;
	bh=JFJ1P9y6teFICHNTLVpFem6Cy1bDNFBdsgSePY1MAyI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=vB8O1O43nqazlukuI8Db4MxQDsRu8zq+5xFVPEFmOVXi1OnwEZKNlSqfUxf7IKBJMcUyVgoOlkkfN4UXPh0ATwfe/h0KeZIMsu5NdmtdtJJ3PGNGg/sPK06Aj9PDJmtXcsxuYjY+GHDDcmNn/ABYD//Tyl6UEICTDxBabafsdyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=GQLmubim; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1762108514; x=1762713314; i=w_armin@gmx.de;
	bh=PDzld/A6ar2ST8rICEV8BJNb+o/DufOT6Vx8/2eZosk=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=GQLmubimEkcItBHk81MRzCwc5c1cKzbDKXe9ARv8qaksismO7NKNnwG//Sryk7/U
	 zVkMGFzkEtOP+07UX2b5r2WnQ6zcPf/ss/2ndp1H4Lc1tnG2c6tXSnQVfVaVFyp/7
	 raZuTue93sZUCNsTm6o1NY44+CIBSQZHoohbCEnP+96UAsGe2PALnnTdEopql8Qzu
	 swqKVIILlk9QVtO15rYz4Rv94OSNp1rPTC5F5sVpqYNHIXX07DHB/KU3bd+plgXoh
	 2gZkjFYth0BVyjE2kaIFz6vA9Cfl4zk6RnyITBYkPEM1ZhJCqTa9J3cKPEAkt22ud
	 X234AS7Dn/SIpOPjtg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.69] ([93.202.247.91]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N5mKP-1wKvJx2FNz-00wZ2g; Sun, 02
 Nov 2025 19:35:14 +0100
Message-ID: <83b004ce-b34e-41a4-b35d-1f24056ac60a@gmx.de>
Date: Sun, 2 Nov 2025 19:35:12 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/6] platform/x86: ayaneo-ec: Add suspend hook
To: Antheas Kapenekakis <lkml@antheas.dev>,
 platform-driver-x86@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
 Hans de Goede <hansg@kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Derek John Clark <derekjohn.clark@gmail.com>,
 =?UTF-8?Q?Joaqu=C3=ADn_Ignacio_Aramend=C3=ADa?= <samsagax@gmail.com>,
 Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>
References: <20251031163651.1465981-1-lkml@antheas.dev>
 <20251031163651.1465981-7-lkml@antheas.dev>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <20251031163651.1465981-7-lkml@antheas.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:R0+/f8VifK/dBewucHPpgWnsjKZvzvLConPMd4E4lWN4CQyWXJd
 D6fViibpOwcyr2WxrXnUG3wKMTgdkQaqJPQkNrxdJJRQ1mFiZZ5c3aa/zTx+cb5oHyk3Bfg
 H6Wtj8RmijcccqlxzojTGeAI+o8AqJ19P5RyoslGgEUHci4XrzT++OJqNfSLonthFIBjRqJ
 u4606OxEYxyvI5hsp+VFA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Pkz3a9k0/VQ=;P3iITQr+E/vuRNk2q9hJ8j4ekJs
 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
 QKGQg==

Am 31.10.25 um 17:36 schrieb Antheas Kapenekakis:

> The Ayaneo EC resets after hibernation, losing the charge control state.
> Add a small PM hook to restore this state on hibernation resume.
>
> The fan speed is also lost during hibernation, but since hibernation
> failures are common with this class of devices, setting a low fan speed
> when the userspace program controlling the fan will potentially not
> take over could cause the device to overheat, so it is not restored.

Please update the patch description.

>
> Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
> ---
>   drivers/platform/x86/ayaneo-ec.c | 73 ++++++++++++++++++++++++++++++++
>   1 file changed, 73 insertions(+)
>
> diff --git a/drivers/platform/x86/ayaneo-ec.c b/drivers/platform/x86/aya=
neo-ec.c
> index 9548e3d22093..e1ad5968d3b4 100644
> --- a/drivers/platform/x86/ayaneo-ec.c
> +++ b/drivers/platform/x86/ayaneo-ec.c
> @@ -41,6 +41,8 @@
>   #define AYANEO_MODULE_LEFT	BIT(0)
>   #define AYANEO_MODULE_RIGHT	BIT(1)
>  =20
> +#define AYANEO_CACHE_LEN	1
> +
>   struct ayaneo_ec_quirk {
>   	bool has_fan_control;
>   	bool has_charge_control;
> @@ -51,6 +53,9 @@ struct ayaneo_ec_platform_data {
>   	struct platform_device *pdev;
>   	struct ayaneo_ec_quirk *quirks;
>   	struct acpi_battery_hook battery_hook;
> +
> +	bool restore_charge_limit;
> +	bool restore_pwm;
>   };
>  =20
>   static const struct ayaneo_ec_quirk quirk_fan =3D {
> @@ -207,10 +212,14 @@ static int ayaneo_ec_read(struct device *dev, enum=
 hwmon_sensor_types type,
>   static int ayaneo_ec_write(struct device *dev, enum hwmon_sensor_types=
 type,
>   			   u32 attr, int channel, long val)
>   {
> +	struct ayaneo_ec_platform_data *data =3D platform_get_drvdata(
> +		to_platform_device(dev));
> +	int ret;
>   	switch (type) {
>   	case hwmon_pwm:
>   		switch (attr) {
>   		case hwmon_pwm_enable:
> +			data->restore_pwm =3D false;
>   			switch (val) {
>   			case 1:
>   				return ec_write(AYANEO_PWM_ENABLE_REG,
> @@ -224,6 +233,15 @@ static int ayaneo_ec_write(struct device *dev, enum=
 hwmon_sensor_types type,
>   		case hwmon_pwm_input:
>   			if (val < 0 || val > 255)
>   				return -EINVAL;
> +			if (data->restore_pwm) {
> +				// Defer restoring PWM control to after
> +				// userspace resumes successfully
> +				ret =3D ec_write(AYANEO_PWM_ENABLE_REG,
> +					       AYANEO_PWM_MODE_MANUAL);
> +				if (ret)
> +					return ret;
> +				data->restore_pwm =3D false;

I suspect that you need to use a mutex to protect the restore sequence.

Thanks,
Armin Wolf

> +			}
>   			return ec_write(AYANEO_PWM_REG, (val * 100) / 255);
>   		default:
>   			break;
> @@ -474,10 +492,65 @@ static int ayaneo_ec_probe(struct platform_device =
*pdev)
>   	return 0;
>   }
>  =20
> +static int ayaneo_freeze(struct device *dev)
> +{
> +	struct platform_device *pdev =3D to_platform_device(dev);
> +	struct ayaneo_ec_platform_data *data =3D platform_get_drvdata(pdev);
> +	int ret;
> +	u8 tmp;
> +
> +	if (data->quirks->has_charge_control) {
> +		ret =3D ec_read(AYANEO_CHARGE_REG, &tmp);
> +		if (ret)
> +			return ret;
> +
> +		data->restore_charge_limit =3D tmp =3D=3D AYANEO_CHARGE_VAL_INHIBIT;
> +	}
> +
> +	if (data->quirks->has_fan_control) {
> +		ret =3D ec_read(AYANEO_PWM_ENABLE_REG, &tmp);
> +		if (ret)
> +			return ret;
> +
> +		data->restore_pwm =3D tmp =3D=3D AYANEO_PWM_MODE_MANUAL;
> +
> +		// Release the fan when entering hibernation to avoid
> +		// overheating if hibernation fails and hangs
> +		if (data->restore_pwm) {
> +			ret =3D ec_write(AYANEO_PWM_ENABLE_REG, AYANEO_PWM_MODE_AUTO);
> +			if (ret)
> +				return ret;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static int ayaneo_restore(struct device *dev)
> +{
> +	struct platform_device *pdev =3D to_platform_device(dev);
> +	struct ayaneo_ec_platform_data *data =3D platform_get_drvdata(pdev);
> +	int ret;
> +
> +	if (data->quirks->has_charge_control && data->restore_charge_limit) {
> +		ret =3D ec_write(AYANEO_CHARGE_REG, AYANEO_CHARGE_VAL_INHIBIT);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct dev_pm_ops ayaneo_pm_ops =3D {
> +	.freeze =3D ayaneo_freeze,
> +	.restore =3D ayaneo_restore,
> +};
> +
>   static struct platform_driver ayaneo_platform_driver =3D {
>   	.driver =3D {
>   		.name =3D "ayaneo-ec",
>   		.dev_groups =3D ayaneo_ec_groups,
> +		.pm =3D &ayaneo_pm_ops,
>   	},
>   	.probe =3D ayaneo_ec_probe,
>   };

