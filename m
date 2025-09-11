Return-Path: <linux-kernel+bounces-811362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AEC3B52811
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 07:13:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6E90688218
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 05:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CADA6241CB7;
	Thu, 11 Sep 2025 05:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lkzRScIg"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 306472253FD
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 05:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757567589; cv=none; b=XgcE9fsSNQ5Touj6mjQP3vsUhrN9zg0s+UeEM1VJpaJdiPNr0TdVIOkJaaREI5eangAmvKbE8QE2TTNA0miauU4uGW1/qT1kNXyo22V+dTmqAlZf1+4ejYbogEFFnAkcWjQY9wvv14EQxguD9//9K94eT16Y4beMC73fwvMmSL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757567589; c=relaxed/simple;
	bh=SlJPMqOheOyXWY5HcaBVfLVMDApWLwnsdWlRM24nlZs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FRo2Ougu/vY1u2Q9CfwLg2wIFWebF0eHdT7K5d2Jt/ykIDjc9viO/zlGbiUfVTYCL23xPS7xH9BUuV7YK0n2m1esjz9LBs4zbUn4f+Pj9Erj1RBuNvp1bv6Csbx7NQbsQDB7I9ZSr65SqcKgAw+TewI1mjVn1kh5SaVIQt0c9zM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lkzRScIg; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5608d792558so318712e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 22:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757567585; x=1758172385; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n9GGmtguUyZu6hbZSSx1TCfWfDEPuY49znudTzJtGCg=;
        b=lkzRScIgMN4bN/tavcpawIOp1r+AUQPBAPzwaIJc5e4soJwd5gDJpGgc81EF/3KF/g
         vkPbcoigjlFDb1rtGSeBPVyJiuJNWRq89mJaQJ5Z6DM1Txj5WEOggxFpMjmstl171Lxr
         iN0uBYBnO02LlcrBGXXSvsUtYgao5jrHjY6ALpDcL58aLUjqTkP7pnqpKO8LLbd5NLgi
         XtnQLSJ/wn9E1MDKeVK8c2ocejB86SIlShpU5FBqlumSWtf6QHzrHdDoZUn8hUl8TeCz
         EUg8ARYEupcit17YBtspB6IZ+DAT9f6+I8nkBWPx5sIiSB19bGN5g7JPY9oxhV+b7zEe
         UTXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757567585; x=1758172385;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n9GGmtguUyZu6hbZSSx1TCfWfDEPuY49znudTzJtGCg=;
        b=c6yejqJFSirC0bgYdcgdRj7lMT9yrOee60bNZdHkF62ORJHpc75G98t+fmAGR0Xtkb
         kqy3n15tFgligjxeC3qH/xdauFmRQj4r9anSoSZC4O5wq8rWfpFCjngdwe+V454agTyq
         nT1dCfr7g+FsA4PxsncCzPj2qF6joo5CF/ro1gKZBvbIwopS7sDrFPv6CKVhZYsgZbEj
         rrt3OTb6l1xs40cozfv4mCnnVpMP3LJ5daeGNJfNOLFX/AHE9TAjwvJ7Urrkn6kr5KQz
         nJK7x/JWZqYcfAc1y9LheoYLdfzBn+fBL7VPTPWsWjBZzicrqrq9oyOyjTQZnuLpn27p
         Gm4w==
X-Forwarded-Encrypted: i=1; AJvYcCUn8p7gjDsrf2o5nI8wdASCcJOwWXuwNmTyxvBgaWOsPRQ0bgdcCD/kPI4XGnP3UCz1I9pYrJkK0kCqrEM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJ8SDcLzLdgFzBaqNXEFbWD9rRPI9yHOyehV0qcQJI/5LbRUZM
	2XsRMX577yuH2SVPN1hSV+ZlgGqNRFsn5wMUCRu4IYJfsnJlC8d01ue7
