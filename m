Return-Path: <linux-kernel+bounces-743560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89248B10040
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 07:52:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C9897B17EA
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 05:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B21A202C48;
	Thu, 24 Jul 2025 05:50:39 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A67A324468A
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 05:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753336238; cv=none; b=g6OhQY10tZK7KUrYi7HvPBjyNBjm8k3NmErtSes7yh89zCEGD1PPmeVDgVDS69OTgo8YE1vqxyvOR0iFwLiFixXKui5qCaTnohGxQxIROu48H1b8lPsjlmOD3JCPcNXYHRyr9XdU8GJhDX91T3pAtDriaYcHZO/bIk8sB0VlMpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753336238; c=relaxed/simple;
	bh=xeAwzSCN4Up6BF7xYcc+fw9Lz5Ta7U9JQRrQ4Kp5RjU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AbLEC/PUf+BnaZJz622k5/tJkdAL3dlIKKuHudaX9NxpoN5+Y/CvWqi++KJ0Kncgsxj0/Y/wWkki3fgne2RZF59i3BPrxf9i2nY6nT22brrY4UkXPSc6ESmqLiEH6kENmHaWs5kpUulvAVRZ9wLRNQaswE4PtPjowMH7yJbCPxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A8A331A00;
	Wed, 23 Jul 2025 22:50:28 -0700 (PDT)
Received: from [10.163.92.78] (unknown [10.163.92.78])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B06973F66E;
	Wed, 23 Jul 2025 22:50:29 -0700 (PDT)
Message-ID: <90f56b8b-cc09-45c5-88d5-36d39a00ea14@arm.com>
Date: Thu, 24 Jul 2025 11:20:26 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH v5] arm64: Enable vmalloc-huge with ptdump
To: Dev Jain <dev.jain@arm.com>, catalin.marinas@arm.com, will@kernel.org
Cc: quic_zhenhuah@quicinc.com, ryan.roberts@arm.com, kevin.brodsky@arm.com,
 yangyicong@hisilicon.com, joey.gouly@arm.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 david@redhat.com, mark.rutland@arm.com, urezki@gmail.com
References: <20250723161827.15802-1-dev.jain@arm.com>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20250723161827.15802-1-dev.jain@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

A very small nit -

arm64/mm: Enable vmalloc-huge with ptdump

On 23/07/25 9:48 PM, Dev Jain wrote:
> Our goal is to move towards enabling vmalloc-huge by default on arm64 so
> as to reduce TLB pressure. Therefore, we need a way to analyze the portion
> of block mappings in vmalloc space we can get on a production system; this
> can be done through ptdump, but currently we disable vmalloc-huge if
> CONFIG_PTDUMP_DEBUGFS is on. The reason is that lazy freeing of kernel
> pagetables via vmap_try_huge_pxd() may race with ptdump, so ptdump
> may dereference a bogus address.
> 
> To solve this, we need to synchronize ptdump_walk_pgd() with
> pud_free_pmd_page() and pmd_free_pte_page().
> 
> Since this race is very unlikely to happen in practice, we do not want to
> penalize other code paths taking the init_mm mmap_lock. Therefore, we use
> static keys. ptdump will enable the static key - upon observing that, the
> vmalloc table freeing path will get patched in with an
> mmap_read_lock/unlock sequence. A code comment explains in detail, how
> a combination of acquire sematics of static_branch_enable() and the

typo                       ^^^^^^^^ s/sematics/semantics

