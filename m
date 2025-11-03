Return-Path: <linux-kernel+bounces-882207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 337FBC29E16
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 03:46:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C74453B13E4
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 02:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BB2D281368;
	Mon,  3 Nov 2025 02:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f4tx302o"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF4E1EACD
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 02:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762137956; cv=none; b=N0OieGZlDwiNTDWvkte8Q6LbSbemSRvTXPrMB+5I7DdKhL2PkIhby6O+CSUt/99C782hgBWnqFqYcYaNbu4hh4hj7gWrmBV9JOMRHHCNmsOY4szrFqlcn/PXrenwfmPbtnXF9MIx1wyx9Ah96NNuFR82OQnnHkecPRbl3AjdQ3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762137956; c=relaxed/simple;
	bh=ze3xsjCCJS9puWJNrWNrf2YFSxZiwdtxv0b9JdmGvjk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=byD1msENynDQIyLSN+1UgsaOlTx+6izVYBTuMpqtKzuQFX1zZm//LnEQ6ek5lsARfW7vn5iUEvkHYcu5aeUyIcpBq5WaO1RPwW71SjsHys/uA9+f3e9ojkFdBeZkj5v5cPbOx3KJy1TMjCIA2S039Hnho5I0DWSeHrMax/GdRD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f4tx302o; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-29524c38f4fso31671225ad.2
        for <linux-kernel@vger.kernel.org>; Sun, 02 Nov 2025 18:45:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762137952; x=1762742752; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=omTEbiSFxXslMTU+E/m37CrkMbUjogQ1Vxn2arunudQ=;
        b=f4tx302oue3mIHpZUK5Xa/Rx1FycZxjanOkL5MMWT3oeJTrg+TCKYATPFo7idEMDX+
         957d4u/U1fZMdkHZ8FypwOYQgmlI47eLlcCxm3jQ9jdGdqnWHUXVpeqtH+/yi94H5FAv
         CSOatdaavEXCvtjmvmUt9X+OzhBIgkmfYKzUhM1GdZbnjMUb7Yap8QbvUPAaL5jFWMgW
         AhJomclTwLYOu3mXYs1YEyqKOA6AgsfW71Im0U6FWRZSf5CVR4G05w06gOG3FT66mGlN
         FVs83YcT31tZKBSPi1mfKbrpXKutIHdgMpYcAOR7Sf5yzkAuU01H25Njdv+4DVIVpMgF
         RiAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762137952; x=1762742752;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=omTEbiSFxXslMTU+E/m37CrkMbUjogQ1Vxn2arunudQ=;
        b=FeSRDEBnjM44VsJGfbxfCMaGiPkvYZQyi0iVrXPdFIactYZgLUAAu2ukHwGZvhaD02
         C2k0+Tg6IEqWOulwKKQz9xji5HRuW8IRWewMdjoRJsLkJqUrD/tDr0ihdq7w2g0vYZje
         3eteOGpWs+Hs3EuiKY7krdJvURGIGjZZw8Kv1VcpHI10YLYx2EjiKkGr5A6eu2n3uGc+
         T9GxqTKu1rwFLW3yWhcLQ8TneFTEqqsxXh2MsjnYAJpaqZmQG6tkhLOPvPBlrfxrlPY6
         X5ltXBkGN/U4eZwTo5CBvDlNk7++L5GsAPWvzJjZVc1gcts8CX6NoLFFc5kElTbduy8e
         1hcA==
X-Forwarded-Encrypted: i=1; AJvYcCUBCajZmYNFvBt5TvK3LBm6Q6v5Mo4zG31mV5jb1iKzGa4PCL6DzVShvvHC4hzRkSP7Q/iKT4rexwqqKjc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfuJ9u9dM4kzl8aM6kIhzBvrq7FMl2VL6KQ5HcwKUHhf6bF8JK
	N0dL5ujgxzrSdA7+0Lr3mvIvMeYCIt8D8STN0SELf124cKAgpa2drSlZ
X-Gm-Gg: ASbGncv7g43Eus+OIm57TyQ1DEMShBW0e/5tWKZLmVwfRG65Mg+egjmZHv14e6zVjk4
	WhR4pZIMCiKmaLTtJJTFS/dRqjSDmaJy59UwAjI6+cttVGLVq7zoQaz4pxDvnrHNYISlaF4+xSI
	bHBDZnLWzlNGo6x35+ZiuAT2AAOodYPi6sprOh4nv9UEKnTKDdBgzSvOURLPmO3iM9hsdokng8v
	4ByIWcLvPv2d0EdtH6x7f2LQlQZOPSXtWEIDAsYDnnN4plJZLxmskVY6pVv9H/uUV7v91yyAWfr
	puh3rIF7U75bU9eD8KcEYL+q2st4PxVkzs6q9LcBOg9mG+65kFC8iXRxgbOLA/Ri1SW5jXIRj65
	mEJm3brebqWxf7a5nWX6OYKxkyEHQnABF73y6P018cqD3hGS4WeEaPDZHNIY3qeHUiGOXWlao7l
	HjqXzY1hsB2KS21JCB8uVHdAU3d6m0kU0eZ3ItqQ834gXVhz5iDg==
