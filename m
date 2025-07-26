Return-Path: <linux-kernel+bounces-746921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 33A79B12D19
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 01:37:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51BA416A41A
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 23:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDB6F22D4C5;
	Sat, 26 Jul 2025 23:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="V+XrhjWO"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B224C1F4CBC;
	Sat, 26 Jul 2025 23:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753573052; cv=none; b=LJPlHqp8+ONkl35Hh/8WWsAln1ln+XHGzVX5VW1Yj/ugsp8VDoPkJXDTPzNp2Xdb3MXTt175pqhvKI3LLepENAcopBF7PbJiEGMmFRr/ERBD5nBHiUZ7nEELud81ALDJv/kB1u1XkOnzNLWCs0PbCsKngesxA0tRxrAVkBeIFpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753573052; c=relaxed/simple;
	bh=kDkCxnYlzEBQe73s8nMdeEZJyf96oxJYMhTs2mtqKwk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H9BwWgTjCt1npHFiHv1bIKpAajdykXKlnYC3QGziHeJwarcLepHWY70ngh+MddMWrc+IyYmbaldvEPqDyEMRLjP1voJETJ2KO6DOR4YEPJ2rn0LlG86qi4aoHELGBRCyt1SvpZqm1x8eXejzS+/O2oIhuB14mJXYBeHyxJEg088=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=V+XrhjWO; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1753573040; x=1754177840; i=w_armin@gmx.de;
	bh=4ZNW+z2bYMklOzQo27/67y7D62ES/gR89SGeK4HUTpQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=V+XrhjWOSltjm1VKq7hmR02jZW8JKGGZ+oJO8hJbekGYoQLnXJmDe7uQpfinUah9
	 rOT+aN6643X4ang485/s+0sFaUewqy2Obp2RNmUep7wvortBICGMN6seC25b1JaCI
	 tzKpuEK7m88vLwuUGMWKy2tSCa5l9oRwaYAyusKGfyENXbhVz2dWjTtqNq/iBd77Y
	 OxgFkzW3cv474Ksbf/pmHZ/dBuvfWNrLnKulr6KbrgIhWAI0uC1t1NmTmrZmHxKhg
	 NNV/lY/2LSSbBKDWF5cvGRmTwLR5TFu//jR/5Pcc0PL4+hy8FtjYYF9jvClO48TQl
	 QaByFNmAwkY4xId9LQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.69] ([87.177.78.219]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MeCtj-1u5vCa2Vfj-00fJYp; Sun, 27
 Jul 2025 01:37:19 +0200
Message-ID: <edc7d119-ee64-489b-ab1d-9577f007e918@gmx.de>
Date: Sun, 27 Jul 2025 01:37:16 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/4] platform/x86: (ayn-ec) Add Temperature Sensors
To: "Derek J. Clark" <derekjohn.clark@gmail.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Hans de Goede <hansg@kernel.org>
Cc: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>,
 Alok Tiwari <alok.a.tiwari@oracle.com>,
 David Box <david.e.box@linux.intel.com>,
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org
References: <20250726204041.516440-1-derekjohn.clark@gmail.com>
 <20250726204041.516440-3-derekjohn.clark@gmail.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <20250726204041.516440-3-derekjohn.clark@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:HJ13utok7jiaTq3hqWAFiYpWDHbmndIJOqv+F7nQaWUJYm9wJWB
 8pjIOZybSPqoyLhs7MZLd2XOSKBvSDl3Xz83RJVTPm3yYEvoV+XHXsfnZtW7ZYae8q1Swz4
 P/4oi21hmEbQCom/PBnsHSkl9z6WCS2GnGwgH6HBaxHRJ+ofnGA+eBlOnNSyV76QcxVl6DF
 RwdW6AYjHdkvON9LahNYw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:/OPZFQTsGCI=;kjO21Yq79xF+dxJR2nFkeVmRmzc
 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
 vV/Hfxu2C2M+JtDBcTCdbGrmTTwHPnpg=

