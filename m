Return-Path: <linux-kernel+bounces-848515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E3E3BCDF15
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 18:18:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4A1754122C
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 16:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 629782FC012;
	Fri, 10 Oct 2025 16:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="k7VErcXi"
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08DB62FBE07
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 16:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760113108; cv=none; b=GeAHHPpo+3iNbSoI8/v/eFn62rTlDZqB0ec6fYdRWZF2dwte1HDJ1hozM98SZkBVnaFC482kppdH9JRClhDidEosgZ0wNzeQAJRWNgxh052IKC+3IUGNy7S0QTwjEbql7fIKr5mnBqCNtc8dZg7aH64Pej4SL2OgVg0+queBGLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760113108; c=relaxed/simple;
	bh=FdYPXGm9deiD/Trs9cMfHlp7XbwPhfQIT9v/Wdt5nis=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GlNF2Q+Hi404quq0lMHe9pzty+MZ0Q1g+aOZ5t7LDUcc63vEqgejNJPeGagfqkS6XiG55cbBzuW0ohBnWIGhjzL8A0QJFKlyc28ECvLLNnUjg858H/3g7oexGVadUUUeXx7+2a9sQWJNKRpk26hKudCDTmhhtf/B+YBhN3PAtLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=k7VErcXi; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-64e58cdb8fbso579912eaf.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 09:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1760113105; x=1760717905; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9w68CQXC1xPR3gkxyDZirmm/itUJmtRYjrTWc5to35A=;
        b=k7VErcXiTSdSzA6bGBoScVNFENhUJPpJdaonLVk1Ps7NKthqAs3DTmZDCzckX/9dZ9
         gSHcKUynJ/G9OXQmWDE7pyKmvpPSJqihJsM6bEWkHAV3hCWq9kDE0ZuEWrjRK+PvEDxo
         zRqc/M/biXlD9FKLj2nHqIbxYAq7pjIt+AmLyk9U/hpPxKB2QyoD1Qfni+cmwNTd7KJe
         BiCdQ1DXKh6/smn0eWVowYxolCtYC6ZNHRL6nPWLp9dwWO6/6U+inw2iO7WuG7zmKhsP
         2x5ohFXFx53uczpwjTAXhfKiNfhC0atvYktW4UhPheAvh8cNVv9RG/7PmtMvsdncyTi7
         ZvwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760113105; x=1760717905;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9w68CQXC1xPR3gkxyDZirmm/itUJmtRYjrTWc5to35A=;
        b=OyIUauge1GhMwvDkQnm8TH58pknGneN1KJhkGeuIqt1fvH5anfK68s9P16CU+VLYwf
         PkKRqkl7b9QbTqoogrNsBmincle44Irk/xH5C8n94H7ns6ag+7ZmkSsUwls4NrlSH/9j
         ndS9J4bvrPrIY85XFtx3l0rMPDWmXJ0fkPAma5ISA3lpUZtEmCeLe1IHSHPA21Lx8YzA
         +7Mu/T1442H2VLLt7VQGkquSYC/pPYgZsmOHAfhRRcZxejeCFoH1qR66I9i5CVAS3Epk
         Eh9RsufChTq5wAKJu9dYYfc+tDECvh+7qPEjps+YDAzhFCqtNGdEi2B0SgU16EbbTvwd
         CHPg==
X-Forwarded-Encrypted: i=1; AJvYcCWQGihCSGYB0AV4IVx/cd8u2AOOEUjoEm/9pDVeJ1sI4PtDn/SS5nQz+lvFETAYrdHsEfqgE0Zi3yPbFlE=@vger.kernel.org
X-Gm-Message-State: AOJu0YylN0U+hUtZm0onflfvwI0rYnpoI9Ur4c3S6UdD8ezitkdwc0dh
	rnIEghed2Lo+f/cXS43MhJFV/huGMPQgmX4uQuftJXDGnPImDO8AGXXyL4dgVeyuhbE=
X-Gm-Gg: ASbGnctXGtW5UsqHUE1kSyvl8jBl4DKCpyZts5AjlBiRL63MfTAAYsaNAILjqH+8oVm
	6J31pZStN806QgocSt0fkKyFqLH8M9fRpwWU7m5/Wcau4SPRckeFI8mxI/NCyNiR7xP2r/xdbNa
	SH4JpcjrBfUizKBzP7GRAN00ZvAOt9ABFNfIEnNiHksX6ZJ/pCMVyx6hwe6miqTx8JQtLqa31/9
	VB6f3HVROcR6gIFx27lysCrqS5fzRo0uZGSDwL/UrJM8i8w6/dLWfoMPCT2w6hzpweHH4QyCUJg
	YIJAmOuR/4Qf1wwUygInJO26mNh3I6GhthGBdJdPogaB1zQ0mT9IAU40ZQXdjcAbuX1k2+ktXx8
	L/N8x4KFEAV7cfTLY8Ef4lwl0jiFoMRoPiJOzwW4AatZbyv1AkkernR5yIlGf3oEEUgZ0LIz96N
	cftY3BjzhoxkqpTzM=
