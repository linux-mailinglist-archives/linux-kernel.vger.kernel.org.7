Return-Path: <linux-kernel+bounces-824198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B995BB88590
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 10:11:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 680731BC5753
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 08:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8090230499D;
	Fri, 19 Sep 2025 08:11:42 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39FEE304964
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 08:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758269502; cv=none; b=TSey46VKxlg7qGf0gfwRl41gb498/Im/IyKBjLxgP5iLf3JyfwmpaizwAdVzj6vhkbmiPWQwXwMWzlI5Fbhd4O+8HyzZj/X8IigmV2iN9jGNz4z3SP5mf5FD/Qer2UZKN64PwccXlAMVz9f3tmBL/6TeS40czQYM5U4BEbfOFQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758269502; c=relaxed/simple;
	bh=5uWE46z4dm0snoeI5SDdVLa/AfPTs/GDrGSvf+dlhu4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TT1dTqSePbj2kquX7w2dPqyfPw4HFGv+ozTJ+/0QgQ9qwKV71gWvxXYaN5OSbwsYuA/iibjOIGsT7nxSYABVWyUmPcOFbUyY+IuLRI6MVHbJwcpKMM7J1Ivjibg7Hy0gbt67nj6M8YOSmMMAsNwjEMPfFo5O+3b+xlddNLHnS+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5F02A16A3;
	Fri, 19 Sep 2025 01:11:31 -0700 (PDT)
Received: from [10.57.95.38] (unknown [10.57.95.38])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 16B3C3F673;
	Fri, 19 Sep 2025 01:11:36 -0700 (PDT)
Message-ID: <0686e52a-ee35-4179-ab35-719598c31fef@arm.com>
Date: Fri, 19 Sep 2025 09:11:35 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH v5] arm64: Enable vmalloc-huge with ptdump
Content-Language: en-GB
To: Dev Jain <dev.jain@arm.com>, Will Deacon <will@kernel.org>
Cc: catalin.marinas@arm.com, anshuman.khandual@arm.com,
 quic_zhenhuah@quicinc.com, kevin.brodsky@arm.com, yangyicong@hisilicon.com,
 joey.gouly@arm.com, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, david@redhat.com, mark.rutland@arm.com,
 urezki@gmail.com, jthoughton@google.com
References: <20250723161827.15802-1-dev.jain@arm.com>
 <aMk8QhkumtEoPVTh@willie-the-truck>
 <e9ea7a4c-6f37-40e2-8812-3125e85cbeed@arm.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <e9ea7a4c-6f37-40e2-8812-3125e85cbeed@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 19/09/2025 08:53, Dev Jain wrote:
> 
> On 16/09/25 4:00 pm, Will Deacon wrote:
>> Hi Dev,
>>
>> On Wed, Jul 23, 2025 at 09:48:27PM +0530, Dev Jain wrote:
>>> @@ -1301,16 +1319,76 @@ int pud_free_pmd_page(pud_t *pudp, unsigned long addr)
>>>       }
>>>         table = pmd_offset(pudp, addr);
>>> +
>>> +    /*
>>> +     * Our objective is to prevent ptdump from reading a PMD table which has
>>> +     * been freed.  Assume that ptdump_walk_pgd() (call this thread T1)
>>> +     * executes completely on CPU1 and pud_free_pmd_page() (call this thread
>>> +     * T2) executes completely on CPU2. Let the region sandwiched by the
>>> +     * mmap_write_lock/unlock in T1 be called CS (the critical section).
>>> +     *
>>> +     * Claim: The CS of T1 will never operate on a freed PMD table.
>>> +     *
>>> +     * Proof:
>>> +     *
>>> +     * Case 1: The static branch is visible to T2.
>>> +     *
>>> +     * Case 1 (a): T1 acquires the lock before T2 can.
>>> +     * T2 will block until T1 drops the lock, so pmd_free() will only be
>>> +     * executed after T1 exits CS.
>>> +     *
>>> +     * Case 1 (b): T2 acquires the lock before T1 can.
>>> +     * The sequence of barriers issued in __flush_tlb_kernel_pgtable()
>>> +     * ensures that an empty PUD (via pud_clear()) is visible to T1 before
>>> +     * T1 can enter CS, therefore it is impossible for the CS to get hold
>>> +     * of the address of the isolated PMD table.
>>> +     *
>>> +     * Case 2: The static branch is not visible to T2.
>>> +     *
>>> +     * Since static_branch_enable() (via dmb(ish)) and mmap_write_lock()
>>> +     * have acquire semantics, it is guaranteed that the static branch
>>> +     * will be visible to all CPUs before T1 can enter CS. The static
>>> +     * branch not being visible to T2 therefore guarantees that T1 has
>>> +     * not yet entered CS .... (i)
>>> +     * The sequence of barriers via __flush_tlb_kernel_pgtable() in T2
>>> +     * implies that if the invisibility of the static branch has been
>>> +     * observed by T2 (i.e static_branch_unlikely() is observed as false),
>>> +     * then all CPUs will have observed an empty PUD ... (ii)
>>> +     * Combining (i) and (ii), we conclude that T1 observes an empty PUD
>>> +     * before entering CS => it is impossible for the CS to get hold of
>>> +     * the address of the isolated PMD table. Q.E.D
>>> +     *
>>> +     * We have proven that the claim is true on the assumption that
>>> +     * there is no context switch for T1 and T2. Note that the reasoning
>>> +     * of the proof uses barriers operating on the inner shareable domain,
>>> +     * which means that they will affect all CPUs, and also a context switch
>>> +     * will insert extra barriers into the code paths => the claim will
>>> +     * stand true even if we drop the assumption.
>>> +     *
>>> +     * It is also worth reasoning whether something can go wrong via
>>> +     * pud_free_pmd_page() -> __pmd_free_pte_page(), since the latter
>>> +     * will be called locklessly on this code path.
>>> +     *
>>> +     * For Case 1 (a), T2 will block until CS is finished, so we are safe.
>>> +     * For Case 1 (b) and Case 2, the PMD table will be isolated before
>>> +     * T1 can enter CS, therefore it is safe for T2 to operate on the
>>> +     * PMD table locklessly.
>>> +     */
>> Although I can see that you put a lot of effort into this comment, I
>> think we should just remove it. Instead, we should have a litmus test
>> in the commit message and probably just some small comments here to
>> explain e.g. why the mmap_read_lock() critical section is empty.
>>
>> I'm currently trying to put together a litmus test with James (cc'd) so
>> maybe we can help you out with that part.
> 
> Thanks for the effort!
> 
>>
>> In the meantime...
>>
>>> diff --git a/arch/arm64/mm/ptdump.c b/arch/arm64/mm/ptdump.c
>>> index 421a5de806c6..65335c7ba482 100644
>>> --- a/arch/arm64/mm/ptdump.c
>>> +++ b/arch/arm64/mm/ptdump.c
>>> @@ -283,6 +283,13 @@ void note_page_flush(struct ptdump_state *pt_st)
>>>       note_page(pt_st, 0, -1, pte_val(pte_zero));
>>>   }
>>>   +static void arm64_ptdump_walk_pgd(struct ptdump_state *st, struct
>>> mm_struct *mm)
>>> +{
>>> +    static_branch_enable(&arm64_ptdump_lock_key);
>>> +    ptdump_walk_pgd(st, mm, NULL);
>>> +    static_branch_disable(&arm64_ptdump_lock_key);
>>> +}
>> What serialises the toggling of the static key here? For example, I can't
>> see what prevents a kernel page-table dump running concurrently with a
>> check_wx() and the key ending up in the wrong state.
> 
> Good spot. I believe static_branch_{inc, dec} should work here. The vmalloc code
> only needs to know that someone is traversing the pagetables, and there is no
> synchronization needed between check_wx and ptdump. And, static_branch_inc()
> should have the same semantics as static_branch_enable().

get/put, enable/disable, inc/dec... I love Linux's inconsistent rules around
terminology for ref counting... sigh.

Anyway, for a bit more bikeshedding, I just read this comment:

 * When the control is directly exposed to userspace, it is prudent to delay the
 * decrement to avoid high frequency code modifications which can (and do)
 * cause significant performance degradation. Struct static_key_deferred and
 * static_key_slow_dec_deferred() provide for this.

Perhaps static_key_slow_dec_deferred() would be a better choice? (assuming we
can agree what an appropriate timeout is). That said, I guess this functionality
is going to remain an off-by-default debug Kconfig, so perhaps it doesn't matter.

Thanks,
Ryan


> 
>>
>> Either we need an additional lock or perhaps using
>> static_branch_{inc,dec}() would work instead? I haven't thought too hard
>> about that but it looks like we need _something_.
>>
>> Will


