Return-Path: <linux-kernel+bounces-855321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C33BBE0E40
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 00:01:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E00E119C63E9
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 22:02:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDE287262F;
	Wed, 15 Oct 2025 22:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="AR+b1EI/"
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA417253B71
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 22:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760565688; cv=none; b=jRa3CeTIc9fOxsPB6CBSPz4liDLZL+zRS3zAhPjI6huSaOwsdoS6PU4gnHLxw0HhkIoRMPJGvT4UKviRlGxedjcSUmVA/iEFARha4QbUIsRo+Pc90ZMkenS1SxhTNdx0dS3Fr+jJZwL0Ydng1KeAxbNqHDT4/s23SPS24KuPhwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760565688; c=relaxed/simple;
	bh=ivYFnPwosDasLCf4bTnC4t7wbWohepcJZp85u+LWQj4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TDSzVyr1imVRSNpHM80Fdy9JaKRqiBLl87bwXEXyiQhfp6X+7YDMk7rAJlU+K80mx1GwbCnKOctfyEAgZ72jGbeQy0iyfJvy4Dm2CQuMSMIvN0m3DVjsOxVtmmrET1o6XEidH677UlFb1ZRfr35J9FvDe2W/6OrsSsZrpTrEXu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=AR+b1EI/; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7bc626c5467so51502a34.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 15:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1760565685; x=1761170485; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1L+yEKnDVHKCFi/+mzMQJngjwB10FbzOmuHQmkZoHW8=;
        b=AR+b1EI/s47rfYdA+kRADE0Ww1nHbX7vEgxPLhP+uUqpKJ0KESYuTS+KDd2kgJ8GgY
         qAtW4353wVvSeTqfa4yOqhmrOWf9Do93HTyNa1tokZvXn+43n44F/C5tWGnSEdosH/ek
         n+atlXSNqKRr0L5KXIlE5bMuLTT3V8NmQISh9vi0EJ0vukKWl8MXyyoKp5dQPYObDW0q
         e77hZROJzMq9DcXXJOWCuFmgQ30h7V3M1XGUOLzQrzIWXTO3lJ7sbkxSIzjXKGRXFc73
         PZth5/6pCfvkhVazAiVgkQUgTkJcFjX1rO7Tgg0TszhwK5wrlhcGzzPImTqAZgq/svzu
         pTtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760565685; x=1761170485;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1L+yEKnDVHKCFi/+mzMQJngjwB10FbzOmuHQmkZoHW8=;
        b=c72N3A3vLBZqtuKTXKrNhSvAK+xqeiU2s5hXlKdI+UMFHpggMAuQ5jYgIbiVJDVluW
         e4bqj5bAyfudal93HxbZfdFF8AYvYzdl2CnJj7d0XCtAIBbS+UE6wZ86z0JtUQRBPHEq
         f9kyLyCgJSKjvZFnOvQWJV5DvW+/9ox2lOjAenLgf9sVxhVTYlmGvRVsCfkGTVOTaQ+r
         Etb5+bXeM+j2eDLtEAqU1KpzlgaijXkuu/ydyv9EEx/jGD01QL4jLyQw8qoVw16k/C25
         zt5W80MYyNlnTpJ81hnO6c1g1eZVoeGOJcNs5nETB9T7lJZigH4c4Jh4rCU8FS72t3gD
         M6Dw==
X-Forwarded-Encrypted: i=1; AJvYcCX96ULM6ugcsi5ynDU0vOZqHXJ0iVtLUho3ACr8Dp5ogx9/abdp/6yfTfCoIRSEqm/FN8+K9P0eesTle48=@vger.kernel.org
X-Gm-Message-State: AOJu0YytdAE7Itf23xxfTAAEvwSKz3idtbloO16qhpMXvwBkr/K6eG8d
	a6+bIpWVkRO9siBSCsLyOrhMFswFUy90/yyMoojM7XX8CNMLSGqTUsNTIHBD7UG1Ieo=
