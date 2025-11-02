Return-Path: <linux-kernel+bounces-881964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D26DC2952A
	for <lists+linux-kernel@lfdr.de>; Sun, 02 Nov 2025 19:36:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38B4A188C260
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Nov 2025 18:36:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6F3522333D;
	Sun,  2 Nov 2025 18:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="bh0pl6E+"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76974322A;
	Sun,  2 Nov 2025 18:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762108585; cv=none; b=UdHZeABgyBueGuPq63OOR7uM1HsK9TWpVuB8Vd6W4ggmjuRUNtI7Gccj8G5ZJiRkY9VNE0IyyA4YjKAGzxEHDaC/YUI4pC+5LN5JtI3b/vZNr0212M5mvekN0XDITgN0deqX/22KK8xW3rFPbb433pusPeLrI2jVJ+1orEk1i00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762108585; c=relaxed/simple;
	bh=Ma+sOo4IGrExqljCaKaf0IoImcP1tEoKBc2YTvdDqPg=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=IhnJyxS4Of6zCgjdl8Ci3nZl38Wgi9rQccYd7rjDTzAf/gCiBZ0inm5ZW3NufRI+bt7GJDADgIzvB0RXFeh9zCgOnTv/BUdQiSZXqdWlHSxqaVawtMVvTBT4RS3yYeYso1p6fasJ48lZpZzlqwcRVdX82xgcFNi2lZSWWqWGdNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=bh0pl6E+; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1762108557; x=1762713357; i=w_armin@gmx.de;
	bh=Ma+sOo4IGrExqljCaKaf0IoImcP1tEoKBc2YTvdDqPg=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=bh0pl6E+dFXEKKb9fRw5AXslByl/t4BelMNRcrx0dnqleqbuo6nzDrBAfvOPKFUC
	 SuXmyOFiXaztcT6rV3Yi+CpOW9DQ6+h7FdvXEVFaPKR4Q7sWLwyT0RY7dLSjT8CuN
	 PuAzc55jqRQG9KnAGzzyAVMTIIiHnrnGxOv5c9P5iulUIvUeV+qCydXUl5MfB0wRd
	 C+h8v6YTxtMWXeVOrwVZHF645EuUaaQkayM/fXYGBnN/Ksi623cqOiz0H5Y5hd7Lx
	 yg8xX/96ff/HFoqevCu1D2BiNSjj6vXN7SebvtUEqhFSKrtL5gJZtyyDMM5j+sa1h
	 LoJtumeTC6DneRzV7Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.69] ([93.202.247.91]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MkHMZ-1vzO0y2Epd-00pUFU; Sun, 02
 Nov 2025 19:35:57 +0100
Message-ID: <15c8e330-3c04-40de-8b87-1d699463c08a@gmx.de>
Date: Sun, 2 Nov 2025 19:35:55 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/6] platform/x86: ayaneo-ec: Add Ayaneo Embedded
 Controller platform driver
From: Armin Wolf <W_Armin@gmx.de>
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
 <eb7a2631-eed0-4a91-81ff-a2efcb70ad29@gmx.de>
Content-Language: en-US
In-Reply-To: <eb7a2631-eed0-4a91-81ff-a2efcb70ad29@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Z5vKctUSMQkfZKtJhdhNoT42NiJQ45Jql156jBt9Nid3yG7G+lv
 YouJROxk2BAyJ3HeEUCBCKOntVKXPBQ5mqaOYP8ck7fQ/mFTXANKJ+keww1FeReeDkvX5/j
 kBRdEPYjpa9U8MG/UMKjuF1fhTXZzuOe1EWFG5aMHaeW8th1a+OEmFNzcAYirI2g7xN4kkV
 J5LKaaZUW2GcfGGLi0yug==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Wq2u2NUjz6A=;e2rtTAm8Noy7TS9KzbDWKoAZMHC
 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
 Md6GMsAnS4iFCoGAk=

Am 02.11.25 um 19:21 schrieb Armin Wolf:

> Am 31.10.25 um 17:36 schrieb Antheas Kapenekakis:
>
>> Recent Ayaneo devices feature an ACPI mapped Embedded Controller (EC)
>> with standard addresses across models that provides access to fan
>> speed, fan control, battery charge limits, and controller power
>> controls. Introduce a new driver stub that will handle these driver
>> features.
>>
>> Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
>> ---
>> =C2=A0 MAINTAINERS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0 6 +++
>> =C2=A0 drivers/platform/x86/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 9 +=
+++
>> =C2=A0 drivers/platform/x86/Makefile=C2=A0=C2=A0=C2=A0 |=C2=A0 3 ++
>> =C2=A0 drivers/platform/x86/ayaneo-ec.c | 90 ++++++++++++++++++++++++++=
++++++
>> =C2=A0 4 files changed, 108 insertions(+)
>> =C2=A0 create mode 100644 drivers/platform/x86/ayaneo-ec.c
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 545a4776795e..da9498d8cc89 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -4187,6 +4187,12 @@ W: https://ez.analog.com/linux-software-drivers
>> =C2=A0 F: Documentation/devicetree/bindings/pwm/adi,axi-pwmgen.yaml
>> =C2=A0 F:=C2=A0=C2=A0=C2=A0 drivers/pwm/pwm-axi-pwmgen.c
>> =C2=A0 +AYANEO PLATFORM EC DRIVER
>> +M:=C2=A0=C2=A0=C2=A0 Antheas Kapenekakis <lkml@antheas.dev>
>> +L:=C2=A0=C2=A0=C2=A0 platform-driver-x86@vger.kernel.org
>> +S:=C2=A0=C2=A0=C2=A0 Maintained
>> +F:=C2=A0=C2=A0=C2=A0 drivers/platform/x86/ayaneo-ec.c
>> +
>> =C2=A0 AZ6007 DVB DRIVER
>> =C2=A0 M:=C2=A0=C2=A0=C2=A0 Mauro Carvalho Chehab <mchehab@kernel.org>
>> =C2=A0 L:=C2=A0=C2=A0=C2=A0 linux-media@vger.kernel.org
>> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfi=
g
>> index 46e62feeda3c..ebe7d2ab8758 100644
>> --- a/drivers/platform/x86/Kconfig
>> +++ b/drivers/platform/x86/Kconfig
>> @@ -316,6 +316,15 @@ config ASUS_TF103C_DOCK
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 If you have an Asus TF103C t=
ablet say Y or M here, for a=20
>> generic x86
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 distro config say M here.
>> =C2=A0 +config AYANEO_EC
>> +=C2=A0=C2=A0=C2=A0 tristate "Ayaneo EC platform control"

I forgot to mention that you need to depend on DMI.

>> +=C2=A0=C2=A0=C2=A0 help
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Enables support for the platform EC of =
Ayaneo devices. This
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 includes fan control, fan speed, charge=
 limit, magic
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 module detection, and controller power =
control.
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 If you have an Ayaneo device, say Y or =
M here.
>> +
>> =C2=A0 config MERAKI_MX100
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tristate "Cisco Meraki MX100 Platform Dr=
iver"
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 depends on GPIOLIB
>> diff --git a/drivers/platform/x86/Makefile=20
>> b/drivers/platform/x86/Makefile
>> index c7db2a88c11a..274a685eb92d 100644
>> --- a/drivers/platform/x86/Makefile
>> +++ b/drivers/platform/x86/Makefile
>> @@ -39,6 +39,9 @@ obj-$(CONFIG_ASUS_TF103C_DOCK)=C2=A0=C2=A0=C2=A0 +=3D=
=20
>> asus-tf103c-dock.o
>> =C2=A0 obj-$(CONFIG_EEEPC_LAPTOP)=C2=A0=C2=A0=C2=A0 +=3D eeepc-laptop.o
>> =C2=A0 obj-$(CONFIG_EEEPC_WMI)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 +=3D eeepc-wmi.o
>> =C2=A0 +# Ayaneo
>> +obj-$(CONFIG_AYANEO_EC)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 +=3D=
 ayaneo-ec.o
