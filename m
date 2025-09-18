Return-Path: <linux-kernel+bounces-823111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F823B858C7
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 17:23:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 887757C1715
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 15:18:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A98030CD8D;
	Thu, 18 Sep 2025 15:18:53 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15DB0241664
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 15:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758208733; cv=none; b=ZR1yIRgcu0/jZpYDMS9/gba2FgbngXBYw1alcLkqRmtZM+SCEu0BzLItHK5gdokFy/w7fptjij1u7QIxnupbMr4oSQ9b/j/z7fYhUkUbx7K1epRS7QYhbNzhUc+C02gYDNTCEuF7yPIyn6NHDGuo3yHoGgtY1JMtlkCFzsrguqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758208733; c=relaxed/simple;
	bh=kXjuFca2JVNLJSZmRetnImSHpmW7eJSiNdlnLfXoDNs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=maqA4p/iV8K6QoH1pVhlaTcJVX4kPMBT5Ec5P+YD9Uk7VceTPmikRsZ6mgtc7UkOT6+6kRJmJLXjCeiEdfghuOT7iek2cbwWvSGuEmTHI09gw/27u1YBbjDxYyYdlvWOjjzH2TEzqZwi0eczZWkMNznOqfNlCYqzGoRk98nywJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C602CC4CEE7;
	Thu, 18 Sep 2025 15:18:51 +0000 (UTC)
Date: Thu, 18 Sep 2025 16:18:49 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	James Morse <james.morse@arm.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v1 2/2] arm64: tlbflush: Don't broadcast if mm was
 only active on local cpu
Message-ID: <aMwi2TwPIut5Lr4Z@arm.com>
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

I realised when we talked earlier that we can reset active_cpu on the
slow path if we got a new ASID. I think it's best to do it in
new_context().

The fork() case where the child may unnecessarily inherit the parent's
active_cpu is already handled by init_new_context() in this patch.

-- 
Catalin

