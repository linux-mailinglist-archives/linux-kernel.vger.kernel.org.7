Return-Path: <linux-kernel+bounces-813575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0508CB547B1
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 11:33:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A7C116C382
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 09:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA83D274FD3;
	Fri, 12 Sep 2025 09:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cFniJmmQ"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21813238142
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 09:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757669454; cv=none; b=BZRbFH11cXCLHp2fzvCTNunTF++SwkOhwdC3jrF6wS59HwHcxeiPBrlMD92Qsu1Pm3dI+juyD6OX6l4d4S5RPT3Wc63F4n/O7oPR1LrfT4CCdYamF7qrepipniH76nA9vItYnCqAxm/fTqiJPSQHsaxpwQTSFj9CxTkt11bk2d0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757669454; c=relaxed/simple;
	bh=hlFmZz3SH60ObFcUVFihSDYbAv89r8HSRjShTlrdIsU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mZyv4Hu8sE15L3XQkJWRK7UO8IEbWSbEtmw4PRbZ6OwilrIjkeKCD9S9l1P/s2TcpPwd4d8GLtWfMwZACM9eepsrP/FcFOiZNtgEIJ/0Esp/xdoPizPVVD57ZnrccMBB15cwFiWMI16xQuWtUJj2MHPXGpp+piJgpplrH7M6ks0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cFniJmmQ; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-33c9efd65eeso16428311fa.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 02:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757669449; x=1758274249; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1aIzMN9zlpmsGg+d+g9UzqtnL/LipD0ZeBNikSa1LIw=;
        b=cFniJmmQ5Lxb0hkNPsbrIInytWJhan/X+PvCKECdZYZqKMOYXYupkd556Pfn+mWgZb
         rRW1F8kYDS0Vro6110NS4BHxY6ZEndURgbDHuRa1SxVxY68+ZVJPYREbgvw4cN92ObMV
         /K9hojIc5wxhKSVvW19VVo9/RhhBTb5q6OplQ+bFHWYo4/j3TSCpCMn6TrnBjiH9Sapx
         LzPZr9627aDiHobtH1lAFebqVqCDXDiq59qv0hVR0myO+ZGsOG4ax8X4OqpohyEC9lO/
         kNH33uE1lfE/71zASTecwEA3y8iXW0eTXED/mXPYN79+FCWDxbmqfSaQOg2KKdtnzDtA
         b8oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757669449; x=1758274249;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1aIzMN9zlpmsGg+d+g9UzqtnL/LipD0ZeBNikSa1LIw=;
        b=TNcfvKOq4z8l0U0nS431ctGIP538pPuJ3Glf998VH1IrToHVTkNpSriPkvhL3QIAOm
         u9H8MO72ddKRUG2xSh2lpvS7MmN1MYs8Kyhpe3qcqMNafKe/wvbGdOsaztx9ecsmTDv2
         otqRsHi6agbyDw1pk4BfJQnzzFiq4GU3GSei/GalqD35Bg1WlGq3UyvLE5Ik0MkVY+3W
         krVV59eDSIYPzGTbtLqoB9gAd8PmovilLciWOcW02wYjeHrDmYQ5VyihrM65QLIS5Uxy
         Xqbhs+OALmwCvSiRwVNWuaCrISC04GY5Nq40mvdlCeIS9xbZajiwrnMKSd2SJZKQvbYp
         Kj4A==
X-Forwarded-Encrypted: i=1; AJvYcCXSCG6Ag3YdqFnetGUxrtMK5ksRj85xvS5r1Rv7YQfUS7u3RJ37Zx5fu9Fbflt8BqEgxjIr97HCPYpH9Q8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUkLywK4etQUqKgwIllD6yVQyYGzQQ4bNrxbo1T6YlsmoKKsro
	AUOyctTBGd/yTFtZb5YAonEyYyFHc9ie/Mfr9aU2bn7hWWcL4xKJzF/F
