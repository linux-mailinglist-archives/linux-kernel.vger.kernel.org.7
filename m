Return-Path: <linux-kernel+bounces-805768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EBA86B48D2E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 14:16:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 218731646E9
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 12:16:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33DDC2EBDFA;
	Mon,  8 Sep 2025 12:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jmKhRTm3"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B86222759C
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 12:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757333782; cv=none; b=ehTtEPPAtFZkA1gxYHJD+eewFBy7eGbBnTr+VybcEaqa6zE1KcXjpmkOBIj8f6QXqmh0IYJPtBp7c022EC+2bgVkiGdd0jnUb2naln8kaqcaGNnVnh5iweT+VVhYXj0kSrghNCzpxtXGu+RW6cH1xXuGsJbtpr6x+s09gEo2XZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757333782; c=relaxed/simple;
	bh=4MmMtxr9FWrYk3eV+BcA70HiaflcG4yNB+x6gFP8ABU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gHipuNG7SNAjbaz7ok4BQvm4hyPAOFIGhlkzQTNxiGYYAToo7C4giVpYQJHaUOs5tu+qvfrhk93HsTng+JIgC3m1OVK5zcVrcyJ0Ay+TQ/16CZHsIfv0J5rnUumxrNv6MUzriolTlybqMs2ujYL26+bs+CuYvR1prZpnNlJh6L4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jmKhRTm3; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-45de6490e74so8350925e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 05:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757333779; x=1757938579; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YKwYvq6k8+ej97B1SVmOtFjmmFjJAHPbIxSDGQ7VhFc=;
        b=jmKhRTm3JyllAyunYNX1/lFXzcBVzwzgiBxuYeQFOtU4Dwpjm9y+2GZZKhr6/a8eus
         JehOBy/6si61qYlkh5X8MR5eVFVUjy50RaCxNfQ34KaIgVFMkkxPfiNSr6qErxCzVKRV
         /r2/JvvGV31Ufv3PCm/hdncso/XXxwrmvKBtz+FkPV+7uql7RwljY3SVBJa/aq0UNvV0
         9fkWySTd+vwSwCn8CKDtxxkeYy0ar+pfiLLL1UvIfyP5sFkhA0kPEors4nJMAhSifsTQ
         8I2+tGLbOZw+uivKhj79Ai4BcSeegXFoR/BfvPFMTxN40CS5MPfnwR61jDixwp68rGE8
         7viw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757333779; x=1757938579;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YKwYvq6k8+ej97B1SVmOtFjmmFjJAHPbIxSDGQ7VhFc=;
        b=dYQlmCYj3bijjn3EAwDEqCg9RtCV4ohUepl8Wca/JgXMWRL63vs5dlNgZhjXdLJiBv
         piNVn33Ug82kbU46aA47/fYrvlxt9yq+XBHX6OTMZ91D4/73+4bguiAYTqZsI9qCxCQ6
         jAo4wrSAhyNR9HMnA5CfRl1gLyPO4rwLLWtut+EiZdqAFTxe7/Q02uaMqW3rTXgINYF8
         QmCyTWcxtLWLslFov0Ijb5gF1B6Immpk0geJqma4Pv7xkEHaHVJA0t+Rya5ubvqqKug0
         zPJdHUR7yhOT5WD+qG8k2nOBGKs/zvCkfUP8mB+hc/8l/vpxHylHwpI37R3ZpnvYAye9
         p11w==
X-Forwarded-Encrypted: i=1; AJvYcCWj1GrreHI+I8pYsZq9AafFPglTQBvIHE0ZQEi+5qtwOejxeKK9Xmjv5Ykqh+ma1koy63uPWEXyXVc6alc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yws9eCCsggWpmSBIUgufcu5vgfaumA0Drvn+MMgI0BYB7vFUWTZ
	yXDWJ7PbYUhKiY4NtbxilIj95renab7ZCxM24hvj7Ott41KP7Gx6aOhmTP5SH4T19gs=
