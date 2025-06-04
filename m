Return-Path: <linux-kernel+bounces-673730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C01BAACE549
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jun 2025 21:42:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08694189B475
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jun 2025 19:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69BF4212FB3;
	Wed,  4 Jun 2025 19:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="oYrLiPE/"
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB2DA1FECAF
	for <linux-kernel@vger.kernel.org>; Wed,  4 Jun 2025 19:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749066112; cv=none; b=koLltBdmGglLEdpBlrRkGCcmyr6q11iLYEpVEhJv+kUMJdSFXIeRtUME5DAwxlMi/HqRP6DdG8T7ovAirHQ5VRegRA6kouoTSIVk+EOhPQM+oGVZ5P5iJOn9TDMJeh1zfznvfYjadAHeDIQmCPU6oQCH+C799JIH8xnly+16GLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749066112; c=relaxed/simple;
	bh=pTrNxse99tNZEA77OJYygduk6B+TUfQJIBFaqEHhGSE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=KKVtwNVUU8H/YaqunnWY8qCjjbJEsohS59BLx/aFDEw6qBzCHGTcQMfxAwuMogCilBuMJi2wvZXZ1H9GHQ2aO49ifxbRF73V/7EYKoraZjqRQLvIgsPEaBNwxaBD45TzxWmAhjcucQTpoDMLE+c/2du4qTg78JSCPINA1UmoVsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=oYrLiPE/; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-60634f82d1aso81608eaf.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jun 2025 12:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1749066109; x=1749670909; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=q5ASF8oqFL6OzHDooXa3YT/1E8Erpn/uDvLXRXzItm0=;
        b=oYrLiPE//28G5vpY+tuIPRQg/I0dd2IjQZ57xOCZiZFR7fbP7xYbj1hmTk/LomyiHO
         Nx2a25Q7ziWT0ysEUXZ8MVWKayl2eDydMaWV0eWh/hrLOyPJCo9GAymZbs7xRN8vWhEZ
         x//ik880Gmt/xjNA44FdLNli4M0VjKZPVJ06VLA+r8HL0m1fZcwq5E2JYjtb43oMcBrV
         lk6wyFGxUOKX6hXXGgcuuEbEFBFgEKjWWXGQm4xNh3ot55vEqTl16822aFh1Pa1NHfiu
         EJkbECVzlOk66LDFWPdrGvL66AkBCR/Exwbh6hMisVDdS8PLyoMtdJnGoXdWrg6qZXlo
         bF+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749066109; x=1749670909;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q5ASF8oqFL6OzHDooXa3YT/1E8Erpn/uDvLXRXzItm0=;
        b=iSFoo40oP8qR5OafJBbDwmkUR22BWX9fAzVM5N7NkYzFwnOt++ojtISkA5t1tFXgyW
         gIjOFHiVPiOfi7EiwC2c+NvBCDisb7WQa6nhJCNHxMUi9xoe1eJIJHV5YmLYkBgLYXrX
         LD1EvXwHMvroDjnAfxkbK6KOKV7FTeHinVNwCrrX4zJNQT2mHKfWyVFmBMuvqa7mxxII
         Qg0QGMCX15ebXR03uVW79l4UD8f3OG1GQ3jsx/hoxkdCWW7x+DeKjsbjW5zWf24kujG8
         qFcaD/Up3LvY7efuPyg75oEKA9IijFsSr5zrYuSM8AlMZCLVOdip0alsm3FjjQqBq5F3
         VaAQ==
X-Forwarded-Encrypted: i=1; AJvYcCVX2XH9JWTTnmj77awuRlf6pQwk/VefPy7OvyH5xGOAM2p1vZc4rlcKwzn2WrlPxuglaad1oBSamH4FDFY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYWS7NbnCUQ87scs104JV9RrUClSeJiXQmI9pk4yqz2pPaHFTm
	T8Ch2nO5WOj8X0t6pdeIBHd4TE7BhKA3nsLHZyIG/ZEnMrZck9I37wHKW+STtlrHOVA=
