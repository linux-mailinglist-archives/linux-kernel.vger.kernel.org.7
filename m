Return-Path: <linux-kernel+bounces-803624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE9DCB4631C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 21:05:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D1993B2852
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 19:05:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA2CF169AE6;
	Fri,  5 Sep 2025 19:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="JkS30Nfz"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85043315D22;
	Fri,  5 Sep 2025 19:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757099117; cv=none; b=ByVJgjcEj6hvpAk3hBcuIoKvWmz3zC+7vzbkAsAXTrEXOwvavjgaoUyndHb5j7s5M46vML0yyM53ggAEDHGlrB/ldJjPr0MMebwha2DNOp51pS6Qg+IeQ8Kg2dJ/WtMNv3tDPDBDHchGnhcRRN6QWlcilZPojEC5BTr8LiDrIWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757099117; c=relaxed/simple;
	bh=7v/ObfEIeymvU6Pw0mc0YttP8zfZXn8La9HxcfDBrKQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NgXMpMhD+PnzLWNqQdXsWIZav3jiyLqMIWx2XmOw0CVq1KrhaV1Sk1pdl5npFFhvftU8OzZ1CgDbdw7q9ixPokAPXshFIZAbYlGdSU262QuvFWHjz2aHRE1C/fukxCy9ndRWY6L/MN5bJ3fU98iYODpaKJuvmQTHSZTtt8avQf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=JkS30Nfz; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1757099111; x=1757703911; i=w_armin@gmx.de;
	bh=kwyKT5ioczeq0paPJps39C9WtWPdV+K2tWrCLMHAc/g=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=JkS30NfzMC4G+21iCtbW6L8ky22NzpjfN90af+ro2/Big6b5IXLxWs5hCycx1cwI
	 fZqgLcjPvtZ89BTsJLqucVbLBF59VCmgE5mEtHthrEn9tuYSxnS/Ay7Qt+f+RhNv8
	 08YqQeuI/3c0eIosNC7Sv1Yt10cRVGvZGAPFIKWwiPLEVTAoebl9QgfikKmoRyma5
	 CT7qYJyQMaQNoggRlHt9px+ZXDtJJChw3RMBYirKUJS/Tn66XpwtHozhnujxxEyH/
	 8EAuqyhbbUmPbYRbzoyXve28HtgsT6xouMxRRzQ80c5YixBiaGf/hWoaGtPzKPu2W
	 ox1bdclRERQ566T8sQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [10.84.88.1] ([176.1.12.67]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MpUUm-1u7CZ90DIi-00pV4J; Fri, 05
 Sep 2025 21:05:11 +0200
Message-ID: <d710b0b7-1bd3-4386-b791-d22506d052df@gmx.de>
Date: Fri, 5 Sep 2025 21:05:06 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 4/5] platform/x86: ayaneo-ec: Add controller power and
 modules attributes
To: Antheas Kapenekakis <lkml@antheas.dev>
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hwmon@vger.kernel.org, Hans de Goede <hansg@kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Derek John Clark <derekjohn.clark@gmail.com>,
 =?UTF-8?Q?Joaqu=C3=ADn_Ignacio_Aramend=C3=ADa?= <samsagax@gmail.com>,
 Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>
References: <20250820160628.99678-1-lkml@antheas.dev>
 <20250820160628.99678-5-lkml@antheas.dev>
 <aaf9682d-f48f-4d43-b8fe-87a93b353fa7@gmx.de>
 <CAGwozwE8hr=kDFvMdkoq7mkc8nV9xrY-5OQG+CjPg14ok88Zow@mail.gmail.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <CAGwozwE8hr=kDFvMdkoq7mkc8nV9xrY-5OQG+CjPg14ok88Zow@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:G4h8nkcGDFJtmhOkJKhk7wwa72QZlYJr7MOF8qEFC/SN4ls1fGQ
 A/HrxlhAQCPK56PfjQD69JnTcHKr/d8kDFXviMHLjaoO2dNnyQB09OcRxHU5OK2qJgAwak2
 6mI/a+2Y74/mabrSbpeOrwHgXvzys1ixSSQZpVvvwJYdMmSCy94bvbw7tHcko00CNHBiuBE
 Nqv5RPQXFqMy9WmZte91g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:/u4PLjKNEyI=;upyVaffdv7jiX3Fdv5lCPVImIlw
 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
 D

