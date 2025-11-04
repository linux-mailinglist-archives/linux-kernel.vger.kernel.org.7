Return-Path: <linux-kernel+bounces-885421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5846BC32D8E
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 20:59:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F1DAA4E45B8
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 19:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF9B22DF3F9;
	Tue,  4 Nov 2025 19:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="JrqfbTE7"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4103C22127A;
	Tue,  4 Nov 2025 19:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762286350; cv=none; b=QvF1ieH2DfQR5XM0SMjzunyzdJYK+xbAxoAFNRzbaFC9yO40YNonmWdSMVT8YfONY/njNQqPq6J383MZjg4ky0t4yy707aGq6YOM89s1msLb7iEqQPw2ljUfaW6Meo/spqwfinl6+SZ8nY3S4pRK+5n8Wym3IZetAQGsNK8O8x8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762286350; c=relaxed/simple;
	bh=h449hPcvusMTJuNpm8DRpDhGBlevUGsMmnejSr0lCkk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KhFKb4GXsrst+arfl3WZ8xe7GS6cK59zQDpxyzh7FVc3GraIgRdEFxphp3E5nYBuc+z6I72fnqaoNcb9fS5TQP+bMjhDc/6QwQVTQVjes1zgPD534ACH82l/qvlJHeC0s+XeXrLuuvfRX9U+nr2SoKO7c+w7BzpZ/6rVP2ipGpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=JrqfbTE7; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1762286335; x=1762891135; i=w_armin@gmx.de;
	bh=8Uyi2b/dNyZwTVbbGBkr0qNRSD8LJ2GnoF2cQOJmrrs=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=JrqfbTE7BaHOrVB4ok9jP9cH6Uw6g1Y5Csz/TKaH/phTYU7UONSgikGUT3GwDMGA
	 WaPkJgVEvQzF6bMtZgnZdQGEad1d6c6klnxN/Poe+dfY9DdrqWuHTon6Vz+uzzex0
	 glILg1gb846wnYtSpjbVVoErV1j3UU/NweYCDqntN5HKrJNWapld/S0VP4i+nwgWj
	 bRwPRIkh3X61o5x4bJNYqLtDtK9xSXGrqvL0EGYrtQinkgGDzAmtPeknqzJg5wf0c
	 vIME+PcKVDByJQEy00tvWlNeRck1e7Xao3ec0CXSzoynhtZpvfWn2KquxTh2b3xv6
	 ldmfz/7DuRUe3RhTEQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.69] ([93.202.247.91]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MeU0q-1vqoOJ0muq-00ipwF; Tue, 04
 Nov 2025 20:58:55 +0100
Message-ID: <6a8fc9ae-5ce6-4583-9b44-b9021f8f8dba@gmx.de>
Date: Tue, 4 Nov 2025 20:58:51 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/6] platform/x86: ayaneo-ec: Add Ayaneo Embedded
 Controller platform driver
To: Antheas Kapenekakis <lkml@antheas.dev>
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hwmon@vger.kernel.org, Hans de Goede <hansg@kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Derek John Clark <derekjohn.clark@gmail.com>,
 =?UTF-8?Q?Joaqu=C3=ADn_Ignacio_Aramend=C3=ADa?= <samsagax@gmail.com>,
 Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>
References: <20251031163651.1465981-1-lkml@antheas.dev>
 <20251031163651.1465981-2-lkml@antheas.dev>
 <eb7a2631-eed0-4a91-81ff-a2efcb70ad29@gmx.de>
 <CAGwozwGO=sZjGro7NaKH=zC4x_GR8H7kaPSn8NP60H7EZ4s3+g@mail.gmail.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <CAGwozwGO=sZjGro7NaKH=zC4x_GR8H7kaPSn8NP60H7EZ4s3+g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:3m150iW3Pt0t6OfWLV9ZSq0XGQ48mPztr24bT4dIlk46fthHyu7
 iwreCoghT6M6nNb67rKpdiE52k+2nzU4M2aKHudRanbV1EADYL00sq7KRsVhdU0lxYCNlUR
 SnTIki9/Ez3QRcvBqwgM4yOrAgRqqmIkGpxuX9DHobUpXsuzb5b+ZMNMlk0gDnChJyXXHXi
 FTzJKWRx7bJGbEN4o0kDw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:CFB+R+BXgGg=;gRvMxepM/BmUHj1SgmXpUm2MYI+
 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
 B7gKlutna4KGYvOKY=

