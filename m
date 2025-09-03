Return-Path: <linux-kernel+bounces-798872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8533B4241A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 16:54:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11EF248785B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 14:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF13C30C358;
	Wed,  3 Sep 2025 14:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ElGRsFvJ"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D3D30BB8D
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 14:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756911241; cv=none; b=staL8nlYtpM6R9vY4ZPIpQr+s37ShWsNqMkhY59iSIjZ75MoGUijj/9YVeqoqPxHZRr+03vYK+jLfb/qaNuEzzeNT+Yd1apUJZKX/qUhC7kYwpB3ZMKiBUTV6l8WiGkJaIAoFiyFdG8lmvQYL7gNVCtxyYmC6vBtarYIMEIJDbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756911241; c=relaxed/simple;
	bh=unDqZyH1QB0AZnE+jIy/cbveVXnikGD65lmG99tqIe0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fCeSB6FsP6bAK6O6fQbfpV8rIgmrBrENd54Z4KFPWbCiGoC3XPLi2JO2N4cLY6vhkpBOWHEDNQJHckZ92uZqfrqivskjMxPtPDPzkKAX2aulbUC989yxercWMzSXWnZm6rYzbm308tCsP4iy9Y6tfHKGZPYJrWI/GX5FdX7z1T8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ElGRsFvJ; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3cdc54cabb1so17828f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 07:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756911238; x=1757516038; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yoaNAmWhIibGu6l1WRy5RqFKcSEP315ehpRCdLHsl14=;
        b=ElGRsFvJjKb6W+daOxlv/O2CFyeAtJ9hdLOWpcnFaGSxSPsuYAkaxMmOAg1MW9sP/G
         vLzzNlbMhIlhOer4oDjNeEqtqVnfOO200OW9o9b9qbjgtypayBW2sIMiifggZFNwx14y
         /ZMgdlaE7XoJVhotKXe9+KajSTPcCUWhvfiZJPnwDFRDLRjL4Wq8CS1ZIR6da0mjq7P9
         apEVHzZtQVfRodptHAtsVTcT3/XqT0WDMG5oEnpkm0LRK3fmsw5n7npiV9aP3cKAPzQS
         37F+atFcfecj2TJlaucd08UiTxlytYxBsairpQY68RtR5uBWiIztgvvEJ0a+61TDflWE
         cQeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756911238; x=1757516038;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yoaNAmWhIibGu6l1WRy5RqFKcSEP315ehpRCdLHsl14=;
        b=ZYX7mduC5OF7SamUOV/IjAp6U8780PiCIBka2r3yH93gFXDEN6Mwe1OMud17nFE43o
         VnWGpbqB+PVv2RSsOMT33Q2h+y1t9DbxXLlB2V+NUt7n2Sl/ChXxCD6UWRYvsrqZjY9q
         1dYteEYgObpo2KojKHkjyHRzev7szvCvUF/SIMhvOQkF8/I8E0eRbuhQ0vOm8WqbXuKO
         ZVbtNV7NmmQunGhvoa/tDtQuksJIv3mcIg7aYNBM58QeDT5L3m4wGZgq8Mbis9LG6A/3
         E4ui6Y2uvCmZHKnZyRytrYmdDoRxJlwSVwvVZooiP5yIcv//LfTGhboo3IeVDbzSR6DU
         iRQg==
X-Forwarded-Encrypted: i=1; AJvYcCVqlg8mEWEblhUW3T4uaPBLp1CGonHgtkTimVDA0DVxwcLfAsOygMePBtNfEGy8Yny63oT7g990ePPkXow=@vger.kernel.org
X-Gm-Message-State: AOJu0YymNwZuYudLyKco+ldbtzXILo6LdvtfrO0UNgnm49jcsf9U1nvK
	ErBRmZHHVhRzSZfaeT36ArAyst/YHNanYCEJFr0bxAhsbryLeSn8Vvf3QiTBTNzQFZM=
X-Gm-Gg: ASbGncsW8D0q7ooDuJN4s4PWU+w2mwaFpPm2Xyt2zZb1W0dTIeiUoF35ATbyeAB2cwc
	XF05DZ1LRXWuIz+g/B5mRqnt0YnRgKzUwu3eRZbbdQeqAq4S1k3nQParRKZuqIryqiYOkrscttX
	6z7uh5M8VmkpDUKEMOfzYFGFrHgqSUR273ls8mO6JGwSt5sD8461+f2OQJ74UQ7YNpjsmokMdea
	yJimhbhz+/Q9B1gXM0M3YgKEOOSwI9pFVGUDecizL1eGb5rWNwBkghXaD69q4bAgyz/DH9RxmiL
	Q0p5WzVE0ivcrysn23QSAGCXOA+yoFRJc71q1CtKyCGoNJu6MCcRYXSIgNL6qyeurH/HxilQ4L6
	+N/bJm9gO8bh+tqWG0hzHuRvALnwRc2LsXPbH7WzGYLXgQ2A4bq6sHbA6M03HOgCI6zRn9jUw6W
	7HQLvOJhazdkdbL4LoMD4eUIw=
