Return-Path: <linux-kernel+bounces-897793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 09690C538F6
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 18:02:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id F26EE3452CF
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 17:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82F0128697;
	Wed, 12 Nov 2025 17:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="dwz9Ugmd"
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 422153451DB
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 16:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762966801; cv=none; b=BP49WF4gejvQm+CguzJONkruPHcKwP1uCbsYdabJm8ScEz3cJR4BpoJ5D6LVvwSGNkae5WreJ8+/d5J1ur5tnCkAiII9UNFBNAL7iqHwNwhAkavJkNEgZBXEdNP5e859lfyq36XR1egQFiwPEuEAZwscX42V/VjphwTghsOf6Os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762966801; c=relaxed/simple;
	bh=8wx44lorjmXobYAPjgirMKLJlUNzSsr5s3gulPDv6j0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qmoox9wKFnT9rws3fTajvtrH64g6Eb8EX/AfLGiSa+Xi7zc9UlgRZk2lGulr6jQ9dA6A45Fc8NZpniSSmu+66c6RgzCw0FiozbUHL31oi4gW0Rcsh83xUED/G0YiCOQVGfdJx2JtxQGbiwG3WVUW7at2c1jropOebeuIg6g8G1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=dwz9Ugmd; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-656bb297df2so210543eaf.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 08:59:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1762966798; x=1763571598; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9UBroaIpNSaiJuWFrz+qWW2HM0uYdQr3mWyR9bfJIIM=;
        b=dwz9Ugmdt4tA8qi6929B5cM2xqwjHCY2sziOHziktlu15hr+e6pR0ZO6X9I4LWCo6i
         mI8gpfA9IzRCnS7rfun2r6dZtrZdkBwT4g6ro1VOCO10ky1BJ2DqXicY2taSkHWzhEYc
         tXYftMocbYP7EN2QB+FBfdNziCXNimUIUI8zYIX/9TL5pvjN4FkcNxCQgnlGz6FCMv66
         D2BibSGCafSfGj4yYb0tODuc3lWYsiZjfj7RLcNm4VGVLWYaLgRcTTCxh5pr6S4FL+4m
         TbUZZuDqUralxivWZydq+2Knhoj/520cHrH63BIAkwdunauvfFOtlaDM3nKPFycaS+TE
         jtgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762966798; x=1763571598;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9UBroaIpNSaiJuWFrz+qWW2HM0uYdQr3mWyR9bfJIIM=;
        b=WLuq0KEUKzdY7LlZND8EKYYipW1VWKhEFpCc6edYTPywn9jnjTLnidlYAXBd5gAtuw
         6q9rA+dKEUzh6VodE6vM+tRcZTxZbsFo+zC5bw/3FYrU4uB5Fag+tLdkbyuJEYlP84Xy
         GZqWO1nghp5MOvcTB5rxmd7rVrH0yUhvhpfiCSgFArai+2WQnhQMiIGDcZAmOnVhO232
         Yeo6Vsx6fClKPSYSHCRAeBgnRIeXUUhG4ua1L9bqt0boNW7WrlHDRIfBWfZZAijg9qHp
         gHQIdEzN9uymyp1vSP+cxjVn0WczHL00aOIc8B7/QoHcoDPmoXZGewb2dPVmjMoHIfBQ
         5eOg==
X-Forwarded-Encrypted: i=1; AJvYcCUkZBxZXR9KgQGzGdkkIGq+qhfuc8ODXOI3dTRfEfDcVSpl3Zg29zfKe0nnWvDan56DqSuCCwusA5Yabnc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywj1ufFf0E0QLotIlygq05ZUsL/VAlFb3zINGk1x+CVQtWTFyWq
	fwWwAQNzOOgQfFmTY9DGlrLKFlI0+/nni3IahG+PkdT0eGb8uG3ufcheUad1aJjLY9A=
