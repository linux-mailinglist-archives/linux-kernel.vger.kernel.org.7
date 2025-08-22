Return-Path: <linux-kernel+bounces-782710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 70323B323F3
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 23:09:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 284E67B02E1
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 21:07:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0450308F39;
	Fri, 22 Aug 2025 21:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="DDf155oi"
Received: from relay10.grserver.gr (relay10.grserver.gr [37.27.248.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71EB72C031B;
	Fri, 22 Aug 2025 21:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.27.248.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755896941; cv=none; b=hiEIVQrhKHb0B0xb1W1aS855TKWgXexOfjiITHU8G7Yj+Y+q43WDHhHeglxiir8piVKknLoavhxtRElGj4JPSitgYKibuFSYo+8oYWGr9lkEhoUxAREtybUXunujeT8v9jRHDMmJpdStru1LVRCLVB+g8jpVjiNXmqIs0xCe7iA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755896941; c=relaxed/simple;
	bh=aj5L2TX2iwz2NiltJHcPmFvBlvtRm7L7Q9nIczpF//U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=egksKfZCxWrm7AG6FQQRkqrF4cxNl2kRLgsPjXXWQj1ByDKKvi7z40s6sIJ/8E3aeQlUYzXKdduRrlxf9L2yAMh/IT8AozICD3WwhoyqOfXw4Zqvd3ct3l4BvBlfbqZ1DA6yFq7JnIjDrergS3HGVeJfs6KHCXhVYL3EG/Yt+o0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=temperror (0-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=DDf155oi; arc=none smtp.client-ip=37.27.248.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from relay10 (localhost.localdomain [127.0.0.1])
	by relay10.grserver.gr (Proxmox) with ESMTP id B5E933EAE6;
	Sat, 23 Aug 2025 00:08:57 +0300 (EEST)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by relay10.grserver.gr (Proxmox) with ESMTPS id 912D63EA45;
	Sat, 23 Aug 2025 00:08:56 +0300 (EEST)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	by linux3247.grserver.gr (Postfix) with ESMTPSA id E53421FF777;
	Sat, 23 Aug 2025 00:08:55 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1755896936;
	bh=tXVCoDJ1dJ54wtQS60wSOykNa185qcgeAq3DOhnPMhs=;
	h=Received:From:Subject:To;
	b=DDf155oiRfB76iP1UdFhdIY5GftS03gplGMBIuz/wrVNmR3L4ByAKfgvxLkuTOjiX
	 BXQo9SEZPcC8gqpsu6KsYErlAhsEJffGBEnTOoPk2wT1F8m1TGVj201LlM+I4WxxzY
	 Y6OFR4W2jGn5PhhVJnnlxKr0eBzJM6MZ6PDN8rWMm+8Vobi3hiFPN2sjgPmujdLyqq
	 UVRpao8oOehArCQ3TEDsJhU3xwm/rjeMoWH0SNvhwbNPfGJWzWHiWW/BRjgOsc7FTQ
	 b7WzpOnv6fc/AQvmX/wWZtmZedquGVcQwh+QgIYWYXZIvGCW7Tavwtr0ssXo/JxXLS
	 blRO3iG1J4ULw==
Authentication-Results: linux3247.grserver.gr;
        spf=pass (sender IP is 209.85.208.180) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-lj1-f180.google.com
Received-SPF: pass (linux3247.grserver.gr: connection is authenticated)
Received: by mail-lj1-f180.google.com with SMTP id
 38308e7fff4ca-33663076b32so219011fa.0;
        Fri, 22 Aug 2025 14:08:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCX0MRGW41VexXAxAmYS8mDDye5KAfEJ+OyjAEfPU6WU1/vhmcpKYPj14IjwdNF+KBFHeWt4RKDC+FpHxsTV@vger.kernel.org,
 AJvYcCXAr+EZ/kF0ChU8jV1GPj+nOWo5OIL0TqCRZ702yQpq7fL5I4ZTFi2bXnue8CaFNzcdBBN/1DKFwIwdCA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzZWdIaaYrkN3qFJgYdJxDjC2VoT1VGabQHNMjbHBJpmdHXOhXQ
	TUAod5qwekbDoGa9tKGkDQJtzKV+i9USz81GsfNWKPZQVvqm2gwnaZi/wsXDvWPW8yQfcSck+wV
	Nf8GZYV4KzhLnSvO8g4ol8nJX4ZGY1IU=
X-Google-Smtp-Source: 
 AGHT+IF0BJB6744loVNX9J+VwPM1e6/x0rlPnAt+1tlz4WNIs7TXIXJk6wwdyAdLAtLweu9PnvPLhONcJMteVKG5dio=
X-Received: by 2002:a2e:a9a9:0:b0:32b:4773:7a80 with SMTP id
 38308e7fff4ca-33650f3e3c5mr13863411fa.25.1755896935419; Fri, 22 Aug 2025
 14:08:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250820160628.99678-1-lkml@antheas.dev>
 <20250820160628.99678-5-lkml@antheas.dev>
 <aaf9682d-f48f-4d43-b8fe-87a93b353fa7@gmx.de>
In-Reply-To: <aaf9682d-f48f-4d43-b8fe-87a93b353fa7@gmx.de>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Fri, 22 Aug 2025 23:08:44 +0200
X-Gmail-Original-Message-ID: 
 <CAGwozwE8hr=kDFvMdkoq7mkc8nV9xrY-5OQG+CjPg14ok88Zow@mail.gmail.com>
X-Gm-Features: Ac12FXz09FfCZBkF-EGxQ6-31MMY1qBnsIDBcAzL5UzPEiL3YjYLI0tUrZ0OxJ8
Message-ID: 
 <CAGwozwE8hr=kDFvMdkoq7mkc8nV9xrY-5OQG+CjPg14ok88Zow@mail.gmail.com>
Subject: Re: [PATCH v1 4/5] platform/x86: ayaneo-ec: Add controller power and
 modules attributes
To: Armin Wolf <W_Armin@gmx.de>
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hwmon@vger.kernel.org, Hans de Goede <hansg@kernel.org>,
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Derek John Clark <derekjohn.clark@gmail.com>,
	=?UTF-8?Q?Joaqu=C3=ADn_Ignacio_Aramend=C3=ADa?= <samsagax@gmail.com>,
	Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
X-PPP-Message-ID: 
 <175589693614.2814910.11317773422842162509@linux3247.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 1.4.3 at linux3247.grserver.gr
X-Virus-Status: Clean

On Fri, 22 Aug 2025 at 14:41, Armin Wolf <W_Armin@gmx.de> wrote:
>
> Am 20.08.25 um 18:06 schrieb Antheas Kapenekakis:
>
> > The Ayaneo 3 features hot-swappable controller modules. The ejection
> > and management is done through HID. However, after ejecting the modules,
> > the controller needs to be power cycled via the EC to re-initialize.
> >
> > For this, the EC provides a variable that holds whether the left or
> > right modules are connected, and a power control register to turn
> > the controller on or off. After ejecting the modules, the controller
> > should be turned off. Then, after both modules are reinserted,
> > the controller may be powered on again to re-initialize.
> >
> > This patch introduces two new firmware attributes:
> >   - `controller_modules`: a read-only attribute that indicates whether
> >     the left and right modules are connected (none, left, right, both).
> >   - `controller_power`: a read-write attribute that allows the user
> >     to turn the controller on or off (with 'on'/'off').
> >
> > Therefore, after ejection is complete, userspace can power off the
> > controller, then wait until both modules have been reinserted
> > (`controller_modules` will return 'both') to turn on the controller.
>
> I do not think that those controls should be exposed as firmware attributes,
> as they are live values not persistent across power cycles. Better use
> sysfs attributes instead.

Isn't there precedent for this with SPL/SPPT/FPPT? I remember having a
long form discussion with you about how this interface is appropriate
for this, which is why I used it here.

The controller_modules attribute is read only and reports which
modules are connected, which is somewhat useful. As for power, it can
likewise be used by users to toggle the controller on and off. Indeed,
the attribute is not long lasting though.

Best,
Antheas

> Thanks,
> Armin Wolf
>
> >
> > Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
> > ---
> >   drivers/platform/x86/ayaneo-ec.c | 235 ++++++++++++++++++++++++++++++-
> >   1 file changed, 234 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/platform/x86/ayaneo-ec.c b/drivers/platform/x86/ayaneo-ec.c
> > index a4bdc6ae7af7..eb7f9ae03b4f 100644
> > --- a/drivers/platform/x86/ayaneo-ec.c
> > +++ b/drivers/platform/x86/ayaneo-ec.c
> > @@ -16,6 +16,10 @@
> >   #include <linux/platform_device.h>
> >   #include <acpi/battery.h>
> >
> > +#include "firmware_attributes_class.h"
> > +
> > +#define DRIVER_NAME "ayaneo-ec"
> > +
> >   #define AYANEO_PWM_ENABLE_REG        0x4A
> >   #define AYANEO_PWM_REG               0x4B
> >   #define AYANEO_PWM_MODE_AUTO         0x00
> > @@ -30,20 +34,60 @@
> >   #define AYANEO_CHARGE_VAL_AUTO              0xaa
> >   #define AYANEO_CHARGE_VAL_INHIBIT   0x55
> >
> > +#define AYANEO_POWER_REG     0x2d
> > +#define AYANEO_POWER_OFF     0xfe
> > +#define AYANEO_POWER_ON              0xff
> > +#define AYANEO_MODULE_REG    0x2f
> > +#define AYANEO_MODULE_LEFT   BIT(0)
> > +#define AYANEO_MODULE_RIGHT  BIT(1)
> > +
> > +enum ayaneo_fw_attr_id {
> > +     AYANEO_ATTR_CONTROLLER_MODULES,
> > +     AYANEO_ATTR_CONTROLLER_POWER,
> > +};
> > +
> > +static const char *const ayaneo_fw_attr_name[] = {
> > +     [AYANEO_ATTR_CONTROLLER_MODULES] = "controller_modules",
> > +     [AYANEO_ATTR_CONTROLLER_POWER] = "controller_power",
> > +};
> > +
> > +static const char *const ayaneo_fw_attr_desc[] = {
> > +     [AYANEO_ATTR_CONTROLLER_MODULES] =
> > +             "Which controller Magic Modules are connected (none, left, right, both)",
> > +     [AYANEO_ATTR_CONTROLLER_POWER] = "Controller power state (on, off)",
> > +};
> > +
> > +#define AYANEO_ATTR_ENUM_MAX_ATTRS 7
> > +#define AYANEO_ATTR_LANGUAGE_CODE "en_US.UTF-8"
> > +
> >   struct ayaneo_ec_quirk {
> >       bool has_fan_control;
> >       bool has_charge_control;
> > +     bool has_magic_modules;
> > +     bool has_controller_power;
> >   };
> >
> >   struct ayaneo_ec_platform_data {
> >       struct platform_device *pdev;
> >       struct ayaneo_ec_quirk *quirks;
> >       struct acpi_battery_hook battery_hook;
> > +     struct device *fw_attrs_dev;
> > +     struct kset *fw_attrs_kset;
> > +};
> > +
> > +struct ayaneo_fw_attr {
> > +     struct ayaneo_ec_platform_data *data;
> > +     enum ayaneo_fw_attr_id fw_attr_id;
> > +     struct attribute_group attr_group;
> > +     struct kobj_attribute display_name;
> > +     struct kobj_attribute current_value;
> >   };
> >
> >   static const struct ayaneo_ec_quirk ayaneo3 = {
> >       .has_fan_control = true,
> >       .has_charge_control = true,
> > +     .has_magic_modules = true,
> > +     .has_controller_power = true,
> >   };
> >
> >   static const struct dmi_system_id dmi_table[] = {
> > @@ -260,6 +304,159 @@ static int ayaneo_remove_battery(struct power_supply *battery,
> >       return 0;
> >   }
> >
> > +static void ayaneo_kset_unregister(void *data)
> > +{
> > +     struct kset *kset = data;
> > +
> > +     kset_unregister(kset);
> > +}
> > +
> > +static void ayaneo_fw_attrs_dev_unregister(void *data)
> > +{
> > +     struct device *fw_attrs_dev = data;
> > +
> > +     device_unregister(fw_attrs_dev);
> > +}
> > +
> > +static ssize_t display_name_language_code_show(struct kobject *kobj,
> > +                                            struct kobj_attribute *attr,
> > +                                            char *buf)
> > +{
> > +     return sysfs_emit(buf, "%s\n", AYANEO_ATTR_LANGUAGE_CODE);
> > +}
> > +
> > +static struct kobj_attribute fw_attr_display_name_language_code =
> > +     __ATTR_RO(display_name_language_code);
> > +
> > +static ssize_t display_name_show(struct kobject *kobj,
> > +                              struct kobj_attribute *attr, char *buf)
> > +{
> > +     struct ayaneo_fw_attr *fw_attr =
> > +             container_of(attr, struct ayaneo_fw_attr, display_name);
> > +
> > +     return sysfs_emit(buf, "%s\n", ayaneo_fw_attr_desc[fw_attr->fw_attr_id]);
> > +}
> > +
> > +static ssize_t current_value_show(struct kobject *kobj,
> > +                               struct kobj_attribute *attr, char *buf)
> > +{
> > +     struct ayaneo_fw_attr *fw_attr =
> > +             container_of(attr, struct ayaneo_fw_attr, current_value);
> > +     bool left, right;
> > +     char *out;
> > +     int ret;
> > +     u8 tmp;
> > +
> > +     switch (fw_attr->fw_attr_id) {
> > +     case AYANEO_ATTR_CONTROLLER_MODULES:
> > +             ret = ec_read(AYANEO_MODULE_REG, &tmp);
> > +             if (ret)
> > +                     return ret;
> > +             left = !(tmp & AYANEO_MODULE_LEFT);
> > +             right = !(tmp & AYANEO_MODULE_RIGHT);
> > +
> > +             if (left && right)
> > +                     out = "both";
> > +             else if (left)
> > +                     out = "left";
> > +             else if (right)
> > +                     out = "right";
> > +             else
> > +                     out = "none";
> > +
> > +             return sysfs_emit(buf, "%s\n", out);
> > +     case AYANEO_ATTR_CONTROLLER_POWER:
> > +             ret = ec_read(AYANEO_POWER_REG, &tmp);
> > +             if (ret)
> > +                     return ret;
> > +
> > +             if (tmp == AYANEO_POWER_OFF)
> > +                     out = "off";
> > +             else
> > +                     out = "on";
> > +
> > +             return sysfs_emit(buf, "%s\n", out);
> > +     }
> > +     return -EINVAL;
> > +}
> > +
> > +static ssize_t current_value_store(struct kobject *kobj,
> > +                                struct kobj_attribute *attr, const char *buf,
> > +                                size_t count)
> > +{
> > +     struct ayaneo_fw_attr *fw_attr =
> > +             container_of(attr, struct ayaneo_fw_attr, current_value);
> > +     int ret;
> > +
> > +     switch (fw_attr->fw_attr_id) {
> > +     case AYANEO_ATTR_CONTROLLER_POWER:
> > +             if (sysfs_streq(buf, "on"))
> > +                     ret = ec_write(AYANEO_POWER_REG, AYANEO_POWER_ON);
> > +             else if (sysfs_streq(buf, "off"))
> > +                     ret = ec_write(AYANEO_POWER_REG, AYANEO_POWER_OFF);
> > +             if (ret)
> > +                     return ret;
> > +             return count;
> > +     case AYANEO_ATTR_CONTROLLER_MODULES:
> > +             return -EINVAL;
> > +     }
> > +     return -EINVAL;
> > +}
> > +
> > +static ssize_t type_show(struct kobject *kobj, struct kobj_attribute *attr,
> > +                      char *buf)
> > +{
> > +     return sysfs_emit(buf, "string\n");
> > +}
> > +
> > +static struct kobj_attribute fw_attr_type_string = {
> > +     .attr = { .name = "type", .mode = 0444 },
> > +     .show = type_show,
> > +};
> > +
> > +static int ayaneo_fw_attr_init(struct ayaneo_ec_platform_data *data,
> > +                            const enum ayaneo_fw_attr_id fw_attr_id,
> > +                            bool read_only)
> > +{
> > +     struct ayaneo_fw_attr *fw_attr;
> > +     struct attribute **attrs;
> > +     int idx = 0;
> > +
> > +     fw_attr = devm_kzalloc(&data->pdev->dev, sizeof(*fw_attr), GFP_KERNEL);
> > +     if (!fw_attr)
> > +             return -ENOMEM;
> > +
> > +     attrs = devm_kcalloc(&data->pdev->dev, AYANEO_ATTR_ENUM_MAX_ATTRS + 1,
> > +                          sizeof(*attrs), GFP_KERNEL);
> > +     if (!attrs)
> > +             return -ENOMEM;
> > +
> > +     fw_attr->data = data;
> > +     fw_attr->fw_attr_id = fw_attr_id;
> > +     fw_attr->attr_group.name = ayaneo_fw_attr_name[fw_attr_id];
> > +     fw_attr->attr_group.attrs = attrs;
> > +
> > +     attrs[idx++] = &fw_attr_type_string.attr;
> > +     attrs[idx++] = &fw_attr_display_name_language_code.attr;
> > +
> > +     sysfs_attr_init(&fw_attr->display_name.attr);
> > +     fw_attr->display_name.attr.name = "display_name";
> > +     fw_attr->display_name.attr.mode = 0444;
> > +     fw_attr->display_name.show = display_name_show;
> > +     attrs[idx++] = &fw_attr->display_name.attr;
> > +
> > +     sysfs_attr_init(&fw_attr->current_value.attr);
> > +     fw_attr->current_value.attr.name = "current_value";
> > +     fw_attr->current_value.attr.mode = read_only ? 0444 : 0644;
> > +     fw_attr->current_value.show = current_value_show;
> > +     fw_attr->current_value.store = current_value_store;
> > +     attrs[idx++] = &fw_attr->current_value.attr;
> > +
> > +     attrs[idx] = NULL;
> > +     return sysfs_create_group(&data->fw_attrs_kset->kobj,
> > +                               &fw_attr->attr_group);
> > +}
> > +
> >   static int ayaneo_ec_probe(struct platform_device *pdev)
> >   {
> >       const struct dmi_system_id *dmi_entry;
> > @@ -295,12 +492,48 @@ static int ayaneo_ec_probe(struct platform_device *pdev)
> >                       return ret;
> >       }
> >
> > +     if (data->quirks->has_magic_modules || data->quirks->has_controller_power) {
> > +             data->fw_attrs_dev = device_create(&firmware_attributes_class, NULL,
> > +                                             MKDEV(0, 0), NULL, "%s",
> > +                                             DRIVER_NAME);
> > +             if (IS_ERR(data->fw_attrs_dev))
> > +                     return PTR_ERR(data->fw_attrs_dev);
> > +
> > +             ret = devm_add_action_or_reset(&data->pdev->dev,
> > +                                     ayaneo_fw_attrs_dev_unregister,
> > +                                     data->fw_attrs_dev);
> > +             if (ret)
> > +                     return ret;
> > +
> > +             data->fw_attrs_kset = kset_create_and_add("attributes", NULL,
> > +                                                     &data->fw_attrs_dev->kobj);
> > +             if (!data->fw_attrs_kset)
> > +                     return -ENOMEM;
> > +
> > +             ret = devm_add_action_or_reset(&data->pdev->dev, ayaneo_kset_unregister,
> > +                                     data->fw_attrs_kset);
> > +
> > +             if (data->quirks->has_magic_modules) {
> > +                     ret = ayaneo_fw_attr_init(
> > +                             data, AYANEO_ATTR_CONTROLLER_MODULES, true);
> > +                     if (ret)
> > +                             return ret;
> > +             }
> > +
> > +             if (data->quirks->has_controller_power) {
> > +                     ret = ayaneo_fw_attr_init(
> > +                             data, AYANEO_ATTR_CONTROLLER_POWER, false);
> > +                     if (ret)
> > +                             return ret;
> > +             }
> > +     }
> > +
> >       return 0;
> >   }
> >
> >   static struct platform_driver ayaneo_platform_driver = {
> >       .driver = {
> > -             .name = "ayaneo-ec",
> > +             .name = DRIVER_NAME,
> >       },
> >       .probe = ayaneo_ec_probe,
> >   };
>


