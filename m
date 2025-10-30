Return-Path: <linux-kernel+bounces-878898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DD7D7C21B8E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 19:16:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 34EC84EC419
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 18:09:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD11C36E37A;
	Thu, 30 Oct 2025 18:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="kIRKI7ns"
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C54472F3C20
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 18:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761847695; cv=none; b=hY1vyxJR+ImPtnbBKG1DmrWSm6BElPh+lUNJVXhjjziVuJB+V4VsQFm1N/EXUwnbmYp3rgjf+vVAqHRDtAsU4iLzErKLTrJpHJWLOLkAUGl9lT+ALHPE/RAwat89UkpOHyQSH5fdQWQklseRczG2LEY13cs8grNVQrOwEUKY6uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761847695; c=relaxed/simple;
	bh=eWMxPtwiwxPVEQlKe4mFS1h3elXIBlOynhg+JJdVP4U=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WKeqaLORJKt5ZIbMgjPEBS4ZVRn8d6IOU9lbQPHE6mKEBH688teTsS42NxNaZb65FNallAl0YMhBF3SZ9NvD9zhQnPq1J7awvPiJ3VtATsyjeuZY1FrbdpleAZ6id5+oWbdctR07WFXy8RiEdGbxwEI+TKhGMgj0sp4TQm90X+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=kIRKI7ns; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 59UGrjmp2754990
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 11:08:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=s2048-2025-q2; bh=htook0j4HEwIhyVlxvXh
	XhycBk4VSOr3yglOIuvM54g=; b=kIRKI7nsN3uQQe4PD7MbgDAMUD6YBiHQjvtD
	Ma2b8tq6WlikLcLlc1yfIW9p6pUuNIOegO+aTQLmY11WcHEbOJxzcqDeQNzEROkE
	nOreC5H9iS0Yxk0geIGvziguM7cdB3z/mEQYgOFogrqq8eUWKzzCkenRo/aiTuKa
	YQl5MTnzH3/13f/zZJyPwSrmyWGBW09sqhir3iEAtwEpV2mScU7GRVwS7Ko2PRNw
	UTjT8WaPzdbZgAR4nhIqvuwb1opoeUriUWQ8aUhmCz0nRdP7Jclr/DdbbUPyTjQL
	exy6zG/7974CtWj1fJhUYL0RhcZ3/iGRvqcc/vI0G8a0S4wTbg==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by m0089730.ppops.net (PPS) with ESMTPS id 4a4bxngphk-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 11:08:09 -0700 (PDT)
Received: from twshared63906.02.prn5.facebook.com (2620:10d:c0a8:1b::2d) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.20; Thu, 30 Oct 2025 18:07:57 +0000
Received: by devbig071.cco5.facebook.com (Postfix, from userid 704538)
	id A693A7C31611; Thu, 30 Oct 2025 11:07:51 -0700 (PDT)
Date: Thu, 30 Oct 2025 11:07:51 -0700
From: Ben Niu <BenNiu@meta.com>
To: Mark Rutland <mark.rutland@arm.com>
CC: <catalin.marinas@arm.com>, <will@kernel.org>, <tytso@mit.edu>,
        <Jason@zx2c4.com>, <linux-arm-kernel@lists.infradead.org>,
        <niuben003@gmail.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tracing: Enable kprobe tracing for Arm64 asm functions
Message-ID: <aQOpd14RXnyQLOWR@meta.com>
References: <20251027181749.240466-1-benniu@meta.com>
 <aQIltqoIVDwh4A6p@J2N7QTR9R3>
 <aQKpDIYwO9VTP7qM@meta.com>
 <aQNbjap69C6inZwb@J2N7QTR9R3>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aQNbjap69C6inZwb@J2N7QTR9R3>
X-FB-Internal: Safe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMwMDE1MCBTYWx0ZWRfX8j6L5Lmb2UUr
 GnDBb/Xw1hd05lHDCWAXOwIktZFW0uKifC8jT3fCR6gyZjSN9M5TQV4NWVtf03K6T+2kqSX2wDL
 d8lzBtCu8Iown7kinPXJVVkB5vPrrgrXxh+FICthRZcwZl2pgRJAtNnG8r5+aBLeqQhWHGJ6sf2
 SXGC8rIm0peqmjPjjcB5gXjs78wLZGJ8xKbj9rWyKvzUJtaAckRzBmfTpX8tnlZU9y90ADEDFrI
 iCTIivvtmdJHN2tRR5LhfjeaUhQledT/IzxmMCiwy17QW5ujQWr5IdExS9i+Hcab06SRGiSpdct
 5R2blHqDqs8RLDEDvF0oCHnhb/MGuO21wTWCiuH9eUmkXDbzLxCSwsAzguDfsjKxST0qERXxYrb
 yJ3VKwwoZT1+89YA0rNfQ+qocQWjyQ==
