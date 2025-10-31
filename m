Return-Path: <linux-kernel+bounces-880750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 27420C266FB
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 18:44:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13352188D7EB
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 17:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB9192FC882;
	Fri, 31 Oct 2025 17:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BF+Oob+x"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0FD82F6182
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 17:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761932586; cv=none; b=uUP4G2JE7mBI0waqh/OkPnRtRbeCfQjz+VkDzZp9FFPmp7+gdiqpI6reqSc+ElkjAV4USUkN9npUlAEDSvbsCgfZgvG0UTG9vsBJ8DvHG7HMAoo5IWzTHFIC7XEvtlJeK0+WAgwtiKu7hg+cE9KWuc5K/o9UksFTPRAD/lx5SjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761932586; c=relaxed/simple;
	bh=89kyHpPbJXmhylbv/+r/d1Rty7NEIIBLxACE0Nh9fx0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Si9FxNrhgPVI5bQPhzI5bCCV/DYjS01f+xlBnyPMXnYOXp+0BCJ1yU8x6aIMGEjnyT5T3lMcwKf9e9B202ODIj7vWyuulnks3kUML4K3k7Js0YaJAuNp0ibGijJdLegX/CWRDYmOQ4Wd7QxRVTRdC4koQiaJ5Ijr4BiszHmyxDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BF+Oob+x; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-28bd8b3fa67so22501835ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 10:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761932584; x=1762537384; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4KIS8YznzNIn0xjee6YBCS61sxbopStZxFkL5pmhtOU=;
        b=BF+Oob+xIbALUbieJ6UFCDs5rt4gjfH/fdC2DqrgDtueZo7G0Wq+qFqB6BuXCyA06B
         PVamO+WGdXJcmLjp8UD7z6xPwFZKjloytK3BHMnkX3/lCBjTQQ/+07TO84ySuUfq9a11
         B6OxTnVjjzdWec9TsBMsFMQMAr1TivaNYVBhrUGy9B+CbGVeuDL5HyY32DPO169OWq3r
         1nMOJE0EgFGma+lwlKAXAKkiNAmjnKJ3YJLjt3E1X5qWNJiWSU4kZrITd40pK+oeEHhJ
         hzszy5kWfHpEDJmBC01GseFNqPmBoJ1tki5yf60GmJGQPyQfXGAP+lo2TBkS1jqAwg1+
         3fRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761932584; x=1762537384;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4KIS8YznzNIn0xjee6YBCS61sxbopStZxFkL5pmhtOU=;
        b=tLGDx0S1JbzDbKHnC0hs9rik31Jy6x61t/Xeix/Ts7z1wZ57Two6feStD/PbZBzXst
         ZRdoxPN0DneqLzdh514GeYVzRyIrvXm1XKxvEmSy4V+3chBcvEh4yDIwLX/wDzymLT6m
         h44mAPBlF05AArY32gg8rZNwNLoyed977gNjt0axV9eO2RUKaVGkmzRcdPYMdIUjFeiA
         Huj23d9+X0vksL42GnxynTqorn1sbGvpbeu8c3pZfn2SL517NlqLbPqY+hq2RtqxbpPE
         jHAC7c8Gc1Jqr5TpPzgIsn5x2BUznY58/XYeAU9tBrubN+rcrUoG03Up1WYTrDCh4/Om
         KrSA==
X-Forwarded-Encrypted: i=1; AJvYcCUqToEok9Irw4RyUrInUMnWudhWVWX19Mkjt4GW2lcd0ObpjzIlrA7xKlpfH+5jVdFuWkfYXWh66M1XDmk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOt7G8mfO1tb1oXLAON8m1Yhl4/fhtNP9oegqjqAtuEcL3XuUT
	Y9vMAjgLgQ2+S8l4KEU+TKhBpXNcuO66RcOh0cCVaE5be97x3GGp3PpIJYg4hnpNQMuUNMaib/K
	D/d6+1w==
X-Google-Smtp-Source: AGHT+IESYWjtdItYLqBwcEmHqqmP0CPrZ5lahVGTlH9mdBWh4wk3eyfim34G+iQPgn2+yKydL4oM1vpHp8A=
X-Received: from pjbcs23.prod.google.com ([2002:a17:90a:f517:b0:33f:df7f:3c2b])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1ca:b0:295:105:c87d
 with SMTP id d9443c01a7336-2951a55b729mr53114805ad.32.1761932583797; Fri, 31
 Oct 2025 10:43:03 -0700 (PDT)
Date: Fri, 31 Oct 2025 10:43:02 -0700
In-Reply-To: <DDWH6WN6G64S.22FTEH7M615YJ@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251031003040.3491385-1-seanjc@google.com> <20251031003040.3491385-3-seanjc@google.com>
 <DDWH6WN6G64S.22FTEH7M615YJ@google.com>
