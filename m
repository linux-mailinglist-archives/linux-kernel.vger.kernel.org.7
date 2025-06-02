Return-Path: <linux-kernel+bounces-670836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04423ACB9E9
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jun 2025 19:00:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC3544026B0
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jun 2025 16:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CC2F226541;
	Mon,  2 Jun 2025 16:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="dv3qoIOH"
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2443A219314
	for <linux-kernel@vger.kernel.org>; Mon,  2 Jun 2025 16:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748883594; cv=none; b=dlcJ9LmEWrKTKiq3f38NbnngefHRq0h2CPAIyvIsoLjI3SP+ht41JnUxvsp9aPbxXXl+j/YBDkwznfFnN2MFDfej3V9r15tQLs7ty+WSj3oQq7XwsRzK40j8nwiL+pMU9h/th/fUVu5mY2q4sO8taXJunWGu7wv09Ek67K5r06g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748883594; c=relaxed/simple;
	bh=hLCMau5YMSaezYEkZcAjhmTJs0p51SrcKofyLoyP440=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Y4vwtAuwaIHJvn6PiFZiAidrVcOq0M6eWRjN+yqM5cc5zDmItgchMamHabO8Vu27Tqj6z24VPfxA0sH6HYc/FVy0XDqOrbH85+Dds3/YYa612TSzIaVesMr5AO4yxLiKi1CTgmboh1FBeXVpMbQxNX6MrNT8AHiLzSMayqydb9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=dv3qoIOH; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-2cc57330163so2807375fac.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jun 2025 09:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1748883590; x=1749488390; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZJRDMPbYGvRNvOHiecbSgnd1erK2y/8jb60RJvda/SU=;
        b=dv3qoIOH0h8m+Pn2pxY8cb6KU+8AoQDSnjeGQ9ZgIsndpTlonW3CgbbbP87A4IYmRv
         ldp27SnTmJ7QhHkIR8XuGlHpHUNjfeUk7uwz8D7PoBexUNrCoBZZ/cnioFvgOY2TCu60
         0gXjexEz2if/U8L5VRyTf4oimLH6j6N4tWbe+/Co644JTvOfgyktgAqDW4Re3v4+ADWd
         sDXOAKBozExBm8onrG8ks/iXRw+vXUD39efxmyuMnDd7q3UVmsWW5YvHmG6m9hljePBY
         aS4UrCe2ckCh+OECSsGSc6ZgEWFsbECsI2IC/RQj/YhzuHI8j4RvW/sRDoAj2NFZg9vr
         TzTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748883590; x=1749488390;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZJRDMPbYGvRNvOHiecbSgnd1erK2y/8jb60RJvda/SU=;
        b=rvzQrMnP9kuq3QY0U4HX2rw/SM6NVicqUQmQWltM7t6W3nrO1/NcpZuezVvcwoQ/Yj
         JDoehJa9RmLn702gZgqswyC4nQvWOOcvknQUEd5olggOQESjLVDDr0TELFyPprMOjYlM
         JfoNpV5zQEsZTnCpDe2ZedwgohtnAEbcDaiM1NzwkZ0YRInP+S1sjREegw82U2kUcNed
         mK63I1iqQpLZl/FtTYQ5MIfL1jY6dp+TqeUI9wHXP1OpXz/Ks2v1dAreWbPKapubMAnp
         pOeKIhmVbCagu0Ns8x8dKqFj1W8lgRKs/+PN48NSzk2iwLMebvvLTF214DZPdOKWwFmB
         aFrQ==
X-Forwarded-Encrypted: i=1; AJvYcCWofuI48Z6Q7vZrxYaAEnrG73a5oRhpyhZ1CYfr/K8TA1DdF5PHj1gEphn2v0dKbZc15DEGt9kNdsnU0WA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9A5njEzQm8mYhYpXw4TBG0FnmDUn8qBrpr/cK+DKDxaBFxm36
	zfgByXu2UkD3FQGE79OCFpp6vCJ0gjymMptq5bViX8GQeXUr8v5PmzY7056IZBlypy0=
X-Gm-Gg: ASbGnct9Vq7goMnOfoYvjMnswVBc3mDLPdVQOeBPDu5ZfVnnBqTxkavmpAH4cu17p+m
	9XHsSzp7e/XxmQMvBFSCXHoP4qZDoIAG70cu5zLPZoKz9kSahDJbPh4ejXZY45G5SKRAdOCRn0Q
	+bUENfLjfKxFeIueLoGfm9f3VbAJA+D1EXDNhsT8rS9lR2A9a56W60FpKvpRCpDgy6aEj+314wI
	56UnCBHDCHIHKOApHqr47dJChpX7byhHClbAV49qMOQtfQhJJxXAfrsa3YabLuwN2jnRHIpH9mH
	rghUdPhhaYYQGo28ZsaFBVYKCyRml3p3tOA/9gF8I9eXhdl5UFLuom/UVW1T6JHBhNmZDn8xkED
	J0UqoJqHcooBKFXcsDJkIXfF+s/eJ