Am 02.11.25 um 19:37 schrieb Antheas Kapenekakis:

> On Sun, 2 Nov 2025 at 19:21, Armin Wolf <W_Armin@gmx.de> wrote:
>> Am 31.10.25 um 17:36 schrieb Antheas Kapenekakis:
>>
>>> Recent Ayaneo devices feature an ACPI mapped Embedded Controller (EC)
>>> with standard addresses across models that provides access to fan
>>> speed, fan control, battery charge limits, and controller power
>>> controls. Introduce a new driver stub that will handle these driver
>>> features.
>>>
>>> Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
>>> ---
>>>    MAINTAINERS                      |  6 +++
>>>    drivers/platform/x86/Kconfig     |  9 ++++
>>>    drivers/platform/x86/Makefile    |  3 ++
>>>    drivers/platform/x86/ayaneo-ec.c | 90 ++++++++++++++++++++++++++++++++
>>>    4 files changed, 108 insertions(+)
>>>    create mode 100644 drivers/platform/x86/ayaneo-ec.c
>>>
>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>> index 545a4776795e..da9498d8cc89 100644
>>> --- a/MAINTAINERS
>>> +++ b/MAINTAINERS
>>> @@ -4187,6 +4187,12 @@ W:     https://ez.analog.com/linux-software-drivers
>>>    F:  Documentation/devicetree/bindings/pwm/adi,axi-pwmgen.yaml
>>>    F:  drivers/pwm/pwm-axi-pwmgen.c
>>>
>>> +AYANEO PLATFORM EC DRIVER
>>> +M:   Antheas Kapenekakis <lkml@antheas.dev>
>>> +L:   platform-driver-x86@vger.kernel.org
>>> +S:   Maintained
>>> +F:   drivers/platform/x86/ayaneo-ec.c
>>> +
>>>    AZ6007 DVB DRIVER
>>>    M:  Mauro Carvalho Chehab <mchehab@kernel.org>
>>>    L:  linux-media@vger.kernel.org
>>> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
>>> index 46e62feeda3c..ebe7d2ab8758 100644
>>> --- a/drivers/platform/x86/Kconfig
>>> +++ b/drivers/platform/x86/Kconfig
>>> @@ -316,6 +316,15 @@ config ASUS_TF103C_DOCK
>>>          If you have an Asus TF103C tablet say Y or M here, for a generic x86
>>>          distro config say M here.
>>>
>>> +config AYANEO_EC
>>> +     tristate "Ayaneo EC platform control"
>>> +     help
>>> +       Enables support for the platform EC of Ayaneo devices. This
>>> +       includes fan control, fan speed, charge limit, magic
>>> +       module detection, and controller power control.
>>> +
>>> +       If you have an Ayaneo device, say Y or M here.
>>> +
>>>    config MERAKI_MX100
>>>        tristate "Cisco Meraki MX100 Platform Driver"
>>>        depends on GPIOLIB
>>> diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
>>> index c7db2a88c11a..274a685eb92d 100644
>>> --- a/drivers/platform/x86/Makefile
>>> +++ b/drivers/platform/x86/Makefile
>>> @@ -39,6 +39,9 @@ obj-$(CONFIG_ASUS_TF103C_DOCK)      += asus-tf103c-dock.o
>>>    obj-$(CONFIG_EEEPC_LAPTOP)  += eeepc-laptop.o
>>>    obj-$(CONFIG_EEEPC_WMI)             += eeepc-wmi.o
>>>
>>> +# Ayaneo
>>> +obj-$(CONFIG_AYANEO_EC)              += ayaneo-ec.o
>>> +
>>>    # Cisco/Meraki
>>>    obj-$(CONFIG_MERAKI_MX100)  += meraki-mx100.o
>>>
>>> diff --git a/drivers/platform/x86/ayaneo-ec.c b/drivers/platform/x86/ayaneo-ec.c
>>> new file mode 100644
>>> index 000000000000..2fe66c8a89f4
>>> --- /dev/null
>>> +++ b/drivers/platform/x86/ayaneo-ec.c
>>> @@ -0,0 +1,90 @@
>>> +// SPDX-License-Identifier: GPL-2.0+
>>> +/*
>>> + * Platform driver for the Embedded Controller (EC) of Ayaneo devices. Handles
>>> + * hwmon (fan speed, fan control), battery charge limits, and magic module
>>> + * control (connected modules, controller disconnection).
>>> + *
>>> + * Copyright (C) 2025 Antheas Kapenekakis <lkml@antheas.dev>
>>> + */
>>> +
>>> +#include <linux/dmi.h>
>>> +#include <linux/err.h>
>>> +#include <linux/init.h>
>>> +#include <linux/kernel.h>
>>> +#include <linux/module.h>
>>> +#include <linux/platform_device.h>
>>> +
>>> +struct ayaneo_ec_quirk {
>>> +};
>>> +
>>> +struct ayaneo_ec_platform_data {
>>> +     struct platform_device *pdev;
>>> +     struct ayaneo_ec_quirk *quirks;
>>> +};
>>> +
>>> +static const struct ayaneo_ec_quirk quirk_ayaneo3 = {
>>> +};
>>> +
>>> +static const struct dmi_system_id dmi_table[] = {
>>> +     {
>>> +             .matches = {
>>> +                     DMI_MATCH(DMI_BOARD_VENDOR, "AYANEO"),
>>> +                     DMI_EXACT_MATCH(DMI_BOARD_NAME, "AYANEO 3"),
>>> +             },
>>> +             .driver_data = (void *)&quirk_ayaneo3,
>>> +     },
>>> +     {},
>>> +};
>> MODULE_DEVICE_TABLE() is missing, please add it so that the driver will
>> automatically load on supported devices.
> It is not. See below.