Am 26.07.25 um 22:40 schrieb Derek J. Clark:

> Adds temperature sensors to the ayn-ec hwmon interface. These read-only
> values include Battery, Motherboard, Charger IC, vCore, and CPU Core, as
> well as labels for each entry. The temperature values provided by the EC
> are whole numbers in degrees Celsius. As hwmon expects millidegrees, we
> scale the raw value up.
>
> `sensors` output after this patch is applied:
> aynec-isa-0000
> Adapter: ISA adapter
> fan1:        1876 RPM
> Battery:      +29.0=C2=B0C
> Motherboard:  +30.0=C2=B0C
> Charger IC:   +30.0=C2=B0C
> vCore:        +36.0=C2=B0C
> CPU Core:     +48.0=C2=B0C
>
> Signed-off-by: Derek J. Clark <derekjohn.clark@gmail.com>
> ---
>   drivers/platform/x86/ayn-ec.c | 88 ++++++++++++++++++++++++++++++++++-
>   1 file changed, 86 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/platform/x86/ayn-ec.c b/drivers/platform/x86/ayn-ec=
.c
> index 8bd3ed1c69eb..466cc33adcb0 100644
> --- a/drivers/platform/x86/ayn-ec.c
> +++ b/drivers/platform/x86/ayn-ec.c
> @@ -61,6 +61,14 @@
>   #define HWMON_PWM_FAN_MODE_AUTO	0x02
>   #define HWMON_PWM_FAN_MODE_EC_CURVE	0x03
>  =20
> +/* EC Temperature Sensors */
> +#define AYN_SENSOR_BAT_TEMP_REG		0x04 /* Battery */
> +#define AYN_SENSOR_CHARGE_TEMP_REG	0x07 /* Charger IC */
> +#define AYN_SENSOR_MB_TEMP_REG		0x05 /* Motherboard */
> +#define AYN_SENSOR_PROC_TEMP_REG	0x09 /* CPU Core */
> +#define AYN_SENSOR_VCORE_TEMP_REG	0x08 /* vCore */
> +
> +

Please avoid multiple blank lines.

>   /* Handle ACPI lock mechanism */
>   #define ACPI_LOCK_DELAY_MS 500
>  =20
> @@ -81,8 +89,19 @@ struct ayn_device {
>   	u32 ayn_lock; /* ACPI EC Lock */
>   } drvdata;
>  =20
> -/* Handle ACPI lock mechanism */
> -#define ACPI_LOCK_DELAY_MS 500
> +struct thermal_sensor {
> +	char *name;
> +	int reg;
> +};
> +
> +static struct thermal_sensor thermal_sensors[] =3D {
> +	{ "Battery",		AYN_SENSOR_BAT_TEMP_REG },
> +	{ "Motherboard",	AYN_SENSOR_MB_TEMP_REG },
> +	{ "Charger IC",		AYN_SENSOR_CHARGE_TEMP_REG },
> +	{ "vCore",		AYN_SENSOR_VCORE_TEMP_REG },
> +	{ "CPU Core",		AYN_SENSOR_PROC_TEMP_REG },
> +	{}
> +};

Please declare this array as const.