X-Google-Smtp-Source: AGHT+IHKfKTbLX6DEzjRIqHHgWQYsVAqnbGKlA7TGvZ37mdtddbwJKcqflssNkEpjctd+pomGp9Tmg==
X-Received: by 2002:a05:6000:2908:b0:3d1:8d1e:906 with SMTP id ffacd0b85a97d-3d1e08a06aemr12584267f8f.59.1756911237655;
        Wed, 03 Sep 2025 07:53:57 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:2a30:223c:d73b:565a? ([2a05:6e02:1041:c10:2a30:223c:d73b:565a])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-45b940bbc0dsm89079915e9.2.2025.09.03.07.53.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Sep 2025 07:53:57 -0700 (PDT)
Message-ID: <3659b492-c135-4fe1-9ffe-70877e4da0f5@linaro.org>
Date: Wed, 3 Sep 2025 16:53:56 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] iio: adc: Add the NXP SAR ADC support for the
 s32g2/3 platforms
To: =?UTF-8?Q?Nuno_S=C3=A1?= <noname.nuno@gmail.com>, jic23@kernel.org,
 dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, robh@kernel.org,
 conor+dt@kernel.org, krzk+dt@kernel.org
Cc: linux-iio@vger.kernel.org, s32@nxp.com, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, chester62515@gmail.com, mbrugger@suse.com,
 ghennadi.procopciuc@oss.nxp.com
References: <20250903102756.1748596-1-daniel.lezcano@linaro.org>
 <20250903102756.1748596-3-daniel.lezcano@linaro.org>
 <eedbfbfd1ba625b6750eb3ae20a69301b8bc3ef9.camel@gmail.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <eedbfbfd1ba625b6750eb3ae20a69301b8bc3ef9.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Hi Nuno,

On 03/09/2025 13:20, Nuno Sá wrote:
> On Wed, 2025-09-03 at 12:27 +0200, Daniel Lezcano wrote:
>> From: Stefan-Gabriel Mirea <stefan-gabriel.mirea@nxp.com>
>>
>> The NXP S32G2 and S32G3 platforms integrate a successive approximation
>> register (SAR) ADC. Two instances are available, each providing 8
>> multiplexed input channels with 12-bit resolution. The conversion rate
>> is up to 1 Msps depending on the configuration and sampling window.
>>
>> The SAR ADC supports raw, buffer, and trigger modes. It can operate
>> in both single-shot and continuous conversion modes, with optional
>> hardware triggering through the cross-trigger unit (CTU) or external
>> events. An internal prescaler allows adjusting the sampling clock,
>> while per-channel programmable sampling times provide fine-grained
>> trade-offs between accuracy and latency. Automatic calibration is
>> performed at probe time to minimize offset and gain errors.
>>
>> The driver is derived from the BSP implementation and has been partly
>> rewritten to comply with upstream requirements. For this reason, all
>> contributors are listed as co-developers, while the author refers to
>> the initial BSP driver file creator.
>>
>> All modes have been validated on the S32G274-RDB2 platform using an
>> externally generated square wave captured by the ADC. Tests covered
>> buffered streaming via IIO, trigger synchronization, and accuracy
>> verification against a precision laboratory signal source.
>>
>> Co-developed-by: Alexandru-Catalin Ionita <alexandru-catalin.ionita@nxp.com>
>> Signed-off-by: Alexandru-Catalin Ionita <alexandru-catalin.ionita@nxp.com>
>> Co-developed-by: Ciprian Costea <ciprianmarian.costea@nxp.com>
>> Signed-off-by: Ciprian Costea <ciprianmarian.costea@nxp.com>
>> Co-developed-by: Radu Pirea (NXP OSS) <radu-nicolae.pirea@oss.nxp.com>
>> Signed-off-by: Radu Pirea (NXP OSS) <radu-nicolae.pirea@oss.nxp.com>
>> Signed-off-by: Stefan-Gabriel Mirea <stefan-gabriel.mirea@nxp.com>
>> Co-developed-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>> ---
> 
> Hi David,

s/David/Daniel/ :)

> Just some minor review for now...

Whow, thanks for fast review !

[ ... ]

>> +static int nxp_sar_adc_dma_probe(struct device *dev, struct nxp_sar_adc
>> *info)
>> +{
>> +	struct device *dev_dma;
>> +	int ret;
>> +	u8 *rx_buf;
>> +
>> +	info->dma_chan = devm_dma_request_chan(dev, "rx");
>> +	if (IS_ERR(info->dma_chan))
>> +		return PTR_ERR(info->dma_chan);
>> +
>> +	dev_dma = info->dma_chan->device->dev;
>> +	rx_buf = dma_alloc_coherent(dev_dma, NXP_SAR_ADC_DMA_BUFF_SZ,
>> +				    &info->rx_dma_buf, GFP_KERNEL);
>> +	if (!rx_buf)
>> +		return -ENOMEM;
>> +
> 
> The above needs some discussion at the very least. Have you considered the IIO
> DMA buffer interface? It should be extendable to accommodate any particularity
> of your usecase (or we should at least discuss it).
> 
> With it, you also gain a userspace interface where you can actually share DMA
> buffers in a zero copy fashion. You can also share these buffers with USB
> gadgets. For instance, with libiio, you would be able to fetch samples from your
> host machine (through USB) in a very fast way (zero copy between IIO and USB).
> 
> Setting up DMA to then "having" to push it to a SW buffer and needing a syscall
> to retrieve the data seems counter-productive.

I'm not very used to dma. If there is a better implementation to put in 
place I'll be glad to take any suggestion to understand the approach.

Is there any driver using the IIO DMA buffer interface I can refer to ?

[ ... ]


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

