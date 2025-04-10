Return-Path: <linux-kernel+bounces-598420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 28045A845F4
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Apr 2025 16:16:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57CF8172150
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Apr 2025 14:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFC432857F1;
	Thu, 10 Apr 2025 14:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="cKNBjrG6"
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A2128A401
	for <linux-kernel@vger.kernel.org>; Thu, 10 Apr 2025 14:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744294311; cv=none; b=NQWV4l3qVsMpJAhe4DvixzPftpA8fzhgimV9rthHbA1AhYmCWzk0EvT71z9I0KEIE07CG6fjDVMhhvVRBASmu16lZ8GuPm6fNjBxW6ibE8dDSe1V8o0Y5Ivi6IFDzeP5lgD0qGBJqPrmtF9R2Un04mjgo3hq7s6BnT0LKUUqxrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744294311; c=relaxed/simple;
	bh=2bcRLWwxEd6oDhiLEs2/eeHeotbrLRq3xVyuc44V+PE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UVRldDd71ne/UJfsQrFW26TmwjihM+zCIJXmEryx8FkMtrRPQzgQjDbvU9qV9Q1Us6O+/5WbVWP2aNktC2IAmXf7Inr0yUnpo5TLmk4/vQditvs+vRtPHMCag63O8wBK2oTYdixpoub+YZ1C9AkvtCL5Naf8H9aR/wySLCTqDWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=cKNBjrG6; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-2c2dc6c30c2so226559fac.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Apr 2025 07:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1744294308; x=1744899108; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bDU6TnnpydkrEGdtbw7Y1FabP4abTQNmCWlwkK2+gfI=;
        b=cKNBjrG6iCxOGsWqTs+iEyG3tdvyzuHtWvuwKnVryMGWJtYfwKGOGiNzNrcxsNBv5N
         hNsa2f+tTP9tDjngk/5eFdzJVoJ7SqfWwpdzh8yRUXE0xPZGCfWh1HKqOsWlt1SK5vJp
         HLEN/CkmeJi3ZOQGiJKyeRlL3aArpNS61r1SAtM7A7D05DyI4I6no3kZ6r685BtqZ7H9
         NsVjTH3sm7ZhsXh6N5JiV8zYtgDdKwGe4A4WOTnj9y+vU3QUqcLmn3Vi8OqFP8M1GIJN
         rCtqqFdHw6tFqG+6zApja4oxlQlSy0NaXjTeQ8GQ7am+S27JHRG7ReyjTMAn+PQzpyCK
         d8mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744294308; x=1744899108;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bDU6TnnpydkrEGdtbw7Y1FabP4abTQNmCWlwkK2+gfI=;
        b=gXXu9gjRo4xcFk3EQgRK/SZVP5SdGlcbbHMQY7n4XoIdTV53ht+xoVT1imFsSZhuwE
         lQ85SDtEGsnE2YM17hKEH0dx6jzSbgaTcjAQbbv3LwiFf0HY7mTd9zTRzSZkW4V5jVKR
         JbB/ChnFnstDuvG7P5bRopG9oCSnvyjUndKeO2BoJMte3SvcR+jr4rO/FdFkYPZ2HfZ3
         8bEakm6kkcXIx20GI2cGlAS48mwesDlTEzBH2t0UwGN4ovRcIkqUJO91CDibTiCRErC6
         MTItAlCqU7shsUEo7u30jJqbXncCZa3UOcvqH27VLMsfJZ5WQ79ovPV4vzZ0+C5ZH3f1
         /teA==
X-Forwarded-Encrypted: i=1; AJvYcCXr6TXmcZ61yv2jlh8cOYQkPnYaXFWscPl4OjH1DNvc1/opIoos908c8r/D8pRVkXxCOAyUSH4+HhtR9QU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwhgbreaDUHeSf77BHOoxGkDubuVnd39pazlELPjOg57286OgG
	2jxW6s6i/YJtMvGtIY16FDD3aKDWKsBWaC29Mq+HJ9jh9JihBMhcK2N+uMdXkAs=
X-Gm-Gg: ASbGncsI+pYhFSEEzyG52LwH1k9xROeKq0rD5ZCige/uJ9ZrPkp4Ubt7ZMpjMrFX7gc
	qSjSuIxZJ/V393mFfd/73hDEsfgAsSonncHfJQXgAqiY+ZbDUrR3JJj9d85+SDLopGEBQY2vu8y
	KKAYlYH2FV9x0lGlbLoVEjsB7Vt50Ul6ZW0qj3xxflhnRttBbKJBPya4FXFznXriFobl7AkuKkv
	jK7sN9NIWov9Q/x4ViDLNUiHAv6llRyIFWpgQIccUJkrp1LTPLmKoxafW6U/yyBFrnV9suipQhI
	2ntonTSe3EBiJi8uJ20Gvu57JSsmP16zt6al5TQMOfrL7vcKwbzHMqdvJaShxXxXJo523QAtueN
	yrfMxfi1ZxE/k
