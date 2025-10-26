Return-Path: <linux-kernel+bounces-870657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A39A7C0B61F
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 23:43:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 699E43B6F65
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 22:42:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 994182FDC2C;
	Sun, 26 Oct 2025 22:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="Juq6mEy8"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C83925A2A5;
	Sun, 26 Oct 2025 22:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761518571; cv=none; b=fdqJlxuuTxb2Y1m3Zhqj5nmzD8N8yzsQ+d3ImvyN+iAqjkOdklqoj6yrcaHZXXsc0YU02s1ljezVPClf3DCXVxTm1kQY4WrOrGMoDdcRfDgD7GtbJd0BL0YTpsR5ht6zkpe6NRG2jOgRxwt2mBRApjdSZ9l5Iaq+L2BefXKO7ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761518571; c=relaxed/simple;
	bh=9xoWttMVKgpnLUA0bd2JXuz5vCp2CTj+gTZMueKtR4A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HaP3SonL+OVePOoV2SS0K/2ZXM332aQR8WgjVKYZlgcmQG6z1Nyo8kt1O9YEUIDsw2jrug88oOFNAVxP/1hbaKwaLgMXaiPjzxQ+EmZLJmKwd7tmg7KQ5GeRR6cMC4GfuwuI3LZeIZ/N97xQnyp2udOyEEESZWBTrQFW3hKh2MM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=Juq6mEy8; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1761518562; x=1762123362; i=w_armin@gmx.de;
	bh=ZEGcaqMfAieJP+lje25MsHsNKxy0JOMF+9Wd2/vHnfE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Juq6mEy8lzGwUKHq9U+ljWiE6/Q0RgX/BeLnessJ02tThrTVojjOBH2fWbYWqFPV
	 1XZ7rAZgYuXsDW8yv+y6DGXXq1CjlvSalKriPbAZlGb3H1aSaxXKXkiAZ6C8hh77t
	 m7aBK1Yaa541bS6HkfDX8mrlLGAZOYgxB9h+KHEoI5BP3hq84Ma7S8uB+28o0owO7
	 HuWRSDoi1jO0nl3jbyzpUQ2NF1+7w7dZElgfuZ+LRS4qZM2/5fv7UkeGu58KnF0UV
	 i04YLV15eNH/53H2lBb10K6CJEgiN+6Y8SeTy7QE4WeB1NL6ligyJmiEFdRSlLY2H
	 zSx4g+dLPrXExTSSNw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.69] ([93.202.247.91]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M1Hdq-1vAPMG1Gv4-004Di0; Sun, 26
 Oct 2025 23:42:42 +0100
Message-ID: <7b1fa12c-dc4e-41f2-9807-a4e772c3888e@gmx.de>
Date: Sun, 26 Oct 2025 23:42:39 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/6] platform/x86: ayaneo-ec: Add controller power and
 modules attributes
To: Antheas Kapenekakis <lkml@antheas.dev>,
 platform-driver-x86@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
 Hans de Goede <hansg@kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Derek John Clark <derekjohn.clark@gmail.com>,
 =?UTF-8?Q?Joaqu=C3=ADn_Ignacio_Aramend=C3=ADa?= <samsagax@gmail.com>,
 Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>
References: <20251015084414.1391595-1-lkml@antheas.dev>
 <20251015084414.1391595-5-lkml@antheas.dev>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <20251015084414.1391595-5-lkml@antheas.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:mniyyOQgIoLSUQHeFrxbjC0wq1Ckym0K6c3KK6Gea7YttuMfZi+
 nYdApIzNoGIuRJ5TfFaNYkUuZkOiEYNgWvKTAsvQwBqc8+OIbnMrH9siZXDop7on6j6Auch
 2yGLt4nhWZzXZk8cqTLHfzZeKMSZXsrkEUee9syjFzOiEk5+OpHA0/8D4OR+rJ+XjN7TGoa
 Rl5RHx/GFXVx6TWFvkvYg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Xd0gF706Ohg=;YqRQWZn8beGH0ML+o2k4ZWtfjkK
 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