X-Proofpoint-GUID: C_cqC4RBMSF_tb7uTGjgGi7FpNfrdJ-U
X-Proofpoint-ORIG-GUID: C_cqC4RBMSF_tb7uTGjgGi7FpNfrdJ-U
X-Authority-Analysis: v=2.4 cv=JPo2csKb c=1 sm=1 tr=0 ts=6903a989 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=kj9zAlcOel0A:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VabnemYjAAAA:8 a=WlImhn6kQVJELLtN0j0A:9 a=CjuIK1q_8ugA:10
 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-30_06,2025-10-29_03,2025-10-01_01

On Thu, Oct 30, 2025 at 12:35:25PM +0000, Mark Rutland wrote:
> On Wed, Oct 29, 2025 at 04:53:48PM -0700, Ben Niu wrote:
> > On Wed, Oct 29, 2025 at 02:33:26PM +0000, Mark Rutland wrote:
> > > On Mon, Oct 27, 2025 at 11:17:49AM -0700, Ben Niu wrote:
> > > > Currently, Arm64 assembly functions always have a bti c
> > > > instruction inserted before the prologue. When ftrace is enabled,
> > > > no padding nops are inserted at all.
> > > > 
> > > > This breaks kprobe tracing for asm functions, which assumes that
> > > > proper nops are added before and within functions (when ftrace is
> > > > enabled) and bti c is only present when CONFIG_ARM64_BTI_KERNEL is
> > > > defined.
> > > 
> > > What exactly do you mean by "breaks kprobe tracing"?
> > > 
> > > The kprobes code knows NOTHING about those ftrace NOPs, so I cannot see
> > > how those are relevant.
> > > 
> > > The patch adds entries to __patchable_function_entries, which is owned
> > > by ftrace, and has NOTHING to do with kprobes.
> > 
> > Thanks for reviewing my patch, Mark. This is the second ever Linux kernel patch
> > I've sent out so I'm still learning how much detail I should put in a patch for
> > reviewers. Clearly, not enough details were added for this patch, and sorry
> > about that.
> 
> Hi Ben,
> 
> Thanks, and sorry for the overly strong tone of my initial reply.
> 
> My key concern above was that "breaks kprobe tracing" sounds like
> something is seriously wrong, whereas IIUC the problem you're trying to
> address is "it isn't currently possible to place a trace kprobe on an
> assembly function" (i.e. there's a limitation, not a bug).

Ok, sounds good. If it's a limitation, I shouldn't have used "breaks kprobe
tracing". :)

