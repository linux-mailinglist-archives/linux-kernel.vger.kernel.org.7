Return-Path: <linux-kernel+bounces-812751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41947B53C39
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 21:23:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D3FF189149E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 19:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A817125DB1C;
	Thu, 11 Sep 2025 19:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="1CXa+mxI"
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C36246BD8
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 19:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757618625; cv=none; b=jMgshZPY4+1EjJam31CTV2kVKIXjLXNPKe6cfHCTuqBaiG44UssoSCCoh3GHFauGkElF8a94Q3m02YLPsSCXkRrT8N+LXuB/y/BmbJlhb1DdiVPA1nb7saSi85jIM8zE94BCm4rn+i3Ft3OeBhnW0aL/lnuvMNKx7yhtuctKVFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757618625; c=relaxed/simple;
	bh=kqxEeAV/Q5vnPKtNOnXmo6QFdVOxZgmFTCeqJRfcni8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tdxBoZd56z2zBHNZXKjSj7xATz0FD+5GJvcG8NcRTtMfFdGJd/gX8iQRyJ0FwOk1hDlWEoovw44SbD8C4xYQ4iAvnByDWddFslQi0R5whSr0TwoSzmN70ABx4n04WO/Ic9ZtSRp8OxvANmmRUaKS2z3GgxJhccqpE9mYx0dHkfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=1CXa+mxI; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-74c1251df00so656048a34.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 12:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1757618623; x=1758223423; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DoWX1q46dXn9Euy8n66ZzUrEnt7VeRMdWOnlV4ydzlM=;
        b=1CXa+mxIZ6wqOrugfNNwRbysHoK2GRyyct7bj2WgZ7WY7Ay6YHJD6Wspoqn1GdSehP
         pol0BmSCInZTE8Osbx7N58r/8Y593Oyu0rRslYLP+Ncl9gj5HMU1k8ivVwq/9VKmBajm
         f2On1QciRFcilAg0jyjBER5BAXw3PLuj1qTVg7gDOiLhl6fTX9AVSDUzju67HV+8ZZqd
         QyBD0/d6cwuFX6h1jnhgV24JfhfajIU7+F4AjTsII42zs8jhfkcXaIwPjr1PlUpEFiuf
         7tfeUV7azf/E+jlrk1rMLTnk+qiQWXnhvtD4ivaX7im7q4u4psMJ8EEgf8ENRA24HOPh
         o8Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757618623; x=1758223423;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DoWX1q46dXn9Euy8n66ZzUrEnt7VeRMdWOnlV4ydzlM=;
        b=jpw122i7I/DfSpuKFHi/+sh+AcitywXoW2PklYhz2qmnJx2SBGwz0v5zoeGRwlMzoT
         I92cMmj1WOU7y3+vNtitzUz/OWHNpPnfN6CmIIZLBX6X0HQ/LUq4SCwtFIWp/ELueKdv
         OLfzRooJrSGJmnMlyeVkkg6dY0HRdqpLUQGlHmLe6o3PrFWYA6Zylc5cYOxYFlugAJ5b
         7+MWRPCCkPc9HJ+b39bYVAqaacFBPhSAe53XekY4vKu2lu+NGl9pUSJbzN1cX1nVTGJT
         2nfRMRaP4Mrr/WXG3mVn1Pkk20Qo9S1SUH9ztmr/a2nQvyckGg6R1neyia/IdZhzQaoo
         5aeg==
X-Forwarded-Encrypted: i=1; AJvYcCVYsgQ1M9F4S1lvMKQ9TQo1SbI64pA42pW8GyasK2xiVZF4iWINXqYWobrW8tvzyOFN/Aj8HrmCD93YYJI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGAg1uRA2MXtg3Fw1ykBgMTvbU4IbRGV+usojYFlVkqXD83Mnf
	NfrY5OgZCJVvEEcCtQDr0beTYtt5YSv/QleG1TyleyBd+OwHbYgQmymKYUBLaAdOP0c=
