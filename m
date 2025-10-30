Return-Path: <linux-kernel+bounces-878216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57B73C200AD
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 13:37:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 498A0427D51
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 12:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD77330F804;
	Thu, 30 Oct 2025 12:35:38 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF307F4F1
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 12:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761827738; cv=none; b=qq/IjpeKSNSVoNyWFjGgeWS/QPRD7jhSqWiflOClddN9P6+b9idNfBRDvUmuP4LpsNZD8jMs6tZU4LL7VVSyYksSiUt9KT+FuwV1F+Ui5cZfnaiSTKcegQN1a9mkmWw0ade2+AyOH6N1CGcYE5Un1IEEkCLO06YADDIx10mepds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761827738; c=relaxed/simple;
	bh=tRVMJwxCjKlL+JJzZL7BklMciq6/9nBWlvXO1bPH9kE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L+ePpUfTys+AFUmI6cLt7gbYRseZxlW0E2Y9uIA0GHUUHrUBanqMN+CuVglrABegKQvBX/PBe6acq6+A6EdQcA3ZAnThtErWsgGkKV7ZFLCtiwD3nOrn+GAiir17Qd+N+0R7ztUkWyD+y7mQsNNHLAUMP4S+ZqKGqQHV1T0Xp04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4B6792C42;
	Thu, 30 Oct 2025 05:35:27 -0700 (PDT)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CB56D3F66E;
	Thu, 30 Oct 2025 05:35:33 -0700 (PDT)
Date: Thu, 30 Oct 2025 12:35:25 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Ben Niu <BenNiu@meta.com>
Cc: catalin.marinas@arm.com, will@kernel.org, tytso@mit.edu,
	Jason@zx2c4.com, linux-arm-kernel@lists.infradead.org,
	niuben003@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: Enable kprobe tracing for Arm64 asm functions
Message-ID: <aQNbjap69C6inZwb@J2N7QTR9R3>
References: <20251027181749.240466-1-benniu@meta.com>
 <aQIltqoIVDwh4A6p@J2N7QTR9R3>
 <aQKpDIYwO9VTP7qM@meta.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQKpDIYwO9VTP7qM@meta.com>

On Wed, Oct 29, 2025 at 04:53:48PM -0700, Ben Niu wrote:
> On Wed, Oct 29, 2025 at 02:33:26PM +0000, Mark Rutland wrote:
> > On Mon, Oct 27, 2025 at 11:17:49AM -0700, Ben Niu wrote:
> > > Currently, Arm64 assembly functions always have a bti c
> > > instruction inserted before the prologue. When ftrace is enabled,
> > > no padding nops are inserted at all.
> > > 
> > > This breaks kprobe tracing for asm functions, which assumes that
> > > proper nops are added before and within functions (when ftrace is
> > > enabled) and bti c is only present when CONFIG_ARM64_BTI_KERNEL is
> > > defined.
> > 
> > What exactly do you mean by "breaks kprobe tracing"?
> > 
> > The kprobes code knows NOTHING about those ftrace NOPs, so I cannot see
> > how those are relevant.
> > 
> > The patch adds entries to __patchable_function_entries, which is owned
> > by ftrace, and has NOTHING to do with kprobes.
> 
> Thanks for reviewing my patch, Mark. This is the second ever Linux kernel patch
> I've sent out so I'm still learning how much detail I should put in a patch for
> reviewers. Clearly, not enough details were added for this patch, and sorry
> about that.

Hi Ben,

Thanks, and sorry for the overly strong tone of my initial reply.

My key concern above was that "breaks kprobe tracing" sounds like
something is seriously wrong, whereas IIUC the problem you're trying to
address is "it isn't currently possible to place a trace kprobe on an
assembly function" (i.e. there's a limitation, not a bug).

