Return-Path: <linux-kernel+bounces-881960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41295C2950F
	for <lists+linux-kernel@lfdr.de>; Sun, 02 Nov 2025 19:30:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FDA2188DE6B
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Nov 2025 18:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8145621D3C0;
	Sun,  2 Nov 2025 18:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="W8c28TOn"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D3A434D3BA;
	Sun,  2 Nov 2025 18:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762108241; cv=none; b=bC5yDkYtcFLamb7UJsozQMyEijLI3EQ8rsKcIULOOa4Upm0/2/hrHrMuh98A0B5Y/90/q1aM5sau0ySLuIPfIuy8tj2qzFdcUEmDy49BMk6iM2+m8fIWPWNZinqnRxjLrJYI4hnAhxEdYJ3WUiIFG46v+brEmTCNTpNVxs5UX3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762108241; c=relaxed/simple;
	bh=sHHa3ByZ8sMbtA/uoV+Gh8oPKobsXyu/FIQ54Fv6+8o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n92xiNiRIHsln9Qtwjtaqs3pf6WOP4d77RglWuIIpwGigMr+wwb3zbH0/qcR1Bs76o1cgp2TmtODmNWi+zez2N4bAo+jyBeiFdG1ZORSH7aDZd33LAmE5ybLnrplrlwM4lNgzxFD2VeQyh+xXlB4WFrSO+F2T82yG7zYQd2qpxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=W8c28TOn; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1762108215; x=1762713015; i=w_armin@gmx.de;
	bh=GcjoztL6CzSBJ56WrdHNrcUViDI8F5g+mxSx/JsQcXc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=W8c28TOn8HYwNdiT4fJV/n4MlG18O/SSZgGLH0SaK2x317+7iFo38r+qrikfibZM
	 l8yMed56gjKxHgKn+OU717or4AMXn4mDDltkMHqbEIM8kosvFZKd9HD5j6WT4pQgc
	 t9Wv71qbzOB7WBwZGlomsHwhQvxd1rnXeoJshBXF9i4JJxNU4bUWG3nfosf3vk5p4
	 RGrOWmUrPKUgSXLACaAXWpigiQLI6dltrpvDKLLo3HPtzLT6RZ27qUehX0yaDxyki
	 Fyg3tEloAXDDv3NYVALjms8K6o+GYbt3Nui5CBvqULozWRC+3IjcyW8Ug/rL6sU0R
	 Mben7ZUiZnhaa2jEJA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.69] ([93.202.247.91]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MBUqL-1vOfur2yHn-0002qg; Sun, 02
 Nov 2025 19:30:14 +0100
Message-ID: <7c521e72-1b32-4172-90ec-6e793941a8ed@gmx.de>
Date: Sun, 2 Nov 2025 19:30:12 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/6] platform/x86: ayaneo-ec: Add controller power and
 modules attributes
To: Antheas Kapenekakis <lkml@antheas.dev>,
 platform-driver-x86@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
 Hans de Goede <hansg@kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Derek John Clark <derekjohn.clark@gmail.com>,
 =?UTF-8?Q?Joaqu=C3=ADn_Ignacio_Aramend=C3=ADa?= <samsagax@gmail.com>,
 Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>
References: <20251031163651.1465981-1-lkml@antheas.dev>
 <20251031163651.1465981-5-lkml@antheas.dev>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <20251031163651.1465981-5-lkml@antheas.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:S/OIbqijf/8kME4ipJ8GjvIY+mMHhzaqDb/8aY8AWuCezgG1Rb/
 CPNHTY6aUbUxnuY0A1kssEoJLK0hV+koDBKvg8yfRSxPmB+LZQYLdolWf2GZbBpsTagTnnw
 CKRFSjzOJ+85JKMYULS0WmBb97qwp7UdNeBD+3reVYaGmDqEkBXQPFVc9aCQ3Aafa6MxsAN
 FYQfRc2mlK/4VrVNSnv3A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:XfIA3NDUBfw=;b7lRPUmZ3dBtatkVypmcH3ynD/A
 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
 EhAo3LErpGcGE0R/nSwikzErCQtDl

Am 31.10.25 um 17:36 schrieb Antheas Kapenekakis:

