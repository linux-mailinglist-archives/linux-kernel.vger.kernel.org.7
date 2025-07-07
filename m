Return-Path: <linux-kernel+bounces-719772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 523F5AFB26D
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 13:40:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93C193B9486
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 11:39:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85733299A9C;
	Mon,  7 Jul 2025 11:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AjecRlxk"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30CC82877D4
	for <linux-kernel@vger.kernel.org>; Mon,  7 Jul 2025 11:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751888402; cv=none; b=R8WDhA0JqKUCG4JlVm2ACdDp6iq02B7SD9O9wUr3Wf1DsVrlB8zRTc5YapFsDP5WFxHfRuozVgIxqFHBUuISDlGjbaNxzBxqA7/ARYS+1wirifqMG6mQI6n08nxRubNoNcdqi/tdpxPkip0zj1fjKvMcdHDlYpD9zK2r8PAemyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751888402; c=relaxed/simple;
	bh=feYWE7Jisq/VyH466HOj3sDaALjgny/+B4AiiKp/mZU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eulVk6yqX2hhecgF5K+2cmrRPsBjzcIgLCx5sf50X7WFMagPTJDy0DtIvOrntyE3o0GawYMaO6t6X62VYvKwfC98hC7tfmg8OuXruafz2fKT+3DEJxCEeP/FrZ46aWJ1d2DxXzH5HJ+BmBXAcMZpPMu1AWmum2ryjcpvGSwYEzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AjecRlxk; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3a57ae5cb17so1849338f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jul 2025 04:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1751888398; x=1752493198; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tuqC9beYeXQDyom1+KuHCuf6wqm7fyMn+vwlhFtjQHU=;
        b=AjecRlxkVFPddaGVkUR5QwlPlNFevwdFLUGwADxxTh8wT2Kw95fMyIK8YO4/PFRzrz
         bTn5YNbjLw+rZLs79KQZF8JBt3kgdoeP2SYUdKkL1OnAgkiuhPOzfjNusI0ZnCJAwjfw
         XuEjjyATnkveBmHKeT2CJ1/Jf/PIrTJaIzBqZwmtqgVrsGgFI2D9m7ZRVlDyM1rFNp6N
         QZlY+EN8kpRZlOjjnBDC14VecK3rhONvMmHamLopca87B8QQKG+yXMODEQ9RIkx9nPcq
         aO4+HQ/EsoSN/8kL8BFM7CllmoOTBQJO+JJYaaLDeOEaqYYbrp5V5qTbmFCJr04z+anM
         2r+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751888398; x=1752493198;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tuqC9beYeXQDyom1+KuHCuf6wqm7fyMn+vwlhFtjQHU=;
        b=sY+sUGziJBt1hDSg4SLk6dEN266qRblTlMIWnQsnQa+yWbJIrblBt3EmD4WKWg1/aQ
         aA8CJUil/tvJ6p9glEqSW2r8zMtq7iKNGwn7cmpNnvup2msuSCYp1vjwH5TJ5ky96QD5
         F21DFBGrWrjn4fE+U4lllpXm/UbzhZAGhh+rkCXTHqKOyZIysjNw1+aZg+ewLCS/BES7
         kCmPj4KcXcheVSLcEkM1WctZrpuquXvXzEOXZzCPYrTc1uK6i9TbfEMd+03cWkFkrhs2
         zg/oFKQon2jQ08IFZKR1PbE9PvdsVnyM7TU+XM6lEL6s2ljeLf+rM9iQF2ttaBSa0rJA
         gi+g==
X-Forwarded-Encrypted: i=1; AJvYcCXZ9PulYImr9TQMUQ0M75c43rDI5QNkaYauRbVBOLTITJWlAlyywtqN4yBo0AXA6FRuhrJmV9iPY+gaCqk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4n4A+XOy/0slQJ8C+1x3K6Z0dMuJ/Ohf6SIGVmmdHGctOMKTh
	iDxeXtZTU20oiVocrrqFAGgpljoX7yf20YEwgLxAk8ow8X4xlk4Sp0/9HV4h7TQcoyk=
X-Gm-Gg: ASbGncsOaPM5u/QAMfq9zPqOrQIBg/jcuoI+P/lnGoKMJj9bMX/UPqCdJNGWbs7wJWd
	QP0ayJ1Q99jpVVJiNge4xPSjLd1iEIHTersvrQsLJ0eGnI/EiYWUFc+2pyNcYGuOzI/Y7nl0xcc
	GMJ4qDerxMjZDawEAjC1J51xYMfopqFj4IL1DkAdX9v9wFxvhwNU8QFiShVn0H7qE5gBoTbfuS9
	KicKPOnrWiXqCbPLuro/ZK/x/kZzzpug+1l61GVAchfYxe+HM4WjaOtVeQIvDpdKSeACT24M/Ed
	+DsPR3HeVTfeJJi0Zs7ZMwfZpiXBoaia+BO3DDnRP0U7fsDLYzk2BtUXxakAbWBiSkU=
X-Google-Smtp-Source: AGHT+IGDItNt/gQIylGSzRr2n2QM8HyI4XMr7tCVaXbrsZo7Z/t7OtW5bunomLUqBKEeZpRqJk5pSA==
X-Received: by 2002:a05:6000:208a:b0:3a5:2698:f65d with SMTP id ffacd0b85a97d-3b4964dedf7mr8422836f8f.27.1751888398358;
        Mon, 07 Jul 2025 04:39:58 -0700 (PDT)
