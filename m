Return-Path: <linux-kernel+bounces-853917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 812E7BDCF95
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 09:26:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D4173B99A0
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 07:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53D0A31AF22;
	Wed, 15 Oct 2025 07:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z8L8wees"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E8CD315D3E
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 07:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760512666; cv=none; b=nBHG+y1NayGuHJgUvL+AfvYxy/KLRwTLlMOqaRb+erbEp4YBdE9CgqUv2yrGVa60IMAEBFn+TcFAJnmTB/gOnjUjJl8td3IYP4eVgwhyKgaJNkULRELImqLRb2oZxpEFhqfv8frdxMvw4zj5SWgIcGFm0Z+5fY4OI76XEcw70dU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760512666; c=relaxed/simple;
	bh=yHzIyTTaSUhvz7vpIa6YFDpCxxpaGXHwLqlXWSiOLTU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o0gp8Quam2lmqUyiz+iWNCe+Ksp6GdRQ/qQ00YGq7bv9KXxKJYdPM7z4GzToosHY7Z8xSEimo+d0BxsyPvJYFCjphWnc4Q+Mqo2Th5ehpDQ8F11n1kX2sW+XTilxeRKykTO3VJCgJLXYeKTfilh1f39W/sOW0MxJFOf1h1l7zJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Z8L8wees; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6394938e0ecso10207484a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 00:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760512663; x=1761117463; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ePYaFzONl4e/LY7q9Fhjo1RMb7nGfXYeEd5O3pWTTdc=;
        b=Z8L8weesbvGvhOJGAKh1zce+VQAjgIFJIL/T7pTGljd4FviIqZ4Eyr0y+sRcoz+XdL
         faiDIbf5JsRtdQiJNM9e7LpCUYq0m52gDWCOByJjc/xB/g4uLhiBZTXo+6QB9FiXXyY5
         +f4MM0kQqGdCG8hYofHngBicfpjTbj+3DgLCgfTPrWE4+TikKK6RMZ4KnJci5DpaPsPb
         1LsQo9XLnBsBuZc5A/fEu7axnBbVlCYrqxjt0cicurKNeFkOlINBvBoAlk91zQI/1DX6
         1NNYHf69Xly4cV41X+oDX5oSPipkHiDvghthKWE+6n/UgW6p/CLGar0up65GcecMp3Ph
         kDIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760512663; x=1761117463;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ePYaFzONl4e/LY7q9Fhjo1RMb7nGfXYeEd5O3pWTTdc=;
        b=B+iyfu88/X1gACZ2UVUiFkKSX3BNJDQ5aJgaDnoND17V8us0SgIkbdNQ/G3CC68tlF
         2TDpvyEuXUdY5fR71QVqE4IgeEgZSEADvJstxKjw0/Z21sbFky/LgjmmoaADhC/8iOPN
         gz3gq4gZWSDFqEZ3YtHV6L/O53DdmCVoDovazmML8SttaUvLqG7H602NpEp53JoNmzUO
         fHInE6hPahaWZDCBy0oZkXIDohaRkYk4JE7m2bafI4+SPx/zYhIgGr7Z4SyJ3oWSXS/Q
         y30ibkRUPk9NeGNvT8h/jCUVFxHH8FjIxZMrLTcGtNCw0qHpRdDGUf3szea8yUFoBC6h
         3sbg==
X-Forwarded-Encrypted: i=1; AJvYcCWZeyza2mw7J0NgY4Ho/XWFUz3QzjjpCKjFqO/QY/On+Ca+EYcZZJEzjlEZbtkFT012unDdR2dgy29WjbI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzjwj0a/hcLeR9glp02l5E9B9HzaCbHjNGYVICOhz2Gflzn6fUj
	SQT7S+kDaH49XQXuZGOuSi80p+e3JPGwShR1EKotN8kQcp9f+n7+UxxU785+smpaO7Y=
X-Gm-Gg: ASbGncv8SBjn1yJvinmQyd495ArH/GSgiphvHuAaX9RIXavWTTxnsiMhDr7lYECu25i
	pWVu89MVYU2q88i9FVDPX9YMDYk0DiKLYQeflAA2OZyqepsZ6cGYuIaMZquJ6EiCTRXHQwGw9Ms
	IQeBBdpD1WJF8Q/+h6uIYx4OC+OfGE3eyvbBFPcGyAx0fwWrXWz+gFu0b8QjCiL3c6VuKEdhixE
	V/e+c2TSk0MTyTq4Us/fNvKewYQDt7pmtKA09uwYek3ujm/g9p9MC76olZmFzh7bUMTfdOzFrbM
	OoWeTdfdG9/AwrNfLqGOprv7waBdulhBytXuJl2o6tbFKFE/2s7oRnrDjsc8n2gsD+6p3VzWca2
	WAXNuvNhhfFb/e8mramQohp1qi4VuN+LTdLMMCT04qKOzdSSyeuugfzkuOI1XrfRZo0o1/8wupQ
	sNLgFsJ98ZUm1M85/4FD6ny75WeQDZG0Mecm1Lmxh4Ko4=
