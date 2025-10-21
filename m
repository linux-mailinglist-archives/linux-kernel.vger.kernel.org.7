Return-Path: <linux-kernel+bounces-862988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E98ABF6BCC
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 15:22:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A3FA425735
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 13:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5FEA336EE2;
	Tue, 21 Oct 2025 13:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="KxDEMFrQ"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 161CE33506F
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 13:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761052902; cv=none; b=dg6gfiWas/W9cEush2xtWidn7Wnt3aPOkWR12MVNBNbGIP/36ElCFNQfJbSXfZvsVnVGq+nJFTNM4U8VvAN1N64jPmLkQwbS2Ek9kQ+EJJcmJgVzXIGoHn9jWcnndHJkwwdM9Q3wt0kruORrqL/G0OZnM5/Jq1tCFPRKNTFOD7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761052902; c=relaxed/simple;
	bh=skb9hQ3bPDQ//+qmxKEwi9qpg4pair4gGJB5W3yGr4o=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C4LbLG0cwA9iMGKcOWo9/BOSqKahNUI8O2XjFxVPdyGNvmdUMLljqAZcn34rD42oT1LY5DlCQNjEox75u3L/ibwwNZgDjZAeRg7XAXkc6uP72zQ9oaQLVU7ToZasKGz0LUVpLVAxFFyf3E5la9mUCtTyL6NXUoCNd0f+LvPU7dI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=KxDEMFrQ; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-591c74fd958so6963098e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 06:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1761052899; x=1761657699; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:references:mime-version:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=QB/8i9gcDwYx9MPZY12QJM3i5Ad8FHrbygJGWykWY6U=;
        b=KxDEMFrQoC2JLkZqQg0/N/oQcpw+fH8JIqkDdOdzxrevNjMrv/dC+IzEf1xYhiOP2b
         Hjh5aCNtbM3thD5FBUtbW/42/nD5gA9PHTJj71Gw/6m4YQhgfih6S0zJu3lGMC44cB2E
         4oaS30vxwTj0Ch9aryiWDR2rArlcE07z2/x+JIradcTjetFoViMJWib257+/C6JHvEJA
         82voJqIoj7OfSq4wkUxNr1i67gcRqBCGTRUhGSI/lv5Ll+rjVlVuVBQizv9o5KqiCeXU
         jOjw+rmsVjHWJ49BYX8IAPeucQp0MoEpPGWgUFXlcFNy7+GlV3Syq2rqAQ99NVCbIYFp
         +wrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761052899; x=1761657699;
        h=cc:to:subject:message-id:date:references:mime-version:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QB/8i9gcDwYx9MPZY12QJM3i5Ad8FHrbygJGWykWY6U=;
        b=czgYisSNRZQnLyf1t5+FMwCs7rpvXWOAxxZNzvTkTaeGSYWd2iLqWPQBQ0ZNv2iWgT
         A3blpCuKwNh2PAMTExN4H3ZA46968gtzqWLASp9Xg7s0R/cHksTrAQJhIdlkMeTec1ve
         yPbU1riHnoQVDzKBATHItobRpE4kgElSy33m/4Hl0WpT5afz3IahbnE/UwTPG3kTEqbu
         2w2KQNiprz0cxIH5mbg9dsoMV6Dwp0BgeefYTZ9H1YSRNqfnVC6Btx/CiT4ynOrO4K9Y
         ylpIORK6edqgwvrQ7srSLmC5chkgRLfFftnv27lWsFhlrCagK6rli4xW3Se49AAr530f
         M1Nw==
X-Forwarded-Encrypted: i=1; AJvYcCX8BADoTJH3NliRir8F4WFJc7wbKz6Cv0uvXzAOwiFfoHJoXu58UGAtwV6mCN25UtGQ1MdT8zPLApPOkfg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHKkVcMz5572Jf3Oq5ODgltIJgqd7nx7ITU/iC3VpbR397IO7L
	4KqFx+b9glqZJxRvbQsIbY9TBsVVCAKQIMpxYguLE9Jjtcyrm2zqm/0NPSYmPSGKoCl+u+ILnRE
	on7KvDhK0MLO3y9m7XWEaMazGKXt+g9pNxZoxuLvy5A==
X-Gm-Gg: ASbGnct9hIpDX8FwTgJmUzPgylxCiSlOpQcwXGkMEOh6+MUq288kEljNDp+9c7+BWb1
	S6OwMhHc7MjWC0W2Fjqo2q0bRvLtitLr3GlRcaT/RLvEbaKr2GyacLJrvA6PEPUDZdAANCQ7CKE
	FKnmQh4nJklJ5Ld5DEL7uPhpE0fh1K1TK5fZvlaBTelE+5kQjBvUP24u0x/IUC+ePedSmXbb78J
	5HNPM7haY9jxPXbV7YFPKnT/xVOGS5cVSoLnR+1NhkkI1dGBoLKJ8S7JuAjwofRoLV7mO71naUo
	diqaoEvSe/kYGpTSdd32HZ9w4/I=
