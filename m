Return-Path: <linux-kernel+bounces-813797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B826B54AD0
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 13:16:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 142EF683543
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 11:16:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2B5D3009E8;
	Fri, 12 Sep 2025 11:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CHQnELay"
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE362EB5BD
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 11:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757675795; cv=none; b=ZFDJc1bcv4NO1w3sSkx0l73wF+tQW886z30UOs4n4huMGYWmCBMAckPJlLB2JY/CEi6lHcRMczyrlCeIXYa76k8e7XHZLohUlQm3nXmUUDRU8nLjVWjZomkUR45J+Xd1QKB/rjTykt+8OHLnfT4QASpFqPAZBwhvIg2er58axoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757675795; c=relaxed/simple;
	bh=pS2ACXCvk66dWOzSh2+WcS1GHKgHXyHyhM1OWcHLpkw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gNg82ZTSXy9BDCTcxal2a5nriCOOGOthlqxWUYOwmPQxgRG9niTvGcWrKUJJXAJdRav4+IpjufAEfDT1/eh+RtklaEycR6OPS2Xk4BKNzooqEJwB1gi/RhJ2U8yIoIeQ6UwydVz7+m/7p/ydRLFJhEb9UZLV7Q2lWtJURMo+l/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CHQnELay; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-74526ca7d64so1759816a34.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 04:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757675791; x=1758280591; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s9raa4UnWp7S98pmKgOEBKVBBsQu0EJl6gJVzoGdYgQ=;
        b=CHQnELaytbomx29pg30RljJeItXpI3oXPRKeRVdEEj18mR2GY8MaQIXu4Ub8KB3X3S
         M8QPkyHaeaHaTpRzu00Xp3VawWZAxoGykXbT/AGvIh3q3JX+W21ATw7sREVlcfeLTF1c
         aSqTWpCYZLV/cR0HGR9Dh+Dd9U/44jBTixkmPmNpmw+3u76IVYCsijLjaDompkGb2Rbf
         q6BG+PRg7O1yT4OuGra4sQuNsAf7easyLwfmbHm3x02YyJ0ybpdj8Vn6jJAvDklHU53W
         mi0lpiCcnUSFUt4+LBfrqlv2qNWCSVNpxhBdGwzC7c057mM3T/vD+POTJo65IZCdonz8
         CbSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757675791; x=1758280591;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s9raa4UnWp7S98pmKgOEBKVBBsQu0EJl6gJVzoGdYgQ=;
        b=U1raJV7UsfjHuQhLLxwgD/vEtX7dBNtJXaPAtve7xROiOxhedXWcxJgkpGRJOswxpM
         ys0QP9e/zGle4NYje4/cgSaNAK87uAMyqW3YgXUaVrW51ZX//HQutMUO2uWhe9kGRBb+
         lFHXYHoOw5aA2cfrUnIV34ipHGNPeDa0qiNiC5ocaBWey/ChfNFM7tjJGvEYC7DdW4Wj
         x/6VGgaIX/UkwhIDOkd36oRV1G2QiCTUmVKc6hK+I3wOCmPoRw3/HQueFhq9hx76PLTn
         xgML9uh+ryYr+xDxOYdv6nHKbL2741FUa48h+gsuYoZMpnSzwqugUJBwHlBW8UA67eig
         r/gQ==
X-Forwarded-Encrypted: i=1; AJvYcCXJ+MLxHO3rcvobOZqxYWbNNLeM82EWSB9cP4zQ/m5Hqqk95sVoMr1iIuU4tZ4f2LeGSrDl39OP9z7oWy8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHZbHxsoGPsSee7INdCs8M5jI5AwISF0N5nO2YirLThL68FSna
	mkfuZdSkLjoLMQjhmgM7zEroWsI5ohqVWxZ/o4v5RWnp2eYbWNLWnaC0ysxT7i4jUJCF4wvTAq5
	VGQYzZf867i8McGIz1WEGCROadOrNLCqyqOH35Tf80A==
