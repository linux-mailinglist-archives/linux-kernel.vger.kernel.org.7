Return-Path: <linux-kernel+bounces-830485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12AA6B99CF1
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 14:21:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A94467ABA8D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 12:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B32B030148D;
	Wed, 24 Sep 2025 12:21:50 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F27FA14EC46
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 12:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758716510; cv=none; b=WEhrywPNbM58DQSZHnKnSe63CIsBG9xmEvuZHiv7LiNQVknOSdqzZGMypw+ue1WPTOCUG46bSkWBZsMaKnN4WH17lm7Wvflxt2BhpN4ARg+pjhqJT3N81j4i8eJWz5swn3ofF6fcs0ef+qnddjYmW5y00RahAfH9fgKNksV2CE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758716510; c=relaxed/simple;
	bh=zIqeJIPDHPZhoZBDJUm3kCZy/RRLG5S3T1DKqqs3p5E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q/EXOtEOCd9vde/2z7ZVulWs6g0aSB+8e9eGda8ULO4XCWxZJjl01xHkbVChC5af3sl1bGhphKxmUAUMY0oVIBFJSpFccmkAS7+Q4k31qwVFxE+sSseAempTppgPtdxtz2bnjecKxt8/Wof+MQ0Ptr2P3nQd++gA0LDAwVCWeOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D72C8106F;
	Wed, 24 Sep 2025 05:21:38 -0700 (PDT)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 13B483F66E;
	Wed, 24 Sep 2025 05:21:44 -0700 (PDT)
Date: Wed, 24 Sep 2025 13:21:37 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Mengchen Li <mengchenli64@gmail.com>
Cc: catalin.marinas@arm.com, will@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: kgdb: Ensure atomic single-step execution
Message-ID: <aNPiUbdRhaRklebF@J2N7QTR9R3>
References: <1756972043-12854-1-git-send-email-mengchenli64@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1756972043-12854-1-git-send-email-mengchenli64@gmail.com>

On Thu, Sep 04, 2025 at 03:47:23PM +0800, Mengchen Li wrote:
> The existing KGDB single-step handling on ARM64 is susceptible to
> interference from external interrupts. If an interrupt arrives in the
> narrow time window between the execution of the instruction under test
> and the generation of the step exception, the CPU will vector to the
> interrupt handler (e.g., el1_interrupt -> __el1_irq) instead of
> triggering the debug exception immediately.
> 
> When the step exception is finally taken, the context is no longer that
> of the original instruction. This causes the debugger to appear "stuck",
> as it repeatedly tries to single-step through the interrupt handler's
> code (e.g., irq_enter_rcu()) instead of the target code.
> 
> The fix is to make the single-step operation atomic by masking interrupts
> for its duration:
> 1. Upon receiving a step ('s') request from GDB, save the current
>    PSTATE and then mask IRQs by setting the PSTATE.I bit.
> 2. After the single-step exception is taken, in kgdb_single_step_handler(),
>    disable the kernel's single-step mechanism and meticulously restore
>    the original interrupt mask state from the saved PSTATE.

I don't think that works:

* Anything which reads PSTATE/DAIF will see PSTATE.I set unexpectedly.
  For example, that will break irqflag tracing, since
  arch_irqs_disabled_flags() will return true in cases where it is
  expected to return false.

* That will break anything which sets PSTATE.I.
  For example, if stepping local_irq_disable(), the initial DAIF value
  might have DAIF.I clear. If that's restored *after*
  local_irq_disable() has set DAIF.I, then restoring the original DAIF.I
  value will erroneously unmask interrupts.

More generally:

* The DAIF.IF bits need to be handled atomically, for platforms where
  FIQ is used.

* Even if the DAIF.IF bits are set, It's still possible to take SError,
  and potentially other exceptions in future (e.g. PMU, NMI). I don't
  think we can only think about the DAIF.I or DAIF.IF bits.

