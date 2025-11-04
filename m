Return-Path: <linux-kernel+bounces-885436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C32CC32E09
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 21:06:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 449AE425BB2
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 20:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8138170809;
	Tue,  4 Nov 2025 20:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="XtfD97Jt"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18AD82EB5CD;
	Tue,  4 Nov 2025 20:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762286622; cv=none; b=meI1TmVsH912NQsqqvLKNQpJx0B0lP0WQ1rtB78lxpzsKkQeNG/E939E84HmdXr/azthA0IppGv95qLOsnF2FkXqbDf9Um67/kIXEO+tLDj9XBsM0/GBhhCcfM8rr//vqwJ+XISWuQkECIovwaHps1Zg2qfW9X6jZpPW6U7wfLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762286622; c=relaxed/simple;
	bh=J1hJB6KTjOXhC0RBOjplOKBb4VvFsnVd+6JotxNhJQ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rWhtFHiI4nEkdTx7RruXg/OgTg/C8uuakkl0ziiviZuQufOvR2DEw1gPLNVdqlMF4BZSS2T3LSs+6NJv3sv2LrSoaP8NjnXDewy8igUe1Tr1fRals+ESnwT+FW5tfjouF85YGGf6q1VPNsPlFXGqambRQCiNa5zj1/81auS2dCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=XtfD97Jt; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1762286614; x=1762891414; i=w_armin@gmx.de;
	bh=IubVs5NxW6XbbvmkklZ1y2CBUf7SecoHug1L1V9zOns=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=XtfD97Jt13Y9Y4ZIenlY4xDth8+iWJu7o7+Ete4drUUM8c3NaOuAc447W4SGbZpU
	 toj7/rLWw8kKgitms1ZGcTmQe034BRXm7RQBplZGCMw53//uLgdAEEhyexSuey/5l
	 8vx3BAzt4BnB7750EIo6TLAC/jdIm0exsCxbu3Ao+fllEAkGMkKijPK3LfoxxLme7
	 Zy1BOhiJRhKwSQbDlO9jX1XL5jNVb4ey2H8EkMXgIjDa5rynZ2hZr6BsP/dAb7Hbk
	 N+7SNgLN5SYM+C7zzJFRjMbPDpRUYWVzkNRATmr2Fun1uanwVns7zeFox/iXg79OM
	 l9evUUnrC41d5QZNIA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.69] ([93.202.247.91]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MyKDU-1wAVfm0BmG-0176SZ; Tue, 04
 Nov 2025 21:03:34 +0100
Message-ID: <e0b29b59-b37d-4c44-ab97-9527b0f959b1@gmx.de>
Date: Tue, 4 Nov 2025 21:03:32 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/6] platform/x86: ayaneo-ec: Add controller power and
 modules attributes
To: Antheas Kapenekakis <lkml@antheas.dev>
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hwmon@vger.kernel.org, Hans de Goede <hansg@kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Derek John Clark <derekjohn.clark@gmail.com>,
 =?UTF-8?Q?Joaqu=C3=ADn_Ignacio_Aramend=C3=ADa?= <samsagax@gmail.com>,
 Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>
References: <20251031163651.1465981-1-lkml@antheas.dev>
 <20251031163651.1465981-5-lkml@antheas.dev>
 <7c521e72-1b32-4172-90ec-6e793941a8ed@gmx.de>
 <CAGwozwFRF11dH02SRRNCyiYW7dNuoYoGWfPdEWPoim2r-KoZ0g@mail.gmail.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <CAGwozwFRF11dH02SRRNCyiYW7dNuoYoGWfPdEWPoim2r-KoZ0g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:5J/xaKqqSjnjOnrYMuX8wiRVr4BhCV/3vPPy3NWlyz5lJf/mDY4
 YV51fduDooLNPcUTmrhb7XzYYfAPz+HamEm2I+KTykZovbaLF2Tqz/fgexH85xlVoKG6Tj3
 7rQ890PLjCjQHzbOGU682TB6oEMV9JzCv0C6MAA1cqVbt5OA023Gbl7XKiBEXEku9Cimt2L
 GxnyhR2S2qqXdSaY/t50A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:mgWZrW90u7k=;60H1nljeNH/CQ7tD87YOdOtel/3
 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
 A0z8vjbg=

Am 02.11.25 um 19:46 schrieb Antheas Kapenekakis:

> On Sun, 2 Nov 2025 at 19:30, Armin Wolf <W_Armin@gmx.de> wrote:
>> Am 31.10.25 um 17:36 schrieb Antheas Kapenekakis:
>>
>>> The Ayaneo 3 features hot-swappable controller modules. The ejection
>>> and management is done through HID. However, after ejecting the modules,
>>> the controller needs to be power cycled via the EC to re-initialize.
>>>
>>> For this, the EC provides a variable that holds whether the left or
>>> right modules are connected, and a power control register to turn
>>> the controller on or off. After ejecting the modules, the controller
>>> should be turned off. Then, after both modules are reinserted,
>>> the controller may be powered on again to re-initialize.
>>>
>>> This patch introduces two new sysfs attributes:
>>>    - `controller_modules`: a read-only attribute that indicates whether
>>>      the left and right modules are connected (none, left, right, both).
>>>    - `controller_power`: a read-write attribute that allows the user
>>>      to turn the controller on or off (with '1'/'0').
>>>
>>> Therefore, after ejection is complete, userspace can power off the
>>> controller, then wait until both modules have been reinserted
>>> (`controller_modules` will return 'both') to turn on the controller.
>>>
>>> Reviewed-by: Armin Wolf <W_Armin@gmx.de>
>>> Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
>>> ---
>>>    .../ABI/testing/sysfs-platform-ayaneo-ec      |  19 ++++
>>>    MAINTAINERS                                   |   1 +
>>>    drivers/platform/x86/ayaneo-ec.c              | 106 ++++++++++++++++++
>>>    3 files changed, 126 insertions(+)
>>>    create mode 100644 Documentation/ABI/testing/sysfs-platform-ayaneo-ec
>>>
>>> diff --git a/Documentation/ABI/testing/sysfs-platform-ayaneo-ec b/Documentation/ABI/testing/sysfs-platform-ayaneo-ec
>>> new file mode 100644
>>> index 000000000000..3c9c3580c685
>>> --- /dev/null
>>> +++ b/Documentation/ABI/testing/sysfs-platform-ayaneo-ec
>>> @@ -0,0 +1,19 @@
>>> +What:                /sys/devices/platform/ayaneo-ec/controller_power
>>> +Date:                Oct 2025
>> I think you need to update those dates.
>>
>>> +KernelVersion:       6.19
>>> +Contact:     "Antheas Kapenekakis" <lkml@antheas.dev>
>>> +Description:
>>> +             Current controller power state. Allows turning on and off
>>> +             the controller power (e.g. for power savings). Write 1 to
>>> +             turn on, 0 to turn off. File is readable and writable.
>>> +
>>> +What:                /sys/devices/platform/ayaneo-ec/controller_modules
>>> +Date:                Oct 2025
>>> +KernelVersion:       6.19
>>> +Contact:     "Antheas Kapenekakis"  <lkml@antheas.dev>
>>> +Description:
>>> +             Shows which controller modules are currently connected to
>>> +             the device. Possible values are "left", "right" and "both".
>>> +             File is read-only. The Windows software for this device
>>> +             will only set controller power to 1 if both module sides
>>> +             are connected (i.e. this file returns "both").
>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>> index da9498d8cc89..b4d62ea9a926 100644
>>> --- a/MAINTAINERS
>>> +++ b/MAINTAINERS
>>> @@ -4191,6 +4191,7 @@ AYANEO PLATFORM EC DRIVER
>>>    M:  Antheas Kapenekakis <lkml@antheas.dev>
>>>    L:  platform-driver-x86@vger.kernel.org
>>>    S:  Maintained
>>> +F:   Documentation/ABI/testing/sysfs-platform-ayaneo
>>>    F:  drivers/platform/x86/ayaneo-ec.c
>>>
>>>    AZ6007 DVB DRIVER
>>> diff --git a/drivers/platform/x86/ayaneo-ec.c b/drivers/platform/x86/ayaneo-ec.c
>>> index 697bb053a7d6..0652c044ad76 100644
>>> --- a/drivers/platform/x86/ayaneo-ec.c
>>> +++ b/drivers/platform/x86/ayaneo-ec.c
>>> @@ -8,6 +8,7 @@
>>>     */
>>>
>>>    #include <linux/acpi.h>
>>> +#include <linux/bits.h>
>>>    #include <linux/dmi.h>
>>>    #include <linux/err.h>
>>>    #include <linux/hwmon.h>
>>> @@ -16,6 +17,7 @@
>>>    #include <linux/module.h>
>>>    #include <linux/platform_device.h>
>>>    #include <linux/power_supply.h>
>>> +#include <linux/sysfs.h>
>>>    #include <acpi/battery.h>
>>>
>>>    #define AYANEO_PWM_ENABLE_REG        0x4A
>>> @@ -32,9 +34,17 @@
>>>    #define AYANEO_CHARGE_VAL_AUTO              0xaa
>>>    #define AYANEO_CHARGE_VAL_INHIBIT   0x55
>>>
>>> +#define AYANEO_POWER_REG     0x2d
>>> +#define AYANEO_POWER_OFF     0xfe
>>> +#define AYANEO_POWER_ON              0xff
>>> +#define AYANEO_MODULE_REG    0x2f
>>> +#define AYANEO_MODULE_LEFT   BIT(0)
>>> +#define AYANEO_MODULE_RIGHT  BIT(1)
>> Using GENMASK() would make sense here.
> Only a single bit is being used though? GENMASK is used for a contiguous series?

I was thinking of using GENMASK() for both bits:

#define AYANEO_MODULE_MASK	GENMASK(1, 0)