X-Google-Smtp-Source: AGHT+IGQwFXBT/2VEHi6WvcZQOXd5gzFS9vQRZKOYXx2obpDoZmVJN74wDAhDg3cd0XCPg1AOp9EdQ==
X-Received: by 2002:a05:6871:878f:b0:2c2:3eb4:e53 with SMTP id 586e51a60fabf-2e9216a6b5emr7938765fac.37.1748883590051;
        Mon, 02 Jun 2025 09:59:50 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:74f4:5886:86e1:3bcf? ([2600:8803:e7e4:1d00:74f4:5886:86e1:3bcf])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2e906c213e0sm1875447fac.47.2025.06.02.09.59.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Jun 2025 09:59:49 -0700 (PDT)
Message-ID: <f582c6fd-6216-4f6f-8024-ae4a0d28fbbb@baylibre.com>
Date: Mon, 2 Jun 2025 11:59:48 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 5/5] iio: adc: ad7405: add ad7405 driver
To: Pop Ioan Daniel <pop.ioan-daniel@analog.com>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Sergiu Cuciurean <sergiu.cuciurean@analog.com>,
 Dragos Bogdan <dragos.bogdan@analog.com>,
 Antoniu Miclaus <antoniu.miclaus@analog.com>,
 Olivier Moysan <olivier.moysan@foss.st.com>,
 Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 Matti Vaittinen <mazziesaccount@gmail.com>,
 Tobias Sperling <tobias.sperling@softing.com>,
 Alisa-Dariana Roman <alisadariana@gmail.com>,
 Marcelo Schmitt <marcelo.schmitt@analog.com>,
 Thomas Bonnefille <thomas.bonnefille@bootlin.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250602134349.1930891-1-pop.ioan-daniel@analog.com>
 <20250602134349.1930891-6-pop.ioan-daniel@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250602134349.1930891-6-pop.ioan-daniel@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 6/2/25 8:43 AM, Pop Ioan Daniel wrote:
> Add support for the AD7405/ADUM770x, a high performance isolated ADC,
> 1-channel, 16-bit with a second-order Σ-Δ modulator that converts an
> analog input signal into a high speed, single-bit data stream.
> 
> Signed-off-by: Pop Ioan Daniel <pop.ioan-daniel@analog.com>
> ---
> changes in v5:
>  - add range checking for dec_rate
>  - remove ad7405_get_scale function
>  - check for negative values in ad7405_write_raw function
>  - remove unuseful comment
>  - remove indio_dev -> dev.parent = dev
>  - fix IIO_CHAN_INFO_OFFSET
>  - add struct mutex lock
>  drivers/iio/adc/Kconfig  |  10 ++
>  drivers/iio/adc/Makefile |   1 +
>  drivers/iio/adc/ad7405.c | 256 +++++++++++++++++++++++++++++++++++++++
>  3 files changed, 267 insertions(+)
>  create mode 100644 drivers/iio/adc/ad7405.c
> 
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index ad06cf556785..43af2070e27f 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -251,6 +251,16 @@ config AD7380
>  	  To compile this driver as a module, choose M here: the module will be
>  	  called ad7380.
>  
> +config AD7405
> +	tristate "Analog Device AD7405 ADC Driver"
> +	depends on IIO_BACKEND
> +	help
> +	  Say yes here to build support for Analog Devices AD7405, ADUM7701,
> +	  ADUM7702, ADUM7703 analog to digital converters (ADC).
> +
> +	  To compile this driver as a module, choose M here: the module will be
> +	  called ad7405.
> +
>  config AD7476
>  	tristate "Analog Devices AD7476 1-channel ADCs driver and other similar devices from AD and TI"
>  	depends on SPI
> diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> index 07d4b832c42e..8115f30b7862 100644
> --- a/drivers/iio/adc/Makefile
> +++ b/drivers/iio/adc/Makefile
> @@ -26,6 +26,7 @@ obj-$(CONFIG_AD7291) += ad7291.o
>  obj-$(CONFIG_AD7292) += ad7292.o
>  obj-$(CONFIG_AD7298) += ad7298.o
>  obj-$(CONFIG_AD7380) += ad7380.o
> +obj-$(CONFIG_AD7405) += ad7405.o
>  obj-$(CONFIG_AD7476) += ad7476.o
>  obj-$(CONFIG_AD7606_IFACE_PARALLEL) += ad7606_par.o
>  obj-$(CONFIG_AD7606_IFACE_SPI) += ad7606_spi.o
> diff --git a/drivers/iio/adc/ad7405.c b/drivers/iio/adc/ad7405.c
> new file mode 100644
> index 000000000000..6199a6661ff5
> --- /dev/null
> +++ b/drivers/iio/adc/ad7405.c
> @@ -0,0 +1,256 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Analog Devices AD7405 driver
> + *
> + * Copyright 2025 Analog Devices Inc.
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/module.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/platform_device.h>
> +#include <linux/property.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/util_macros.h>
> +#include <linux/mutex.h>
> +
> +#include <linux/iio/backend.h>
> +#include <linux/iio/iio.h>
> +
> +static const unsigned int ad7405_dec_rates[] = {
> +	4096, 2048, 1024, 512, 256, 128, 64, 32,
> +};

