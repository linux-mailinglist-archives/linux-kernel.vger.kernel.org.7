Return-Path: <linux-kernel+bounces-801677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17312B448A9
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 23:36:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD94C3BF13D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 21:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ACB22C1581;
	Thu,  4 Sep 2025 21:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="rblHqW69"
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E1E289811
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 21:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757021798; cv=none; b=auYTQLix0XnBC/LdoG2Y84JhpqfL7QMy1toZ2XSG9ST7LfQXRS+hBwPHX4EZZfuCEMZIrQ2Op4lIlXnppxJHSyW/Azu4Q7lZFoEkD12nYGRZ6Rn1hpaf0F9yh1kMtX2sYlRuMXZjc/P5Rj3n3GFWhcyQrTZl8t0XDT9fY/ZnopA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757021798; c=relaxed/simple;
	bh=7CzmPfMQy+yfaTvGUJ5I488Q7O3xDmbX1jz1pgUJ5bg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UI8JaPyBtOMWiOev6amuLnXw+cr7YlDrtOGDCCETSEVheAqIxoDio14CJARJ8ChKgbZPeuQsLTf7XYPmOPXHRvKgNCgAc/4KRjUvTBNS/NVtw++zAAEmahV4fwfNCq6qgymLnnyeyfzBCPIO3ESRrtrgdAosumqs9s9MihMEZ/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=rblHqW69; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-745a415bf72so458350a34.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 14:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1757021795; x=1757626595; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o2ksK33O2Gh+zayfz9iUY+WpS0hxyQwgAZC6r3ahBbc=;
        b=rblHqW69LUPEE0IgIzBO57xVsY1DEr8uGx63kQm6tisj1Gub6qdmbvgO01A2VTJ+si
         iYG6PXp1acn3eviDevDMgZ55o01MZsQc9O0jMpgGxR62KW4KVZteOG8e+FqoImWUe8EE
         JdM161uqCeZcmwG/fQMF/Jm6MSpzJlVKoZnvGu2gkQmTx9QcvDdEkLLyarRm/qGwbL/x
         8UP5JbPVUIH5xcXvbedDaa25VlhrY+Y+0OQZawQmo4HVj0LUoyvBMWrVIIiQiYBxybt/
         cLPgVU0eVmP6dDU+nol+6MdR0IS9XlS4OVjWTi+YjDEZcOxAYvzgMD1G8TrwjiWjTh2x
         Nx1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757021795; x=1757626595;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o2ksK33O2Gh+zayfz9iUY+WpS0hxyQwgAZC6r3ahBbc=;
        b=TryB5h6di739Gu4HJw2rf0BM+7N+xdaX51T0gDSBTnooEGGWsbmpmCPh7z05qfFFln
         83P2jYUzKIDB/35FMH2p3RLVMYNKDiOF4zn315Dsx57njDzmm+2ayZtAg2aZB2uwW1po
         5+afvdSeUzkizZFL9rxYhnLuGMF3r7QJNRWSHXip5+bE4rUcG8XwCWfVROSxz4FzBUeo
         KpEOOIvvHB3NEJRs1x/X2ilwNMjxMwn4+UYI4a58cLEgKSRONWVeJJXbZALwlC9JQu9t
         EKr1GkD6T7JzZ7Ikp+dwVB6RKAD8wGwK7+ntfNc972qlmvpYCqCutyAyRSXu0MRU3+Pg
         +dMQ==
X-Forwarded-Encrypted: i=1; AJvYcCUntSkVQ+1VrdEwGZbW/C6958PXpsOvxHr4q7YZGKb1cA+yHjdJXjSLpOj9Z4Jvz86TdpiCz7p+EyP16Es=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3SYA6uvMpL6t7D3Eus+k0bD3e0n/TGHGddJT+HUzlW57SFGeo
	3pZOpokcKRpZjRrKzW6T3Uzo8ZRecAhlEFGEWdLpffZ+6fDrGDkTsXuD4L0swIOZDkPtwt4WwGf
	Mt8rW
X-Gm-Gg: ASbGncuZiDH+u6Z/6UbfXj53nt4obSBpajFE+D6QA8+A40ul9WL4nr5ifq8h/aOK8Wu
	5bYsTYn9wc12mKcauyJXRLjd+6avgAbTfslXk5QLuS0eQACHQr5PWI54tL/4tn3CoXzgTiawi3H
	loT+2onb2dV5Ev/Nuo/FZ0jS1B7aTT9ZSi9xPRMZYhVcEOngKuUq9hfPPwQsFDQsRj6Q+40IQbS
	Cf4SB5ShFhaDpxCD3i1VZiPnhhwTYMW00SisfljOaZITWLI35O7LatAi1aNy/84v8lB600cS4ZK
	s3qsfolvyq9nNMoMaRgBb0OHJEfCWkk1C3WIWkALKjYCqkG5vDlI1PmCjqt+W3Ri0T7LY+Ouu/T
	WfYXLg6wmFE/v2JJAJd03hag4/EM1nqM52q+jg0aW/uqCQkbwRAoJ9OxvwG57JAy/L+oSOrrjIt
	BlhxXDymNuMg==
