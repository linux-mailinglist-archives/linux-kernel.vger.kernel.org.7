Return-Path: <linux-kernel+bounces-874197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 89CB8C15BD5
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 17:19:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBF881C262F7
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 16:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46FB433033A;
	Tue, 28 Oct 2025 16:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fP8aN+1n"
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE4B278E5D
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 16:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761668021; cv=none; b=caTAqeWSxLayJVT3oT9MdxK1Q4GhBHta2NKtGuMpRnTjb8yFarK3iyLtop66NbkPKXyaWZnN201Wu7URc2LJNQWsTToT5ZDqehMlofmKTFyJ2ycbKBKKu1qN9/ctyFo8Lgq9DBQdrC5Pj7O5w3BxqbINhOAo8/GIz22DKmzr8jU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761668021; c=relaxed/simple;
	bh=1FMr40Wyu3AEU5OL8LlXUIHcjSkACHNNJ/reBeLQWaQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CbPJrjx4J2+5SquSpqtweBmlIX5X8OhCJqycZKLdmzbsDMozxfVy5c1SYFtePI1+MVb3/X8TCpFiTyasTf2v63Gp0kxdPgZPYzHNXdMUgB9sR/gcSg5MhVQxzxaRhG0WZkFsxIer9k4EWeer7O0mGfedifwjv6kuCrLkc/2gpV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fP8aN+1n; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <91ebba8f-6960-46f7-854a-6bab3d0bbd5b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761668018;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k6hFEseP+AK2f/a81hSP487sZcnRCpMeyAI0dHmU+Gc=;
	b=fP8aN+1nMFWAupOIls4HnUnlF9HtUlZL0o8l+1djP+YfdNfdJ3J/Cia9HJk1DLE2MjIDXu
	NE9SrXnAlosd61D6n3fbZg3bmkoXv24Mz2Tn7binXtKafWMMVkPuU/93T27jM6N8KarUyo
	OPTFKjSShHeTIA1HBbBj+pksZsl3vEk=
Date: Tue, 28 Oct 2025 09:13:24 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] RISC-V: Enable HOTPLUG_PARALLEL for secondary CPUs
To: Anup Patel <anup@brainfault.org>
Cc: Anup Patel <apatel@ventanamicro.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>,
 Alexandre Ghiti <alex@ghiti.fr>, Sunil V L <sunilvl@ventanamicro.com>,
 Andrew Jones <ajones@ventanamicro.com>, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20250905122512.71684-1-apatel@ventanamicro.com>
 <0f7e6be5-f9ac-4019-93c6-295a068046a8@linux.dev>
 <CAAhSdy1uGQaPc2SkcX5oHF-aP4dOS1gu5iHor5O8zmz-XWUtBA@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Atish Patra <atish.patra@linux.dev>