X-Gm-Gg: ASbGncsnV1h9qYOTG/0gkcszlx9IjMuYVw0TxEfthQCNOBcCCuw2Mdhq468vsVPtb7r
	rxKMhVATAmklHdFjG2/iIe7qzfjYHc3sqCKp4mJ8jtxXqYbtxIz5k4sGGUUE3ff6eNffRW5wPlC
	A4cHSw1RQGRCyrsolvPvkca1DGKmZfppk8+2Jmv8shUFT9YQhBubSBYGWDBuwr3AMrRSiqWpWlG
	TTJ/laXIfO8ewtOTF+nqSQPKSJVSMgehNbXoLC5NYGUEHwv1L1GXA6X/dd/BOblFxLOwPW0HYVh
	V3Nj1CytKIDEY8AR2KmxQ3sPUVFKEKBO5KFD+xpWEKf4+58LLGk/OEipm+E0nEbqlvatTvlU+ri
	G5nfS4LpaV9ReKwEYVfPQp9RrAY3ywSagZ0JFXD7uBIth55XhGRCSOlzNblDoHa2s2Etm3lSX+P
	0QZPyMatI6Gw==
X-Google-Smtp-Source: AGHT+IEBEN07QRmj1/6V2YlTqYhYgXmVCJ6qRkj6CfF4fpM1qtcfdWgtW459UBV2iO984U0Ky8/ZvA==
X-Received: by 2002:a05:6870:788b:b0:302:523a:1799 with SMTP id 586e51a60fabf-32e552aa273mr147762fac.11.1757618618034;
        Thu, 11 Sep 2025 12:23:38 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:d684:59db:8b2a:5451? ([2600:8803:e7e4:1d00:d684:59db:8b2a:5451])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-32d33452e9fsm624768fac.11.2025.09.11.12.23.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Sep 2025 12:23:36 -0700 (PDT)
Message-ID: <a69192a1-68cb-4c24-abe6-09534df0ba98@baylibre.com>
Date: Thu, 11 Sep 2025 14:23:35 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/14] iio: accel: bma220: add i2c module
To: Petre Rodan <petre.rodan@subdimension.ro>,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250910-bma220_improvements-v2-0-e23f4f2b9745@subdimension.ro>
 <20250910-bma220_improvements-v2-9-e23f4f2b9745@subdimension.ro>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250910-bma220_improvements-v2-9-e23f4f2b9745@subdimension.ro>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/10/25 2:57 AM, Petre Rodan wrote:
> Add the bma220_i2c module.
> 
> Note that this kernel module transparently shifts all register addresses
> 1 bit to the left, so all functions will operate based on the SPI memory
> map.
> 
> Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
> ---
> no change
> ---
>  drivers/iio/accel/Kconfig       |  9 +++++-
>  drivers/iio/accel/Makefile      |  1 +
>  drivers/iio/accel/bma220.h      |  1 +
>  drivers/iio/accel/bma220_core.c | 18 ++++++++++++
>  drivers/iio/accel/bma220_i2c.c  | 61 +++++++++++++++++++++++++++++++++++++++++
>  5 files changed, 89 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
> index 9b6c35b759481df5ff3c91856f8783357d25de80..b3c5b0b7a406ec0cec531a122af424cb8ec57703 100644
> --- a/drivers/iio/accel/Kconfig
> +++ b/drivers/iio/accel/Kconfig
> @@ -221,6 +221,7 @@ config BMA220

	depends I2C || SPI