X-Google-Smtp-Source: AGHT+IEkZaYGqTaVEBhg/NH0XJNUU/u00tkVS5TwqBNVwmkgoIkNoMb3Fp5vF6Y8P21aL8iacPxIWw==
X-Received: by 2002:a05:6830:d83:b0:745:9a08:c9b2 with SMTP id 46e09a7af769-7459a08ced9mr3566127a34.5.1757021795594;
        Thu, 04 Sep 2025 14:36:35 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:a178:aa1c:68f0:444a? ([2600:8803:e7e4:1d00:a178:aa1c:68f0:444a])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-745742a5a9bsm3617905a34.11.2025.09.04.14.36.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Sep 2025 14:36:35 -0700 (PDT)
Message-ID: <88936759-77f5-479c-8cdb-121fc08f068f@baylibre.com>
Date: Thu, 4 Sep 2025 16:36:34 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] iio: adc: ad7124: fix sample rate for multi-channel
 use
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250904-iio-adc-ad7124-fix-samp-freq-for-multi-channel-v2-1-bbf2f0d997ea@baylibre.com>
 <aLnYk6RPePeACmex@smile.fi.intel.com>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <aLnYk6RPePeACmex@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/4/25 1:21 PM, Andy Shevchenko wrote:
> On Thu, Sep 04, 2025 at 11:19:56AM -0500, David Lechner wrote:
>> Change how the FS[10:0] field of the FILTER register is calculated to
>> get consistent sample rates when only one channel is enabled vs when
>> multiple channels are enabled in a buffered read.
>>
>> By default, the AD7124 allows larger sampling frequencies when only one
>> channel is enabled. It assumes that you will discard the first sample or
>> so to allow for settling time and then no additional settling time is
>> needed between samples because there is no multiplexing due to only one
>> channel being enabled. The conversion formula to convert between the
>> sampling frequency and the FS[10:0] field is:
>>
>>     fADC = fCLK / (FS[10:0] x 32)
>>
>> which is what the driver has been using.
>>
>> On the other hand, when multiple channels are enabled, there is
>> additional settling time needed when switching between channels so the
>> calculation to convert between becomes:
>>
>>     fADC = fCLK / (FS[10:0] x 32 x (4 + AVG - 1))
>>
>> where AVG depends on the filter type selected and the power mode.
>>
>> The FILTER register has a SINGLE_CYCLE bit that can be set to force the
>> single channel case to use the same timing as the multi-channel case.
>>
>> Before this change, the first formula was always used, so if all of the
>> in_voltageY_sampling_frequency attributes were set to 10 Hz, then doing
>> a buffered read with 1 channel enabled would result in the requested
>> sampling frequency of 10 Hz. But when more than one channel was
>> enabled, the actual sampling frequency would be 2.5 Hz per channel,
>> which is 1/4 of the requested frequency.
>>
>> After this change, the SINGLE_CYCLE flag is now always enabled and the
>> multi-channel formula is now always used. This causes the sampling
>> frequency to be consistent regardless of the number of channels enabled.
>>
>> Technically, the sincx+sinc1 filter modes can't currently be selected
>> so there is some temporarily dead code in ad7124_get_avg() until filter
>> support is added.
>>
>> The AD7124_FILTER_FS define is moved while we are touching this to
>> keep the bit fields in descending order to be consistent with the rest
>> of the file.
> 
> ...
> 
>>  	tmp = FIELD_PREP(AD7124_FILTER_FILTER, cfg->filter_type) |
>> +		AD7124_FILTER_SINGLE_CYCLE |
>>  		FIELD_PREP(AD7124_FILTER_FS, cfg->odr_sel_bits);
> 
> Seems to me that this is not indented correctly, with that in mind I would
> 
> 	tmp = FIELD_PREP(AD7124_FILTER_FILTER, cfg->filter_type) |
> 	      FIELD_PREP(AD7124_FILTER_FS, cfg->odr_sel_bits) |
> 	      AD7124_FILTER_SINGLE_CYCLE;
> 
> 

All 3 of these lines are being removed in a later patch (haven't sent it to the
mailing list yet). So I will leave this as-is to keep the diff to a minimum.