> kprobe and ftrace seem two seprate things, but kprobe actually checks if a
> function is notrace based off whether the function is padded with proper nops
> for ftrace when ftrace is enabled. See the following call stack for more
> details (obtained by debugging centos 10 arm64 linux kernel):
> 
> #0  lookup_rec (start=18446603338384966592, end=18446603338384967175) at kernel/trace/ftrace.c:1591
> #1  ftrace_location_range (start=18446603338384966592, end=18446603338384967175) at kernel/trace/ftrace.c:1626
> #2  0xffff8000802bd070 [PAC] in __within_notrace_func (addr=<optimized out>, addr@entry=18446603338384966592) at kernel/trace/trace_kprobe.c:456
> #3  0xffff8000802bd13c [PAC] in within_notrace_func (tk=0xffff0000cb5b0400) at kernel/trace/trace_kprobe.c:464
> #4  0xffff8000802bd534 [PAC] in __register_trace_kprobe (tk=tk@entry=0xffff0000cb5b0400) at kernel/trace/trace_kprobe.c:496
> #5  0xffff8000802bf7a0 [PAC] in __register_trace_kprobe (tk=0xffff0000cb5b0400) at kernel/trace/trace_kprobe.c:490
> #6  create_local_trace_kprobe (func=func@entry=0xffff0000cabb19c0 "__arch_copy_to_user", addr=<optimized out>, offs=<optimized out>, is_return=is_return@entry=false)
>     at kernel/trace/trace_kprobe.c:1935
> #7  0xffff80008029ef8c [PAC] in perf_kprobe_init (p_event=p_event@entry=0xffff0000c6d89a40, is_retprobe=false) at kernel/trace/trace_event_perf.c:267
> #8  0xffff800080364ec4 [PAC] in perf_kprobe_event_init (event=0xffff0000c6d89a40) at kernel/events/core.c:11102
> #9  0xffff800080369740 [PAC] in perf_try_init_event (pmu=0xffff8000829347a8 <perf_kprobe>, event=0xffff0000c6d89a40) at kernel/events/core.c:12595
> #10 0xffff8000803699dc [PAC] in perf_init_event (event=event@entry=0xffff0000c6d89a40) at kernel/events/core.c:12693
> #11 0xffff80008036d91c [PAC] in perf_event_alloc (attr=attr@entry=0xffff80008785b970, cpu=cpu@entry=0, task=task@entry=0x0, group_leader=0xffff0000c6d89a40, 
>     group_leader@entry=0x0, parent_event=parent_event@entry=0x0, overflow_handler=<optimized out>, overflow_handler@entry=0x0, context=<optimized out>, context@entry=0x0, 
>     cgroup_fd=cgroup_fd@entry=-1) at kernel/events/core.c:12968
> #12 0xffff800080373244 [PAC] in __do_sys_perf_event_open (attr_uptr=<optimized out>, pid=<optimized out>, cpu=0, group_fd=<optimized out>, flags=<optimized out>)
>     at kernel/events/core.c:13485
> #13 0xffff800080379aa0 [PAC] in __se_sys_perf_event_open (attr_uptr=<optimized out>, pid=<optimized out>, cpu=<optimized out>, group_fd=<optimized out>, flags=<optimized out>)
>     at kernel/events/core.c:13367
> #14 __arm64_sys_perf_event_open (regs=<optimized out>) at kernel/events/core.c:13367
> #15 0xffff80008004997c [PAC] in __invoke_syscall (regs=0xffff80008785beb0, syscall_fn=<optimized out>) at arch/arm64/kernel/syscall.c:35
> #16 invoke_syscall (regs=regs@entry=0xffff80008785beb0, scno=<optimized out>, sc_nr=sc_nr@entry=463, syscall_table=<optimized out>) at arch/arm64/kernel/syscall.c:49
> #17 0xffff800080049a88 [PAC] in el0_svc_common (sc_nr=463, syscall_table=<optimized out>, regs=0xffff80008785beb0, scno=<optimized out>) at arch/arm64/kernel/syscall.c:132
> #18 do_el0_svc (regs=regs@entry=0xffff80008785beb0) at arch/arm64/kernel/syscall.c:151
> #19 0xffff800080fba654 [PAC] in el0_svc (regs=0xffff80008785beb0) at arch/arm64/kernel/entry-common.c:875
> #20 0xffff800080fbab10 [PAC] in el0t_64_sync_handler (regs=<optimized out>) at arch/arm64/kernel/entry-common.c:894
> #21 0xffff800080011684 [PAC] in el0t_64_sync () at arch/arm64/kernel/entry.S:600

