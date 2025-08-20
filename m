Return-Path: <linux-kernel+bounces-777273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74F24B2D794
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 11:09:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9DC327B70C4
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 09:08:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 150B92DFA32;
	Wed, 20 Aug 2025 09:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NXa+Lrtk"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94A0E2DD5F7
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 09:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755680871; cv=none; b=UMwpCM9daV797397KePe4/Zunpto5FxLasv5P41pVvkmQ3joPKdCi6I3eTu9ntqT3l/x9p4hHI08WR2WBOYQUr8smP8YOWkUeW6rW9QcISOkoApUAOHxsEIkOoxSEOAFFy0h1V2+1BXRk6vzBLSjoM3uM9ekRRtQM6Uey0zgt1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755680871; c=relaxed/simple;
	bh=NI3SMXaSUNQXgIS0unSURR/fRocEo6hfMV5pRESv2Ok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AbcOGrl7rk5Yc9V+8L8yAVbf0AySckXpAE+OTfVhl3hGQKT3twn1X8s/MLgDWKx0Mhep40HkmTE4Qcoya3fb1ufOsCWk7JanaBGhQEBtIjnOqfeXz578T0kJle8wmrcp1053+mJEUVMyDQM2J8uM9/VUmXd7Zwn8xdz45A4l8v0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=NXa+Lrtk; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=+dQFoPVMaOz9zldizhNLGttkBrQFkHnnF8ugKvUt9Rw=; b=NXa+Lrtk4tAW4cgiaOHXpsiEtm
	WVN2v0us53k+wWmD5CQIhcqCze/FByiPxuLdkvEkS342Hah6/gXuz8OG4rADU4AB6NvrDTj7bNtjh
	KKFk6cX/RVdMlRAnq3KPXPPjDSWhZ3r7s+yIB6IYFQVZr8Hxx1cRv2/RU+4FUS+J4i/hh4Jk7o7Ed
	pGicbUpydf5OK/+0pWIZ2h7S2Wo9H8RLyiSUYoWj226ZVL+9/SPVylNLXvViiyazTkMO6X6QG4FWU
	CN1lPbRNbyj6xc/BJfaQNVuWh8uUxDxexoYqdW3KnnWRT5ItUiC1mySTaIeR4IHH80szdgSeq8VbQ
	PqVKbaEA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uoen8-00000000FZf-2kj7;
	Wed, 20 Aug 2025 09:07:34 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 99860300385; Wed, 20 Aug 2025 11:07:33 +0200 (CEST)
Date: Wed, 20 Aug 2025 11:07:33 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Marcos Del Sol Vives <marcos@orca.pet>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Brian Gerst <brgerst@gmail.com>,
	Uros Bizjak <ubizjak@gmail.com>, Ard Biesheuvel <ardb@kernel.org>,
	David Kaplan <david.kaplan@amd.com>,
	"Ahmed S. Darwish" <darwi@linutronix.de>,
	Kees Cook <kees@kernel.org>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	Oleg Nesterov <oleg@redhat.com>, "Xin Li (Intel)" <xin@zytor.com>,
	Sabyrzhan Tasbolatov <snovitoll@gmail.com>
Subject: Re: [PATCH] x86: add hintable NOPs emulation
Message-ID: <20250820090733.GJ3245006@noisy.programming.kicks-ass.net>
References: <20250820013452.495481-1-marcos@orca.pet>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250820013452.495481-1-marcos@orca.pet>

On Wed, Aug 20, 2025 at 03:34:46AM +0200, Marcos Del Sol Vives wrote:
> Hintable NOPs are a series of instructions introduced by Intel with the
> Pentium Pro (i686), and described in US patent US5701442A.
> 
> These instructions were reserved to allow backwards-compatible changes
> in the instruction set possible, by having old processors treat them as
> variable-length NOPs, while having other semantics in modern processors.
> 
> Some modern uses are:
>  - Multi-byte/long NOPs
>  - Indirect Branch Tracking (ENDBR32)
>  - Shadow Stack (part of CET)
> 
> Some processors advertising i686 compatibility lack full support for
> them, which may cause #UD to be incorrectly triggered, crashing software
> that uses then with an unexpected SIGILL.
> 
> One such software is sudo in Debian bookworm, which is compiled with
> GCC -fcf-protection=branch and contains ENDBR32 instructions. It crashes
> on my Vortex86DX3 processor and VIA C3 Nehalem processors [1].
> 
> This patch is a much simplified version of my previous patch for x86
> instruction emulation [2], that only emulates hintable NOPs.
> 
> When #UD is raised, it checks if the opcode corresponds to a hintable NOP
> in user space. If true, it warns the user via the dmesg and advances the
> instruction pointer, thus emulating its expected NOP behaviour.
> 
> [1]: https://lists.debian.org/debian-devel/2023/10/msg00118.html
> [2]: https://lore.kernel.org/all/20210626130313.1283485-1-marcos@orca.pet/
> 
> Signed-off-by: Marcos Del Sol Vives <marcos@orca.pet>

This is going to be terribly slow if there's a significant number of
traps (like with endbr32), but yeah, this ought to work.

One indenting fail below, other than that:

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