X-Google-Smtp-Source: AGHT+IHG9Df4sw77NGMLmyAPyEpZKytCcfjQRB4VU1g0t6dvwv9yzIQ08bojaZq/jmaesTSuJVkHEw==
X-Received: by 2002:a17:903:24f:b0:295:24c3:8b49 with SMTP id d9443c01a7336-29524c38fcdmr134036945ad.46.1762137951930;
        Sun, 02 Nov 2025 18:45:51 -0800 (PST)
Received: from HYB-iPCgmhaB8Cy.ad.analog.com ([59.9.235.253])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b93be5ed9e6sm8604521a12.27.2025.11.02.18.45.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Nov 2025 18:45:51 -0800 (PST)
Date: Mon, 3 Nov 2025 11:45:44 +0900
From: Joan Na <joan.na.devcode@gmail.com>
To: Nuno =?iso-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, Joan Na <joan.na@analog.com>
Subject: Re: [PATCH v5 2/2] regulator: max77675: Add MAX77675 regulator driver
Message-ID: <aQgXWGzUW720mH+P@HYB-iPCgmhaB8Cy.ad.analog.com>
References: <20251029023253.150257-1-joan.na@analog.com>
 <20251029023253.150257-3-joan.na@analog.com>
 <3a9441f01e82dfcbdf146a809ba4a6f9604c63d7.camel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3a9441f01e82dfcbdf146a809ba4a6f9604c63d7.camel@gmail.com>

On Wed, Oct 29, 2025 at 09:55:53AM +0000, Nuno Sá wrote:
> On Wed, 2025-10-29 at 11:32 +0900, Joan-Na-adi wrote:
> > From: Joan Na <joan.na@analog.com>
> > 
> > Add support for the Maxim Integrated MAX77675 PMIC regulator.
> > 
> > The MAX77675 is a compact, highly efficient SIMO (Single Inductor Multiple Output)
> > power management IC that provides four programmable buck-boost switching regulators
> > with only one inductor. It supports up to 700mA total output current and operates
> > from a single-cell Li-ion battery.
> > 
> > An integrated power-up sequencer and I2C interface allow flexible startup
> > configuration and runtime control.
> > 
> > Signed-off-by: Joan Na <joan.na@analog.com>
> > ---
> 
> Hi Joan,
> 
> Some comments from me... 
> 

Hello Nuno,

Thank you for taking the time to review.
Please refer to my response below.

> >  drivers/regulator/Kconfig              |   9 +
> >  drivers/regulator/Makefile             |   1 +
> >  drivers/regulator/max77675-regulator.c | 861 +++++++++++++++++++++++++
> >  drivers/regulator/max77675-regulator.h | 260 ++++++++
> >  4 files changed, 1131 insertions(+)
> >  create mode 100644 drivers/regulator/max77675-regulator.c
> >  create mode 100644 drivers/regulator/max77675-regulator.h
> > 
> > diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
> > index d84f3d054c59..93131446e402 100644
> > --- a/drivers/regulator/Kconfig
> > +++ b/drivers/regulator/Kconfig
> > @@ -649,6 +649,15 @@ config REGULATOR_MAX77650
> >  	  Semiconductor. This device has a SIMO with three independent
> >  	  power rails and an LDO.
> > 
> > +config REGULATOR_MAX77675
> > +	tristate "Maxim MAX77675 regulator driver"
> > +	depends on I2C
> 
> Looking at your code, I would expected OF to be a dependency as well.
>

I’ll add OF as a dependency

> > +	select REGMAP_I2C
> > +	help
> > +	  This driver controls the Maxim MAX77675 power regulator via I2C.
> > +	  It supports four programmable buck-boost outputs.
> > +	  Say Y here to enable the regulator driver
> > +
> >  config REGULATOR_MAX77857
> >  	tristate "ADI MAX77857/MAX77831 regulator support"
> >  	depends on I2C
> > diff --git a/drivers/regulator/Makefile b/drivers/regulator/Makefile
> > index b3101376029d..cdd99669cd24 100644
> > --- a/drivers/regulator/Makefile
> > +++ b/drivers/regulator/Makefile
> > @@ -78,6 +78,7 @@ obj-$(CONFIG_REGULATOR_MAX77503) += max77503-regulator.o
> >  obj-$(CONFIG_REGULATOR_MAX77541) += max77541-regulator.o
> >  obj-$(CONFIG_REGULATOR_MAX77620) += max77620-regulator.o
> >  obj-$(CONFIG_REGULATOR_MAX77650) += max77650-regulator.o
> > +obj-$(CONFIG_REGULATOR_MAX77675) += max77675-regulator.o
> >  obj-$(CONFIG_REGULATOR_MAX8649)	+= max8649.o
> >  obj-$(CONFIG_REGULATOR_MAX8660) += max8660.o
> >  obj-$(CONFIG_REGULATOR_MAX8893) += max8893.o
> > diff --git a/drivers/regulator/max77675-regulator.c b/drivers/regulator/max77675-regulator.c
> > new file mode 100644
> > index 000000000000..c1281f07fe43
> > --- /dev/null
> > +++ b/drivers/regulator/max77675-regulator.c
> > @@ -0,0 +1,861 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +/*
> > + * Copyright (c) 2025 Analog Devices, Inc.
> > + * ADI regulator driver for MAX77675.
> > + */
> > +
> > +#include <linux/module.h>
> > +#include <linux/slab.h>
> > +#include <linux/of.h>
> > +#include <linux/i2c.h>
> > +#include <linux/regmap.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/regulator/driver.h>
> > +#include <linux/regulator/consumer.h>
> > +#include <linux/regulator/of_regulator.h>
> > +#include <linux/bitfield.h>
> 
> You're clearly missing (at least) mod_devicetable.h. I know that at least clang allows you to get
> iwyu,
>