Am 22.08.25 um 23:08 schrieb Antheas Kapenekakis:

> On Fri, 22 Aug 2025 at 14:41, Armin Wolf <W_Armin@gmx.de> wrote:
>> Am 20.08.25 um 18:06 schrieb Antheas Kapenekakis:
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
>>> This patch introduces two new firmware attributes:
>>>    - `controller_modules`: a read-only attribute that indicates whether
>>>      the left and right modules are connected (none, left, right, both).
>>>    - `controller_power`: a read-write attribute that allows the user
>>>      to turn the controller on or off (with 'on'/'off').
>>>
>>> Therefore, after ejection is complete, userspace can power off the
>>> controller, then wait until both modules have been reinserted
>>> (`controller_modules` will return 'both') to turn on the controller.
>> I do not think that those controls should be exposed as firmware attributes,
>> as they are live values not persistent across power cycles. Better use
>> sysfs attributes instead.
> Isn't there precedent for this with SPL/SPPT/FPPT? I remember having a
> long form discussion with you about how this interface is appropriate
> for this, which is why I used it here.
>
> The controller_modules attribute is read only and reports which
> modules are connected, which is somewhat useful. As for power, it can
> likewise be used by users to toggle the controller on and off. Indeed,
> the attribute is not long lasting though.
>
> Best,
> Antheas

The difference between SPL/SPPT/FPPT and the controller attributes is that the latter are
reflecting the current physical state of the hardware, rather than being some tunables that
are fully controlled by the user.

Because of this i strongly suggest you to use plain sysfs attributes instead. This would also
make it easier for the userspace daemon handling the controllers.

Thanks,
Armin Wolf

