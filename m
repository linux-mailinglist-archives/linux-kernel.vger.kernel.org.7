Return-Path: <linux-kernel+bounces-818600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA5ADB593CF
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 12:33:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FB86189165F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 10:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62E00304BB6;
	Tue, 16 Sep 2025 10:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BHb+dGdy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD51430499C
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 10:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758018632; cv=none; b=Z9I30qGzgDpTXDgfPhX4ldbKQF8KFx6GkOuH8VA4l52osSNWWyj9humxXGAuHQ2Y8bmQ39A0/Sw3AK2abEJIh33gsavCxIw3RPWFWmXCn0jsiMghuz6EMkyZkamsT52B7qavmngeq4tqrQapbaWyU8eJAGu2yRHy4aW8VfOLJiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758018632; c=relaxed/simple;
	bh=SAAJtRVKcJwiJyR3IHIUauj/vRpTKvM8j3kpPYHSy0E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FAy6GLSEcQ5dL503si161n77B+K7+Jx1Tggfx/t/07xS/2ve6TJJktAhI4Z/t+7wzU3DZaTKfe/Frcg+MQQr9QUqMsceqhk3G/oFH6eSN9wMtI7hYPmLsFWrXQLqdVF1pE6kYgcNntZBWY6R9oNV5yjyomK3AUQv6CFtGI+7lY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BHb+dGdy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7148C4CEEB;
	Tue, 16 Sep 2025 10:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758018632;
	bh=SAAJtRVKcJwiJyR3IHIUauj/vRpTKvM8j3kpPYHSy0E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BHb+dGdyRn7Zj3bk8i+PMkTmR3IvnW/TifXFm9rRvMPO/ZaO5pXce+RHUf/AYLN5m
	 ZFjrymyO4KJP39QuuWUan4ZWhzUkqkwGi9L4zGjQ69ZuV4LvnnIIwSrNtKWLRNpY/e
	 9Xd2t3xgqXbIMDet89oXA17Hz7dxpGgF4MThYHz82vFlVmkJjQdOqewWp9Z9wFJ54n
	 pnXV10t8OJNalk/7VJZnza0DYdlBgPBtnX0op5oV7wN8o5GrSxX4PYJarBoQ7GnYIE
	 Y64YxNdJWhIDL6bVgnejuGZKtkQxB5z2PPwj9vNUeEMpXwlAu/yx+9N3bKoHMHLkeK
	 HpbRHh1G/qxdQ==
Date: Tue, 16 Sep 2025 11:30:26 +0100
From: Will Deacon <will@kernel.org>
To: Dev Jain <dev.jain@arm.com>
Cc: catalin.marinas@arm.com, anshuman.khandual@arm.com,
	quic_zhenhuah@quicinc.com, ryan.roberts@arm.com,
	kevin.brodsky@arm.com, yangyicong@hisilicon.com, joey.gouly@arm.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	david@redhat.com, mark.rutland@arm.com, urezki@gmail.com,
	jthoughton@google.com
Subject: Re: [RESEND PATCH v5] arm64: Enable vmalloc-huge with ptdump
Message-ID: <aMk8QhkumtEoPVTh@willie-the-truck>
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

Hi Dev,

On Wed, Jul 23, 2025 at 09:48:27PM +0530, Dev Jain wrote:
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
> +	 *
> +	 * Case 1 (b): T2 acquires the lock before T1 can.
> +	 * The sequence of barriers issued in __flush_tlb_kernel_pgtable()
> +	 * ensures that an empty PUD (via pud_clear()) is visible to T1 before
> +	 * T1 can enter CS, therefore it is impossible for the CS to get hold
> +	 * of the address of the isolated PMD table.
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
> +	 *
> +	 * We have proven that the claim is true on the assumption that
> +	 * there is no context switch for T1 and T2. Note that the reasoning
> +	 * of the proof uses barriers operating on the inner shareable domain,
> +	 * which means that they will affect all CPUs, and also a context switch
> +	 * will insert extra barriers into the code paths => the claim will
> +	 * stand true even if we drop the assumption.
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

Although I can see that you put a lot of effort into this comment, I
think we should just remove it. Instead, we should have a litmus test
in the commit message and probably just some small comments here to
explain e.g. why the mmap_read_lock() critical section is empty.

I'm currently trying to put together a litmus test with James (cc'd) so
maybe we can help you out with that part.

In the meantime...

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

What serialises the toggling of the static key here? For example, I can't
see what prevents a kernel page-table dump running concurrently with a
check_wx() and the key ending up in the wrong state.

Either we need an additional lock or perhaps using
static_branch_{inc,dec}() would work instead? I haven't thought too hard
about that but it looks like we need _something_.

Will