Message-ID: <aQT1JgdgiNae3Ybl@google.com>
Subject: Re: [PATCH v4 2/8] x86/bugs: Decouple ALTERNATIVE usage from VERW
 macro definition
From: Sean Christopherson <seanjc@google.com>
To: Brendan Jackman <jackmanb@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Borislav Petkov <bp@alien8.de>, Peter Zijlstra <peterz@infradead.org>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"

On Fri, Oct 31, 2025, Brendan Jackman wrote:
> On Fri Oct 31, 2025 at 12:30 AM UTC, Sean Christopherson wrote:
> > Decouple the use of ALTERNATIVE from the encoding of VERW to clear CPU
> > buffers so that KVM can use ALTERNATIVE_2 to handle "always clear buffers"
> > and "clear if guest can access host MMIO" in a single statement.
> >
> > No functional change intended.
> >
> > Signed-off-by: Sean Christopherson <seanjc@google.com>
> > ---
> >  arch/x86/include/asm/nospec-branch.h | 21 ++++++++++-----------
> >  1 file changed, 10 insertions(+), 11 deletions(-)
> >
> > diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
> > index 08ed5a2e46a5..923ae21cbef1 100644
> > --- a/arch/x86/include/asm/nospec-branch.h
> > +++ b/arch/x86/include/asm/nospec-branch.h
> > @@ -308,24 +308,23 @@
> >   * CFLAGS.ZF.
> >   * Note: Only the memory operand variant of VERW clears the CPU buffers.
> >   */
> > -.macro __CLEAR_CPU_BUFFERS feature
> >  #ifdef CONFIG_X86_64
> > -	ALTERNATIVE "", "verw x86_verw_sel(%rip)", \feature
> > +#define CLEAR_CPU_BUFFERS_SEQ	verw x86_verw_sel(%rip)
> >  #else
> > -	/*
> > -	 * In 32bit mode, the memory operand must be a %cs reference. The data
> > -	 * segments may not be usable (vm86 mode), and the stack segment may not
> > -	 * be flat (ESPFIX32).
> > -	 */
> > -	ALTERNATIVE "", "verw %cs:x86_verw_sel", \feature
> > +/*
> > + * In 32bit mode, the memory operand must be a %cs reference. The data segments
> > + * may not be usable (vm86 mode), and the stack segment may not be flat (ESPFIX32).
> > + */
> > +#define CLEAR_CPU_BUFFERS_SEQ	verw %cs:x86_verw_sel
> >  #endif
> > -.endm
> > +
> > +#define __CLEAR_CPU_BUFFERS	__stringify(CLEAR_CPU_BUFFERS_SEQ)
> 
> Maybe CLEAR_CPU_BUFFERS_SEQ should just be defined as a string in the
> first place?

Heh, I tried that, and AFAICT it simply can't work with the way ALTERNATIVE and
friends are implemented, as each paramater needs to be a single unbroken string.

E.g. this 

diff --git a/arch/x86/kvm/vmx/vmenter.S b/arch/x86/kvm/vmx/vmenter.S
index 61a809790a58..ffa6bc2345e3 100644
--- a/arch/x86/kvm/vmx/vmenter.S
+++ b/arch/x86/kvm/vmx/vmenter.S
@@ -63,6 +63,8 @@
        RET
 .endm
 
+#define CLEAR_CPU_BUFFERS_SEQ_STRING  "verw x86_verw_sel(%rip)"
+
 .section .noinstr.text, "ax"
 
 /**
@@ -169,9 +171,9 @@ SYM_FUNC_START(__vmx_vcpu_run)
 
        /* Clobbers EFLAGS.ZF */
        ALTERNATIVE_2 "",                                                       \
-                     __stringify(jz .Lskip_clear_cpu_buffers;                  \
-                                 CLEAR_CPU_BUFFERS_SEQ;                        \
-                                 .Lskip_clear_cpu_buffers:),                   \
+                     "jz .Lskip_clear_cpu_buffers; "                           \
+                     CLEAR_CPU_BUFFERS_SEQ_STRING;                             \
+                     ".Lskip_clear_cpu_buffers:",                              \
                      X86_FEATURE_CLEAR_CPU_BUF_MMIO,                           \
                      __CLEAR_CPU_BUFFERS, X86_FEATURE_CLEAR_CPU_BUF_VM
 
yields wonderfully helpful error messages like so:

  arch/x86/kvm/vmx/vmenter.S: Assembler messages:
  arch/x86/kvm/vmx/vmenter.S:173: Error: too many positional arguments

If there's a magic incanation to get things to work, it's unknown to me.