X-Gm-Gg: ASbGncskXiQjS8fffJIKWaHGSTU745+BC35qE13xUrpEtoESTswO2MZ3DIa6/pS4/Ar
	8ekyKIqO9mXLj6fP0lC7jN2Ivn8e/B8O1T51qdiXDvUoKY3Bf3KuuJ50SccHMEl2AAURQza+Bgt
	TYHKoRT8l2k1zXgz6n2fRl68bO+qos+Y7qNciO6DqZLIg6V4J040FINBX4MsA+Q0fajRPZ08pjL
	rGPr4eOxNk4SuEyjjiUqF3dCRBVv6bCsXe7kUksCPpoRgrnq6+xPFlP903XEC07Y2gLtDM92kw6
	SxJveBDGGQ2FYm9lbCYB0u/YqAQPql/hyoxUCIg+f049c1rL2GIWgpGWpPs44VtBeowvuS1WOg7
	Qn/fuS/sqFVESUpEPGHR9Vr+TYLvgqlSZnww6R5jtTSP9ZdOWFgq9j/p2+OXPxOOnuzzUIVAQjR
	fnDPETID/CFr1B
X-Google-Smtp-Source: AGHT+IHHaHG9f3JfZZVt+d1nycXZY2xvo779V3OBu/mIAiQ09/Gn1pehlQ1lC70/JTuVl0j5hESIAQ==
X-Received: by 2002:a05:600c:474a:b0:45b:7d77:b592 with SMTP id 5b1f17b1804b1-45dddea4cccmr73119825e9.12.1757333778815;
        Mon, 08 Sep 2025 05:16:18 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:9b6a:7b16:fb30:a294? ([2a05:6e02:1041:c10:9b6a:7b16:fb30:a294])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-45de15de318sm86864365e9.13.2025.09.08.05.16.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Sep 2025 05:16:18 -0700 (PDT)
Message-ID: <fd4c81a5-3b99-448c-92d4-9465f0e76db3@linaro.org>
Date: Mon, 8 Sep 2025 14:16:17 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] iio: adc: Add the NXP SAR ADC support for the
 s32g2/3 platforms
To: David Lechner <dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <noname.nuno@gmail.com>, jic23@kernel.org, nuno.sa@analog.com,
 andy@kernel.org, robh@kernel.org, conor+dt@kernel.org, krzk+dt@kernel.org
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
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <e5e76789-c8d9-463c-aa01-f2c6ae718f74@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 05/09/2025 23:54, David Lechner wrote:
> On 9/5/25 3:58 PM, Daniel Lezcano wrote:
>> On 05/09/2025 17:25, David Lechner wrote:
>>> On 9/5/25 4:44 AM, Daniel Lezcano wrote:
>>>> On 04/09/2025 19:49, David Lechner wrote:
>>>>> On 9/4/25 12:40 PM, Daniel Lezcano wrote:
>>
>> [ ... ]
>>
>>> Taking a step back, what sort of real-world uses cases do you need to support?
>>> Or are you just trying to implement everything that the ADC can do? The latter
>>> can be a bit risky because you might end making something where you can't do
>>> a buffered read and a single channel read at the same time, but later find out
>>> you have a real-world application that needs to do this.
>>>
>>> It looks like it would be possible to implement buffered reads in lots of ways.
>>> IIO devices can have more than one buffer per device so we can add more in the
>>> future if we need to. So I would just drop the DMA part of the implementation
>>> for now and implement the basic triggered buffer using MCR[NSTART] and ECH
>>> (End of Chain) interrupt request and just reading data from the ICDR registers.
>>>
>>> I would wait to have a real-world application that requires DMA to decide the
>>> best way to implement that. There are lots of possibilities, like does it need
>>> an external trigger or is continuous mode good enough? Does it need to be cyclic
>>> (something the IIO subsystem doesn't really support yet) or not. Is exact sample
>>> timing important or do we just need a big buffer? These questions we can't
>>> really answer without a specific application to use it.
>>
>> In the case of this IP, the use cases are in the automotive context. The system running on the APU is supposed to monitor at high rate (or not) the different channels which can be connected to any device the integrator choose to use.
>>
>> For this reason, the driver should be able to support the different modes because the integrator of the car computer can decide to monitor the devices connected to the different channels differently.
>>
>> Said differently, we need these modes because the capture depends on what the integrator decide to connect to the different channels.
> ...
>> We just know all these use cases exist.


The submitted driver supports the three modes.

Nuno asked to use the IIO dma engine API.

However there is few information and examples with the API and I failed 
to use the devm_iio_dmaengine_buffer_setup_with_handle() function.

AFAICT, devm_iio_dmaengine_buffer_setup_ext() can not be used because 
dma_slave_config() is not called, thus the src_addr is not set.

Is there any example somewhere, documentation or guidance to use the API?

Thanks

   -- Daniel


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