X-Gm-Gg: ASbGncs56cblIDHnloD0vy48JGMNlCufVREWUKtnJ3oeKNnQLYNI9C6Vt0QFEbVoUnb
	gwsiCQ5yfXGxCVSrQ8vkrFJPJzGG4SHE02Rxh++otJlH/2sGhYKQ1u5D/kHReSAnf9KH5kr8Mvz
	gAO6B2WnXcR7VCTuZiu4/TgUheeFOR270YLZIH+sd1KSnM1D05RGNjjt14TK0OiGqAknLJQ3a96
	Yltj5G4wrQMaqw+dp8zbqbNLIt2McxT0pmL3a/38tMXAA+1D8xLycKpDmoFwmC3tf1m6s1dcLL0
	GKr5/q69/Psmmy4yaT8YI5Bog5UAQ5FxL+B/6Bxu5psiypcE0pThiFJ0SVF4H59RAqSspk+lZ/Y
	UbryIp3YDJvEIwQqr9q8j093dpvrEG/ClGtlgBeArwUYaacR4aOkq3Zhz5fbzRLLA/kcvx4fKLf
	qDHvcMxwKl3bmk/wDmKplQTWfmng==
X-Google-Smtp-Source: AGHT+IGbO2TNLW7OztisIpnUEWi1m59CsNk+mU6orscsOd8TRI1mD2wU7d2RFQgpdeFyzU4p4mhlXw==
X-Received: by 2002:a05:6512:acc:b0:55b:9045:ec5e with SMTP id 2adb3069b0e04-5625f535a6amr6672349e87.18.1757567584892;
        Wed, 10 Sep 2025 22:13:04 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-56e63c63eeesm159703e87.88.2025.09.10.22.13.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Sep 2025 22:13:04 -0700 (PDT)
Message-ID: <d586b4a3-8fb8-45b5-a5a6-5bee8d366879@gmail.com>
Date: Thu, 11 Sep 2025 08:13:03 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] iio: adc: Support ROHM BD79112 ADC/GPIO
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Linus Walleij
 <linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
References: <20250910-bd79112-v4-0-f82f43746a8c@gmail.com>
 <20250910-bd79112-v4-2-f82f43746a8c@gmail.com>
 <20250910184619.0303163d@jic23-huawei>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20250910184619.0303163d@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Morning Jonathan,

On 10/09/2025 20:46, Jonathan Cameron wrote:
> On Wed, 10 Sep 2025 14:24:35 +0300
> Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> 
>> The ROHM BD79112 is an ADC/GPIO with 32 channels. The channel inputs can
>> be used as ADC or GPIO. Using the GPIOs as IRQ sources isn't supported.
>>
>> The ADC is 12-bit, supporting input voltages up to 5.7V, and separate I/O
>> voltage supply. Maximum SPI clock rate is 20 MHz (10 MHz with
>> daisy-chain configuration) and maximum sampling rate is 1MSPS.
>>
>> The IC does also support CRC but it is not implemented in the driver.
>>
>> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> 
> Hi Matti,
> 
> A few trivial things that I'll tidy up if nothing else comes up (I might not
> bother given how trivial they are!)

Thanks again!

> Also one question. I couldn't immediately follow why any random register
> read is sanity checking if an ADC pin is configured as GPIO.
> 

Ah. Valid question! I see my comment below is partially wrong.