>
>> Thanks,
>> Armin Wolf
>>
>>> Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
>>> ---
>>>    drivers/platform/x86/ayaneo-ec.c | 235 ++++++++++++++++++++++++++++++-
>>>    1 file changed, 234 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/platform/x86/ayaneo-ec.c b/drivers/platform/x86/ayaneo-ec.c
>>> index a4bdc6ae7af7..eb7f9ae03b4f 100644
>>> --- a/drivers/platform/x86/ayaneo-ec.c
>>> +++ b/drivers/platform/x86/ayaneo-ec.c
>>> @@ -16,6 +16,10 @@
>>>    #include <linux/platform_device.h>
>>>    #include <acpi/battery.h>
>>>
>>> +#include "firmware_attributes_class.h"
>>> +
>>> +#define DRIVER_NAME "ayaneo-ec"
>>> +
>>>    #define AYANEO_PWM_ENABLE_REG        0x4A
>>>    #define AYANEO_PWM_REG               0x4B
>>>    #define AYANEO_PWM_MODE_AUTO         0x00
>>> @@ -30,20 +34,60 @@
>>>    #define AYANEO_CHARGE_VAL_AUTO              0xaa
>>>    #define AYANEO_CHARGE_VAL_INHIBIT   0x55
>>>
>>> +#define AYANEO_POWER_REG     0x2d
>>> +#define AYANEO_POWER_OFF     0xfe
>>> +#define AYANEO_POWER_ON              0xff
>>> +#define AYANEO_MODULE_REG    0x2f
>>> +#define AYANEO_MODULE_LEFT   BIT(0)
>>> +#define AYANEO_MODULE_RIGHT  BIT(1)
>>> +
>>> +enum ayaneo_fw_attr_id {
>>> +     AYANEO_ATTR_CONTROLLER_MODULES,
>>> +     AYANEO_ATTR_CONTROLLER_POWER,
>>> +};
>>> +
>>> +static const char *const ayaneo_fw_attr_name[] = {
>>> +     [AYANEO_ATTR_CONTROLLER_MODULES] = "controller_modules",
>>> +     [AYANEO_ATTR_CONTROLLER_POWER] = "controller_power",
>>> +};
>>> +
>>> +static const char *const ayaneo_fw_attr_desc[] = {
>>> +     [AYANEO_ATTR_CONTROLLER_MODULES] =
>>> +             "Which controller Magic Modules are connected (none, left, right, both)",
>>> +     [AYANEO_ATTR_CONTROLLER_POWER] = "Controller power state (on, off)",
>>> +};
>>> +
>>> +#define AYANEO_ATTR_ENUM_MAX_ATTRS 7
>>> +#define AYANEO_ATTR_LANGUAGE_CODE "en_US.UTF-8"
>>> +
>>>    struct ayaneo_ec_quirk {
>>>        bool has_fan_control;
>>>        bool has_charge_control;
>>> +     bool has_magic_modules;
>>> +     bool has_controller_power;
>>>    };
>>>
>>>    struct ayaneo_ec_platform_data {
>>>        struct platform_device *pdev;
>>>        struct ayaneo_ec_quirk *quirks;
>>>        struct acpi_battery_hook battery_hook;
>>> +     struct device *fw_attrs_dev;
>>> +     struct kset *fw_attrs_kset;
>>> +};
>>> +
>>> +struct ayaneo_fw_attr {
>>> +     struct ayaneo_ec_platform_data *data;
>>> +     enum ayaneo_fw_attr_id fw_attr_id;
>>> +     struct attribute_group attr_group;
>>> +     struct kobj_attribute display_name;
>>> +     struct kobj_attribute current_value;
>>>    };
>>>
>>>    static const struct ayaneo_ec_quirk ayaneo3 = {
>>>        .has_fan_control = true,
>>>        .has_charge_control = true,
>>> +     .has_magic_modules = true,
>>> +     .has_controller_power = true,
>>>    };
>>>
>>>    static const struct dmi_system_id dmi_table[] = {
>>> @@ -260,6 +304,159 @@ static int ayaneo_remove_battery(struct power_supply *battery,
>>>        return 0;
>>>    }
>>>
>>> +static void ayaneo_kset_unregister(void *data)
>>> +{
>>> +     struct kset *kset = data;
>>> +
>>> +     kset_unregister(kset);
>>> +}
>>> +
>>> +static void ayaneo_fw_attrs_dev_unregister(void *data)
>>> +{
>>> +     struct device *fw_attrs_dev = data;
>>> +
>>> +     device_unregister(fw_attrs_dev);
>>> +}
>>> +
>>> +static ssize_t display_name_language_code_show(struct kobject *kobj,
>>> +                                            struct kobj_attribute *attr,
>>> +                                            char *buf)
>>> +{
>>> +     return sysfs_emit(buf, "%s\n", AYANEO_ATTR_LANGUAGE_CODE);
>>> +}
>>> +
>>> +static struct kobj_attribute fw_attr_display_name_language_code =
>>> +     __ATTR_RO(display_name_language_code);
>>> +
>>> +static ssize_t display_name_show(struct kobject *kobj,
>>> +                              struct kobj_attribute *attr, char *buf)
>>> +{
>>> +     struct ayaneo_fw_attr *fw_attr =
>>> +             container_of(attr, struct ayaneo_fw_attr, display_name);
>>> +
>>> +     return sysfs_emit(buf, "%s\n", ayaneo_fw_attr_desc[fw_attr->fw_attr_id]);
>>> +}
>>> +
>>> +static ssize_t current_value_show(struct kobject *kobj,
>>> +                               struct kobj_attribute *attr, char *buf)
>>> +{
>>> +     struct ayaneo_fw_attr *fw_attr =
>>> +             container_of(attr, struct ayaneo_fw_attr, current_value);
>>> +     bool left, right;
>>> +     char *out;
>>> +     int ret;
>>> +     u8 tmp;
>>> +
>>> +     switch (fw_attr->fw_attr_id) {
>>> +     case AYANEO_ATTR_CONTROLLER_MODULES:
>>> +             ret = ec_read(AYANEO_MODULE_REG, &tmp);
>>> +             if (ret)
>>> +                     return ret;
>>> +             left = !(tmp & AYANEO_MODULE_LEFT);
>>> +             right = !(tmp & AYANEO_MODULE_RIGHT);
>>> +
>>> +             if (left && right)
>>> +                     out = "both";
>>> +             else if (left)
>>> +                     out = "left";
>>> +             else if (right)
>>> +                     out = "right";
>>> +             else
>>> +                     out = "none";
>>> +
>>> +             return sysfs_emit(buf, "%s\n", out);
>>> +     case AYANEO_ATTR_CONTROLLER_POWER:
>>> +             ret = ec_read(AYANEO_POWER_REG, &tmp);
>>> +             if (ret)
>>> +                     return ret;
>>> +
>>> +             if (tmp == AYANEO_POWER_OFF)
>>> +                     out = "off";
>>> +             else
>>> +                     out = "on";
>>> +
>>> +             return sysfs_emit(buf, "%s\n", out);
>>> +     }
>>> +     return -EINVAL;
>>> +}
>>> +
>>> +static ssize_t current_value_store(struct kobject *kobj,
>>> +                                struct kobj_attribute *attr, const char *buf,
>>> +                                size_t count)
>>> +{
>>> +     struct ayaneo_fw_attr *fw_attr =
>>> +             container_of(attr, struct ayaneo_fw_attr, current_value);
>>> +     int ret;
>>> +
>>> +     switch (fw_attr->fw_attr_id) {
>>> +     case AYANEO_ATTR_CONTROLLER_POWER:
>>> +             if (sysfs_streq(buf, "on"))
>>> +                     ret = ec_write(AYANEO_POWER_REG, AYANEO_POWER_ON);
>>> +             else if (sysfs_streq(buf, "off"))
>>> +                     ret = ec_write(AYANEO_POWER_REG, AYANEO_POWER_OFF);
>>> +             if (ret)
>>> +                     return ret;
>>> +             return count;
>>> +     case AYANEO_ATTR_CONTROLLER_MODULES:
>>> +             return -EINVAL;
>>> +     }
>>> +     return -EINVAL;
>>> +}
>>> +
>>> +static ssize_t type_show(struct kobject *kobj, struct kobj_attribute *attr,
>>> +                      char *buf)
>>> +{
>>> +     return sysfs_emit(buf, "string\n");
>>> +}
>>> +
>>> +static struct kobj_attribute fw_attr_type_string = {
>>> +     .attr = { .name = "type", .mode = 0444 },
>>> +     .show = type_show,
>>> +};
>>> +
>>> +static int ayaneo_fw_attr_init(struct ayaneo_ec_platform_data *data,
>>> +                            const enum ayaneo_fw_attr_id fw_attr_id,
>>> +                            bool read_only)
>>> +{
>>> +     struct ayaneo_fw_attr *fw_attr;
>>> +     struct attribute **attrs;
>>> +     int idx = 0;
>>> +
>>> +     fw_attr = devm_kzalloc(&data->pdev->dev, sizeof(*fw_attr), GFP_KERNEL);
>>> +     if (!fw_attr)
>>> +             return -ENOMEM;
>>> +
>>> +     attrs = devm_kcalloc(&data->pdev->dev, AYANEO_ATTR_ENUM_MAX_ATTRS + 1,
>>> +                          sizeof(*attrs), GFP_KERNEL);
>>> +     if (!attrs)
>>> +             return -ENOMEM;
>>> +
>>> +     fw_attr->data = data;
>>> +     fw_attr->fw_attr_id = fw_attr_id;
>>> +     fw_attr->attr_group.name = ayaneo_fw_attr_name[fw_attr_id];
>>> +     fw_attr->attr_group.attrs = attrs;
>>> +
>>> +     attrs[idx++] = &fw_attr_type_string.attr;
>>> +     attrs[idx++] = &fw_attr_display_name_language_code.attr;
>>> +
>>> +     sysfs_attr_init(&fw_attr->display_name.attr);
>>> +     fw_attr->display_name.attr.name = "display_name";
>>> +     fw_attr->display_name.attr.mode = 0444;
>>> +     fw_attr->display_name.show = display_name_show;
>>> +     attrs[idx++] = &fw_attr->display_name.attr;
>>> +
>>> +     sysfs_attr_init(&fw_attr->current_value.attr);
>>> +     fw_attr->current_value.attr.name = "current_value";
>>> +     fw_attr->current_value.attr.mode = read_only ? 0444 : 0644;
>>> +     fw_attr->current_value.show = current_value_show;
>>> +     fw_attr->current_value.store = current_value_store;
>>> +     attrs[idx++] = &fw_attr->current_value.attr;
>>> +
>>> +     attrs[idx] = NULL;
>>> +     return sysfs_create_group(&data->fw_attrs_kset->kobj,
>>> +                               &fw_attr->attr_group);
>>> +}
>>> +
>>>    static int ayaneo_ec_probe(struct platform_device *pdev)
>>>    {
>>>        const struct dmi_system_id *dmi_entry;
>>> @@ -295,12 +492,48 @@ static int ayaneo_ec_probe(struct platform_device *pdev)
>>>                        return ret;
>>>        }
>>>
>>> +     if (data->quirks->has_magic_modules || data->quirks->has_controller_power) {
>>> +             data->fw_attrs_dev = device_create(&firmware_attributes_class, NULL,
>>> +                                             MKDEV(0, 0), NULL, "%s",
>>> +                                             DRIVER_NAME);
>>> +             if (IS_ERR(data->fw_attrs_dev))
>>> +                     return PTR_ERR(data->fw_attrs_dev);
>>> +
>>> +             ret = devm_add_action_or_reset(&data->pdev->dev,
>>> +                                     ayaneo_fw_attrs_dev_unregister,
>>> +                                     data->fw_attrs_dev);
>>> +             if (ret)
>>> +                     return ret;
>>> +
>>> +             data->fw_attrs_kset = kset_create_and_add("attributes", NULL,
>>> +                                                     &data->fw_attrs_dev->kobj);
>>> +             if (!data->fw_attrs_kset)
>>> +                     return -ENOMEM;
>>> +
>>> +             ret = devm_add_action_or_reset(&data->pdev->dev, ayaneo_kset_unregister,
>>> +                                     data->fw_attrs_kset);
>>> +
>>> +             if (data->quirks->has_magic_modules) {
>>> +                     ret = ayaneo_fw_attr_init(
>>> +                             data, AYANEO_ATTR_CONTROLLER_MODULES, true);
>>> +                     if (ret)
>>> +                             return ret;
>>> +             }
>>> +
>>> +             if (data->quirks->has_controller_power) {
>>> +                     ret = ayaneo_fw_attr_init(
>>> +                             data, AYANEO_ATTR_CONTROLLER_POWER, false);
>>> +                     if (ret)
>>> +                             return ret;
>>> +             }
>>> +     }
>>> +
>>>        return 0;
>>>    }
>>>
>>>    static struct platform_driver ayaneo_platform_driver = {
>>>        .driver = {
>>> -             .name = "ayaneo-ec",
>>> +             .name = DRIVER_NAME,
>>>        },
>>>        .probe = ayaneo_ec_probe,
>>>    };

