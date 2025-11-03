Return-Path: <linux-kernel+bounces-883092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BAB0CC2C7A1
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 15:50:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6320A3B8CD2
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 14:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C9B3312812;
	Mon,  3 Nov 2025 14:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="X2Q5KfRZ"
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E13B630CDA8
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 14:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762181167; cv=none; b=LBtawjUxNNuVkCWBcLwgdNZGkUxb+l19nTFz/DRFPpY4eQ8CY9x3kbrY2ddIEy22CPHs0s6Mhb7DYsMAAxIOvfVhxdumgrPy2W4nbXrgJHSBQncsjy36HpNlLdTLfeN8kyak2W9Z2ZQtBa4CZoyc4P0PZWgA+8C/ZwSEQpX3ckY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762181167; c=relaxed/simple;
	bh=fs/2by/S27WDPm0ilbh5zFhuJpMec2Iy6t4szQvymlU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DZL4jwMWNgbjAdbFANpzB/mYSuhoFp5Ee8+jx30bl39rIuPT/w4e59c5yFyrUpcyg6YSyi1KQXx52N6pVbdaJT7SZuoDqQnvP+4QmhgxJtTLMUUQLW756D7l4r6+BCBr+A/StugxS3jy4/XE6lu/VLv7atH9dn0YEf/CpXu3OZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=X2Q5KfRZ; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7c53c863172so1403089a34.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 06:46:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1762181163; x=1762785963; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PDHP+mLFk92r6h7AxBTCn7EZSCxWKQie4OhNqh3d/ww=;
        b=X2Q5KfRZ0QP0bfsCV9/RJeH6irH9sQBy1Z9KMVKRv/bN2s8omz7llSIkykkMVo/r8m
         f4mJD5EogbOB10+6CwXxzoEujkK4h66PyejIE1ow47NBmL2gyZlEsVjlYNUkrwwnARgX
         esVO1UpaduvKFX7ffsNK9i9KP9XqLcyxCqu8hrP/sZHFea2zeqxRRzlYubY7IJZU881u
         q8HEOLWGoAG580qOzQkbFPyOLzZQmTmGfBmNtPcUsZOxz4rC8/uel0Io5FXWP9eb4GfL
         YjZtr+iFc27//7b30bguUC89ITZtAvF4euKv4RI9TQFGqNF0zyi5apiCoRrScSvyOOWE
         egcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762181163; x=1762785963;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PDHP+mLFk92r6h7AxBTCn7EZSCxWKQie4OhNqh3d/ww=;
        b=Sadu0FSSDv0W26br5zF8ncBM0oz8XX48xRKnNOsyyvvk3nAfURSp5pnWucMJOaXvod
         vL/YF29Dtbqz8+/dNv+PkL8F57y1SgZdhc8VRXAP+Ubk64+7DVkZ9QxxYYd2MRPoIx/h
         f24vzZ2KQ2AsGNRTQlbeHbcG35vU8zb6E1Ic4HTCVrbbevGwrdTUKJZuLrdoSPEjjOHt
         Sgw4e6E0Q/dAQYuZ8OUAEc+VhekhxnWcR4pkqIIlhXtmXS2sTX93LJAZzBMqTcMI6u29
         Ak1/Cxojlf5sC+9dmx4dzY++188cM8LVxMcL6GJUg1qZ2g2LsdIsoP4dAEyZJJ5NbuC3
         A1Jg==
X-Forwarded-Encrypted: i=1; AJvYcCWB4JdYZWvKfGLlKeNtMgE/bw9qpcTpDjuWcyqIytfjIgtnRCl46dBwaNDnvY+1W9bat8jHGxc/7p3Ei/k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVqEyKD3ogXP3kIQiVH+WcCEyefUKUkVdwW2jgYvMex2mQSbeD
	CJLxE5BRdutyQO4v5HpjJxJP02MDlIBYu8RXFmLJ3P27iu7+oUZdLioD0l67YGB6wPQN6gYECF2
	4xMhQ
