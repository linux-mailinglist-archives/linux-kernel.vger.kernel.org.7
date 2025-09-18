Return-Path: <linux-kernel+bounces-822595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CFEFB843C9
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 12:55:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10ED63B4850
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 10:55:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 586452F7446;
	Thu, 18 Sep 2025 10:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="qedgpUp5"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D77092EAB61
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 10:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758192921; cv=none; b=RpraAH5fjLuldpZArypsX9aEPjdmretbZaviAvotMIyRTILcdpWNK9z5eGIsDK5Hmh9Ifr0a9FnR2OHdxiYMqghNfgF0L+55u8JJAn3hzjKlOiI8ElL6aaB6fgCvnCmKWBKhxO++Zie7gKMISNBwFTsceZYOGV9Z3aOTWxiVdGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758192921; c=relaxed/simple;
	bh=jUj3DmphDYHob5tgbYVZeMPCTzvB0qCtndg6eAPhzeU=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SW8OD8NUhbyoBNzHzHl+rET5VsC6gVDqJY1rEYbWHaDncB4Kf/+fTMza7z36lUCm/y4QrcoGWLApoilOd8xnY3sykO2+Z62mO+H6M0CydN8Qd6NeZMvm2um2J2bJPiWc4ULG4OowTDwH13zsVKpj2SCeBVKEEJ/i9LphHGCYtt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=qedgpUp5; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5783a776a77so1150269e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 03:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1758192918; x=1758797718; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:references:mime-version:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=kb5Wonknu5Up30dV+dkb1z8Wdj+m522AJmQC52RsZ8w=;
        b=qedgpUp5IIo5xYX3tkdu1FdEfEyKNpYpHKd4F4eUZlESZ/pJ7Z8Gpj5MGTMG45mmPx
         6JX3iAey+4VuowuxkrwultayD+g50a1g61EbCIRBpNDz/xdlVr/4Jz2rfZcl093FW4Oh
         CQqObp1AYf4d3M1mRPUiaCX/QRovlwjp9R1pbL35++wpR5l8PvD2c82OjkvOPu90yfUY
         VI1Hs07skVxaLT7rOSbsNCGYceRShDQp1ULOdCeO2yEolg7oKxixZRmnw4/J1Dps8Sjs
         +ypnqMnu6Be1asW07uq+CUa57tVb5fKOyw9DL4YMCVt9z1TRGwgRyosq3yBDqSwLUOct
         YhyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758192918; x=1758797718;
        h=cc:to:subject:message-id:date:references:mime-version:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kb5Wonknu5Up30dV+dkb1z8Wdj+m522AJmQC52RsZ8w=;
        b=LaWoBcvPywt+ddTOLQI8HUqK+FO1vSKTgw9fjyRSAJb6LdDJW4FqO5zmgZfMJuVH5s
         pRIHo79P1nZ1QhFBLPLQCzjL5QODy43tioHq9vF/XGVXr9Er5cty8c7hUV6VxrHUnwZ4
         g/3EedVEiB+r1DqhNrZPBHBr/OJStnd1Mby2OWAeSQ9uhaE7F2HdM5Q1ZuaBmL0V5LtE
         HPRwasg1Bkt3M2jdlXdpgPnA2pcdVwg83VzIHhkj3Pn82TAxpWqDqabFVL5NEQ3RCnVS
         cHLEXvH5ciDttNOoC1B/PzoLiy0tJF+FSDVq95NZ0taRCcPcXfxlz+dmUVLqdyRwytCn
         p7BQ==
X-Forwarded-Encrypted: i=1; AJvYcCWdgpidJx/ThTDKKXPkA42xWgYILGN0q9Mggnlv4Hde3UHFhn38nucvEHQWJeCrQNX2mf4qRN4ZFAtV+eQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOfzjj70kU3Hhd4cPUuHUDEKS62GTKEmHaEJcBgDnZmMtFaHJ+
	brd7IqCPHHg/O1qxGQuTjG5j1pB+OkKFutuu4v+K2NmEkvMPAEg4MN+VcRUGwltr9juQv2e59El
	rFL64RXjQjpqG7RQxzBCV8eEm2CPckmlL2lEaAx3FdQOJYJa+unZCu5r49016
X-Gm-Gg: ASbGnct+eNHQmo8jaiOwCOpRxZognIeOeKOoO5CoOn4XLL5BE3bt0JX+3zrGAPScFLg
	RHSO8W49iN5fhstAZLXbWIsDl9yymygTMDvkv68R0BZRQHCY4wM1IiK8kHEQ8OCQ2m8sig+d6bv
	TUKtK61O9YUJqIXY+kVjLZXl3lxU0JA/r6zninz4dI/zFMBkgXSltJB+DDk6tfQpYGACTfJSGgY
	V9EUycl6vaD36QnnKn++W1Tpw==
X-Google-Smtp-Source: AGHT+IGHqUzrOrF5h0jq5ITJQr9RlHNA7rg3df+hUZXro+/W4S11AYeIdoZ0dL2vKV3prv3NyO2vbOc2/8WjvSUzl9w=
X-Received: by 2002:a05:6512:3f26:b0:55f:3f00:a830 with SMTP id
 2adb3069b0e04-5779b9b5a1fmr1645131e87.57.1758192917914; Thu, 18 Sep 2025
 03:55:17 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 18 Sep 2025 03:55:16 -0700
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 18 Sep 2025 03:55:16 -0700
From: Bartosz Golaszewski <brgl@bgdev.pl>
In-Reply-To: <20250917090422.870033-6-ioana.ciornei@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250917090422.870033-1-ioana.ciornei@nxp.com> <20250917090422.870033-6-ioana.ciornei@nxp.com>
Date: Thu, 18 Sep 2025 03:55:16 -0700
X-Gm-Features: AS18NWCbc_x_jlVkgrm8bsF4vFJeHzl6KfSHBqaKH56sjhYqV_7bfyBIPSWiwE4
Message-ID: <CAMRc=MdxE-qsthHot7+iA8yqg1ZEASzGh7dmR=ucfxg_JQipxQ@mail.gmail.com>
Subject: Re: [PATCH v3 05/10] gpio: regmap: add the .fixed_direction_output
 configuration parameter