>  =20
>   static bool lock_global_acpi_lock(void)
>   {
> @@ -428,6 +447,61 @@ static SENSOR_DEVICE_ATTR_RW(pwm1_auto_point3_temp,=
 pwm_curve, 7);
>   static SENSOR_DEVICE_ATTR_RW(pwm1_auto_point4_temp, pwm_curve, 8);
>   static SENSOR_DEVICE_ATTR_RW(pwm1_auto_point5_temp, pwm_curve, 9);
>  =20
> +/**
> + * thermal_sensor_show() - Read a thermal sensor attribute value.
> + *
> + * @dev: The attribute's parent device.
> + * @attr: The attribute to read.
> + * @buf: Buffer to write the result into.
> + *
> + * Return: Number of bytes read, or an error.
> + */
> +static ssize_t thermal_sensor_show(struct device *dev,
> +				   struct device_attribute *attr, char *buf)
> +{
> +	long ret, val;
> +	int i;
> +
> +	i =3D to_sensor_dev_attr(attr)->index;
> +
> +	ret =3D read_from_ec(thermal_sensors[i].reg, 1, &val);
> +	if (ret)
> +		return ret;
> +
> +	val =3D val * 1000L;

Please use MILLIDEGREE_PER_DEGREE from linux/units.h here.

> +
> +	return sysfs_emit(buf, "%ld\n", val);
> +}
> +
> +/**
> + * thermal_sensor_label_show() - Read a thermal sensor attribute label.
> + *
> + * @dev: The attribute's parent device.
> + * @attr: The attribute to read.
> + * @buf: Buffer to read to.
> + *
> + * Return: Number of bytes read, or an error.
> + */
> +static ssize_t thermal_sensor_label_show(struct device *dev,
> +					 struct device_attribute *attr,
> +					 char *buf)
> +{
> +	int i =3D to_sensor_dev_attr(attr)->index;
> +
> +	return sysfs_emit(buf, "%s\n", thermal_sensors[i].name);
> +}
> +
> +static SENSOR_DEVICE_ATTR_RO(temp1_input, thermal_sensor, 0);
> +static SENSOR_DEVICE_ATTR_RO(temp2_input, thermal_sensor, 1);
> +static SENSOR_DEVICE_ATTR_RO(temp3_input, thermal_sensor, 2);
> +static SENSOR_DEVICE_ATTR_RO(temp4_input, thermal_sensor, 3);
> +static SENSOR_DEVICE_ATTR_RO(temp5_input, thermal_sensor, 4);
> +static SENSOR_DEVICE_ATTR_RO(temp1_label, thermal_sensor_label, 0);
> +static SENSOR_DEVICE_ATTR_RO(temp2_label, thermal_sensor_label, 1);
> +static SENSOR_DEVICE_ATTR_RO(temp3_label, thermal_sensor_label, 2);
> +static SENSOR_DEVICE_ATTR_RO(temp4_label, thermal_sensor_label, 3);
> +static SENSOR_DEVICE_ATTR_RO(temp5_label, thermal_sensor_label, 4);
> +
>   static struct attribute *ayn_sensors_attrs[] =3D {
>   	&sensor_dev_attr_pwm1_auto_point1_pwm.dev_attr.attr,
>   	&sensor_dev_attr_pwm1_auto_point1_temp.dev_attr.attr,
> @@ -439,6 +513,16 @@ static struct attribute *ayn_sensors_attrs[] =3D {
>   	&sensor_dev_attr_pwm1_auto_point4_temp.dev_attr.attr,
>   	&sensor_dev_attr_pwm1_auto_point5_pwm.dev_attr.attr,
>   	&sensor_dev_attr_pwm1_auto_point5_temp.dev_attr.attr,
> +	&sensor_dev_attr_temp1_input.dev_attr.attr,
> +	&sensor_dev_attr_temp1_label.dev_attr.attr,
> +	&sensor_dev_attr_temp2_input.dev_attr.attr,
> +	&sensor_dev_attr_temp2_label.dev_attr.attr,
> +	&sensor_dev_attr_temp3_input.dev_attr.attr,
> +	&sensor_dev_attr_temp3_label.dev_attr.attr,
> +	&sensor_dev_attr_temp4_input.dev_attr.attr,
> +	&sensor_dev_attr_temp4_label.dev_attr.attr,
> +	&sensor_dev_attr_temp5_input.dev_attr.attr,
> +	&sensor_dev_attr_temp5_label.dev_attr.attr,

Please use the standard hwmon API for exposing those temperature sensors.

Thanks,
Armin Wolf

>   	NULL,
>   };
>  =20