X-Gm-Gg: ASbGncuNUnw9meNp91jMKhW9308jKs8pBx9sjmdKQTUrpjbYlA2DyHtNHPCPhixd6Dv
	r0b5eDCek8WQ60FWdGmZByDdXC+EwxaJ2DJpl6PE3ri/CavEdPEk4SvYMqG32ZBIt1HdvDwbZOY
	3PVAE0zPrgF2x8PX0cuwdGoNGFHO2N28fqGVuKdCQEPVJJYHB9WoP76GhKDcnKWNEyIpC2aWh+H
	WW4ZDbRNFIpT+E5cpXt1Y0RqXMyKarUmtENEYceVbgu5MQRphGlBLA8Qo6eUOmvpzeJN8BoQaEW
	In7b9WmUTMIojSHbKRCqIZ915Rc8eM7VjHJcXiT0ZdlozPZyqddTq/6Rh45N0mfmw0h2Ya8rA+U
	b57wRErRKIh3Gt98wBCjkd4EjL4eMWtEMPBHTSOOveBqfMBqDewk6jw//ARsN/i1j3Fc1QNGjQH
	SekVdN4cOv8hC51gZl71sxGmiWhi308k8dkSYEn14p2YZXHWI=
X-Google-Smtp-Source: AGHT+IEX5hvXmn9UjZsBKQ0Hsx3hl8uxgDAS79OfkLE+xLuN78czXcOVDV7GvX8Pk5iqXK+4MsMs6A==
X-Received: by 2002:a05:6830:d10:b0:743:968b:3440 with SMTP id 46e09a7af769-7c0df79ad52mr18475439a34.20.1760565684799;
        Wed, 15 Oct 2025 15:01:24 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:86b5:623:b364:9913? ([2600:8803:e7e4:500:86b5:623:b364:9913])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7c0f90fb491sm5770115a34.20.2025.10.15.15.01.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Oct 2025 15:01:24 -0700 (PDT)
Message-ID: <39794baf-0a9f-465e-916d-6d5340e508de@baylibre.com>
Date: Wed, 15 Oct 2025 17:01:22 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] spi: axi-spi-engine: support
 SPI_MULTI_BUS_MODE_STRIPE
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Marcelo Schmitt <marcelo.schmitt@analog.com>,
 Michael Hennerich <michael.hennerich@analog.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Andy Shevchenko <andy@kernel.org>,
 Sean Anderson <sean.anderson@linux.dev>, linux-spi@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org
References: <20251014-spi-add-multi-bus-support-v1-0-2098c12d6f5f@baylibre.com>
 <20251014-spi-add-multi-bus-support-v1-4-2098c12d6f5f@baylibre.com>
 <aPAJwqdFY7ldtt-F@debian-BULLSEYE-live-builder-AMD64>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <aPAJwqdFY7ldtt-F@debian-BULLSEYE-live-builder-AMD64>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/15/25 3:53 PM, Marcelo Schmitt wrote:
> On 10/14, David Lechner wrote:
>> Add support for SPI_MULTI_BUS_MODE_STRIPE to the AXI SPI engine driver.
>>
>> The v2.0.0 version of the AXI SPI Engine IP core supports multiple
>> buses. This can be used with SPI_MULTI_BUS_MODE_STRIPE to support
>> reading from simultaneous sampling ADCs that have a separate SDO line
>> for each analog channel. This allows reading all channels at the same
>> time to increase throughput.
>>
>> Signed-off-by: David Lechner <dlechner@baylibre.com>
>> ---
>>  drivers/spi/spi-axi-spi-engine.c | 128 +++++++++++++++++++++++++++++++++++++--
>>  1 file changed, 124 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/spi/spi-axi-spi-engine.c b/drivers/spi/spi-axi-spi-engine.c
>> index e06f412190fd243161a0b3df992f26157531f6a1..707e5108efec41f7eff608a09fcebd9d28fa2d70 100644
>> --- a/drivers/spi/spi-axi-spi-engine.c
>> +++ b/drivers/spi/spi-axi-spi-engine.c
>> @@ -23,6 +23,9 @@
>>  #include <linux/spi/spi.h>
>>  #include <trace/events/spi.h>
>>  
>> +#define SPI_ENGINE_REG_DATA_WIDTH		0x0C
>> +#define   SPI_ENGINE_REG_DATA_WIDTH_NUM_OF_SDIO_MASK	GENMASK(24, 16)
> would it be 8-bit mask?
> #define   SPI_ENGINE_REG_DATA_WIDTH_NUM_OF_SDIO_MASK   GENMASK(23, 16)