X-Gm-Gg: ASbGncthjN19/xOMH1nanN/yv9b1oSrLgMQb8NReT5HRf0ErD7rQLRZOn7Dtbud2Rli
	gMigaUU9tFmfO648UxDVtEFG9h+01TiRWROXBz6vWecS7pGnfGQjmrQmOn60q7K953DmBf7k4FA
	8GC3Q577l9m+ZhOq+BjmvUahEqKLAVHkl+lGQ6+0OkGSNs8V51g6pHgl4VJJKNW/XsveMfAwm99
	FWA65nWSp3WiDHS9+izm5unfvb5zZ5Q79Ihg2yBAjj8ufsO+QE4prt7MQvKDtd3Ij88zmE8g3/c
	6Omb0Rodr0TQFlvehVlOUOg39j7q2UzQXDM5my8EP9S2SvDybALiRULiJwXKCsxofzn00b2Qdzs
	tN7AaAg3YbWSGZtaHcMX4Ma0LVWzEa4kO
X-Google-Smtp-Source: AGHT+IHZhvTFouH7z71/PdL2eJrkzX4Jjes9ijVKOIiaqvUL1DLMmrokCFicYDILisJ+kbtNo+bM5Q==
X-Received: by 2002:a2e:a231:0:b0:337:f84a:6ded with SMTP id 38308e7fff4ca-3514165afb4mr5768781fa.40.1757669448935;
        Fri, 12 Sep 2025 02:30:48 -0700 (PDT)
Received: from [10.38.18.54] ([213.255.186.37])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-34f1b491f41sm7463431fa.57.2025.09.12.02.30.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Sep 2025 02:30:48 -0700 (PDT)
Message-ID: <e29e5003-37bb-4ad7-a64a-45e6f9f1c6d1@gmail.com>
Date: Fri, 12 Sep 2025 12:30:47 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] iio: adc: Support ROHM BD79112 ADC/GPIO
To: David Lechner <dlechner@baylibre.com>, Jonathan Cameron
 <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Linus Walleij <linus.walleij@linaro.org>,
 Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
References: <20250910-bd79112-v4-0-f82f43746a8c@gmail.com>
 <20250910-bd79112-v4-2-f82f43746a8c@gmail.com>
 <92306c8a-a2ec-4a43-80d7-c8e0c1cc0ee1@baylibre.com>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <92306c8a-a2ec-4a43-80d7-c8e0c1cc0ee1@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/09/2025 00:20, David Lechner wrote:
> On 9/10/25 6:24 AM, Matti Vaittinen wrote:
> 
> ...
> 
>> diff --git a/drivers/iio/adc/rohm-bd79112.c b/drivers/iio/adc/rohm-bd79112.c
>> new file mode 100644
>> index 0000000000000000000000000000000000000000..a2a3affe2c6dc86a237a164139c27ec66dc9d131
>> --- /dev/null
>> +++ b/drivers/iio/adc/rohm-bd79112.c
>> @@ -0,0 +1,553 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * ROHM ADC driver for BD79112 signal monitoring hub.
>> + * Copyright (C) 2025, ROHM Semiconductor.
>> + *
>> + * SPI communication derived from ad7923.c and ti-ads7950.c
> 
> Really? I wrote the ti-ads7950 driver and I can't say I see the
> resemblance. ;-)

Really. :) I picked the idea of populating the transfers in the probe 
and using buffers from the driver-data, from these drivers :) Well, I 
admit it ended up being a bit different - but the starting point was 
those drivers ;)

> 
>> + */
>> +
> 
> ...
> 
>> +static int bd79112_get_gpio_pins(const struct iio_chan_spec *cs, int num_channels)
> 
> u32 would make more sense when dealing with bit flags.
> 
>> +{
>> +	int i, gpio_channels;
> 
> same for the local variable.

Meh. Ok :)

> ...
> 
>> +static int bd79112_probe(struct spi_device *spi)
>> +{
> 
> ...
> 
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
> 
> If these messages never change (other than the data in the buffers), you can
> call devm_spi_optimize_message() here on each message to get reduced CPU usage
> on every SPI message for free.
> 

Thanks!

Yours,
	-- Matti


