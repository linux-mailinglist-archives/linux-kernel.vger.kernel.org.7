Return-Path: <linux-kernel+bounces-860699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3469BF0B9C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 13:05:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65C763BD53B
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 11:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E5D12D9EEA;
	Mon, 20 Oct 2025 11:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ShBEDogR"
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0243A208D0
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 11:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760958267; cv=none; b=iEyuwNS60ucB3VT9g8yBXzZcf/PmL9E5UmvugcqbRWbKsfvb+hdtgMKcasxYwxlnmK5iJYzOUlHNzy2T5Bk52/Ftw3T4ICDufGc+Fwx0KwxBjvjWrxr9pzBqRfwjBzIUJumSJHHGZ29KhZVR3i//3T1xX44IL3/rpWx2gSo5azU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760958267; c=relaxed/simple;
	bh=QV7p8sfzkEsb5+IlEIEkCLtjJ6qjrXkSmN4PVMNZs6A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LES8A534gnOyjEgLDzWD+Ae6cPQPQjZKWLTm1LetHDNBkey0eu/STiJfsmzUIVuG8io0V03n9tw8SF1ZDi/rYHA/pkRgqigugAIqCToNSs393SFnoFyiJW5I8Od5n7MuXBp2cEIohFW0p5NApTak+xuUMZu1YE5CoilP9uSANFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ShBEDogR; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1760958256; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=b+3d8uC7KF4xfmtSqoZNFp1K71/AwpCYuc/qfKAkSII=;
	b=ShBEDogRtXr47keDPVnfWxb9exupJwTSfUN0BkuPiBO3fIALiddkpCqLxerabBxFZf0nbpK6aci9gDW/l/LkNkJO4Xeln0DNO6x79pf9lbOJRpaqe7iD5GlIWTt2b1uDpfMIcC3WXxa0pZfPOS5IO9/9DXXUWwK8lG3QC/RqCiA=
