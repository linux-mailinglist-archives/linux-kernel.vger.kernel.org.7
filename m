Return-Path: <linux-kernel+bounces-764612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E202B22521
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 13:01:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A1507B25DA
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 11:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C271123BCE7;
	Tue, 12 Aug 2025 11:01:37 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5609937160
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 11:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754996497; cv=none; b=LcLmzITKVAp+Q97wlpPejqwEIxKxM5CUV+/brUCxbhWyZnRQjiWUFP/1rLXOiKvDc+E7ANbPX90oL1Y3EI2t/VnE5fwm+JpxwldSkzTAjv2rWCop1D2RQwe3Py0spaQJJND0PNxtGLx6Vw1P3k1MqR8SfFnjt+P0lyouGBWPSyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754996497; c=relaxed/simple;
	bh=e8xJKLc2dXZ7AKemk1oceWurgq9JtK9m2PVNxUFdOv4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Eqln006xNGpsptJrrcx2iDljVsJUmSjy9hquPmjQdlfxEi/8ReMOI4wKVNDiNg0UiM9ly+4ck4lxk7BfoltFawSMEEbHEZ20Unf76lbn5EH15PBnfnOS1MgURKbHpkDmmS1tIEjHM99qsAsScfiQbJnWwWX1k7ZohkQp8rlhlhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 488E525E1;
	Tue, 12 Aug 2025 04:01:26 -0700 (PDT)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A6A743F63F;
	Tue, 12 Aug 2025 04:01:30 -0700 (PDT)
Date: Tue, 12 Aug 2025 12:01:27 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: catalin.marinas@arm.com, will@kernel.org, oleg@redhat.com,
	sstabellini@kernel.org, puranjay@kernel.org, broonie@kernel.org,
	mbenes@suse.cz, ryan.roberts@arm.com, akpm@linux-foundation.org,
	chenl311@chinatelecom.cn, ada.coupriediaz@arm.com,
	anshuman.khandual@arm.com, kristina.martsenko@arm.com,
	liaochang1@huawei.com, ardb@kernel.org, leitao@debian.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	xen-devel@lists.xenproject.org
Subject: Re: [PATCH -next v7 2/7] arm64: entry: Refactor the entry and exit
 for exceptions from EL1
Message-ID: <aJsfB3DJCduz6lzx@J2N7QTR9R3>
References: <20250729015456.3411143-1-ruanjinjie@huawei.com>
 <20250729015456.3411143-3-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250729015456.3411143-3-ruanjinjie@huawei.com>

Hi Jinjie,

On Tue, Jul 29, 2025 at 09:54:51AM +0800, Jinjie Ruan wrote:
> The generic entry code uses irqentry_state_t to track lockdep and RCU
> state across exception entry and return. For historical reasons, arm64
> embeds similar fields within its pt_regs structure.
> 
> In preparation for moving arm64 over to the generic entry code, pull
> these fields out of arm64's pt_regs, and use a separate structure,
> matching the style of the generic entry code.
> 
> No functional changes.
> 
> Suggested-by: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>

One minor formatting nit below, but with aside from that this looks
great, and with that fixed up:

Acked-by: Mark Rutland <mark.rutland@arm.com>

[...]

> @@ -475,73 +497,81 @@ UNHANDLED(el1t, 64, error)
>  static void noinstr el1_abort(struct pt_regs *regs, unsigned long esr)
>  {
>  	unsigned long far = read_sysreg(far_el1);
> +	arm64_irqentry_state_t state;
>  
> -	enter_from_kernel_mode(regs);
> +	state = enter_from_kernel_mode(regs);
>  	local_daif_inherit(regs);
>  	do_mem_abort(far, esr, regs);
>  	local_daif_mask();
> -	exit_to_kernel_mode(regs);
> +	exit_to_kernel_mode(regs, state);
>  }
>  
>  static void noinstr el1_pc(struct pt_regs *regs, unsigned long esr)
>  {
>  	unsigned long far = read_sysreg(far_el1);
> +	arm64_irqentry_state_t state;
>  
> -	enter_from_kernel_mode(regs);
> +	state = enter_from_kernel_mode(regs);
>  	local_daif_inherit(regs);
>  	do_sp_pc_abort(far, esr, regs);
>  	local_daif_mask();
> -	exit_to_kernel_mode(regs);
> +	exit_to_kernel_mode(regs, state);
>  }
>  
>  static void noinstr el1_undef(struct pt_regs *regs, unsigned long esr)
>  {
> -	enter_from_kernel_mode(regs);
> +	arm64_irqentry_state_t state = enter_from_kernel_mode(regs);
> +
>  	local_daif_inherit(regs);
>  	do_el1_undef(regs, esr);
>  	local_daif_mask();
> -	exit_to_kernel_mode(regs);
> +	exit_to_kernel_mode(regs, state);
>  }