> barriers in __flush_tlb_kernel_pgtable() ensures that ptdump will never
> get a hold on the address of a freed PMD or PTE table.
> 
> For an (almost) rigorous proof of correctness, one may look at:
> https://lore.kernel.org/all/e1e87f16-1c48-481b-8f7c-9333ac5d13e7@arm.com/
> 
> Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>
> Signed-off-by: Dev Jain <dev.jain@arm.com>
> ---
> Rebased on 6.16-rc7.
> 
> mm-selfests pass. No issues were observed while parallelly running
> test_vmalloc.sh (which stresses the vmalloc subsystem) and dumping the
> kernel pagetable through sysfs in a loop.
> 
> v4->v5:
>  - The arch_vmap_pxd_supported() changes were dropped by mistake in between
>    the revisions, add them back (Anshuman)
>  - Rewrite cover letter, drop stray change, add arm64_ptdump_walk_pgd()
>    helper, rename ptdump_lock_key -> arm64_ptdump_lock_key, add comment
>    above __pmd_free_pte_page() to explain when the lock won't
>    be taken (Anshuman)
>  - Rewrite the comment explaining the synchronization logic (Catalin)
> 
> v3->v4:
>  - Lock-unlock immediately
>  - Simplify includes
> 
> v2->v3:
>  - Use static key mechanism
> 
> v1->v2:
>  - Take lock only when CONFIG_PTDUMP_DEBUGFS is on
>  - In case of pud_free_pmd_page(), isolate the PMD table to avoid taking
>    the lock 512 times again via pmd_free_pte_page()
> 
> ---
>  arch/arm64/include/asm/ptdump.h  |  2 +
>  arch/arm64/include/asm/vmalloc.h |  6 +--
>  arch/arm64/mm/mmu.c              | 86 ++++++++++++++++++++++++++++++--
>  arch/arm64/mm/ptdump.c           | 11 +++-
>  4 files changed, 95 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/ptdump.h b/arch/arm64/include/asm/ptdump.h
> index fded5358641f..baff24004459 100644
> --- a/arch/arm64/include/asm/ptdump.h
> +++ b/arch/arm64/include/asm/ptdump.h
> @@ -7,6 +7,8 @@
>  
>  #include <linux/ptdump.h>
>  
> +DECLARE_STATIC_KEY_FALSE(arm64_ptdump_lock_key);
> +
>  #ifdef CONFIG_PTDUMP
>  
>  #include <linux/mm_types.h>
> diff --git a/arch/arm64/include/asm/vmalloc.h b/arch/arm64/include/asm/vmalloc.h
> index 12f534e8f3ed..e835fd437ae0 100644
> --- a/arch/arm64/include/asm/vmalloc.h
> +++ b/arch/arm64/include/asm/vmalloc.h
> @@ -12,15 +12,13 @@ static inline bool arch_vmap_pud_supported(pgprot_t prot)
>  	/*
>  	 * SW table walks can't handle removal of intermediate entries.
>  	 */

This above comment can now be dropped.

> -	return pud_sect_supported() &&
> -	       !IS_ENABLED(CONFIG_PTDUMP_DEBUGFS);
> +	return pud_sect_supported();
>  }
>  
>  #define arch_vmap_pmd_supported arch_vmap_pmd_supported
>  static inline bool arch_vmap_pmd_supported(pgprot_t prot)
>  {
> -	/* See arch_vmap_pud_supported() */
> -	return !IS_ENABLED(CONFIG_PTDUMP_DEBUGFS);
> +	return true;
>  }
>  
>  #define arch_vmap_pte_range_map_size arch_vmap_pte_range_map_size
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index 00ab1d648db6..49932c1dd34e 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -46,6 +46,8 @@
>  #define NO_CONT_MAPPINGS	BIT(1)
>  #define NO_EXEC_MAPPINGS	BIT(2)	/* assumes FEAT_HPDS is not used */
>  
> +DEFINE_STATIC_KEY_FALSE(arm64_ptdump_lock_key);

A short introduction about the static key's purpose might be helpful.

> +
>  enum pgtable_type {
>  	TABLE_PTE,
>  	TABLE_PMD,
> @@ -1267,7 +1269,12 @@ int pmd_clear_huge(pmd_t *pmdp)
>  	return 1;
>  }
>  
> -int pmd_free_pte_page(pmd_t *pmdp, unsigned long addr)
> +/*
> + * If PMD has been isolated via pud_free_pmd_page(), ptdump cannot get
> + * a hold to it, so no need to serialize with mmap_lock, hence lock
> + * will be passed as false here. Otherwise, lock will be true.
> + */