I see, my bad.

>>> +
>>> +static int ayaneo_ec_probe(struct platform_device *pdev)
>>> +{
>>> +     const struct dmi_system_id *dmi_entry;
>>> +     struct ayaneo_ec_platform_data *data;
>>> +
>>> +     dmi_entry = dmi_first_match(dmi_table);
>>> +     if (!dmi_entry)
>>> +             return -ENODEV;
>> Please store the quirk inside a global variable and perform the DMI match
>> inside ayaneo_ec_init. This will allow you to mark the DMI table as __initconst.
> This driver was designed to not need a global quirk variable, which
> required a lot of additional work (the drvdata structure) . I am not
> re-adding it as a workaround for __initconst.
>
> Adding init to probe emits a warning because there is a dangling
> reference to it.

Ok.

Thanks,
Armin Wolf

>> Thanks,
>> Armin Wolf
>>
>>> +
>>> +     data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
>>> +     if (!data)
>>> +             return -ENOMEM;
>>> +
>>> +     data->pdev = pdev;
>>> +     data->quirks = dmi_entry->driver_data;
>>> +     platform_set_drvdata(pdev, data);
>>> +
>>> +     return 0;
>>> +}
>>> +
>>> +static struct platform_driver ayaneo_platform_driver = {
>>> +     .driver = {
>>> +             .name = "ayaneo-ec",
>>> +     },
>>> +     .probe = ayaneo_ec_probe,
>>> +};
>>> +
>>> +static struct platform_device *ayaneo_platform_device;
>>> +
>>> +static int __init ayaneo_ec_init(void)
>>> +{
>>> +     ayaneo_platform_device =
>>> +             platform_create_bundle(&ayaneo_platform_driver,
>>> +                                    ayaneo_ec_probe, NULL, 0, NULL, 0);
>>> +
>>> +     return PTR_ERR_OR_ZERO(ayaneo_platform_device);
>>> +}
>>> +
>>> +static void __exit ayaneo_ec_exit(void)
>>> +{
>>> +     platform_device_unregister(ayaneo_platform_device);
>>> +     platform_driver_unregister(&ayaneo_platform_driver);
>>> +}
>>> +
>>> +MODULE_DEVICE_TABLE(dmi, dmi_table);
> Here
>
>>> +
>>> +module_init(ayaneo_ec_init);
>>> +module_exit(ayaneo_ec_exit);
>>> +
>>> +MODULE_AUTHOR("Antheas Kapenekakis <lkml@antheas.dev>");
>>> +MODULE_DESCRIPTION("Ayaneo Embedded Controller (EC) platform features");
>>> +MODULE_LICENSE("GPL");

