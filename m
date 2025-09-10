Return-Path: <linux-kernel+bounces-811022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BA028B52308
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 22:54:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E95637A438D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 20:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0AC12FC88C;
	Wed, 10 Sep 2025 20:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Gs1GsYLy"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AADB2D739E
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 20:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757537645; cv=none; b=bFZYIgz0zGgtizdhRCxUNX6yNbApNjC2LEgVJCBtV1YiT/QpEcz6yPaWUE5V66V4fIi1JvMVpc8XCInlJBfpr8bt76dkmRpVuBHzAMqqntTYwbcjExoIB4ZpeVbbwzQkCbTXI/9AptUC05kF70+3CCk6b7zbrN+C5Ga1bgiOMAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757537645; c=relaxed/simple;
	bh=BPaRSaGXkXtKNzV5Y0J5q2TYElCixphj4f8xoDsFC8g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Yha+9i1XOQBLZO8B2QqqElcTaDDVZdwtzCoC8XrzBYBZN2/MI+impsA9ryiEmI3Vqdw+YHr2yqpIVqgxseTP4R/cStif7VHy0V3mnRP9h3CZMeSiO5xqIdCZw0Krfg0uMNCZ91dKUzsFQgX8AXXFOMyHxkPKIDanyjPmtwX9JIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Gs1GsYLy; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3e751508f15so53425f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 13:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757537640; x=1758142440; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JK6XdnnF7e9DVAyJJQMalDeYM4MKvqUs+TYP+auqI10=;
        b=Gs1GsYLyX4kCmYmi5LeMPSzyWKPMCq+8cehGQeB5zBQ5yXrzagnA5sNPHJQT56Wy9W
         52DwTDb+4tZWCQrR5KhsKk9lIi96xbgZP4jpodPNFKArVRVxubact51GUT+DRw8b/HHP
         jnMsOl4zux/Y+ilMb6cx3pkiPtCtkFL5tZjdyDnSjok1L1jbS2Dzb0K1WeZnCYfSigf+
         RYSYSKeNAxZqqLWBQfTXIe2xm80zEEvBU19YzHh99plh0PeUzUI9on08+pp4iEPnX/E6
         gKmDoeEr3pGEgFmaFpX3cFq0sUv7K47HwjoWRV4X+3ib/MUl39RRpc4rNhiTPxvBqVI9
         mtVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757537640; x=1758142440;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JK6XdnnF7e9DVAyJJQMalDeYM4MKvqUs+TYP+auqI10=;
        b=XsvV/6FVLSxnDpIR2AK3vkXs45A6F6iYT8GR91iWKUEtezoaFNaSX5TQPcu+xzILAI
         fzEnzBfQ3pC6g5L9rhJumnKFbTwGcDyJualf6EjYIVbr6XhO1PchiDu0O0s1WtxvItfv
         /3E5JAnlyJ+3vlz+i/tNzGFAmaeoRx+0SEHfmb3WzYWdmoPxLFhfsfxJfr83M2kZHNvb
         MJCUJVW0oyPDnZBV13FkrAW1nyozdQa2fDCSMCvs1cz7AUxeHJ8cfjoz+oShOm8t7bk/
         d5lyeaRhant/s0LtUxyfdX6Miyod0XmHRSMdKvpmEdoqLehp4CbOOQS7gMwXRXzvrQMY
         pNUQ==
X-Forwarded-Encrypted: i=1; AJvYcCVfNInt32ChPMfDDOt6hbbo/uc6CbL48LHtAVXLxo0gYWjYw7g68kr8MPb0EbPvGtMMYa+wGSXQB4sTK6k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCYvi1qf0k4fC19l8QlISkemo9+BypUvYsi+UJOZw+Mot1undB
	2g8VuiTQmLbFzH3Ncnv5NNGN7ilsPL+2HmB5AAu5xT6nlmmKKtDmkgwGZkXBgiphUGA=
X-Gm-Gg: ASbGnctPgPIwmLd2ebLnbsK2cWj75vB266hPj7JF+Nkt3JeoBuAjiJOtGJC6qMRTMzG
	r+ebSCojUlZqV/hf+yz9fPfE+WH374rFxB6l6GFbWWd/1rw+tg6souGk5C3vpgbxSmnPmIrWP0Y
	vcPH9P+b7hLOK69EJAANPdRVs9QDy0mI1dEWdbp+THa0qQJE48KdfZdmRj6HjTz5sSi2XQ6XTIT
	bJDWwy55QZSY4N50d9hZPECCZdg3jzdmz+LC0xBFp6dKQgBZlsk4tUzdsV8za4Bp6HQDoOrG8no
	HjYz7FkVjv+0jxUEWZV6U78YkT2K7G+DaALoXtvU8oxuDteER2CcYM4MIdHTux9jDio/x84KYaS
	LDVCDGtfp8YFFB6KZ7DcdSIvccsYXWGPOV5/xuMS/PIWMlmMRR4UdUzMPt2Eh6mYtYl/XtkuULu
	rdPkWVe9b3yHbQM5tQ2iiWNvU=
