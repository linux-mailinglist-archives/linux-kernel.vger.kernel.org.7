Return-Path: <linux-kernel+bounces-860690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 72D65BF0B51
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 13:01:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 654264F252F
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 11:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30137259CB3;
	Mon, 20 Oct 2025 11:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="vKCILETA"
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32171257821
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 11:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760958044; cv=none; b=KOQtZtgnFdUmdzItkkIbHBtOsxsm0gbz5/NquxH5sptHbmw6lwc4A83LJJ4L3ydGlElRogV5eADdZGLSDUOYA2up/y21q2G4x4jUZGgzkXi0ZgrCNtDnDTdqiVZZ8aSiFymVQZAktxYcenrDfBZL3S4IGLPBMM+6cNKuydttfdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760958044; c=relaxed/simple;
	bh=dTxv6HYgb1ZLq67JkWsfuo5X7sQIs7lbyB+Bz24Brcs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tsWlOsAYAdlFfC6PmKKS9gPpEuxWdHPAZEegQcmwcywOrm1VTE+TmqmtYJuB+YNwqIt9EpJuM1TJSgde+/dCeQkCFTvHX2jUlc70q2pSRVdlNXe2mJ49iQwW6q9FpMilH920zIAjPGc48lJgUYkssKPkkYurrYaRlKFAIQEuPvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=vKCILETA; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1760958031; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=I0Rh7vr2r5CUO65seAlIgLtsprqiSEsZXpmW27HKpY8=;
	b=vKCILETAQIAXB2mymeoWIkyPmi6VFBcARRmvQ97utVLqA4cRvQZIegoj8j17XnmBiy6Y9HKCEvYMs/W8PnTdeSX0JvFG5ePY+KUPECGSYo8pkf0GeQwRlhv6zvFFerJb8ejXWI428BKDDzrcfCuF+VZOQt+UvXKFweGEFd0XovI=
