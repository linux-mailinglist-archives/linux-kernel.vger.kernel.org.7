Return-Path: <linux-kernel+bounces-739345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5344B0C508
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 15:20:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87308189D080
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 13:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 528082D8768;
	Mon, 21 Jul 2025 13:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vFGGbJfr"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C57E72D63FA
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 13:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753104022; cv=none; b=ca2JQGJnmKeCzs1VpOhYqhOrG7p2eXaTukN4kvyanxbQRrIm5lnS1BAXz0TrGaSxckM7nlBiK9sJx74r2mYsgXr9BJbKxIJ0MbyJ7rg/KTieiKp1CG40ZbkYD6fkNUYQzjbnwk/Zu8oR4zmysnfNH/ZGz1ib9Jk1xZ3Fg3cQCZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753104022; c=relaxed/simple;
	bh=vFYsACjf+wWImBMqFRsLGjZ2g5T9qvVJqCKa1lGxxgE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OtvBoTXDzdwmcluxvhC7kFtQO5oUnzrw90e3TzVWDEX7z2acN4V8cCejJd3yxi25Zdss5HHCtbB7L/ipYhf2BOGlfnzYYr6CMuG2rHkVosuHrQqd1sGt+KK4Y9JY6RFfKMqQosLOKXifBSPhQHMcriMVGrpYnkAhHDQcxzLeYr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vFGGbJfr; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3a4fb9c2436so2471591f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 06:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753104017; x=1753708817; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vrn9rE6UkF/v98BJ3Qu5cq8UrY7vJ2riZbgUi0l0lcs=;
        b=vFGGbJfr1jf4m2Un99pCCWR2wFDwIJbrMohaPirrvrr1Evc+kstuO6fhRd+mDI5P8G
         x9BM5namDDZeDUnlY+yMiPJpFwqyM9bX1mfnZ4h/8OVG/ueeaGByHQZZEiiyo2nYXJNQ
         LCwgSn/LLBu3vcSkGRwmxTYKu+/nYL5XMYUImq4m378UODgnAPY6tfSGAlzpZBYP/hCv
         ++OPnQY+BHWuhwvZiBsfRobVJ1sqmqjyzC0gP0Ttc5iTtPmLN57nuNtT3bewMXAKdqdQ
         GhcDPhm8eovcSoRYu7101W2/Fcyxyg32kjAvsqm7QRGAJItNqZXjSgaRdUdsgypVeuxF
         8aVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753104017; x=1753708817;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vrn9rE6UkF/v98BJ3Qu5cq8UrY7vJ2riZbgUi0l0lcs=;
        b=OA9+dZfwIc0OmhNLhPkWhm4r9fNHI5E0N62SWzKoWYj6n707/XeXHSUowWaX0tlp6R
         xlTrPAAhOAqQ8nofkaIrJHO11FMTfdio0YUG1eAGVWR3WMahRJXbu9mkJnFVx0VLOXLe
         KDtHHS/yBYVypn0EeN1bVjGfJyO583CZtpGyGIPcZNF8P06fL5TnDRgnwvLZYQkdy7RS
         cONFD7C0/V0OOOJRFKtxQvuQPdEsAYdDEaR7zppUXtkBm/hLe1yNKWhmUfPfUFcOkRC7
         Rb7MzwGK7KxN/f4aHRN+b5Er1ESteVzgyI8CJ2r7MrNsoUf7hqUGTohyMdeVh1P8FQQT
         Nk9w==
X-Forwarded-Encrypted: i=1; AJvYcCW1gwVA/LNM/Dapus6XY3/zohlaQGx/HU+SdblkI+56o1rzfm/PV/XUE27QE9EmXZYqo6QKArHXR4yqY64=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMx7uTUDpaDBVZLqfzoz2ndujhDA7GfQkIwdriIDKTbVHKIPYP
	d9Xm/KZZi81ucL9hFFbjEyWHn0aiNdDIlhG9KugzG6hSbNyBTpa+dx0u5UVu9d/k+Ms=
