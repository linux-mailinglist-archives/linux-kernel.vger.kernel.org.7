Return-Path: <linux-kernel+bounces-810687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ACFEB51DEA
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 18:39:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7D771734B3
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 16:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8922627145C;
	Wed, 10 Sep 2025 16:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FKu2Kdh5"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04233A921
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 16:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757522347; cv=none; b=KwYOMY+PUJxQiXmZ/a85/IICL/+jNn4BNHbJsmfBlUGjlNaEABxVGJ4+o5Yk37+lacXCLK1o96Lp1BwpaqGf68Z+tZiss+HIXpvAzyAORTnb3+DcLWpS3SsF+5soNAXRb6yU5j4uK+43HYLxKP3ioTSScpf7Tviaoxo6w4e9wbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757522347; c=relaxed/simple;
	bh=mPnf6arEFrndxVcCtW5AdVgYCj6hOqhS200GvmvfH2k=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=BUq2S3z5HamwZv0QWLCHuxx50d5ADYEMxkM2zT/+STaimbBabok6QT7L7Xs58+GN8eNErScXZW94V2T260hzucC9XFj+9gg49g7HwwREeCrYN5H+cEu+UGI+jcT5xcCZ/68+dw06hUknSSTOIVmI83lRQ4P7dV/CI81rjvKjNpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FKu2Kdh5; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3e7512c8669so1567957f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 09:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757522344; x=1758127144; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ryDj+aX0VCnQnicL1qTRj29wb3PwCnn+l2BRfDaXTqs=;
        b=FKu2Kdh5yskMIjVQ3dmdSUy9tGv5npHL2DnQcilrm9YfCBrXbaketJV/5oR3N358NQ
         sayGfDzNMwusei8D9zjQtG4T8DxtH6MTF50ouY7if0/P4ZYrLB/NuT9z7B9cpNaCNMYG
         IkYXB4AMABmZKSVVPL5EGxr7xQfq5owNuaflEbtHeAEPA5cIqodmCi/jIO3eUTH27BR5
         R7r3KSQ3uJc+yIGHhwC1ao2UJvkq7vRflnk0fljUl/QHyzzOQSK78k7wR22d+IBKRPJJ
         diF48XXpIeCpO6ce/HtLBOSz/dG2x7p313kRSbAhN8GlxehCecY6Fnvk8dSNe5wm0v0Q
         g24A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757522344; x=1758127144;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ryDj+aX0VCnQnicL1qTRj29wb3PwCnn+l2BRfDaXTqs=;
        b=XfL82nP0iBPbC71QK4ASynGEaRp383xJNKa0Tr6utBU/wDc5fck31jA9+/za6ueXI0
         972kxZ+vKEZ8+SAdPAs9xUpDLaoViwtMFFrAi4EwAQkaeU/EZsPpTbOGnEt05ucekQWI
         SyqM63N+fMUKJsEfVXp3OnrI8gUUFyEphmen92vhQDSL2+PP72gWeHXy/uVOr5S/hmH0
         O52C34BjhWoiAZRlugNQRQlLePIkcxulFhhROwvHDRxj1pv8dcVjcTwq1+NwnCeF1S1k
         2Tt7U6Jk9hII5cXnRp0+kur+miHDvvmz05sS2H4U5q2i2XlCX163S46fNj4C7JqVRaux
         Lijw==
X-Forwarded-Encrypted: i=1; AJvYcCU9qxeetPQ5tPi3ZRDCDzbb7WHW3ZX2tyHdNkVowA9LvXptgJetPzYs/V5bFz6WIG2GyVhcfTMtcVAe2Ik=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdgDNS9RUA+ynAsdMDVTxQQe8Ej6tQNlKaymd10LzWnwMGU0rj
	FxxfJOsW3UgaLy39bSjQ+mvQaypvhvDYLPUI/QGIEnAkJQz/XewUu0vWJvFzKpMSO60=
X-Gm-Gg: ASbGnctQ444PIHmzuc75mpjHSTp+isBKC8WNiBsfO3Y49PCVmdkfKKO3+k+LYqWeUEk
	73WgdSdEupMj6uIl0R8BlcOv0YoJyIYbM3TluMuIGvl1u69snF7AUfbwjCWStYKZhNUXdz9yUF1
	dDr/xvD1VsdWosfcu+l8LngnYKJ9z9VHmOvig5Xvs2WBPIe0JCfQAyYUV4rOIJfD6C6jY768t6H
	dT8scp2+Bb1kSi17l9N7nfD/CIAKxLSSwLf/Hm4Tu0XUsWU1YRTvgAVeWt/nFWgPk4wxmFp1wxD
	GHY6+JXOOUX/KeJU1H/UL4nq0vL7nkcsksL0Jw/d7gOyP1lhE89f9KBRL8hD1UeaoPfYKUnIRDr
	08RNLtAZEWqnC6AfUu3I/nP0WoDTJOZUrQa0Lh2l8aAlt/wyPfXFO2LGLGGVeIericLvxXAAm/H
	FtWg==