>  	select REGMAP
>  	select IIO_BUFFER
>  	select IIO_TRIGGERED_BUFFER
> +	select BMA220_I2C if I2C
>  	select BMA220_SPI if SPI
>  	help
>  	  Say yes here to add support for the Bosch BMA220 triaxial
> @@ -228,7 +229,13 @@ config BMA220
>  
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called bma220_core and you will also get
> -	  bma220_spi if SPI is enabled.
> +	  bma220_i2c if I2C is enabled and bma220_spi if SPI is
> +	  enabled.
> +
> +config BMA220_I2C
> +	tristate
> +	select REGMAP_I2C
> +	depends on BMA220
>  
>  config BMA220_SPI
>  	tristate
> diff --git a/drivers/iio/accel/Makefile b/drivers/iio/accel/Makefile
> index 56a9f848f7f913633bc2a628c1ac5c9190774b9d..fa440a85928398fee927081f605595ba9fbc4ad9 100644
> --- a/drivers/iio/accel/Makefile
> +++ b/drivers/iio/accel/Makefile
> @@ -26,6 +26,7 @@ obj-$(CONFIG_ADXL380_I2C) += adxl380_i2c.o
>  obj-$(CONFIG_ADXL380_SPI) += adxl380_spi.o
>  obj-$(CONFIG_BMA180) += bma180.o
>  obj-$(CONFIG_BMA220) += bma220_core.o
> +obj-$(CONFIG_BMA220_I2C) += bma220_i2c.o
>  obj-$(CONFIG_BMA220_SPI) += bma220_spi.o
>  obj-$(CONFIG_BMA400) += bma400_core.o
>  obj-$(CONFIG_BMA400_I2C) += bma400_i2c.o
> diff --git a/drivers/iio/accel/bma220.h b/drivers/iio/accel/bma220.h
> index f9f4fa3daf33665f07f8bf073468dff070b46d74..384557d10d5613b7d829c6666f3da06de219277a 100644
> --- a/drivers/iio/accel/bma220.h
> +++ b/drivers/iio/accel/bma220.h
> @@ -12,6 +12,7 @@
>  #include <linux/regmap.h>
>  
>  extern const struct regmap_config bma220_spi_regmap_config;
> +extern const struct regmap_config bma220_i2c_regmap_config;

Up to now, i2c is before spi. So would be consistent to keep
doing that.

>  extern const struct dev_pm_ops bma220_pm_ops;
>  
>  int bma220_common_probe(struct device *dev, struct regmap *regmap, int irq);
> diff --git a/drivers/iio/accel/bma220_core.c b/drivers/iio/accel/bma220_core.c
> index 4d8b65ea737a2d5fe74f98da13a582a80874a5af..191074d8618ea2638f69283781b8677921876681 100644
> --- a/drivers/iio/accel/bma220_core.c
> +++ b/drivers/iio/accel/bma220_core.c
> @@ -175,6 +175,24 @@ const struct regmap_config bma220_spi_regmap_config = {
>  };
>  EXPORT_SYMBOL_NS_GPL(bma220_spi_regmap_config, "IIO_BOSCH_BMA220");
>  
> +/*
> + * Based on the datasheet the memory map differs between the SPI and the I2C
> + * implementations. I2C register addresses are simply shifted to the left
> + * by 1 bit yet the register size remains unchanged.
> + * This driver employs the SPI memory map to correlate register names to
> + * addresses regardless of the bus type.
> + */
> +
> +const struct regmap_config bma220_i2c_regmap_config = {
> +	.reg_bits = 8,
> +	.val_bits = 8,
> +	.reg_shift = -1,
> +	.max_register = BMA220_REG_SOFTRESET,
> +	.cache_type = REGCACHE_NONE,
> +	.writeable_reg = bma220_is_writable_reg,
> +};
> +EXPORT_SYMBOL_NS_GPL(bma220_i2c_regmap_config, "IIO_BOSCH_BMA220");
> +
>  static irqreturn_t bma220_trigger_handler(int irq, void *p)
>  {
>  	int ret;
> diff --git a/drivers/iio/accel/bma220_i2c.c b/drivers/iio/accel/bma220_i2c.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..2b63949ea64ee11421e76a2e7c868a922d1f9a12
> --- /dev/null
> +++ b/drivers/iio/accel/bma220_i2c.c
> @@ -0,0 +1,61 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Bosch triaxial acceleration sensor
> + *
> + * Copyright (c) 2025 Petre Rodan <petre.rodan@subdimension.ro>
> + *
> + * Datasheet: https://media.digikey.com/pdf/Data%20Sheets/Bosch/BMA220.pdf
> + * I2C address is either 0x0b or 0x0a depending on CSB (pin 10)
> + */
> +
> +#include <linux/device.h>
> +#include <linux/errno.h>
> +#include <linux/i2c.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/regmap.h>
> +#include <linux/types.h>
> +
> +#include <linux/iio/iio.h>

It doesn't look like the iio header is used. Maybe not device.h either.

> +
> +#include "bma220.h"
> +