X-Gm-Gg: ASbGnctcfuDXjL7mw64p07Og9Q64LmQcnIVy8kxCU8Y1AQCYPyf7sogiwimppnKlVZq
	vf9yMBt+yEwIFjg0JXXa14ahi+krPdvmKJFP7L77uExAu9Hnnb2fWOwnFhJPYOyVuuW3AkXMbCe
	IQAefZtnK1CKEnGQMX8Kvy+3JIJriRgIug5SU3GI39jqWEvJLRAkE6eWYlnAlpHZBMG9vB2z0T2
	eQ8xA8+mwCwyq/2bYTORU8qc8GDZq32oiXjOCGZYUSEQc3Wi5aImEb7w3q3HiEmV3CrRboA09p9
	8WVCryUqQrMcgmBDy8KqkobnFs4AZjGwlcctJTwzQ2gZvTY2lM1KiEvYYtTzYH1t1QcfCVtH1+i
	o9RzcsTXzszO4F0CdUVPurpBV3Dc6D8HpZ/ETujbBSw7pmycNf/wiXuUEsfq2jsfqCaNVXIrqjZ
	/QtBTG6HXzMEWyqoEPMP1DbhB55w/fKul93bVNVQXH4He78pHsTIrSr8bMv6XYcV/S0as+8BA=
X-Google-Smtp-Source: AGHT+IHncJLjW6SAXBWAuFDI30CJXo0InftwPdqGHG+Ii4HqdxDcuIic/Wojt73xZVCmFH2UZVHohQ==
X-Received: by 2002:a05:6830:4422:b0:760:6ff1:2995 with SMTP id 46e09a7af769-7c6967dc593mr6819660a34.30.1762181162575;
        Mon, 03 Nov 2025 06:46:02 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:37c9:fd3e:34ae:9253? ([2600:8803:e7e4:500:37c9:fd3e:34ae:9253])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7c6c2474ae7sm180122a34.14.2025.11.03.06.46.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Nov 2025 06:46:02 -0800 (PST)
Message-ID: <c365b17c-de18-4718-8d51-fa1d93236d90@baylibre.com>
Date: Mon, 3 Nov 2025 08:46:01 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 8/8] iio: adc: ad4030: Support common-mode channels
 with SPI offloading
To: =?UTF-8?Q?Nuno_S=C3=A1?= <noname.nuno@gmail.com>,
 Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
 Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, michael.hennerich@analog.com,
 nuno.sa@analog.com, eblanc@baylibre.com, andy@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, corbet@lwn.net
References: <cover.1760984107.git.marcelo.schmitt@analog.com>
 <3fadbf22973098c4be9e5f0edd8c22b8b9b18ca6.1760984107.git.marcelo.schmitt@analog.com>
 <20251027140423.61d96e88@jic23-huawei>
 <aQJY7XizVWbE68ll@debian-BULLSEYE-live-builder-AMD64>
 <ca6760182b4662c96df6204bae903d8affa6a8e3.camel@gmail.com>
 <aQisqe5EWARTwpQq@debian-BULLSEYE-live-builder-AMD64>
 <1c3712b9b5313ed6c9d07c1acbc9b918a4883056.camel@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <1c3712b9b5313ed6c9d07c1acbc9b918a4883056.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/3/25 8:30 AM, Nuno Sá wrote:
