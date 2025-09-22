Return-Path: <linux-kernel+bounces-827099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2292AB904DD
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 13:08:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D91B317E73A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 11:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1FEC2D9EED;
	Mon, 22 Sep 2025 11:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SybAgN8L"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A762192B66
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 11:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758539307; cv=none; b=BbM98NMbDLPWZdKVmJJf+yJIbdu/KEcm/gcICOP6+Uh80UVQz9ywBw5J1SBiocLiiSI+CLwSMtEYNZG72YTYVN/ROmMCROjdRLbRiMwAfYcjW5UHI9hEmsYlaain0289VogjbqA2eyypSXq89M8gKPdzOyoBs2eywu+jnCeLcA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758539307; c=relaxed/simple;
	bh=8H2DVag6hTQmO7INCaFRzpGM0vzoCJhreoQ8hR1H9cs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jLnITxVCUakTCP+6xm0Nxluot1YDFOAE9mgPFHM0K8We/j4iyYzIvZ8OIg14b3TWio/Ow1kDc/918a4HM/YdRuROFcxO6Zz9RjlbhUjlL++5RC9vK1S1MyxkpIIWBQqpigqw651aag90CjS+rYUoadZiEZ9i86uyRLDnGBWl3Jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SybAgN8L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C4C7C4CEF0;
	Mon, 22 Sep 2025 11:08:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758539306;
	bh=8H2DVag6hTQmO7INCaFRzpGM0vzoCJhreoQ8hR1H9cs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SybAgN8LLiYMb3bpJZqg4BUvIixL2rR0eKxerV6f/X/6YdftvcHthhB/L29Hgj49n
	 OaLHaAZKHmUxR534G5DuhXqXfpT0ipHW5E4oAabe13VGuaBG8o6QP6B/hzsxGeBWXK
	 7pOeYFp102UQ/7Wi/97lF91HL4FgpO5E67hxZuu8BhygX/V+4Wmm7ChGYzu0Bmm6cr
	 FuwkRXtnzTlzz2pNwrBlrbR2V6D3nIa+ljr4oFYdR37Cr5YZHCqBbXfoeGF3ubQI3i
	 xYmGTSCb+p6QEclPUmLV7riMd1uIRP+VIRXRarU4QheUDG2LPvfacfgGLFBdAVkffQ
	 yqiAMnaUPz5YQ==
Date: Mon, 22 Sep 2025 12:08:22 +0100
From: Will Deacon <will@kernel.org>
To: Mengchen Li <mengchenli64@gmail.com>
Cc: catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, mark.rutland@arm.com,
	ada.coupriediaz@arm.com, dianders@chromium.org
Subject: Re: [PATCH] arm64: kgdb: Ensure atomic single-step execution
Message-ID: <aNEuJu0BQAloEBX9@willie-the-truck>
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
> 
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

Why are you now copying the caller saved registers?

Will

