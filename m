Return-Path: <linux-kernel+bounces-769000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE50BB268EB
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 16:17:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D21EA27BFE
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 14:08:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDCB8134AC;
	Thu, 14 Aug 2025 14:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gqgctjnJ"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 364501F2C45
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 14:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755180165; cv=none; b=iVPx9aMwlhhaHWLRWH2vx5pQp59wNesFort2glB4KUeBWlappqufGAbtXjqeNNwpPILVrf3XmXM4uXwIIG2+k/UFG+/pcTJOns4sTjmSWv3QlPagREfgAAa9DGQK3GllgFtj5E48cDUrvMnIyWzLkkTgi+gDFMhvcIdngZtj60A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755180165; c=relaxed/simple;
	bh=vD6N19vulg3nT1U+XDDs5iFEvbwhlOucwBKUyBA3INc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T7Vcv5rSILRImw/cHJoHw5jpNH2stGYlEnEcKblpx4rkW7IO6r9A4KJzbaDW2sN5gNWkc9dFFlzjzDWx37w2owLhrCfQ92EvxXQtCvosyHrmTDQB3/OGXs5t4W8gRpDnBf1llvKsQz4ic0KBFF5LycIVmv+JFtU7xZNj2kZoVso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gqgctjnJ; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3b9d41c1963so509016f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 07:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755180161; x=1755784961; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=USeovI1td615+m2hPQWxMlhtpdb04/bJ2k3zHNEipJk=;
        b=gqgctjnJCGzhl1czEXqJS54vIfPyqjCUl0pj2GywqdDP9jBxdphgaww62BXBo5VYJe
         s+2Ugt0BD8ilg7MWS8PdNRWblewwgR9qpaj6uf7rko5jyBvrqDy1Z9WtkXzunBeiMugf
         aAPfzKlRtjkT96zXaL0W6TYMevGWktdeVzuXUVoQB11zMKVXXSyzfaeEh+IPjJGIWpn6
         tNr7Bku7DL3KQYiv4Wafz+IRtzMvuGUDS2Z9m5LZD2FgFI/LMUkgXdJz997bbftXDV6y
         hZUZr9si4IJ3TZuJhgL/o9RdotV+IGzewmnThwHTWzFdKt2M3SWtHy82ptwPXo2hwump
         eeKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755180161; x=1755784961;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=USeovI1td615+m2hPQWxMlhtpdb04/bJ2k3zHNEipJk=;
        b=dssjNkCq2tWZWcWy3nnr2DpCKNXC3vyR1i+bsEegxSlCv1SjK/P+aVTrPxNPy3FYRB
         4GtqKWM8jwIW/gU3UeNen75bB6jQVdq36hrlNepATWAZRvBLiOyWx6852iZRjOx14HSB
         Eok8krqXt+djI7TCuiz3NK+23emXNfAVXKuggLig3ALTgVmaBKnZyf9On94NVcgVB9Sw
         dydTeaCCvjGEtUURRhATtYkGWVIEn/+ki9uy+XyAJNGOLDglpPjBBZVuJ2c9P/oiU9QX
         nkghsYrpCTIAa/6xJb61pphTugR0FIylG/UG2uu/YWvppk6acaZIyenrq7AAJO5C8p8l
         DACg==
X-Gm-Message-State: AOJu0YycbmrrdloyPE/h5ph0fCY0itYWa2qLmwmFZzzyyAhITGOgW83i
	qi4rquZRWmKmyRcsZIPabbp3WKS2dDIA0DlBH6EHRl/MdpmUBszkRdmUu9n0AtreYCQ=
X-Gm-Gg: ASbGncs9XaTAAnPLuqwLQLDticVM3AqN0tThtDbueg5cGg3qh6xibbgB6VU0rjYnQEu
	FApdg7a8xT+mMyiLBrB7iXuj13n+NUYvJPxSVBX7sPKRDAPVV5xAxtLh+SPSgs7i28AfIK8EXdU
	CXuWFPdtCQuaWv5F9yPq9xhHzl6s9hP2QvdXX54uhlrB9isIbRTIUJS9cz41B2yY+nwcwzSB3pO
	28V2pq5wWgWKx+O5E07gIwclgiSb5tEbugwd8Ng3BI5aFZaePFEPH8raRi2OYGpDdpoiegMr4Tq
	hHhY+nBsG2oe66jJwmNVHsGcdzz7vlgQ/h/sDHH6TVFLM/0tX4BKY3tPaLAFHuWOsSe51MFB0sZ
	DOcVf54VDQVfzEkmDQjw3D2kLLI/b7vHJZ4o1DqHO8zfHrDp68nSUDlr5SJOEoA==
