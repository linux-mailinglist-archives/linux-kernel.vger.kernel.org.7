Return-Path: <linux-kernel+bounces-803853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93441B46632
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 23:54:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47EE516560A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 21:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B10028642B;
	Fri,  5 Sep 2025 21:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="wGIX+wDD"
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9037C287241
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 21:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757109249; cv=none; b=NSBmfCDF1cqCB74XNeyh+ynAqDIMJcrL7168fltmxx7pzTfEEzE4UAhuE0pdyvYiwjEBpS4xbTinSjyOwsIby1EQl9p8/588L0lp6hg0EkLEFaKPVvczHFce9CgcV1uA3HIdItf/eAQ6gglMYT4ZM6esKRrSxAuhceHNH7VJB6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757109249; c=relaxed/simple;
	bh=j6tnYW71dNyHGysaY2hYHozv03AFzw5XgjK4LS781bE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kyfgc5807xgO335zHrpzPV35oQSxFvIFZv50n9tIdNdQsp0qRmD1B2gb1nlmc0R0myE55Q0zNQVm+5kbqZiegsoRK/cDQp+977D+jJXXylypQrRe2GiLbemGZIpnJ1eYXzIR7PZVxffAqTz/CHz9Fyt4tovEkSICQlMXfzArJfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=wGIX+wDD; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-315a0b68314so2243971fac.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 14:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1757109246; x=1757714046; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=geUOZPIM1H0puFsovboYTPlTcH8IiFSVx5bKk2dh98U=;
        b=wGIX+wDDzsdKFCHGb65u/lhrn0u1TNLsS1VY9/CQRAckXlYduc5Rs4tG1XPIxb1iDr
         Efcx5FJD0KJ4piOY8j9vePaVcKVN4i9OTD7FZuYSjmR9X24VBJrj2xfZMER6IydpavjV
         ZS4bVKMsemsjeE4zgNw7LC86QUgMMAh6iUbRm6x8NC/p2kAI5uJgYle/I67n6d9UIRjZ
         iiAz5JAZaPuT+HV3KP5YhEQoS79Ez9pMQJL9mrVGZYoZCt2sisL3ryMVMN4YoaHi2Pb3
         Tc5COqKIpAyPbguz45TiDQCTtBVX15y1bYhAMV2yAXbMYMzF43PWjLzeVqXn+vabebpt
         SGFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757109246; x=1757714046;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=geUOZPIM1H0puFsovboYTPlTcH8IiFSVx5bKk2dh98U=;
        b=vo6xB4DEI9Xosk0RGYd9W+UO/ihmEP2bMYS10nEWW2AIg4+Rev6+ziO2m/hNNU+AH3
         jj6OaWy3JTQl4Dtbk0FimYwSaJVnXFPTHU50nIaiZILOvWYhVR7FyPttuq0jMPU7rmyG
         oUBFtajsfzedrgWddODwPuEee3zXRxP4z1De/ASCu19jg4q/QeZ74CqlwKHd33wIDh4q
         dOjfxap5uhis1PLt0w3uvHLcKPpJMESIYRM8dR9bHR3DHfDvrax8Gv7o+m/F68YatWR9
         zYMPURK0mbM0CA4pOBIxMTwI5ue+tixIKRSBrek0FQU/VnMuiqWUPcEACOycK+1AImih
         aBzA==
X-Forwarded-Encrypted: i=1; AJvYcCVjO5wBBiolBjL82snvd4zfOUMx5ng6cyPxVnOetbPCVDqE3KVJxwYEsdJv62868qU7ZUoRLJxr10HQ9Xg=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywwx5jDVDINe+WQbRLb3xdx/tWohhNEHNYwgs4QIgP5z7zX0J9E
	yQa6W/Osobgus1AfUNihILtF6nmolG7X3vNXDleG51pd/ChSArQ+t3HIfMXDQSUxclc=