> The Ayaneo 3 features hot-swappable controller modules. The ejection
> and management is done through HID. However, after ejecting the modules,
> the controller needs to be power cycled via the EC to re-initialize.
>
> For this, the EC provides a variable that holds whether the left or
> right modules are connected, and a power control register to turn
> the controller on or off. After ejecting the modules, the controller
> should be turned off. Then, after both modules are reinserted,
> the controller may be powered on again to re-initialize.
>
> This patch introduces two new sysfs attributes:
>   - `controller_modules`: a read-only attribute that indicates whether
>     the left and right modules are connected (none, left, right, both).
>   - `controller_power`: a read-write attribute that allows the user
>     to turn the controller on or off (with '1'/'0').
>
> Therefore, after ejection is complete, userspace can power off the
> controller, then wait until both modules have been reinserted
> (`controller_modules` will return 'both') to turn on the controller.
>
> Reviewed-by: Armin Wolf <W_Armin@gmx.de>
> Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
> ---
>   .../ABI/testing/sysfs-platform-ayaneo-ec      |  19 ++++
>   MAINTAINERS                                   |   1 +
>   drivers/platform/x86/ayaneo-ec.c              | 106 ++++++++++++++++++
>   3 files changed, 126 insertions(+)
>   create mode 100644 Documentation/ABI/testing/sysfs-platform-ayaneo-ec
>
> diff --git a/Documentation/ABI/testing/sysfs-platform-ayaneo-ec b/Docume=
ntation/ABI/testing/sysfs-platform-ayaneo-ec
> new file mode 100644
> index 000000000000..3c9c3580c685
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-platform-ayaneo-ec
> @@ -0,0 +1,19 @@
> +What:		/sys/devices/platform/ayaneo-ec/controller_power
> +Date:		Oct 2025

I think you need to update those dates.

> +KernelVersion:	6.19
> +Contact:	"Antheas Kapenekakis" <lkml@antheas.dev>
> +Description:
> +		Current controller power state. Allows turning on and off
> +		the controller power (e.g. for power savings). Write 1 to
> +		turn on, 0 to turn off. File is readable and writable.
> +
> +What:		/sys/devices/platform/ayaneo-ec/controller_modules
> +Date:		Oct 2025
> +KernelVersion:	6.19
> +Contact:	"Antheas Kapenekakis"  <lkml@antheas.dev>
> +Description:
> +		Shows which controller modules are currently connected to
> +		the device. Possible values are "left", "right" and "both".
> +		File is read-only. The Windows software for this device
> +		will only set controller power to 1 if both module sides
> +		are connected (i.e. this file returns "both").
> diff --git a/MAINTAINERS b/MAINTAINERS
> index da9498d8cc89..b4d62ea9a926 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4191,6 +4191,7 @@ AYANEO PLATFORM EC DRIVER
>   M:	Antheas Kapenekakis <lkml@antheas.dev>
>   L:	platform-driver-x86@vger.kernel.org
>   S:	Maintained
> +F:	Documentation/ABI/testing/sysfs-platform-ayaneo
>   F:	drivers/platform/x86/ayaneo-ec.c
>  =20
>   AZ6007 DVB DRIVER
> diff --git a/drivers/platform/x86/ayaneo-ec.c b/drivers/platform/x86/aya=
neo-ec.c
> index 697bb053a7d6..0652c044ad76 100644
> --- a/drivers/platform/x86/ayaneo-ec.c
> +++ b/drivers/platform/x86/ayaneo-ec.c
> @@ -8,6 +8,7 @@
>    */
>  =20
>   #include <linux/acpi.h>
> +#include <linux/bits.h>
>   #include <linux/dmi.h>
>   #include <linux/err.h>
>   #include <linux/hwmon.h>
> @@ -16,6 +17,7 @@
>   #include <linux/module.h>
>   #include <linux/platform_device.h>
>   #include <linux/power_supply.h>
> +#include <linux/sysfs.h>
>   #include <acpi/battery.h>
>  =20
>   #define AYANEO_PWM_ENABLE_REG	 0x4A
> @@ -32,9 +34,17 @@
>   #define AYANEO_CHARGE_VAL_AUTO		0xaa
>   #define AYANEO_CHARGE_VAL_INHIBIT	0x55
>  =20
> +#define AYANEO_POWER_REG	0x2d
> +#define AYANEO_POWER_OFF	0xfe
> +#define AYANEO_POWER_ON		0xff
> +#define AYANEO_MODULE_REG	0x2f
> +#define AYANEO_MODULE_LEFT	BIT(0)
> +#define AYANEO_MODULE_RIGHT	BIT(1)