This comment should be split into two and added near their respective
call sites with and without the kernel mmap_lock requirement.

> +static int __pmd_free_pte_page(pmd_t *pmdp, unsigned long addr, bool lock)IIUC 'lock' is the need for taking mmap_lock in init_mm. Hence changing
that as 'mmap_lock' or 'kernel_mmap_lock' might be better which will
also add some required context.

>  {
>  	pte_t *table;
>  	pmd_t pmd;
> @@ -1279,13 +1286,24 @@ int pmd_free_pte_page(pmd_t *pmdp, unsigned long addr)
>  		return 1;
>  	}
>  
> +	/* See comment in pud_free_pmd_page for static key logic */
>  	table = pte_offset_kernel(pmdp, addr);
>  	pmd_clear(pmdp);
>  	__flush_tlb_kernel_pgtable(addr);
> +	if (static_branch_unlikely(&arm64_ptdump_lock_key) && lock) {
> +		mmap_read_lock(&init_mm);
> +		mmap_read_unlock(&init_mm);
> +	}
> +
>  	pte_free_kernel(NULL, table);
>  	return 1;
>  }
>  
> +int pmd_free_pte_page(pmd_t *pmdp, unsigned long addr)
> +{
> +	return __pmd_free_pte_page(pmdp, addr, true);
> +}
> +
>  int pud_free_pmd_page(pud_t *pudp, unsigned long addr)
>  {
>  	pmd_t *table;
> @@ -1301,16 +1319,76 @@ int pud_free_pmd_page(pud_t *pudp, unsigned long addr)
>  	}
>  
>  	table = pmd_offset(pudp, addr);
> +
> +	/*
> +	 * Our objective is to prevent ptdump from reading a PMD table which has
> +	 * been freed.  Assume that ptdump_walk_pgd() (call this thread T1)
> +	 * executes completely on CPU1 and pud_free_pmd_page() (call this thread
> +	 * T2) executes completely on CPU2. Let the region sandwiched by the
> +	 * mmap_write_lock/unlock in T1 be called CS (the critical section).
> +	 *
> +	 * Claim: The CS of T1 will never operate on a freed PMD table.
> +	 *
> +	 * Proof:
> +	 *
> +	 * Case 1: The static branch is visible to T2.
> +	 *
> +	 * Case 1 (a): T1 acquires the lock before T2 can.
> +	 * T2 will block until T1 drops the lock, so pmd_free() will only be
> +	 * executed after T1 exits CS.

T2 blocks here because ptdump_walk_pgd() takes mmap_write_lock(). This needs
to be mentioned.

> +	 *> +	 * Case 1 (b): T2 acquires the lock before T1 can.
> +	 * The sequence of barriers issued in __flush_tlb_kernel_pgtable()
> +	 * ensures that an empty PUD (via pud_clear()) is visible to T1 before
> +	 * T1 can enter CS, therefore it is impossible for the CS to get hold
> +	 * of the address of the isolated PMD table.

Agreed. mmap_write_lock() from ptdump_walk_pgd() will proceed after T2 calls
mmap_read_unlock(). So protection from race comes from the fact that T1 can
never get hold of isolated PMD table not because of the mmap_lock.

> +	 *
> +	 * Case 2: The static branch is not visible to T2.
> +	 *
> +	 * Since static_branch_enable() (via dmb(ish)) and mmap_write_lock()
> +	 * have acquire semantics, it is guaranteed that the static branch
> +	 * will be visible to all CPUs before T1 can enter CS. The static
> +	 * branch not being visible to T2 therefore guarantees that T1 has
> +	 * not yet entered CS .... (i)
> +	 * The sequence of barriers via __flush_tlb_kernel_pgtable() in T2
> +	 * implies that if the invisibility of the static branch has been
> +	 * observed by T2 (i.e static_branch_unlikely() is observed as false),
> +	 * then all CPUs will have observed an empty PUD ... (ii)
> +	 * Combining (i) and (ii), we conclude that T1 observes an empty PUD
> +	 * before entering CS => it is impossible for the CS to get hold of
> +	 * the address of the isolated PMD table. Q.E.D
> +	 *> +	 * We have proven that the claim is true on the assumption that
> +	 * there is no context switch for T1 and T2. Note that the reasoning
> +	 * of the proof uses barriers operating on the inner shareable domain,
> +	 * which means that they will affect all CPUs, and also a context switch
> +	 * will insert extra barriers into the code paths => the claim will
> +	 * stand true even if we drop the assumption.

Do these all rest on the fact that static_branch_enable() and mmap_write_lock()
have acquire semantics available via a particular class of barrier instructions
? In which case should the generation of those instructions via these functions
be asserted for the above T1/T2 guarantee to hold ? Just curious.

> +	 *
> +	 * It is also worth reasoning whether something can go wrong via
> +	 * pud_free_pmd_page() -> __pmd_free_pte_page(), since the latter
> +	 * will be called locklessly on this code path.
> +	 *
> +	 * For Case 1 (a), T2 will block until CS is finished, so we are safe.
> +	 * For Case 1 (b) and Case 2, the PMD table will be isolated before
> +	 * T1 can enter CS, therefore it is safe for T2 to operate on the
> +	 * PMD table locklessly.
> +	 */

