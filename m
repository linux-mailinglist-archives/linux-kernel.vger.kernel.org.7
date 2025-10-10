Return-Path: <linux-kernel+bounces-848498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF591BCDE80
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 17:57:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBB0E3A3CE8
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 15:50:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DD952561A7;
	Fri, 10 Oct 2025 15:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="N2+ivFbN"
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 609AD25DAF0
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 15:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760111447; cv=none; b=l8MvzVWOOEtasu9aU8OsHIi3eXFw4QGjgcNDejrrjSR//XHvUbQqxsSB/ThxYQ3r5UBF4jPzu39DtFRquaZzcrT7i8pdR3KGVJl5nLg6IavkJ7QEehsL/tX93fU0dgsqJupHKza5xBvhuMcrUO81vVhuHf5aecZ2wrgOPCxW3GY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760111447; c=relaxed/simple;
	bh=Lr+jKNfeiIaKX/OCJwSJFFQhKa98XMsgnhtzVqhKr+Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Er4leKyJjzR5Ir68e7/g/ZAN2OnmMFW1zzHmfKQ4lj8Kj9NBr6zSIvujcuqk7rwffh+wLI9XUj25UjfaGFv7CRcN6pP1TW/QwenA9DS2t5+YJVRZxt2MaTVBkQYBNkIgr1hUYDqOMW4ibhSinVHXYqLaT4ZNe18vIYY1JihNgOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=N2+ivFbN; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-43f47280160so1289708b6e.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 08:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1760111444; x=1760716244; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/Wla+XRCNTxPSui7Pm3LI+bmBJn47wan8XF9ZjOoM70=;
        b=N2+ivFbNOjCsuVXun5JLnggSTPx9/Su4gFlgGvgxKCc3dtBzXS1B5eR7eR6kccTgGL
         aONNtlO2XqMyv6rSc7aq6Lfi+3D0ZTDoUmBqY+AD8SSurKZRTKjynKY3SF/OTKyDQWJf
         KsN+AackdmYPjEkQwhyEtTfDSD/JWV1Db1Ol/b9JL3103OPpL17eTv0PwX5TWV26y3tE
         cI/jXGjVHvT2Aj+1XDeD66miZSiLU3FTCgxsZ2wLpwJmPpUrTarPgBw9rpSFM7xO/5RJ
         WE7AgSDvcr51ycIBr5vsyDEoBxudCWN7LmsgEg7iwAacqRYrM/M3SaaZEQ/R8x8wAYTY
         mX9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760111444; x=1760716244;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/Wla+XRCNTxPSui7Pm3LI+bmBJn47wan8XF9ZjOoM70=;
        b=iYkOyNt0GwOs2FQZJib3JJjEOtfsNCQsQLG0gtGFHOk8NMlZNvRhFOVIPV2n7PIZnl
         DWBYFTiMd8xjSWsThmLlMZtrl+LNrL16iA/4GDnNJUixTC1NiUXoD2+yroBXAG9vAYlv
         qOSzYBxB9Lk8VZMAtWPH2IJrP+cwvx66Rr51f03+eHjjvqhf6EgqGFOk16Q+hm8vgEb6
         vvAQyjsALjcuccoQLFxERbEYY4gZ9RtXCJFq5qka9M68uiXa1R2wHRENnQieCIXVtZdF
         y5iz/MPV13mllATfNif97XYgn8PI63pb/R9zzdQB7dvxhG5H0YumeaKBhLfNs9CXRKg1
         whCg==
X-Forwarded-Encrypted: i=1; AJvYcCUiDy462Vray8benkD2Jgxi7enN1hEUherCaoodhymXaOw56bUFl4S+4hkO8F6klp5dLGtaThpY9MCOMLw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOS77oivKMSBr2kSQ1JaZf2ufsvIMt4DmvWpdKiWapXp647Ulz
	xCxDJh9FW3LTildtMDnUhophm291dnFRNOi2dZyhHIPAEBid5WITJ12DyRmJwku9uFE=
X-Gm-Gg: ASbGncvWTwXUA3YhNFttZy3NWWm5NTAa5ZZCnz5jfiMCKaA0iG56DoxbgY/N8lKbfVg
	rDacHWBfcwU0UQd3k3cgYuw5gT6HzqGkj1B0wuJkW0ODZD2HrgJJUR2xYStb12igxPJN9cVRWNN
	AcBpGD26wsnhTc20anuB6AHPFDBR5tRZ+lIH5nNuuMB+/VDS+grr3xHrgzya/RFRlcYsL4bZKck
	nn/PIgWH0MHQAWjWv7hpTvApHO6huVkyuUVjw4u7+PLf1KHTmaGRUDJ8md5os/Skvmnktfphol4
	kSxJWzyjDeDizPk4bHuwWzwVMhqicKesooD7YTgsKqVmevRYd6ykWTF24ClDEPCajmpBVnu+ZF7
	FjNgK73NgZpblHjzTszJD6nttz0gT8A9pvbo1ywHqyKgRu8hW80y1RAp6q1dAGtBX6V2Ab5rQ3k
	5RYT/yDQtcLc/YCMOs2H/2xCCL3g==