X-Gm-Gg: ASbGncvht/+IHg2Sxa1SsxhYozKjCMHrl7ZLw3ORwN6XH6QIX3xWkQGdIK243QiB/fF
	Ip5Kfb6EfuzixSqq+aYonHziXRevHqykamymqc0PiPpsacyXHO+AV6ncsCLll1ZRw77bt3lEHwo
	tc2FI8xO2tFqu5B3iqDLssa2j1DFAkpVI+Bql7ED5u6e6yR2oCINJsijGsWfMwYT8I5LE5KdKZZ
	yKf3R591eorOLv+axAMWWFQNOCYtpG6qOfl6QS8uTyDd1xCmAuazmCHXp1ESNQYFDIsCqgVpoiB
	NJSHYoBIbEICrC+8CwDXJwXOxSZfGiaUfKIDmAZa4mrmIzNu1X11jFjqEFOgyBppXm3mbu4AFqM
	rR6Cd+GfKA8xDbziwoQYuGIkKU9hV
X-Google-Smtp-Source: AGHT+IEzy93HXeQ7Hbpo9xrmeoGJR+Xw6IA3XRoiEMldgks4R+FNLRCMMCrJXXJLLkeRORE5KQmorQ==
X-Received: by 2002:a05:6820:f0b:b0:605:f34d:7e00 with SMTP id 006d021491bc7-60f0c84f3dbmr2522592eaf.7.1749066108665;
        Wed, 04 Jun 2025 12:41:48 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:56f4:67ce:c6e3:8f76? ([2600:8803:e7e4:1d00:56f4:67ce:c6e3:8f76])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-60c14c8bafbsm2331178eaf.19.2025.06.04.12.41.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Jun 2025 12:41:48 -0700 (PDT)
Message-ID: <9295ffc8-51aa-440f-8d55-0a6f64e6a352@baylibre.com>
Date: Wed, 4 Jun 2025 14:41:47 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 5/5] iio: adc: ad7405: add ad7405 driver
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
 Esteban Blanc <eblanc@baylibre.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250604133413.1528693-1-pop.ioan-daniel@analog.com>
 <20250604133413.1528693-6-pop.ioan-daniel@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250604133413.1528693-6-pop.ioan-daniel@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 6/4/25 8:34 AM, Pop Ioan Daniel wrote:
> Add support for the AD7405/ADUM770x, a high performance isolated ADC,
> 1-channel, 16-bit with a second-order Σ-Δ modulator that converts an
> analog input signal into a high speed, single-bit data stream.
> 
> Signed-off-by: Pop Ioan Daniel <pop.ioan-daniel@analog.com>
> ---

...

> diff --git a/drivers/iio/adc/ad7405.c b/drivers/iio/adc/ad7405.c
> new file mode 100644
> index 000000000000..a5ca61ad5150
> --- /dev/null
> +++ b/drivers/iio/adc/ad7405.c
> @@ -0,0 +1,262 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Analog Devices AD7405 driver
> + *
> + * Copyright 2025 Analog Devices Inc.
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/kernel.h>

Maybe it wasn't clear in previous reviews, but we like to avoid including
kernel.h because it includes too much, so should be replaced with ofher
more specific headers.

> +#include <linux/module.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/platform_device.h>
> +#include <linux/property.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/util_macros.h>
> +

...

> +
> +static int ad7405_set_dec_rate(struct iio_dev *indio_dev,
> +			       const struct iio_chan_spec *chan,
> +			       unsigned int dec_rate)
> +{
> +	struct ad7405_state *st = iio_priv(indio_dev);
> +	int ret;
> +
> +	if (!iio_device_claim_direct(indio_dev))
> +		return -EBUSY;
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
> +	iio_device_release_direct(indio_dev);

iio_device_release_direct() needs to always be called before returning
after iio_backend_oversampling_ratio_set() is called. So this function
needs some reordering.

It should look like:

	if (!iio_device_claim_direct(indio_dev))
		return -EBUSY;

	ret = iio_backend_oversampling_ratio_set(st->back, chan->scan_index, dec_rate);
	iio_device_release_direct(indio_dev);

With everything else before or after that.

Or move the claim/realease to ad7405_write_raw() so that the entire call
to ad7405_set_dec_rate() is syncronized.

> +
> +	if (ret < 0)
> +		return ret;
> +
> +	return 0;
> +}
> +

...

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
> +	/*
> +	 *Set 256 decimation rate. The default value in the AXI_ADC register

Add space after * to match IIO comment style.

> +	 *is 0, so we set the register with a decimation rate value that is
> +	 *functional for all parts.
> +	 */
> +	ret = ad7405_set_dec_rate(indio_dev, &indio_dev->channels[0], 256);
> +	if (ret)
> +		return ret;
> +
> +	return devm_iio_device_register(dev, indio_dev);
> +}

