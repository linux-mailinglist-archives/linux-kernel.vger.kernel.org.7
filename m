Return-Path: <linux-kernel+bounces-782706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A842EB323E9
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 23:05:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F5CD5A2646
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 21:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40CBA2EBB98;
	Fri, 22 Aug 2025 21:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="Y363eFEA"
Received: from relay10.grserver.gr (relay10.grserver.gr [37.27.248.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD34C2C158F;
	Fri, 22 Aug 2025 21:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.27.248.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755896717; cv=none; b=neXfp2IgDFngTQTTimSUkYMuT/vnfEg72CLMA4S/WM90OJ6mEpW/fGiZRPxMg49/A1oIRTUv3DAfyyz12/o3H4u3yOjLyiYY8epA1GCRZEz9XTZYvZAR/kEJPk5qLCfhpM4xLpHSwCIOUpmfXePyoj8dA4PEXgskN375fDUxNX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755896717; c=relaxed/simple;
	bh=6PQFtKI1g/lL+40qzTZpKrgz+YLHCRwVEDJhMDxqrTk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q/9m7g8q4G7dCTd6w+YYfbWBCgMLfRVXWqNg2gB+BIUZ1CK7fqD2CluMqUdlCc2MsT2wttQSkuaxow/wDWvebNmf5TI6YeL+8Bu8asuw7jMfATkuwR4m1xN9obJsSsXOpTDi45+gZ4vk3f5Drm+6CmnfqTxFxEvBsxRsx5L4DFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=temperror (0-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=Y363eFEA; arc=none smtp.client-ip=37.27.248.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from relay10 (localhost.localdomain [127.0.0.1])
	by relay10.grserver.gr (Proxmox) with ESMTP id 8D2B83EA2D;
	Sat, 23 Aug 2025 00:05:07 +0300 (EEST)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by relay10.grserver.gr (Proxmox) with ESMTPS id 323D63EA39;
	Sat, 23 Aug 2025 00:05:06 +0300 (EEST)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	by linux3247.grserver.gr (Postfix) with ESMTPSA id 885AC206EA8;
	Sat, 23 Aug 2025 00:05:05 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1755896705;
	bh=t/MzG5yIvZw4swhp/S2NE0YLrpBZeIQibfjH5sdD+OQ=;
	h=Received:From:Subject:To;
	b=Y363eFEAlZHtcyNlZqUoRCWETjzmRCp+SQdHKVYgCrJA2dQza4Pbr4+juhJH3EBBT
	 yUx384NbMqVI30avLLVy9k+GAhG4Q2Nz3JOReKqnk1UjpfUYlyOF8s02Wwl6m26LRQ
	 joUryoL6oAVCNeMqFUmDl7Nwc4xvkSR+C1WOa0qAW9xfak8LCJaKJYFofpOEQiRyZq
	 gfWhRtPscFJbckoMPFykEjJQjgjffUu4FxK9ybTQLSb9lKUPH55tvsvjKfBKdGur7j
	 FJTCbsLKzwygCovTLMdE4Cof1TuIJHbJyiV4lPK2qiXfc/Pk3c041hUIN9pWlLb7/L
	 9IVmGSpF3U5Bg==
Authentication-Results: linux3247.grserver.gr;
        spf=pass (sender IP is 209.85.208.174) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-lj1-f174.google.com
Received-SPF: pass (linux3247.grserver.gr: connection is authenticated)
Received: by mail-lj1-f174.google.com with SMTP id
 38308e7fff4ca-33652952e2dso10727531fa.1;
        Fri, 22 Aug 2025 14:05:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCU5vcXFmrxwkICk8kN4bDTx9HgDm05/A3wzTsj+c+uZPhUBZ3HoclSmXiPE/wvvai688L6ecFJ/B6MK2w==@vger.kernel.org,
 AJvYcCVX1Be92tLLweFK8pHy82TPqASLRtIgKYjNA/LRayNVSuWME5XD+pmO/I2DE+1MTUxkU2exuP0dEfdhILj8@vger.kernel.org
X-Gm-Message-State: AOJu0YyijKJmy7rEWn61qONYlSn0t6ft2o45v73l4l0AYuP7GaS5UR8h
	n+f+eL7MFrXQPGO1/IyF9OJca5H63/mvUlm62y+P3xt+AILiujTHPTMt+WmgmVnfe1wvxSuzCC9
	7Rv/aIE4ocRNDE6vASS/Uk8LETs50z2s=
X-Google-Smtp-Source: 
 AGHT+IG0SPPnJ2GtHv3TXSHy6J4E3n8S/8NjjQyoQxDqEckNPFMGpFSQgTTGfzSt3SxjqQpjcKYt6DYiE8C5oykBOcU=
X-Received: by 2002:a2e:be0d:0:b0:332:2c2a:63bf with SMTP id
 38308e7fff4ca-33650feee6bmr12879841fa.20.1755896705020; Fri, 22 Aug 2025
 14:05:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250820160628.99678-1-lkml@antheas.dev>
 <20250820160628.99678-4-lkml@antheas.dev>
 <bb62de69-4bf6-480c-8385-c5e69887563f@gmx.de>
In-Reply-To: <bb62de69-4bf6-480c-8385-c5e69887563f@gmx.de>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Fri, 22 Aug 2025 23:04:53 +0200
X-Gmail-Original-Message-ID: 
 <CAGwozwFsuo3tKTUe-Z0deW7XD5RC28UBS8uPuRGg5Qor6sc-Fg@mail.gmail.com>
X-Gm-Features: Ac12FXwMddh4QZlJTs6PM6cp7CIgoeSVnU_Qcjf0xAGPbIkMBonwLaK-Av30ES4
Message-ID: 
 <CAGwozwFsuo3tKTUe-Z0deW7XD5RC28UBS8uPuRGg5Qor6sc-Fg@mail.gmail.com>
Subject: Re: [PATCH v1 3/5] platform/x86: ayaneo-ec: Add charge control
 support
To: Armin Wolf <W_Armin@gmx.de>
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hwmon@vger.kernel.org, Hans de Goede <hansg@kernel.org>,
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Derek John Clark <derekjohn.clark@gmail.com>,
	=?UTF-8?Q?Joaqu=C3=ADn_Ignacio_Aramend=C3=ADa?= <samsagax@gmail.com>,
	Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
X-PPP-Message-ID: 
 <175589670575.2802908.12571860268060693660@linux3247.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 1.4.3 at linux3247.grserver.gr
X-Virus-Status: Clean

On Fri, 22 Aug 2025 at 14:38, Armin Wolf <W_Armin@gmx.de> wrote:
>
> Am 20.08.25 um 18:06 schrieb Antheas Kapenekakis:
>
> > Ayaneo devices support charge inhibition via the EC. This inhibition
> > only works while the device is powered on, and resets between restarts.
> > However, it is maintained across suspend/resume cycles.
>
> Does this include hibernation?

No. S4/S5 reset the state. Can you give a reference for a regmap
implementation? A hibernation hook would be a nice to have. Although I
am not sure how I feel about restoring the fan speed after
hibernation. It seems dangerous.

> Thanks,
> Armin Wolf
>
> > The EC does not support charge threshold control. Instead, userspace
> > software on Windows manually toggles charge inhibition depending on
> > battery level.
> >
> > Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
> > ---
> >   drivers/platform/x86/Kconfig     |   1 +
> >   drivers/platform/x86/ayaneo-ec.c | 111 +++++++++++++++++++++++++++++++
> >   2 files changed, 112 insertions(+)
> >
> > diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
> > index 0a7ca2c78456..c871a722e5ef 100644
> > --- a/drivers/platform/x86/Kconfig
> > +++ b/drivers/platform/x86/Kconfig
> > @@ -308,6 +308,7 @@ config AYANEO_EC
> >       tristate "Ayaneo EC platform control"
> >       depends on X86
> >       depends on ACPI_EC
> > +     depends on ACPI_BATTERY
> >       depends on HWMON
> >       help
> >         Enables support for the platform EC of Ayaneo devices. This
> > diff --git a/drivers/platform/x86/ayaneo-ec.c b/drivers/platform/x86/ayaneo-ec.c
> > index 8b1902706b81..a4bdc6ae7af7 100644
> > --- a/drivers/platform/x86/ayaneo-ec.c
> > +++ b/drivers/platform/x86/ayaneo-ec.c
> > @@ -14,6 +14,7 @@
> >   #include <linux/kernel.h>
> >   #include <linux/module.h>
> >   #include <linux/platform_device.h>
> > +#include <acpi/battery.h>
> >
> >   #define AYANEO_PWM_ENABLE_REG        0x4A
> >   #define AYANEO_PWM_REG               0x4B
> > @@ -22,17 +23,27 @@
> >
> >   #define AYANEO_FAN_REG               0x76
> >
> > +#define EC_CHARGE_CONTROL_BEHAVIOURS                         \
> > +     (BIT(POWER_SUPPLY_CHARGE_BEHAVIOUR_AUTO) |           \
> > +      BIT(POWER_SUPPLY_CHARGE_BEHAVIOUR_INHIBIT_CHARGE))
> > +#define AYANEO_CHARGE_REG            0x1e
> > +#define AYANEO_CHARGE_VAL_AUTO               0xaa
> > +#define AYANEO_CHARGE_VAL_INHIBIT    0x55
> > +
> >   struct ayaneo_ec_quirk {
> >       bool has_fan_control;
> > +     bool has_charge_control;
> >   };
> >
> >   struct ayaneo_ec_platform_data {
> >       struct platform_device *pdev;
> >       struct ayaneo_ec_quirk *quirks;
> > +     struct acpi_battery_hook battery_hook;
> >   };
> >
> >   static const struct ayaneo_ec_quirk ayaneo3 = {
> >       .has_fan_control = true,
> > +     .has_charge_control = true,
> >   };
> >
> >   static const struct dmi_system_id dmi_table[] = {
> > @@ -159,11 +170,102 @@ static const struct hwmon_chip_info ayaneo_ec_chip_info = {
> >       .info = ayaneo_ec_sensors,
> >   };
> >
> > +static int ayaneo_psy_ext_get_prop(struct power_supply *psy,
> > +                             const struct power_supply_ext *ext,
> > +                             void *data,
> > +                             enum power_supply_property psp,
> > +                             union power_supply_propval *val)
> > +{
> > +     int ret;
> > +     u8 tmp;
> > +
> > +     switch (psp) {
> > +     case POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR:
> > +             ret = ec_read(AYANEO_CHARGE_REG, &tmp);
> > +             if (ret)
> > +                     return ret;
> > +
> > +             if (tmp == AYANEO_CHARGE_VAL_INHIBIT)
> > +                     val->intval = POWER_SUPPLY_CHARGE_BEHAVIOUR_INHIBIT_CHARGE;
> > +             else
> > +                     val->intval = POWER_SUPPLY_CHARGE_BEHAVIOUR_AUTO;
> > +             return 0;
> > +     default:
> > +             return -EINVAL;
> > +     }
> > +}
> > +
> > +static int ayaneo_psy_ext_set_prop(struct power_supply *psy,
> > +                             const struct power_supply_ext *ext,
> > +                             void *data,
> > +                             enum power_supply_property psp,
> > +                             const union power_supply_propval *val)
> > +{
> > +     u8 raw_val;
> > +
> > +     switch (psp) {
> > +     case POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR:
> > +             switch (val->intval) {
> > +             case POWER_SUPPLY_CHARGE_BEHAVIOUR_AUTO:
> > +                     raw_val = AYANEO_CHARGE_VAL_AUTO;
> > +                     break;
> > +             case POWER_SUPPLY_CHARGE_BEHAVIOUR_INHIBIT_CHARGE:
> > +                     raw_val = AYANEO_CHARGE_VAL_INHIBIT;
> > +                     break;
> > +             default:
> > +                     return -EINVAL;
> > +             }
> > +             return ec_write(AYANEO_CHARGE_REG, raw_val);
> > +     default:
> > +             return -EINVAL;
> > +     }
> > +}
> > +
> > +static int ayaneo_psy_prop_is_writeable(struct power_supply *psy,
> > +                                  const struct power_supply_ext *ext,
> > +                                  void *data,
> > +                                  enum power_supply_property psp)
> > +{
> > +     return true;
> > +}
> > +
> > +static const enum power_supply_property ayaneo_psy_ext_props[] = {
> > +     POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR,
> > +};
> > +
> > +static const struct power_supply_ext ayaneo_psy_ext = {
> > +     .name                   = "ayaneo-charge-control",
> > +     .properties             = ayaneo_psy_ext_props,
> > +     .num_properties         = ARRAY_SIZE(ayaneo_psy_ext_props),
> > +     .charge_behaviours      = EC_CHARGE_CONTROL_BEHAVIOURS,
> > +     .get_property           = ayaneo_psy_ext_get_prop,
> > +     .set_property           = ayaneo_psy_ext_set_prop,
> > +     .property_is_writeable  = ayaneo_psy_prop_is_writeable,
> > +};
> > +
> > +static int ayaneo_add_battery(struct power_supply *battery,
> > +                        struct acpi_battery_hook *hook)
> > +{
> > +     struct ayaneo_ec_platform_data *data =
> > +             container_of(hook, struct ayaneo_ec_platform_data, battery_hook);
> > +
> > +     return power_supply_register_extension(battery, &ayaneo_psy_ext,
> > +                                            &data->pdev->dev, NULL);
> > +}
> > +
> > +static int ayaneo_remove_battery(struct power_supply *battery,
> > +                           struct acpi_battery_hook *hook)
> > +{
> > +     power_supply_unregister_extension(battery, &ayaneo_psy_ext);
> > +     return 0;
> > +}
> > +
> >   static int ayaneo_ec_probe(struct platform_device *pdev)
> >   {
> >       const struct dmi_system_id *dmi_entry;
> >       struct ayaneo_ec_platform_data *data;
> >       struct device *hwdev;
> > +     int ret;
> >
> >       dmi_entry = dmi_first_match(dmi_table);
> >       if (!dmi_entry)
> > @@ -184,6 +286,15 @@ static int ayaneo_ec_probe(struct platform_device *pdev)
> >                       return PTR_ERR(hwdev);
> >       }
> >
> > +     if (data->quirks->has_charge_control) {
> > +             data->battery_hook.add_battery = ayaneo_add_battery;
> > +             data->battery_hook.remove_battery = ayaneo_remove_battery;
> > +             data->battery_hook.name = "Ayaneo Battery";
> > +             ret = devm_battery_hook_register(&pdev->dev, &data->battery_hook);
> > +             if (ret)
> > +                     return ret;
> > +     }
> > +
> >       return 0;
> >   }
> >
>


