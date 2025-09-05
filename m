Return-Path: <linux-kernel+bounces-803594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 542C5B462CE
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 20:53:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05F411734AA
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 18:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78BE332CF97;
	Fri,  5 Sep 2025 18:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="tS4sjTh3"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B4232CF80;
	Fri,  5 Sep 2025 18:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757098154; cv=none; b=dJJkLon8mETNdF2mEtYP0sp64HphnIk1RqKeud+DpxIhYZVSsG4dPo8yG0qjNsMVV8hNwcrYfRwJ4moVnVwBaBuO2C91LTBLp8zm/mQhd5HXaJHM5/lXg254fvcn+jwdjRsHgv1p1bEtH07AzIW9f4mH5gEO8JoRJlLvkIbRAGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757098154; c=relaxed/simple;
	bh=EIvlTcMSet5hI7aBU2cfGGdEEDH3/l2hHxgdFVrCirw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ypn3N+6B6C5ZVgaQGdwk7XLrIoP18aPHRcFcATugsKZfHmgJXrepNUD/M6FGpB5St6zPd65B4XQSGPLGbTfMDCbAOQ57xzZKOFC7JYWW07TDY8DdRWgy/3c8PV38LexC6LYHlxVDUWGOR8i0TVKx/Q4zDPeXRhN7Z8LeW4Yzdxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=tS4sjTh3; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1757098148; x=1757702948; i=w_armin@gmx.de;
	bh=rAKfsOXmf9XVoMW81HiT+q8lNzDrrFD8zqCfWjJFZKs=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=tS4sjTh35C8Gx6P1NnYsg0OcoxIFwmEemrbBDBU19ESRAVeVcv7Q4C5kqa+jCLXs
	 O6b7WiwX0ealOoqytIhpH8W5E5n1MbhD4xn1hheF7DSzL6BUPN8BiXbKQWNrhRxgC
	 oQorOuLGfg/aEBAgqxaiLAyydAgADDykM9UjIzt9yM2lC2Y/JJFHX/lgMYxcv06bC
	 GtZreyq4UwBdkhRF0rWH55oV0GBVO6w8CJSCZO/s2xrHo0VTlPev+h98N3HNattAK
	 NA4DUuMF80ZE+ywP7Acqhxu1LHyrRU1XOltn4kfeUONGBMQ9bspCtCpCh9yQSWtKv
	 tTWbJQwm4PmeF0yH5A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [10.84.88.1] ([176.1.12.67]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M9Fjb-1uqTAJ0O75-001Yyr; Fri, 05
 Sep 2025 20:49:08 +0200
Message-ID: <d59d64b4-653c-4a78-9c6f-47fbe40555b4@gmx.de>
Date: Fri, 5 Sep 2025 20:49:02 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/5] platform/x86: ayaneo-ec: Add hwmon support
To: Antheas Kapenekakis <lkml@antheas.dev>
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hwmon@vger.kernel.org, Hans de Goede <hansg@kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Derek John Clark <derekjohn.clark@gmail.com>,
 =?UTF-8?Q?Joaqu=C3=ADn_Ignacio_Aramend=C3=ADa?= <samsagax@gmail.com>,
 Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>
References: <20250820160628.99678-1-lkml@antheas.dev>
 <20250820160628.99678-3-lkml@antheas.dev>
 <44404f92-fd30-400c-9f80-64c5649d9849@gmx.de>
 <CAGwozwEV6QVqZKVfO++W0v0g7w9rWE2Joup=w9vPibP=hAzx4A@mail.gmail.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <CAGwozwEV6QVqZKVfO++W0v0g7w9rWE2Joup=w9vPibP=hAzx4A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:fy69JJMojZTj2eVmbYWIg0d53pStV5um89iKrbGIdPR3WInfeIJ
 +CpAr1itJ8OeqbIi05Q+2s3MkR+Xq8R4VOn3bsH89jhkg5+mpO0R2Zw+N+zH66MhuHOlVlo
 PYwDB2WVl1F3K8nlKQ+wYclrnHUk+YhFiitUa3qhHC6AIoAjsprkKIR6QLnb8og3zt3fL5a
 cQ0OrQygZK0eu9ete+RZw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:kItZdS7ksd8=;A6QwT71EY+EMgmiUmlXC9+KtXSJ
 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

Am 22.08.25 um 22:56 schrieb Antheas Kapenekakis:

> On Fri, 22 Aug 2025 at 14:35, Armin Wolf <W_Armin@gmx.de> wrote:
>> Am 20.08.25 um 18:06 schrieb Antheas Kapenekakis:
>>
>>> Add hwmon single fan sensor reads and control for Ayaneo devices.
>>> The register and method of access is the same for all devices.
>>>
>>> Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
>>> ---
>>>    drivers/platform/x86/Kconfig     |   2 +
>>>    drivers/platform/x86/ayaneo-ec.c | 132 +++++++++++++++++++++++++++++++
>>>    2 files changed, 134 insertions(+)
>>>
>>> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
>>> index 6d4a33791cc1..0a7ca2c78456 100644
>>> --- a/drivers/platform/x86/Kconfig
>>> +++ b/drivers/platform/x86/Kconfig
>>> @@ -307,6 +307,8 @@ config ASUS_TF103C_DOCK
>>>    config AYANEO_EC
>>>        tristate "Ayaneo EC platform control"
>>>        depends on X86
>>> +     depends on ACPI_EC
>>> +     depends on HWMON
>>>        help
>>>          Enables support for the platform EC of Ayaneo devices. This
>>>          includes fan control, fan speed, charge limit, magic
>>> diff --git a/drivers/platform/x86/ayaneo-ec.c b/drivers/platform/x86/ayaneo-ec.c
>>> index 90b86527ab0d..8b1902706b81 100644
>>> --- a/drivers/platform/x86/ayaneo-ec.c
>>> +++ b/drivers/platform/x86/ayaneo-ec.c
>>> @@ -7,13 +7,23 @@
>>>     * Copyright (C) 2025 Antheas Kapenekakis <lkml@antheas.dev>
>>>     */
>>>
>>> +#include <linux/acpi.h>
>>>    #include <linux/dmi.h>
>>> +#include <linux/hwmon.h>
>>>    #include <linux/init.h>
>>>    #include <linux/kernel.h>
>>>    #include <linux/module.h>
>>>    #include <linux/platform_device.h>
>>>
>>> +#define AYANEO_PWM_ENABLE_REG         0x4A
>>> +#define AYANEO_PWM_REG                0x4B
>>> +#define AYANEO_PWM_MODE_AUTO  0x00
>>> +#define AYANEO_PWM_MODE_MANUAL        0x01
>>> +
>>> +#define AYANEO_FAN_REG                0x76
>>> +
>>>    struct ayaneo_ec_quirk {
>>> +     bool has_fan_control;
>>>    };
>>>
>>>    struct ayaneo_ec_platform_data {
>>> @@ -22,6 +32,7 @@ struct ayaneo_ec_platform_data {
>>>    };
>>>
>>>    static const struct ayaneo_ec_quirk ayaneo3 = {
>>> +     .has_fan_control = true,
>>>    };
>>>
>>>    static const struct dmi_system_id dmi_table[] = {
>>> @@ -35,10 +46,124 @@ static const struct dmi_system_id dmi_table[] = {
>>>        {},
>>>    };
>>>
>>> +/* Callbacks for hwmon interface */
>>> +static umode_t ayaneo_ec_hwmon_is_visible(const void *drvdata,
>>> +                                    enum hwmon_sensor_types type, u32 attr,
>>> +                                    int channel)
>>> +{
>>> +     switch (type) {
>>> +     case hwmon_fan:
>>> +             return 0444;
>>> +     case hwmon_pwm:
>>> +             return 0644;
>>> +     default:
>>> +             return 0;
>>> +     }
>>> +}
>>> +
>>> +static int ayaneo_ec_read(struct device *dev, enum hwmon_sensor_types type,
>>> +                          u32 attr, int channel, long *val)
>>> +{
>>> +     u8 tmp;
>>> +     int ret;
>>> +
>>> +     switch (type) {
>>> +     case hwmon_fan:
>>> +             switch (attr) {
>>> +             case hwmon_fan_input:
>>> +                     ret = ec_read(AYANEO_FAN_REG, &tmp);
>>> +                     if (ret)
>>> +                             return ret;
>>> +                     *val = tmp << 8;
>>> +                     ret = ec_read(AYANEO_FAN_REG + 1, &tmp);
>>> +                     if (ret)
>>> +                             return ret;
>>> +                     *val += tmp;
>>> +                     return 0;
>>> +             default:
>>> +                     break;
>>> +             }
>>> +             break;
>>> +     case hwmon_pwm:
>>> +             switch (attr) {
>>> +             case hwmon_pwm_input:
>>> +                     ret = ec_read(AYANEO_PWM_REG, &tmp);
>>> +                     if (ret)
>>> +                             return ret;
>>> +                     *val = (255 * tmp) / 100;
>>> +                     if (*val < 0 || *val > 255)
>>> +                             return -EINVAL;
>>> +                     return 0;
>>> +             case hwmon_pwm_enable:
>>> +                     ret = ec_read(AYANEO_PWM_ENABLE_REG, &tmp);
>>> +                     if (ret)
>>> +                             return ret;
>>> +                     if (tmp == AYANEO_PWM_MODE_MANUAL)
>>> +                             *val = 1;
>>> +                     else
>>> +                             *val = 2;
>>> +                     return 0;
>>> +             default:
>>> +                     break;
>>> +             }
>>> +             break;
>>> +     default:
>>> +             break;
>>> +     }
>>> +     return -EOPNOTSUPP;
>>> +}
>>> +
>>> +static int ayaneo_ec_write(struct device *dev, enum hwmon_sensor_types type,
>>> +                           u32 attr, int channel, long val)
>>> +{
>>> +     switch (type) {
>>> +     case hwmon_pwm:
>>> +             switch (attr) {
>>> +             case hwmon_pwm_enable:
>>> +                     if (val == 1)
>>> +                             return ec_write(AYANEO_PWM_ENABLE_REG,
>>> +                                             AYANEO_PWM_MODE_MANUAL);
>>> +                     else if (val == 2)
>>> +                             return ec_write(AYANEO_PWM_ENABLE_REG,
>>> +                                             AYANEO_PWM_MODE_AUTO);
>>> +                     else
>>> +                             return -EINVAL;
>> Consider using a switch statement here.
>>
>>> +             case hwmon_pwm_input:
>>> +                     if (val < 0 || val > 255)
>>> +                             return -EINVAL;
>>> +                     return ec_write(AYANEO_PWM_REG, (val * 100) / 255);
>> Better use fixp_linear_interpolate() for that. Also you need to restore those registers
>> after suspend. I suggest that you use regmap for that.
> The registers appear to maintain their state after sleep. If I get a
> report that some devices do not, I will amend the driver with a
> suspend hook.

Even during hibernation?

Thanks,
Armin Wolf

>
> ack on the interpolate.
>
> Antheas
>
>> Thanks,
>> Armin Wolf
>>
>>> +             default:
>>> +                     break;
>>> +             }
>>> +             break;
>>> +     default:
>>> +             break;
>>> +     }
>>> +     return -EOPNOTSUPP;
>>> +}
>>> +
>>> +static const struct hwmon_ops ayaneo_ec_hwmon_ops = {
>>> +     .is_visible = ayaneo_ec_hwmon_is_visible,
>>> +     .read = ayaneo_ec_read,
>>> +     .write = ayaneo_ec_write,
>>> +};
>>> +
>>> +static const struct hwmon_channel_info *const ayaneo_ec_sensors[] = {
>>> +     HWMON_CHANNEL_INFO(fan, HWMON_F_INPUT),
>>> +     HWMON_CHANNEL_INFO(pwm, HWMON_PWM_INPUT | HWMON_PWM_ENABLE),
>>> +     NULL,
>>> +};
>>> +
>>> +static const struct hwmon_chip_info ayaneo_ec_chip_info = {
>>> +     .ops = &ayaneo_ec_hwmon_ops,
>>> +     .info = ayaneo_ec_sensors,
>>> +};
>>> +
>>>    static int ayaneo_ec_probe(struct platform_device *pdev)
>>>    {
>>>        const struct dmi_system_id *dmi_entry;
>>>        struct ayaneo_ec_platform_data *data;
>>> +     struct device *hwdev;
>>>
>>>        dmi_entry = dmi_first_match(dmi_table);
>>>        if (!dmi_entry)
>>> @@ -52,6 +177,13 @@ static int ayaneo_ec_probe(struct platform_device *pdev)
>>>        data->quirks = dmi_entry->driver_data;
>>>        platform_set_drvdata(pdev, data);
>>>
>>> +     if (data->quirks->has_fan_control) {
>>> +             hwdev = devm_hwmon_device_register_with_info(
>>> +                     &pdev->dev, "ayaneo_ec", NULL, &ayaneo_ec_chip_info, NULL);
>>> +             if (IS_ERR(hwdev))
>>> +                     return PTR_ERR(hwdev);
>>> +     }
>>> +
>>>        return 0;
>>>    }
>>>