> On Mon, 2025-11-03 at 10:22 -0300, Marcelo Schmitt wrote:
>> On 10/30, Nuno Sá wrote:
>>> On Wed, 2025-10-29 at 15:11 -0300, Marcelo Schmitt wrote:
>>>> On 10/27, Jonathan Cameron wrote:
>>>>> On Mon, 20 Oct 2025 16:15:39 -0300
>>>>> Marcelo Schmitt <marcelo.schmitt@analog.com> wrote:
>>>>>
>>>>>> AD4030 and similar devices can read common-mode voltage together with
>>>>>> ADC sample data. When enabled, common-mode voltage data is provided in a
>>>>>> separate IIO channel since it measures something other than the primary
>>>>>> ADC input signal and requires separate scaling to convert to voltage
>>>>>> units. The initial SPI offload support patch for AD4030 only provided
>>>>>> differential channels. Now, extend the AD4030 driver to also provide
>>>>>> common-mode IIO channels when setup with SPI offloading capability.
>>>>>>
>>>>>> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
>>>>>> ---
>>>>>> New patch.
>>>>>> I hope this works for ADCs with two channels. It's not clear if works as
>>>>>> expected with current HDL and single-channel ADCs (like ADAQ4216).
>>>>>>
>>>>>> The ad4630_fmc HDL project was designed for ADCs with two channels and
>>>>>> always streams two data channels to DMA (even when the ADC has only one
>>>>>> physical channel). Though, if the ADC has only one physical channel, the
>>>>>> data that would come from the second ADC channel comes in as noise and
>>>>>> would have to be discarded. Because of that, when using single-channel
>>>>>> ADCs, the ADC driver would need to use a special DMA buffer to filter out
>>>>>> half of the data that reaches DMA memory. With that, the ADC sample data
>>>>>> could be delivered to user space without any noise being added to the IIO
>>>>>> buffer. I have implemented a prototype of such specialized buffer
>>>>>> (industrialio-buffer-dmaengine-filtered), but it is awful and only worked
>>>>>> with CONFIG_IIO_DMA_BUF_MMAP_LEGACY (only present in ADI Linux tree). Usual
>>>>>> differential channel data is also affected by the extra 0xFFFFFFFF data
>>>>>> pushed to DMA. Though, for the differential channel, it's easier to see it
>>>>>> shall work for two-channel ADCs (the sine wave appears "filled" in
>>>>>> iio-oscilloscope).
>>>>>>
>>>>>> So, I sign this, but don't guarantee it to work.
>>>>>
>>>>> So what's the path to resolve this?  Waiting on HDL changes or not support
>>>>> those devices until we have a clean solution?
>>>>
>>>> Waiting for HDL to get updated I'd say.
>>>
>>> Agree. We kind of control the IP here so why should we do awful tricks in
>>> SW right :)? At the very least I would expect hdl to be capable to discard the
>>> data in HW.
>>>
>>>>
>>>>>
>>>>> Also, just to check, is this only an issue with the additional stuff this
>>>>> patch adds or do we have a problem with SPI offload in general (+ this
>>>>> IP) and those single channel devices?
>>>>
>>>> IMO, one solution would be to update the HDL project for AD4630 and similar ADCs
>>>> to not send data from channel 2 to DMA memory when single-channel ADCs are
>>>> connected. Another possibility would be to intercept and filter out the extra
>>>> data before pushing it to user space. My first attempt of doing that didn't
>>>> work out with upstream kernel but I may revisit that.
>>>
>>> I'm also confused. Is this also an issue with the current series without common mode?
>>>
>>> If I'm getting things right, one channel ADCs pretty much do not work right now with
>>> spi offload?
>>
>> Yes, that's correct. It kind of works for single-channel ADCs, but half of the
>> data we see in user space is valid and the other half is not. For two-channel
>> ADCs, everything should be fine.
> 
> To me that is something that does not work eheheh :). I mean, going with all this trouble
> to sample as fast as we can just so we have to discard (or mask out) half of every sample
> in userspace (even though I can imagine we still get better performance vs non offload case).

If we are getting extra data to userspace, then either we aren't creating the
SPI message correctly and telling the controller to read too much data or
the HDL is broken.

> 
>>
>>>
>>> If the above is correct I would just not support it for 1 channel ADCs.
>>
>> Currently, it's just one part that is single-channel (AD4030). If patches 6 and
>> 7 were accepted, it would be 3 single-channel parts supported. I can add an `if`
>> somewhere to check the number of channel, but it will eventually have to be
>> removed when HDL gets fixed.
> 
> I would probably do the above or maybe we just need to push for an hdl fix or some
> final conclusion (like if they cannot fix it for some reason) and act accordingly.
> 
>>
>> Or, if HDL can't be fixed, then we'll need the `if` now and something else
>> latter to filter out extra data before pushing to IIO buffers as mentioned
>> above. Though, this scenario seems odd to me as I think the HDL wouldn't be 100%
>> compatible with single-channel AD4030-like parts. We would be writing code to
>> support AD4030 _and_ a peculiar data stream from this specific HDL project?
>>
>> My suggestion is to apply all patches except patch 8. IMHO, SPI offload
>> single-channel ADC support is broken due to HDL IP data stream not being
>> compatible with single-channel parts. That's not a Linux driver issue.
> 
> Well, it's not a SW issue but we are driving the HW and we know it's broken so I
> don't see a point in having something that does not work. Given that this is so
> connected to the HDL part of it I'm not sure it's fine to ignore that offload does
> not work for 1 channel parts. 
> 
> Anyways, it's odd to me but ultimately if Jonathan is fine with it, I won't object :)
> 
> 
> - Nuno Sá

If single-channel parts currently don't work and two-channel parts need [1] or
a hardware descrambler to work with a single data line, then it sounds like we
are blocked here until the HDL is improved or [1] is merged.

[1]: https://lore.kernel.org/linux-iio/20251014-spi-add-multi-bus-support-v1-0-2098c12d6f5f@baylibre.com/