X-Gm-Gg: ASbGnctdvc1irvge9mnGdwp3L4Sz2ETOXtNIaH3Vp9MqL2Ve3Y8TAdhPDw67O/+e8W5
	ZJGeckhmofZUz/S8ySA5M6RCH9ObE5jff80kG5JdepamuSGwRRexOtLo8a+8mJhWwAKUkythp90
	0D1zG5hRc9y0CY/Xedb2fBniEtvdkSrT6rkPvs+nnUHJqhgy28ECr83ILwc5ONsa4b4iUfnhRRC
	neGqBYaKMgpN2Kd7fO+VJX3F5MfPdSMHrjIyn2jHvMZyHTyr/awf+m6jtWfMknp9vE9BlcRu5Ov
	GgLjISVE2i4OwAXnDlUZ/+Z0TZBK9kZndAOBf3QY7RjP5014Qu/0Qo9q7gZXcVVJ+NZlwWeA3ub
	IAhyvwhq5KYKDnEwoEI6WSnlJnBmJztFRDkctpJo/p4ky31ssRhv0v/KTknKoQRq0GmbG6ZWX
X-Google-Smtp-Source: AGHT+IGfk5K+s35XPShmflVbwVdAHvuZ3nG91RGSV8iFUqGTJlmmKaTQGR4sWgOGsMuN+p485ER7/g==
X-Received: by 2002:a05:6808:6c88:b0:437:decf:ab53 with SMTP id 5614622812f47-43b29ad3d9bmr183404b6e.30.1757109246626;
        Fri, 05 Sep 2025 14:54:06 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:52e:cda3:16cc:72bb? ([2600:8803:e7e4:1d00:52e:cda3:16cc:72bb])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-43836abece4sm1977636b6e.28.2025.09.05.14.54.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Sep 2025 14:54:06 -0700 (PDT)
Message-ID: <e5e76789-c8d9-463c-aa01-f2c6ae718f74@baylibre.com>
Date: Fri, 5 Sep 2025 16:54:05 -0500
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
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <23b80d52-6149-483b-a159-276dd00d12cd@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/5/25 3:58 PM, Daniel Lezcano wrote:
> On 05/09/2025 17:25, David Lechner wrote:
>> On 9/5/25 4:44 AM, Daniel Lezcano wrote:
>>> On 04/09/2025 19:49, David Lechner wrote:
>>>> On 9/4/25 12:40 PM, Daniel Lezcano wrote:
> 
> [ ... ]
> 
>> Taking a step back, what sort of real-world uses cases do you need to support?
>> Or are you just trying to implement everything that the ADC can do? The latter
>> can be a bit risky because you might end making something where you can't do
>> a buffered read and a single channel read at the same time, but later find out
>> you have a real-world application that needs to do this.
>>
>> It looks like it would be possible to implement buffered reads in lots of ways.
>> IIO devices can have more than one buffer per device so we can add more in the
>> future if we need to. So I would just drop the DMA part of the implementation
>> for now and implement the basic triggered buffer using MCR[NSTART] and ECH
>> (End of Chain) interrupt request and just reading data from the ICDR registers.
>>
>> I would wait to have a real-world application that requires DMA to decide the
>> best way to implement that. There are lots of possibilities, like does it need
>> an external trigger or is continuous mode good enough? Does it need to be cyclic
>> (something the IIO subsystem doesn't really support yet) or not. Is exact sample
>> timing important or do we just need a big buffer? These questions we can't
>> really answer without a specific application to use it.
> 
> In the case of this IP, the use cases are in the automotive context. The system running on the APU is supposed to monitor at high rate (or not) the different channels which can be connected to any device the integrator choose to use.
> 
> For this reason, the driver should be able to support the different modes because the integrator of the car computer can decide to monitor the devices connected to the different channels differently.
> 
> Said differently, we need these modes because the capture depends on what the integrator decide to connect to the different channels.
...
> We just know all these use cases exist.

Changing the order here a bit:

> or just read the value at a low rate.

For this, I think reading _raw attributes/in-kernel APIs/INDIO_BUFFER_TRIGGERED
(no DMA) covers these use cases.

> That could be a real high rate sampling, 

For this, devm_iio_dmaengine_buffer_setup() should work with continuous mode
to sample as fast as possible.

In both of the above a sampling_frequency attribute would control the prescalar
of the ADC bus clock to give some control over the hardware sampling rate. There
is no IIO trigger device in this case.

> or triggered with a dedicated global timer on the system 

For this one, we would want a `trigger-sources = <&timer>;` property in the
devicetree to connect the timer trigger to the ADC. This would probably trigger
a DMA transfer if precise timing is important. In this case, it might make
sense to have a buffer/sampling_frequency attribute to control the timer. There
wouldn't need to be a separate IIO trigger device in this case either.