You can then retrieve both bits using FIELD_GET() and simply use a switch statement
together with an enum in controller_modules_show().

Thanks,
Armin Wolf

>> With those issues being fixed:
>> Reviewed-by: Armin Wolf <W_Armin@gmx.de>
>>
>>> +
>>>    struct ayaneo_ec_quirk {
>>>        bool has_fan_control;
>>>        bool has_charge_control;
>>> +     bool has_magic_modules;
>>>    };
>>>
>>>    struct ayaneo_ec_platform_data {
>>> @@ -46,6 +56,7 @@ struct ayaneo_ec_platform_data {
>>>    static const struct ayaneo_ec_quirk quirk_ayaneo3 = {
>>>        .has_fan_control = true,
>>>        .has_charge_control = true,
>>> +     .has_magic_modules = true,
>>>    };
>>>
>>>    static const struct dmi_system_id dmi_table[] = {
>>> @@ -266,6 +277,100 @@ static int ayaneo_remove_battery(struct power_supply *battery,
>>>        return 0;
>>>    }
>>>
>>> +static ssize_t controller_power_store(struct device *dev,
>>> +                                   struct device_attribute *attr,
>>> +                                   const char *buf,
>>> +                                   size_t count)
>>> +{
>>> +     bool value;
>>> +     int ret;
>>> +
>>> +     ret = kstrtobool(buf, &value);
>>> +     if (ret)
>>> +             return ret;
>>> +
>>> +     ret = ec_write(AYANEO_POWER_REG, value ? AYANEO_POWER_ON : AYANEO_POWER_OFF);
>>> +     if (ret)
>>> +             return ret;
>>> +
>>> +     return count;
>>> +}
>>> +
>>> +static ssize_t controller_power_show(struct device *dev,
>>> +                                  struct device_attribute *attr,
>>> +                                  char *buf)
>>> +{
>>> +     int ret;
>>> +     u8 val;
>>> +
>>> +     ret = ec_read(AYANEO_POWER_REG, &val);
>>> +     if (ret)
>>> +             return ret;
>>> +
>>> +     return sysfs_emit(buf, "%d\n", val == AYANEO_POWER_ON);
>>> +}
>>> +
>>> +static DEVICE_ATTR_RW(controller_power);
>>> +
>>> +static ssize_t controller_modules_show(struct device *dev,
>>> +                                    struct device_attribute *attr, char *buf)
>>> +{
>>> +     char *out;
>>> +     int ret;
>>> +     u8 val;
>>> +
>>> +     ret = ec_read(AYANEO_MODULE_REG, &val);
>>> +     if (ret)
>>> +             return ret;
>>> +
>>> +     switch (~val & (AYANEO_MODULE_LEFT | AYANEO_MODULE_RIGHT)) {
>>> +     case AYANEO_MODULE_LEFT | AYANEO_MODULE_RIGHT:
>>> +             out = "both";
>>> +             break;
>>> +     case AYANEO_MODULE_LEFT:
>>> +             out = "left";
>>> +             break;
>>> +     case AYANEO_MODULE_RIGHT:
>>> +             out = "right";
>>> +             break;
>>> +     default:
>>> +             out = "none";
>>> +             break;
>>> +     }
>>> +
>>> +     return sysfs_emit(buf, "%s\n", out);
>>> +}
>>> +
>>> +static DEVICE_ATTR_RO(controller_modules);
>>> +
>>> +static struct attribute *aya_mm_attrs[] = {
>>> +     &dev_attr_controller_power.attr,
>>> +     &dev_attr_controller_modules.attr,
>>> +     NULL
>>> +};
>>> +
>>> +static umode_t aya_mm_is_visible(struct kobject *kobj,
>>> +                              struct attribute *attr, int n)
>>> +{
>>> +     struct device *dev = kobj_to_dev(kobj);
>>> +     struct platform_device *pdev = to_platform_device(dev);
>>> +     struct ayaneo_ec_platform_data *data = platform_get_drvdata(pdev);
>>> +
>>> +     if (data->quirks->has_magic_modules)
>>> +             return attr->mode;
>>> +     return 0;
>>> +}
>>> +
>>> +static const struct attribute_group aya_mm_attribute_group = {
>>> +     .is_visible = aya_mm_is_visible,
>>> +     .attrs = aya_mm_attrs,
>>> +};
>>> +
>>> +static const struct attribute_group *ayaneo_ec_groups[] = {
>>> +     &aya_mm_attribute_group,
>>> +     NULL
>>> +};
>>> +
>>>    static int ayaneo_ec_probe(struct platform_device *pdev)
>>>    {
>>>        const struct dmi_system_id *dmi_entry;
>>> @@ -307,6 +412,7 @@ static int ayaneo_ec_probe(struct platform_device *pdev)
>>>    static struct platform_driver ayaneo_platform_driver = {
>>>        .driver = {
>>>                .name = "ayaneo-ec",
>>> +             .dev_groups = ayaneo_ec_groups,
>>>        },
>>>        .probe = ayaneo_ec_probe,
>>>    };