If we want to do something here, I think we'd need to enlighten the
entry code with more comprehensive management of the singlestep state.
I'm not too keen on coupling that with KGDB.

> This guarantees the instruction is executed without interruption and the
> debug exception is taken in the correct context.
> 
> As a result of this new approach, the following cleanups are also made:
> - The global `kgdb_single_step` flag is removed, as state is now precisely
>   managed by `kgdb_cpu_doing_single_step` and the interrupt mask.
> - The logic to disable single-step and manage the flag in the 'c'ontinue
>   case is removed, as it is rendered redundant.
> - The call to `kernel_rewind_single_step()` is unnecessary and is removed.
> 
> Tested on OrangePi 3B (RK3566) via serial console (kgdboc);
> allows reliable single-stepping with GDB where it previously failed.
> 
> Signed-off-by: Mengchen Li <mengchenli64@gmail.com>
> ---
>  arch/arm64/kernel/kgdb.c | 49 ++++++++++++++++++++----------------------------
>  1 file changed, 20 insertions(+), 29 deletions(-)
> 
> diff --git a/arch/arm64/kernel/kgdb.c b/arch/arm64/kernel/kgdb.c
> index 968324a..ee8a7e3 100644
> --- a/arch/arm64/kernel/kgdb.c
> +++ b/arch/arm64/kernel/kgdb.c
> @@ -101,6 +101,8 @@ struct dbg_reg_def_t dbg_reg_def[DBG_MAX_REG_NUM] = {
>  	{ "fpcr", 4, -1 },
>  };
>  
> +static DEFINE_PER_CPU(unsigned int, kgdb_pstate);
> +
>  char *dbg_get_reg(int regno, void *mem, struct pt_regs *regs)
>  {
>  	if (regno >= DBG_MAX_REG_NUM || regno < 0)
> @@ -128,25 +130,15 @@ int dbg_set_reg(int regno, void *mem, struct pt_regs *regs)
>  void
>  sleeping_thread_to_gdb_regs(unsigned long *gdb_regs, struct task_struct *task)
>  {
> -	struct cpu_context *cpu_context = &task->thread.cpu_context;
> +	struct pt_regs *thread_regs;
>  
>  	/* Initialize to zero */
>  	memset((char *)gdb_regs, 0, NUMREGBYTES);
>  
> -	gdb_regs[19] = cpu_context->x19;
> -	gdb_regs[20] = cpu_context->x20;
> -	gdb_regs[21] = cpu_context->x21;
> -	gdb_regs[22] = cpu_context->x22;
> -	gdb_regs[23] = cpu_context->x23;
> -	gdb_regs[24] = cpu_context->x24;
> -	gdb_regs[25] = cpu_context->x25;
> -	gdb_regs[26] = cpu_context->x26;
> -	gdb_regs[27] = cpu_context->x27;
> -	gdb_regs[28] = cpu_context->x28;
> -	gdb_regs[29] = cpu_context->fp;
> -
> -	gdb_regs[31] = cpu_context->sp;
> -	gdb_regs[32] = cpu_context->pc;
> +	thread_regs = task_pt_regs(task);
> +	memcpy((void *)gdb_regs, (void *)thread_regs->regs, GP_REG_BYTES);
> +	/* Special case for PSTATE */
> +	dbg_get_reg(33, gdb_regs + GP_REG_BYTES, thread_regs);
>  }

The commit message doesn't explain anything about the behaviour for
sleeping threads, so it's not clear why this is changed at all.

The task_pt_regs() helper returns a pointer to the pt_regs for the
*userspace* context of a task. That doesn't represent the kernel
context, and that's meaningless for kthreads without a userspace
context.

Regardless of anything else, this is definitely wrong. It is at best
pointless.

[...]

> +		/* mask interrupts while single stepping */
> +		__this_cpu_write(kgdb_pstate, linux_regs->pstate);
> +		linux_regs->pstate |= (1 << 7);

As a general note, please don't open-code bit shifts like this.

IIUC this is PSR_I_BIT.

Mark.