X-Gm-Gg: ASbGncuVNWXJ95ao6CBZOQe+emWI1zltxu9W3zAKe0d0CrWwJIvHD4DHV9mvBlnImUj
	bK2soxngbIIObIXPlJH0yOCqQ5zu0J+JTVY9/wxj07LJV7S3HFyuKSyJmcv2vhSKmjWK6RcIlgr
	h57Ss1ZuuQScLMbp8ym5L83jCEOcQ+BZ7nFnFDzXFAREqV5PysIG19JOtved5bJ8cqGObo1WMLy
	9SP5WWOJgdQT1Cpz3aI2NCLPawP
X-Google-Smtp-Source: AGHT+IF+6KDhxF/Nv9wIPe93Lse4duQguZZlNPVnH8YGAzn5f8KKXL2caupjcfX/resj9T72psSu60bapr4zRsCqOX4=
X-Received: by 2002:a05:6808:1a1e:b0:439:40ed:1927 with SMTP id
 5614622812f47-43b8da9120amr1190971b6e.51.1757675790664; Fri, 12 Sep 2025
 04:16:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250804-b4-gs101_max77759_fg-v5-0-03a40e6c0e3d@uclouvain.be> <20250804-b4-gs101_max77759_fg-v5-1-03a40e6c0e3d@uclouvain.be>
In-Reply-To: <20250804-b4-gs101_max77759_fg-v5-1-03a40e6c0e3d@uclouvain.be>
From: Peter Griffin <peter.griffin@linaro.org>
Date: Fri, 12 Sep 2025 12:16:19 +0100
X-Gm-Features: Ac12FXyOFnYMp2b4OuaR1npoXk0x3GKafYhZlOCgGWPVm0PFMJpZl8toEpgiLuo
Message-ID: <CADrjBPqe6JsT_yKTazRn-Ro2V4ZHQ1=6LX304CyVxgzLBqXrew@mail.gmail.com>
Subject: Re: [PATCH v5 1/4] power: supply: add support for MAX77759 fuel gauge
To: t.antoine@uclouvain.be
Cc: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Dimitri Fedrau <dima.fedrau@gmail.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
	Tudor Ambarus <tudor.ambarus@linaro.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Thomas,

Thanks for your patch, and working on this!

On Mon, 4 Aug 2025 at 15:25, Thomas Antoine via B4 Relay
<devnull+t.antoine.uclouvain.be@kernel.org> wrote:
>
> From: Thomas Antoine <t.antoine@uclouvain.be>
>
> The Maxim MAX77759 is a PMIC used in gs101-oriole and gs101-raven
> (Google Pixel 6 and 6 Pro). It contains a fuel gauge on a separate
> I2C address. Add basic support for this fuel gauge. The driver is
> based on the driver for the MAX17201 and MAX17205 which also use
> the MAX M5 fuel gauge. There is a lot of common between the two

small nit: "in common"                             ^^^^^^

