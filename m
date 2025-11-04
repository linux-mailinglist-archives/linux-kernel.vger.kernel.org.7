Return-Path: <linux-kernel+bounces-885426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 68D44C32DB8
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 21:01:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDD5C18C3C63
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 20:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B70962FC87E;
	Tue,  4 Nov 2025 20:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="cofLyVSY"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08C122E8DFD;
	Tue,  4 Nov 2025 20:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762286415; cv=none; b=bJfVHZFCS55fgNi0yYgsCrmDT7eG3X5Ci4e9+ZcslM7PVWkH4LcGm3a2makmgIWfs/9QXEDiZAV27sgt5Rpi1lWFZQnd57pKhO9HhJ6xTKri7h1ytgm/ujmETPFpsAHSarwQzaAEg0bIpfXDBVQVDJFdv65z+LUNu8dTwahplFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762286415; c=relaxed/simple;
	bh=1+V0rJONJUmwcols7lxouU2Ma97BEOmffU/Kul3++zw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZYRVNLe62ODypvEyZvs1Q0JIvem2he/AA6zHOn0Hj6v7jMZTl3CisyBmpgQJPN1wo5V609NJkvNqrtJEKqD6YEZJRkMtytNsJCur5IobK2Z4alsL2bKtnvn3KtztlHKS6rMljI+nCJPA5vNSFp+HmWMEeufcVZ9DrzrqqTiJRvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=cofLyVSY; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1762286410; x=1762891210; i=w_armin@gmx.de;
	bh=dh9ybfHqekF8Riu2F5xBEI2p35kO5L/0g1XEw9I8FmI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=cofLyVSYMiMLM6ObAxPDgEoveRL8Ur8DDmpj+iidv/IuC5QZS5Lr/bx6H6rIWZay
	 gAfcsufI6RGYxXCgp8SZsFOj+bYOicAoimSQPCT0bIZnEKNMPazobslCdD4iEcAwZ
	 FmqkrRknhap+Xa6/1325r2UdanDlP8XD3i79iOF0feA1e1NUmWDUtrFmeF0gghQdo
	 dv1LxbirXeb/SuYUn3XK2YOoz2wbP1yNATqLKM+rEOoHVPrdDbVIySLE1uA07T0Tf
	 Iyw/gfI1Vcsgu16ej0aEhoM5DN3ByUwSOQmAdh063CMlfZzSyXn+ITeDMv/Kjs5M3
	 3lN2tbWNjyfF9pJq8A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.69] ([93.202.247.91]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MCbIx-1vOveb0exv-001HfX; Tue, 04
 Nov 2025 21:00:10 +0100
Message-ID: <d719d78f-5466-4d3f-a43c-dfd4c2c0190a@gmx.de>
Date: Tue, 4 Nov 2025 21:00:07 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/6] platform/x86: ayaneo-ec: Add charge control
 support
To: Antheas Kapenekakis <lkml@antheas.dev>
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hwmon@vger.kernel.org, Hans de Goede <hansg@kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Derek John Clark <derekjohn.clark@gmail.com>,
 =?UTF-8?Q?Joaqu=C3=ADn_Ignacio_Aramend=C3=ADa?= <samsagax@gmail.com>,
 Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>
References: <20251031163651.1465981-1-lkml@antheas.dev>
 <20251031163651.1465981-4-lkml@antheas.dev>
 <b075b605-4cdd-4fbf-aa1a-78f7f34a1c50@gmx.de>
 <CAGwozwHfaeOnMmLbAK03gzG2JCsZ=TDAv3EMyDoBZRtG=ix5ng@mail.gmail.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <CAGwozwHfaeOnMmLbAK03gzG2JCsZ=TDAv3EMyDoBZRtG=ix5ng@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:lkbJmd/TLHgcZQZptURbZJ8lmkmXrTazGeV0ju0MfN37xgpQcbo
 9wJqdMxjib+Ahz2a4CDDmj0RsLTuE1ch6Yhfao1evt5t0g6W1+eGFEGXynUpCxRdhNWEZXc
 nccY2rSdxNb4hsMxDH5VsG+yZ2uV8Lt4wmizh7M7VOb84VfUzkAns69mwmDx0YMNLaJ9eED
 nOCmPsUKGydLo3yCfzN5A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:1WRFUav14m4=;sUB+8xV+xK7NvXl/UVDbZv0CqUh
 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
 14aCkDCB1aT6AxR1s=

Am 02.11.25 um 19:37 schrieb Antheas Kapenekakis:

> On Sun, 2 Nov 2025 at 19:26, Armin Wolf <W_Armin@gmx.de> wrote:
>> Am 31.10.25 um 17:36 schrieb Antheas Kapenekakis:
>>
>>> Ayaneo devices support charge inhibition via the EC. This inhibition
>>> only works while the device is powered on, and resets between restarts.
>>> However, it is maintained across suspend/resume cycles.
>>>
>>> The EC does not support charge threshold control. Instead, userspace
>>> software on Windows manually toggles charge inhibition depending on
>>> battery level.
>>>
>>> Reviewed-by: Armin Wolf <W_Armin@gmx.de>
>>> Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
>>> ---
>>>    drivers/platform/x86/Kconfig     |   1 +
>>>    drivers/platform/x86/ayaneo-ec.c | 112 +++++++++++++++++++++++++++++++
>>>    2 files changed, 113 insertions(+)
>>>
>>> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
>>> index b3beaff4b03a..a45449ae83f8 100644
>>> --- a/drivers/platform/x86/Kconfig
>>> +++ b/drivers/platform/x86/Kconfig
>>> @@ -319,6 +319,7 @@ config ASUS_TF103C_DOCK
>>>    config AYANEO_EC
>>>        tristate "Ayaneo EC platform control"
>>>        depends on ACPI_EC
>>> +     depends on ACPI_BATTERY
>>>        depends on HWMON
>>>        help
>>>          Enables support for the platform EC of Ayaneo devices. This
>>> diff --git a/drivers/platform/x86/ayaneo-ec.c b/drivers/platform/x86/ayaneo-ec.c
>>> index 108a23458a4f..697bb053a7d6 100644
>>> --- a/drivers/platform/x86/ayaneo-ec.c
>>> +++ b/drivers/platform/x86/ayaneo-ec.c
>>> @@ -15,6 +15,8 @@
>>>    #include <linux/kernel.h>
>>>    #include <linux/module.h>
>>>    #include <linux/platform_device.h>
>>> +#include <linux/power_supply.h>
>>> +#include <acpi/battery.h>
>>>
>>>    #define AYANEO_PWM_ENABLE_REG        0x4A
>>>    #define AYANEO_PWM_REG               0x4B
>>> @@ -23,17 +25,27 @@
>>>
>>>    #define AYANEO_FAN_REG               0x76
>>>
>>> +#define EC_CHARGE_CONTROL_BEHAVIOURS                         \
>>> +     (BIT(POWER_SUPPLY_CHARGE_BEHAVIOUR_AUTO) |           \
>>> +      BIT(POWER_SUPPLY_CHARGE_BEHAVIOUR_INHIBIT_CHARGE))
>> I think POWER_SUPPLY_CHARGE_BEHAVIOUR_INHIBIT_CHARGE_AWAKE would be more suitable here.
> Charge inhibition works during sleep.

I must have suffered from a misunderstanding then. In this case:

Reviewed-by: Armin Wolf <W_Armin@gmx.de>

