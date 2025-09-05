Return-Path: <linux-kernel+bounces-803606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F749B462EA
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 20:56:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3287CA04601
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 18:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03E89315D37;
	Fri,  5 Sep 2025 18:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="lQrNf4u2"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 078EE315D23;
	Fri,  5 Sep 2025 18:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757098490; cv=none; b=PhthHJ/bwjhDtnVLNhm8E2D+BASog5iaoSiCtlBPJHqs/J5tHoXSloq8SqDUkHGyyqmzBfvWfnDoz0pQHnV216QwbBwA1lVR47OZMUdJBcp6V1c4WZsnoMB5dXnDV2nAublYd2bh8q2OeqGrbkSxuooBCHw7H/c3N9XX2pnaT8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757098490; c=relaxed/simple;
	bh=XSPApHUAmSv+kcqZuhXlvwHQ+Ki+3uW78Qo5H7cOcUs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZBShqcV4yDdB3I3DmWVWPJ9QGKj7KdjopkS+wWDvZTVt/5t147Po6uPCgJe4uFzeAfdF4iqnzpFupThUaFyMqnF9tttksynxAO3+WlsJRoXnYjfgA07ftN7cK6XajZmDcDr7gZVHQQ8ffm5Oj9q2KRIWCPvSDOEvp2Q81QZQgvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=lQrNf4u2; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1757098462; x=1757703262; i=w_armin@gmx.de;
	bh=/j9AXpi74cFeqDy0kfzeKMDqPqZ0OGcNmpESi4lFIWg=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=lQrNf4u2IzVuwOTydg1XLch7XY+eJGNnTVK9Lkl7yBVi885lgst0bovE+7fH07lQ
	 tIMkMmMBLg4CkhDj6OZ62P37gp7eMbtoG+W5m7tLK8oAho0P6MTLlg5xmqcT3z9q6
	 bf3w091SlPku+y3jf7j/JstCTtpy/2sk8Q81Ntz9SH6s9ot/BSGf6r449Pwk5stlp
	 p/gbP1wPby3n3Iw/0PYxv01mNcfm2sq4YWiKkjfTV1gNEJmTSut4a3ucm7bKY+See
	 2f5IHtWrwENWhB3s7st+XZ8gP1Z+FV7LntY0OENL2+LdZmw4eHsjir/F/Aa2gq1F+
	 jsqwkm8vm8R2A1g53g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [10.84.88.1] ([176.1.12.67]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mlf0U-1uCA9f2QHi-00jSl9; Fri, 05
 Sep 2025 20:54:21 +0200
Message-ID: <9cc4868f-98c3-4f5a-a252-a9d00bdc8d87@gmx.de>
Date: Fri, 5 Sep 2025 20:54:16 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/5] platform/x86: ayaneo-ec: Add charge control
 support
To: Antheas Kapenekakis <lkml@antheas.dev>
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hwmon@vger.kernel.org, Hans de Goede <hansg@kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Derek John Clark <derekjohn.clark@gmail.com>,
 =?UTF-8?Q?Joaqu=C3=ADn_Ignacio_Aramend=C3=ADa?= <samsagax@gmail.com>,
 Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>
References: <20250820160628.99678-1-lkml@antheas.dev>
 <20250820160628.99678-4-lkml@antheas.dev>
 <bb62de69-4bf6-480c-8385-c5e69887563f@gmx.de>
 <CAGwozwFsuo3tKTUe-Z0deW7XD5RC28UBS8uPuRGg5Qor6sc-Fg@mail.gmail.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <CAGwozwFsuo3tKTUe-Z0deW7XD5RC28UBS8uPuRGg5Qor6sc-Fg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:r8x4V06HQs9TA1Z+33iznBKTNEhjEhyNkImzUuM8gVQKRKyBAVc
 MmnrE4/WerRVqJ54muObCgg5nhvx4ZsxtwgVW+rQUPYi2dr9oVKdEd5Eeh69xn+sIWfSEeP
 zgDxGhXSQoRT4MleE1nkdJt7TvfZeym5bGl486dg29yzpN6d2cP23bPJ+bQN5f4/3qKXG7N
 3LpLHdz42OcF1UiGoQHWQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:hGujhTKlLtA=;Oznyf8t8cu5TgEdrBa0JNNVBEZD
 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
 culfB94zZo

Am 22.08.25 um 23:04 schrieb Antheas Kapenekakis:

> On Fri, 22 Aug 2025 at 14:38, Armin Wolf <W_Armin@gmx.de> wrote:
>> Am 20.08.25 um 18:06 schrieb Antheas Kapenekakis:
>>
>>> Ayaneo devices support charge inhibition via the EC. This inhibition
>>> only works while the device is powered on, and resets between restarts.
>>> However, it is maintained across suspend/resume cycles.
>> Does this include hibernation?
> No. S4/S5 reset the state. Can you give a reference for a regmap
> implementation? A hibernation hook would be a nice to have. Although I
> am not sure how I feel about restoring the fan speed after
> hibernation. It seems dangerous.

Take a look at this patch series: https://lore.kernel.org/platform-driver-x86/20250803210157.8185-1-W_Armin@gmx.de

Restoring the fan speed after hibernation should be OK as long as you also restore the other fan control settings.
This should be safe as long as you can test the driver on real hardware.

Thanks,
Armin Wolf

>> Thanks,
>> Armin Wolf
>>
>>> The EC does not support charge threshold control. Instead, userspace
>>> software on Windows manually toggles charge inhibition depending on
>>> battery level.
>>>
>>> Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
>>> ---
>>>    drivers/platform/x86/Kconfig     |   1 +
>>>    drivers/platform/x86/ayaneo-ec.c | 111 +++++++++++++++++++++++++++++++
>>>    2 files changed, 112 insertions(+)
>>>
>>> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
>>> index 0a7ca2c78456..c871a722e5ef 100644
>>> --- a/drivers/platform/x86/Kconfig
>>> +++ b/drivers/platform/x86/Kconfig
>>> @@ -308,6 +308,7 @@ config AYANEO_EC
>>>        tristate "Ayaneo EC platform control"
>>>        depends on X86
>>>        depends on ACPI_EC
>>> +     depends on ACPI_BATTERY
>>>        depends on HWMON
>>>        help
>>>          Enables support for the platform EC of Ayaneo devices. This
>>> diff --git a/drivers/platform/x86/ayaneo-ec.c b/drivers/platform/x86/ayaneo-ec.c
>>> index 8b1902706b81..a4bdc6ae7af7 100644
>>> --- a/drivers/platform/x86/ayaneo-ec.c
>>> +++ b/drivers/platform/x86/ayaneo-ec.c
>>> @@ -14,6 +14,7 @@
>>>    #include <linux/kernel.h>
>>>    #include <linux/module.h>
>>>    #include <linux/platform_device.h>
>>> +#include <acpi/battery.h>
>>>
>>>    #define AYANEO_PWM_ENABLE_REG        0x4A
>>>    #define AYANEO_PWM_REG               0x4B
>>> @@ -22,17 +23,27 @@
>>>
>>>    #define AYANEO_FAN_REG               0x76
>>>
>>> +#define EC_CHARGE_CONTROL_BEHAVIOURS                         \
>>> +     (BIT(POWER_SUPPLY_CHARGE_BEHAVIOUR_AUTO) |           \
>>> +      BIT(POWER_SUPPLY_CHARGE_BEHAVIOUR_INHIBIT_CHARGE))
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
>>>    static const struct ayaneo_ec_quirk ayaneo3 = {
>>>        .has_fan_control = true,
>>> +     .has_charge_control = true,
>>>    };
>>>
>>>    static const struct dmi_system_id dmi_table[] = {
>>> @@ -159,11 +170,102 @@ static const struct hwmon_chip_info ayaneo_ec_chip_info = {
>>>        .info = ayaneo_ec_sensors,
>>>    };
>>>
>>> +static int ayaneo_psy_ext_get_prop(struct power_supply *psy,
>>> +                             const struct power_supply_ext *ext,
>>> +                             void *data,
>>> +                             enum power_supply_property psp,
>>> +                             union power_supply_propval *val)
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
>>> +                             const struct power_supply_ext *ext,
>>> +                             void *data,
>>> +                             enum power_supply_property psp,
>>> +                             const union power_supply_propval *val)
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
>>> +                                  const struct power_supply_ext *ext,
>>> +                                  void *data,
>>> +                                  enum power_supply_property psp)
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
>>> +                        struct acpi_battery_hook *hook)
>>> +{
>>> +     struct ayaneo_ec_platform_data *data =
>>> +             container_of(hook, struct ayaneo_ec_platform_data, battery_hook);
>>> +
>>> +     return power_supply_register_extension(battery, &ayaneo_psy_ext,
>>> +                                            &data->pdev->dev, NULL);
>>> +}
>>> +
>>> +static int ayaneo_remove_battery(struct power_supply *battery,
>>> +                           struct acpi_battery_hook *hook)
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
>>> @@ -184,6 +286,15 @@ static int ayaneo_ec_probe(struct platform_device *pdev)
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