> devices with some key differences. The main one is the lack of nvmem
> in the fuel gauge of the MAX77759.
>
> The initialization of the chip is very basic and mostly hardcoded.
> Loading the model of the fuel gauge is not implemented here.
>
> On both gs101-oriole and gs101-raven, the same EEPROM as for the
> battery id is used to backup some of the state of the fuel gauge.
> Use a standard nvmem binding to access this data. The CRC8 is
> computed to allow to go from linux to a stock android without
> apparent data corruption. If other devices using the MAX77759 are
> found/created, a similar nvmem layout should be made or the driver
> should be extended to support those devices.
>
> The current, capacity, temperature and charge have all been tested.
> The charge full design and capacity equal the ones seen on android,
> the ratio between average charge and average current does predict
> pretty accurately the time to empty under a constant workload and
> temperature is coherent with the dynamic state of the device.
>
> Health is not enabled as it always reports overheating. The time to
> empty is wrong by about a factor 2. The voltage reporting is
> correct when using VCELL (which reports the lowest voltage of all
> cells) when considering that the device is connected to a single
> cell. It could be enabled by either confirming that the device is
> connected to a single cell or finding an alternative reporting mean.
>
> Modifications have been made to it since but the regmap was
> originally proposed by Andr=C3=A9 Draszik in
>
> Link: https://lore.kernel.org/all/d1bade77b5281c1de6b2ddcb4dbbd033e455a11=
6.camel@linaro.org/
>
> Signed-off-by: Thomas Antoine <t.antoine@uclouvain.be>
> ---
>  drivers/power/supply/Kconfig            |  14 +
>  drivers/power/supply/Makefile           |   1 +
>  drivers/power/supply/max77759_battery.c | 649 ++++++++++++++++++++++++++=
++++++
>  3 files changed, 664 insertions(+)
>
> diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
> index 79ddb006e2dad6bf96b71ed570a37c006b5f9433..147d049b836c3fbb24b762dba=
f31eebb8ba041f7 100644
> --- a/drivers/power/supply/Kconfig
> +++ b/drivers/power/supply/Kconfig
> @@ -458,6 +458,20 @@ config BATTERY_MAX1721X
>           Say Y here to enable support for the MAX17211/MAX17215 standalo=
ne
>           battery gas-gauge.
>
> +config BATTERY_MAX77759
> +       tristate "Maxim Integrated MAX77759 Fuel Gauge"
> +       depends on I2C
> +       select REGMAP_I2C
> +       help
> +         Say yes to enable support for the Fuel gauge of the Maxim Integ=
rated
> +         MAX77759. It is a companion Power Management IC for USB Type-C
> +         applications with Battery Charger, Fuel Gauge, temperature sens=
ors,
> +         USB Type-C Port Controller (TCPC), NVMEM, and additional GPIO
> +         interfaces.
> +
> +         To compile this driver as module, choose M here: the
> +         module will be called max77759_fg.
> +
>  config BATTERY_TWL4030_MADC
>         tristate "TWL4030 MADC battery driver"
>         depends on TWL4030_MADC
> diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefil=
e
> index 4f5f8e3507f80da02812f0d08c2d81ddff0a272f..114578fa4fd08356822f13ce1=
fbad29923defad8 100644
> --- a/drivers/power/supply/Makefile
> +++ b/drivers/power/supply/Makefile
> @@ -57,6 +57,7 @@ obj-$(CONFIG_BATTERY_MAX17040)        +=3D max17040_bat=
tery.o
>  obj-$(CONFIG_BATTERY_MAX17042) +=3D max17042_battery.o
>  obj-$(CONFIG_BATTERY_MAX1720X) +=3D max1720x_battery.o
>  obj-$(CONFIG_BATTERY_MAX1721X) +=3D max1721x_battery.o
> +obj-$(CONFIG_BATTERY_MAX77759) +=3D max77759_battery.o
>  obj-$(CONFIG_BATTERY_RT5033)   +=3D rt5033_battery.o
>  obj-$(CONFIG_CHARGER_RT5033)   +=3D rt5033_charger.o
>  obj-$(CONFIG_CHARGER_RT9455)   +=3D rt9455_charger.o
> diff --git a/drivers/power/supply/max77759_battery.c b/drivers/power/supp=
ly/max77759_battery.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..d8d702af607211e391733cd14=
323698b54be734c
> --- /dev/null
> +++ b/drivers/power/supply/max77759_battery.c
> @@ -0,0 +1,649 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Fuel gauge driver for Maxim 777759
> + *
> + * based on max1720x_battery.c
> + *
> + * Copyright (C) 2024 Liebherr-Electronics and Drives GmbH
> + */
> +

[..]