X-Gm-Gg: ASbGncvagG5fMR2zg0e9iyAbWrQ8WptDWeAmwm8kn6yiR5mH0WUcHaYkzSAk0QwBqX8
	sRzbYw9YxFe48TcGbQXpDXRV2kDJZYN8zOYavvq7ii/YZZtGl6pXjsUvMUbJ1+GRA+zodMsBOvq
	GMpJLhgjfmVw5qkL1dKeDUcMrnrEJ/QN/XKOzR0d4/chycUHLqdkg4gTI60vM2g08B5jGHELCpm
	6gAxtrKozMT8oNPb8Gr/xqqIVSa2qFYFdUegP5Z1WTc2WjvfdsMnyfJ4+4S0AoAtXw3aRvqL3IF
	wcbjyRnbQ7mbFf+Evi5oqtUIXHFUOw04aFuqId4w1NQ2AJEH3qembFZ4HQxFbpwG2jQYv08o6UZ
	8LmpNr8PNnSlPiISq6+R5YWg0+BQYXzP2AakqQA==
X-Google-Smtp-Source: AGHT+IH+iH70+HX8sNgyQja7zJIW/pG4ctsn+z4ohiQa3kbUyjxssWONPs/1WpQT4zINE1WNbLE7Uw==
X-Received: by 2002:a05:6000:992:b0:3a4:f663:acb9 with SMTP id ffacd0b85a97d-3b61b0ec0dbmr9587918f8f.9.1753104016864;
        Mon, 21 Jul 2025 06:20:16 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b75baa7072sm3489845f8f.2.2025.07.21.06.20.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Jul 2025 06:20:16 -0700 (PDT)
Message-ID: <0c53164a-306a-4cb7-9085-bba8985c32e7@linaro.org>
Date: Mon, 21 Jul 2025 14:20:15 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] perf: arm_spe: Disable buffer before writing to
 PMBPTR_EL1 or PMBSR_EL1
To: Leo Yan <leo.yan@arm.com>, Alexandru Elisei <alexandru.elisei@arm.com>
Cc: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Anshuman Khandual <Anshuman.Khandual@arm.com>,
 Rob Herring <Rob.Herring@arm.com>, Suzuki Poulose <Suzuki.Poulose@arm.com>,
 Robin Murphy <Robin.Murphy@arm.com>, linux-arm-kernel@lists.infradead.org,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250701-james-spe-vm-interface-v1-0-52a2cd223d00@linaro.org>
 <20250701-james-spe-vm-interface-v1-2-52a2cd223d00@linaro.org>
 <20250704155016.GI1039028@e132581.arm.com>
 <b77f12e7-ea3f-4c57-9706-ff8e32721cc8@linaro.org>
 <20250707153710.GB2182465@e132581.arm.com> <aG4_uYJgpMXo3QHQ@raptor>
 <20250714085849.GC1093654@e132581.arm.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20250714085849.GC1093654@e132581.arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 14/07/2025 9:58 am, Leo Yan wrote:
> Hi Alexandru,
> 
> On Wed, Jul 09, 2025 at 11:08:57AM +0100, Alexandru Elisei wrote:
> 
> [...]
> 
>>>>>>    	case SPE_PMU_BUF_FAULT_ACT_OK:
>>>>>>    		/*
>>>>>> @@ -679,18 +692,14 @@ static irqreturn_t arm_spe_pmu_irq_handler(int irq, void *dev)
>>>>>>    		 * PMBPTR might be misaligned, but we'll burn that bridge
>>>>>>    		 * when we get to it.
>>>>>>    		 */
>>>>>> -		if (!(handle->aux_flags & PERF_AUX_FLAG_TRUNCATED)) {
>>>>>> +		if (!(handle->aux_flags & PERF_AUX_FLAG_TRUNCATED))
>>>>>>    			arm_spe_perf_aux_output_begin(handle, event);
>>>>>> -			isb();
>>>>>
>>>>> I am a bit suspecious we can remove this isb().
>>>>>
>>>>> As a reference to the software usage PKLXF in Arm ARM (DDI 0487 L.a),
>>>>> after enable TRBE trace unit, an ISB is mandatory. Maybe check a bit
>>>>> for this?
>>>>
>>>> Wasn't this isb() to separate the programming of the registers with the
>>>> status register clear at the end of this function to enable profiling?
>>>
>>> Enabling profiling buffer followed an isb() is not only for separating
>>> other register programming.
>>>
>>> As described in section D17.9, Synchronization and Statistical Profiling
>>> in Arm ARM:
>>>
>>>    "A Context Synchronization event guarantees that a direct write to a
>>>    System register made by the PE in program order before the Context
>>>    synchronization event are observable by indirect reads and indirect
>>>    writes of the same System register made by a profiling operation
>>>    relating to a sampled operation in program order after the Context
>>>    synchronization event."
>>>
>>> My understanding is: after the ARM SPE profiling is enabled, the
>>> followed ISB is a Synchronization to make sure the system register
>>> values are observed by SPE. And we cannot rely on ERET, especially if
>>> we are tracing the kernel mode.
>>
>> Thought about this some more.
>>
>> Before:
>>
>> arm_spe_pmu_buf_get_fault_act:
>>    <drain buffer>
>>    ISB
>> arm_spe_perf_aux_output_begin:
>>    PMBLIMITR_EL1.E = 1
>> ISB
>> PMBSR_EL1.S = 0
>> ERET
>>
>> Now:
>>
>> PMBLIMITR_EL1 = 0
>> ISB
>>
>> PMBSR_EL1.S = 0
>> arm_spe_perf_aux_output_begin:
>>    ISB
>>    PMBLIMITR_EL1.E = 1
>> ERET
>>
>> I don't see much of a difference between the two sequences - the point after
>> which we can be sure that profiling is enabled remains the ERET from the
>> exception return.  The only difference is that, before this change, the ERET
>> synchronized clearing the PMBSR_EL1.S bit, now it synchronizes setting the
>> PMBLIMITR_EL1.E bit.
>>
>> Thoughts?
> 
> To make the discussion easier, I'll focus on the trace enabling flow
> in this reply.
> 
> My understanding of a sane flow would be:
> 
>    arm_spe_pmu_irq_handler() {
>      arm_spe_perf_aux_output_begin() {
>            SYS_PMBPTR_EL1 = base;
> 
>            ISB // Synchronization between SPE register setting and
>                // enabling profiling buffer.
>            PMBLIMITR_EL1.E = 1;
>      }
>      ISB // Context synchronization event to ensure visibility to SPE
>    }
> 
>    ... start trace ... (Bottom half, e.g., softirq, etc)
> 
>    ERET
> 
> In the current code, arm_spe_perf_aux_output_begin() is followed by an
> ISB, which serves as a context synchronization event to ensure
> visibility to the SPE. After that, it ensures that the trace unit will
> function correctly.
> 

But I think Alex's point is that in the existing code the thing that 
finally enables trace (PMBSR_EL1.S = 0) isn't followed by an isb(), only 
an ERET. So the new flow isn't any different in that regard.

> I understand that the Software Usage PKLXF recommends using an ERET as
> the synchronization point. However, between enabling the profiling
> buffer and the ERET, the kernel might execute other operations (e.g.,
> softirqs, tasklets, etc.).

Isn't preemption disabled? Surely that's not possible. Even if something 
did run it wouldn't be anything that touches the SPE registers, and 
we're sure there's an isb() between setting up the buffer and the final 
PMBLIMITR_EL1.E = 1

> 
> Therefore, it seems to me that using ERET as the synchronization point
> may be too late. This is why I think we should keep an ISB after
> arm_spe_perf_aux_output_begin().
> 
> Thanks,
> Leo

Wouldn't that make the ERET too late even in the current code then? But 
I think we're agreeing there's no issue there?

James


