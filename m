Return-Path: <linux-kernel+bounces-741051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 50BC4B0DF7C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 16:51:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 611423AA942
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 14:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26C7F2EA171;
	Tue, 22 Jul 2025 14:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aU3Rrk1g"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 667C7273803
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 14:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753195577; cv=none; b=t4LXQQX7tiatE4wZRrXjkEQdJHUI/YdWkX/nFho+BucEHCIEbdngcMUc04DGqoKGlSP16WEeDbBBoMGE0zQ5G6knXiD30eBJkpihfWfXgCBOHnJisq/nPMu0Xof5ekWchvb//xnBr6vuZ4BWKcCX+KOY9VLJqnMY1kAyRxuf8+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753195577; c=relaxed/simple;
	bh=Rvaa3cO6sz7LRc4YI/Z6bfeC7kjrZOw49htRXcjJeM4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ofqoi0btT/TU0f3Hgm7kOfXAvKAbEkROLtAQnPAQfhQIoD+Gp7QKSdmKjkJm6hi/2nxWG6sXiMMmRk68WtftteudWcH88wsFThDN7wGE5R6j/XBJeDu9FnxxZG3fx57j+fdKOG14mUZqk5wdX2oxcJpvk1WjajwfxTPcVVi7ENY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aU3Rrk1g; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4563cfac19cso46613145e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 07:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753195573; x=1753800373; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+zRq6q+Q3aRIIcPAovmp38L5s64IDYxDAuFuBlXk1Vs=;
        b=aU3Rrk1gAG5wwj7esNOcZixbOoyu+WHIyQY1MGsSIKqr+lDXll+20c6Fc9OyJiVanV
         fEN6AXuYop5N8j1wcNs44m5bt5aM5XcT0y/Zo46tZGyj4/YW+w6x5QGNW7c831GGMjqb
         eHWi3g7I+qowKI7GPbtIq40cBM3SWftJmwVI1FitkOusf2vWKE/KvlLHWui7zxp4F2VI
         mPdYSNbFAspbHPFlnBw2STBJdelb0zbiSdjPTJ/5XpkeRPRfYBHir5P44Xm7b/q0G+QH
         TD1n4qx39Zrxlw4PiMP/iGw7BcPOVg1rKPPp6eIy65ZQHbDoaVGkUTpOVxDAFhmcWGQY
         clSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753195573; x=1753800373;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+zRq6q+Q3aRIIcPAovmp38L5s64IDYxDAuFuBlXk1Vs=;
        b=TX7gNalMX34vFlv9mtbOsLSaqdvsg8aX11jSTKxx9oSjTh2aDXWkX/BDeMaCu5fRf6
         SyaPp81gIF0DEbqDo5fVgmJnM7pb9D5XY7Y3NaP0u88k0PiH/rQ+fdPj8xjjuxYDnhFk
         9Dn7C8Q7bEfz0oJc3r7kjN4ROB8SRVFMhoxpHlT9MMP5/L7B9tJo2EcfzFUJ5UToQR+h
         yD91Bwh1cG3D0BmSPrqfFmSEnjlVc31YwYa6/wOBnPkyVfWdyb9zpXShaWkF2qbQab6g
         UVn6fk/GEJEt31GUSMKy0BSMcH1XBC2kpBP5rXWiLyeXz2UjvUe3x5DIPI5QrqToZ7SE
         wSmQ==
X-Forwarded-Encrypted: i=1; AJvYcCXIdjM/Uhc0ySXOaVyiLVh9wTqmnPzbhDH1j/aRemA7bGuT9drETGQSNr8z3Kn2rL2v1kvEBfp8T5tpBiM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywp6Tw1Zyl26LfAO05Xb44XzYYPyFGGdj77Ph6qj/yu+oCK4XQD
	0RQuU6ox+5I0aAV2HRNQ01uJusy6BEO1FHkdZFMWmhrB3JXOrG2+kUJiG0yuicB3bP4=
X-Gm-Gg: ASbGncssyM5A+PnrOfyclLf16p+pma/TE7Zz9Kpv0CNattSGlPNnvizSg3uMf2SlBJh
	OKAJrNgeWGflcrfqfBW2EADtD7weI5pq2Hht78lYgNNN27qiW9XpRyhvGxmJUTEmG6k/gFAn4KJ
	2914pEJq1NsNuTfHUeh4l6PFf8hzqSICQsagx3abnJ9pNwneHjgPD5xZ6+4A/AyVaf6MeReTqHv
	kkcJYlkZvkIfo6LhNSTfPPANK7PbZlhRouKQk+FLsuaimDCpwfD8T/CSaD2cl/PJmXoENme08qD
	7KFxnatHlwaXA9L4ttVtqHtz1Ap3mjEy5uvvqmy7ye1tYCwX2vMSZO4YmkRgI1XZ+xYQ/882+vi
	iIiIBw8EKDhePQIkF0wFCk5++UA8=