To: Ioana Ciornei <ioana.ciornei@nxp.com>
Cc: Frank Li <Frank.Li@nxp.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>, 
	Shawn Guo <shawnguo@kernel.org>, Michael Walle <mwalle@kernel.org>, Lee Jones <lee@kernel.org>, 
	devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 17 Sep 2025 11:04:17 +0200, Ioana Ciornei <ioana.ciornei@nxp.com> said:
> There are GPIO controllers such as the one present in the LX2160ARDB
> QIXIS FPGA which have fixed-direction input and output GPIO lines mixed
> together in a single register. This cannot be modeled using the
> gpio-regmap as-is since there is no way to present the true direction of
> a GPIO line.
>
> In order to make this use case possible, add a new configuration
> parameter - fixed_direction_output - into the gpio_regmap_config
> structure. This will enable user drivers to provide a bitmap that
> represents the fixed direction of the GPIO lines.
>
> Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
> ---
> Changes in v2:
> - Add the fixed_direction_output bitmap to the gpio_regmap_config
> Changes in v3:
> - Make a deep copy of the new bitmap.
> - Remove the offset check against the ngpio.
> - Added documentation for the new config field.
>
>  drivers/gpio/gpio-regmap.c  | 18 ++++++++++++++++++
>  include/linux/gpio/regmap.h |  6 ++++++
>  2 files changed, 24 insertions(+)
>
> diff --git a/drivers/gpio/gpio-regmap.c b/drivers/gpio/gpio-regmap.c
> index e8a32dfebdcb..9edd79b5c10e 100644
> --- a/drivers/gpio/gpio-regmap.c
> +++ b/drivers/gpio/gpio-regmap.c
> @@ -31,6 +31,7 @@ struct gpio_regmap {
>  	unsigned int reg_clr_base;
>  	unsigned int reg_dir_in_base;
>  	unsigned int reg_dir_out_base;
> +	unsigned long *fixed_direction_output;
>
>  	int (*reg_mask_xlate)(struct gpio_regmap *gpio, unsigned int base,
>  			      unsigned int offset, unsigned int *reg,
> @@ -129,6 +130,13 @@ static int gpio_regmap_get_direction(struct gpio_chip *chip,
>  	unsigned int base, val, reg, mask;
>  	int invert, ret;
>
> +	if (gpio->fixed_direction_output) {
> +		if (test_bit(offset, gpio->fixed_direction_output))
> +			return GPIO_LINE_DIRECTION_OUT;
> +		else
> +			return GPIO_LINE_DIRECTION_IN;
> +	}
> +
>  	if (gpio->reg_dat_base && !gpio->reg_set_base)
>  		return GPIO_LINE_DIRECTION_IN;
>  	if (gpio->reg_set_base && !gpio->reg_dat_base)
> @@ -277,6 +285,16 @@ struct gpio_regmap *gpio_regmap_register(const struct gpio_regmap_config *config
>  			return ERR_PTR(ret);
>  	}
>
> +	if (config->fixed_direction_output) {
> +		gpio->fixed_direction_output = devm_bitmap_alloc(config->parent,
> +								 chip->ngpio,
> +								 GFP_KERNEL);

Please don't use devres hidden in what is effectively a library function for
drivers. You have no guarantee this will always be used in probe or that the
life-time of this will end with the associated device's detach. Just use
a regular bitmap_alloc().

Bart

> +		if (!gpio->fixed_direction_output)
> +			return ERR_PTR(-ENOMEM);
> +		bitmap_copy(gpio->fixed_direction_output,
> +			    config->fixed_direction_output, chip->ngpio);
> +	}
> +
>  	/* if not set, assume there is only one register */
>  	gpio->ngpio_per_reg = config->ngpio_per_reg;
>  	if (!gpio->ngpio_per_reg)
> diff --git a/include/linux/gpio/regmap.h b/include/linux/gpio/regmap.h
> index c722c67668c6..8d3d595bfdd3 100644
> --- a/include/linux/gpio/regmap.h
> +++ b/include/linux/gpio/regmap.h
> @@ -37,6 +37,10 @@ struct regmap;
>   *			offset to a register/bitmask pair. If not
>   *			given the default gpio_regmap_simple_xlate()
>   *			is used.
> + * @fixed_direction_output:
> + *			(Optional) Bitmap representing the fixed direction of
> + *			the GPIO lines. Useful when there are GPIO lines with a
> + *			fixed direction mixed together in the same register.
>   * @drvdata:		(Optional) Pointer to driver specific data which is
>   *			not used by gpio-remap but is provided "as is" to the
>   *			driver callback(s).
> @@ -78,6 +82,8 @@ struct gpio_regmap_config {
>  	int ngpio_per_reg;
>  	struct irq_domain *irq_domain;
>
> +	unsigned long *fixed_direction_output;
> +
>  	int (*reg_mask_xlate)(struct gpio_regmap *gpio, unsigned int base,
>  			      unsigned int offset, unsigned int *reg,
>  			      unsigned int *mask);
> --
> 2.25.1
>
>