Received: from DESKTOP-5N7EMDA(mailfrom:ying.huang@linux.alibaba.com fp:SMTPD_---0WqakbIX_1760958255 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 20 Oct 2025 19:04:16 +0800
From: "Huang, Ying" <ying.huang@linux.alibaba.com>
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,  Will Deacon
 <will@kernel.org>,  Ryan Roberts <ryan.roberts@arm.com>,  Gavin Shan
 <gshan@redhat.com>,  Ard Biesheuvel <ardb@kernel.org>,  "Matthew Wilcox
 (Oracle)" <willy@infradead.org>,  Yicong Yang <yangyicong@hisilicon.com>,
  linux-arm-kernel@lists.infradead.org,  linux-kernel@vger.kernel.org,
  linux-mm@kvack.org
Subject: Re: [PATCH] arm64, mm: avoid always making PTE dirty in pte_mkwrite()
In-Reply-To: <0e6d1f1f-a917-4e36-80de-03ba94c6d850@arm.com> (Anshuman
	Khandual's message of "Mon, 20 Oct 2025 07:39:51 +0530")
References: <20251015023712.46598-1-ying.huang@linux.alibaba.com>
	<aPKFmHg-FrkGJxWd@arm.com>
	<0e6d1f1f-a917-4e36-80de-03ba94c6d850@arm.com>
Date: Mon, 20 Oct 2025 19:04:14 +0800
Message-ID: <87o6q1dec1.fsf@DESKTOP-5N7EMDA>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Hi, Anshuman,

Anshuman Khandual <anshuman.khandual@arm.com> writes:

> On 17/10/25 11:36 PM, Catalin Marinas wrote:
>> On Wed, Oct 15, 2025 at 10:37:12AM +0800, Huang Ying wrote:
>>> Current pte_mkwrite_novma() makes PTE dirty unconditionally.  This may
>>> mark some pages that are never written dirty wrongly.  For example,
>>> do_swap_page() may map the exclusive pages with writable and clean PTEs
>>> if the VMA is writable and the page fault is for read access.
>>> However, current pte_mkwrite_novma() implementation always dirties the
>>> PTE.  This may cause unnecessary disk writing if the pages are
>>> never written before being reclaimed.
>>>
>>> So, change pte_mkwrite_novma() to clear the PTE_RDONLY bit only if the
>>> PTE_DIRTY bit is set to make it possible to make the PTE writable and
>>> clean.
>>>
>>> The current behavior was introduced in commit 73e86cb03cf2 ("arm64:
>>> Move PTE_RDONLY bit handling out of set_pte_at()").  Before that,
>>> pte_mkwrite() only sets the PTE_WRITE bit, while set_pte_at() only
>>> clears the PTE_RDONLY bit if both the PTE_WRITE and the PTE_DIRTY bits
>>> are set.
>>>
>>> To test the performance impact of the patch, on an arm64 server
>>> machine, run 16 redis-server processes on socket 1 and 16
>>> memtier_benchmark processes on socket 0 with mostly get
>>> transactions (that is, redis-server will mostly read memory only).
>>> The memory footprint of redis-server is larger than the available
>>> memory, so swap out/in will be triggered.  Test results show that the
>>> patch can avoid most swapping out because the pages are mostly clean.
>>> And the benchmark throughput improves ~23.9% in the test.
>>>
>>> Fixes: 73e86cb03cf2 ("arm64: Move PTE_RDONLY bit handling out of set_pte_at()")
>>> Signed-off-by: Huang Ying <ying.huang@linux.alibaba.com>
>>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>>> Cc: Will Deacon <will@kernel.org>
>>> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
>>> Cc: Ryan Roberts <ryan.roberts@arm.com>
>>> Cc: Gavin Shan <gshan@redhat.com>
>>> Cc: Ard Biesheuvel <ardb@kernel.org>
>>> Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
>>> Cc: Yicong Yang <yangyicong@hisilicon.com>
>>> Cc: linux-arm-kernel@lists.infradead.org
>>> Cc: linux-kernel@vger.kernel.org
>>> ---
>>>  arch/arm64/include/asm/pgtable.h | 3 ++-
>>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
>>> index aa89c2e67ebc..0944e296dd4a 100644
>>> --- a/arch/arm64/include/asm/pgtable.h
>>> +++ b/arch/arm64/include/asm/pgtable.h
>>> @@ -293,7 +293,8 @@ static inline pmd_t set_pmd_bit(pmd_t pmd, pgprot_t prot)
>>>  static inline pte_t pte_mkwrite_novma(pte_t pte)
>>>  {
>>>  	pte = set_pte_bit(pte, __pgprot(PTE_WRITE));
>>> -	pte = clear_pte_bit(pte, __pgprot(PTE_RDONLY));
>>> +	if (pte_sw_dirty(pte))
>>> +		pte = clear_pte_bit(pte, __pgprot(PTE_RDONLY));
>>>  	return pte;
>>>  }
>> 
>> This seems to be the right thing. I recall years ago I grep'ed
>> (obviously not hard enough) and most pte_mkwrite() places had a
>> pte_mkdirty(). But I missed do_swap_page() and possibly others.
>> 
>> For this patch:
>> 
>> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
>> 
>> I wonder whether we should also add (as a separate patch):
>> 
>> diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
>> index 830107b6dd08..df1c552ef11c 100644
>> --- a/mm/debug_vm_pgtable.c
>> +++ b/mm/debug_vm_pgtable.c
>> @@ -101,6 +101,7 @@ static void __init pte_basic_tests(struct pgtable_debug_args *args, int idx)
>>  	WARN_ON(pte_dirty(pte_mkclean(pte_mkdirty(pte))));
>>  	WARN_ON(pte_write(pte_wrprotect(pte_mkwrite(pte, args->vma))));
>>  	WARN_ON(pte_dirty(pte_wrprotect(pte_mkclean(pte))));
>> +	WARN_ON(pte_dirty(pte_mkwrite_novma(pte_mkclean(pte))));
>>  	WARN_ON(!pte_dirty(pte_wrprotect(pte_mkdirty(pte))));
>>  }
>> 
>> For completeness, also (and maybe other combinations):
>> 
>> 	WARN_ON(!pte_write(pte_mkdirty(pte_mkwrite_novma(pte))));
>
> Adding similar tests to pte_wrprotect().
>
> diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
> index 830107b6dd08..573632ebf304 100644
> --- a/mm/debug_vm_pgtable.c
> +++ b/mm/debug_vm_pgtable.c
> @@ -102,6 +102,11 @@ static void __init pte_basic_tests(struct pgtable_debug_args *args, int idx)
>         WARN_ON(pte_write(pte_wrprotect(pte_mkwrite(pte, args->vma))));
>         WARN_ON(pte_dirty(pte_wrprotect(pte_mkclean(pte))));
>         WARN_ON(!pte_dirty(pte_wrprotect(pte_mkdirty(pte))));
> +
> +       WARN_ON(pte_dirty(pte_mkwrite_novma(pte_mkclean(pte))));
> +       WARN_ON(!pte_write(pte_mkdirty(pte_mkwrite_novma(pte))));
> +       WARN_ON(!pte_write(pte_mkwrite_novma(pte_wrprotect(pte))));
> +       WARN_ON(pte_write(pte_wrprotect(pte_mkwrite_novma(pte))));
>  }
>
>  static void __init pte_advanced_tests(struct pgtable_debug_args *args)
> @@ -195,6 +200,9 @@ static void __init pmd_basic_tests(struct pgtable_debug_args *args, int idx)
>         WARN_ON(pmd_write(pmd_wrprotect(pmd_mkwrite(pmd, args->vma))));
>         WARN_ON(pmd_dirty(pmd_wrprotect(pmd_mkclean(pmd))));
>         WARN_ON(!pmd_dirty(pmd_wrprotect(pmd_mkdirty(pmd))));
> +
> +       WARN_ON(!pmd_write(pmd_mkwrite_novma(pmd_wrprotect(pmd))));
> +       WARN_ON(pmd_write(pmd_wrprotect(pmd_mkwrite_novma(pmd))));
>         /*
>          * A huge page does not point to next level page table
>          * entry. Hence this must qualify as pmd_bad().

Thanks!

I can add a patch for these tests.  Or, do you want to work on it?

>> 
>> I cc'ed linux-mm in case we missed anything. If nothing raised, I'll
>> queue it next week.

---
Best Regards,
Huang, Ying

