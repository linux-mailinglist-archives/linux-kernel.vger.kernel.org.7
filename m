Return-Path: <linux-kernel+bounces-812251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F732B53510
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 16:19:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40E3016D07B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 14:19:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B8A921930A;
	Thu, 11 Sep 2025 14:19:36 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E30E41F4E34
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 14:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757600375; cv=none; b=fjwPwfkc7kt3A3LsW6cC9egAWd4K/KLPsDjACNaSpUVuSbps1YIt7QF2VFXlxNMiYpFjpCm2c42MwBN/ydKhI4d61nhmZxY4dOeJL1ZvWa8Sw52+sllzG3+fO6ftxrJXcy3MEOZ7Oo9CDsBlCsqcVrbs2ngW0Gh+x0cHSnUNydQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757600375; c=relaxed/simple;
	bh=XNn6RgHtlgerFzNm4CBWYhbXauckYh07PfJzX9tNUyI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bfOfIIq877JZO5s4BoKo06i90hLOhjReiF8Fe0jAZ+C+gK4MN62GXSpV1t4RLfRn5g82vp954DM2+a+GmXPmVp7xAWmJbPEpbjJDKtcNukcL59j1NY4JkYGM4Fl/lQvzW/DhFRi4upppZ6UfzNK2y6Yg2j5omTyVr/uUBaKQOyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C8B09153B;
	Thu, 11 Sep 2025 07:19:24 -0700 (PDT)
Received: from [10.1.32.180] (unknown [10.1.32.180])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 95A4F3F694;
	Thu, 11 Sep 2025 07:19:31 -0700 (PDT)
Message-ID: <b4c7ad35-e855-498a-9128-6f2bdf6baaec@arm.com>
Date: Thu, 11 Sep 2025 15:19:30 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 2/2] arm64: tlbflush: Don't broadcast if mm was
 only active on local cpu
Content-Language: en-GB
To: Yang Shi <yang@os.amperecomputing.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, James Morse <james.morse@arm.com>,
 "Christoph Lameter (Ampere)" <cl@gentwo.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250829153510.2401161-1-ryan.roberts@arm.com>
 <20250829153510.2401161-3-ryan.roberts@arm.com>
 <dcc3b52d-0b86-47fc-8297-a6abc8af4c38@os.amperecomputing.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <dcc3b52d-0b86-47fc-8297-a6abc8af4c38@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/09/2025 00:58, Yang Shi wrote:
> Hi Ryan,
> 
> 
> On 8/29/25 8:35 AM, Ryan Roberts wrote:
>> There are 3 variants of tlb flush that invalidate user mappings:
>> flush_tlb_mm(), flush_tlb_page() and __flush_tlb_range(). All of these
>> would previously unconditionally broadcast their tlbis to all cpus in
>> the inner shareable domain.
>>
>> But this is a waste of effort if we can prove that the mm for which we
>> are flushing the mappings has only ever been active on the local cpu. In
>> that case, it is safe to avoid the broadcast and simply invalidate the
>> current cpu.
>>
>> So let's track in mm_context_t::active_cpu either the mm has never been
>> active on any cpu, has been active on more than 1 cpu, or has been
>> active on precisely 1 cpu - and in that case, which one. We update this
>> when switching context, being careful to ensure that it gets updated
>> *before* installing the mm's pgtables. On the reader side, we ensure we
>> read *after* the previous write(s) to the pgtable(s) that necessitated
>> the tlb flush have completed. This guarrantees that if a cpu that is
>> doing a tlb flush sees it's own id in active_cpu, then the old pgtable
>> entry cannot have been seen by any other cpu and we can flush only the
>> local cpu.
>>
>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>> ---
>>   arch/arm64/include/asm/mmu.h         | 12 ++++
>>   arch/arm64/include/asm/mmu_context.h |  2 +
>>   arch/arm64/include/asm/tlbflush.h    | 90 +++++++++++++++++++++++++---
>>   arch/arm64/mm/context.c              | 30 +++++++++-
>>   4 files changed, 123 insertions(+), 11 deletions(-)
>>
>> diff --git a/arch/arm64/include/asm/mmu.h b/arch/arm64/include/asm/mmu.h
>> index 6e8aa8e72601..ca32fb860309 100644
>> --- a/arch/arm64/include/asm/mmu.h
>> +++ b/arch/arm64/include/asm/mmu.h
>> @@ -17,6 +17,17 @@
>>   #include <linux/refcount.h>
>>   #include <asm/cpufeature.h>
>>   +/*
>> + * Sentinal values for mm_context_t::active_cpu. ACTIVE_CPU_NONE indicates the
>> + * mm has never been active on any CPU. ACTIVE_CPU_MULTIPLE indicates the mm
>> + * has been active on multiple CPUs. Any other value is the ID of the single
>> + * CPU that the mm has been active on.
>> + */
>> +enum active_cpu {
>> +    ACTIVE_CPU_NONE = UINT_MAX,
>> +    ACTIVE_CPU_MULTIPLE = UINT_MAX - 1,
>> +};
>> +
>>   typedef struct {
>>       atomic64_t    id;
>>   #ifdef CONFIG_COMPAT
>> @@ -26,6 +37,7 @@ typedef struct {
>>       void        *vdso;
>>       unsigned long    flags;
>>       u8        pkey_allocation_map;
>> +    unsigned int    active_cpu;
> 
> Any reason why you don't use bit mask to mark the active CPUs? And mm_struct
> also has cpu_bitmap to record the active CPUs which the process has run on. Why
> not just use it? 

An earlier draft of this patch used that approach. But that version returned
some performance regressions. I then re-wrote the whole thing as tight as I
could, including getting rid of the use of the cpu mask; I figured that there
are (usually?) 512 bits in a mask, so that's 8 loads to figure out if the thread
has run on more than 1 CPU. Whereas my approach is 1 load.

Anyway, I don't have hard evidence that it is actually the cpu mask that was
causing the slow downs. I made other changes too. I'll revisit this and do more
testing. I agree it would be good to use the cpu mask if we can. (or don't
bother allocating it if we can't!).

> x86 uses it to determine which CPUs kernel should send TLB
> flush IPI to. I understand this series just check whether local cpu is the
> active cpu or not, but bit mask should not make things more complicated. And it
> also can provide more flexibility. We can extend this, for example, use IPI to
> send local TLB flush if the number of active cpus is quite low. AFAIK, x86 added
> TLBI broadcast support too, and fallback to IPI if the number of active cpus is
> <= 3. IIRC, Christohper's series did the similar thing. He should be interested
> in this series too, cc'ed him.

That definitely feels like a separate step, if we even want to go in that direction.

> 
> Thanks,
> Yang
> 
>>   } mm_context_t;
>>     /*
>> diff --git a/arch/arm64/include/asm/mmu_context.h b/arch/arm64/include/asm/
>> mmu_context.h
>> index 0dbe3b29049b..db2505a8eba8 100644
>> --- a/arch/arm64/include/asm/mmu_context.h
>> +++ b/arch/arm64/include/asm/mmu_context.h
>> @@ -180,6 +180,8 @@ init_new_context(struct task_struct *tsk, struct mm_struct
>> *mm)
>>       /* pkey 0 is the default, so always reserve it. */
>>       mm->context.pkey_allocation_map = BIT(0);
>>   +    WRITE_ONCE(mm->context.active_cpu, ACTIVE_CPU_NONE);
>> +
>>       return 0;
>>   }
>>   diff --git a/arch/arm64/include/asm/tlbflush.h b/arch/arm64/include/asm/
>> tlbflush.h
>> index f66b8c4696d0..651440e0aff9 100644
>> --- a/arch/arm64/include/asm/tlbflush.h
>> +++ b/arch/arm64/include/asm/tlbflush.h
>> @@ -182,6 +182,52 @@ static inline unsigned long get_trans_granule(void)
>>           (__pages >> (5 * (scale) + 1)) - 1;            \
>>       })
>>   +/*
>> + * Determines whether the user tlbi invalidation can be performed only on the
>> + * local CPU or whether it needs to be broadcast. (Returns true for local).
>> + * Additionally issues appropriate barrier to ensure prior pgtable updates are
>> + * visible to the table walker. Must be paired with flush_tlb_user_post().
>> + */
>> +static inline bool flush_tlb_user_pre(struct mm_struct *mm)
>> +{
>> +    unsigned int self, active;
>> +    bool local;
>> +
>> +    migrate_disable();
>> +
>> +    self = smp_processor_id();
>> +
>> +    /*
>> +     * The load of mm->context.active_cpu must not be reordered before the
>> +     * store to the pgtable that necessitated this flush. This ensures that
>> +     * if the value read is our cpu id, then no other cpu can have seen the
>> +     * old pgtable value and therefore does not need this old value to be
>> +     * flushed from its tlb. But we don't want to upgrade the dsb(ishst),
>> +     * needed to make the pgtable updates visible to the walker, to a
>> +     * dsb(ish) by default. So speculatively load without a barrier and if
>> +     * it indicates our cpu id, then upgrade the barrier and re-load.
>> +     */
>> +    active = READ_ONCE(mm->context.active_cpu);
>> +    if (active == self) {
>> +        dsb(ish);
>> +        active = READ_ONCE(mm->context.active_cpu);
>> +    } else {
>> +        dsb(ishst);
>> +    }
>> +
>> +    local = active == self;
>> +    if (!local)
>> +        migrate_enable();
>> +
>> +    return local;
>> +}
>> +
>> +static inline void flush_tlb_user_post(bool local)
>> +{
>> +    if (local)
>> +        migrate_enable();
>> +}
>> +
>>   /*
>>    *    TLB Invalidation
>>    *    ================
>> @@ -274,11 +320,18 @@ static inline void flush_tlb_all(void)
>>   static inline void flush_tlb_mm(struct mm_struct *mm)
>>   {
>>       unsigned long asid;
>> +    bool local;
>>   -    dsb(ishst);
>> +    local = flush_tlb_user_pre(mm);
>>       asid = __TLBI_VADDR(0, ASID(mm));
>> -    __tlbi(aside1is, asid);
>> -    __tlbi_user(aside1is, asid);
>> +    if (local) {
>> +        __tlbi(aside1, asid);
>> +        __tlbi_user(aside1, asid);
>> +    } else {
>> +        __tlbi(aside1is, asid);
>> +        __tlbi_user(aside1is, asid);
>> +    }
>> +    flush_tlb_user_post(local);
>>       dsb(ish);
>>       mmu_notifier_arch_invalidate_secondary_tlbs(mm, 0, -1UL);
>>   }
>> @@ -287,11 +340,18 @@ static inline void __flush_tlb_page_nosync(struct
>> mm_struct *mm,
>>                          unsigned long uaddr)
>>   {
>>       unsigned long addr;
>> +    bool local;
>>   -    dsb(ishst);
>> +    local = flush_tlb_user_pre(mm);
>>       addr = __TLBI_VADDR(uaddr, ASID(mm));
>> -    __tlbi(vale1is, addr);
>> -    __tlbi_user(vale1is, addr);
>> +    if (local) {
>> +        __tlbi(vale1, addr);
>> +        __tlbi_user(vale1, addr);
>> +    } else {
>> +        __tlbi(vale1is, addr);
>> +        __tlbi_user(vale1is, addr);
>> +    }
>> +    flush_tlb_user_post(local);
>>       mmu_notifier_arch_invalidate_secondary_tlbs(mm, uaddr & PAGE_MASK,
>>                           (uaddr & PAGE_MASK) + PAGE_SIZE);
>>   }
>> @@ -437,6 +497,8 @@ static inline bool __flush_tlb_range_limit_excess(unsigned
>> long start,
>>   enum tlbi_op {
>>       TLBI_VALE1IS,
>>       TLBI_VAE1IS,
>> +    TLBI_VALE1,
>> +    TLBI_VAE1,
>>   };
>>     #define flush_tlb_range_op(op, ...)                    \
>> @@ -448,6 +510,12 @@ do {                                    \
>>       case TLBI_VAE1IS:                        \
>>           __flush_tlb_range_op(vae1is, __VA_ARGS__);        \
>>           break;                            \
>> +    case TLBI_VALE1:                        \
>> +        __flush_tlb_range_op(vale1, __VA_ARGS__);        \
>> +        break;                            \
>> +    case TLBI_VAE1:                            \
>> +        __flush_tlb_range_op(vae1,  __VA_ARGS__);        \
>> +        break;                            \
>>       default:                            \
>>           BUILD_BUG_ON_MSG(1, "Unknown TLBI op");            \
>>       }                                \
>> @@ -460,6 +528,7 @@ static inline void __flush_tlb_range_nosync(struct
>> mm_struct *mm,
>>   {
>>       unsigned long asid, pages;
>>       enum tlbi_op tlbi_op;
>> +    bool local;
>>         start = round_down(start, stride);
>>       end = round_up(end, stride);
>> @@ -470,13 +539,18 @@ static inline void __flush_tlb_range_nosync(struct
>> mm_struct *mm,
>>           return;
>>       }
>>   -    dsb(ishst);
>> +    local = flush_tlb_user_pre(mm);
>>       asid = ASID(mm);
>>   -    tlbi_op = last_level ? TLBI_VALE1IS : TLBI_VAE1IS;
>> +    if (local)
>> +        tlbi_op = last_level ? TLBI_VALE1 : TLBI_VAE1;
>> +    else
>> +        tlbi_op = last_level ? TLBI_VALE1IS : TLBI_VAE1IS;
>> +
>>       flush_tlb_range_op(tlbi_op, start, pages, stride, asid, tlb_level,
>>                  true, lpa2_is_enabled());
>>   +    flush_tlb_user_post(local);
>>       mmu_notifier_arch_invalidate_secondary_tlbs(mm, start, end);
>>   }
>>   diff --git a/arch/arm64/mm/context.c b/arch/arm64/mm/context.c
>> index b2ac06246327..adf4fc26ddb6 100644
>> --- a/arch/arm64/mm/context.c
>> +++ b/arch/arm64/mm/context.c
>> @@ -214,9 +214,10 @@ static u64 new_context(struct mm_struct *mm)
>>     void check_and_switch_context(struct mm_struct *mm)
>>   {
>> -    unsigned long flags;
>> -    unsigned int cpu;
>> +    unsigned int cpu = smp_processor_id();
>>       u64 asid, old_active_asid;
>> +    unsigned int active;
>> +    unsigned long flags;
>>         if (system_supports_cnp())
>>           cpu_set_reserved_ttbr0();
>> @@ -251,7 +252,6 @@ void check_and_switch_context(struct mm_struct *mm)
>>           atomic64_set(&mm->context.id, asid);
>>       }
>>   -    cpu = smp_processor_id();
>>       if (cpumask_test_and_clear_cpu(cpu, &tlb_flush_pending))
>>           local_flush_tlb_all();
>>   @@ -262,6 +262,30 @@ void check_and_switch_context(struct mm_struct *mm)
>>         arm64_apply_bp_hardening();
>>   +    /*
>> +     * Update mm->context.active_cpu in such a manner that we avoid cmpxchg
>> +     * and dsb unless we definitely need it. If initially ACTIVE_CPU_NONE
>> +     * then we are the first cpu to run so set it to our id. If initially
>> +     * any id other than ours, we are the second cpu to run so set it to
>> +     * ACTIVE_CPU_MULTIPLE. If we update the value then we must issue
>> +     * dsb(ishst) to ensure stores to mm->context.active_cpu are ordered
>> +     * against the TTBR0 write in cpu_switch_mm()/uaccess_enable(); the
>> +     * store must be visible to another cpu before this cpu could have
>> +     * populated any TLB entries based on the pgtables that will be
>> +     * installed.
>> +     */
>> +    active = READ_ONCE(mm->context.active_cpu);
>> +    if (active != cpu && active != ACTIVE_CPU_MULTIPLE) {
>> +        if (active == ACTIVE_CPU_NONE)
>> +            active = cmpxchg_relaxed(&mm->context.active_cpu,
>> +                         ACTIVE_CPU_NONE, cpu);
>> +
>> +        if (active != ACTIVE_CPU_NONE)
>> +            WRITE_ONCE(mm->context.active_cpu, ACTIVE_CPU_MULTIPLE);
>> +
>> +        dsb(ishst);
>> +    }
>> +
>>       /*
>>        * Defer TTBR0_EL1 setting for user threads to uaccess_enable() when
>>        * emulating PAN.
> 


