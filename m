Return-Path: <linux-kernel+bounces-894221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D08FC497FD
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 23:21:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5EC554E3467
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 22:21:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 157642D949F;
	Mon, 10 Nov 2025 22:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="aarU8qht"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AE6723E34C
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 22:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762813256; cv=none; b=A1qpPRaguBBgonqNoWDjcZNxcDqgAgmRqg8IpZjAdrA4hWA5PsgDexylzdkuDMenS7Xvk6ApkguIJ+FopPh5YIWN1UoYpkw+bmYOasAbwnjMTlaq2rV9uTyDWVvmHI+Jg2Xjnyf62UkWLXdXx/c9DF5nhU4l9Q52vFLfGqeVD7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762813256; c=relaxed/simple;
	bh=JocQ8BClRVizvLRScOaB+Fi70TmOQy51tETfBEa6I+I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FgfwWpxjXA9+njqkAhoQ97Z6nNO0H1JTpyxMRiEJDIARX3gtHPe4n7LLxVpitqrSb2wNnvxxfaBRZizavD41Wdv+HbsG4/N6iAcVhkISIJUR24EP+73eI74ZRVtsAVmu//J84a2ZmLx233kdf4C1Hj0JgeMUx96cnE1UDb/S3n0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=aarU8qht; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=CQEF7s6HZY4hdQfBG8RO4XOL+ms6wXYGMo58X5FUpjA=; b=aarU8qhtboU5MC1u2UmHZn8XOz
	TDxLVR0msnNyHHnzBjO3R9OQ8ftbFREhrcbjK7evVrR55PQJAm0oCPcB3uQwyxO9aH7w0CNwd3isb
	oQnrw6Vj8UrxkKMm8sgLu9mWMN0/q0oHs/m5os+QnEiVPnrAjRyZwya6r9Qgmx9PqSo+vIeZoTW5O
	NhXXdXJvewTwSrqJ3fu9NRxB6rK0y3hM8LyvrIXYi7fnnK9Uz3fJ1fnsjbSj/K0jkPdmky3sw9WdR
	hQ+FqfjOFANz8CBwXp4PbIm5HaSdxzyIDKas4g0NxYTX8ZncQubEKZkpM6p5TIerCWWym5fh8antd
	zp+aPPkw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vIaFi-00000007xdS-0UEY;
	Mon, 10 Nov 2025 22:20:46 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 839B430029E; Mon, 10 Nov 2025 23:20:44 +0100 (CET)
Date: Mon, 10 Nov 2025 23:20:44 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Linus Torvalds <torvalds@linuxfoundation.org>
Cc: Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
	linux-kernel@vger.kernel.org, kees@kernel.org, acarmina@redhat.com,
	jpoimboe@kernel.org, mark.rutland@arm.com,
	maciej.wieczor-retman@intel.com
Subject: Re: [PATCH v2 00/12] x86: WARN() hackery
Message-ID: <20251110222044.GC278048@noisy.programming.kicks-ass.net>
References: <20251110114633.202485143@infradead.org>
 <CAHk-=wj4gDw2iMi-OSbCov3SVDJCQr=YCRr3JZr9Mz-eNwfmGw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wj4gDw2iMi-OSbCov3SVDJCQr=YCRr3JZr9Mz-eNwfmGw@mail.gmail.com>

On Mon, Nov 10, 2025 at 08:18:02AM -0800, Linus Torvalds wrote:
> On Mon, 10 Nov 2025 at 03:58, Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > We should probably just merge these, as they improve the code-gen for WARN()
> > significantly on x86
> 
> Yes..  And I'd actually like to see some example code generation in
> the commit messages just to make that "improve the code-gen" more
> explicit.

Damn, I actually thought to include some and then I totally forgot.

So lets see:

        if (WARN_ONCE(preempt_count() != 2*PREEMPT_DISABLE_OFFSET,
                      "corrupted preempt_count: %s/%d/0x%x\n",
                      current->comm, current->pid, preempt_count()))

#define WARN_ONCE(condition, format...)                         \
        DO_ONCE_LITE_IF(condition, WARN, 1, format)

#define WARN(condition, format...) ({                                   \
        int __ret_warn_on = !!(condition);                              \
        if (unlikely(__ret_warn_on))                                    \
                __WARN_printf(TAINT_WARN, format);                      \
        unlikely(__ret_warn_on);                                        \
})

