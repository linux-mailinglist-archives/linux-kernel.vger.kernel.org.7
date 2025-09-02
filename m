Return-Path: <linux-kernel+bounces-796989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53027B40A79
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 18:23:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 179001679A0
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 16:23:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0187431CA48;
	Tue,  2 Sep 2025 16:23:24 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A8192F361E
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 16:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756830203; cv=none; b=aMznNP4A2sRslH2wAm/59J0fIrpZrc9XlSmcX+jLExt86pFO5MSwQz+3YLV2Gy5SmoMYCQcJuvYIeiZtRZ1I0j3uSVX+uqSr67KaDD5TXN0s/yEZiO1V6cQRM4HzwmTjMSrd7isHPgpIckIGL0vC4vW5i1pFmCAZzyJ+yjDncRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756830203; c=relaxed/simple;
	bh=N5qNvqIcCIgRX5gvNcNL3DkrBEZ1UMmb6Dd4Cq7UA7E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MQWaFdsscMGhMv2hM/Ucue1vEF9iDnSf8msdbxPEjeVyHuENgPig70EhASlSOIAutEFMRoO0ymwLJ624cyrZcZIK9Y78bmRq4GpUYLcCcpI4dFytGRWxPWyxvlJkcGgpWFJEDSE2TwTXN9P7ZfgHxWlfSBhM8BUTvZ2dSoRzzXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A327C4CEED;
	Tue,  2 Sep 2025 16:23:21 +0000 (UTC)
Date: Tue, 2 Sep 2025 17:23:19 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	James Morse <james.morse@arm.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v1 2/2] arm64: tlbflush: Don't broadcast if mm was
 only active on local cpu
Message-ID: <aLcZ93VeOYa4ilZb@arm.com>
References: <20250829153510.2401161-1-ryan.roberts@arm.com>
 <20250829153510.2401161-3-ryan.roberts@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250829153510.2401161-3-ryan.roberts@arm.com>

On Fri, Aug 29, 2025 at 04:35:08PM +0100, Ryan Roberts wrote:
> diff --git a/arch/arm64/include/asm/tlbflush.h b/arch/arm64/include/asm/tlbflush.h
> index f66b8c4696d0..651440e0aff9 100644
> --- a/arch/arm64/include/asm/tlbflush.h
> +++ b/arch/arm64/include/asm/tlbflush.h
> @@ -182,6 +182,52 @@ static inline unsigned long get_trans_granule(void)
>  		(__pages >> (5 * (scale) + 1)) - 1;			\
>  	})
>  
> +/*
> + * Determines whether the user tlbi invalidation can be performed only on the
> + * local CPU or whether it needs to be broadcast. (Returns true for local).
> + * Additionally issues appropriate barrier to ensure prior pgtable updates are
> + * visible to the table walker. Must be paired with flush_tlb_user_post().
> + */
> +static inline bool flush_tlb_user_pre(struct mm_struct *mm)
> +{
> +	unsigned int self, active;
> +	bool local;
> +
> +	migrate_disable();
> +
> +	self = smp_processor_id();
> +
> +	/*
> +	 * The load of mm->context.active_cpu must not be reordered before the
> +	 * store to the pgtable that necessitated this flush. This ensures that
> +	 * if the value read is our cpu id, then no other cpu can have seen the
> +	 * old pgtable value and therefore does not need this old value to be
> +	 * flushed from its tlb. But we don't want to upgrade the dsb(ishst),
> +	 * needed to make the pgtable updates visible to the walker, to a
> +	 * dsb(ish) by default. So speculatively load without a barrier and if
> +	 * it indicates our cpu id, then upgrade the barrier and re-load.
> +	 */
> +	active = READ_ONCE(mm->context.active_cpu);
> +	if (active == self) {
> +		dsb(ish);
> +		active = READ_ONCE(mm->context.active_cpu);
> +	} else {
> +		dsb(ishst);
> +	}

Does the ISH vs ISHST make much difference in practice? I wonder whether
we could keep this simple.

> diff --git a/arch/arm64/mm/context.c b/arch/arm64/mm/context.c
> index b2ac06246327..adf4fc26ddb6 100644
> --- a/arch/arm64/mm/context.c
> +++ b/arch/arm64/mm/context.c
> @@ -214,9 +214,10 @@ static u64 new_context(struct mm_struct *mm)
>  
>  void check_and_switch_context(struct mm_struct *mm)
>  {
> -	unsigned long flags;
> -	unsigned int cpu;
> +	unsigned int cpu = smp_processor_id();
>  	u64 asid, old_active_asid;
> +	unsigned int active;
> +	unsigned long flags;
>  
>  	if (system_supports_cnp())
>  		cpu_set_reserved_ttbr0();
> @@ -251,7 +252,6 @@ void check_and_switch_context(struct mm_struct *mm)
>  		atomic64_set(&mm->context.id, asid);
>  	}
>  
> -	cpu = smp_processor_id();
>  	if (cpumask_test_and_clear_cpu(cpu, &tlb_flush_pending))
>  		local_flush_tlb_all();
>  
> @@ -262,6 +262,30 @@ void check_and_switch_context(struct mm_struct *mm)
>  
>  	arm64_apply_bp_hardening();
>  
> +	/*
> +	 * Update mm->context.active_cpu in such a manner that we avoid cmpxchg
> +	 * and dsb unless we definitely need it. If initially ACTIVE_CPU_NONE
> +	 * then we are the first cpu to run so set it to our id. If initially
> +	 * any id other than ours, we are the second cpu to run so set it to
> +	 * ACTIVE_CPU_MULTIPLE. If we update the value then we must issue
> +	 * dsb(ishst) to ensure stores to mm->context.active_cpu are ordered
> +	 * against the TTBR0 write in cpu_switch_mm()/uaccess_enable(); the
> +	 * store must be visible to another cpu before this cpu could have
> +	 * populated any TLB entries based on the pgtables that will be
> +	 * installed.
> +	 */
> +	active = READ_ONCE(mm->context.active_cpu);
> +	if (active != cpu && active != ACTIVE_CPU_MULTIPLE) {
> +		if (active == ACTIVE_CPU_NONE)
> +			active = cmpxchg_relaxed(&mm->context.active_cpu,
> +						 ACTIVE_CPU_NONE, cpu);
> +
> +		if (active != ACTIVE_CPU_NONE)
> +			WRITE_ONCE(mm->context.active_cpu, ACTIVE_CPU_MULTIPLE);
> +
> +		dsb(ishst);
> +	}

I think this works. I recall James had a litmus test for the model
checker confirming this.

In a cut-down version, we'd have:

P0:				P1:

set_pte();			WRITE_ONCE(active_cpu);
dsb();				dsb();
READ_ONCE(active_cpu);		READ_ONCE(pte);

The pte read on P1 is implied following the TTBR0 write. As you
described, if P0 did not see the active_cpu update, P1 would have seen
the updated pte.

So far I couldn't fail this, so:

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