Received: from [192.168.1.3] ([37.18.136.128])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454b16865c2sm108604675e9.19.2025.07.07.04.39.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Jul 2025 04:39:57 -0700 (PDT)
Message-ID: <b77f12e7-ea3f-4c57-9706-ff8e32721cc8@linaro.org>
Date: Mon, 7 Jul 2025 12:39:57 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] perf: arm_spe: Disable buffer before writing to
 PMBPTR_EL1 or PMBSR_EL1
To: Leo Yan <leo.yan@arm.com>
Cc: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Alexandru Elisei <Alexandru.Elisei@arm.com>,
 Anshuman Khandual <Anshuman.Khandual@arm.com>,
 Rob Herring <Rob.Herring@arm.com>, Suzuki Poulose <Suzuki.Poulose@arm.com>,
 Robin Murphy <Robin.Murphy@arm.com>, linux-arm-kernel@lists.infradead.org,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250701-james-spe-vm-interface-v1-0-52a2cd223d00@linaro.org>
 <20250701-james-spe-vm-interface-v1-2-52a2cd223d00@linaro.org>
 <20250704155016.GI1039028@e132581.arm.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20250704155016.GI1039028@e132581.arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 04/07/2025 4:50 pm, Leo Yan wrote:
> On Tue, Jul 01, 2025 at 04:31:58PM +0100, James Clark wrote:
> 
> [...]
> 
>> @@ -661,16 +666,24 @@ static irqreturn_t arm_spe_pmu_irq_handler(int irq, void *dev)
>>   	 */
>>   	irq_work_run();
>>   
>> +	/*
>> +	 * arm_spe_pmu_buf_get_fault_act() already drained, and PMBSR_EL1.S == 1
>> +	 * means that StatisticalProfilingEnabled() == false. So now we can
>> +	 * safely disable the buffer.
>> +	 */
>> +	write_sysreg_s(0, SYS_PMBLIMITR_EL1);
>> +	isb();
>> +
>> +	/* Status can be cleared now that PMBLIMITR_EL1.E == 0 */
>> +	write_sysreg_s(0, SYS_PMBSR_EL1);
>> +
> 
> An important thing is about sequence:
> As described in arm_spe_pmu_disable_and_drain_local(), should we always
> clear ELs bits in PMSCR_EL1 before clear PMBLIMITR_EL1.E bit? As a
> reference, we could see TRBE always clear ELx bits before disable trace
> buffer.
> 
> And a trivial flaw:
> 
> If the TRUNCATED flag has been set, the irq_work_run() above runs the
> IRQ work to invoke the arm_spe_pmu_stop() to disable trace buffer, which
> clear SYS_PMBLIMITR_EL1.E bit. This is why the current code does not
> explictly clear SYS_PMBLIMITR_EL1.E bit.
> 
> With this patch, the interrupt handler will clear SYS_PMBLIMITR_EL1.E
> bit twice for a trunacated case.
> 
> 

I suppose that's a rarer case that we don't necessarily have to optimize 
for. I don't think it will do any harm, but is it even possible to avoid?

There are already some other duplications in the driver, for example in 
arm_spe_pmu_stop() we call arm_spe_pmu_disable_and_drain_local() which 
drains, and then arm_spe_pmu_buf_get_fault_act() which also drains again.

>>   	switch (act) {
>>   	case SPE_PMU_BUF_FAULT_ACT_FATAL:
>>   		/*
>> -		 * If a fatal exception occurred then leaving the profiling
>> -		 * buffer enabled is a recipe waiting to happen. Since
>> -		 * fatal faults don't always imply truncation, make sure
>> -		 * that the profiling buffer is disabled explicitly before
>> -		 * clearing the syndrome register.
>> +		 * To complete the full disable sequence, also disable profiling
>> +		 * at EL0 and EL1, we don't want to continue at all anymore.
>>   		 */
>> -		arm_spe_pmu_disable_and_drain_local();
>> +		write_sysreg_s(0, SYS_PMSCR_EL1);
>>   		break;
>>   	case SPE_PMU_BUF_FAULT_ACT_OK:
>>   		/*
>> @@ -679,18 +692,14 @@ static irqreturn_t arm_spe_pmu_irq_handler(int irq, void *dev)
>>   		 * PMBPTR might be misaligned, but we'll burn that bridge
>>   		 * when we get to it.
>>   		 */
>> -		if (!(handle->aux_flags & PERF_AUX_FLAG_TRUNCATED)) {
>> +		if (!(handle->aux_flags & PERF_AUX_FLAG_TRUNCATED))
>>   			arm_spe_perf_aux_output_begin(handle, event);
>> -			isb();
> 
> I am a bit suspecious we can remove this isb().
> 
> As a reference to the software usage PKLXF in Arm ARM (DDI 0487 L.a),
> after enable TRBE trace unit, an ISB is mandatory. Maybe check a bit
> for this?
> 
> Thanks,
> Leo
> 

Wasn't this isb() to separate the programming of the registers with the 
status register clear at the end of this function to enable profiling?

But now we enable profiling with the write to PMBLIMITR_EL1 in 
arm_spe_perf_aux_output_begin() and the last thing here is the ERET. 
That's specifically mentioned as enough synchronization in PKLXF:

   In the common case, this is an ERET instruction that returns to a
   different Exception level where tracing is allowed.

>> -		}
>>   		break;
>>   	case SPE_PMU_BUF_FAULT_ACT_SPURIOUS:
>>   		/* We've seen you before, but GCC has the memory of a sieve. */
>>   		break;
>>   	}
>>   
>> -	/* The buffer pointers are now sane, so resume profiling. */
>> -	write_sysreg_s(0, SYS_PMBSR_EL1);
>>   	return IRQ_HANDLED;
>>   }
>>   
>>
>> -- 
>> 2.34.1
>>
>>


