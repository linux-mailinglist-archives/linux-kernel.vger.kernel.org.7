Return-Path: <linux-kernel+bounces-806001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 72EA6B49091
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 15:59:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC1C31885C23
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 13:59:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E89CF306B35;
	Mon,  8 Sep 2025 13:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="q2/deTxr"
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 117ED219A89
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 13:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757339934; cv=none; b=srSHyZxZ6TvKIa/tf+0E2yDUT/dUzXcFBvAzfWcinWg3naK6vYvIgRrsiCdnBgNKC2xDRR54oEECIWk/vTWVS+Bs2cr34R4MoXwZKA9z4VO7jKJ3XFlk4cP1UuXtPJH07P9p1R7iq7C+M4HlfkqWjCn/kPDPieGUS0hQ3OtRG6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757339934; c=relaxed/simple;
	bh=nnUQdXDtc1/htbgItUKvh9KzsFDQchaQnV43ZN8NEFE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZXYQvCJ4Cp1eTtm+JP/7psd3lzqBSdjiRd3ixOYxXrzA+0XbEzBZwBay8hbrZhk+GgDwpEaqkwkgG6Y6f0ExxP1UOJHkGxe6utDVvBdny5ur68aQg4vj0Ok8Acf3XJaqtbd4NP3IHp9PGLl+cqaJBs723JGn5flUhUtZ+ff4SYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=q2/deTxr; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-315a0b68314so3899043fac.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 06:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1757339931; x=1757944731; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gDFNaThuo0PvZZYSMHlfPbpR/XX95Jknj6NoGboj6lg=;
        b=q2/deTxruJLnCgYvrDadBbSQ4dWNB6Pih+1tRxrzRAsYjwQik+Y//fkJmPjMSi9c6b
         S3PE46hLU19OYqlSjxAYSe+zwpzc9R/+SQoCenUG94ijuFT7fDgMq+aArwl0mCASgMAO
         XqgZSriEKfrF1fJa3+mCPQC85AomlPtCS59jdGPzEXmIHOhohDsNH0YBMtOu4HLLRmbV
         3+KyMz+xCeNHcsYdPHUJBriJD+cwsRh2c1cXsywml+Unaut2bY6lYIEDhKU2Kwoku2NM
         rZSbXxiKzVe54OaMDAPhPPWXEQAQYVcNS8d5WqMOfeUS5SnbPd08olIX63X1SVhqIl2h
         A1Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757339931; x=1757944731;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gDFNaThuo0PvZZYSMHlfPbpR/XX95Jknj6NoGboj6lg=;
        b=cNafk/kgHyEdFDlqgI5xQ0ES3Z0MzSEtVmQDZuNmlPQJgk/LwhqV5vVQg1ybt4Xhrb
         gs5y4i+1bx+eYOCyQJ6SMhFkDOxvEKqTE7ZX1YUAWLllnYdvrWVXz5jNAjPgIhvCmlQz
         E3StKsGuA+PrbHvAr3T+GhGNaDaG9p6P6AmXaINfJdA3FQcCuyMGFTLZHKKDJ+MqKJ36
         KvfPNMMrAl+fF9lX1BHXX1GM7T7647ttzV+ze3QaJKVranxvXLnmb2XrrJ41Xv+GA5/t
         x3AMGID/zLF8HL6q3w1/HyLbG1ebKYK3HyfuYKUh5QaNsuUoaD5wBNV2+Jk3e+4rrc30
         DVtw==
X-Forwarded-Encrypted: i=1; AJvYcCWaPSkP8L9taAG9OXS+t8M9uFPuXd9GOwVn7yzFt2KV+bg2yFvgWkAsX34Nm9wR9JKb4pQr/ZQTMezmFTU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgUPpxSLZ00HYZ6tby5m1XOUU6a62GBcE7GRxKlJIuPvatb9TR
	IbfZ7JI2h7EdcxBOiRaN8ghyTuZUJEZNcbcItkQIjeVYvYha87nOGIcNGprQ40BbBmM=
X-Gm-Gg: ASbGncvnUceAbHKVjRuy55Q9zZ2pOrEPneidtlTMPa8aJQ+3qC/GNmxpIpFWCErNPUH
	MNIWvRxSqBJ64n+MvU0R8NZ3YrxiI7hmo6jnElSMkOltS5AA9HmRRZfy+n2He9tNckcBK0YzB2p
	J9iKH6GZl7PA20FHHhW2FynlOWR37hXtwLQvp7xvQv+NnH5VvVBvNhjb+vOTJxL0jonxOHDgHOi
	/hukkBaeqwIsfBgy4vBcEGtzk+eadxWGKy7Hv42OlKt9CPeC3VvyBXF3mpuabMN6gZtjAfsvRv1
	YeM5ODJPUxEgA8TN1ttfm20lT0ZMzdwpDM1antxiLQ6+HXkn3F5ZJwSQh+QXne+ERDGSVg0CoAL
	SrjHpt/1Ytj6wOOFzynacD1MLDkmJ4rgQPeMVkjh2dj3xtQd3IK1ZETS+GunquPn0E2ALyj+4kq
	AnTKeCZvMwGA==
X-Google-Smtp-Source: AGHT+IEPQYSTXuY8KKXgCvExJN+PZ1J2AcW9uGwlCK03wEeWUxvan6qwMKW9MKZUGeyFqcFqjVGwrw==
X-Received: by 2002:a05:6871:6a5:b0:321:80a7:a1ae with SMTP id 586e51a60fabf-32262a7d5c4mr4189811fac.14.1757339931066;
        Mon, 08 Sep 2025 06:58:51 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:c856:f3d3:de1a:6f93? ([2600:8803:e7e4:1d00:c856:f3d3:de1a:6f93])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3282d63b5fcsm1037740fac.4.2025.09.08.06.58.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Sep 2025 06:58:50 -0700 (PDT)
