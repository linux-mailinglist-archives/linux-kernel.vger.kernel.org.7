Return-Path: <linux-kernel+bounces-824175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E30EB88487
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 09:53:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50C177C5EE2
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 07:53:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE01F2EBDD3;
	Fri, 19 Sep 2025 07:53:32 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FD0B2EB857
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 07:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758268412; cv=none; b=X9xp/98dIESv/c9erCQ5BD24PglWqtiPgF5VNB4ftl7vzyiSxVw52BP32K+KhAXKeQNNzgQnWtnoMosXTYZGJ8tEmsOLS9u1aQ7K2VTplaQT94HvABcRrkhhL59iziQ7jsry6vu50qEm5CF/LKIDYIvH/kabslPrjiIzvYr72Fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758268412; c=relaxed/simple;
	bh=pg3g9pPSZSIQkFxf0kn3Ll3KmCSbd8s08wa/bWL2iDU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B0qFOHB22IxP05v5R/i1dI1ntcpnFA364+d2D+EUcq3lpCAFTzY3vm57AxJOxwqjyYX4p3ngaMNP1MbKFfuhgqZ/D1s/pJwTlcD6crVbpEt2nX43FTLseRNP/bmUsnHcaA2RHartGQWNhcSRCxhNIp5vDAjGOUr1MQBOmbMkv0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BE4E9169C;
	Fri, 19 Sep 2025 00:53:21 -0700 (PDT)
Received: from [10.164.18.52] (MacBook-Pro.blr.arm.com [10.164.18.52])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DAF2E3F673;
	Fri, 19 Sep 2025 00:53:25 -0700 (PDT)
Message-ID: <e9ea7a4c-6f37-40e2-8812-3125e85cbeed@arm.com>
Date: Fri, 19 Sep 2025 13:23:22 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH v5] arm64: Enable vmalloc-huge with ptdump
To: Will Deacon <will@kernel.org>
Cc: catalin.marinas@arm.com, anshuman.khandual@arm.com,
 quic_zhenhuah@quicinc.com, ryan.roberts@arm.com, kevin.brodsky@arm.com,
 yangyicong@hisilicon.com, joey.gouly@arm.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 david@redhat.com, mark.rutland@arm.com, urezki@gmail.com,
 jthoughton@google.com
References: <20250723161827.15802-1-dev.jain@arm.com>
 <aMk8QhkumtEoPVTh@willie-the-truck>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <aMk8QhkumtEoPVTh@willie-the-truck>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 16/09/25 4:00 pm, Will Deacon wrote:
> Hi Dev,
>
> On Wed, Jul 23, 2025 at 09:48:27PM +0530, Dev Jain wrote:
>> @@ -1301,16 +1319,76 @@ int pud_free_pmd_page(pud_t *pudp, unsigned long addr)
>>   	}
>>   
>>   	table = pmd_offset(pudp, addr);
>> +
>> +	/*
>> +	 * Our objective is to prevent ptdump from reading a PMD table which has
>> +	 * been freed.  Assume that ptdump_walk_pgd() (call this thread T1)
>> +	 * executes completely on CPU1 and pud_free_pmd_page() (call this thread
>> +	 * T2) executes completely on CPU2. Let the region sandwiched by the
>> +	 * mmap_write_lock/unlock in T1 be called CS (the critical section).
>> +	 *
>> +	 * Claim: The CS of T1 will never operate on a freed PMD table.
>> +	 *
>> +	 * Proof:
>> +	 *
>> +	 * Case 1: The static branch is visible to T2.
>> +	 *
>> +	 * Case 1 (a): T1 acquires the lock before T2 can.
>> +	 * T2 will block until T1 drops the lock, so pmd_free() will only be
>> +	 * executed after T1 exits CS.
>> +	 *
>> +	 * Case 1 (b): T2 acquires the lock before T1 can.
>> +	 * The sequence of barriers issued in __flush_tlb_kernel_pgtable()
>> +	 * ensures that an empty PUD (via pud_clear()) is visible to T1 before
>> +	 * T1 can enter CS, therefore it is impossible for the CS to get hold
>> +	 * of the address of the isolated PMD table.
>> +	 *
>> +	 * Case 2: The static branch is not visible to T2.
>> +	 *
>> +	 * Since static_branch_enable() (via dmb(ish)) and mmap_write_lock()
>> +	 * have acquire semantics, it is guaranteed that the static branch
>> +	 * will be visible to all CPUs before T1 can enter CS. The static
>> +	 * branch not being visible to T2 therefore guarantees that T1 has
>> +	 * not yet entered CS .... (i)
>> +	 * The sequence of barriers via __flush_tlb_kernel_pgtable() in T2
>> +	 * implies that if the invisibility of the static branch has been
>> +	 * observed by T2 (i.e static_branch_unlikely() is observed as false),
>> +	 * then all CPUs will have observed an empty PUD ... (ii)
>> +	 * Combining (i) and (ii), we conclude that T1 observes an empty PUD
>> +	 * before entering CS => it is impossible for the CS to get hold of
>> +	 * the address of the isolated PMD table. Q.E.D
>> +	 *
>> +	 * We have proven that the claim is true on the assumption that
>> +	 * there is no context switch for T1 and T2. Note that the reasoning
>> +	 * of the proof uses barriers operating on the inner shareable domain,
>> +	 * which means that they will affect all CPUs, and also a context switch
>> +	 * will insert extra barriers into the code paths => the claim will
>> +	 * stand true even if we drop the assumption.
>> +	 *
>> +	 * It is also worth reasoning whether something can go wrong via
>> +	 * pud_free_pmd_page() -> __pmd_free_pte_page(), since the latter
>> +	 * will be called locklessly on this code path.
>> +	 *
>> +	 * For Case 1 (a), T2 will block until CS is finished, so we are safe.
>> +	 * For Case 1 (b) and Case 2, the PMD table will be isolated before
>> +	 * T1 can enter CS, therefore it is safe for T2 to operate on the
>> +	 * PMD table locklessly.
>> +	 */
> Although I can see that you put a lot of effort into this comment, I
> think we should just remove it. Instead, we should have a litmus test
> in the commit message and probably just some small comments here to
> explain e.g. why the mmap_read_lock() critical section is empty.
>
> I'm currently trying to put together a litmus test with James (cc'd) so
> maybe we can help you out with that part.

Thanks for the effort!

>
> In the meantime...
>
>> diff --git a/arch/arm64/mm/ptdump.c b/arch/arm64/mm/ptdump.c
>> index 421a5de806c6..65335c7ba482 100644
>> --- a/arch/arm64/mm/ptdump.c
>> +++ b/arch/arm64/mm/ptdump.c
>> @@ -283,6 +283,13 @@ void note_page_flush(struct ptdump_state *pt_st)
>>   	note_page(pt_st, 0, -1, pte_val(pte_zero));
>>   }
>>   
>> +static void arm64_ptdump_walk_pgd(struct ptdump_state *st, struct mm_struct *mm)
>> +{
>> +	static_branch_enable(&arm64_ptdump_lock_key);
>> +	ptdump_walk_pgd(st, mm, NULL);
>> +	static_branch_disable(&arm64_ptdump_lock_key);
>> +}
> What serialises the toggling of the static key here? For example, I can't
> see what prevents a kernel page-table dump running concurrently with a
> check_wx() and the key ending up in the wrong state.

Good spot. I believe static_branch_{inc, dec} should work here. The vmalloc code
only needs to know that someone is traversing the pagetables, and there is no
synchronization needed between check_wx and ptdump. And, static_branch_inc()
should have the same semantics as static_branch_enable().

>
> Either we need an additional lock or perhaps using
> static_branch_{inc,dec}() would work instead? I haven't thought too hard
> about that but it looks like we need _something_.
>
> Will