>> +
>> =C2=A0 # Cisco/Meraki
>> =C2=A0 obj-$(CONFIG_MERAKI_MX100)=C2=A0=C2=A0=C2=A0 +=3D meraki-mx100.o
>> =C2=A0 diff --git a/drivers/platform/x86/ayaneo-ec.c=20
>> b/drivers/platform/x86/ayaneo-ec.c
>> new file mode 100644
>> index 000000000000..2fe66c8a89f4
>> --- /dev/null
>> +++ b/drivers/platform/x86/ayaneo-ec.c
>> @@ -0,0 +1,90 @@
>> +// SPDX-License-Identifier: GPL-2.0+
>> +/*
>> + * Platform driver for the Embedded Controller (EC) of Ayaneo=20
>> devices. Handles
>> + * hwmon (fan speed, fan control), battery charge limits, and magic=20
>> module
>> + * control (connected modules, controller disconnection).
>> + *
>> + * Copyright (C) 2025 Antheas Kapenekakis <lkml@antheas.dev>
>> + */
>> +
>> +#include <linux/dmi.h>
>> +#include <linux/err.h>
>> +#include <linux/init.h>
>> +#include <linux/kernel.h>
>> +#include <linux/module.h>
>> +#include <linux/platform_device.h>
>> +
>> +struct ayaneo_ec_quirk {
>> +};
>> +
>> +struct ayaneo_ec_platform_data {
>> +=C2=A0=C2=A0=C2=A0 struct platform_device *pdev;
>> +=C2=A0=C2=A0=C2=A0 struct ayaneo_ec_quirk *quirks;
>> +};
>> +
>> +static const struct ayaneo_ec_quirk quirk_ayaneo3 =3D {
>> +};
>> +
>> +static const struct dmi_system_id dmi_table[] =3D {
>> +=C2=A0=C2=A0=C2=A0 {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .matches =3D {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 DMI=
_MATCH(DMI_BOARD_VENDOR, "AYANEO"),
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 DMI=
_EXACT_MATCH(DMI_BOARD_NAME, "AYANEO 3"),
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 },
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .driver_data =3D (void *)&q=
uirk_ayaneo3,
>> +=C2=A0=C2=A0=C2=A0 },
>> +=C2=A0=C2=A0=C2=A0 {},
>> +};
>
> MODULE_DEVICE_TABLE() is missing, please add it so that the driver will
> automatically load on supported devices.
>
>> +
>> +static int ayaneo_ec_probe(struct platform_device *pdev)
>> +{
>> +=C2=A0=C2=A0=C2=A0 const struct dmi_system_id *dmi_entry;
>> +=C2=A0=C2=A0=C2=A0 struct ayaneo_ec_platform_data *data;
>> +
>> +=C2=A0=C2=A0=C2=A0 dmi_entry =3D dmi_first_match(dmi_table);
>> +=C2=A0=C2=A0=C2=A0 if (!dmi_entry)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -ENODEV;
>
> Please store the quirk inside a global variable and perform the DMI matc=
h
> inside ayaneo_ec_init. This will allow you to mark the DMI table as=20
> __initconst.
>
> Thanks,
> Armin Wolf
>
>> +
>> +=C2=A0=C2=A0=C2=A0 data =3D devm_kzalloc(&pdev->dev, sizeof(*data), GF=
P_KERNEL);
>> +=C2=A0=C2=A0=C2=A0 if (!data)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -ENOMEM;
>> +
>> +=C2=A0=C2=A0=C2=A0 data->pdev =3D pdev;
>> +=C2=A0=C2=A0=C2=A0 data->quirks =3D dmi_entry->driver_data;
>> +=C2=A0=C2=A0=C2=A0 platform_set_drvdata(pdev, data);
>> +
>> +=C2=A0=C2=A0=C2=A0 return 0;
>> +}
>> +
>> +static struct platform_driver ayaneo_platform_driver =3D {
>> +=C2=A0=C2=A0=C2=A0 .driver =3D {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .name =3D "ayaneo-ec",
>> +=C2=A0=C2=A0=C2=A0 },
>> +=C2=A0=C2=A0=C2=A0 .probe =3D ayaneo_ec_probe,
>> +};
>> +
>> +static struct platform_device *ayaneo_platform_device;
>> +
>> +static int __init ayaneo_ec_init(void)
>> +{
>> +=C2=A0=C2=A0=C2=A0 ayaneo_platform_device =3D
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 platform_create_bundle(&aya=
neo_platform_driver,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ayaneo_ec_=
probe, NULL, 0, NULL, 0);
>> +
>> +=C2=A0=C2=A0=C2=A0 return PTR_ERR_OR_ZERO(ayaneo_platform_device);
>> +}
>> +
>> +static void __exit ayaneo_ec_exit(void)
>> +{
>> +=C2=A0=C2=A0=C2=A0 platform_device_unregister(ayaneo_platform_device);
>> +=C2=A0=C2=A0=C2=A0 platform_driver_unregister(&ayaneo_platform_driver)=
;
>> +}
>> +
>> +MODULE_DEVICE_TABLE(dmi, dmi_table);
>> +
>> +module_init(ayaneo_ec_init);
>> +module_exit(ayaneo_ec_exit);
>> +
>> +MODULE_AUTHOR("Antheas Kapenekakis <lkml@antheas.dev>");
>> +MODULE_DESCRIPTION("Ayaneo Embedded Controller (EC) platform=20
>> features");
>> +MODULE_LICENSE("GPL");
>