X-Google-Smtp-Source: AGHT+IERUJslQgwOH4b97ptMQL4N4tOcjICMqR7HsbySu7FxgbLzrjkgYS25JdaV9G4A+kXiHJj3RQ==
X-Received: by 2002:a05:6000:2503:b0:3a6:d349:1b52 with SMTP id ffacd0b85a97d-3b9edf1cf68mr2732676f8f.21.1755180161393;
        Thu, 14 Aug 2025 07:02:41 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3b911469bffsm9885157f8f.36.2025.08.14.07.02.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Aug 2025 07:02:40 -0700 (PDT)
Message-ID: <52887b08-d5bc-4710-af7c-a70fab5e7f81@linaro.org>
Date: Thu, 14 Aug 2025 16:02:40 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] clocksource/drivers/arm_arch_timer: Add standalone
 MMIO driver
To: Marc Zyngier <maz@kernel.org>, Steven Price <steven.price@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Hanjun Guo
 <guohanjun@huawei.com>, Sudeep Holla <sudeep.holla@arm.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Thomas Gleixner
 <tglx@linutronix.de>, Mark Rutland <mark.rutland@arm.com>
References: <20250807160243.1970533-1-maz@kernel.org>
 <20250807160243.1970533-3-maz@kernel.org>
 <8e58b01b-772d-4ca7-a681-34f10baa07e6@arm.com> <86ldnmdvpl.wl-maz@kernel.org>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <86ldnmdvpl.wl-maz@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 14/08/2025 12:49, Marc Zyngier wrote:
> On Thu, 14 Aug 2025 11:13:47 +0100,
> Steven Price <steven.price@arm.com> wrote:
>>
>> On 07/08/2025 17:02, Marc Zyngier wrote:
>>> Add a new driver for the MMIO side of the ARM architected timer.
>>> Most of it has been lifted from the existing arch timer code,
>>> massaged, and finally rewritten.
>>>
>>> It supports both DT and ACPI as firmware descriptions.
>>>
>>> Signed-off-by: Marc Zyngier <maz@kernel.org>
>>> ---
>>>   MAINTAINERS                               |   1 +
>>>   drivers/clocksource/arm_arch_timer_mmio.c | 420 ++++++++++++++++++++++
>>>   2 files changed, 421 insertions(+)
>>>   create mode 100644 drivers/clocksource/arm_arch_timer_mmio.c
>>>
>> [...]
>>> +static void arch_timer_mmio_setup(struct arch_timer *at, int irq)
>>> +{
>>> +	at->evt = (struct clock_event_device) {
>>> +		.features		   = (CLOCK_EVT_FEAT_ONESHOT |
>>> +					      CLOCK_EVT_FEAT_DYNIRQ),
>>> +		.name			   = "arch_mem_timer",
>>> +		.rating			   = 400,
>>> +		.cpumask		   = cpu_possible_mask,
>>> +		.irq 			   = irq,
>>> +		.set_next_event		   = arch_timer_mmio_set_next_event,
>>> +		.set_state_oneshot_stopped = arch_timer_mmio_shutdown,
>>> +		.set_state_shutdown	   = arch_timer_mmio_shutdown,
>>> +	};
>>> +
>>> +	at->evt.set_state_shutdown(&at->evt);
>>> +
>>> +	clockevents_config_and_register(&at->evt, at->rate, 0xf, CLOCKSOURCE_MASK(56));
>>
>> This doesn't work on 32 bit - clockevents_config_and_register()'s final
>> argument is an unsigned long, and a 56 bit mask doesn't fit. This
>> triggers a compiler warning:
> 
> Already reported, see 20250814111657.7debc9f1@canb.auug.org.au.
> 
>> Possible this should really be min(CLOCKSOURCE_MASK(56), ULONG_MAX)? But
>> I'm not familiar enough with this code. Most likely it's dead code on a
>> 32 bit platform.
> 
> No, this definitely exists on 32bit crap, since it has been part of
> the architecture from the ARMv7+VE days.
> 
> I think this is more of an impedance mismatch between the
> CLOCKSOURCE_MASK() helper and the clockevents_config_and_register(),
> and a (unsigned long) cast would do the trick.
> 
> But it also means that the per-cpu timer also gets truncated the same
> way, and that has interesting impacts on how often the timer is
> reprogrammed.
> 
> Daniel, do you want a patch on top or a new series?

A new series please

Thanks


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

