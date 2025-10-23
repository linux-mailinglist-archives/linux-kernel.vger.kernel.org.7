Return-Path: <linux-kernel+bounces-866763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BD6BDC00966
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 12:55:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B1DD1A08579
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 10:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76C7330BB97;
	Thu, 23 Oct 2025 10:54:47 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2BDC2D9ECD
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 10:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761216886; cv=none; b=S8vlFcTTs7n0U3BOStqTmUoh66oFX/FDKfdf0FAq/IJ+gKjuX3PV9m8Tfgf8NJ0DVwaldbSzDiVhu7UetSjDOmmKkVko97VT5lIhaXVHcKWpwk9x/EJDTSMi9A4wXgHxgxI+L+JI0sGjV10sEg+gKFJ/Cn9zSB5ZPUxXPlEy99c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761216886; c=relaxed/simple;
	bh=NkcPDzz6PRUjrMF/BwtUvta0I0A69Hkq2wRbQUHTNM4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UyUfxjh5ypE41IfX64lz31oII5T3/a4QdlG40PVfdXLr1R9lqssfjzrtYfG37Bez+xOG19vQen58WdEUJBgmK9uKHi7EQSS1TpSwLktEH03B50sQ0omx40Z/EYBOFNZdTv4HJyFbV1yEdv1d2pMBYgFEVIx8bz8p2SV3srrJmvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CA4891516;
	Thu, 23 Oct 2025 03:54:34 -0700 (PDT)
Received: from [10.1.31.176] (XHFQ2J9959.cambridge.arm.com [10.1.31.176])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C02393F63F;
	Thu, 23 Oct 2025 03:54:39 -0700 (PDT)
Message-ID: <fb633059-9b5b-49ea-848a-7537bb13559d@arm.com>
Date: Thu, 23 Oct 2025 11:54:38 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -v3 2/2] arm64, tlbflush: don't TLBI broadcast if page
 reused in write fault
Content-Language: en-GB
To: Huang Ying <ying.huang@linux.alibaba.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Zi Yan <ziy@nvidia.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Yang Shi <yang@os.amperecomputing.com>,
 "Christoph Lameter (Ampere)" <cl@gentwo.org>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Anshuman Khandual
 <anshuman.khandual@arm.com>, Kefeng Wang <wangkefeng.wang@huawei.com>,
 Kevin Brodsky <kevin.brodsky@arm.com>,
 Yin Fengwei <fengwei_yin@linux.alibaba.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
References: <20251023013524.100517-1-ying.huang@linux.alibaba.com>
 <20251023013524.100517-3-ying.huang@linux.alibaba.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20251023013524.100517-3-ying.huang@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 23/10/2025 02:35, Huang Ying wrote:
> A multi-thread customer workload with large memory footprint uses
> fork()/exec() to run some external programs every tens seconds.  When
> running the workload on an arm64 server machine, it's observed that
> quite some CPU cycles are spent in the TLB flushing functions.  While
> running the workload on the x86_64 server machine, it's not.  This
> causes the performance on arm64 to be much worse than that on x86_64.
> 
> During the workload running, after fork()/exec() write-protects all
> pages in the parent process, memory writing in the parent process
> will cause a write protection fault.  Then the page fault handler
> will make the PTE/PDE writable if the page can be reused, which is
> almost always true in the workload.  On arm64, to avoid the write
> protection fault on other CPUs, the page fault handler flushes the TLB
> globally with TLBI broadcast after changing the PTE/PDE.  However, this
> isn't always necessary.  Firstly, it's safe to leave some stale
> read-only TLB entries as long as they will be flushed finally.
> Secondly, it's quite possible that the original read-only PTE/PDEs
> aren't cached in remote TLB at all if the memory footprint is large.
> In fact, on x86_64, the page fault handler doesn't flush the remote
> TLB in this situation, which benefits the performance a lot.
> 
> To improve the performance on arm64, make the write protection fault
> handler flush the TLB locally instead of globally via TLBI broadcast
> after making the PTE/PDE writable.  If there are stale read-only TLB
> entries in the remote CPUs, the page fault handler on these CPUs will
> regard the page fault as spurious and flush the stale TLB entries.
> 
> To test the patchset, make the usemem.c from
> vm-scalability (https://git.kernel.org/pub/scm/linux/kernel/git/wfg/vm-scalability.git).
> support calling fork()/exec() periodically.  To mimic the behavior of
> the customer workload, run usemem with 4 threads, access 100GB memory,
> and call fork()/exec() every 40 seconds.  Test results show that with
> the patchset the score of usemem improves ~40.6%.  The cycles% of TLB
> flush functions reduces from ~50.5% to ~0.3% in perf profile.

LGTM:

Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>

> 
> Signed-off-by: Huang Ying <ying.huang@linux.alibaba.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Zi Yan <ziy@nvidia.com>
> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
> Cc: Ryan Roberts <ryan.roberts@arm.com>
> Cc: Yang Shi <yang@os.amperecomputing.com>
> Cc: "Christoph Lameter (Ampere)" <cl@gentwo.org>
> Cc: Dev Jain <dev.jain@arm.com>
> Cc: Barry Song <baohua@kernel.org>
> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
> Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
> Cc: Kevin Brodsky <kevin.brodsky@arm.com>
> Cc: Yin Fengwei <fengwei_yin@linux.alibaba.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-mm@kvack.org
> ---
>  arch/arm64/include/asm/pgtable.h  | 14 +++++---
>  arch/arm64/include/asm/tlbflush.h | 56 +++++++++++++++++++++++++++++++
>  arch/arm64/mm/contpte.c           |  3 +-
>  arch/arm64/mm/fault.c             |  2 +-
>  4 files changed, 67 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> index aa89c2e67ebc..25b3c31edb6c 100644
> --- a/arch/arm64/include/asm/pgtable.h
> +++ b/arch/arm64/include/asm/pgtable.h
> @@ -130,12 +130,16 @@ static inline void arch_leave_lazy_mmu_mode(void)
>  #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
>  
>  /*
> - * Outside of a few very special situations (e.g. hibernation), we always
> - * use broadcast TLB invalidation instructions, therefore a spurious page
> - * fault on one CPU which has been handled concurrently by another CPU
> - * does not need to perform additional invalidation.
> + * We use local TLB invalidation instruction when reusing page in
> + * write protection fault handler to avoid TLBI broadcast in the hot
> + * path.  This will cause spurious page faults if stale read-only TLB
> + * entries exist.
>   */
> -#define flush_tlb_fix_spurious_fault(vma, address, ptep) do { } while (0)
> +#define flush_tlb_fix_spurious_fault(vma, address, ptep)	\
> +	local_flush_tlb_page_nonotify(vma, address)
> +
> +#define flush_tlb_fix_spurious_fault_pmd(vma, address, pmdp)	\
> +	local_flush_tlb_page_nonotify(vma, address)
>  
>  /*
>   * ZERO_PAGE is a global shared page that is always zero: used
> diff --git a/arch/arm64/include/asm/tlbflush.h b/arch/arm64/include/asm/tlbflush.h
> index 18a5dc0c9a54..5c8f88fa5e40 100644
> --- a/arch/arm64/include/asm/tlbflush.h
> +++ b/arch/arm64/include/asm/tlbflush.h
> @@ -249,6 +249,19 @@ static inline unsigned long get_trans_granule(void)
>   *		cannot be easily determined, the value TLBI_TTL_UNKNOWN will
>   *		perform a non-hinted invalidation.
>   *
> + *	local_flush_tlb_page(vma, addr)
> + *		Local variant of flush_tlb_page().  Stale TLB entries may
> + *		remain in remote CPUs.
> + *
> + *	local_flush_tlb_page_nonotify(vma, addr)
> + *		Same as local_flush_tlb_page() except MMU notifier will not be
> + *		called.
> + *
> + *	local_flush_tlb_contpte(vma, addr)
> + *		Invalidate the virtual-address range
> + *		'[addr, addr+CONT_PTE_SIZE)' mapped with contpte on local CPU
> + *		for the user address space corresponding to 'vma->mm'.  Stale
> + *		TLB entries may remain in remote CPUs.
>   *
>   *	Finally, take a look at asm/tlb.h to see how tlb_flush() is implemented
>   *	on top of these routines, since that is our interface to the mmu_gather
> @@ -282,6 +295,33 @@ static inline void flush_tlb_mm(struct mm_struct *mm)
>  	mmu_notifier_arch_invalidate_secondary_tlbs(mm, 0, -1UL);
>  }
>  
> +static inline void __local_flush_tlb_page_nonotify_nosync(
> +	struct mm_struct *mm, unsigned long uaddr)
> +{
> +	unsigned long addr;
> +
> +	dsb(nshst);
> +	addr = __TLBI_VADDR(uaddr, ASID(mm));
> +	__tlbi(vale1, addr);
> +	__tlbi_user(vale1, addr);
> +}
> +
> +static inline void local_flush_tlb_page_nonotify(
> +	struct vm_area_struct *vma, unsigned long uaddr)
> +{
> +	__local_flush_tlb_page_nonotify_nosync(vma->vm_mm, uaddr);
> +	dsb(nsh);
> +}
> +
> +static inline void local_flush_tlb_page(struct vm_area_struct *vma,
> +					unsigned long uaddr)
> +{
> +	__local_flush_tlb_page_nonotify_nosync(vma->vm_mm, uaddr);
> +	mmu_notifier_arch_invalidate_secondary_tlbs(vma->vm_mm, uaddr & PAGE_MASK,
> +						(uaddr & PAGE_MASK) + PAGE_SIZE);
> +	dsb(nsh);
> +}
> +
>  static inline void __flush_tlb_page_nosync(struct mm_struct *mm,
>  					   unsigned long uaddr)
>  {
> @@ -472,6 +512,22 @@ static inline void __flush_tlb_range(struct vm_area_struct *vma,
>  	dsb(ish);
>  }
>  
> +static inline void local_flush_tlb_contpte(struct vm_area_struct *vma,
> +					   unsigned long addr)
> +{
> +	unsigned long asid;
> +
> +	addr = round_down(addr, CONT_PTE_SIZE);
> +
> +	dsb(nshst);
> +	asid = ASID(vma->vm_mm);
> +	__flush_tlb_range_op(vale1, addr, CONT_PTES, PAGE_SIZE, asid,
> +			     3, true, lpa2_is_enabled());
> +	mmu_notifier_arch_invalidate_secondary_tlbs(vma->vm_mm, addr,
> +						    addr + CONT_PTE_SIZE);
> +	dsb(nsh);
> +}
> +
>  static inline void flush_tlb_range(struct vm_area_struct *vma,
>  				   unsigned long start, unsigned long end)
>  {
> diff --git a/arch/arm64/mm/contpte.c b/arch/arm64/mm/contpte.c
> index c0557945939c..589bcf878938 100644
> --- a/arch/arm64/mm/contpte.c
> +++ b/arch/arm64/mm/contpte.c
> @@ -622,8 +622,7 @@ int contpte_ptep_set_access_flags(struct vm_area_struct *vma,
>  			__ptep_set_access_flags(vma, addr, ptep, entry, 0);
>  
>  		if (dirty)
> -			__flush_tlb_range(vma, start_addr, addr,
> -							PAGE_SIZE, true, 3);
> +			local_flush_tlb_contpte(vma, start_addr);
>  	} else {
>  		__contpte_try_unfold(vma->vm_mm, addr, ptep, orig_pte);
>  		__ptep_set_access_flags(vma, addr, ptep, entry, dirty);
> diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
> index d816ff44faff..22f54f5afe3f 100644
> --- a/arch/arm64/mm/fault.c
> +++ b/arch/arm64/mm/fault.c
> @@ -235,7 +235,7 @@ int __ptep_set_access_flags(struct vm_area_struct *vma,
>  
>  	/* Invalidate a stale read-only entry */
>  	if (dirty)
> -		flush_tlb_page(vma, address);
> +		local_flush_tlb_page(vma, address);
>  	return 1;
>  }
>  


