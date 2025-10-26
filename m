Return-Path: <linux-kernel+bounces-870650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AEFFBC0B5BF
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 23:26:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 456014ED057
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 22:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F68B2FE58E;
	Sun, 26 Oct 2025 22:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="AcOhhjeX"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D43451BC5C;
	Sun, 26 Oct 2025 22:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761517560; cv=none; b=UCreleW1UV3mpoQfwMFhxV1J4McK4oxyvHZh6/jHBOnu7f0kowOjuEskJ4h+XoB7/FnR066St2Ev2mlfKnJ5n8BGezi6GhCgOqbxdUi73YJfhwihMneIZbRcCoqy2SP4Qb/SG7NoluPwz92UVYeLmgzGPuIbKbSCOc2AnkcakxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761517560; c=relaxed/simple;
	bh=kEsFoG43ybyNGs1wAOoLL1ShGo+CrlpehI/Ov6ZVI7k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LGdHe58poQCVSceFgrSknegVUXEIVeK4M4NvJ1w0dDk7dUdi3oMkuLarloGBA75AMX8Z/Z63W7HG2C78oVbKGbA3tng6V1Ll0cewBLNlOsvTWRV/rEEz/kUq46kuA6wYTqaFQ53BIc1sKD/UizfCIpSiyxjsOdDYkbWL5LLIrxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=AcOhhjeX; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1761517550; x=1762122350; i=w_armin@gmx.de;
	bh=pxOj0fRHhkSK7bYnw2/jnn84cKJbHG6hzdJpvRGcleY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=AcOhhjeX4QZRzYbaGrJKQN2ObrjwXsrlC8kvQ+QiYAHmb0UwcW6FYpXmupY2IR4O
	 AJimFKZQZ+SzpFQT3/HzPwS76tomqzQ4B7//Te4yyRIb131bltSKRev3n7W7zNzcR
	 4t/BPk/TZBVx6gI3A0rk5K8nclpBbOebeGqpfddaE9yg6D/XumzTZZfYKElXMHD02
	 Bke7V4SFiexZE4LMYNzVeoPvAaCRoxmTMHYaKN6xjcfQpJQANOn2keus/nAfWr1Rh
	 OaXK0ZXC2U6XviR0rCixs/2HIe9OJWecX5Ca03s5pPkGoxtiCBcwAcxpr9xbnoZBk
	 GkqC/UIhyvMWbT9A9A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.69] ([93.202.247.91]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MEV3C-1uxCjs1Any-00HR3C; Sun, 26
 Oct 2025 23:25:50 +0100
Message-ID: <552b53b0-f583-4bac-80a5-1f9509bf575f@gmx.de>
Date: Sun, 26 Oct 2025 23:25:47 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/6] platform/x86: ayaneo-ec: Add Ayaneo Embedded
 Controller platform driver
To: Antheas Kapenekakis <lkml@antheas.dev>,
 platform-driver-x86@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
 Hans de Goede <hansg@kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Derek John Clark <derekjohn.clark@gmail.com>,
 =?UTF-8?Q?Joaqu=C3=ADn_Ignacio_Aramend=C3=ADa?= <samsagax@gmail.com>,
 Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>
References: <20251015084414.1391595-1-lkml@antheas.dev>
 <20251015084414.1391595-2-lkml@antheas.dev>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <20251015084414.1391595-2-lkml@antheas.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:AX6GAq1PrSXquH0FsUCOLZ7IJFf0D3hF85HMKbbFzfXdJLbjlNu
 ro16/u5r/BOlngWu6lBIMr/ZRHNe2x1TdHJs733jVp8Ma0Zej9u3LGTL+AQCbIllsFm4nKP
 TNrAHUk9jeWrFiPxztaVU37XgXTe8MjAt+DZi70gx8sat5ANbm2xogIo203G9D16bovVcpL
 u0hQaZ+sqGX11vGUS9rIQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:vsQJt6H93kk=;7MdtU0qWX6MzIgkl2qcpe/WaoUn
 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
 vb95RttuYgWcpvJ+602HMfq/4U=

Am 15.10.25 um 10:44 schrieb Antheas Kapenekakis:

> Recent Ayaneo devices feature an ACPI mapped Embedded Controller (EC)
> with standard addresses across models that provides access to fan
> speed, fan control, battery charge limits, and controller power
> controls. Introduce a new driver stub that will handle these driver
> features.
>
> Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
> ---
>   MAINTAINERS                      |  6 +++
>   drivers/platform/x86/Kconfig     | 10 ++++
>   drivers/platform/x86/Makefile    |  3 ++
>   drivers/platform/x86/ayaneo-ec.c | 89 ++++++++++++++++++++++++++++++++
>   4 files changed, 108 insertions(+)
>   create mode 100644 drivers/platform/x86/ayaneo-ec.c
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 46126ce2f968..8c4d0c26ca77 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4187,6 +4187,12 @@ W:	https://ez.analog.com/linux-software-drivers
>   F:	Documentation/devicetree/bindings/pwm/adi,axi-pwmgen.yaml
>   F:	drivers/pwm/pwm-axi-pwmgen.c
>  =20
> +AYANEO PLATFORM EC DRIVER
> +M:	Antheas Kapenekakis <lkml@antheas.dev>
> +L:	platform-driver-x86@vger.kernel.org
> +S:	Maintained
> +F:	drivers/platform/x86/ayaneo-ec.c
> +
>   AZ6007 DVB DRIVER
>   M:	Mauro Carvalho Chehab <mchehab@kernel.org>
>   L:	linux-media@vger.kernel.org
> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
> index 46e62feeda3c..ff2678927696 100644
> --- a/drivers/platform/x86/Kconfig
> +++ b/drivers/platform/x86/Kconfig
> @@ -316,6 +316,16 @@ config ASUS_TF103C_DOCK
>   	  If you have an Asus TF103C tablet say Y or M here, for a generic x8=
6
>   	  distro config say M here.
>  =20
> +config AYANEO_EC
> +	tristate "Ayaneo EC platform control"
> +	depends on X86