> > kprobe and ftrace seem two seprate things, but kprobe actually checks if a
> > function is notrace based off whether the function is padded with proper nops
> > for ftrace when ftrace is enabled. See the following call stack for more
> > details (obtained by debugging centos 10 arm64 linux kernel):
> > 
> > #0  lookup_rec (start=18446603338384966592, end=18446603338384967175) at kernel/trace/ftrace.c:1591
> > #1  ftrace_location_range (start=18446603338384966592, end=18446603338384967175) at kernel/trace/ftrace.c:1626
> > #2  0xffff8000802bd070 [PAC] in __within_notrace_func (addr=<optimized out>, addr@entry=18446603338384966592) at kernel/trace/trace_kprobe.c:456
> > #3  0xffff8000802bd13c [PAC] in within_notrace_func (tk=0xffff0000cb5b0400) at kernel/trace/trace_kprobe.c:464
> > #4  0xffff8000802bd534 [PAC] in __register_trace_kprobe (tk=tk@entry=0xffff0000cb5b0400) at kernel/trace/trace_kprobe.c:496
> > #5  0xffff8000802bf7a0 [PAC] in __register_trace_kprobe (tk=0xffff0000cb5b0400) at kernel/trace/trace_kprobe.c:490
> > #6  create_local_trace_kprobe (func=func@entry=0xffff0000cabb19c0 "__arch_copy_to_user", addr=<optimized out>, offs=<optimized out>, is_return=is_return@entry=false)
> >     at kernel/trace/trace_kprobe.c:1935
> > #7  0xffff80008029ef8c [PAC] in perf_kprobe_init (p_event=p_event@entry=0xffff0000c6d89a40, is_retprobe=false) at kernel/trace/trace_event_perf.c:267
> > #8  0xffff800080364ec4 [PAC] in perf_kprobe_event_init (event=0xffff0000c6d89a40) at kernel/events/core.c:11102
> > #9  0xffff800080369740 [PAC] in perf_try_init_event (pmu=0xffff8000829347a8 <perf_kprobe>, event=0xffff0000c6d89a40) at kernel/events/core.c:12595
> > #10 0xffff8000803699dc [PAC] in perf_init_event (event=event@entry=0xffff0000c6d89a40) at kernel/events/core.c:12693
> > #11 0xffff80008036d91c [PAC] in perf_event_alloc (attr=attr@entry=0xffff80008785b970, cpu=cpu@entry=0, task=task@entry=0x0, group_leader=0xffff0000c6d89a40, 
> >     group_leader@entry=0x0, parent_event=parent_event@entry=0x0, overflow_handler=<optimized out>, overflow_handler@entry=0x0, context=<optimized out>, context@entry=0x0, 
> >     cgroup_fd=cgroup_fd@entry=-1) at kernel/events/core.c:12968
> > #12 0xffff800080373244 [PAC] in __do_sys_perf_event_open (attr_uptr=<optimized out>, pid=<optimized out>, cpu=0, group_fd=<optimized out>, flags=<optimized out>)
> >     at kernel/events/core.c:13485
> > #13 0xffff800080379aa0 [PAC] in __se_sys_perf_event_open (attr_uptr=<optimized out>, pid=<optimized out>, cpu=<optimized out>, group_fd=<optimized out>, flags=<optimized out>)
> >     at kernel/events/core.c:13367
> > #14 __arm64_sys_perf_event_open (regs=<optimized out>) at kernel/events/core.c:13367
> > #15 0xffff80008004997c [PAC] in __invoke_syscall (regs=0xffff80008785beb0, syscall_fn=<optimized out>) at arch/arm64/kernel/syscall.c:35
> > #16 invoke_syscall (regs=regs@entry=0xffff80008785beb0, scno=<optimized out>, sc_nr=sc_nr@entry=463, syscall_table=<optimized out>) at arch/arm64/kernel/syscall.c:49
> > #17 0xffff800080049a88 [PAC] in el0_svc_common (sc_nr=463, syscall_table=<optimized out>, regs=0xffff80008785beb0, scno=<optimized out>) at arch/arm64/kernel/syscall.c:132
> > #18 do_el0_svc (regs=regs@entry=0xffff80008785beb0) at arch/arm64/kernel/syscall.c:151
> > #19 0xffff800080fba654 [PAC] in el0_svc (regs=0xffff80008785beb0) at arch/arm64/kernel/entry-common.c:875
> > #20 0xffff800080fbab10 [PAC] in el0t_64_sync_handler (regs=<optimized out>) at arch/arm64/kernel/entry-common.c:894
> > #21 0xffff800080011684 [PAC] in el0t_64_sync () at arch/arm64/kernel/entry.S:600
> 
> Sorry, I had forgotten that trace kprobes do apply this restriction;
> thanks for explaining this.
> 
> Please note that basic kprobes (i.e. those opened directly by
> register_kprobe()) aren't subject to this restriction; the checks in
> check_kprobe_address_safe() do not include !within_notrace_func(). This
> restriction only applies to trace kprobes (which use the tracing
> infrastructure).

Right within_notrace_func is just (false) when ftrace is not enabled.

> > within_notrace_func is only defined if defined(CONFIG_DYNAMIC_FTRACE) && \
> > !defined(CONFIG_KPROBE_EVENTS_ON_NOTRACE), which searches a list of records
> > about whether a function is ftrace-able or not. The list of records is built
> > by ftrace_init at boot time.
> >  
> > > > The patch fixes the bug by inserting nops and bti c in Arm64 asm
> > > > in the same way as compiled C code.
> > 
> > That's correct. I added __patchable_function_entries in assemblies so that
> > their addresses are added between __start_mcount_loc and __stop_mcount_loc
> > at link time, which is then picked up by ftrace_init. Proper nop and bti c
> > instructions are added to assemblies in the way as if the assemblies are
> > compiled from C code. This is crucial to satisfy ftrace requirements and nop
> > patching at boot time. Otherwise, ftrace_bug will be hit and the assembly
> > function won't be ftrace-able and also kprobe-traceable.
> 
> Do you actually need these functions to be ftrace traceable, or do you
> just care that they can be traced via trace kprobes?