Using GENMASK() would make sense here.

With those issues being fixed:
Reviewed-by: Armin Wolf <W_Armin@gmx.de>

> +
>   struct ayaneo_ec_quirk {
>   	bool has_fan_control;
>   	bool has_charge_control;
> +	bool has_magic_modules;
>   };
>  =20
>   struct ayaneo_ec_platform_data {
> @@ -46,6 +56,7 @@ struct ayaneo_ec_platform_data {
>   static const struct ayaneo_ec_quirk quirk_ayaneo3 =3D {
>   	.has_fan_control =3D true,
>   	.has_charge_control =3D true,
> +	.has_magic_modules =3D true,
>   };
>  =20
>   static const struct dmi_system_id dmi_table[] =3D {
> @@ -266,6 +277,100 @@ static int ayaneo_remove_battery(struct power_supp=
ly *battery,
>   	return 0;
>   }
>  =20
> +static ssize_t controller_power_store(struct device *dev,
> +				      struct device_attribute *attr,
> +				      const char *buf,
> +				      size_t count)
> +{
> +	bool value;
> +	int ret;
> +
> +	ret =3D kstrtobool(buf, &value);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D ec_write(AYANEO_POWER_REG, value ? AYANEO_POWER_ON : AYANEO_PO=
WER_OFF);
> +	if (ret)
> +		return ret;
> +
> +	return count;
> +}
> +
> +static ssize_t controller_power_show(struct device *dev,
> +				     struct device_attribute *attr,
> +				     char *buf)
> +{
> +	int ret;
> +	u8 val;
> +
> +	ret =3D ec_read(AYANEO_POWER_REG, &val);
> +	if (ret)
> +		return ret;
> +
> +	return sysfs_emit(buf, "%d\n", val =3D=3D AYANEO_POWER_ON);
> +}
> +
> +static DEVICE_ATTR_RW(controller_power);
> +
> +static ssize_t controller_modules_show(struct device *dev,
> +				       struct device_attribute *attr, char *buf)
> +{
> +	char *out;
> +	int ret;
> +	u8 val;
> +
> +	ret =3D ec_read(AYANEO_MODULE_REG, &val);
> +	if (ret)
> +		return ret;
> +
> +	switch (~val & (AYANEO_MODULE_LEFT | AYANEO_MODULE_RIGHT)) {
> +	case AYANEO_MODULE_LEFT | AYANEO_MODULE_RIGHT:
> +		out =3D "both";
> +		break;
> +	case AYANEO_MODULE_LEFT:
> +		out =3D "left";
> +		break;
> +	case AYANEO_MODULE_RIGHT:
> +		out =3D "right";
> +		break;
> +	default:
> +		out =3D "none";
> +		break;
> +	}
> +
> +	return sysfs_emit(buf, "%s\n", out);
> +}
> +
> +static DEVICE_ATTR_RO(controller_modules);
> +
> +static struct attribute *aya_mm_attrs[] =3D {
> +	&dev_attr_controller_power.attr,
> +	&dev_attr_controller_modules.attr,
> +	NULL
> +};
> +
> +static umode_t aya_mm_is_visible(struct kobject *kobj,
> +				 struct attribute *attr, int n)
> +{
> +	struct device *dev =3D kobj_to_dev(kobj);
> +	struct platform_device *pdev =3D to_platform_device(dev);
> +	struct ayaneo_ec_platform_data *data =3D platform_get_drvdata(pdev);
> +
> +	if (data->quirks->has_magic_modules)
> +		return attr->mode;
> +	return 0;
> +}
> +
> +static const struct attribute_group aya_mm_attribute_group =3D {
> +	.is_visible =3D aya_mm_is_visible,
> +	.attrs =3D aya_mm_attrs,
> +};
> +
> +static const struct attribute_group *ayaneo_ec_groups[] =3D {
> +	&aya_mm_attribute_group,
> +	NULL
> +};
> +
>   static int ayaneo_ec_probe(struct platform_device *pdev)
>   {
>   	const struct dmi_system_id *dmi_entry;
> @@ -307,6 +412,7 @@ static int ayaneo_ec_probe(struct platform_device *p=
dev)
>   static struct platform_driver ayaneo_platform_driver =3D {
>   	.driver =3D {
>   		.name =3D "ayaneo-ec",
> +		.dev_groups =3D ayaneo_ec_groups,
>   	},
>   	.probe =3D ayaneo_ec_probe,
>   };

