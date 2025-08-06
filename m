Return-Path: <linux-kernel+bounces-757390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 31D00B1C1A6
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 09:57:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 20FC94E24E1
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 07:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B2A721B196;
	Wed,  6 Aug 2025 07:57:50 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E7461F03C7
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 07:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754467069; cv=none; b=HAMoGiMLwGZzoip8jWL8egOtwuLScT077+uDeEcmgOUdLg6It8D82SxFiMhnhiU6IW/LEaxqqoxnDRyUqbDf4Ky9U/AzgUk03x43iu7UHuJvj/aOF471RXTiP0aafyc3cZFxZNNlxhfeY2ToyJf+GfD8kL9jGuvbzS/PF0Ru2dU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754467069; c=relaxed/simple;
	bh=xgMMJ+lyvONgysryicYMfrSV5BRAxVt72pNWw5iDR6s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b/9RcA4NFYdmsyeAvwowjrXJczTvhjkTP1imGqTkV+/9ArgBHWk8WzYFjcywz7HpFKgOMD/s6eUFg9zu8z4B9h0KtIUaJhteuSuu3xCxPCfVoT4hNq31y445A/BA7zraOOY3RwjU0W5JAJbup0LnOdYf1eD6EJGs56fZDPMY0IA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 843761F37;
	Wed,  6 Aug 2025 00:57:37 -0700 (PDT)
Received: from [10.57.88.107] (unknown [10.57.88.107])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F221C3F5A1;
	Wed,  6 Aug 2025 00:57:43 -0700 (PDT)
Message-ID: <e68455fe-37b8-4f9c-b7ba-3a2f72d6c76e@arm.com>
Date: Wed, 6 Aug 2025 08:57:42 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v6 3/4] arm64: mm: support large block mapping when
 rodata=full
Content-Language: en-GB
To: Yang Shi <yang@os.amperecomputing.com>, will@kernel.org,
 catalin.marinas@arm.com, akpm@linux-foundation.org, Miko.Lenczewski@arm.com,
 dev.jain@arm.com, scott@os.amperecomputing.com, cl@gentwo.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250805081350.3854670-1-ryan.roberts@arm.com>
 <20250805081350.3854670-4-ryan.roberts@arm.com>
 <06e63282-771c-48ec-bcfd-b174e94d52bf@os.amperecomputing.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <06e63282-771c-48ec-bcfd-b174e94d52bf@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 05/08/2025 18:59, Yang Shi wrote:
> 
> 
> On 8/5/25 1:13 AM, Ryan Roberts wrote:
>> From: Yang Shi <yang@os.amperecomputing.com>
>>
>> When rodata=full is specified, kernel linear mapping has to be mapped at
>> PTE level since large page table can't be split due to break-before-make
>> rule on ARM64.
>>
>> This resulted in a couple of problems:
>>    - performance degradation
>>    - more TLB pressure
>>    - memory waste for kernel page table
>>
>> With FEAT_BBM level 2 support, splitting large block page table to
>> smaller ones doesn't need to make the page table entry invalid anymore.
>> This allows kernel split large block mapping on the fly.
>>
>> Add kernel page table split support and use large block mapping by
>> default when FEAT_BBM level 2 is supported for rodata=full.  When
>> changing permissions for kernel linear mapping, the page table will be
>> split to smaller size.
>>
>> The machine without FEAT_BBM level 2 will fallback to have kernel linear
>> mapping PTE-mapped when rodata=full.
>>
>> With this we saw significant performance boost with some benchmarks and
>> much less memory consumption on my AmpereOne machine (192 cores, 1P)
>> with 256GB memory.
>>
>> * Memory use after boot
>> Before:
>> MemTotal:       258988984 kB
>> MemFree:        254821700 kB
>>
>> After:
>> MemTotal:       259505132 kB
>> MemFree:        255410264 kB
>>
>> Around 500MB more memory are free to use.  The larger the machine, the
>> more memory saved.
>>
>> * Memcached
>> We saw performance degradation when running Memcached benchmark with
>> rodata=full vs rodata=on.  Our profiling pointed to kernel TLB pressure.
>> With this patchset we saw ops/sec is increased by around 3.5%, P99
>> latency is reduced by around 9.6%.
>> The gain mainly came from reduced kernel TLB misses.  The kernel TLB
>> MPKI is reduced by 28.5%.
>>
>> The benchmark data is now on par with rodata=on too.
>>
>> * Disk encryption (dm-crypt) benchmark
>> Ran fio benchmark with the below command on a 128G ramdisk (ext4) with
>> disk encryption (by dm-crypt).
>> fio --directory=/data --random_generator=lfsr --norandommap            \
>>      --randrepeat 1 --status-interval=999 --rw=write --bs=4k --loops=1  \
>>      --ioengine=sync --iodepth=1 --numjobs=1 --fsync_on_close=1         \
>>      --group_reporting --thread --name=iops-test-job --eta-newline=1    \
>>      --size 100G
>>
>> The IOPS is increased by 90% - 150% (the variance is high, but the worst
>> number of good case is around 90% more than the best number of bad
>> case). The bandwidth is increased and the avg clat is reduced
>> proportionally.
>>
>> * Sequential file read
>> Read 100G file sequentially on XFS (xfs_io read with page cache
>> populated). The bandwidth is increased by 150%.
>>
>> Co-developed-by: Ryan Roberts <ryan.roberts@arm.com>
>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>> Signed-off-by: Yang Shi <yang@os.amperecomputing.com>
>> ---
>>   arch/arm64/include/asm/cpufeature.h |   2 +
>>   arch/arm64/include/asm/mmu.h        |   1 +
>>   arch/arm64/include/asm/pgtable.h    |   5 +
>>   arch/arm64/kernel/cpufeature.c      |   7 +-
>>   arch/arm64/mm/mmu.c                 | 237 +++++++++++++++++++++++++++-
>>   arch/arm64/mm/pageattr.c            |   6 +
>>   6 files changed, 252 insertions(+), 6 deletions(-)
>>
> 
> [...]
> 
>> +
>> +static DEFINE_MUTEX(pgtable_split_lock);
>> +
>> +int split_kernel_leaf_mapping(unsigned long addr)
>> +{
>> +    pgd_t *pgdp, pgd;
>> +    p4d_t *p4dp, p4d;
>> +    pud_t *pudp, pud;
>> +    pmd_t *pmdp, pmd;
>> +    pte_t *ptep, pte;
>> +    int ret = 0;
>> +
>> +    /*
>> +     * !BBML2_NOABORT systems should not be trying to change permissions on
>> +     * anything that is not pte-mapped in the first place. Just return early
>> +     * and let the permission change code raise a warning if not already
>> +     * pte-mapped.
>> +     */
>> +    if (!system_supports_bbml2_noabort())
>> +        return 0;
>> +
>> +    /*
>> +     * Ensure addr is at least page-aligned since this is the finest
>> +     * granularity we can split to.
>> +     */
>> +    if (addr != PAGE_ALIGN(addr))
>> +        return -EINVAL;
>> +
>> +    mutex_lock(&pgtable_split_lock);
>> +    arch_enter_lazy_mmu_mode();
>> +
>> +    /*
>> +     * PGD: If addr is PGD aligned then addr already describes a leaf
>> +     * boundary. If not present then there is nothing to split.
>> +     */
>> +    if (ALIGN_DOWN(addr, PGDIR_SIZE) == addr)
>> +        goto out;
>> +    pgdp = pgd_offset_k(addr);
>> +    pgd = pgdp_get(pgdp);
>> +    if (!pgd_present(pgd))
>> +        goto out;
>> +
>> +    /*
>> +     * P4D: If addr is P4D aligned then addr already describes a leaf
>> +     * boundary. If not present then there is nothing to split.
>> +     */
>> +    if (ALIGN_DOWN(addr, P4D_SIZE) == addr)
>> +        goto out;
>> +    p4dp = p4d_offset(pgdp, addr);
>> +    p4d = p4dp_get(p4dp);
>> +    if (!p4d_present(p4d))
>> +        goto out;
>> +
>> +    /*
>> +     * PUD: If addr is PUD aligned then addr already describes a leaf
>> +     * boundary. If not present then there is nothing to split. Otherwise,
>> +     * if we have a pud leaf, split to contpmd.
>> +     */
>> +    if (ALIGN_DOWN(addr, PUD_SIZE) == addr)
>> +        goto out;
>> +    pudp = pud_offset(p4dp, addr);
>> +    pud = pudp_get(pudp);
>> +    if (!pud_present(pud))
>> +        goto out;
>> +    if (pud_leaf(pud)) {
>> +        ret = split_pud(pudp, pud);
>> +        if (ret)
>> +            goto out;
>> +    }
>> +
>> +    /*
>> +     * CONTPMD: If addr is CONTPMD aligned then addr already describes a
>> +     * leaf boundary. If not present then there is nothing to split.
>> +     * Otherwise, if we have a contpmd leaf, split to pmd.
>> +     */
>> +    if (ALIGN_DOWN(addr, CONT_PMD_SIZE) == addr)
>> +        goto out;
>> +    pmdp = pmd_offset(pudp, addr);
>> +    pmd = pmdp_get(pmdp);
>> +    if (!pmd_present(pmd))
>> +        goto out;
>> +    if (pmd_leaf(pmd)) {
>> +        if (pmd_cont(pmd))
>> +            split_contpmd(pmdp);
>> +        /*
>> +         * PMD: If addr is PMD aligned then addr already describes a
>> +         * leaf boundary. Otherwise, split to contpte.
>> +         */
>> +        if (ALIGN_DOWN(addr, PMD_SIZE) == addr)
>> +            goto out;
>> +        ret = split_pmd(pmdp, pmd);
>> +        if (ret)
>> +            goto out;
>> +    }
>> +
>> +    /*
>> +     * CONTPTE: If addr is CONTPTE aligned then addr already describes a
>> +     * leaf boundary. If not present then there is nothing to split.
>> +     * Otherwise, if we have a contpte leaf, split to pte.
>> +     */
>> +    if (ALIGN_DOWN(addr, CONT_PMD_SIZE) == addr)
>> +        goto out;
>> +    ptep = pte_offset_kernel(pmdp, addr);
>> +    pte = __ptep_get(ptep);
>> +    if (!pte_present(pte))
>> +        goto out;
>> +    if (pte_cont(pte))
>> +        split_contpte(ptep);
>> +
>> +out:
>> +    arch_leave_lazy_mmu_mode();
>> +    mutex_unlock(&pgtable_split_lock);
>> +    return ret;
>>   }
>>     /*
>> @@ -640,6 +857,16 @@ static inline void arm64_kfence_map_pool(phys_addr_t
>> kfence_pool, pgd_t *pgdp) {
>>     #endif /* CONFIG_KFENCE */
>>   +static inline bool force_pte_mapping(void)
>> +{
>> +    bool bbml2 = system_capabilities_finalized() ?
>> +        system_supports_bbml2_noabort() : bbml2_noabort_available();
>> +
>> +    return (!bbml2 && (rodata_full || arm64_kfence_can_set_direct_map() ||
>> +               is_realm_world())) ||
>> +        debug_pagealloc_enabled();
>> +}
>> +
>>   static void __init map_mem(pgd_t *pgdp)
>>   {
>>       static const u64 direct_map_end = _PAGE_END(VA_BITS_MIN);
>> @@ -665,7 +892,7 @@ static void __init map_mem(pgd_t *pgdp)
>>         early_kfence_pool = arm64_kfence_alloc_pool();
>>   -    if (can_set_direct_map())
>> +    if (force_pte_mapping())
>>           flags |= NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS;
>>         /*
>> @@ -1367,7 +1594,7 @@ int arch_add_memory(int nid, u64 start, u64 size,
>>         VM_BUG_ON(!mhp_range_allowed(start, size, true));
>>   -    if (can_set_direct_map())
>> +    if (force_pte_mapping())
>>           flags |= NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS;
>>         __create_pgd_mapping(swapper_pg_dir, start, __phys_to_virt(start),
>> diff --git a/arch/arm64/mm/pageattr.c b/arch/arm64/mm/pageattr.c
>> index c6a85000fa0e..6a8eefc16dbc 100644
>> --- a/arch/arm64/mm/pageattr.c
>> +++ b/arch/arm64/mm/pageattr.c
>> @@ -140,6 +140,12 @@ static int update_range_prot(unsigned long start,
>> unsigned long size,
>>       data.set_mask = set_mask;
>>       data.clear_mask = clear_mask;
>>   +    ret = split_kernel_leaf_mapping(start);
>> +    if (!ret)
>> +        ret = split_kernel_leaf_mapping(start + size);
>> +    if (WARN_ON_ONCE(ret))
>> +        return ret;
> 
> This means we take the mutex lock twice and do lazy mmu twice too. So how's about:
> 
> mutex_lock()
> enter lazy mmu
> split_mapping(start)
> split_mapping(end)
> leave lazy mmu
> mutex_unlock()

Good point. In fact it would be even better to share the same lazy mmu
invocation with the permission change code below. How about something like this:

---8<---
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 5b5a84b34024..90ab0ab5b06a 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -625,8 +625,6 @@ static int split_pud(pud_t *pudp, pud_t pud, gfp_t gfp)
 	return 0;
 }

-static DEFINE_MUTEX(pgtable_split_lock);
-
 int split_kernel_leaf_mapping(unsigned long addr)
 {
 	pgd_t *pgdp, pgd;
@@ -636,14 +634,7 @@ int split_kernel_leaf_mapping(unsigned long addr)
 	pte_t *ptep, pte;
 	int ret = 0;

-	/*
-	 * !BBML2_NOABORT systems should not be trying to change permissions on
-	 * anything that is not pte-mapped in the first place. Just return early
-	 * and let the permission change code raise a warning if not already
-	 * pte-mapped.
-	 */
-	if (!system_supports_bbml2_noabort())
-		return 0;
+	VM_WARN_ON(!system_supports_bbml2_noabort());

 	/*
 	 * Ensure addr is at least page-aligned since this is the finest
@@ -652,9 +643,6 @@ int split_kernel_leaf_mapping(unsigned long addr)
 	if (addr != PAGE_ALIGN(addr))
 		return -EINVAL;

-	mutex_lock(&pgtable_split_lock);
-	arch_enter_lazy_mmu_mode();
-
 	/*
 	 * PGD: If addr is PGD aligned then addr already describes a leaf
 	 * boundary. If not present then there is nothing to split.
@@ -734,8 +722,6 @@ int split_kernel_leaf_mapping(unsigned long addr)
 		split_contpte(ptep);

 out:
-	arch_leave_lazy_mmu_mode();
-	mutex_unlock(&pgtable_split_lock);
 	return ret;
 }

diff --git a/arch/arm64/mm/pageattr.c b/arch/arm64/mm/pageattr.c
index 6a8eefc16dbc..73f80db2e5ba 100644
--- a/arch/arm64/mm/pageattr.c
+++ b/arch/arm64/mm/pageattr.c
@@ -131,6 +131,8 @@ bool can_set_direct_map(void)
 		arm64_kfence_can_set_direct_map() || is_realm_world();
 }

+static DEFINE_MUTEX(pgtable_split_lock);
+
 static int update_range_prot(unsigned long start, unsigned long size,
 			     pgprot_t set_mask, pgprot_t clear_mask)
 {
@@ -140,14 +142,23 @@ static int update_range_prot(unsigned long start, unsigned
long size,
 	data.set_mask = set_mask;
 	data.clear_mask = clear_mask;

-	ret = split_kernel_leaf_mapping(start);
-	if (!ret)
-		ret = split_kernel_leaf_mapping(start + size);
-	if (WARN_ON_ONCE(ret))
-		return ret;
-
 	arch_enter_lazy_mmu_mode();

+	/*
+	 * split_kernel_leaf_mapping() is only allowed for BBML2_NOABORT
+	 * systems. !BBML2_NOABORT systems should not be trying to change
+	 * permissions on anything that is not pte-mapped in the first place.
+	 */
+	if (system_supports_bbml2_noabort()) {
+		mutex_lock(&pgtable_split_lock);
+		ret = split_kernel_leaf_mapping(start);
+		if (!ret)
+			ret = split_kernel_leaf_mapping(start + size);
+		mutex_unlock(&pgtable_split_lock);
+		if (ret)
+			goto out;
+	}
+
 	/*
 	 * The caller must ensure that the range we are operating on does not
 	 * partially overlap a block mapping, or a cont mapping. Any such case
@@ -155,8 +166,8 @@ static int update_range_prot(unsigned long start, unsigned
long size,
 	 */
 	ret = walk_kernel_page_table_range_lockless(start, start + size,
 						    &pageattr_ops, &data);
+out:
 	arch_leave_lazy_mmu_mode();
-
 	return ret;
 }
---8<---

Of course this means we take the mutex while inside the lazy mmu section.
Technically sleeping is not allowed while in lazy mmu mode, but the arm64
implementation can handle it. If this is a step too far, I guess we can keep 2
separate lazy mmu sections; one for split as you suggest, and another for
permission change.

Thanks,
Ryan

> 
> Thanks,
> Yang
> 
>> +
>>       arch_enter_lazy_mmu_mode();
>>         /*
> 


