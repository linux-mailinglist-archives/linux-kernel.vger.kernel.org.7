Return-Path: <linux-kernel+bounces-751083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F80AB16518
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 19:00:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4A5C7ACB96
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 16:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B1B528DF0B;
	Wed, 30 Jul 2025 17:00:40 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE3341EA6F
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 17:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753894839; cv=none; b=PBUHX59701sRKBrq6ampwUbinZb95Twddb/u2oCfGElcpoU9t6WkD7w4S+Ml7JQ9DhPk3oUHfM69CyVjPgCCHF2Wl+26gQSVXPW/AZUuAT/POXxpfm0/Ku8GtMVr6aVhA6dDt98cUo+tXHW9H071FcVWUH6r6bqDDcHNiUJh1/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753894839; c=relaxed/simple;
	bh=HqcJFN2IAn+JXON3YK7cxiaG1LfUaVXsspo2RiVy94k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KN2rIOmlveiVOjK0urKYZaxcEtXuGshu9PryK+r2UvLWF/fBY5BadCErvSg95pevvlDNLH8LCf/4Pa1schNjnbRF40o5EWlKLz9f6rzcB53/RasbMLjiFM2vZ8TA0Pt9e8qt8gVOU+NmmrmRfYM4P9Yd1VlcfDiJWkN3PietrTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 213E3C4CEE3;
	Wed, 30 Jul 2025 17:00:36 +0000 (UTC)
Date: Wed, 30 Jul 2025 18:00:34 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Dev Jain <dev.jain@arm.com>
Cc: will@kernel.org, anshuman.khandual@arm.com, quic_zhenhuah@quicinc.com,
	ryan.roberts@arm.com, kevin.brodsky@arm.com,
	yangyicong@hisilicon.com, joey.gouly@arm.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	david@redhat.com, mark.rutland@arm.com, urezki@gmail.com
Subject: Re: [RESEND PATCH v5] arm64: Enable vmalloc-huge with ptdump
Message-ID: <aIpPsg1Kij8Knnjl@arm.com>
References: <20250723161827.15802-1-dev.jain@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250723161827.15802-1-dev.jain@arm.com>

On Wed, Jul 23, 2025 at 09:48:27PM +0530, Dev Jain wrote:
> diff --git a/arch/arm64/include/asm/vmalloc.h b/arch/arm64/include/asm/vmalloc.h
> index 12f534e8f3ed..e835fd437ae0 100644
> --- a/arch/arm64/include/asm/vmalloc.h
> +++ b/arch/arm64/include/asm/vmalloc.h
> @@ -12,15 +12,13 @@ static inline bool arch_vmap_pud_supported(pgprot_t prot)
>  	/*
>  	 * SW table walks can't handle removal of intermediate entries.
>  	 */
> -	return pud_sect_supported() &&
> -	       !IS_ENABLED(CONFIG_PTDUMP_DEBUGFS);
> +	return pud_sect_supported();

Does the "SW table walks..." comment still make sense?

> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index 00ab1d648db6..49932c1dd34e 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
[...]
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

I think "executes completely on CPU*" is confusing. Just talk about
threads as they can be migrated between CPUs and the memory model is
preserved.

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

This assumes that there is some ordering between unlock and pmd_free()
(e.g. some poisoning of the old page). The unlock only gives us release
semantics, not acquire. It just happens that we have an atomic
dec-and-test down the __free_pages() path but I'm not convinced we
should rely on it unless free_pages() has clear semantics on ordering
related to prior memory writes.

> +	 *
> +	 * Case 1 (b): T2 acquires the lock before T1 can.
> +	 * The sequence of barriers issued in __flush_tlb_kernel_pgtable()
> +	 * ensures that an empty PUD (via pud_clear()) is visible to T1 before
> +	 * T1 can enter CS, therefore it is impossible for the CS to get hold
> +	 * of the address of the isolated PMD table.

Is this the effect of the barriers in the TLB flushing or the release
semantics of the unlock?

> +	 *
> +	 * Case 2: The static branch is not visible to T2.
> +	 *
> +	 * Since static_branch_enable() (via dmb(ish)) and mmap_write_lock()
> +	 * have acquire semantics, it is guaranteed that the static branch

Does static_branch_disable() have release semantics? I think it does via
some atomic_cmpxchg() but it's worth spelling it out.

> +	 * will be visible to all CPUs before T1 can enter CS. The static

As I mentioned on a previous version, this visibility is not absolute.
You could say that it will be observed by other CPUs before they observe
the write_lock.

> +	 * branch not being visible to T2 therefore guarantees that T1 has
> +	 * not yet entered CS .... (i)
> +	 * The sequence of barriers via __flush_tlb_kernel_pgtable() in T2
> +	 * implies that if the invisibility of the static branch has been
> +	 * observed by T2 (i.e static_branch_unlikely() is observed as false),
> +	 * then all CPUs will have observed an empty PUD ... (ii)
> +	 * Combining (i) and (ii), we conclude that T1 observes an empty PUD
> +	 * before entering CS => it is impossible for the CS to get hold of
> +	 * the address of the isolated PMD table. Q.E.D

OK, I nearly got lost. That's not a straightforward memory ordering with
as we have instruction updates with ISB as part of the TLB flushing. I
concluded last time I looked that this branch patching part works
because we also have kick_all_cpus_sync() as part of the static branch
update.

Stepping back to a simpler model, let's say that the static key is a
variable. I wrote this quick test for herd7 and the Linux kernel memory
model (fairly easy to play with):

-------------------------------------8<---------------------------------------
C pte_free_ptdump

(*
 * $ cd tools/memory-model
 * $ herd7 -conf linux-kernel.cfg path/to/pte_free_ptdump.litmus
 *)

{
	pmd = 1;				(* allocated pmd *)
	pte_page = 1;				(* valid pte page pointed at by the pmd *)
}

// pmd_free_pte_page()
P0(spinlock_t *init_mm, int *ptdump_lock_key, int *pmd, int *pte_page)
{
	WRITE_ONCE(*pmd, 0);			// pmd_clear()
	smp_mb();
	if (READ_ONCE(*ptdump_lock_key)) {	// static_branch() approximation
		spin_lock(init_mm);		// mmap_read_lock()
		spin_unlock(init_mm);		// mmap_read_unlock()
	}
	smp_mb();
	WRITE_ONCE(*pte_page, 0);		// pte_free_kernel()
}

// ptdump_walk_pgd()
P1(spinlock_t *init_mm, int *ptdump_lock_key, int *pmd, int *pte_page)
{
	int val;
	int page;

	WRITE_ONCE(*ptdump_lock_key, 1);	// static_branch_enable()
	smp_mb();
	spin_lock(init_mm);			// mmap_write_lock()
	val = READ_ONCE(*pmd);
	page = READ_ONCE(*pte_page);		// freed pte page?
	spin_unlock(init_mm);			// mmap_write_unlock()
	smp_mb();
	WRITE_ONCE(*ptdump_lock_key, 0);	// static_branch_disable()
}

exists(1:val=1 /\ 1:page=0)
-------------------------------------8<---------------------------------------

I sprinkled some necessary smp_mb() but in most cases we have
release/acquire semantics. It does show that we need a barrier before
the page freeing. We also need to acquire for enabling the static key
and release for disabling it.

Next step is to assess that replacing the static key variable read/write
with code patching preserves the model.

-- 
Catalin