Received: from DESKTOP-5N7EMDA(mailfrom:ying.huang@linux.alibaba.com fp:SMTPD_---0WqbBPTq_1760958022 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 20 Oct 2025 19:00:30 +0800
From: "Huang, Ying" <ying.huang@linux.alibaba.com>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>,  Anshuman Khandual
 <anshuman.khandual@arm.com>,  Ryan Roberts <ryan.roberts@arm.com>,  Gavin
 Shan <gshan@redhat.com>,  Ard Biesheuvel <ardb@kernel.org>,  "Matthew
 Wilcox (Oracle)" <willy@infradead.org>,  Yicong Yang
 <yangyicong@hisilicon.com>,  linux-arm-kernel@lists.infradead.org,
  linux-kernel@vger.kernel.org,  linux-mm@kvack.org
Subject: Re: [PATCH] arm64, mm: avoid always making PTE dirty in pte_mkwrite()
In-Reply-To: <aPKFmHg-FrkGJxWd@arm.com> (Catalin Marinas's message of "Fri, 17
	Oct 2025 19:06:16 +0100")
References: <20251015023712.46598-1-ying.huang@linux.alibaba.com>
	<aPKFmHg-FrkGJxWd@arm.com>
Date: Mon, 20 Oct 2025 19:00:20 +0800
Message-ID: <87bjm1g7nf.fsf@DESKTOP-5N7EMDA>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Hi, Catalin,

Catalin Marinas <catalin.marinas@arm.com> writes:

> On Wed, Oct 15, 2025 at 10:37:12AM +0800, Huang Ying wrote:
>> Current pte_mkwrite_novma() makes PTE dirty unconditionally.  This may
>> mark some pages that are never written dirty wrongly.  For example,
>> do_swap_page() may map the exclusive pages with writable and clean PTEs
>> if the VMA is writable and the page fault is for read access.
>> However, current pte_mkwrite_novma() implementation always dirties the
>> PTE.  This may cause unnecessary disk writing if the pages are
>> never written before being reclaimed.
>> 
>> So, change pte_mkwrite_novma() to clear the PTE_RDONLY bit only if the
>> PTE_DIRTY bit is set to make it possible to make the PTE writable and
>> clean.
>> 
>> The current behavior was introduced in commit 73e86cb03cf2 ("arm64:
>> Move PTE_RDONLY bit handling out of set_pte_at()").  Before that,
>> pte_mkwrite() only sets the PTE_WRITE bit, while set_pte_at() only
>> clears the PTE_RDONLY bit if both the PTE_WRITE and the PTE_DIRTY bits
>> are set.
>> 
>> To test the performance impact of the patch, on an arm64 server
>> machine, run 16 redis-server processes on socket 1 and 16
>> memtier_benchmark processes on socket 0 with mostly get
>> transactions (that is, redis-server will mostly read memory only).
>> The memory footprint of redis-server is larger than the available
>> memory, so swap out/in will be triggered.  Test results show that the
>> patch can avoid most swapping out because the pages are mostly clean.
>> And the benchmark throughput improves ~23.9% in the test.
>> 
>> Fixes: 73e86cb03cf2 ("arm64: Move PTE_RDONLY bit handling out of set_pte_at()")
>> Signed-off-by: Huang Ying <ying.huang@linux.alibaba.com>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Will Deacon <will@kernel.org>
>> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
>> Cc: Ryan Roberts <ryan.roberts@arm.com>
>> Cc: Gavin Shan <gshan@redhat.com>
>> Cc: Ard Biesheuvel <ardb@kernel.org>
>> Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
>> Cc: Yicong Yang <yangyicong@hisilicon.com>
>> Cc: linux-arm-kernel@lists.infradead.org
>> Cc: linux-kernel@vger.kernel.org
>> ---
>>  arch/arm64/include/asm/pgtable.h | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>> 
>> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
>> index aa89c2e67ebc..0944e296dd4a 100644
>> --- a/arch/arm64/include/asm/pgtable.h
>> +++ b/arch/arm64/include/asm/pgtable.h
>> @@ -293,7 +293,8 @@ static inline pmd_t set_pmd_bit(pmd_t pmd, pgprot_t prot)
>>  static inline pte_t pte_mkwrite_novma(pte_t pte)
>>  {
>>  	pte = set_pte_bit(pte, __pgprot(PTE_WRITE));
>> -	pte = clear_pte_bit(pte, __pgprot(PTE_RDONLY));
>> +	if (pte_sw_dirty(pte))
>> +		pte = clear_pte_bit(pte, __pgprot(PTE_RDONLY));
>>  	return pte;
>>  }
>
> This seems to be the right thing. I recall years ago I grep'ed
> (obviously not hard enough) and most pte_mkwrite() places had a
> pte_mkdirty(). But I missed do_swap_page() and possibly others.

The do_swap_page() change was introduced in June 2024, quite recently.

> For this patch:
>
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

Thanks!

> I wonder whether we should also add (as a separate patch):
>
> diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
> index 830107b6dd08..df1c552ef11c 100644
> --- a/mm/debug_vm_pgtable.c
> +++ b/mm/debug_vm_pgtable.c
> @@ -101,6 +101,7 @@ static void __init pte_basic_tests(struct pgtable_debug_args *args, int idx)
>  	WARN_ON(pte_dirty(pte_mkclean(pte_mkdirty(pte))));
>  	WARN_ON(pte_write(pte_wrprotect(pte_mkwrite(pte, args->vma))));
>  	WARN_ON(pte_dirty(pte_wrprotect(pte_mkclean(pte))));
> +	WARN_ON(pte_dirty(pte_mkwrite_novma(pte_mkclean(pte))));
>  	WARN_ON(!pte_dirty(pte_wrprotect(pte_mkdirty(pte))));
>  }
>
> For completeness, also (and maybe other combinations):
>
> 	WARN_ON(!pte_write(pte_mkdirty(pte_mkwrite_novma(pte))));

Sure.  Will add another patch for this.

> I cc'ed linux-mm in case we missed anything. If nothing raised, I'll
> queue it next week.

---
Best Regards,
Huang, Ying