X-Google-Smtp-Source: AGHT+IEzlWOgnfRNv4/fQDkTRc8GhsQBHo1Y57syH6gUs7Qb009+oIXJL35tfLadwhf4ZS07sILvoA==
X-Received: by 2002:a05:600c:354c:b0:456:161c:3d61 with SMTP id 5b1f17b1804b1-4562e275c25mr216633925e9.22.1753195573391;
        Tue, 22 Jul 2025 07:46:13 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4563b75cb86sm134030035e9.32.2025.07.22.07.46.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Jul 2025 07:46:12 -0700 (PDT)
Message-ID: <10e9cb52-2476-4c13-8632-0a85830f98dd@linaro.org>
Date: Tue, 22 Jul 2025 15:46:11 +0100
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
Cc: Alexandru Elisei <alexandru.elisei@arm.com>, Will Deacon
 <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
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
 <0c53164a-306a-4cb7-9085-bba8985c32e7@linaro.org>
 <20250721152134.GF3137075@e132581.arm.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20250721152134.GF3137075@e132581.arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 21/07/2025 4:21 pm, Leo Yan wrote:
> On Mon, Jul 21, 2025 at 02:20:15PM +0100, James Clark wrote:
> 
> [...]
> 
>>>> Thought about this some more.
>>>>
>>>> Before:
>>>>
>>>> arm_spe_pmu_buf_get_fault_act:
>>>>     <drain buffer>
>>>>     ISB
>>>> arm_spe_perf_aux_output_begin:
>>>>     PMBLIMITR_EL1.E = 1
>>>> ISB
>>>> PMBSR_EL1.S = 0
>>>> ERET
>>>>
>>>> Now:
>>>>
>>>> PMBLIMITR_EL1 = 0
>>>> ISB
>>>>
>>>> PMBSR_EL1.S = 0
>>>> arm_spe_perf_aux_output_begin:
>>>>     ISB
>>>>     PMBLIMITR_EL1.E = 1
>>>> ERET
>>>>
>>>> I don't see much of a difference between the two sequences - the point after
>>>> which we can be sure that profiling is enabled remains the ERET from the
>>>> exception return.  The only difference is that, before this change, the ERET
>>>> synchronized clearing the PMBSR_EL1.S bit, now it synchronizes setting the
>>>> PMBLIMITR_EL1.E bit.
>>>>
>>>> Thoughts?
>>>
>>> To make the discussion easier, I'll focus on the trace enabling flow
>>> in this reply.
>>>
>>> My understanding of a sane flow would be:
>>>
>>>     arm_spe_pmu_irq_handler() {
>>>       arm_spe_perf_aux_output_begin() {
>>>             SYS_PMBPTR_EL1 = base;
>>>
>>>             ISB // Synchronization between SPE register setting and
>>>                 // enabling profiling buffer.
>>>             PMBLIMITR_EL1.E = 1;
>>>       }
>>>       ISB // Context synchronization event to ensure visibility to SPE
>>>     }
>>>
>>>     ... start trace ... (Bottom half, e.g., softirq, etc)
>>>
>>>     ERET
>>>
>>> In the current code, arm_spe_perf_aux_output_begin() is followed by an
>>> ISB, which serves as a context synchronization event to ensure
>>> visibility to the SPE. After that, it ensures that the trace unit will
>>> function correctly.
>>>
>>
>> But I think Alex's point is that in the existing code the thing that finally
>> enables trace (PMBSR_EL1.S = 0) isn't followed by an isb(), only an ERET. So
>> the new flow isn't any different in that regard.
> 
> Thanks for explanation.
> 
>>> I understand that the Software Usage PKLXF recommends using an ERET as
>>> the synchronization point. However, between enabling the profiling
>>> buffer and the ERET, the kernel might execute other operations (e.g.,
>>> softirqs, tasklets, etc.).
>>
>> Isn't preemption disabled? Surely that's not possible. Even if something did
>> run it wouldn't be anything that touches the SPE registers, and we're sure
>> there's an isb() between setting up the buffer and the final PMBLIMITR_EL1.E
>> = 1
> 
> Yes, bottom half runs in preemtion disabled state. See:
> 
>    el1_interrupt() -> __el1_irq() -> irq_exit_rcu() -> invoke_softirq()
> 
> In some cases, sotfirq and tasklet might even cause long latency (I
> believe it can be milliseconds or even longer), this is why ftrace
> "irqsoff" tracer is used to profile latency caused by irq off state.
> 
> Bottom half does not modify SPE registsers, but it can be a long road
> between enabling SPE trace and ERET.
> 
>>> Therefore, it seems to me that using ERET as the synchronization point
>>> may be too late. This is why I think we should keep an ISB after
>>> arm_spe_perf_aux_output_begin().
>>
>> Wouldn't that make the ERET too late even in the current code then? But I
>> think we're agreeing there's no issue there?
> 
> I would say ERET is too late for current code as well.
> 
> Thanks,
> Leo


Ok I get it now. The point is that there is stuff in between the return 
in the SPE IRQ handler and the actual ERET. If someone is interested in 
sampling the kernel then they might miss sampling a small amount of that.

It's not a correctness thing, just reducing potential gaps in the 
samples. I can add another commit to add it, but it doesn't look like it 
would be a fixes commit either, just an improvement. And the same issue 
applies to the existing code too.

James