Ah, good catch.

> 
>> +#define   SPI_ENGINE_REG_DATA_WIDTH_MASK		GENMASK(15, 0)
>>  #define SPI_ENGINE_REG_OFFLOAD_MEM_ADDR_WIDTH	0x10
>>  #define SPI_ENGINE_REG_RESET			0x40
>>  
> ...
>>  
>> +	data_width_reg_val = readl(spi_engine->base + SPI_ENGINE_REG_DATA_WIDTH);
>> +
>>  	if (adi_axi_pcore_ver_gteq(version, 1, 1)) {
>>  		unsigned int sizes = readl(spi_engine->base +
>>  				SPI_ENGINE_REG_OFFLOAD_MEM_ADDR_WIDTH);
>> @@ -1097,6 +1214,9 @@ static int spi_engine_probe(struct platform_device *pdev)
>>  	}
>>  	if (adi_axi_pcore_ver_gteq(version, 1, 3))
>>  		host->mode_bits |= SPI_MOSI_IDLE_LOW | SPI_MOSI_IDLE_HIGH;
>> +	if (adi_axi_pcore_ver_gteq(version, 2, 0))
>> +		host->num_data_bus = FIELD_GET(SPI_ENGINE_REG_DATA_WIDTH_NUM_OF_SDIO_MASK,
>> +					       data_width_reg_val);
>>  
> Not sure I'm following the use of DATA_WIDTH and NUM_OF_SDIO.
> HDL doc [1] states NUM_OF_SDIO 'is equal with the maximum supported SDI lines in
> bits'. And the code sets that to be the number of buses. That should work for
> AD7380 because each AD7380 SDO bus has only one line. But, it won't support
> AD4630 (or even AD4030) because each AD4630 rx bus has 4 data lines. I can't
> find it in HDL, but I'd expect to also have something like NUM_OF_SDIO_PER_BUS.
> Or DATA_WIDTH is the number of lines per bus and HDL doc is unclear to me?

Right now, the HDL doesn't distinguish between the two, so we only have the
case where each "SDIO" is a separate bus. The AD4630 project has extra IP
blocks to unscramble things to simulate having 4 lines on each bus rather than
8 buses.

DATA_WIDTH has to do with how wide the bus between the SPI Engine and DMA
is, so it has nothing to do with the wiring to the peripheral.

> Well, it would be nice if we can have host->num_data_bus set in a way that
> minimizes diff when multiple lines per bus gets implemented (if that's not
> currently supported).

I agree it would be nice. However, the register name and meaning already exists
even in older versions of the IP block (as NUM_OF_SDI), so I think it would be
best to stick with the existing name. Ideally, when support for multiple wires
per bus is added, then we would compile like this: NUM_OF_SDIO=2 SDIO_BUS_WIDTH=4
rather than NUM_OF_SDIO=8 NUM_OF_SDIO_PER_BUS=4.

> 
> [1]: https://github.com/analogdevicesinc/hdl/pull/1808/files#diff-d1274cfe2e206aa66a0ecd3da04b3e62fc5fad9e12029b34b226c6f91454d34dR77

Well, the linked PR isn't merged yet, so I guess we could ask there to rename
NUM_OF_SDIO to NUM_OF_SDIO_BUS there if you think that is a better name since
it is being renamed anyway.