X-Google-Smtp-Source: AGHT+IFmYqZtjBQqWMLY6jQsULT/KG9GV1bM+5qtfWP5Tt64i73SBNyEd6pZNj/0MqfoPh6C/V9WhQ==
X-Received: by 2002:a05:6402:2791:b0:63b:ec17:70da with SMTP id 4fb4d7f45d1cf-63bec1774f4mr1814946a12.8.1760512662522;
        Wed, 15 Oct 2025 00:17:42 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:ab0f:5130:68a8:f38? ([2a05:6e02:1041:c10:ab0f:5130:68a8:f38])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-63a52b0f860sm12650070a12.15.2025.10.15.00.17.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Oct 2025 00:17:41 -0700 (PDT)
Message-ID: <0ac22118-fd0f-49c0-9aa8-5739925587d2@linaro.org>
Date: Wed, 15 Oct 2025 09:17:40 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] iio: adc: Add the NXP SAR ADC support for the
 s32g2/3 platforms
To: Jonathan Cameron <jic23@kernel.org>
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 robh@kernel.org, conor+dt@kernel.org, krzk+dt@kernel.org,
 linux-iio@vger.kernel.org, s32@nxp.com, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, chester62515@gmail.com, mbrugger@suse.com,
 ghennadi.procopciuc@oss.nxp.com
References: <20250919135618.3065608-1-daniel.lezcano@linaro.org>
 <20250919135618.3065608-3-daniel.lezcano@linaro.org>
 <20250920102742.4cadb734@jic23-huawei>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20250920102742.4cadb734@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Jonathan,

back to this driver after the merge window ...

On 9/20/25 11:27, Jonathan Cameron wrote:
> On Fri, 19 Sep 2025 15:56:18 +0200
> Daniel Lezcano <daniel.lezcano@linaro.org> wrote:

[ ... ]

>> +static int nxp_sar_adc_start_conversion(struct nxp_sar_adc *info, bool raw)
>> +{
>> +	u32 mcr;
>> +
>> +	mcr = readl(NXP_SAR_ADC_MCR(info->regs));
>> +	mcr |= NXP_SAR_ADC_MCR_NSTART;
>> +
>> +	if (raw)
>> +		mcr &= ~NXP_SAR_ADC_MCR_MODE;
>> +	else
>> +		mcr |= NXP_SAR_ADC_MCR_MODE;
> 
> Could use FIELD_MODIFY() for this though saving is minor.
> Same applies in various other places in this driver (and
> many others!)

[ ... ]

I gave a try to use the macro FIELD_MODIFY(). Logically, FIELD_GET() 
should be used too for consistency. From my POV, the result looks less 
readable than the usual annotation but may be I not used to the FIELD_ 
usage. Here is a snippet of the changes, do you really want to convert 
all the driver ?

         mcr = readl(NXP_SAR_ADC_MCR(info->regs));

         /* Return the current state. */
-       pwdn = mcr & NXP_SAR_ADC_MCR_PWDN;
+       pwdn = FIELD_GET(NXP_SAR_ADC_MCR_PWDN, mcr);

-       if (enable)
-               mcr &= ~NXP_SAR_ADC_MCR_PWDN;
-       else
-               mcr |= NXP_SAR_ADC_MCR_PWDN;
+       /* When the enabled flag is not set, we set the power down bit */
+       FIELD_MODIFY(NXP_SAR_ADC_MCR_PWDN, &mcr, !enable);

         writel(mcr, NXP_SAR_ADC_MCR(info->regs));

This looks ok but then:

  {
         u32 msr, ret;

-       ret = readl_poll_timeout(NXP_SAR_ADC_MSR(base), msr, !(msr & 
NXP_SAR_ADC_MSR_CALBUSY),
+       ret = readl_poll_timeout(NXP_SAR_ADC_MSR(base), msr,
+                                !FIELD_GET(NXP_SAR_ADC_MSR_CALBUSY, msr)),
                                  NXP_SAR_ADC_WAIT_US,
                                  NXP_SAR_ADC_CAL_TIMEOUT_US);
         if (ret)
                 return ret;

-       if (msr & NXP_SAR_ADC_MSR_CALFAIL) {
+       if (FIELD_GET(NXP_SAR_ADC_MSR_CALFAIL, msr)) {
                 /*
                  * If the calibration fails, the status register bit
                  * must be cleared.
                  */
-               msr &= ~NXP_SAR_ADC_MSR_CALFAIL;
+               FIELD_MODIFY(NXP_SAR_ADC_MSR_CALFAIL, &msr, 0x0);
                 writel(msr, NXP_SAR_ADC_MSR(base));

                 return -EAGAIN;

[ ... ]

         ceocfr = readl(NXP_SAR_ADC_CEOCFR0(info->regs));
-       if (!(ceocfr & NXP_SAR_ADC_EOC_CH(chan)))
+
+       /* FIELD_GET() can not be used here because EOC_CH is not 
constant */
+       if (!(NXP_SAR_ADC_EOC_CH(chan) & ceocfr))
                 return -EIO;

         cdr = readl(NXP_SAR_ADC_CDR(info->regs, chan));
-       if (!(cdr & NXP_SAR_ADC_CDR_VALID))
+       if (!(FIELD_GET(NXP_SAR_ADC_CDR_VALID, cdr)))
                 return -EIO;

-       return cdr & NXP_SAR_ADC_CDR_CDATA_MASK;
+       return FIELD_GET(NXP_SAR_ADC_CDR_CDATA_MASK, cdr);
  }



-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