#define __WARN_printf(taint, arg...) do {                               \
                instrumentation_begin();                                \
                __warn_printk(arg);                                     \
                __WARN_FLAGS("", BUGFLAG_NO_CUT_HERE | BUGFLAG_TAINT(taint));\
                instrumentation_end();                                  \
        } while (0)

Turns into this majestic pile:


# ../kernel/sched/core.c:5093:  if (WARN_ONCE(preempt_count() != 2*PREEMPT_DISABLE_OFFSET,
        cmpl    $2, %ecx        #, _7
        jne     .L1472  #,

...

.L1472:
# ../kernel/sched/core.c:5093:  if (WARN_ONCE(preempt_count() != 2*PREEMPT_DISABLE_OFFSET,
        cmpb    $0, __already_done.11(%rip)     #, __already_done
        je      .L1513  #,

...

.L1513:
# ../kernel/sched/core.c:5093:  if (WARN_ONCE(preempt_count() != 2*PREEMPT_DISABLE_OFFSET,
        movb    $1, __already_done.11(%rip)     #, __already_done
# ../kernel/sched/core.c:5093:  if (WARN_ONCE(preempt_count() != 2*PREEMPT_DISABLE_OFFSET,


# 0 "" 2
# ../kernel/sched/core.c:5093:  if (WARN_ONCE(preempt_count() != 2*PREEMPT_DISABLE_OFFSET,
#NO_APP
        movl    1424(%r14), %edx        # _15->pid, _15->pid
        leaq    1912(%r14), %rsi        #, _17
        movq    $.LC43, %rdi    #,
        call    __warn_printk   #
# ../kernel/sched/core.c:5093:  if (WARN_ONCE(preempt_count() != 2*PREEMPT_DISABLE_OFFSET,

# 0 "" 2
# 5093 "../kernel/sched/core.c" 1
        1:       .byte 0x0f, 0x0b ;
.pushsection __bug_table,"aw"
912:
        .pushsection .discard.annotate_data,"M", @progbits, 8
        .long 912b - .
        .long 1
        .popsection
        2:      .long 1b - .    # bug_entry::bug_addr
        .long .LC1 - .  # bug_entry::file       #
        .word 5093      # bug_entry::line       #
        .word 2313      # bug_entry::flags      #
        .org 2b + 12    #
.popsection
.pushsection .discard.annotate_insn,"M", @progbits, 8
        .long 1b - .
        .long 8		# ANNOTYPE_REACHABLE
        .popsection


While afterwards it looks like so:


# ../kernel/sched/core.c:5093:  if (WARN_ONCE(preempt_count() != 2*PREEMPT_DISABLE_OFFSET,
        cmpl    $2, %ecx        #, _7
        jne     .L1442  #,

...

.L1442:
# ../kernel/sched/core.c:5093:  if (WARN_ONCE(preempt_count() != 2*PREEMPT_DISABLE_OFFSET,
#APP
# 5093 "../kernel/sched/core.c" 1
        lea (2f)(%rip), %rdi    # bug
1:
.pushsection __bug_table,"aw"
        912:
        .pushsection .discard.annotate_data,"M", @progbits, 8
        .long 912b - .
        .long 1
        .popsection
        2:
        .long 1b - .    # bug_entry::bug_addr
        .long .LC43 - . # bug_entry::format     #
        .long .LC1 - .  # bug_entry::file       #
        .word 5093      # bug_entry::line       #
        .word 2323      # bug_entry::flags      #
        .org 2b + 16    #
.popsection
        
# 0 "" 2
#NO_APP  
        movl    1424(%r14), %edx        # pretmp_19->pid, pretmp_19->pid
# ../kernel/sched/core.c:5093:  if (WARN_ONCE(preempt_count() != 2*PREEMPT_DISABLE_OFFSET,
        leaq    1912(%r14), %rsi        #, _13
# ../kernel/sched/core.c:5093:  if (WARN_ONCE(preempt_count() != 2*PREEMPT_DISABLE_OFFSET,
        call    __SCT__WARN_trap        #

Where at runtime we patch that "call __SCT__WARN_trap" to read like:

	ud1 (%ecx), %rdi


The whole DO_ONCE_LITE_IF/__already_done thing is gone (replaced with
BUGFLAG_ONCE) and the external __warn_prink() call is also gone, now
inside the exception handler through the pt_regs->va_list magic.

I'll see if I can clean that up somewhat and stick in the changelog.