We don't care if they are traced by ftrace or kprobes. Actually, as I mentioned
in the original email, even with my patch, ftrace still does not work for those
assembly functions because of lack of BTF info in assemblies. Adding those nops
only unblocks kprobes and it's good enough for us.
 
> Why does this matter specifically for arm64, and not for other
> architectures? AFAICT x86 doesn't do anything to make assembly functions
> traceable by ftrace either.
>
> Is there something specific you want to trace, but cannot currently
> trace (on arm64)?

For some reason, we only saw Arm64 Linux asm functions __arch_copy_to_user and
__arch_copy_from_user being hot in our workloads, not those counterpart asm
functions on x86, so we are trying to understand and improve performance of
those Arm64 asm functions. This patch mainly helps understand the workloads
and the following patch tries to improve the performance. Enabling tracing
will help us tune the asm functions. In addition, Arm64 future-gen CPUs will
support FEAT_MOPS, which include instructions copying data between user and
kernel. Thanks to tracing support, we may also help Arm tune their FEAT_MOPS
implementations.

20251018052237.1368504-2-benniu@meta.com

Although I would also love to trace x86 asm functions, it's not my focus right
now and we don't have any demand for that. Plus, fixing assemblies of different
CPUs will involve folks from different companies in the same email chain, which
may increase communication cost.
 
> > > As it stands, NAK to this change.
> > > 
> > > I'm not averse to making (some) assembly functions traceable by ftrace,
> > > and hence giving those NOPs. However, that's not safe generally (e.g.
> > > due to noinstr requirements), and so special care will need to be taken.
> > 
> > Assemblies that are not traceable should use SYM_CODE_START or the new macro
> > SYM_FUNC_START_NOTRACE. If an assembly function starts with SYM_FUNC_START,
> > by default, it's assumed to be traceable. I dumped all assemblies under
> > arch/arm64, and majority of the assemblies are utility functions (e.g., crypto,
> > memset/memcpy, etc.), which seemed safe to trace. 
> 
> For better or worse, that is not the case. For example, it is not safe
> to trace memset() or memcpy(), because those can be used by noinstr
> code. Similarly those can be used early during handling of a kprobe,
> resulting in a recursive exception (which will cause a fatal stack
> overflow).
> 
> > There are a few functions
> > in the following (and maybe others) that might not be traceable, so please
> > advise.
> > ./kernel/entry-ftrace.S
> > ./kernel/entry.S
> > ./mm/proc.S
> > ./kernel/head.S
> 
> Practically nothing in those files is safe to trace.
> 
> There are plenty of other assembly which must not be traced, e.g.
> anything with a "__pi_" prefix. 

Ok, thanks, this is critical info.

> > We can either have SYM_FUNC_START be traceable by default, or flip the polarity
> > and introduce SYM_FUNC_START_TRACEABLE to explicitly mark those functions
> > deemed safe to trace.
> 
> I would be much happier with the latter (or something to that effect).
> However, as with my question about x86 above, I'd like a better
> explanation as to why you need to trace assembly functions in the first
> place.

Please see my explanation above. In short, we do need tracing support for
__arch_copy_from_user and __arch_copy_to_user to better understand our workloads
and how to tune the new implementations for those two asm functions.

> The existing restrictions could do with some cleanup, and we might be
> able to make it possible use a kprobe tracepoint on functions/code
> *without* requiring that it's possible to place an ftrace tracepoint.

Right, that's another way to enable tracing for asm functions. I thought about
it but didn't pursue that because adding nops makes the asm functions look
similar to compiled C code, which unifies code gen and makes it possible to
enable ftrace for asm functions in the future. Furthermore, it limits the scope
of changes to only Arm64 without touching the kprobe/ftrace infra. However, if
kprobe/ftrace maintainers are ok with adding new logic for kprobe to not look at
within_notrace_func for asm functions, I'm also happy to go that route.

Ben