Message-ID: <c23ed0cf-8188-49ac-b310-57bbfb54f337@baylibre.com>
Date: Mon, 8 Sep 2025 08:58:49 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] iio: adc: Add the NXP SAR ADC support for the
 s32g2/3 platforms
To: Daniel Lezcano <daniel.lezcano@linaro.org>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <noname.nuno@gmail.com>, jic23@kernel.org,
 nuno.sa@analog.com, andy@kernel.org, robh@kernel.org, conor+dt@kernel.org,
 krzk+dt@kernel.org
Cc: linux-iio@vger.kernel.org, s32@nxp.com, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, chester62515@gmail.com, mbrugger@suse.com,
 ghennadi.procopciuc@oss.nxp.com
References: <20250903102756.1748596-1-daniel.lezcano@linaro.org>
 <20250903102756.1748596-3-daniel.lezcano@linaro.org>
 <eedbfbfd1ba625b6750eb3ae20a69301b8bc3ef9.camel@gmail.com>
 <0bfce1eb-69f1-4dae-b461-234eb98ffce1@linaro.org>
 <a3373804-08a4-4526-a432-c21a74ea3d6b@baylibre.com>
 <edc8e024-e425-49de-bfa2-44218fe72e26@linaro.org>
 <6b8cd005-b04c-4dd7-abf7-5a51319a5f0a@baylibre.com>
 <23b80d52-6149-483b-a159-276dd00d12cd@linaro.org>
 <e5e76789-c8d9-463c-aa01-f2c6ae718f74@baylibre.com>
 <fd4c81a5-3b99-448c-92d4-9465f0e76db3@linaro.org>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <fd4c81a5-3b99-448c-92d4-9465f0e76db3@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/8/25 7:16 AM, Daniel Lezcano wrote:
> On 05/09/2025 23:54, David Lechner wrote:
>> On 9/5/25 3:58 PM, Daniel Lezcano wrote:
>>> On 05/09/2025 17:25, David Lechner wrote:
>>>> On 9/5/25 4:44 AM, Daniel Lezcano wrote:
>>>>> On 04/09/2025 19:49, David Lechner wrote:
>>>>>> On 9/4/25 12:40 PM, Daniel Lezcano wrote:
>>>
>>> [ ... ]
>>>
>>>> Taking a step back, what sort of real-world uses cases do you need to support?
>>>> Or are you just trying to implement everything that the ADC can do? The latter
>>>> can be a bit risky because you might end making something where you can't do
>>>> a buffered read and a single channel read at the same time, but later find out
>>>> you have a real-world application that needs to do this.
>>>>
>>>> It looks like it would be possible to implement buffered reads in lots of ways.
>>>> IIO devices can have more than one buffer per device so we can add more in the
>>>> future if we need to. So I would just drop the DMA part of the implementation
>>>> for now and implement the basic triggered buffer using MCR[NSTART] and ECH
>>>> (End of Chain) interrupt request and just reading data from the ICDR registers.
>>>>
>>>> I would wait to have a real-world application that requires DMA to decide the
>>>> best way to implement that. There are lots of possibilities, like does it need
>>>> an external trigger or is continuous mode good enough? Does it need to be cyclic
>>>> (something the IIO subsystem doesn't really support yet) or not. Is exact sample
>>>> timing important or do we just need a big buffer? These questions we can't
>>>> really answer without a specific application to use it.
>>>
>>> In the case of this IP, the use cases are in the automotive context. The system running on the APU is supposed to monitor at high rate (or not) the different channels which can be connected to any device the integrator choose to use.
>>>
>>> For this reason, the driver should be able to support the different modes because the integrator of the car computer can decide to monitor the devices connected to the different channels differently.
>>>
>>> Said differently, we need these modes because the capture depends on what the integrator decide to connect to the different channels.
>> ...
>>> We just know all these use cases exist.
> 
> 
> The submitted driver supports the three modes.
> 
> Nuno asked to use the IIO dma engine API.
> 
> However there is few information and examples with the API and I failed to use the devm_iio_dmaengine_buffer_setup_with_handle() function.
> 
> AFAICT, devm_iio_dmaengine_buffer_setup_ext() can not be used because dma_slave_config() is not called, thus the src_addr is not set.
> 
> Is there any example somewhere, documentation or guidance to use the API?
> 
> Thanks
> 
>   -- Daniel
> 
> 

Unfortunately, not really. Until the last few years, there wasn't really
any users of these APIs. I added devm_iio_dmaengine_buffer_setup_with_handle()
for the SPI offloading work I did recently. The only reason it had to be
added is because we needed to get the DMA handle from a different devicetree
node from the ADC's node. Since this device has dmas and dma-names in
the devicetree, then if devm_iio_dmaengine_buffer_setup[_ext]() doesn't work
with that, then it might have other problems (assumptions made for a specific
use case) than just not calling dma_slave_config().

I think maybe Nuno and certainly I are guilty of trying to offer you advice
without looking deeply enough into what you already submitted. :-/

I see now that what you are doing with the DMA looks more like other SoC ADCs
(AT91/STM32/AM335x) which is quite different from how the iio_dmaengine_buffer
stuff works, e.g. cyclic vs. not. So unless you are interested in evolving
the iio_dmaengine_buffer code to be more general to handle this case as well,
it might not be the right tool for the job currently.


