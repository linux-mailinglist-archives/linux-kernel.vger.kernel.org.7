Return-Path: <linux-kernel+bounces-757423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB0CDB1C1F1
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 10:15:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 333707205B0
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 08:15:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6463321859A;
	Wed,  6 Aug 2025 08:15:37 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 208C91FB3
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 08:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754468136; cv=none; b=q5Gpis6leAOYhf9/oiq01nz+U2jtjnAB51wtgNgyBE5uRROwD/k09zo4jpElhZzHPbPZql3jV4fEzROZ/dQMexkeso1KOTbzblmOeDWsuHFvP0AsbWisI7RzyLc+waWJFuUPJGE1978CcRj76XFvE94iEbvUgfshMviOrMuvXv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754468136; c=relaxed/simple;
	bh=WJ7sgvWbPtgeYzb3QXQ/fRdZfUeyBUia98xuZGI5y4A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mtOEvEmiN2Q3KmakZjmf7Yzoe3/vbKUJ3VnY68yzJaEFzhcrSgKIXxHYS61d7BtX/JzPLffyvXmo6lAYSM1ppbD5q/BVoCKJgSsnJut5gmNPBS5PW5PuRvf2HQITQeESwrU+iUIQ11J0MZ+cuPzx63zSAsBTneCt89U3Li5RO9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 426D81756;
	Wed,  6 Aug 2025 01:15:25 -0700 (PDT)
Received: from [10.57.88.107] (unknown [10.57.88.107])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9FBFA3F5A1;
	Wed,  6 Aug 2025 01:15:30 -0700 (PDT)
Message-ID: <ea41f07b-a758-4944-8b80-37b3f20032c2@arm.com>
Date: Wed, 6 Aug 2025 09:15:29 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v6 4/4] arm64: mm: split linear mapping if BBML2
 unsupported on secondary CPUs
Content-Language: en-GB
To: Yang Shi <yang@os.amperecomputing.com>, will@kernel.org,
 catalin.marinas@arm.com, akpm@linux-foundation.org, Miko.Lenczewski@arm.com,
 dev.jain@arm.com, scott@os.amperecomputing.com, cl@gentwo.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250805081350.3854670-1-ryan.roberts@arm.com>
 <20250805081350.3854670-5-ryan.roberts@arm.com>
 <6d32bdf5-ccde-4779-a2df-08b6859dbf8e@os.amperecomputing.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <6d32bdf5-ccde-4779-a2df-08b6859dbf8e@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 05/08/2025 19:14, Yang Shi wrote:
> 
> 
> On 8/5/25 1:13 AM, Ryan Roberts wrote:
>> From: Yang Shi <yang@os.amperecomputing.com>
>>
>> The kernel linear mapping is painted in very early stage of system boot.
>> The cpufeature has not been finalized yet at this point. So the linear
>> mapping is determined by the capability of boot CPU only.  If the boot
>> CPU supports BBML2, large block mappings will be used for linear
>> mapping.
>>
>> But the secondary CPUs may not support BBML2, so repaint the linear
>> mapping if large block mapping is used and the secondary CPUs don't
>> support BBML2 once cpufeature is finalized on all CPUs.
>>
>> If the boot CPU doesn't support BBML2 or the secondary CPUs have the
>> same BBML2 capability with the boot CPU, repainting the linear mapping
>> is not needed.
>>
>> Repainting is implemented by the boot CPU, which we know supports BBML2,
>> so it is safe for the live mapping size to change for this CPU. The
>> linear map region is walked using the pagewalk API and any discovered
>> large leaf mappings are split to pte mappings using the existing helper
>> functions. Since the repainting is performed inside of a stop_machine(),
>> we must use GFP_ATOMIC to allocate the extra intermediate pgtables. But
>> since we are still early in boot, it is expected that there is plenty of
>> memory available so we will never need to sleep for reclaim, and so
>> GFP_ATOMIC is acceptable here.
>>
>> The secondary CPUs are all put into a waiting area with the idmap in
>> TTBR0 and reserved map in TTBR1 while this is performed since they
>> cannot be allowed to observe any size changes on the live mappings.
>>
>> Co-developed-by: Ryan Roberts <ryan.roberts@arm.com>
>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>> Signed-off-by: Yang Shi <yang@os.amperecomputing.com>
>> ---
>>   arch/arm64/include/asm/mmu.h   |   3 +
>>   arch/arm64/kernel/cpufeature.c |   8 ++
>>   arch/arm64/mm/mmu.c            | 151 ++++++++++++++++++++++++++++++---
>>   arch/arm64/mm/proc.S           |  25 +++++-
>>   4 files changed, 172 insertions(+), 15 deletions(-)
>>
>> diff --git a/arch/arm64/include/asm/mmu.h b/arch/arm64/include/asm/mmu.h
>> index 98565b1b93e8..966c08fd8126 100644
>> --- a/arch/arm64/include/asm/mmu.h
>> +++ b/arch/arm64/include/asm/mmu.h
>> @@ -56,6 +56,8 @@ typedef struct {
>>    */
>>   #define ASID(mm)    (atomic64_read(&(mm)->context.id) & 0xffff)
>>   +extern bool linear_map_requires_bbml2;
>> +
>>   static inline bool arm64_kernel_unmapped_at_el0(void)
>>   {
>>       return alternative_has_cap_unlikely(ARM64_UNMAP_KERNEL_AT_EL0);
>> @@ -72,6 +74,7 @@ extern void create_pgd_mapping(struct mm_struct *mm,
>> phys_addr_t phys,
>>   extern void *fixmap_remap_fdt(phys_addr_t dt_phys, int *size, pgprot_t prot);
>>   extern void mark_linear_text_alias_ro(void);
>>   extern int split_kernel_leaf_mapping(unsigned long addr);
>> +extern int linear_map_split_to_ptes(void *__unused);
>>     /*
>>    * This check is triggered during the early boot before the cpufeature
>> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
>> index f28f056087f3..11392c741e48 100644
>> --- a/arch/arm64/kernel/cpufeature.c
>> +++ b/arch/arm64/kernel/cpufeature.c
>> @@ -85,6 +85,7 @@
>>   #include <asm/insn.h>
>>   #include <asm/kvm_host.h>
>>   #include <asm/mmu_context.h>
>> +#include <asm/mmu.h>
>>   #include <asm/mte.h>
>>   #include <asm/hypervisor.h>
>>   #include <asm/processor.h>
>> @@ -2013,6 +2014,12 @@ static int __init __kpti_install_ng_mappings(void
>> *__unused)
>>       return 0;
>>   }
>>   +static void __init linear_map_maybe_split_to_ptes(void)
>> +{
>> +    if (linear_map_requires_bbml2 && !system_supports_bbml2_noabort())
>> +        stop_machine(linear_map_split_to_ptes, NULL, cpu_online_mask);
>> +}
>> +
>>   static void __init kpti_install_ng_mappings(void)
>>   {
>>       /* Check whether KPTI is going to be used */
>> @@ -3930,6 +3937,7 @@ void __init setup_system_features(void)
>>   {
>>       setup_system_capabilities();
>>   +    linear_map_maybe_split_to_ptes();
>>       kpti_install_ng_mappings();
>>         sve_setup();
>> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
>> index f6cd79287024..5b5a84b34024 100644
>> --- a/arch/arm64/mm/mmu.c
>> +++ b/arch/arm64/mm/mmu.c
>> @@ -27,6 +27,7 @@
>>   #include <linux/kfence.h>
>>   #include <linux/pkeys.h>
>>   #include <linux/mm_inline.h>
>> +#include <linux/pagewalk.h>
>>     #include <asm/barrier.h>
>>   #include <asm/cputype.h>
>> @@ -483,11 +484,11 @@ void create_kpti_ng_temp_pgd(pgd_t *pgdir, phys_addr_t
>> phys, unsigned long virt,
>>     #define INVALID_PHYS_ADDR    -1
>>   -static phys_addr_t __pgd_pgtable_alloc(struct mm_struct *mm,
>> +static phys_addr_t __pgd_pgtable_alloc(struct mm_struct *mm, gfp_t gfp,
>>                          enum pgtable_type pgtable_type)
>>   {
>>       /* Page is zeroed by init_clear_pgtable() so don't duplicate effort. */
>> -    struct ptdesc *ptdesc = pagetable_alloc(GFP_PGTABLE_KERNEL & ~__GFP_ZERO,
>> 0);
>> +    struct ptdesc *ptdesc = pagetable_alloc(gfp & ~__GFP_ZERO, 0);
>>       phys_addr_t pa;
>>         if (!ptdesc)
>> @@ -514,9 +515,9 @@ static phys_addr_t __pgd_pgtable_alloc(struct mm_struct *mm,
>>   }
>>     static phys_addr_t
>> -try_pgd_pgtable_alloc_init_mm(enum pgtable_type pgtable_type)
>> +try_pgd_pgtable_alloc_init_mm(enum pgtable_type pgtable_type, gfp_t gfp)
>>   {
>> -    return __pgd_pgtable_alloc(&init_mm, pgtable_type);
>> +    return __pgd_pgtable_alloc(&init_mm, gfp, pgtable_type);
>>   }
>>     static phys_addr_t __maybe_unused
>> @@ -524,7 +525,7 @@ pgd_pgtable_alloc_init_mm(enum pgtable_type pgtable_type)
>>   {
>>       phys_addr_t pa;
>>   -    pa = __pgd_pgtable_alloc(&init_mm, pgtable_type);
>> +    pa = __pgd_pgtable_alloc(&init_mm, GFP_PGTABLE_KERNEL, pgtable_type);
>>       BUG_ON(pa == INVALID_PHYS_ADDR);
>>       return pa;
>>   }
>> @@ -534,7 +535,7 @@ pgd_pgtable_alloc_special_mm(enum pgtable_type pgtable_type)
>>   {
>>       phys_addr_t pa;
>>   -    pa = __pgd_pgtable_alloc(NULL, pgtable_type);
>> +    pa = __pgd_pgtable_alloc(NULL, GFP_PGTABLE_KERNEL, pgtable_type);
>>       BUG_ON(pa == INVALID_PHYS_ADDR);
>>       return pa;
>>   }
>> @@ -548,7 +549,7 @@ static void split_contpte(pte_t *ptep)
>>           __set_pte(ptep, pte_mknoncont(__ptep_get(ptep)));
>>   }
>>   -static int split_pmd(pmd_t *pmdp, pmd_t pmd)
>> +static int split_pmd(pmd_t *pmdp, pmd_t pmd, gfp_t gfp)
>>   {
>>       pmdval_t tableprot = PMD_TYPE_TABLE | PMD_TABLE_UXN | PMD_TABLE_AF;
>>       unsigned long pfn = pmd_pfn(pmd);
>> @@ -557,7 +558,7 @@ static int split_pmd(pmd_t *pmdp, pmd_t pmd)
>>       pte_t *ptep;
>>       int i;
>>   -    pte_phys = try_pgd_pgtable_alloc_init_mm(TABLE_PTE);
>> +    pte_phys = try_pgd_pgtable_alloc_init_mm(TABLE_PTE, gfp);
>>       if (pte_phys == INVALID_PHYS_ADDR)
>>           return -ENOMEM;
>>       ptep = (pte_t *)phys_to_virt(pte_phys);
>> @@ -590,7 +591,7 @@ static void split_contpmd(pmd_t *pmdp)
>>           set_pmd(pmdp, pmd_mknoncont(pmdp_get(pmdp)));
>>   }
>>   -static int split_pud(pud_t *pudp, pud_t pud)
>> +static int split_pud(pud_t *pudp, pud_t pud, gfp_t gfp)
>>   {
>>       pudval_t tableprot = PUD_TYPE_TABLE | PUD_TABLE_UXN | PUD_TABLE_AF;
>>       unsigned int step = PMD_SIZE >> PAGE_SHIFT;
>> @@ -600,7 +601,7 @@ static int split_pud(pud_t *pudp, pud_t pud)
>>       pmd_t *pmdp;
>>       int i;
>>   -    pmd_phys = try_pgd_pgtable_alloc_init_mm(TABLE_PMD);
>> +    pmd_phys = try_pgd_pgtable_alloc_init_mm(TABLE_PMD, gfp);
>>       if (pmd_phys == INVALID_PHYS_ADDR)
>>           return -ENOMEM;
>>       pmdp = (pmd_t *)phys_to_virt(pmd_phys);
>> @@ -688,7 +689,7 @@ int split_kernel_leaf_mapping(unsigned long addr)
>>       if (!pud_present(pud))
>>           goto out;
>>       if (pud_leaf(pud)) {
>> -        ret = split_pud(pudp, pud);
>> +        ret = split_pud(pudp, pud, GFP_PGTABLE_KERNEL);
>>           if (ret)
>>               goto out;
>>       }
>> @@ -713,7 +714,7 @@ int split_kernel_leaf_mapping(unsigned long addr)
>>            */
>>           if (ALIGN_DOWN(addr, PMD_SIZE) == addr)
>>               goto out;
>> -        ret = split_pmd(pmdp, pmd);
>> +        ret = split_pmd(pmdp, pmd, GFP_PGTABLE_KERNEL);
>>           if (ret)
>>               goto out;
>>       }
>> @@ -738,6 +739,112 @@ int split_kernel_leaf_mapping(unsigned long addr)
>>       return ret;
>>   }
>>   +static int split_to_ptes_pud_entry(pud_t *pudp, unsigned long addr,
>> +                   unsigned long next, struct mm_walk *walk)
>> +{
>> +    pud_t pud = pudp_get(pudp);
>> +    int ret = 0;
>> +
>> +    if (pud_leaf(pud))
>> +        ret = split_pud(pudp, pud, GFP_ATOMIC);
>> +
>> +    return ret;
>> +}
>> +
>> +static int split_to_ptes_pmd_entry(pmd_t *pmdp, unsigned long addr,
>> +                   unsigned long next, struct mm_walk *walk)
>> +{
>> +    pmd_t pmd = pmdp_get(pmdp);
>> +    int ret = 0;
>> +
>> +    if (pmd_leaf(pmd)) {
>> +        if (pmd_cont(pmd))
>> +            split_contpmd(pmdp);
>> +        ret = split_pmd(pmdp, pmd, GFP_ATOMIC);
>> +    }
>> +
>> +    return ret;
>> +}
>> +
>> +static int split_to_ptes_pte_entry(pte_t *ptep, unsigned long addr,
>> +                   unsigned long next, struct mm_walk *walk)
>> +{
>> +    pte_t pte = __ptep_get(ptep);
>> +
>> +    if (pte_cont(pte))
>> +        split_contpte(ptep);
>> +
>> +    return 0;
>> +}
> 
> IIUC pgtable walker API walks the page table PTE by PTE, so it means the split
> function is called on every PTE even though it has been split. This is not very
> efficient. But it may be ok since repainting is just called once at boot time.

Good point. I think this could be improved, while continuing to use the walker API.

Currently I'm splitting leaf puds to cont-pmds, then cont-pmds to pmds, then
pmds to cont-ptes then cont-ptes to ptes. And we therefore need to visit each
pte (or technically 1 in 16 ptes) to check if they are cont-mapped. I did it
this way to reuse the existing split logic without modification.

But we could provide a flag to the split logic to tell it to "bypass split to
cont-pte" so that we then have puds to cont-pmds, cont-pmds to pmds and pmds to
ptes. And in that final case we can avoid walking any ptes that we already split
from pmds because we know they can't be cont-mapped. We can do that with
ACTION_CONTINUE when returning from the pmd handler. We would still visit every
pte that was already mapped at pte level because we would still need to check
for cont-pte. The API doesn't provide a way for us to skip forward by 16 ptes at
a time.

Something like this, perhaps:

---8<---
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 5b5a84b34024..f0066ecbe6b2 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -549,7 +549,7 @@ static void split_contpte(pte_t *ptep)
 		__set_pte(ptep, pte_mknoncont(__ptep_get(ptep)));
 }

-static int split_pmd(pmd_t *pmdp, pmd_t pmd, gfp_t gfp)
+static int split_pmd(pmd_t *pmdp, pmd_t pmd, gfp_t gfp, bool to_cont_pte)
 {
 	pmdval_t tableprot = PMD_TYPE_TABLE | PMD_TABLE_UXN | PMD_TABLE_AF;
 	unsigned long pfn = pmd_pfn(pmd);
@@ -567,7 +567,8 @@ static int split_pmd(pmd_t *pmdp, pmd_t pmd, gfp_t gfp)
 		tableprot |= PMD_TABLE_PXN;

 	prot = __pgprot((pgprot_val(prot) & ~PTE_TYPE_MASK) | PTE_TYPE_PAGE);
-	prot = __pgprot(pgprot_val(prot) | PTE_CONT);
+	if (to_cont_pte)
+		prot = __pgprot(pgprot_val(prot) | PTE_CONT);

 	for (i = 0; i < PTRS_PER_PTE; i++, ptep++, pfn++)
 		__set_pte(ptep, pfn_pte(pfn, prot));
@@ -714,7 +715,7 @@ int split_kernel_leaf_mapping(unsigned long addr)
 		 */
 		if (ALIGN_DOWN(addr, PMD_SIZE) == addr)
 			goto out;
-		ret = split_pmd(pmdp, pmd, GFP_PGTABLE_KERNEL);
+		ret = split_pmd(pmdp, pmd, GFP_PGTABLE_KERNEL, true);
 		if (ret)
 			goto out;
 	}
@@ -760,7 +761,8 @@ static int split_to_ptes_pmd_entry(pmd_t *pmdp, unsigned
long addr,
 	if (pmd_leaf(pmd)) {
 		if (pmd_cont(pmd))
 			split_contpmd(pmdp);
-		ret = split_pmd(pmdp, pmd, GFP_ATOMIC);
+		ret = split_pmd(pmdp, pmd, GFP_ATOMIC, false);
+		walk->action = ACTION_CONTINUE;
 	}

 	return ret;
---8<---

Thanks,
Ryan


> 
> Thanks,
> Yang
> 
>> +
>> +static const struct mm_walk_ops split_to_ptes_ops = {
>> +    .pud_entry    = split_to_ptes_pud_entry,
>> +    .pmd_entry    = split_to_ptes_pmd_entry,
>> +    .pte_entry    = split_to_ptes_pte_entry,
>> +};
>> +
>> +extern u32 repaint_done;
>> +
>> +int __init linear_map_split_to_ptes(void *__unused)
>> +{
>> +    /*
>> +     * Repainting the linear map must be done by CPU0 (the boot CPU) because
>> +     * that's the only CPU that we know supports BBML2. The other CPUs will
>> +     * be held in a waiting area with the idmap active.
>> +     */
>> +    if (!smp_processor_id()) {
>> +        unsigned long lstart = _PAGE_OFFSET(vabits_actual);
>> +        unsigned long lend = PAGE_END;
>> +        unsigned long kstart = (unsigned long)lm_alias(_stext);
>> +        unsigned long kend = (unsigned long)lm_alias(__init_begin);
>> +        int ret;
>> +
>> +        /*
>> +         * Wait for all secondary CPUs to be put into the waiting area.
>> +         */
>> +        smp_cond_load_acquire(&repaint_done, VAL == num_online_cpus());
>> +
>> +        /*
>> +         * Walk all of the linear map [lstart, lend), except the kernel
>> +         * linear map alias [kstart, kend), and split all mappings to
>> +         * PTE. The kernel alias remains static throughout runtime so
>> +         * can continue to be safely mapped with large mappings.
>> +         */
>> +        ret = walk_kernel_page_table_range_lockless(lstart, kstart,
>> +                        &split_to_ptes_ops, NULL);
>> +        if (!ret)
>> +            ret = walk_kernel_page_table_range_lockless(kend, lend,
>> +                        &split_to_ptes_ops, NULL);
>> +        if (ret)
>> +            panic("Failed to split linear map\n");
>> +        flush_tlb_kernel_range(lstart, lend);
>> +
>> +        /*
>> +         * Relies on dsb in flush_tlb_kernel_range() to avoid reordering
>> +         * before any page table split operations.
>> +         */
>> +        WRITE_ONCE(repaint_done, 0);
>> +    } else {
>> +        typedef void (repaint_wait_fn)(void);
>> +        extern repaint_wait_fn bbml2_wait_for_repainting;
>> +        repaint_wait_fn *wait_fn;
>> +
>> +        wait_fn = (void *)__pa_symbol(bbml2_wait_for_repainting);
>> +
>> +        /*
>> +         * At least one secondary CPU doesn't support BBML2 so cannot
>> +         * tolerate the size of the live mappings changing. So have the
>> +         * secondary CPUs wait for the boot CPU to make the changes
>> +         * with the idmap active and init_mm inactive.
>> +         */
>> +        cpu_install_idmap();
>> +        wait_fn();
>> +        cpu_uninstall_idmap();
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>>   /*
>>    * This function can only be used to modify existing table entries,
>>    * without allocating new levels of table. Note that this permits the
>> @@ -857,6 +964,8 @@ static inline void arm64_kfence_map_pool(phys_addr_t
>> kfence_pool, pgd_t *pgdp) {
>>     #endif /* CONFIG_KFENCE */
>>   +bool linear_map_requires_bbml2;
>> +
>>   static inline bool force_pte_mapping(void)
>>   {
>>       bool bbml2 = system_capabilities_finalized() ?
>> @@ -892,6 +1001,8 @@ static void __init map_mem(pgd_t *pgdp)
>>         early_kfence_pool = arm64_kfence_alloc_pool();
>>   +    linear_map_requires_bbml2 = !force_pte_mapping() && can_set_direct_map();
>> +
>>       if (force_pte_mapping())
>>           flags |= NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS;
>>   @@ -1025,7 +1136,8 @@ void __pi_map_range(u64 *pgd, u64 start, u64 end, u64
>> pa, pgprot_t prot,
>>               int level, pte_t *tbl, bool may_use_cont, u64 va_offset);
>>     static u8 idmap_ptes[IDMAP_LEVELS - 1][PAGE_SIZE] __aligned(PAGE_SIZE)
>> __ro_after_init,
>> -      kpti_ptes[IDMAP_LEVELS - 1][PAGE_SIZE] __aligned(PAGE_SIZE)
>> __ro_after_init;
>> +      kpti_ptes[IDMAP_LEVELS - 1][PAGE_SIZE] __aligned(PAGE_SIZE)
>> __ro_after_init,
>> +      bbml2_ptes[IDMAP_LEVELS - 1][PAGE_SIZE] __aligned(PAGE_SIZE)
>> __ro_after_init;
>>     static void __init create_idmap(void)
>>   {
>> @@ -1050,6 +1162,19 @@ static void __init create_idmap(void)
>>                      IDMAP_ROOT_LEVEL, (pte_t *)idmap_pg_dir, false,
>>                      __phys_to_virt(ptep) - ptep);
>>       }
>> +
>> +    /*
>> +     * Setup idmap mapping for repaint_done flag.  It will be used if
>> +     * repainting the linear mapping is needed later.
>> +     */
>> +    if (linear_map_requires_bbml2) {
>> +        u64 pa = __pa_symbol(&repaint_done);
>> +
>> +        ptep = __pa_symbol(bbml2_ptes);
>> +        __pi_map_range(&ptep, pa, pa + sizeof(u32), pa, PAGE_KERNEL,
>> +                   IDMAP_ROOT_LEVEL, (pte_t *)idmap_pg_dir, false,
>> +                   __phys_to_virt(ptep) - ptep);
>> +    }
>>   }
>>     void __init paging_init(void)
>> diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
>> index 8c75965afc9e..dbaac2e824d7 100644
>> --- a/arch/arm64/mm/proc.S
>> +++ b/arch/arm64/mm/proc.S
>> @@ -416,7 +416,29 @@ alternative_else_nop_endif
>>   __idmap_kpti_secondary:
>>       /* Uninstall swapper before surgery begins */
>>       __idmap_cpu_set_reserved_ttbr1 x16, x17
>> +    b scondary_cpu_wait
>>   +    .unreq    swapper_ttb
>> +    .unreq    flag_ptr
>> +SYM_FUNC_END(idmap_kpti_install_ng_mappings)
>> +    .popsection
>> +#endif
>> +
>> +    .pushsection    ".data", "aw", %progbits
>> +SYM_DATA(repaint_done, .long 1)
>> +    .popsection
>> +
>> +    .pushsection ".idmap.text", "a"
>> +SYM_TYPED_FUNC_START(bbml2_wait_for_repainting)
>> +    /* Must be same registers as in idmap_kpti_install_ng_mappings */
>> +    swapper_ttb    .req    x3
>> +    flag_ptr    .req    x4
>> +
>> +    mrs     swapper_ttb, ttbr1_el1
>> +    adr_l   flag_ptr, repaint_done
>> +    __idmap_cpu_set_reserved_ttbr1 x16, x17
>> +
>> +scondary_cpu_wait:
>>       /* Increment the flag to let the boot CPU we're ready */
>>   1:    ldxr    w16, [flag_ptr]
>>       add    w16, w16, #1
>> @@ -436,9 +458,8 @@ __idmap_kpti_secondary:
>>         .unreq    swapper_ttb
>>       .unreq    flag_ptr
>> -SYM_FUNC_END(idmap_kpti_install_ng_mappings)
>> +SYM_FUNC_END(bbml2_wait_for_repainting)
>>       .popsection
>> -#endif
>>     /*
>>    *    __cpu_setup
> 