> ---
>  arch/x86/Kconfig                 | 29 +++++++++++++++++++++++++
>  arch/x86/include/asm/processor.h |  4 ++++
>  arch/x86/kernel/process.c        |  3 +++
>  arch/x86/kernel/traps.c          | 36 ++++++++++++++++++++++++++++++++
>  4 files changed, 72 insertions(+)
> 
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 58d890fe2100..a6daebdc2573 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -1286,6 +1286,35 @@ config X86_IOPL_IOPERM
>  	  ability to disable interrupts from user space which would be
>  	  granted if the hardware IOPL mechanism would be used.
>  
> +config X86_HNOP_EMU
> +	bool "Hintable NOPs emulation"
> +	depends on X86_32
> +	default y
> +	help
> +	  Hintable NOPs are a series of instructions introduced by Intel with
> +	  the Pentium Pro (i686), and described in US patent US5701442A.
> +
> +	  These instructions were reserved to allow backwards-compatible
> +	  changes in the instruction set possible, by having old processors
> +	  treat them as variable-length NOPs, while having other semantics in
> +	  modern processors.
> +
> +	  Some modern uses are:
> +	   - Multi-byte/long NOPs
> +	   - Indirect Branch Tracking (ENDBR32)
> +	   - Shadow Stack (part of CET)
> +
> +	  Some processors advertising i686 compatibility (such as Cyrix MII,
> +	  VIA C3 Nehalem or DM&P Vortex86DX3) lack full support for them,
> +	  which may cause SIGILL to be incorrectly raised in user space when
> +	  a hintable NOP is encountered.
> +
> +	  Say Y here if you want the kernel to emulate them, allowing programs
> +	  that make use of them to run transparently on such processors.
> +
> +	  This emulation has no performance penalty for processors that
> +	  properly support them, so if unsure, enable it.
> +
>  config TOSHIBA
>  	tristate "Toshiba Laptop support"
>  	depends on X86_32
> diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
> index bde58f6510ac..c34fb678c4de 100644
> --- a/arch/x86/include/asm/processor.h
> +++ b/arch/x86/include/asm/processor.h
> @@ -499,6 +499,10 @@ struct thread_struct {
>  
>  	unsigned int		iopl_warn:1;
>  
> +#ifdef CONFIG_X86_HNOP_EMU
> +	unsigned int		hnop_warn:1;
> +#endif
> +
>  	/*
>  	 * Protection Keys Register for Userspace.  Loaded immediately on
>  	 * context switch. Store it in thread_struct to avoid a lookup in
> diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
> index 1b7960cf6eb0..6ec8021638d0 100644
> --- a/arch/x86/kernel/process.c
> +++ b/arch/x86/kernel/process.c
> @@ -178,6 +178,9 @@ int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
>  	p->thread.io_bitmap = NULL;
>  	clear_tsk_thread_flag(p, TIF_IO_BITMAP);
>  	p->thread.iopl_warn = 0;
> +#ifdef CONFIG_X86_HNOP_EMU
> +	p->thread.hnop_warn = 0;
> +#endif
>  	memset(p->thread.ptrace_bps, 0, sizeof(p->thread.ptrace_bps));
>  
>  #ifdef CONFIG_X86_64
> diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
> index 36354b470590..2dcb7d7edf8a 100644
> --- a/arch/x86/kernel/traps.c
> +++ b/arch/x86/kernel/traps.c
> @@ -295,12 +295,48 @@ DEFINE_IDTENTRY(exc_overflow)
>  	do_error_trap(regs, 0, "overflow", X86_TRAP_OF, SIGSEGV, 0, NULL);
>  }
>  
> +#ifdef CONFIG_X86_HNOP_EMU
> +static bool handle_hnop(struct pt_regs *regs)
> +{
> +	struct thread_struct *t = &current->thread;
> +	unsigned char buf[MAX_INSN_SIZE];
> +	unsigned long nr_copied;
> +	struct insn insn;
> +
> +	nr_copied = insn_fetch_from_user(regs, buf);
> +	if (nr_copied <= 0)
> +		return false;
> +
> +	if (!insn_decode_from_regs(&insn, regs, buf, nr_copied))
> +		return false;
> +
> +	/* Hintable NOPs cover 0F 18 to 0F 1F */
> +	if (insn.opcode.bytes[0] != 0x0F ||
> +		insn.opcode.bytes[1] < 0x18 || insn.opcode.bytes[1] > 0x1F)

That continuation wants to be aligned at (, not tab-width.

> +		return false;
> +
> +	if (!t->hnop_warn) {
> +		pr_warn_ratelimited("%s[%d] emulating hintable NOP, ip:%lx\n",
> +		       current->comm, task_pid_nr(current), regs->ip);
> +		t->hnop_warn = 1;
> +	}
> +
> +	regs->ip += insn.length;
> +	return true;
> +}
> +#endif
> +
>  #ifdef CONFIG_X86_F00F_BUG
>  void handle_invalid_op(struct pt_regs *regs)
>  #else
>  static inline void handle_invalid_op(struct pt_regs *regs)
>  #endif
>  {
> +#ifdef CONFIG_X86_HNOP_EMU
> +	if (user_mode(regs) && handle_hnop(regs))
> +		return;
> +#endif
> +
>  	do_error_trap(regs, 0, "invalid opcode", X86_TRAP_UD, SIGILL,
>  		      ILL_ILLOPN, error_get_trap_addr(regs));
>  }
> -- 
> 2.34.1
> 