Content-Language: en-US
In-Reply-To: <CAAhSdy1uGQaPc2SkcX5oHF-aP4dOS1gu5iHor5O8zmz-XWUtBA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 10/28/25 1:48 AM, Anup Patel wrote:
> On Tue, Oct 28, 2025 at 2:05 PM Atish Patra <atish.patra@linux.dev> wrote:
>>
>> On 9/5/25 5:25 AM, Anup Patel wrote:
>>> The core kernel already supports parallel bringup of secondary
>>> CPUs (aka HOTPLUG_PARALLEL). The x86 and MIPS architectures
>>> already use HOTPLUG_PARALLEL and ARM is also moving toward it.
>>>
>>> On RISC-V, there is no arch specific global data accessed in the
>>> RISC-V secondary CPU bringup path so enabling HOTPLUG_PARALLEL for
>>> RISC-V would only requires:
>>> 1) Providing RISC-V specific arch_cpuhp_kick_ap_alive()
>>> 2) Calling cpuhp_ap_sync_alive() from smp_callin()
>>>
>>> This patch is tested natively with OpenSBI on QEMU RV64 virt machine
>>> with 64 cores and also tested with KVM RISC-V guest with 32 VCPUs.
>>>
>>> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
>>> ---
>>>    arch/riscv/Kconfig          |  2 +-
>>>    arch/riscv/kernel/smpboot.c | 15 +++++++++++++++
>>>    2 files changed, 16 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
>>> index a4b233a0659e..d5800d6f9a15 100644
>>> --- a/arch/riscv/Kconfig
>>> +++ b/arch/riscv/Kconfig
>>> @@ -196,7 +196,7 @@ config RISCV
>>>        select HAVE_SAMPLE_FTRACE_DIRECT_MULTI
>>>        select HAVE_STACKPROTECTOR
>>>        select HAVE_SYSCALL_TRACEPOINTS
>>> -     select HOTPLUG_CORE_SYNC_DEAD if HOTPLUG_CPU
>>> +     select HOTPLUG_PARALLEL if HOTPLUG_CPU
>>>        select IRQ_DOMAIN
>>>        select IRQ_FORCED_THREADING
>>>        select KASAN_VMALLOC if KASAN
>>> diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
>>> index 601a321e0f17..d85916a3660c 100644
>>> --- a/arch/riscv/kernel/smpboot.c
>>> +++ b/arch/riscv/kernel/smpboot.c
>>> @@ -39,7 +39,9 @@
>>>
>>>    #include "head.h"
>>>
>>> +#ifndef CONFIG_HOTPLUG_PARALLEL
>>>    static DECLARE_COMPLETION(cpu_running);
>>> +#endif
>>>
>>>    void __init smp_prepare_cpus(unsigned int max_cpus)
>>>    {
>>> @@ -179,6 +181,12 @@ static int start_secondary_cpu(int cpu, struct task_struct *tidle)
>>>        return -EOPNOTSUPP;
>>>    }
>>>
>>> +#ifdef CONFIG_HOTPLUG_PARALLEL
>>> +int arch_cpuhp_kick_ap_alive(unsigned int cpu, struct task_struct *tidle)
>>> +{
>>> +     return start_secondary_cpu(cpu, tidle);
>>> +}
>>> +#else
>>>    int __cpu_up(unsigned int cpu, struct task_struct *tidle)
>>>    {
>>>        int ret = 0;
>>> @@ -199,6 +207,7 @@ int __cpu_up(unsigned int cpu, struct task_struct *tidle)
>>>
>>>        return ret;
>>>    }
>>> +#endif
>>>
>>>    void __init smp_cpus_done(unsigned int max_cpus)
>>>    {
>>> @@ -225,6 +234,10 @@ asmlinkage __visible void smp_callin(void)
>>>        mmgrab(mm);
>>>        current->active_mm = mm;
>>>
>>> +#ifdef CONFIG_HOTPLUG_PARALLEL
>>> +     cpuhp_ap_sync_alive();
>>> +#endif
>>> +
>>>        store_cpu_topology(curr_cpuid);
>>>        notify_cpu_starting(curr_cpuid);
>>>
>>> @@ -243,7 +256,9 @@ asmlinkage __visible void smp_callin(void)
>>>         */
>>>        local_flush_icache_all();
>>>        local_flush_tlb_all();
>>> +#ifndef CONFIG_HOTPLUG_PARALLEL
>>>        complete(&cpu_running);
>>> +#endif
>> LGTM.
>>
>> Reviewed-by: Atish Patra <atishp@rivosinc.com>
>>
>> Have you tried with 128 harts ? I was not able to boot 128 harts in Qemu
>> with NR_CPUS=256.
>> This is unrelated to this patch though. I can reproduce the issue on
>> upstream with 6.18-rc3.
> I have tried upto 96 harts and that works fine.

Yeah. I had tried upto 92 as well.

> For 128 harts, the memory used by OpenSBI goes beyond 2MB so
> OpenSBI can't run from the first 2MB of DRAM (0x80000000) as the
> first booting stage. Try with U-Boot SPL loading OpenSBI from FIT image.

Ahh yes. That makes sense. I will try with U-Boot SPL.

> Regards,
> Anup
>
>>
>>>        /*
>>>         * Disable preemption before enabling interrupts, so we don't try to
>>>         * schedule a CPU that hasn't actually started yet.