X-Google-Smtp-Source: AGHT+IFmSQs/65lBMWUZCbPudB/Y7vsZmZnRWmezkFLrbBsfFTtCSMn4x+tYxlovrhd6L79TJQ3aRA==
X-Received: by 2002:a05:6808:15a0:b0:43d:20f2:2e26 with SMTP id 5614622812f47-4417b34558dmr5969421b6e.10.1760111444375;
        Fri, 10 Oct 2025 08:50:44 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:6d3b:e3bd:4210:32e2? ([2600:8803:e7e4:500:6d3b:e3bd:4210:32e2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7c0f9067bbbsm944113a34.10.2025.10.10.08.50.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Oct 2025 08:50:43 -0700 (PDT)
Message-ID: <007e87d2-92f5-417a-a6bf-1babd4c60c61@baylibre.com>
Date: Fri, 10 Oct 2025 10:50:43 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] iio: imu: st_lsm6dsx: Decouple sensor ODR from FIFO
 batch data rate
To: Lorenzo Bianconi <lorenzo@kernel.org>,
 Francesco Lavra <flavra@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251009173609.992452-1-flavra@baylibre.com>
 <20251009173609.992452-3-flavra@baylibre.com> <aOg3dg21aWNTF47x@lore-desk>
 <160b32c14df3daa06304fef430534561cabcfaea.camel@baylibre.com>
 <aOjAK9LRMCcBspkb@lore-desk>
 <9dbd2ae7883ec8dba65706603a29f3144076840e.camel@baylibre.com>
 <aOkG-jBOYXxWy1z3@lore-desk>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <aOkG-jBOYXxWy1z3@lore-desk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/10/25 8:15 AM, Lorenzo Bianconi wrote:
> On Oct 10, Francesco Lavra wrote:
>> On Fri, 2025-10-10 at 10:13 +0200, Lorenzo Bianconi wrote:
>>>> On Fri, 2025-10-10 at 00:30 +0200, Lorenzo Bianconi wrote:
>>>>>> The rate at which accelerometer or gyroscope sensor samples are fed
>>>>>> to the hardware FIFO (batch data rate, or BDR) does not have to
>>>>>> coincide with the sensor sampling frequency (output data rate, or
>>>>>> ODR); the only requirement is for the BDR to not be greater than
>>>>>> the ODR. Having a BDR lower than the ODR is useful in cases where
>>>>>> an application requires a high sampling rate for accurate detection
>>>>>> of motion events (e.g. wakeup events), but wants to read sensor
>>>>>> sample values from the device buffer at a lower data rate.
>>>>>
>>>>> can you please provide more details here? Are you using the hw fifo
>>>>> to
>>>>> read
>>>>> data? If we configure the hw fifo according to the BDR (even assuming
>>>>> the
>>>>> watermark is set 1) the hw will generate interrupts according to the
>>>>> BDR
>>>>> (bdr < odr).
>>>>
>>>> Yes, I'm using the hw fifo to read data. The use case is to enable
>>>> event
>>>> detection (which works best at high sampling rates) and sensor data
>>>> streaming at the same time, without requiring the data stream to be at
>>>> the
>>>> same rate as the sensor sampling rate. So the amount of I2C (or SPI)
>>>> traffic (as well as the rate of periodic interrupts) required by the
>>>> data
>>>> stream is kept to a minimum without sacrificing the accuracy of event
>>>> detection.
>>>
>>> I guess you can get the same result (reduce sensor data interrupt rate
>>> keeping high odr value) configuring the hw fifo watermark.
>>> Does it work for you?
>>
>> Setting the hw fifo watermark to a high value reduces the rate of
>> interrupts, but doesn't do much to reduce the amount of I2C traffic, so the
>> issue would still be there.
> 
> ack, now I got the goal of the series. I think the series is mostly fine.
> I guess hwfifo_odr instead of bdr is more meaningful, what do you think?
> Naming is always hard.
> 
> Regards,
> Lorenzo

In the IIO subsystem, we prefer to include the units in the variable/
field name as well, e.g. hw_fifo_odr_mHz.

