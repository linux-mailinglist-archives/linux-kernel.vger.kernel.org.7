Return-Path: <linux-kernel+bounces-742795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 50CF3B0F6C8
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 17:17:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C14BF188A63A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 15:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C5EF2E54C5;
	Wed, 23 Jul 2025 15:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="2jKYJlak"
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 999D7156CA
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 15:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753283515; cv=none; b=cymp4Zyq2sLsSBKt0rGqXuwo+O/WArkbPntyiE4gnoz69qwpSawB4ugpNz9w8uNC/CAf64lwoHIxRyVm5UwXlXboUu80NvwwZYYw788RwZRHyk+cqJL4BrOsJ9Gi2po4gqrM5hWbrHEOY7h9QKwRBUO/j39AOp6eYi6FdmuIL9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753283515; c=relaxed/simple;
	bh=42dmNoNeHaeyAh/9x6yJx9tx/4hkKLwnJU2fijUtJZc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ACXnkzW7B/Fc2JBg6C9+w1Ybk9Az5nsrSCpcajNMqfnH5xwJtbYwn2kwsLZdokG5rrFueiYKZoqd6Hy+zFscavLbOjoVZVGFaJmgA5RkmvPP6LDdG1vkSIPx4qL4p6Jivags1XG+DskPgK9E90tNSDhLb0yCCsCdoQpbPvJ0iHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=2jKYJlak; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-73e7804cf31so1394817a34.2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 08:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1753283513; x=1753888313; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S85WnsPVgtp4eLDg2p0Y3squYOTYT4wbTPP6Q+Mdo1U=;
        b=2jKYJlakQr0jo0lzRd2XBwObUDVMyNEfsY3EhUesNzQMrsnxR0ai1FyFYvx8ncrOL1
         M5lk4eeM/r715vPBzKorxuQRQrMvnVn2nDLx3olHli0OGjOZ+jtkeeXL7/uEVG9TKCER
         sp3NRe8L8lFHg8ZV5PumQZECSMHdNJfXWrJaZQnX/Bce4aSkwf+daakpDDsrM3byRFK4
         duEIiMSFGVX7RQsEYwlWwXFxM3L2nw/HX9LegnXP/yvYJTfNprA5SLm7Uv2n1gdtqEtn
         NnjEYSL7XEfJIT0eayks6YzkrYf299JJp5JfkEauhIK/uP0nIowL73AwZh97E0QW9Nrl
         qa4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753283513; x=1753888313;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S85WnsPVgtp4eLDg2p0Y3squYOTYT4wbTPP6Q+Mdo1U=;
        b=V98rLd3LLrqrs/YeZh4o06TxmU7ldyEvGw2+O6cI+JhvHAFC8YZfbuTWtUF/UwfCYY
         ltNolEVCUcMcWxs7tBXRqfIqGSSExj2FsERbZfB4zU6ApsbCERwIW35O217j+wxcjg5+
         D3q7evSFagOqW7cbz/78wEOSAErizf8Xs4Avr+3GyQWHMvLYjQlGCq1UOFT35VlmJQqa
         lQML3TqGNZqxJxaMuh3Ao0gU+gwUhZ2IIHKGY+FdSsyWlIwtatU1jv/982vEg2sNloKW
         B7fHqFJD993ArsSJbeeZOgkSSiwkGfjUA9AHF1wGpq5kFXIYMMBhUm2dEZV9ahSGDLTp
         m9TA==
X-Forwarded-Encrypted: i=1; AJvYcCWa+vt8hv/0mydC6FTakyZ6+M2PRhwmPfT/oHjiV8DDbIW2RHr+uSDjJ1RIwCSOE1MwvWtOo99P/t+hDrU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEKJ+Ec20uGP2Tsc3SX6wtPVz19wq9sD0iAckIycOjjCQec0tf
	8aLS/i1Gt/d/34YgII5/s9DB+aUdG3Z31GvM2UqVQtAP7CNc1kCtj3AI0QGk1GU0h6o=
X-Gm-Gg: ASbGncuUMBNEQuxVAoOgkTc9il+Ia2OpODSetpf4huw8jdtjsdq7KodtHNFwXPzLxc6
	DkDWIMc4/5kl7T2yYhoKuOCFMY5BV3GN/IMkrZTt3PCV7W1C2ic8MXwZpGsQcbRg9ewyyrKUvcN
	6Evtvaf3ClPsfB2nNKYicqNmkIPPGB+QycTD6jA4tzpGeLXl+S6+fBm0x/U2yux2vVNAnTXLbTH
	2jZzm9ElDE6fVMDt/yKGwlfJMlqbmpueFrIOEDJ6Db9QBWDO2EGEnGch5ZMAzz9mqZjXDhY9bEU
	esV0fYxUmgnLvTYzZ69g8IMpIyz1w222CM0QYDV7O7aR4o+Swn6RLMMmT3Bw0hqFjtbI+2rik6j
	5OUsN6q1KNg3m70bWTZIlF9pdTYg5QvtB4L1vokEvj1CLHdzPqYbr4Zx5ZAwr/ED+2AW5NhTjVF
	s46y3WAjg=
