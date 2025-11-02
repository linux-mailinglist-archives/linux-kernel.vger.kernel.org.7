Return-Path: <linux-kernel+bounces-881952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C23ACC294DF
	for <lists+linux-kernel@lfdr.de>; Sun, 02 Nov 2025 19:21:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D132C4E7756
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Nov 2025 18:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E2292080C1;
	Sun,  2 Nov 2025 18:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="Z+zq1Zwo"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E643B2A0;
	Sun,  2 Nov 2025 18:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762107695; cv=none; b=JDXdtcistdVDUNTUpTjNwWgT3NyiSjorxx0MoKBWAC/rN6q4GFaSiiIRqq8V2yE7D+aFu2h+TDtugD8V6DCijkwi8bEmNwY3VHNTDfM0TRpakhQUHck8r5jeCNSJ49iE+0Ab9QpZ0W7bPZ5A0NSUlTDU0JpHXcQN7GLj88UTb4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762107695; c=relaxed/simple;
	bh=WZZ4OkdzRWFyKwcJG7E+d1QbBIyw9hTGaHQYv3SdlFo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e48ACQeBvEpSnKl173/d+3cNeg6DFlbUehPqcLnVCm4Bt4v42LTrb1jDZCoRjZ5h+7MnOTpTsLZKOL8I5rVg+n1Xmje0d8pGreiRJbF1XtZO9SNBtPWiw75uBVGl77B8uVy8hNdLIh5PNOYVZv79QS9AmiRNz5U5IGOhzBEmR7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=Z+zq1Zwo; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1762107666; x=1762712466; i=w_armin@gmx.de;
	bh=5a3LI6sAzc5fbSz4vMYAwdJuS6HbsbBZIzPCrs7R/r4=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Z+zq1ZwoHlLPLGTfIF9sN7mxeEvwW1Rfdk52qBgtGbZpEmwU5QOdW3T/N14JlKHo
	 PDKHq4XTzXPBp3wAiLrYyMRgfNy5aeY+/UBBQ/XbXqXWeozgIwXy6g4dFzEnlpUaR
	 doWzKRLFC4jrPHDLUiAe06aQip39DOQUBpWvd44vL/T2wT86vplBzzscK2Z21xh73
	 lEtjncvBicRPNM4e/NpJbVXzKtjQGwUBDPa2UuHv+x3sUq1ACUlZceo8q2xU9K4Tu
	 sGKNNi4HxFyKDX2V/8UUabEpBWsmXQQqKMcXqh4N0cM0lOF8aQdGOW/AXhwUT3/Wd
	 9B4vnQMQe5WuBXCC5Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.69] ([93.202.247.91]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MY68d-1vlJHD0VnZ-00Um1d; Sun, 02
 Nov 2025 19:21:06 +0100
Message-ID: <eb7a2631-eed0-4a91-81ff-a2efcb70ad29@gmx.de>
Date: Sun, 2 Nov 2025 19:21:03 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/6] platform/x86: ayaneo-ec: Add Ayaneo Embedded
 Controller platform driver
To: Antheas Kapenekakis <lkml@antheas.dev>,
 platform-driver-x86@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
 Hans de Goede <hansg@kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Derek John Clark <derekjohn.clark@gmail.com>,
 =?UTF-8?Q?Joaqu=C3=ADn_Ignacio_Aramend=C3=ADa?= <samsagax@gmail.com>,
 Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>
References: <20251031163651.1465981-1-lkml@antheas.dev>
 <20251031163651.1465981-2-lkml@antheas.dev>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <20251031163651.1465981-2-lkml@antheas.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:wdCozLpl/2bvpNTHqZKfmk5Peh4OvB79Sbuu5Nd8ikkksZenKvY
 sLngPHPXkA4V79xHKu82GRLEc+f2V7qjQMYNPE+HzJCC1ro0qgG9m451Zq4/MN+Y2RJQu7+
 qwy8ClyowtLedia3dQJptD8hzrdPpc82iHhvOUGOqS+ku2lHIPI69b2OPPJHeGm1dNOCW+O
 RrnBbGdrB7h/+JT0RKljA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:LOJuPt1D3pQ=;rK78I5jGXvg5by3J+UgyjE9sbyM
 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

Am 31.10.25 um 17:36 schrieb Antheas Kapenekakis:

> Recent Ayaneo devices feature an ACPI mapped Embedded Controller (EC)
> with standard addresses across models that provides access to fan
> speed, fan control, battery charge limits, and controller power
> controls. Introduce a new driver stub that will handle these driver
> features.
>
> Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
> ---
>   MAINTAINERS                      |  6 +++
>   drivers/platform/x86/Kconfig     |  9 ++++
>   drivers/platform/x86/Makefile    |  3 ++
>   drivers/platform/x86/ayaneo-ec.c | 90 ++++++++++++++++++++++++++++++++
>   4 files changed, 108 insertions(+)
>   create mode 100644 drivers/platform/x86/ayaneo-ec.c
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 545a4776795e..da9498d8cc89 100644
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
> index 46e62feeda3c..ebe7d2ab8758 100644
> --- a/drivers/platform/x86/Kconfig
> +++ b/drivers/platform/x86/Kconfig
> @@ -316,6 +316,15 @@ config ASUS_TF103C_DOCK
>   	  If you have an Asus TF103C tablet say Y or M here, for a generic x8=
6
>   	  distro config say M here.
>  =20
> +config AYANEO_EC
> +	tristate "Ayaneo EC platform control"
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
> index 000000000000..2fe66c8a89f4
> --- /dev/null
> +++ b/drivers/platform/x86/ayaneo-ec.c
> @@ -0,0 +1,90 @@
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
> +#include <linux/err.h>
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
> +static const struct ayaneo_ec_quirk quirk_ayaneo3 =3D {
> +};
> +
> +static const struct dmi_system_id dmi_table[] =3D {
> +	{
> +		.matches =3D {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "AYANEO"),
> +			DMI_EXACT_MATCH(DMI_BOARD_NAME, "AYANEO 3"),
> +		},
> +		.driver_data =3D (void *)&quirk_ayaneo3,
> +	},
> +	{},
> +};

MODULE_DEVICE_TABLE() is missing, please add it so that the driver will
automatically load on supported devices.

> +
> +static int ayaneo_ec_probe(struct platform_device *pdev)
> +{
> +	const struct dmi_system_id *dmi_entry;
> +	struct ayaneo_ec_platform_data *data;
> +
> +	dmi_entry =3D dmi_first_match(dmi_table);
> +	if (!dmi_entry)
> +		return -ENODEV;

Please store the quirk inside a global variable and perform the DMI match
inside ayaneo_ec_init. This will allow you to mark the DMI table as __init=
const.

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