It looks lilke this should be a range, not a list. The driver
currently allows any value to be passed to the backend, not
just these values.

Or if these are the only values that make sense for this
ADC chip even if the backend allows other values, then
we should do more checking in this driver to ensure only
these values can be passed to the backend.

> +
> +struct ad7405_chip_info {
> +	const char *name;
> +	struct iio_chan_spec channel;
> +	const unsigned int full_scale_mv;
> +};
> +
> +struct ad7405_state {
> +	struct iio_backend *back;
> +	const struct ad7405_chip_info *info;
> +	/*
> +	 *Synchronize access to members the of driver state, and ensure
> +	 *atomicity of consecutive regmap operations.

There is no regmap.

> +	 */
> +	struct mutex lock;

This is never initalized.

> +	unsigned int ref_frequency;
> +	unsigned int dec_rate;
> +};
> +
> +static int ad7405_set_dec_rate(struct iio_dev *indio_dev,
> +			       const struct iio_chan_spec *chan,
> +			       unsigned int dec_rate)
> +{
> +	struct ad7405_state *st = iio_priv(indio_dev);
> +	int ret;
> +
> +	guard(mutex)(&st->lock);

Why not iio_device_claim_direct() instead? Seems like it could be
probalamatic if this was changed in the middle of a buffered read.

> +
> +	if (dec_rate > 4096 || dec_rate < 32)
> +		return -EINVAL;
> +
> +	ret = iio_backend_oversampling_ratio_set(st->back, chan->scan_index, dec_rate);
> +	if (ret)
> +		return ret;
> +
> +	st->dec_rate = dec_rate;
> +
> +	return 0;
> +}
> +
> +static int ad7405_read_raw(struct iio_dev *indio_dev,
> +			   const struct iio_chan_spec *chan, int *val,
> +			   int *val2, long info)
> +{
> +	struct ad7405_state *st = iio_priv(indio_dev);
> +
> +	switch (info) {
> +	case IIO_CHAN_INFO_SCALE:
> +		*val = st->info->full_scale_mv;
> +		*val2 = st->info->channel.scan_type.realbits - 1;
> +		return IIO_VAL_FRACTIONAL_LOG2;
> +	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
> +		*val = st->dec_rate;
> +		guard(mutex)(&st->lock);

Taking the mutex here does nothing. Maybe it was meant to go before
*val = st->dec_rate;

But I'm not sure that is really necessary. 

> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		*val = DIV_ROUND_CLOSEST_ULL(st->ref_frequency, st->dec_rate);
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_OFFSET:
> +		*val = -(1 << (st->info->channel.scan_type.realbits - 1));
> +		return IIO_VAL_INT;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int ad7405_write_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *chan, int val,
> +			    int val2, long info)
> +{
> +	switch (info) {
> +	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
> +		if (val < 0)
> +			return -EINVAL;
> +		return ad7405_set_dec_rate(indio_dev, chan, val);
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int ad7405_read_avail(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan,
> +			     const int **vals, int *type, int *length,
> +			     long info)
> +{
> +	switch (info) {
> +	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
> +		*vals = ad7405_dec_rates;
> +		*length = ARRAY_SIZE(ad7405_dec_rates);
> +		*type = IIO_VAL_INT;
> +		return IIO_AVAIL_LIST;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static const struct iio_info ad7405_iio_info = {
> +	.read_raw = &ad7405_read_raw,
> +	.write_raw = &ad7405_write_raw,
> +	.read_avail = &ad7405_read_avail,
> +};
> +
> +#define AD7405_IIO_CHANNEL {					\
> +	.type = IIO_VOLTAGE,					\
> +	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |	\
> +			BIT(IIO_CHAN_INFO_OFFSET),		\
> +	.info_mask_shared_by_all = IIO_CHAN_INFO_SAMP_FREQ |	\
> +			BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),	\
> +	.info_mask_shared_by_all_available =			\
> +			BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),	\
> +	.indexed = 1,						\
> +	.channel = 0,						\
> +	.channel2 = 1,						\
> +	.differential = 1,					\
> +	.scan_index = 0,					\
> +	.scan_type = {						\
> +		.sign = 'u',					\
> +		.realbits = 16,					\
> +		.storagebits = 16,				\
> +	},							\
> +}
> +
> +static const struct ad7405_chip_info ad7405_chip_info = {
> +	.name = "AD7405",

In all the other ADI drivers, the name is lower case, so we should
to the same here to be consistent.

> +	.full_scale_mv = 320,
> +	.channel = AD7405_IIO_CHANNEL,
> +};
> +
> +static const struct ad7405_chip_info adum7701_chip_info = {
> +	.name = "ADUM7701",
> +	.full_scale_mv = 320,
> +	.channel = AD7405_IIO_CHANNEL,
> +};
> +
> +static const struct ad7405_chip_info adum7702_chip_info = {
> +	.name = "ADUM7702",
> +	.full_scale_mv = 64,
> +	.channel = AD7405_IIO_CHANNEL,
> +};
> +
> +static const struct ad7405_chip_info adum7703_chip_info = {
> +	.name = "ADUM7703",
> +	.full_scale_mv = 320,
> +	.channel = AD7405_IIO_CHANNEL,
> +};
> +
> +static const char * const ad7405_power_supplies[] = {
> +	"vdd1",	"vdd2",
> +};
> +
> +static int ad7405_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct iio_dev *indio_dev;
> +	struct ad7405_state *st;
> +	struct clk *clk;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	st = iio_priv(indio_dev);
> +
> +	st->info = device_get_match_data(dev);
> +	if (!st->info)
> +		return dev_err_probe(dev, -EINVAL, "no chip info\n");
> +
> +	ret = devm_regulator_bulk_get_enable(dev, ARRAY_SIZE(ad7405_power_supplies),
> +					     ad7405_power_supplies);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to get and enable supplies");
> +
> +	clk = devm_clk_get_enabled(dev, NULL);
> +	if (IS_ERR(clk))
> +		return PTR_ERR(clk);
> +
> +	st->ref_frequency = clk_get_rate(clk);
> +	if (!st->ref_frequency)
> +		return -EINVAL;
> +
> +	indio_dev->name = st->info->name;
> +	indio_dev->channels = &st->info->channel;
> +	indio_dev->num_channels = 1;
> +	indio_dev->info = &ad7405_iio_info;
> +
> +	st->back = devm_iio_backend_get(dev, NULL);
> +	if (IS_ERR(st->back))
> +		return dev_err_probe(dev, PTR_ERR(st->back),
> +				     "failed to get IIO backend");
> +
> +	ret = iio_backend_chan_enable(st->back, 0);
> +	if (ret)
> +		return ret;
> +
> +	ret = devm_iio_backend_request_buffer(dev, st->back, indio_dev);
> +	if (ret)
> +		return ret;
> +
> +	ret = devm_iio_backend_enable(dev, st->back);
> +	if (ret)
> +		return ret;
> +

Would not hurt to have a comment explaining why 256 is chosen for the
default value.

> +	ret = ad7405_set_dec_rate(indio_dev, &indio_dev->channels[0], 256);
> +	if (ret)
> +		return ret;
> +
> +	return devm_iio_device_register(dev, indio_dev);
> +}
> +
> +static const struct of_device_id ad7405_of_match[] = {
> +	{ .compatible = "adi,ad7405", .data = &ad7405_chip_info, },
> +	{ .compatible = "adi,adum7701", .data = &adum7701_chip_info, },
> +	{ .compatible = "adi,adum7702", .data = &adum7702_chip_info, },
> +	{ .compatible = "adi,adum7703", .data = &adum7703_chip_info, },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, ad7405_of_match);
> +
> +static struct platform_driver ad7405_driver = {
> +	.driver = {
> +		.name = "ad7405",
> +		.owner = THIS_MODULE,
> +		.of_match_table = ad7405_of_match,
> +	},
> +	.probe = ad7405_probe,
> +};
> +module_platform_driver(ad7405_driver);
> +
> +MODULE_AUTHOR("Dragos Bogdan <dragos.bogdan@analog.com>");
> +MODULE_AUTHOR("Pop Ioan Daniel <pop.ioan-daniel@analog.com>");
> +MODULE_DESCRIPTION("Analog Devices AD7405 driver");
> +MODULE_LICENSE("GPL");
> +MODULE_IMPORT_NS("IIO_BACKEND");