X-Google-Smtp-Source: AGHT+IESe/ClormQSj9MCq6UVWklH/eH8uzfHevbgKe0nfufdJcx8Ixa6/aSjLL+D07Yt1hJfEbavA==
X-Received: by 2002:a05:6808:4f69:b0:403:529d:fd81 with SMTP id 5614622812f47-426c4bdf54dmr2556577b6e.17.1753283512546;
        Wed, 23 Jul 2025 08:11:52 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:11dd:c0f5:968d:e96? ([2600:8803:e7e4:1d00:11dd:c0f5:968d:e96])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-41fd10c1f4asm3184197b6e.7.2025.07.23.08.11.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Jul 2025 08:11:51 -0700 (PDT)
Message-ID: <f74d6542-cc4e-40dd-8ef9-2a766d0b51ef@baylibre.com>
Date: Wed, 23 Jul 2025 10:11:50 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: proximity: hx9023s: fix scan_type endianness
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Yasin Lee <yasin.lee.x@gmail.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20250722-iio-proximity-hx9023c-fix-scan_type-endianness-v1-1-48f5dc156895@baylibre.com>
 <823a28d6-e612-4e32-976a-cb99945848ce@baylibre.com>
 <aIDuEcHhaGtz2klP@smile.fi.intel.com>
 <795dffe0-51cf-49a8-bbb1-1585edddf5ba@baylibre.com>
 <aIDzvNYIaJnSuzOa@smile.fi.intel.com>
 <7ca7e0b9-a77d-4de8-92b1-fea3250e8155@baylibre.com>
 <aID6jfjULn2kvvQJ@smile.fi.intel.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <aID6jfjULn2kvvQJ@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/23/25 10:06 AM, Andy Shevchenko wrote:
> On Wed, Jul 23, 2025 at 09:57:58AM -0500, David Lechner wrote:
>> On 7/23/25 9:37 AM, Andy Shevchenko wrote:
>>> On Wed, Jul 23, 2025 at 09:29:37AM -0500, David Lechner wrote:
>>>> On 7/23/25 9:13 AM, Andy Shevchenko wrote:
>>>>> On Tue, Jul 22, 2025 at 06:08:37PM -0500, David Lechner wrote:
>>>>>> On 7/22/25 6:07 PM, David Lechner wrote:
>>>>>>> Change the scan_type endianness from IIO_BE to IIO_LE. This matches
>>>>>>> the call to cpu_to_le16() in hx9023s_trigger_handler() that formats
>>>>>>> the data before pushing it to the IIO buffer.
>>>>>
>>>>>> It is odd to have data already in CPU-endian and convert it to LE
>>>>>> before pushing to buffers. So I'm a bit tempted to do this instead
>>>>>> since it probably isn't likely anyone is using this on a big-endian
>>>>>> system:
>>>>>
>>>>> I can say that first of all, we need to consult with the datasheet for the
>>>>> actual HW endianess. And second, I do not believe that CPU endianess may be
>>>>> used, 
>>>>
>>>> Why not? Lot's of IIO drivers use IIO_CPU in their scan buffers.
>>>>
>>>>> I can't imagine when this (discrete?) component can be integrated in such
>>>>> a way. That said, I think your second approach even worse.
>>>>
>>>> hx9023s_sample() is calling get_unaligned_le16() on all of the data
>>>> read over the bus, so in the driver, all data is stored CPU-endian
>>>> already rather than passing actual raw bus data to the buffer.
>>>
>>> I see, now it makes a lot of sense. Thanks for clarifying this to me.
>>>
>>>> So it seems a waste of CPU cycles to convert it back to little-endian
>>>> to push to the buffer only for consumers to have to convert it back
>>>> to CPU-endian again. But since most systems are little-endian already
>>>> this doesn't really matter since no actual conversion is done in this
>>>> case.
>>>
>>> Right, but it's buggy on BE, isn't it?
>>>
>>
>> Right now, the driver is buggy everywhere. The scan info says that the
>> scan data is BE, but in reality, it is LE (no matter the CPU-endianness).
>>
>> With the simple patch, it fixes the scan info to reflect reality that
>> the data is LE in the buffer. This works on BE systems. They just have
>> an extra conversion from BE to LE in the kernel when pushing to the
>> buffer and userspace would have to convert back to BE to do math on it.
>>
>> With the alternate patch you didn't like, the forced conversion to LE
>> when pushing to buffers is dropped, so nothing would change on LE
>> systems but BE systems wouldn't have the extra order swapping.
> 
> But do they need that? If you supply CPU order (and it is already in a such
> after get_unaligned_*() calls) then everything would be good, no?
> 

It doesn't make sense to my why, but the existing code is changing
back to LE before pushing to buffers for some reason.


	iio_for_each_active_channel(indio_dev, bit) {
		index = indio_dev->channels[bit].channel;
		data->buffer.channels[i++] = cpu_to_le16(data->ch_data[index].diff);
	}

	iio_push_to_buffers_with_ts(indio_dev, &data->buffer,
				    sizeof(data->buffer), pf->timestamp);

I agree that it seems unnecessary which is why I suggested the
alternate patch to drop the cpu_to_le16() and just leave it
CPU-endian when pushing to the buffers.