>> Other than that:
>> Reviewed-by: Armin Wolf <W_Armin@gmx.de>
>>
>>> +#define AYANEO_CHARGE_REG            0x1e
>>> +#define AYANEO_CHARGE_VAL_AUTO               0xaa
>>> +#define AYANEO_CHARGE_VAL_INHIBIT    0x55
>>> +
>>>    struct ayaneo_ec_quirk {
>>>        bool has_fan_control;
>>> +     bool has_charge_control;
>>>    };
>>>
>>>    struct ayaneo_ec_platform_data {
>>>        struct platform_device *pdev;
>>>        struct ayaneo_ec_quirk *quirks;
>>> +     struct acpi_battery_hook battery_hook;
>>>    };
>>>
>>>    static const struct ayaneo_ec_quirk quirk_ayaneo3 = {
>>>        .has_fan_control = true,
>>> +     .has_charge_control = true,
>>>    };
>>>
>>>    static const struct dmi_system_id dmi_table[] = {
>>> @@ -164,11 +176,102 @@ static const struct hwmon_chip_info ayaneo_ec_chip_info = {
>>>        .info = ayaneo_ec_sensors,
>>>    };
>>>
>>> +static int ayaneo_psy_ext_get_prop(struct power_supply *psy,
>>> +                                const struct power_supply_ext *ext,
>>> +                                void *data,
>>> +                                enum power_supply_property psp,
>>> +                                union power_supply_propval *val)
>>> +{
>>> +     int ret;
>>> +     u8 tmp;
>>> +
>>> +     switch (psp) {
>>> +     case POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR:
>>> +             ret = ec_read(AYANEO_CHARGE_REG, &tmp);
>>> +             if (ret)
>>> +                     return ret;
>>> +
>>> +             if (tmp == AYANEO_CHARGE_VAL_INHIBIT)
>>> +                     val->intval = POWER_SUPPLY_CHARGE_BEHAVIOUR_INHIBIT_CHARGE;
>>> +             else
>>> +                     val->intval = POWER_SUPPLY_CHARGE_BEHAVIOUR_AUTO;
>>> +             return 0;
>>> +     default:
>>> +             return -EINVAL;
>>> +     }
>>> +}
>>> +
>>> +static int ayaneo_psy_ext_set_prop(struct power_supply *psy,
>>> +                                const struct power_supply_ext *ext,
>>> +                                void *data,
>>> +                                enum power_supply_property psp,
>>> +                                const union power_supply_propval *val)
>>> +{
>>> +     u8 raw_val;
>>> +
>>> +     switch (psp) {
>>> +     case POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR:
>>> +             switch (val->intval) {
>>> +             case POWER_SUPPLY_CHARGE_BEHAVIOUR_AUTO:
>>> +                     raw_val = AYANEO_CHARGE_VAL_AUTO;
>>> +                     break;
>>> +             case POWER_SUPPLY_CHARGE_BEHAVIOUR_INHIBIT_CHARGE:
>>> +                     raw_val = AYANEO_CHARGE_VAL_INHIBIT;
>>> +                     break;
>>> +             default:
>>> +                     return -EINVAL;
>>> +             }
>>> +             return ec_write(AYANEO_CHARGE_REG, raw_val);
>>> +     default:
>>> +             return -EINVAL;
>>> +     }
>>> +}
>>> +
>>> +static int ayaneo_psy_prop_is_writeable(struct power_supply *psy,
>>> +                                     const struct power_supply_ext *ext,
>>> +                                     void *data,
>>> +                                     enum power_supply_property psp)
>>> +{
>>> +     return true;
>>> +}
>>> +
>>> +static const enum power_supply_property ayaneo_psy_ext_props[] = {
>>> +     POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR,
>>> +};
>>> +
>>> +static const struct power_supply_ext ayaneo_psy_ext = {
>>> +     .name                   = "ayaneo-charge-control",
>>> +     .properties             = ayaneo_psy_ext_props,
>>> +     .num_properties         = ARRAY_SIZE(ayaneo_psy_ext_props),
>>> +     .charge_behaviours      = EC_CHARGE_CONTROL_BEHAVIOURS,
>>> +     .get_property           = ayaneo_psy_ext_get_prop,
>>> +     .set_property           = ayaneo_psy_ext_set_prop,
>>> +     .property_is_writeable  = ayaneo_psy_prop_is_writeable,
>>> +};
>>> +
>>> +static int ayaneo_add_battery(struct power_supply *battery,
>>> +                           struct acpi_battery_hook *hook)
>>> +{
>>> +     struct ayaneo_ec_platform_data *data =
>>> +             container_of(hook, struct ayaneo_ec_platform_data, battery_hook);
>>> +
>>> +     return power_supply_register_extension(battery, &ayaneo_psy_ext,
>>> +                                            &data->pdev->dev, NULL);
>>> +}
>>> +
>>> +static int ayaneo_remove_battery(struct power_supply *battery,
>>> +                              struct acpi_battery_hook *hook)
>>> +{
>>> +     power_supply_unregister_extension(battery, &ayaneo_psy_ext);
>>> +     return 0;
>>> +}
>>> +
>>>    static int ayaneo_ec_probe(struct platform_device *pdev)
>>>    {
>>>        const struct dmi_system_id *dmi_entry;
>>>        struct ayaneo_ec_platform_data *data;
>>>        struct device *hwdev;
>>> +     int ret;
>>>
>>>        dmi_entry = dmi_first_match(dmi_table);
>>>        if (!dmi_entry)
>>> @@ -189,6 +292,15 @@ static int ayaneo_ec_probe(struct platform_device *pdev)
>>>                        return PTR_ERR(hwdev);
>>>        }
>>>
>>> +     if (data->quirks->has_charge_control) {
>>> +             data->battery_hook.add_battery = ayaneo_add_battery;
>>> +             data->battery_hook.remove_battery = ayaneo_remove_battery;
>>> +             data->battery_hook.name = "Ayaneo Battery";
>>> +             ret = devm_battery_hook_register(&pdev->dev, &data->battery_hook);
>>> +             if (ret)
>>> +                     return ret;
>>> +     }
>>> +
>>>        return 0;
>>>    }
>>>