I'd prefer if we consistently defined 'state' on a separate line, before
the main block consisting of:

	state = enter_from_kernel_mode(regs);
	local_daif_inherit(regs);
	do_el1_undef(regs, esr);
	local_daif_mask();
	exit_to_kernel_mode(regs, state);

... since that way the enter/exit functions clearly enclose the whole
block, which isn't as clear when there's a line gap between
enter_from_kernel_mode() and the rest of the block.

That would also be more consistent with what we do for functions that
need to read other registers (e.g. el1_abort() and el1_pc() above).

If that could be applied consistently here and below, that'd be great.

Mark.

>  static void noinstr el1_bti(struct pt_regs *regs, unsigned long esr)
>  {
> -	enter_from_kernel_mode(regs);
> +	arm64_irqentry_state_t state = enter_from_kernel_mode(regs);
> +
>  	local_daif_inherit(regs);
>  	do_el1_bti(regs, esr);
>  	local_daif_mask();
> -	exit_to_kernel_mode(regs);
> +	exit_to_kernel_mode(regs, state);
>  }
>  
>  static void noinstr el1_gcs(struct pt_regs *regs, unsigned long esr)
>  {
> -	enter_from_kernel_mode(regs);
> +	arm64_irqentry_state_t state = enter_from_kernel_mode(regs);
> +
>  	local_daif_inherit(regs);
>  	do_el1_gcs(regs, esr);
>  	local_daif_mask();
> -	exit_to_kernel_mode(regs);
> +	exit_to_kernel_mode(regs, state);
>  }
>  
>  static void noinstr el1_mops(struct pt_regs *regs, unsigned long esr)
>  {
> -	enter_from_kernel_mode(regs);
> +	arm64_irqentry_state_t state = enter_from_kernel_mode(regs);
> +
>  	local_daif_inherit(regs);
>  	do_el1_mops(regs, esr);
>  	local_daif_mask();
> -	exit_to_kernel_mode(regs);
> +	exit_to_kernel_mode(regs, state);
>  }
>  
>  static void noinstr el1_breakpt(struct pt_regs *regs, unsigned long esr)
>  {
> -	arm64_enter_el1_dbg(regs);
> +	arm64_irqentry_state_t state = arm64_enter_el1_dbg(regs);
> +
>  	debug_exception_enter(regs);
>  	do_breakpoint(esr, regs);
>  	debug_exception_exit(regs);
> -	arm64_exit_el1_dbg(regs);
> +	arm64_exit_el1_dbg(regs, state);
>  }
>  
>  static void noinstr el1_softstp(struct pt_regs *regs, unsigned long esr)
>  {
> -	arm64_enter_el1_dbg(regs);
> +	arm64_irqentry_state_t state = arm64_enter_el1_dbg(regs);
> +
>  	if (!cortex_a76_erratum_1463225_debug_handler(regs)) {
>  		debug_exception_enter(regs);
>  		/*
> @@ -554,37 +584,40 @@ static void noinstr el1_softstp(struct pt_regs *regs, unsigned long esr)
>  			do_el1_softstep(esr, regs);
>  		debug_exception_exit(regs);
>  	}
> -	arm64_exit_el1_dbg(regs);
> +	arm64_exit_el1_dbg(regs, state);
>  }
>  
>  static void noinstr el1_watchpt(struct pt_regs *regs, unsigned long esr)
>  {
>  	/* Watchpoints are the only debug exception to write FAR_EL1 */
>  	unsigned long far = read_sysreg(far_el1);
> +	arm64_irqentry_state_t state;
>  
> -	arm64_enter_el1_dbg(regs);
> +	state = arm64_enter_el1_dbg(regs);
>  	debug_exception_enter(regs);
>  	do_watchpoint(far, esr, regs);
>  	debug_exception_exit(regs);
> -	arm64_exit_el1_dbg(regs);
> +	arm64_exit_el1_dbg(regs, state);
>  }
>  
>  static void noinstr el1_brk64(struct pt_regs *regs, unsigned long esr)
>  {
> -	arm64_enter_el1_dbg(regs);
> +	arm64_irqentry_state_t state = arm64_enter_el1_dbg(regs);
> +
>  	debug_exception_enter(regs);
>  	do_el1_brk64(esr, regs);
>  	debug_exception_exit(regs);
> -	arm64_exit_el1_dbg(regs);
> +	arm64_exit_el1_dbg(regs, state);
>  }
>  
>  static void noinstr el1_fpac(struct pt_regs *regs, unsigned long esr)
>  {
> -	enter_from_kernel_mode(regs);
> +	arm64_irqentry_state_t state = enter_from_kernel_mode(regs);
> +
>  	local_daif_inherit(regs);
>  	do_el1_fpac(regs, esr);
>  	local_daif_mask();
> -	exit_to_kernel_mode(regs);
> +	exit_to_kernel_mode(regs, state);
>  }
>  
>  asmlinkage void noinstr el1h_64_sync_handler(struct pt_regs *regs)
> @@ -639,15 +672,16 @@ asmlinkage void noinstr el1h_64_sync_handler(struct pt_regs *regs)
>  static __always_inline void __el1_pnmi(struct pt_regs *regs,
>  				       void (*handler)(struct pt_regs *))
>  {
> -	arm64_enter_nmi(regs);
> +	arm64_irqentry_state_t state = arm64_enter_nmi(regs);
> +
>  	do_interrupt_handler(regs, handler);
> -	arm64_exit_nmi(regs);
> +	arm64_exit_nmi(regs, state);
>  }
>  
>  static __always_inline void __el1_irq(struct pt_regs *regs,
>  				      void (*handler)(struct pt_regs *))
>  {
> -	enter_from_kernel_mode(regs);
> +	arm64_irqentry_state_t state = enter_from_kernel_mode(regs);
>  
>  	irq_enter_rcu();
>  	do_interrupt_handler(regs, handler);
> @@ -655,7 +689,7 @@ static __always_inline void __el1_irq(struct pt_regs *regs,
>  
>  	arm64_preempt_schedule_irq();
>  
> -	exit_to_kernel_mode(regs);
> +	exit_to_kernel_mode(regs, state);
>  }
>  static void noinstr el1_interrupt(struct pt_regs *regs,
>  				  void (*handler)(struct pt_regs *))
> @@ -681,11 +715,12 @@ asmlinkage void noinstr el1h_64_fiq_handler(struct pt_regs *regs)
>  asmlinkage void noinstr el1h_64_error_handler(struct pt_regs *regs)
>  {
>  	unsigned long esr = read_sysreg(esr_el1);
> +	arm64_irqentry_state_t state;
>  
>  	local_daif_restore(DAIF_ERRCTX);
> -	arm64_enter_nmi(regs);
> +	state = arm64_enter_nmi(regs);
>  	do_serror(regs, esr);
> -	arm64_exit_nmi(regs);
> +	arm64_exit_nmi(regs, state);
>  }
>  
>  static void noinstr el0_da(struct pt_regs *regs, unsigned long esr)
> @@ -997,12 +1032,13 @@ asmlinkage void noinstr el0t_64_fiq_handler(struct pt_regs *regs)
>  static void noinstr __el0_error_handler_common(struct pt_regs *regs)
>  {
>  	unsigned long esr = read_sysreg(esr_el1);
> +	arm64_irqentry_state_t state;
>  
>  	enter_from_user_mode(regs);
>  	local_daif_restore(DAIF_ERRCTX);
> -	arm64_enter_nmi(regs);
> +	state = arm64_enter_nmi(regs);
>  	do_serror(regs, esr);
> -	arm64_exit_nmi(regs);
> +	arm64_exit_nmi(regs, state);
>  	local_daif_restore(DAIF_PROCCTX);
>  	exit_to_user_mode(regs);
>  }
> @@ -1122,6 +1158,7 @@ asmlinkage void noinstr __noreturn handle_bad_stack(struct pt_regs *regs)
>  asmlinkage noinstr unsigned long
>  __sdei_handler(struct pt_regs *regs, struct sdei_registered_event *arg)
>  {
> +	arm64_irqentry_state_t state;
>  	unsigned long ret;
>  
>  	/*
> @@ -1146,9 +1183,9 @@ __sdei_handler(struct pt_regs *regs, struct sdei_registered_event *arg)
>  	else if (cpu_has_pan())
>  		set_pstate_pan(0);
>  
> -	arm64_enter_nmi(regs);
> +	state = arm64_enter_nmi(regs);
>  	ret = do_sdei_event(regs, arg);
> -	arm64_exit_nmi(regs);
> +	arm64_exit_nmi(regs, state);
>  
>  	return ret;
>  }
> -- 
> 2.34.1
> 

