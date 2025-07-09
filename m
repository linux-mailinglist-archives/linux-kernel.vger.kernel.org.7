Return-Path: <linux-kernel+bounces-723279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE961AFE541
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 12:12:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 774E8189502D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 10:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A89D1288C05;
	Wed,  9 Jul 2025 10:09:12 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A48C3C01;
	Wed,  9 Jul 2025 10:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752055752; cv=none; b=JZlkJ6P/pTrsX8mzxFjG3To3gBY0XXL/CiMCZzCbDAJ7dXHXfY+HO7CLI+tUKVrALMWF2g6pVYF2xMZt+vuQXBsGFHY210WhV9KWytPh1pMIaVe3uVgbgHIG7g7ZdFS8e/LpR+fO0mXAT8y7+tGDyVzXKmL04n3FKKZT9w0saa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752055752; c=relaxed/simple;
	bh=CoL5/v2x+skW61avdU6nrTmmN8/dRoGuGgV8F1UO23k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TbmQJLnO2Eqe34006RLUI4Zindx5FcnYyRLdYGrQTZZ1IFzmFdkP0aJgP80ZoEfPNYgmmQgM5wKSJpwYnP4h6k+KDj4SJiDDr0SS+U7rjb2lEgK7XIyZtNOr2NQVOtHjErheVsjP90CXFCsFGC0Ki2CekE9gqbB5tlvtp/hqEzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 43FAC153B;
	Wed,  9 Jul 2025 03:08:58 -0700 (PDT)
Received: from raptor (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 142A33F694;
	Wed,  9 Jul 2025 03:09:07 -0700 (PDT)
Date: Wed, 9 Jul 2025 11:08:57 +0100
From: Alexandru Elisei <alexandru.elisei@arm.com>
To: Leo Yan <leo.yan@arm.com>
Cc: James Clark <james.clark@linaro.org>, Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Anshuman Khandual <Anshuman.Khandual@arm.com>,
	Rob Herring <Rob.Herring@arm.com>,
	Suzuki Poulose <Suzuki.Poulose@arm.com>,
	Robin Murphy <Robin.Murphy@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] perf: arm_spe: Disable buffer before writing to
 PMBPTR_EL1 or PMBSR_EL1
Message-ID: <aG4_uYJgpMXo3QHQ@raptor>
References: <20250701-james-spe-vm-interface-v1-0-52a2cd223d00@linaro.org>
 <20250701-james-spe-vm-interface-v1-2-52a2cd223d00@linaro.org>
 <20250704155016.GI1039028@e132581.arm.com>
 <b77f12e7-ea3f-4c57-9706-ff8e32721cc8@linaro.org>
 <20250707153710.GB2182465@e132581.arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250707153710.GB2182465@e132581.arm.com>

Hi Leo, James,