Sorry, I had forgotten that trace kprobes do apply this restriction;
thanks for explaining this.

Please note that basic kprobes (i.e. those opened directly by
register_kprobe()) aren't subject to this restriction; the checks in
check_kprobe_address_safe() do not include !within_notrace_func(). This
restriction only applies to trace kprobes (which use the tracing
infrastructure).

> within_notrace_func is only defined if defined(CONFIG_DYNAMIC_FTRACE) && \
> !defined(CONFIG_KPROBE_EVENTS_ON_NOTRACE), which searches a list of records
> about whether a function is ftrace-able or not. The list of records is built
> by ftrace_init at boot time.
>  
> > > The patch fixes the bug by inserting nops and bti c in Arm64 asm
> > > in the same way as compiled C code.
> 
> That's correct. I added __patchable_function_entries in assemblies so that
> their addresses are added between __start_mcount_loc and __stop_mcount_loc
> at link time, which is then picked up by ftrace_init. Proper nop and bti c
> instructions are added to assemblies in the way as if the assemblies are
> compiled from C code. This is crucial to satisfy ftrace requirements and nop
> patching at boot time. Otherwise, ftrace_bug will be hit and the assembly
> function won't be ftrace-able and also kprobe-traceable.

Do you actually need these functions to be ftrace traceable, or do you
just care that they can be traced via trace kprobes?

Why does this matter specifically for arm64, and not for other
architectures? AFAICT x86 doesn't do anything to make assembly functions
traceable by ftrace either.

Is there something specific you want to trace, but cannot currently
trace (on arm64)?

> > As it stands, NAK to this change.
> > 
> > I'm not averse to making (some) assembly functions traceable by ftrace,
> > and hence giving those NOPs. However, that's not safe generally (e.g.
> > due to noinstr requirements), and so special care will need to be taken.
> 
> Assemblies that are not traceable should use SYM_CODE_START or the new macro
> SYM_FUNC_START_NOTRACE. If an assembly function starts with SYM_FUNC_START,
> by default, it's assumed to be traceable. I dumped all assemblies under
> arch/arm64, and majority of the assemblies are utility functions (e.g., crypto,
> memset/memcpy, etc.), which seemed safe to trace. 

For better or worse, that is not the case. For example, it is not safe
to trace memset() or memcpy(), because those can be used by noinstr
code. Similarly those can be used early during handling of a kprobe,
resulting in a recursive exception (which will cause a fatal stack
overflow).

> There are a few functions
> in the following (and maybe others) that might not be traceable, so please
> advise.
> ./kernel/entry-ftrace.S
> ./kernel/entry.S
> ./mm/proc.S
> ./kernel/head.S

Practically nothing in those files is safe to trace.

There are plenty of other assembly which must not be traced, e.g.
anything with a "__pi_" prefix.

> We can either have SYM_FUNC_START be traceable by default, or flip the polarity
> and introduce SYM_FUNC_START_TRACEABLE to explicitly mark those functions
> deemed safe to trace.

I would be much happier with the latter (or something to that effect).
However, as with my question about x86 above, I'd like a better
explanation as to why you need to trace assembly functions in the first
place.

The existing restrictions could do with some cleanup, and we might be
able to make it possible use a kprobe tracepoint on functions/code
*without* requiring that it's possible to place an ftrace tracepoint.

Mark.