Hi,

i think the "depends on X86" part is not necessary, all X86 platform drive=
rs are
already only selectable on X86.

> +	help
> +	  Enables support for the platform EC of Ayaneo devices. This
> +	  includes fan control, fan speed, charge limit, magic
> +	  module detection, and controller power control.
> +
> +	  If you have an Ayaneo device, say Y or M here.
> +
>   config MERAKI_MX100
>   	tristate "Cisco Meraki MX100 Platform Driver"
>   	depends on GPIOLIB
> diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefi=
le
> index c7db2a88c11a..274a685eb92d 100644
> --- a/drivers/platform/x86/Makefile
> +++ b/drivers/platform/x86/Makefile
> @@ -39,6 +39,9 @@ obj-$(CONFIG_ASUS_TF103C_DOCK)	+=3D asus-tf103c-dock.o
>   obj-$(CONFIG_EEEPC_LAPTOP)	+=3D eeepc-laptop.o
>   obj-$(CONFIG_EEEPC_WMI)		+=3D eeepc-wmi.o
>  =20
> +# Ayaneo
> +obj-$(CONFIG_AYANEO_EC)		+=3D ayaneo-ec.o
> +
>   # Cisco/Meraki
>   obj-$(CONFIG_MERAKI_MX100)	+=3D meraki-mx100.o
>  =20
> diff --git a/drivers/platform/x86/ayaneo-ec.c b/drivers/platform/x86/aya=
neo-ec.c
> new file mode 100644
> index 000000000000..90b86527ab0d
> --- /dev/null
> +++ b/drivers/platform/x86/ayaneo-ec.c
> @@ -0,0 +1,89 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Platform driver for the Embedded Controller (EC) of Ayaneo devices. =
Handles
> + * hwmon (fan speed, fan control), battery charge limits, and magic mod=
ule
> + * control (connected modules, controller disconnection).
> + *
> + * Copyright (C) 2025 Antheas Kapenekakis <lkml@antheas.dev>
> + */
> +
> +#include <linux/dmi.h>
> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +
> +struct ayaneo_ec_quirk {
> +};
> +
> +struct ayaneo_ec_platform_data {
> +	struct platform_device *pdev;
> +	struct ayaneo_ec_quirk *quirks;
> +};
> +
> +static const struct ayaneo_ec_quirk ayaneo3 =3D {
> +};
> +
> +static const struct dmi_system_id dmi_table[] =3D {
> +	{
> +		.matches =3D {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "AYANEO"),
> +			DMI_EXACT_MATCH(DMI_BOARD_NAME, "AYANEO 3"),
> +		},
> +		.driver_data =3D (void *)&ayaneo3,
> +	},
> +	{},
> +};

Missing MODULE_DEVICE_TABLE().

> +
> +static int ayaneo_ec_probe(struct platform_device *pdev)
> +{
> +	const struct dmi_system_id *dmi_entry;
> +	struct ayaneo_ec_platform_data *data;
> +
> +	dmi_entry =3D dmi_first_match(dmi_table);
> +	if (!dmi_entry)
> +		return -ENODEV;

Why not doing this inside ayaneo_ec_init() ? This would also allow you
to mark the DMI table as __initconst. Please also mark ayaneo_ec_probe as
__init as well.

Thanks,
Armin Wolf

> +
> +	data =3D devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	data->pdev =3D pdev;
> +	data->quirks =3D dmi_entry->driver_data;
> +	platform_set_drvdata(pdev, data);
> +
> +	return 0;
> +}
> +
> +static struct platform_driver ayaneo_platform_driver =3D {
> +	.driver =3D {
> +		.name =3D "ayaneo-ec",
> +	},
> +	.probe =3D ayaneo_ec_probe,
> +};
> +
> +static struct platform_device *ayaneo_platform_device;
> +
> +static int __init ayaneo_ec_init(void)
> +{
> +	ayaneo_platform_device =3D
> +		platform_create_bundle(&ayaneo_platform_driver,
> +				       ayaneo_ec_probe, NULL, 0, NULL, 0);
> +
> +	return PTR_ERR_OR_ZERO(ayaneo_platform_device);
> +}
> +
> +static void __exit ayaneo_ec_exit(void)
> +{
> +	platform_device_unregister(ayaneo_platform_device);
> +	platform_driver_unregister(&ayaneo_platform_driver);
> +}
> +
> +MODULE_DEVICE_TABLE(dmi, dmi_table);
> +
> +module_init(ayaneo_ec_init);
> +module_exit(ayaneo_ec_exit);
> +
> +MODULE_AUTHOR("Antheas Kapenekakis <lkml@antheas.dev>");
> +MODULE_DESCRIPTION("Ayaneo Embedded Controller (EC) platform features")=
;
> +MODULE_LICENSE("GPL");