I will add it.

> > +
> > +#include "max77675-regulator.h"
> 
> Why do we need the header file? Just include everything in the source code unless you expect to
> share something with another module (which I dunno)?
> 

I will remove the header file as suggested

> > +
> > +struct max77675_regulator_pdata {
> > +	u8   fps_slot;
> > +	bool fixed_slew_rate;
> > +};
> > +
> 
> I would get rid of the _pdata suffix. Implies some legacy way of doing things (but kind of a
> nitpick)
>

I will rename it to max77675_regulator_sbb_setting.

> > +struct max77675_config {
> > +	u8   en_mode;
> > +	u8   voltage_change_latency;
> > +	u8   drv_sbb_strength;
> > +	u8   dvs_slew_rate;
> > +	u8   debounce_time;
> > +	u8   manual_reset_time;
> > +	bool en_pullup_disable;
> > +	bool bias_low_power_request;
> > +	bool simo_int_ldo_always_on;
> > +};
> > +
> > +struct max77675_regulator {
> > +	struct device *dev;
> > +	struct regmap *regmap;
> > +	struct max77675_config config;
> > +	struct max77675_regulator_pdata pdata[MAX77675_ID_NUM_MAX];
> > +};
> > +
> > +/**
> > + * Set latency mode.
> > + *
> > + * @param maxreg Pointer to max77675 device structure.
> > + * @param enable true to enable latency mode, false to disable.
> > + */
> > +static int max77675_set_latency_mode(struct max77675_regulator *maxreg, bool enable)
> > +{
> > +	return regmap_update_bits(maxreg->regmap, MAX77675_REG_CNFG_SBB_TOP_B,
> > +				  MAX77675_LAT_MODE_BIT,
> > +				  FIELD_PREP(MAX77675_LAT_MODE_BIT, enable));
> > +}
> > +
> 
> I would drop these one liner wrappers. Personally, I don't see a big benefit on it.
> 

I agree with your point and will remove these one-liner wrappers as suggested