X-Google-Smtp-Source: AGHT+IF4FJP0GLYWv9/d9TiSPWxCSlvFcNDS8tgAo2NgT2cPnPyU3dINAVQK7QTyDgIRoeywhov6Bw==
X-Received: by 2002:a05:6871:d109:b0:2c1:4146:c556 with SMTP id 586e51a60fabf-2d0b3821079mr1660879fac.31.1744294308198;
        Thu, 10 Apr 2025 07:11:48 -0700 (PDT)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2d0969b721fsm676463fac.25.2025.04.10.07.11.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Apr 2025 07:11:47 -0700 (PDT)
Message-ID: <420dbd79-c981-4278-b888-5dd9f5baa4c6@baylibre.com>
Date: Thu, 10 Apr 2025 09:11:46 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] iio: dac: ad3530r: Add driver for AD3530R and
 AD3531R
To: "Paller, Kim Seer" <KimSeer.Paller@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 "Hennerich, Michael" <Michael.Hennerich@analog.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
References: <20250403-togreg-v3-0-d4b06a4af5a9@analog.com>
 <20250403-togreg-v3-3-d4b06a4af5a9@analog.com>
 <fd2116bd-b0e2-4db4-97ff-1a1e88545413@baylibre.com>
 <PH0PR03MB714159E822B96E7A788A5CD4F9AA2@PH0PR03MB7141.namprd03.prod.outlook.com>
 <a66220e9-f690-4f95-9a14-d2b663d63490@baylibre.com>
 <PH0PR03MB7141587E8AFB2844E52988DAF9B72@PH0PR03MB7141.namprd03.prod.outlook.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <PH0PR03MB7141587E8AFB2844E52988DAF9B72@PH0PR03MB7141.namprd03.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/10/25 3:39 AM, Paller, Kim Seer wrote:
> 
> 
>> -----Original Message-----
>> From: David Lechner <dlechner@baylibre.com>
>> Sent: Tuesday, April 8, 2025 10:06 PM
>> To: Paller, Kim Seer <KimSeer.Paller@analog.com>; Jonathan Cameron
>> <jic23@kernel.org>; Lars-Peter Clausen <lars@metafoo.de>; Hennerich,
>> Michael <Michael.Hennerich@analog.com>; Rob Herring <robh@kernel.org>;
>> Krzysztof Kozlowski <krzk+dt@kernel.org>; Conor Dooley
>> <conor+dt@kernel.org>
>> Cc: linux-iio@vger.kernel.org; linux-kernel@vger.kernel.org;
>> devicetree@vger.kernel.org
>> Subject: Re: [PATCH v3 3/3] iio: dac: ad3530r: Add driver for AD3530R and
>> AD3531R
>>
>> [External]
>>
>> On 4/7/25 3:01 AM, Paller, Kim Seer wrote:
>>>>> +	for (i = 0; i < chip_info->num_channels; i++)
>>>>> +		st->chan[i].powerdown_mode =
>>>> AD3530R_32KOHM_POWERDOWN_MODE;
>>>>> +
>>>>> +	st->ldac_gpio = devm_gpiod_get_optional(dev, "ldac",
>>>> GPIOD_OUT_HIGH);
>>>>> +	if (IS_ERR(st->ldac_gpio))
>>>>> +		return dev_err_probe(dev, PTR_ERR(st->ldac_gpio),
>>>>> +				     "Failed to get ldac GPIO\n");
>>>>> +
>>>>> +	if (device_property_present(dev, "adi,double-output-range")) {
>>>>
>>>> This is not documented in the DT bindings.
>>>>
>>>> This could instead be implemented by making the out_voltage_scale
>> attribute
>>>> writeable.
>>>>
>>>> If we really do need it in the devicetree because we want to protect against
>>>> someone accidentally setting it too high, then the property should be the
>> actual
>>>> multipler value with an enum specifier of 1, 2 and a default of 1 rather than
>> a
>>>> flag (e.g. adi,output-multipler).
>>>
>>> Thank you for the feedback. This should be adi,range-double, which is already
>>> documented in the DT bindings and is also used as a boolean type in other
>> drivers.
>>> I just forgot to update it here. This is a one-bit configuration that doubles the
>>> output range (multiplier of 2).  Should I proceed with the suggested
>> approach?
>>>
>>
>> I see adi,range-double in
>> Documentation/devicetree/bindings/iio/adc/adi,ad7923.yaml
>>
>> We would need to add the same in the new .yaml file added in this
>> series along with a justification in the commit message of why this
>> needs to be set in the devicetree rather than at runtime.
> 
> I can confirm that the adi,range-double property is already present in the adi,ad3530r.yaml
> file as a boolean type, and consistent with its usage in adi,ad7923.yaml.

Sorry, I don't know why I didn't see it the first 2 times I looked. :-(
It is there.

> 
>>
>> Ideally, we would ask the applications engineer for this chip to
>> find out how real users would want to use this feature to make sure
>> setting it in the devicetree aligns with that and is not too
>> restrictive.
> 
> The apps engineer for this chip indicated that the boolean type format aligns better with
> how users are expected to configure this feature, especially for users who may not be
> familiar with specific range values or enum specifiers.
> 

Very good.