On Mon, Jul 07, 2025 at 04:37:10PM +0100, Leo Yan wrote:
> On Mon, Jul 07, 2025 at 12:39:57PM +0100, James Clark wrote:
> 
> [...]
> 
> > > > @@ -661,16 +666,24 @@ static irqreturn_t arm_spe_pmu_irq_handler(int irq, void *dev)
> > > >   	 */
> > > >   	irq_work_run();
> > > > +	/*
> > > > +	 * arm_spe_pmu_buf_get_fault_act() already drained, and PMBSR_EL1.S == 1
> > > > +	 * means that StatisticalProfilingEnabled() == false. So now we can
> > > > +	 * safely disable the buffer.
> > > > +	 */
> > > > +	write_sysreg_s(0, SYS_PMBLIMITR_EL1);
> > > > +	isb();
> > > > +
> > > > +	/* Status can be cleared now that PMBLIMITR_EL1.E == 0 */
> > > > +	write_sysreg_s(0, SYS_PMBSR_EL1);
> > > > +
> > > 
> > > An important thing is about sequence:
> > > As described in arm_spe_pmu_disable_and_drain_local(), should we always
> > > clear ELs bits in PMSCR_EL1 before clear PMBLIMITR_EL1.E bit? As a
> > > reference, we could see TRBE always clear ELx bits before disable trace
> > > buffer.
> > > 
> > > And a trivial flaw:
> > > 
> > > If the TRUNCATED flag has been set, the irq_work_run() above runs the
> > > IRQ work to invoke the arm_spe_pmu_stop() to disable trace buffer, which
> > > clear SYS_PMBLIMITR_EL1.E bit. This is why the current code does not
> > > explictly clear SYS_PMBLIMITR_EL1.E bit.
> > > 
> > > With this patch, the interrupt handler will clear SYS_PMBLIMITR_EL1.E
> > > bit twice for a trunacated case.
> > 
> > I suppose that's a rarer case that we don't necessarily have to optimize
> > for. I don't think it will do any harm, but is it even possible to avoid?
> > 
> > There are already some other duplications in the driver, for example in
> > arm_spe_pmu_stop() we call arm_spe_pmu_disable_and_drain_local() which
> > drains, and then arm_spe_pmu_buf_get_fault_act() which also drains again.
> 
> If we don't need to worry about duplicated operations in the truncated
> case, then for easier maintenance and better readability, I'm wondering
> if we could simplify the interrupt handler as follows:
> 
>     arm_spe_pmu_irq_handler()
>     {
>         ...
> 
>         act = arm_spe_pmu_buf_get_fault_act(handle);
>         if (act == SPE_PMU_BUF_FAULT_ACT_SPURIOUS)
>                 return IRQ_NONE;
> 
>         arm_spe_pmu_disable_and_drain_local();
> 
>         /* Status can be cleared now that PMBLIMITR_EL1.E == 0 */
>         write_sysreg_s(0, SYS_PMBSR_EL1);
>         isb();
> 
>         switch (act) {
>             ...
>         }
>     }
> 
> This approach complies with DEN0154 - we must clear PMBLIMITR_EL1.E
> before writing to other SPE system registers (e.g., PMBSR).
> 
> The reason for using arm_spe_pmu_disable_and_drain_local() is that we
> first need to disable profiling instructions by clearing PMSCR_EL1/EL2,
> and then is it safe to disable the profiling buffer.
> 
> [...]
> 
> > > >   	case SPE_PMU_BUF_FAULT_ACT_OK:
> > > >   		/*
> > > > @@ -679,18 +692,14 @@ static irqreturn_t arm_spe_pmu_irq_handler(int irq, void *dev)
> > > >   		 * PMBPTR might be misaligned, but we'll burn that bridge
> > > >   		 * when we get to it.
> > > >   		 */
> > > > -		if (!(handle->aux_flags & PERF_AUX_FLAG_TRUNCATED)) {
> > > > +		if (!(handle->aux_flags & PERF_AUX_FLAG_TRUNCATED))
> > > >   			arm_spe_perf_aux_output_begin(handle, event);
> > > > -			isb();
> > > 
> > > I am a bit suspecious we can remove this isb().
> > > 
> > > As a reference to the software usage PKLXF in Arm ARM (DDI 0487 L.a),
> > > after enable TRBE trace unit, an ISB is mandatory. Maybe check a bit
> > > for this?
> >
> > Wasn't this isb() to separate the programming of the registers with the
> > status register clear at the end of this function to enable profiling?
> 
> Enabling profiling buffer followed an isb() is not only for separating
> other register programming.
> 
> As described in section D17.9, Synchronization and Statistical Profiling
> in Arm ARM:
> 
>   "A Context Synchronization event guarantees that a direct write to a
>   System register made by the PE in program order before the Context
>   synchronization event are observable by indirect reads and indirect
>   writes of the same System register made by a profiling operation
>   relating to a sampled operation in program order after the Context
>   synchronization event."
> 
> My understanding is: after the ARM SPE profiling is enabled, the
> followed ISB is a Synchronization to make sure the system register
> values are observed by SPE. And we cannot rely on ERET, especially if
> we are tracing the kernel mode.

Thought about this some more.

Before:

arm_spe_pmu_buf_get_fault_act:
  <drain buffer>
  ISB
arm_spe_perf_aux_output_begin:
  PMBLIMITR_EL1.E = 1
ISB
PMBSR_EL1.S = 0
ERET

Now:

PMBLIMITR_EL1 = 0
ISB

PMBSR_EL1.S = 0
arm_spe_perf_aux_output_begin:
  ISB
  PMBLIMITR_EL1.E = 1
ERET

I don't see much of a difference between the two sequences - the point after
which we can be sure that profiling is enabled remains the ERET from the
exception return.  The only difference is that, before this change, the ERET
synchronized clearing the PMBSR_EL1.S bit, now it synchronizes setting the
PMBLIMITR_EL1.E bit.

Thoughts?

Thanks,
Alex