X-Google-Smtp-Source: AGHT+IHZPdMhwLR+ThyraP/LawoTGgzxKuQx6x8ArefQTN1S56leBOp7hCKwv1ioGhDyO4toIc0Uiw==
X-Received: by 2002:a05:6000:2f87:b0:3dc:b041:9919 with SMTP id ffacd0b85a97d-3e641d46461mr14526703f8f.11.1757537640267;
        Wed, 10 Sep 2025 13:54:00 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:9717:723a:79cf:4f4a? ([2a05:6e02:1041:c10:9717:723a:79cf:4f4a])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3e7521ca1c1sm8490811f8f.24.2025.09.10.13.53.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Sep 2025 13:53:59 -0700 (PDT)
Message-ID: <63ee2dae-7d9d-4838-9fcc-6a15273fc987@linaro.org>
Date: Wed, 10 Sep 2025 22:53:59 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: AW: AW: [PATCH 1/4] clocksource/drivers/timer-rtl-otto: work
 around dying timers
To: markus.stockhausen@gmx.de, tglx@linutronix.de
Cc: howels@allthatwemight.be, bjorn@mork.no, linux-kernel@vger.kernel.org
References: <20250804080328.2609287-1-markus.stockhausen@gmx.de>
 <20250804080328.2609287-2-markus.stockhausen@gmx.de>
 <af4a09e2-5b3e-4223-a926-4ab33b327416@linaro.org>
 <007901dc223b$feb371a0$fc1a54e0$@gmx.de>
 <38633f6f-c14c-4a74-b372-cdfdab80619e@linaro.org>
 <020f01dc227f$03e40b60$0bac2220$@gmx.de>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <020f01dc227f$03e40b60$0bac2220$@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/09/2025 20:16, markus.stockhausen@gmx.de wrote:
>> Von: Daniel Lezcano <daniel.lezcano@linaro.org>
>> Gesendet: Mittwoch, 10. September 2025 18:39
>>
>>> What I tried:
>>>
>>> 1. Read out the current (remaining) timer value: In the error cases
>>> this can give any value between 1 (=320ns) and 15 (=4800ns).
>>>
>>> 2. Check if IRQ flag is already set and IRQ might trigger next. This was
>>> never the case.
>>
>> It would have been interesting to check if we are in the time bug range
>> to wait with a delay (5us), check the IRQ flag as the current timer
>> should have expired, then set the counter and recheck the IRQ flag.
> 
> It's been 2 months that I dived deep into this case. Finding a
> reproducer, adding lightweight logging and try&error a solution
> was really hard. In the end I was happy to have a fix that was
> intensively tested.

I understand. No worries I applied the series, it is in the compilation 
batch.

> For some notes see
> https://github.com/openwrt/openwrt/pull/19468#issuecomment-3095570297
> 
>  From what I remember:
> 
> - I started on a multithreading SoC and went over to a single
> core SoC to reduce side effects during analysis.
> 
> - The timer never died when it was reprogrammed from
> an interrupt of a just finished timer. The reason was always
> a reprogramming from outside the interrupt->reprogram
> call sequence.
> 
> - Reprogramming always worked fine. A timer with <5us left, was
> restarted with a timer >5us. The new timer started to count.
> No interrupt flag seemed to be magically toggled during this
> process. There was no active IRQ notification directly after the
> reprogramming. That was how I expected it.
> 
> - But in rare cases the new timer did not trigger the subsequent
> interrupt. I was totally confused that the future interrupt of
> a newly started timer did not work.
> 
> Graphically:
> 
> - timer run ---+-------------------->|
>                 | issue stop & start
>                 | timer run ------------------>|
>                                                | no IRQ here
> 
> Conclusion was for me: If we "kill" a running timer and restart
> it and it will not fire an interrupt after the newly set time,
> then something must be somehow broken. The ending timer and
> the stop/start sequence (that consists of two register writes)
> have some interference. Whatever it might be.

Mmh, I think I misunderstood initially the problem. Thanks for clarifying.



-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