X-Google-Smtp-Source: AGHT+IHd0omg/rlvWPFBEqlcSVQAWZIDB8yoaKyD9jCTVYWmDrXVdGmrtHcE+pAoTAHuCLm4ZKiTag==
X-Received: by 2002:a05:6871:6d12:b0:31d:7326:c3a7 with SMTP id 586e51a60fabf-3c0f9e6cf08mr5691630fac.41.1760113104781;
        Fri, 10 Oct 2025 09:18:24 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:6d3b:e3bd:4210:32e2? ([2600:8803:e7e4:500:6d3b:e3bd:4210:32e2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3c8c8ae1de8sm1007500fac.4.2025.10.10.09.18.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Oct 2025 09:18:24 -0700 (PDT)
Message-ID: <576b582e-7388-4ee4-9a4c-4f7e04fc3fda@baylibre.com>
Date: Fri, 10 Oct 2025 11:18:22 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 6/8] iio: adc: ad4030: Add SPI offload support
To: =?UTF-8?Q?Nuno_S=C3=A1?= <noname.nuno@gmail.com>,
 Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-pwm@vger.kernel.org, linux-spi@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: jic23@kernel.org, ukleinek@kernel.org, michael.hennerich@analog.com,
 nuno.sa@analog.com, eblanc@baylibre.com, andy@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, corbet@lwn.net,
 marcelo.schmitt1@gmail.com, Trevor Gamblin <tgamblin@baylibre.com>,
 Axel Haslam <ahaslam@baylibre.com>
References: <cover.1759929814.git.marcelo.schmitt@analog.com>
 <2bde211f1bc730ee147c9540b88339a93b2983e6.1759929814.git.marcelo.schmitt@analog.com>
 <a86007ab148f9556af032f5ba61991a74a5641c0.camel@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <a86007ab148f9556af032f5ba61991a74a5641c0.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10/10/25 6:19 AM, Nuno Sá wrote:
> On Wed, 2025-10-08 at 10:51 -0300, Marcelo Schmitt wrote:
>> AD4030 and similar ADCs can capture data at sample rates up to 2 mega
>> samples per second (MSPS). Not all SPI controllers are able to achieve such
>> high throughputs and even when the controller is fast enough to run
>> transfers at the required speed, it may be costly to the CPU to handle
>> transfer data at such high sample rates. Add SPI offload support for AD4030
>> and similar ADCs to enable data capture at maximum sample rates.
>>
>> Co-developed-by: Trevor Gamblin <tgamblin@baylibre.com>
>> Signed-off-by: Trevor Gamblin <tgamblin@baylibre.com>
>> Co-developed-by: Axel Haslam <ahaslam@baylibre.com>
>> Signed-off-by: Axel Haslam <ahaslam@baylibre.com>
>> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
>> ---
>> Change log v3 -> v4
>> - Applied code adjustments suggested to SPI offload patch.
>> - Only select SPI_OFFLOAD_TRIGGER_PWM if (SPI_OFFLOAD && PWM).
>>
>>  drivers/iio/adc/Kconfig  |   3 +
>>  drivers/iio/adc/ad4030.c | 504 +++++++++++++++++++++++++++++++++++----
>>  2 files changed, 465 insertions(+), 42 deletions(-)
>>
>> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
>> index 58a14e6833f6..1ed091b6731a 100644
>> --- a/drivers/iio/adc/Kconfig
>> +++ b/drivers/iio/adc/Kconfig
>> @@ -62,7 +62,10 @@ config AD4030
>>  	depends on GPIOLIB
>>  	select REGMAP
>>  	select IIO_BUFFER
>> +	select IIO_BUFFER_DMA
>> +	select IIO_BUFFER_DMAENGINE
>>  	select IIO_TRIGGERED_BUFFER
>> +	select SPI_OFFLOAD_TRIGGER_PWM if (SPI_OFFLOAD && PWM)
> 
> Two things as I mentioned in [1]:
> 
> 1) Wouldn't 'imply SPI_OFFLOAD_TRIGGER_PWM' accomplish the same?
> 2) Don't we also need stubs for spi/offload/consumer.h?

It doesn't hurt to enable SPI offload support even if no controller
supports it, so I would prefer that drivers that use it just select
SPI_OFFLOAD.

> 
> [1]: https://lore.kernel.org/linux-pwm/2e82eaf275b5c8df768c8b842167c3562991e50c.camel@gmail.com/T/#t
> - Nuno Sá
>  