Although looks reasonable - the above comment block is going to be difficult to
process after time has passed :) Just wondering could it some how be simplified ?

> +	pud_clear(pudp);
> +	__flush_tlb_kernel_pgtable(addr);
> +	if (static_branch_unlikely(&arm64_ptdump_lock_key)) {
> +		mmap_read_lock(&init_mm);
> +		mmap_read_unlock(&init_mm);
> +	}
> +
>  	pmdp = table;
>  	next = addr;
>  	end = addr + PUD_SIZE;
>  	do {
>  		if (pmd_present(pmdp_get(pmdp)))
> -			pmd_free_pte_page(pmdp, next);
> +			__pmd_free_pte_page(pmdp, next, false);
>  	} while (pmdp++, next += PMD_SIZE, next != end);
>  
> -	pud_clear(pudp);
> -	__flush_tlb_kernel_pgtable(addr);
>  	pmd_free(NULL, table);
>  	return 1;
>  }
> diff --git a/arch/arm64/mm/ptdump.c b/arch/arm64/mm/ptdump.c
> index 421a5de806c6..65335c7ba482 100644
> --- a/arch/arm64/mm/ptdump.c
> +++ b/arch/arm64/mm/ptdump.c
> @@ -283,6 +283,13 @@ void note_page_flush(struct ptdump_state *pt_st)
>  	note_page(pt_st, 0, -1, pte_val(pte_zero));
>  }
>  
> +static void arm64_ptdump_walk_pgd(struct ptdump_state *st, struct mm_struct *mm)
> +{
> +	static_branch_enable(&arm64_ptdump_lock_key);
> +	ptdump_walk_pgd(st, mm, NULL);
> +	static_branch_disable(&arm64_ptdump_lock_key);
> +}
Encapsulating generic ptdump_walk_pgd() between arm64 platform
specific static key enable/disable requirement does make sense.

> +
>  void ptdump_walk(struct seq_file *s, struct ptdump_info *info)
>  {
>  	unsigned long end = ~0UL;
> @@ -311,7 +318,7 @@ void ptdump_walk(struct seq_file *s, struct ptdump_info *info)
>  		}
>  	};
>  
> -	ptdump_walk_pgd(&st.ptdump, info->mm, NULL);
> +	arm64_ptdump_walk_pgd(&st.ptdump, info->mm);
>  }
>  
>  static void __init ptdump_initialize(void)
> @@ -353,7 +360,7 @@ bool ptdump_check_wx(void)
>  		}
>  	};
>  
> -	ptdump_walk_pgd(&st.ptdump, &init_mm, NULL);
> +	arm64_ptdump_walk_pgd(&st.ptdump, &init_mm);
>  
>  	if (st.wx_pages || st.uxn_pages) {
>  		pr_warn("Checked W+X mappings: FAILED, %lu W+X pages found, %lu non-UXN pages found\n",