> > The rationale above does not make sense; it conflates distinct things,
> > and I think a more complete explanation is necessary.
> 
> Please see my explanation above. If you have any questions, please let me know.
> 
> > Mark.
> > 
> > > Note: although this patch unblocks kprobe tracing, fentry is still
> > > broken because no BTF info gets generated from assembly files. A
> > > separate patch is needed to fix that.
> > > 
> > > I built this patch with different combos of the following features
> > > and confirmed kprobe tracing for asm function __arch_copy_to_user
> > > worked in all cases:
> > > 
> > > CONFIG_DYNAMIC_FTRACE_WITH_CALL_OPS
> > > CONFIG_DYNAMIC_FTRACE_WITH_ARGS
> > > CONFIG_ARM64_BTI_KERNEL
> > > 
> > > Signed-off-by: Ben Niu <benniu@meta.com>
> > > ---
> > >  arch/arm64/include/asm/linkage.h           | 103 ++++++++++++++++-----
> > >  arch/arm64/kernel/vdso/vgetrandom-chacha.S |   2 +-
> > >  2 files changed, 81 insertions(+), 24 deletions(-)
> > > 
> > > diff --git a/arch/arm64/include/asm/linkage.h b/arch/arm64/include/asm/linkage.h
> > > index d3acd9c87509..f3f3bc168162 100644
> > > --- a/arch/arm64/include/asm/linkage.h
> > > +++ b/arch/arm64/include/asm/linkage.h
> > > @@ -5,8 +5,47 @@
> > >  #include <asm/assembler.h>
> > >  #endif
> > >  
> > > -#define __ALIGN		.balign CONFIG_FUNCTION_ALIGNMENT
> > > -#define __ALIGN_STR	".balign " #CONFIG_FUNCTION_ALIGNMENT
> > > +#define __ALIGN .balign CONFIG_FUNCTION_ALIGNMENT
> > > +#define __ALIGN_STR ".balign " #CONFIG_FUNCTION_ALIGNMENT
> > > +
> > > +#ifdef CONFIG_DYNAMIC_FTRACE_WITH_CALL_OPS
> > > +
> > > +#define PRE_FUNCTION_NOPS                                                   \
> > > +	ALIGN;                                                              \
> > > +	nops CONFIG_FUNCTION_ALIGNMENT / 4 - 2;                             \
> > > +	.pushsection __patchable_function_entries, "awo", @progbits, .text; \
> > > +	.p2align 3;                                                         \
> > > +	.8byte 1f;                                                          \
> > > +	.popsection;                                                        \
> > > +	1 :;                                                                \
> > > +	nops 2;
> > > +
> > > +#define PRE_PROLOGUE_NOPS nops 2;
> > > +
> > > +#elif defined(CONFIG_DYNAMIC_FTRACE_WITH_ARGS)
> > > +
> > > +#define PRE_FUNCTION_NOPS
> > > +
> > > +#define PRE_PROLOGUE_NOPS                                                   \
> > > +	.pushsection __patchable_function_entries, "awo", @progbits, .text; \
> > > +	.p2align 3;                                                         \
> > > +	.8byte 1f;                                                          \
> > > +	.popsection;                                                        \
> > > +	1 :;                                                                \
> > > +	nops 2;
> > > +
> > > +#else
> > > +
> > > +#define PRE_FUNCTION_NOPS
> > > +#define PRE_PROLOGUE_NOPS
> > > +
> > > +#endif
> > > +
> > > +#ifdef CONFIG_ARM64_BTI_KERNEL
> > > +#define BTI_C bti c;
> > > +#else
> > > +#define BTI_C
> > > +#endif
> > >  
> > >  /*
> > >   * When using in-kernel BTI we need to ensure that PCS-conformant
> > > @@ -15,32 +54,50 @@
> > >   * everything, the override is done unconditionally so we're more
> > >   * likely to notice any drift from the overridden definitions.
> > >   */
> > > -#define SYM_FUNC_START(name)				\
> > > -	SYM_START(name, SYM_L_GLOBAL, SYM_A_ALIGN)	\
> > > -	bti c ;
> > > +#define SYM_FUNC_START(name)                       \
> > > +	PRE_FUNCTION_NOPS                          \
> > > +	SYM_START(name, SYM_L_GLOBAL, SYM_A_ALIGN) \
> > > +	BTI_C                                      \
> > > +	PRE_PROLOGUE_NOPS
> > > +
> > > +#define SYM_FUNC_START_NOTRACE(name)               \
> > > +	SYM_START(name, SYM_L_GLOBAL, SYM_A_ALIGN) \
> > > +	BTI_C
> > >  
> > > -#define SYM_FUNC_START_NOALIGN(name)			\
> > > -	SYM_START(name, SYM_L_GLOBAL, SYM_A_NONE)	\
> > > -	bti c ;
> > > +#define SYM_FUNC_START_NOALIGN(name)              \
> > > +	PRE_FUNCTION_NOPS                         \
> > > +	SYM_START(name, SYM_L_GLOBAL, SYM_A_NONE) \
> > > +	BTI_C                                     \
> > > +	PRE_PROLOGUE_NOPS
> > >  
> > > -#define SYM_FUNC_START_LOCAL(name)			\
> > > -	SYM_START(name, SYM_L_LOCAL, SYM_A_ALIGN)	\
> > > -	bti c ;
> > > +#define SYM_FUNC_START_LOCAL(name)                \
> > > +	PRE_FUNCTION_NOPS                         \
> > > +	SYM_START(name, SYM_L_LOCAL, SYM_A_ALIGN) \
> > > +	BTI_C                                     \
> > > +	PRE_PROLOGUE_NOPS
> > >  
> > > -#define SYM_FUNC_START_LOCAL_NOALIGN(name)		\
> > > -	SYM_START(name, SYM_L_LOCAL, SYM_A_NONE)	\
> > > -	bti c ;
> > > +#define SYM_FUNC_START_LOCAL_NOALIGN(name)       \
> > > +	PRE_FUNCTION_NOPS                        \
> > > +	SYM_START(name, SYM_L_LOCAL, SYM_A_NONE) \
> > > +	BTI_C                                    \
> > > +	PRE_PROLOGUE_NOPS
> > >  
> > > -#define SYM_FUNC_START_WEAK(name)			\
> > > -	SYM_START(name, SYM_L_WEAK, SYM_A_ALIGN)	\
> > > -	bti c ;
> > > +#define SYM_FUNC_START_WEAK(name)                \
> > > +	PRE_FUNCTION_NOPS                        \
> > > +	SYM_START(name, SYM_L_WEAK, SYM_A_ALIGN) \
> > > +	BTI_C                                    \
> > > +	PRE_PROLOGUE_NOPS
> > >  
> > > -#define SYM_FUNC_START_WEAK_NOALIGN(name)		\
> > > -	SYM_START(name, SYM_L_WEAK, SYM_A_NONE)		\
> > > -	bti c ;
> > > +#define SYM_FUNC_START_WEAK_NOALIGN(name)       \
> > > +	PRE_FUNCTION_NOPS                       \
> > > +	SYM_START(name, SYM_L_WEAK, SYM_A_NONE) \
> > > +	BTI_C                                   \
> > > +	PRE_PROLOGUE_NOPS
> > >  
> > > -#define SYM_TYPED_FUNC_START(name)				\
> > > -	SYM_TYPED_START(name, SYM_L_GLOBAL, SYM_A_ALIGN)	\
> > > -	bti c ;
> > > +#define SYM_TYPED_FUNC_START(name)                       \
> > > +	PRE_FUNCTION_NOPS                                \
> > > +	SYM_TYPED_START(name, SYM_L_GLOBAL, SYM_A_ALIGN) \
> > > +	BTI_C                                            \
> > > +	PRE_PROLOGUE_NOPS
> > >  
> > >  #endif
> > > diff --git a/arch/arm64/kernel/vdso/vgetrandom-chacha.S b/arch/arm64/kernel/vdso/vgetrandom-chacha.S
> > > index 67890b445309..21c27b64cf9f 100644
> > > --- a/arch/arm64/kernel/vdso/vgetrandom-chacha.S
> > > +++ b/arch/arm64/kernel/vdso/vgetrandom-chacha.S
> > > @@ -40,7 +40,7 @@
> > >   *	x2: 8-byte counter input/output
> > >   *	x3: number of 64-byte block to write to output
> > >   */
> > > -SYM_FUNC_START(__arch_chacha20_blocks_nostack)
> > > +SYM_FUNC_START_NOTRACE(__arch_chacha20_blocks_nostack)
> > >  
> > >  	/* copy0 = "expand 32-byte k" */
> > >  	mov_q		x8, 0x3320646e61707865
> > > -- 
> > > 2.47.3
> > > 
> > > 