>> +/*
>> + * Read transaction consists of two 16-bit sequences separated by CSB.
>> + * For register read, 'IOSET' bit must be set. For ADC read, IOSET is cleared
>> + * and ADDR equals the channel number (0 ... 31).
>> + *
>> + * First 16-bit sequence, MOSI as below, MISO data ignored:
>> + * - SCK: | 1 | 2 |   3   |    4   | 5 .. 8 | 9 .. 16 |
>> + * - MOSI:| 0 | 0 | IOSET | RW (1) |  ADDR  |  8'b0   |
>> + *
>> + * CSB released and re-acquired between these sequences
>> + *
>> + * Second 16-bit sequence, MISO as below, MOSI data ignored:
>> + *   For Register read data is 8 bits:
>> + *   - SCK: | 1 .. 8 |   9 .. 16   |
>> + *   - MISO:|  8'b0  | 8-bit data  |
>> + *
>> + *   For ADC read data is 12 bits:
>> + *   - SCK: | 1 .. 4 |   4 .. 16   |
>> + *   - MISO:|  4'b0  | 12-bit data |

This is not 100% true. I overlooked the ADC read "status flag" when 
adding this comment for the ADC data reading.

This should be:

  *   For ADC, read data is 12 bits prepended with a status flag:
  *   - SCK: | 1 |      2      | 3  4 |   4 .. 16   |
  *   - MISO:| 0 | STATUS_FLAG | 2'b0 | 12-bit data |

The 'STATUS_FLAG' is set if the input pin is configured as a GPIO.

>> + */
>> +static int bd79112_reg_read(void *context, unsigned int reg, unsigned int *val)
>> +{
>> +	struct bd79112_data *data = context;
>> +	int ret;
>> +
>> +	if (reg & BD79112_BIT_IO)
>> +		reg |= BD79112_BIT_RW;
>> +
>> +	data->read_tx[0] = reg;
>> +
>> +	ret = spi_sync(data->spi, &data->read_msg);
>> +	if (!ret)
>> +		*val = be16_to_cpu(data->read_rx);
>> +
>> +	if (reg & BD79112_BIT_IO && *val & BD79112_ADC_STATUS_FLAG)
>> +		dev_err(data->dev, "ADC pin configured as GPIO\n");
> 
> Why are we checking this in a regmap callback?
> Maybe it needs rewording and the point is some missmatch in what we
> can read vs the state?
> 
>> +
>> +	return ret;
>> +}
> 
>> +
>> +static int bd79112_probe(struct spi_device *spi)
>> +{
>> +	struct bd79112_data *data;
>> +	struct iio_dev *iio_dev;
>> +	struct iio_chan_spec *cs;
>> +	struct device *dev = &spi->dev;
>> +	unsigned long gpio_pins, pin;
>> +	unsigned int i;
>> +	int ret;
>> +
>> +	iio_dev = devm_iio_device_alloc(dev, sizeof(*data));
>> +	if (!iio_dev)
>> +		return -ENOMEM;
>> +
>> +	data = iio_priv(iio_dev);
>> +	data->spi = spi;
>> +	data->dev = dev;
>> +	data->map = devm_regmap_init(&spi->dev, NULL, data, &bd79112_regmap);
> 
> 	data->mpa = devm_regmap_init(dev, ...
> 
> 
>> +	if (IS_ERR(data->map))
>> +		return dev_err_probe(dev, PTR_ERR(data->map),
>> +				     "Failed to initialize Regmap\n");
>> +
>> +	ret = devm_regulator_get_enable_read_voltage(dev, "vdd");
>> +	if (ret < 0)
>> +		return dev_err_probe(dev, ret, "Failed to get the Vdd\n");
>> +
>> +	data->vref_mv = ret / 1000;
>> +
>> +	ret = devm_regulator_get_enable(dev, "iovdd");
>> +	if (ret < 0)
>> +		return dev_err_probe(dev, ret, "Failed to enable I/O voltage\n");
>> +
>> +	data->read_xfer[0].tx_buf = &data->read_tx[0];
>> +	data->read_xfer[0].len = sizeof(data->read_tx);
>> +	data->read_xfer[0].cs_change = 1;
>> +	data->read_xfer[1].rx_buf = &data->read_rx;
>> +	data->read_xfer[1].len = sizeof(data->read_rx);
>> +	spi_message_init_with_transfers(&data->read_msg, data->read_xfer, 2);
>> +
>> +	data->write_xfer.tx_buf = &data->reg_write_tx[0];
>> +	data->write_xfer.len = sizeof(data->reg_write_tx);
>> +	spi_message_init_with_transfers(&data->write_msg, &data->write_xfer, 1);
>> +
>> +	ret = devm_iio_adc_device_alloc_chaninfo_se(dev, &bd79112_chan_template,
>> +						    BD79112_MAX_NUM_CHANNELS - 1,
>> +						    &cs);
>> +
>> +	/* Register all pins as GPIOs if there are no ADC channels */
>> +	if (ret == -ENOENT)
>> +		goto register_gpios;
>> +
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	iio_dev->num_channels = ret;
>> +	iio_dev->channels = cs;
>> +
>> +	for (i = 0; i < iio_dev->num_channels; i++) {
>> +		unsigned int ch = cs[i].channel;
>> +
>> +		cs[i].datasheet_name = bd79112_chan_names[ch];
> 
> Could have done
> 
> 		cs[i].datasheet_name = bd79112_chan_names[cs[i].channel];
> 
> and I don't think it makes it harder to read, but doesn't matter enough to respin.

I kind of agree. It stays short and allows us to get rid of the 
brackets. Thanks!

I can still re-spin this later this week, assuming you rather not fix 
the data-format comment while applying :)

Thanks for pointing this out!

Yours,
	-- Matti