> > +/**
> > + * Set DVS slew rate mode.
> > + *
> > + * @param maxreg Pointer to max77675 device structure.
> > + * @param enable true to use DVS-controlled slew rate, false for fixed 2mV/us.
> > + */
> > +static int max77675_set_dvs_slew_rate(struct max77675_regulator *maxreg, bool enable)
> > +{
> > +	return regmap_update_bits(maxreg->regmap, MAX77675_REG_CNFG_SBB_TOP_B,
> > +				  MAX77675_DVS_SLEW_BIT,
> > +				  FIELD_PREP(MAX77675_DVS_SLEW_BIT, enable));
> > +}
> > +
> 
> Ditto for all other places.
> 
> ...
> 
> > 
> > +
> > +/**
> > + * Set debounce time for EN pin.
> > + *
> > + * @param maxreg Pointer to max77675 device structure.
> > + * @param debounce_30ms true for 30ms, false for 100us
> > + */
> > +static int max77675_set_debounce_time(struct max77675_regulator *maxreg, bool debounce_30ms)
> > +{
> > +	return regmap_update_bits(maxreg->regmap, MAX77675_REG_CNFG_GLBL_A,
> > +				  MAX77675_DBEN_EN_BIT,
> > +				  FIELD_PREP(MAX77675_DBEN_EN_BIT, debounce_30ms));
> > +}
> > +
> > +static int max77675_regulator_get_fps_src(struct max77675_regulator *maxreg, int id)
> > +{
> > +	unsigned int reg_addr;
> > +	unsigned int val;
> > +	int ret;
> > +
> > +	switch (id) {
> > +	case MAX77675_ID_SBB0:
> > +		reg_addr = MAX77675_REG_CNFG_SBB0_B;
> > +		break;
> > +	case MAX77675_ID_SBB1:
> > +		reg_addr = MAX77675_REG_CNFG_SBB1_B;
> > +		break;
> > +	case MAX77675_ID_SBB2:
> > +		reg_addr = MAX77675_REG_CNFG_SBB2_B;
> > +		break;
> > +	case MAX77675_ID_SBB3:
> > +		reg_addr = MAX77675_REG_CNFG_SBB3_B;
> > +		break;
> > +	default:
> > +		dev_err(maxreg->dev, "Invalid regulator id: %d\n", id);
> > +		return -EINVAL;
> > +	}
> > +
> > +	ret = regmap_read(maxreg->regmap, reg_addr, &val);
> > +	if (ret < 0) {
> > +		dev_err(maxreg->dev, "Failed to read FPS source (reg 0x%02x): %d\n",
> > +			reg_addr, ret);
> > +		return ret;
> > +	}
> > +
> > +	return val & MAX77675_EN_SBB_MASK;
> 
> Ok, this works since the mask is 0x7. However, FIELD_GET() would make it more
> readable and easy to review. I mean, I would not need to go and see the mask value.
> 

I will change it to "return FIELD_GET(MAX77675_EN_SBB_MASK, val)"

> > +}
> > +
> > +static int max77675_regulator_set_fps_src(struct max77675_regulator *maxreg, int id, u8 fps_src)
> > +{
> > +	unsigned int reg_addr;
> > +	int ret;
> > +
> > +	switch (id) {
> > +	case MAX77675_ID_SBB0:
> > +		reg_addr = MAX77675_REG_CNFG_SBB0_B;
> > +		break;
> > +	case MAX77675_ID_SBB1:
> > +		reg_addr = MAX77675_REG_CNFG_SBB1_B;
> > +		break;
> > +	case MAX77675_ID_SBB2:
> > +		reg_addr = MAX77675_REG_CNFG_SBB2_B;
> > +		break;
> > +	case MAX77675_ID_SBB3:
> > +		reg_addr = MAX77675_REG_CNFG_SBB3_B;
> > +		break;
> > +	default:
> > +		dev_err(maxreg->dev, "Invalid regulator id: %d\n", id);
> > +		return -EINVAL;
> > +	}
> > +
> > +	ret = regmap_update_bits(maxreg->regmap, reg_addr,
> > +				 MAX77675_EN_SBB_MASK, fps_src);
> > +	if (ret < 0) {
> > +		dev_err(maxreg->dev, "Failed to set FPS source (reg 0x%02x): %d\n",
> > +			reg_addr, ret);
> > +		return ret;
> > +	}
> 
> I would drop the log and just do return regmap_update_bits(). Up to you...
> 

I will change it

> > +
> > +	return 0;
> > +}
> > +
> > +/**
> > + * max77675_set_sbb_slew_rate_fixed - Set the slew rate for a specific SBB regulator channel
> > + *
> > + * @maxreg: Pointer to the max77675 regulator structure
> > + * @id: Regulator channel ID (ID_SBB0 ~ ID_SBB3)
> > + * @fixed: Slew rate value (true = 2mV/us, false = use DVS_SLEW)
> > + *
> > + * This function configures the slew rate control source for the specified SBB channel by
> > + * updating the corresponding bits in the CNFG_SBB_TOP_B register.
> > + *
> > + * Return: 0 on success, negative error code on failure (e.g., invalid channel ID).
> > + */
> > +static int max77675_set_sbb_slew_rate_fixed(struct max77675_regulator *maxreg, int id, bool
> > fixed)
> > +{
> > +	u8 mask, value;
> > +	u8 slew_src_ctrl_bit = fixed ? 0 : 1;
> > +
> > +	switch (id) {
> > +	case MAX77675_ID_SBB0:
> > +		mask = MAX77675_SR_SBB0_BIT;
> > +		value = FIELD_PREP(MAX77675_SR_SBB0_BIT, slew_src_ctrl_bit);
> > +		break;
> > +
> > +	case MAX77675_ID_SBB1:
> > +		mask = MAX77675_SR_SBB1_BIT;
> > +		value = FIELD_PREP(MAX77675_SR_SBB1_BIT, slew_src_ctrl_bit);
> > +		break;
> > +
> > +	case MAX77675_ID_SBB2:
> > +		mask = MAX77675_SR_SBB2_BIT;
> > +		value = FIELD_PREP(MAX77675_SR_SBB2_BIT, slew_src_ctrl_bit);
> > +		break;
> > +
> > +	case MAX77675_ID_SBB3:
> > +		mask = MAX77675_SR_SBB3_BIT;
> > +		value = FIELD_PREP(MAX77675_SR_SBB3_BIT, slew_src_ctrl_bit);
> > +		break;
> > +
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +
> > +	return regmap_update_bits(maxreg->regmap, MAX77675_REG_CNFG_SBB_TOP_B, mask, value);
> > +}
> > +
> > +static int max77675_init_regulator(struct max77675_regulator *maxreg, int id)
> > +{
> > +	struct max77675_regulator_pdata *rpdata = &maxreg->pdata[id];
> > +	int ret;
> > +
> > +	if (rpdata->fps_slot == MAX77675_FPS_DEF) {
> > +		ret = max77675_regulator_get_fps_src(maxreg, id);
> > +		if (ret < 0) {
> > +			dev_err(maxreg->dev, "Failed to read FPS source for ID %d\n", id);
> > +			return ret;
> > +		}
> > +		rpdata->fps_slot = ret;
> > +	} else {
> > +		ret = max77675_regulator_set_fps_src(maxreg, id, rpdata->fps_slot);
> > +		if (ret)
> > +			dev_warn(maxreg->dev, "Failed to set FPS source for ID %d\n", id);
> > +	}
> > +
> > +	ret = max77675_set_sbb_slew_rate_fixed(maxreg, id, rpdata->fixed_slew_rate);
> > +	if (ret)
> > +		dev_warn(maxreg->dev, "Failed to set slew rate for ID %d\n", id);
> 
> Do we really want to treat this as a warning (as FPS)? If so, I would expect a proper
> comment explaining why we can afford it.
> 

As this could impact proper operation, I’ll make the function return an error.

> > +
> > +	return 0;
> > +}
> > +
> > +static int max77675_of_parse_cb(struct device_node *np,
> > +				const struct regulator_desc *desc,
> > +				struct regulator_config *config)
> > +{
> > +	struct max77675_regulator *maxreg = config->driver_data;
> > +	struct max77675_regulator_pdata *rpdata = &maxreg->pdata[desc->id];
> > +	u32 pval;
> > +	int ret;
> > +
> > +	/* Parse FPS slot from DT */
> > +	ret = of_property_read_u32(np, "maxim,fps-slot", &pval);
> > +	rpdata->fps_slot = (!ret) ? (u8)pval : MAX77675_FPS_DEF;
> > +
> 
> So, can we get any arbitrary value for pval? I see we you have an enum in
> the bindings so make sure we properly validate it. Same for all other
> properties. The bindings also have this as a string and here you have a u32?
> Not going to work. You need of_property_read_string() + match_string().

Thanks, I will change it

> 
> 
> Also, "maxim,"? For some time now it's "adi,".
> 

I will change it

> > +	/* Parse slew rate control source */
> > +	rpdata->fixed_slew_rate = of_property_read_bool(np, "maxim,fixed-slew-rate");
> > +
> > +	/* Apply parsed configuration */
> > +	return max77675_init_regulator(maxreg, desc->id);
> > +}
> > +
> > +static int max77675_get_error_flags(struct regulator_dev *rdev, unsigned int *flags)
> > +{
> > +	struct max77675_regulator *maxreg = rdev_get_drvdata(rdev);
> > +	unsigned int int_flags;
> > +	int id = rdev_get_id(rdev);
> > +	int ret;
> > +
> > +	ret = regmap_read(maxreg->regmap, MAX77675_REG_INT_GLBL, &int_flags);
> > +	if (ret) {
> > +		dev_err(maxreg->dev, "Failed to read INT_GLBL: %d\n", ret);
> > +		return ret;
> > +	}
> > +
> > +	*flags = 0;
> > +
> > +	switch (id) {
> > +	case MAX77675_ID_SBB0:
> > +		if (int_flags & MAX77675_INT_SBB0_F_BIT)
> > +			*flags |= REGULATOR_ERROR_FAIL;
> > +		break;
> > +	case MAX77675_ID_SBB1:
> > +		if (int_flags & MAX77675_INT_SBB1_F_BIT)
> > +			*flags |= REGULATOR_ERROR_FAIL;
> > +		break;
> > +	case MAX77675_ID_SBB2:
> > +		if (int_flags & MAX77675_INT_SBB2_F_BIT)
> > +			*flags |= REGULATOR_ERROR_FAIL;
> > +		break;
> > +	case MAX77675_ID_SBB3:
> > +		if (int_flags & MAX77675_INT_SBB3_F_BIT)
> > +			*flags |= REGULATOR_ERROR_FAIL;
> > +		break;
> > +	default:
> > +		dev_warn(maxreg->dev, "Unsupported regulator ID: %d\n", id);
> > +		break;
> 
> Should not be a warning. Also wonder if it can happen at all?
> 

Agreed, this case shouldn’t happen. I’ll drop the warning.

> > +	}
> > +
> > +	if (int_flags & MAX77675_INT_TJAL2_R_BIT) {
> > +		/* TJAL2 interrupt: Over-temperature condition (above 120 degree) */
> > +		*flags |= REGULATOR_ERROR_OVER_TEMP;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static const struct regulator_ops max77675_regulator_ops = {
> > +	.list_voltage         = regulator_list_voltage_linear,
> > +	.enable               = regulator_enable_regmap,
> > +	.disable              = regulator_disable_regmap,
> > +	.is_enabled           = regulator_is_enabled_regmap,
> > +	.map_voltage          = regulator_map_voltage_linear,
> > +	.set_voltage_sel      = regulator_set_voltage_sel_regmap,
> > +	.get_voltage_sel      = regulator_get_voltage_sel_regmap,
> > +	.set_active_discharge = regulator_set_active_discharge_regmap,
> > +	.get_error_flags      = max77675_get_error_flags,
> > +};
> > +
> > +static struct regulator_desc max77675_regulators[MAX77675_ID_NUM_MAX] = {
> > +	{
> > +		.name                  = "sbb0",
> > +		.of_match              = of_match_ptr("sbb0"),
> > +		.regulators_node       = of_match_ptr("regulators"),
> 
> I wonder if we need of_match_ptr() given that the whole thing depends on OF.
> 
> ...
> 

I agree with you. If there are no objections, I will remove it.

> > +
> > +static int max77675_apply_config(struct max77675_regulator *maxreg)
> > +{
> > +	const struct max77675_config *config = &maxreg->config;
> > +	int ret;
> > +
> > +	ret = max77675_set_en_mode(maxreg, config->en_mode);
> > +	if (ret) {
> > +		dev_err(maxreg->dev, "Failed to set EN mode: %d\n", ret);
> > +		return ret;
> > +	}
> > +
> > +	ret = max77675_set_latency_mode(maxreg, config->voltage_change_latency);
> > +	if (ret) {
> > +		dev_err(maxreg->dev, "Failed to set latency mode: %d\n", ret);
> > +		return ret;
> > +	}
> > +
> > +	ret = max77675_set_drv_sbb_strength(maxreg, config->drv_sbb_strength);
> > +	if (ret) {
> > +		dev_err(maxreg->dev, "Failed to set drive strength: %d\n", ret);
> > +		return ret;
> > +	}
> > +
> > +	ret = max77675_set_dvs_slew_rate(maxreg, config->dvs_slew_rate);
> > +	if (ret) {
> > +		dev_err(maxreg->dev, "Failed to set DVS slew rate: %d\n", ret);
> > +		return ret;
> > +	}
> > +
> > +	ret = max77675_set_debounce_time(maxreg, config->debounce_time);
> > +	if (ret) {
> > +		dev_err(maxreg->dev, "Failed to set EN debounce time: %d\n", ret);
> > +		return ret;
> > +	}
> > +
> > +	ret = max77675_set_manual_reset_time(maxreg, config->manual_reset_time);
> > +	if (ret) {
> > +		dev_err(maxreg->dev, "Failed to set manual reset time: %d\n", ret);
> > +		return ret;
> > +	}
> > +
> > +	ret = max77675_set_en_pullup_disable(maxreg, config->en_pullup_disable);
> > +	if (ret) {
> > +		dev_err(maxreg->dev, "Failed to set EN pull-up disable: %d\n", ret);
> > +		return ret;
> > +	}
> > +
> > +	ret = max77675_set_bias_low_power_request(maxreg, config->bias_low_power_request);
> > +	if (ret) {
> > +		dev_err(maxreg->dev, "Failed to set bias low-power request: %d\n", ret);
> > +		return ret;
> > +	}
> > +
> > +	ret = max77675_set_simo_int_ldo_always_on(maxreg, config->simo_int_ldo_always_on);
> > +	if (ret) {
> > +		dev_err(maxreg->dev, "Failed to set SIMO internal LDO always-on: %d\n", ret);
> > +		return ret;
> > +	}
> 
> This seems to called during probe. All the above can be return dev_err_probe()...
> 

I’m thinking of handling it directly where the return value is checked. What are your thoughts?

ret = max77675_apply_config(maxreg);
    if (ret)
    	return dev_err_probe(maxreg->dev, ret, "Failed to apply config\n");

> > +
> > +	return 0;
> > +}
> > +
> > +static u8 max77675_parse_voltage_change_latency(struct device_node *np)
> > +{
> > +	u32 val;
> > +
> > +	if (!of_property_read_u32(np, "maxim,voltage-change-latency-us", &val)) {
> > +		switch (val) {
> > +		case 10:
> > +			return MAX77675_LOW_LATENCY_MODE;
> > +		case 100:
> > +			return MAX77675_HIGH_LATENCY_MODE;
> > +		default:
> > +			break;
> 
> The above is wrong. You're ignoring invalid values being given and overwrite them
> with defaults. The pattern is:
> 
> val = MAX77675_HIGH_LATENCY_MODE;
> if (!of_property_read_u32(np, "maxim,voltage-change-latency-us", &val)) {
> 	...
> 	default:
> 		return dev_err_probe(dev, -EINVAL, ...);
> }
> 
> You can also do:
> 
> ret = of_property_read_u32(...);
> /* Not 100% sure if -EINVAL is the error code for a missing property */
> if (ret && ret != -EINVAL)
> 	return ret;
> if (!ret) {
> 	...
> }
> 

I will update the code to set a default value first and handle invalid values by returning an error.

> > +		}
> > +	}
> > +
> > +	/* default: high latency */
> > +	return MAX77675_HIGH_LATENCY_MODE;
> > +}
> > +
> > +static u8 max77675_parse_en_mode(struct device_node *np)
> > +{
> > +	const char *str;
> > +
> > +	if (!of_property_read_string(np, "maxim,en-mode", &str)) {
> > +		if (!strcasecmp(str, "push-button"))
> > +			return MAX77675_EN_PUSH_BUTTON;
> > +		else if (!strcasecmp(str, "slide-switch"))
> > +			return MAX77675_EN_SLIDE_SWITCH;
> > +		else if (!strcasecmp(str, "logic"))
> > +			return MAX77675_EN_LOGIC;
> 
> redundant else if(). Moreover, this looks like it could use match_string()
> 

I will update it to use match_string.

> > +	}
> > +
> > +	/* default : slide-switch */
> > +	return MAX77675_EN_SLIDE_SWITCH;
> > +}
> > +
> > +static u8 max77675_parse_manual_reset_time(struct device_node *np)
> > +{
> > +	u32 val;
> > +
> > +	if (!of_property_read_u32(np, "reset-time-sec", &val)) {
> > +		switch (val) {
> > +		case 4:
> > +			return MAX77675_MRT_4S;
> > +		case 8:
> > +			return MAX77675_MRT_8S;
> > +		case 12:
> > +			return MAX77675_MRT_12S;
> > +		case 16:
> > +			return MAX77675_MRT_16S;
> > +		default:
> > +			break;
> 
> Ditto.
> 
> ...
> 
> > +
> > +static int max77675_parse_config(struct max77675_regulator *maxreg)
> > +{
> > +	struct device_node *np = maxreg->dev->of_node;
> > +	struct max77675_config *config = &maxreg->config;
> > +	int ret;
> > +
> > +	/* EN pin mode: push-button, slide-switch, or logic */
> > +	config->en_mode = max77675_parse_en_mode(np);
> > +
> > +	/* latency mode */
> > +	config->voltage_change_latency = max77675_parse_voltage_change_latency(np);
> > +
> > +	/* drive strength */
> > +	config->drv_sbb_strength = max77675_parse_drv_sbb_strength(np);
> > +
> > +	/* drv slew rate */
> > +	config->dvs_slew_rate = max77675_parse_dvs_slew_rate(np);
> > +
> > +	/* Debounce time for EN pin */
> > +	config->debounce_time = max77675_parse_debounce_time_us(np);
> > +
> > +	/* Manual reset time for EN pin */
> > +	config->manual_reset_time = max77675_parse_manual_reset_time(np);
> 
> Seems to me that all of the above will need some error handling.
> 

I will update the code to handle errors.

> > +
> > +	/* Disable internal pull-up resistor on EN pin */
> > +	config->en_pullup_disable = of_property_read_bool(np, "maxim,en-pullup-disable");
> > +
> > +	/* Request low-power mode for main bias */
> > +	config->bias_low_power_request = of_property_read_bool(np, "maxim,bias-low-power-
> > request");
> > +
> > +	/* Force internal LDO to always supply 1.8V */
> > +	config->simo_int_ldo_always_on = of_property_read_bool(np, "maxim,simo-int-ldo-always-
> > on");
> > +
> > +	ret = max77675_apply_config(maxreg);
> > +
> > +	return ret;
> > +}
> > +
> > +static int max77675_init_event(struct max77675_regulator *maxreg)
> > +{
> > +	unsigned int ercflag, int_glbl;
> > +	int ret;
> > +
> > +	ret = regmap_read(maxreg->regmap, MAX77675_REG_ERCF_GLBL, &ercflag);
> > +	if (ret) {
> > +		dev_err(maxreg->dev, "Failed to read CID register: %d\n", ret);
> > +		return ret;
> > +	}
> > +
> > +	ret = regmap_read(maxreg->regmap, MAX77675_REG_INT_GLBL, &int_glbl);
> > +	if (ret) {
> > +		dev_err(maxreg->dev, "Failed to read INT_GLBL register: %d\n", ret);
> > +		return ret;
> > +	}
> > +
> > +	if (ercflag & MAX77675_SFT_CRST_F_BIT)
> > +		dev_info(maxreg->dev, "Software Cold Reset Flag is set\n");
> > +
> > +	if (ercflag & MAX77675_SFT_OFF_F_BIT)
> > +		dev_info(maxreg->dev, "Software Off Flag is set\n");
> > +
> > +	if (ercflag & MAX77675_MRST_BIT)
> > +		dev_info(maxreg->dev, "Manual Reset Timer Flag is set\n");
> > +
> > +	if (ercflag & MAX77675_UVLO_BIT)
> > +		dev_info(maxreg->dev, "Undervoltage Lockout Flag is set\n");
> > +
> > +	if (ercflag & MAX77675_OVLO_BIT)
> > +		dev_info(maxreg->dev, "Overvoltage Lockout Flag is set\n");
> > +
> > +	if (ercflag & MAX77675_TOVLD_BIT)
> > +		dev_info(maxreg->dev, "Thermal Overload Flag is set\n");
> > +
> > +	if (int_glbl & MAX77675_INT_SBB3_F_BIT)
> > +		dev_info(maxreg->dev, "SBB3 Channel Fault Interrupt occurred\n");
> > +
> > +	if (int_glbl & MAX77675_INT_SBB2_F_BIT)
> > +		dev_info(maxreg->dev, "SBB2 Channel Fault Interrupt occurred\n");
> > +
> > +	if (int_glbl & MAX77675_INT_SBB1_F_BIT)
> > +		dev_info(maxreg->dev, "SBB1 Channel Fault Interrupt occurred\n");
> > +
> > +	if (int_glbl & MAX77675_INT_SBB0_F_BIT)
> > +		dev_info(maxreg->dev, "SBB0 Channel Fault Interrupt occurred\n");
> > +
> > +	if (int_glbl & MAX77675_INT_TJAL2_R_BIT)
> > +		dev_info(maxreg->dev, "Thermal Alarm 2 Rising Interrupt occurred\n");
> > +
> > +	if (int_glbl & MAX77675_INT_TJAL1_R_BIT)
> > +		dev_info(maxreg->dev, "Thermal Alarm 1 Rising Interrupt occurred\n");
> > +
> > +	if (int_glbl & MAX77675_INT_EN_R_BIT)
> > +		dev_info(maxreg->dev, "nEN Rising Edge Interrupt occurred\n");
> > +
> > +	if (int_glbl & MAX77675_INT_EN_F_BIT)
> > +		dev_info(maxreg->dev, "nEN Falling Edge Interrupt occurred\n");
> 
> All of the above looks like dev_dbg() to me.
> 

I will change it

> > +
> > +	return 0;
> > +}
> > +
> > +static int max77675_regulator_probe(struct i2c_client *client)
> > +{
> > +	struct max77675_regulator *maxreg;
> > +	struct regulator_config config = {};
> > +	struct device_node *regulators_np;
> > +	int i, ret;
> > +
> > +	maxreg = devm_kzalloc(&client->dev, sizeof(*maxreg), GFP_KERNEL);
> > +	if (!maxreg)
> > +		return -ENOMEM;
> > +
> > +	maxreg->dev = &client->dev;
> > +
> > +	maxreg->regmap = devm_regmap_init_i2c(client, &max77675_regmap_config);
> > +	if (IS_ERR(maxreg->regmap))
> > +		return dev_err_probe(maxreg->dev,
> > +				     PTR_ERR(maxreg->regmap),
> > +				     "Failed to init regmap\n");
> > +
> > +	ret = max77675_init_event(maxreg);
> > +	if (ret)
> > +		return dev_err_probe(maxreg->dev, ret, "Failed to init event\n");
> > +
> > +	ret = max77675_parse_config(maxreg);
> > +	if (ret)
> > +		return dev_err_probe(maxreg->dev, ret, "Failed to apply config\n");
> > +
> > +	config.dev = &client->dev;
> > +	config.regmap = maxreg->regmap;
> > +	config.driver_data = maxreg;
> > +
> > +	regulators_np = of_get_child_by_name(client->dev.of_node, "regulators");
> 
> The above can actually be:
> 
> struct device_node *regulators_np __free(device_node) = of_get_child_by_name(...)
> 
> and then no need to care about of_node_put(). You need cleanup.h
> 

Thanks fot letting me know, I will change it

> > +	if (!regulators_np) {
> > +		dev_err(maxreg->dev, "No 'regulators' subnode found in DT\n");
> > +		return -EINVAL;
> > +	}
> > +
> > +	for (i = 0; i < MAX77675_ID_NUM_MAX; i++) {
> > +		const struct regulator_desc *desc = &max77675_regulators[i];
> > +		struct regulator_dev *rdev;
> > +
> > +		config.of_node = of_get_child_by_name(regulators_np, desc->name);
> > +		if (!config.of_node) {
> > +			dev_warn(maxreg->dev, "No DT node for regulator %s\n", desc->name);
> > +			continue;
> > +		}
> > +
> > +		rdev = devm_regulator_register(&client->dev, desc, &config);
> > +		of_node_put(config.of_node);
> > +		if (IS_ERR(rdev)) {
> > +			of_node_put(regulators_np);
> > +			return dev_err_probe(maxreg->dev, PTR_ERR(rdev),
> > +				"Failed to register regulator %d (%s): %d\n",
> > +				i, desc->name, ret);
> > +		}
> > +	}
> > +
> > +	of_node_put(regulators_np);
> > +	i2c_set_clientdata(client, maxreg);
> 
> I do not see i2c_get_clientdata() anywhere. I suspect you can drop the above.
>

I will remove it

> > +
> > +	return 0;
> > +}
> > +
> > +static const struct i2c_device_id max77675_i2c_id[] = {
> > +	{ "max77675", 0 },
> > +	{ }
> > +};
> > +MODULE_DEVICE_TABLE(i2c, max77675_i2c_id);
> > +
> > +static const struct of_device_id __maybe_unused max77675_of_match[] = {
> > +	{ .compatible = "maxim,max77675", },
> > +	{ }
> > +};
> > +MODULE_DEVICE_TABLE(of, max77675_of_match);
> > +
> > +static struct i2c_driver max77675_regulator_driver = {
> > +	.driver = {
> > +		.name = "max77675",
> > +		.of_match_table = of_match_ptr(max77675_of_match),
> 
> I guess we can drop of_match_ptr() if we agree that we depend on OF
> 

I agree with you. If there are no objections, I will remove it.

> > +	},
> > +	.probe = max77675_regulator_probe,
> > +	.id_table = max77675_i2c_id,
> > +};
> > +
> > +module_i2c_driver(max77675_regulator_driver);
> > +
> > +MODULE_DESCRIPTION("MAX77675 Regulator Driver");
> > +MODULE_AUTHOR("Joan Na <joan.na@analog.com>");
> > +MODULE_LICENSE("GPL");
> > diff --git a/drivers/regulator/max77675-regulator.h b/drivers/regulator/max77675-regulator.h
> > new file mode 100644
> > index 000000000000..0aaa30a630ca
> > --- /dev/null
> > +++ b/drivers/regulator/max77675-regulator.h
> 
> As said, drop the header.
>

I will drop the header.

> - Nuno Sá

-- 
Best regards,
Joan Na