> Mark.
> 
> > > The rationale above does not make sense; it conflates distinct things,
> > > and I think a more complete explanation is necessary.
> > 
> > Please see my explanation above. If you have any questions, please let me know.
> > 
> > > Mark.
> > > 
> > > > Note: although this patch unblocks kprobe tracing, fentry is still
> > > > broken because no BTF info gets generated from assembly files. A
> > > > separate patch is needed to fix that.
> > > > 
> > > > I built this patch with different combos of the following features
> > > > and confirmed kprobe tracing for asm function __arch_copy_to_user
> > > > worked in all cases:
> > > > 
> > > > CONFIG_DYNAMIC_FTRACE_WITH_CALL_OPS
> > > > CONFIG_DYNAMIC_FTRACE_WITH_ARGS
> > > > CONFIG_ARM64_BTI_KERNEL
> > > > 
> > > > Signed-off-by: Ben Niu <benniu@meta.com>
> > > > ---
> > > >  arch/arm64/include/asm/linkage.h           | 103 ++++++++++++++++-----
> > > >  arch/arm64/kernel/vdso/vgetrandom-chacha.S |   2 +-
> > > >  2 files changed, 81 insertions(+), 24 deletions(-)
> > > > 
> > > > diff --git a/arch/arm64/include/asm/linkage.h b/arch/arm64/include/asm/linkage.h
> > > > index d3acd9c87509..f3f3bc168162 100644
> > > > --- a/arch/arm64/include/asm/linkage.h
> > > > +++ b/arch/arm64/include/asm/linkage.h
> > > > @@ -5,8 +5,47 @@
> > > >  #include <asm/assembler.h>
> > > >  #endif
> > > >  
> > > > -#define __ALIGN		.balign CONFIG_FUNCTION_ALIGNMENT
> > > > -#define __ALIGN_STR	".balign " #CONFIG_FUNCTION_ALIGNMENT
> > > > +#define __ALIGN .balign CONFIG_FUNCTION_ALIGNMENT
> > > > +#define __ALIGN_STR ".balign " #CONFIG_FUNCTION_ALIGNMENT
> > > > +
> > > > +#ifdef CONFIG_DYNAMIC_FTRACE_WITH_CALL_OPS
> > > > +
> > > > +#define PRE_FUNCTION_NOPS                                                   \
> > > > +	ALIGN;                                                              \
> > > > +	nops CONFIG_FUNCTION_ALIGNMENT / 4 - 2;                             \
> > > > +	.pushsection __patchable_function_entries, "awo", @progbits, .text; \
> > > > +	.p2align 3;                                                         \
> > > > +	.8byte 1f;                                                          \
> > > > +	.popsection;                                                        \
> > > > +	1 :;                                                                \
> > > > +	nops 2;
> > > > +
> > > > +#define PRE_PROLOGUE_NOPS nops 2;
> > > > +
> > > > +#elif defined(CONFIG_DYNAMIC_FTRACE_WITH_ARGS)
> > > > +
> > > > +#define PRE_FUNCTION_NOPS
> > > > +
> > > > +#define PRE_PROLOGUE_NOPS                                                   \
> > > > +	.pushsection __patchable_function_entries, "awo", @progbits, .text; \
> > > > +	.p2align 3;                                                         \
> > > > +	.8byte 1f;                                                          \
> > > > +	.popsection;                                                        \
> > > > +	1 :;                                                                \
> > > > +	nops 2;
> > > > +
> > > > +#else
> > > > +
> > > > +#define PRE_FUNCTION_NOPS
> > > > +#define PRE_PROLOGUE_NOPS
> > > > +
> > > > +#endif
> > > > +
> > > > +#ifdef CONFIG_ARM64_BTI_KERNEL
> > > > +#define BTI_C bti c;
> > > > +#else
> > > > +#define BTI_C
> > > > +#endif
> > > >  
> > > >  /*
> > > >   * When using in-kernel BTI we need to ensure that PCS-conformant
> > > > @@ -15,32 +54,50 @@
> > > >   * everything, the override is done unconditionally so we're more
> > > >   * likely to notice any drift from the overridden definitions.
> > > >   */
> > > > -#define SYM_FUNC_START(name)				\
> > > > -	SYM_START(name, SYM_L_GLOBAL, SYM_A_ALIGN)	\
> > > > -	bti c ;
> > > > +#define SYM_FUNC_START(name)                       \
> > > > +	PRE_FUNCTION_NOPS                          \
> > > > +	SYM_START(name, SYM_L_GLOBAL, SYM_A_ALIGN) \
> > > > +	BTI_C                                      \
> > > > +	PRE_PROLOGUE_NOPS
> > > > +
> > > > +#define SYM_FUNC_START_NOTRACE(name)               \
> > > > +	SYM_START(name, SYM_L_GLOBAL, SYM_A_ALIGN) \
> > > > +	BTI_C
> > > >  
> > > > -#define SYM_FUNC_START_NOALIGN(name)			\
> > > > -	SYM_START(name, SYM_L_GLOBAL, SYM_A_NONE)	\
> > > > -	bti c ;
> > > > +#define SYM_FUNC_START_NOALIGN(name)              \
> > > > +	PRE_FUNCTION_NOPS                         \
> > > > +	SYM_START(name, SYM_L_GLOBAL, SYM_A_NONE) \
> > > > +	BTI_C                                     \
> > > > +	PRE_PROLOGUE_NOPS
> > > >  
> > > > -#define SYM_FUNC_START_LOCAL(name)			\
> > > > -	SYM_START(name, SYM_L_LOCAL, SYM_A_ALIGN)	\
> > > > -	bti c ;
> > > > +#define SYM_FUNC_START_LOCAL(name)                \
> > > > +	PRE_FUNCTION_NOPS                         \
> > > > +	SYM_START(name, SYM_L_LOCAL, SYM_A_ALIGN) \
> > > > +	BTI_C                                     \
> > > > +	PRE_PROLOGUE_NOPS
> > > >  
> > > > -#define SYM_FUNC_START_LOCAL_NOALIGN(name)		\
> > > > -	SYM_START(name, SYM_L_LOCAL, SYM_A_NONE)	\
> > > > -	bti c ;
> > > > +#define SYM_FUNC_START_LOCAL_NOALIGN(name)       \
> > > > +	PRE_FUNCTION_NOPS                        \
> > > > +	SYM_START(name, SYM_L_LOCAL, SYM_A_NONE) \
> > > > +	BTI_C                                    \
> > > > +	PRE_PROLOGUE_NOPS
> > > >  
> > > > -#define SYM_FUNC_START_WEAK(name)			\
> > > > -	SYM_START(name, SYM_L_WEAK, SYM_A_ALIGN)	\
> > > > -	bti c ;
> > > > +#define SYM_FUNC_START_WEAK(name)                \
> > > > +	PRE_FUNCTION_NOPS                        \
> > > > +	SYM_START(name, SYM_L_WEAK, SYM_A_ALIGN) \
> > > > +	BTI_C                                    \
> > > > +	PRE_PROLOGUE_NOPS
> > > >  
> > > > -#define SYM_FUNC_START_WEAK_NOALIGN(name)		\
> > > > -	SYM_START(name, SYM_L_WEAK, SYM_A_NONE)		\
> > > > -	bti c ;
> > > > +#define SYM_FUNC_START_WEAK_NOALIGN(name)       \
> > > > +	PRE_FUNCTION_NOPS                       \
> > > > +	SYM_START(name, SYM_L_WEAK, SYM_A_NONE) \
> > > > +	BTI_C                                   \
> > > > +	PRE_PROLOGUE_NOPS
> > > >  
> > > > -#define SYM_TYPED_FUNC_START(name)				\
> > > > -	SYM_TYPED_START(name, SYM_L_GLOBAL, SYM_A_ALIGN)	\
> > > > -	bti c ;
> > > > +#define SYM_TYPED_FUNC_START(name)                       \
> > > > +	PRE_FUNCTION_NOPS                                \
> > > > +	SYM_TYPED_START(name, SYM_L_GLOBAL, SYM_A_ALIGN) \
> > > > +	BTI_C                                            \
> > > > +	PRE_PROLOGUE_NOPS
> > > >  
> > > >  #endif
> > > > diff --git a/arch/arm64/kernel/vdso/vgetrandom-chacha.S b/arch/arm64/kernel/vdso/vgetrandom-chacha.S
> > > > index 67890b445309..21c27b64cf9f 100644
> > > > --- a/arch/arm64/kernel/vdso/vgetrandom-chacha.S
> > > > +++ b/arch/arm64/kernel/vdso/vgetrandom-chacha.S
> > > > @@ -40,7 +40,7 @@
> > > >   *	x2: 8-byte counter input/output
> > > >   *	x3: number of 64-byte block to write to output
> > > >   */
> > > > -SYM_FUNC_START(__arch_chacha20_blocks_nostack)
> > > > +SYM_FUNC_START_NOTRACE(__arch_chacha20_blocks_nostack)
> > > >  
> > > >  	/* copy0 = "expand 32-byte k" */
> > > >  	mov_q		x8, 0x3320646e61707865
> > > > -- 
> > > > 2.47.3
> > > > 
> > > > 