X-Google-Smtp-Source: AGHT+IHk1zLAuAf7An+/YbdqQ1T40qjXM1fGoPkTH3xkJdlR15JGXwSYcrqjL9tKA6p+wu8EZoZZxQ==
X-Received: by 2002:a05:6000:1acf:b0:3da:37de:a38e with SMTP id ffacd0b85a97d-3e643c19857mr14259710f8f.54.1757522344099;
        Wed, 10 Sep 2025 09:39:04 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:9717:723a:79cf:4f4a? ([2a05:6e02:1041:c10:9717:723a:79cf:4f4a])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-45df821f714sm34042845e9.16.2025.09.10.09.39.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Sep 2025 09:39:03 -0700 (PDT)
Message-ID: <38633f6f-c14c-4a74-b372-cdfdab80619e@linaro.org>
Date: Wed, 10 Sep 2025 18:39:02 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: AW: [PATCH 1/4] clocksource/drivers/timer-rtl-otto: work around
 dying timers
To: markus.stockhausen@gmx.de, tglx@linutronix.de,
 linux-kernel@vger.kernel.org, howels@allthatwemight.be, bjorn@mork.no
References: <20250804080328.2609287-1-markus.stockhausen@gmx.de>
 <20250804080328.2609287-2-markus.stockhausen@gmx.de>
 <af4a09e2-5b3e-4223-a926-4ab33b327416@linaro.org>
 <007901dc223b$feb371a0$fc1a54e0$@gmx.de>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <007901dc223b$feb371a0$fc1a54e0$@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/09/2025 12:16, markus.stockhausen@gmx.de wrote:
>> Von: Daniel Lezcano <daniel.lezcano@linaro.org>
>> Gesendet: Mittwoch, 10. September 2025 11:03
>>
>> On 04/08/2025 10:03, Markus Stockhausen wrote:
>>> The OpenWrt distribution has switched from kernel longterm 6.6 to
>>> 6.12. Reports show that devices with the Realtek Otto switch platform
>>> die during operation and are rebooted by the watchdog. Sorting out
>>> other possible reasons the Otto timer is to blame. The platform
>>> currently consists of 4 targets with different hardware revisions.
>>> It is not 100% clear which devices and revisions are affected.
>>>
>>> Analysis shows:
>>>
>>> A more aggressive sched/deadline handling leads to more timer starts
>>> with small intervals. This increases the bug chances. See
>>> https://marc.info/?l=linux-kernel&m=175276556023276&w=2
>>>
>>> Focusing on the real issue a hardware limitation on some devices was
>>> found. There is a minimal chance that a timer ends without firing an
>>> interrupt if it is reprogrammed within the 5us before its expiration
>>> time.
>>
>> Is it possible the timer IRQ flag is reset when setting the new counter
>> value ?
>>
>> While in the code path with the interrupt disabled, the timer expires in
>> these 5us, the IRQ flag is raised, then the driver sets a new value and
>> this flag is reset automatically, thus losing the current timer expiration ?
> 
> Something like this ...
> 
> During my analysis I tried a lot of things to identify the situation that
> leads to this error. Especially just before the reprogramming command
> 
> static inline void rttm_enable_timer(void __iomem *base, u32 mode, u32 divisor)
> {
>    iowrite32(RTTM_CTRL_ENABLE | mode | divisor, base + RTTM_CTRL);
> }
> 
> What I tried:
> 
> 1. Read out the current (remaining) timer value: In the error cases
> this can give any value between 1 (=320ns) and 15 (=4800ns).
> 
> 2. Check if IRQ flag is already set and IRQ might trigger next. This was
> never the case.

It would have been interesting to check if we are in the time bug range 
to wait with a delay (5us), check the IRQ flag as the current timer 
should have expired, then set the counter and recheck the IRQ flag.


> 3. Reorder reprogramming sequence (as far as possible). Only the
> double reprogramming helped here.
> 
> So nothing we can do to actively identify and work around the buggy
> situation. There is some hardware limitation between expiring timers
> and reprgramming. Due to missing erratum the current bugfix is the
> only (and best) solution I have.
> 
> Markus
> 


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