X-Gm-Gg: ASbGncv8raRs1xkDRg0Bjs9TdtHZkHVLlPN1HWsO3ECzGgo6j6ZERuUd5pgjO6Sn6C2
	DgFJv9O6TFZjwuaUrUvQhJF7gKCrOCw9bEB77he8JvbKQSSlGngl/r8xr+ffalJZhPQxdxPv3u6
	w9TJrVK9MvuuKzt4jadezz3KPuZPoHv4NeoIiZwPwR8ya7YtH5K2rsQNzgyLD/vxA5Bf3qphCoh
	OJYXYxTF8LOPaGzjGl9sQXrnJbNCgeIKIcZIHnKrFFxXfHEBi458LJfeEZg6OLGPAibHZZJsUW5
	xMNe/tWbAvrfwCTT/rvSjXONXJWUXm2B0e+55ZhaaJH5zybNTAJUyTyTr3lQoBkKs0Ue5hNW4A4
	ntQp75c/gUxsixDMthHRv6RjP6FIB7t8drpy7CUh45NAQ5raw4OjL3vu7Pvx567VTo7CrElG4j2
	6z6oSox18H4XYAeh5ZYmjqEHqMlcVWYxLtdU6p95OKRm0/DowLSg==
X-Google-Smtp-Source: AGHT+IGjGiA68SQxE2DOheehH23MBaQy65p8WqlrKArkfS9SuLVcwJ48eTHV9RHhY2eyZHq3Z4deyQ==
X-Received: by 2002:a05:6808:3198:b0:442:2ce:46cf with SMTP id 5614622812f47-4507456e715mr1828413b6e.34.1762966797983;
        Wed, 12 Nov 2025 08:59:57 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:d404:301b:b985:c499? ([2600:8803:e7e4:500:d404:301b:b985:c499])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3e41f2583casm10124611fac.23.2025.11.12.08.59.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Nov 2025 08:59:57 -0800 (PST)
Message-ID: <0e59d92f-7b3c-4ff6-b3ad-7fae2ded9b77@baylibre.com>
Date: Wed, 12 Nov 2025 10:59:56 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/6] spi: axi-spi-engine: support
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
References: <20251107-spi-add-multi-bus-support-v2-0-8a92693314d9@baylibre.com>
 <20251107-spi-add-multi-bus-support-v2-4-8a92693314d9@baylibre.com>
 <aRNSc1GEz0UNx17i@debian-BULLSEYE-live-builder-AMD64>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <aRNSc1GEz0UNx17i@debian-BULLSEYE-live-builder-AMD64>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/11/25 9:12 AM, Marcelo Schmitt wrote:
> Hi David,
> 
> The updates to spi-engine driver look good.
> Only one comment about what happens if we have conflicting bus modes for the
> offload case. Just to check I'm getting how this is working.
> 

...

>> @@ -284,6 +316,24 @@ static int spi_engine_precompile_message(struct spi_message *msg)
>>  			min_bits_per_word = min(min_bits_per_word, xfer->bits_per_word);
>>  			max_bits_per_word = max(max_bits_per_word, xfer->bits_per_word);
>>  		}
>> +
>> +		if (xfer->rx_buf || xfer->offload_flags & SPI_OFFLOAD_XFER_RX_STREAM ||
>> +		    xfer->tx_buf || xfer->offload_flags & SPI_OFFLOAD_XFER_TX_STREAM) {
>> +			switch (xfer->multi_bus_mode) {
>> +			case SPI_MULTI_BUS_MODE_SINGLE:
>> +			case SPI_MULTI_BUS_MODE_STRIPE:
>> +				break;
>> +			default:
>> +				/* Other modes, like mirror not supported */
>> +				return -EINVAL;
>> +			}
>> +
>> +			/* If all xfers have the same multi-bus mode, we can optimize. */
>> +			if (multi_bus_mode == SPI_ENGINE_MULTI_BUS_MODE_UNKNOWN)
>> +				multi_bus_mode = xfer->multi_bus_mode;
>> +			else if (multi_bus_mode != xfer->multi_bus_mode)
>> +				multi_bus_mode = SPI_ENGINE_MULTI_BUS_MODE_CONFLICTING;
> 
> Here we check all xfers have the same multi-bus mode and keep the mode that has
> been set. Otherwise, we set this conflicting mode and the intent is to generate
> SDI and SDO mask commands on demand on spi_engine_precompile_message(). OTOH,

s/spi_engine_precompile_message/spi_engine_compile_message/

Probably just a typo, but just to be clear, the "on demand" bit happens in the
compile function rather than precompile.

> if all xfers have the same multi-bus mode, we can add just one pair of SDI/SDO
> mask commands in spi_engine_trigger_enable() and one pair latter in
> spi_engine_trigger_disable(). I guess this is the optimization mentioned in the
> comment.
> 
Your understanding is correct.