> +       switch (psp) {
> +       case POWER_SUPPLY_PROP_PRESENT:
> +               /*
> +                * POWER_SUPPLY_PROP_PRESENT will always readable via
> +                * sysfs interface. Value return 0 if battery not
> +                * present or unaccesable via I2c.

small nit: inaccessible      ^^^^^^

> +                */
> +               ret =3D regmap_read(info->regmap, MAX77759_FG_STATUS, &re=
g_val);
> +               if (ret < 0) {
> +                       val->intval =3D 0;
> +                       return 0;
> +               }
> +
> +               val->intval =3D !FIELD_GET(MAX77759_FG_STATUS_BAT_ABSENT,=
 reg_val);
> +               break;
> +       case POWER_SUPPLY_PROP_CAPACITY:
> +               ret =3D regmap_read(info->regmap, MAX77759_FG_REPSOC, &re=
g_val);
> +               val->intval =3D max77759_fg_percent_to_ps(reg_val);
> +               break;
> +       case POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN:
> +               ret =3D regmap_read(info->regmap, MAX77759_FG_DESIGN_CAP,=
 &reg_val);
> +               if (ret < 0)
> +                       return ret;
> +
> +               val->intval =3D max77759_fg_capacity_to_ps(reg_val, info)=
;
> +               ret =3D max77759_fg_capacity_lsb(info, &reg_val);
> +               val->intval *=3D reg_val;
> +               break;
> +       case POWER_SUPPLY_PROP_CHARGE_AVG:
> +               ret =3D regmap_read(info->regmap, MAX77759_FG_REPCAP, &re=
g_val);
> +               if (ret < 0)
> +                       return ret;
> +
> +               val->intval =3D max77759_fg_capacity_to_ps(reg_val, info)=
;
> +               ret =3D max77759_fg_capacity_lsb(info, &reg_val);
> +               val->intval *=3D reg_val;
> +               break;
> +       case POWER_SUPPLY_PROP_TEMP:
> +               ret =3D regmap_read(info->regmap, MAX77759_FG_TEMP, &reg_=
val);
> +               val->intval =3D max77759_fg_temperature_to_ps(reg_val);
> +               break;
> +       case POWER_SUPPLY_PROP_CURRENT_NOW:
> +               ret =3D regmap_read(info->regmap, MAX77759_FG_CURRENT, &r=
eg_val);
> +               val->intval =3D max77759_fg_current_to_voltage(reg_val) /=
 info->rsense;
> +               break;
> +       case POWER_SUPPLY_PROP_CURRENT_AVG:
> +               ret =3D regmap_read(info->regmap, MAX77759_FG_AVG_CURRENT=
, &reg_val);
> +               val->intval =3D max77759_fg_current_to_voltage(reg_val) /=
 info->rsense;
> +               break;
> +       case POWER_SUPPLY_PROP_CHARGE_FULL:
> +               ret =3D regmap_read(info->regmap, MAX77759_FG_FULL_CAP, &=
reg_val);
> +               if (ret < 0)
> +                       return ret;
> +
> +               val->intval =3D max77759_fg_capacity_to_ps(reg_val, info)=
;
> +               ret =3D max77759_fg_capacity_lsb(info, &reg_val);
> +               val->intval *=3D reg_val;
> +               break;
> +       case POWER_SUPPLY_PROP_MODEL_NAME:
> +               ret =3D regmap_read(info->regmap, MAX77759_FG_DEV_NAME, &=
reg_val);
> +               if (ret < 0)
> +                       return ret;
> +
> +               reg_val =3D FIELD_GET(MAX77759_FG_DEV_NAME_TYPE_MASK, reg=
_val);
> +               if (reg_val =3D=3D MAX77759_FG_DEV_NAME_TYPE)
> +                       val->strval =3D max77759_fg_model;
> +               else
> +                       return -ENODEV;
> +               break;
> +       case POWER_SUPPLY_PROP_MANUFACTURER:
> +               val->strval =3D max77759_fg_manufacturer;
> +               break;
> +       default:
> +               return -EINVAL;
> +       }
> +
> +       return ret;
> +}
> +
> +static int max77759_fg_init(struct device *dev,
> +                           struct max77759_fg_device_info *info,
> +                           struct power_supply *bat_psy)
> +{
> +       struct max77759_fg_state_save *state;
> +       struct power_supply_battery_info *bat_info;
> +       struct nvmem_cell *cell;
> +       unsigned int val;
> +       int ret;
> +       size_t len;
> +
> +       power_supply_get_battery_info(bat_psy, &bat_info);

Should check the return code here and exit if not present as if the
battery info is missing in DT it will crash in max77759_fg_init().

With that addressed:
Reviewed-by: Peter Griffin <peter.griffin@linaro.org>

I think there was also some feedback from Krysztof on the binding, but
aside from that I think Sebastian was ready to queue this.

regards,

Peter