X-Google-Smtp-Source: AGHT+IFU9Qs1FF3tvhuZ5QNpuWHEjsct+r642wNfUlzflw0GmkJA6bzYaO33fmeXk7R1wFoOfbXFWOTQ8VOF5mms5iA=
X-Received: by 2002:a05:6512:ea8:b0:55f:489d:7bd with SMTP id
 2adb3069b0e04-591d84689e0mr5110249e87.0.1761052899116; Tue, 21 Oct 2025
 06:21:39 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 21 Oct 2025 09:21:38 -0400
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 21 Oct 2025 09:21:38 -0400
From: Bartosz Golaszewski <brgl@bgdev.pl>
In-Reply-To: <20251020-fix-gpio-idio-16-regmap-v2-3-ebeb50e93c33@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251020-fix-gpio-idio-16-regmap-v2-0-ebeb50e93c33@kernel.org> <20251020-fix-gpio-idio-16-regmap-v2-3-ebeb50e93c33@kernel.org>
Date: Tue, 21 Oct 2025 09:21:38 -0400
X-Gm-Features: AS18NWA1C6wtwpPuGtGISwiqHUwqLrfrlE6ZnSP2lWK50cndlklyKCnzfgz1HbQ
Message-ID: <CAMRc=MeFZTDk4cgzEJNnkrJOEneFUBLwtKjkpV3-cLSm=xsxNg@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] gpio: idio-16: Define fixed direction of the GPIO lines
To: William Breathitt Gray <wbg@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Michael Walle <mwalle@kernel.org>, 
	Ioana Ciornei <ioana.ciornei@nxp.com>, Mark Brown <broonie@kernel.org>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Mark Cave-Ayland <mark.caveayland@nutanix.com>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 20 Oct 2025 10:51:46 +0200, William Breathitt Gray
<wbg@kernel.org> said:
> The direction of the IDIO-16 GPIO lines is fixed with the first 16 lines
> as output and the remaining 16 lines as input. Set the gpio_config
> fixed_direction_output member to represent the fixed direction of the
> GPIO lines.
>
> Fixes: db02247827ef ("gpio: idio-16: Migrate to the regmap API")
> Reported-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
> Closes: https://lore.kernel.org/r/9b0375fd-235f-4ee1-a7fa-daca296ef6bf@nutanix.com
> Suggested-by: Michael Walle <mwalle@kernel.org>
> Cc: stable@vger.kernel.org # ae495810cffe: gpio: regmap: add the .fixed_direction_output configuration parameter
> Cc: stable@vger.kernel.org
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: William Breathitt Gray <wbg@kernel.org>
> ---
>  drivers/gpio/gpio-idio-16.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/gpio/gpio-idio-16.c b/drivers/gpio/gpio-idio-16.c
> index 0103be977c66bb8d165c1c92123368be6832d120..4fbae6f6a49727df40f2793b42ca207d78ec272b 100644
> --- a/drivers/gpio/gpio-idio-16.c
> +++ b/drivers/gpio/gpio-idio-16.c
> @@ -6,6 +6,7 @@
>
>  #define DEFAULT_SYMBOL_NAMESPACE "GPIO_IDIO_16"
>
> +#include <linux/bitmap.h>
>  #include <linux/bits.h>
>  #include <linux/device.h>
>  #include <linux/err.h>
> @@ -107,6 +108,7 @@ int devm_idio_16_regmap_register(struct device *const dev,
>  	struct idio_16_data *data;
>  	struct regmap_irq_chip *chip;
>  	struct regmap_irq_chip_data *chip_data;
> +	DECLARE_BITMAP(fixed_direction_output, IDIO_16_NGPIO);
>
>  	if (!config->parent)
>  		return -EINVAL;
> @@ -164,6 +166,9 @@ int devm_idio_16_regmap_register(struct device *const dev,
>  	gpio_config.irq_domain = regmap_irq_get_domain(chip_data);
>  	gpio_config.reg_mask_xlate = idio_16_reg_mask_xlate;
>
> +	bitmap_from_u64(fixed_direction_output, GENMASK_U64(15, 0));
> +	gpio_config.fixed_direction_output = fixed_direction_output;
> +
>  	return PTR_ERR_OR_ZERO(devm_gpio_regmap_register(dev, &gpio_config));
>  }
>  EXPORT_SYMBOL_GPL(devm_idio_16_regmap_register);
>
> --
> 2.51.0
>
>

Turns out, this requires commit ae495810cffe ("gpio: regmap: add the
.fixed_direction_output configuration parameter") so I cannot queue it for
v6.18. What do you want me to do? Send the first two ones upstream and apply
this for v6.19?

Bartosz