Am 15.10.25 um 10:44 schrieb Antheas Kapenekakis:

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
> Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
> ---
>   .../ABI/testing/sysfs-platform-ayaneo         |  19 ++++
>   MAINTAINERS                                   |   1 +
>   drivers/platform/x86/ayaneo-ec.c              | 100 ++++++++++++++++++
>   3 files changed, 120 insertions(+)
>   create mode 100644 Documentation/ABI/testing/sysfs-platform-ayaneo
>
> diff --git a/Documentation/ABI/testing/sysfs-platform-ayaneo b/Documenta=
tion/ABI/testing/sysfs-platform-ayaneo
> new file mode 100644
> index 000000000000..1fa32ba60fd0
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-platform-ayaneo

Better use Documentation/ABI/testing/sysfs-platform-ayaneo-ec.

> @@ -0,0 +1,19 @@
> +What:		/sys/devices/platform/<platform>/controller_power

Better use /sys/devices/platform/ayaneo-ec/controller_power.

> +Date:		Oct 2025
> +KernelVersion:	6.9

Kernel version is outdated.

> +Contact:	"Antheas Kapenekakis" <lkml@antheas.dev>
> +Description:
> +		Current controller power state. Allows turning on and off
> +		the controller power (e.g. for power savings). Write 1 to
> +		turn on, 0 to turn off. File is readable and writable.
> +
> +What:		/sys/devices/platform/<platform>/controller_modules

See above.

> +Date:		Oct 2025
> +KernelVersion:	6.9

See above.

With this being fixed:

Reviewed-by: Armin Wolf <W_Armin@gmx.de>

> +Contact:	"Antheas Kapenekakis"  <lkml@antheas.dev>
> +Description:
> +		Shows which controller modules are currently connected to
> +		the device. Possible values are "left", "right" and "both".
> +		File is read-only. The Windows software for this device
> +		will only set controller power to 1 if both module sides
> +		are connected (i.e. this file returns "both").
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8c4d0c26ca77..3dfa004555dd 100644
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
> index 23c283f5eb61..363b61fc6e12 100644
> --- a/drivers/platform/x86/ayaneo-ec.c
> +++ b/drivers/platform/x86/ayaneo-ec.c
> @@ -30,9 +30,17 @@
>   #define AYANEO_CHARGE_VAL_AUTO		0xaa
>   #define AYANEO_CHARGE_VAL_INHIBIT	0x55
>  =20
> +#define AYANEO_POWER_REG	0x2d
> +#define AYANEO_POWER_OFF	0xfe
> +#define AYANEO_POWER_ON		0xff
> +#define AYANEO_MODULE_REG	0x2f
> +#define AYANEO_MODULE_LEFT	BIT(0)
> +#define AYANEO_MODULE_RIGHT	BIT(1)
> +
>   struct ayaneo_ec_quirk {
>   	bool has_fan_control;
>   	bool has_charge_control;
> +	bool has_magic_modules;
>   };
>  =20
>   struct ayaneo_ec_platform_data {
> @@ -44,6 +52,7 @@ struct ayaneo_ec_platform_data {
>   static const struct ayaneo_ec_quirk ayaneo3 =3D {
>   	.has_fan_control =3D true,
>   	.has_charge_control =3D true,
> +	.has_magic_modules =3D true,
>   };
>  =20
>   static const struct dmi_system_id dmi_table[] =3D {
> @@ -262,6 +271,96 @@ static int ayaneo_remove_battery(struct power_suppl=
y *battery,
>   	return 0;
>   }
>  =20
> +static ssize_t controller_power_store(struct device *dev,
> +			    struct device_attribute *attr, const char *buf,
> +			    size_t count)
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
> +			   struct device_attribute *attr, char *buf)
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
> +	bool left, right;
> +	char *out;
> +	int ret;
> +	u8 val;
> +
> +	ret =3D ec_read(AYANEO_MODULE_REG, &val);
> +	if (ret)
> +		return ret;
> +
> +	left =3D !(val & AYANEO_MODULE_LEFT);
> +	right =3D !(val & AYANEO_MODULE_RIGHT);
> +
> +	if (left && right)
> +		out =3D "both";
> +	else if (left)
> +		out =3D "left";
> +	else if (right)
> +		out =3D "right";
> +	else
> +		out =3D "none";
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
> @@ -303,6 +402,7 @@ static int ayaneo_ec_probe(struct platform_device *p=
dev)
>   static struct platform_driver ayaneo_platform_driver =3D {
>   	.driver =3D {
>   		.name =3D "ayaneo-ec",
> +		.dev_groups =3D ayaneo_ec_groups,
>   	},
>   	.probe =3D ayaneo_ec_probe,
>   };

