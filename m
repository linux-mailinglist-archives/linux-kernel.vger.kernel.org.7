Return-Path: <linux-kernel+bounces-880968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E24F9C2711D
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 22:44:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EEF73BBC9E
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 21:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3147D31DDBB;
	Fri, 31 Oct 2025 21:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kw/1nTQd"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD86E3168E0
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 21:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761947078; cv=none; b=Ys/eAuP3e8s/uo4cG30WEnmf2G4wE9AFTalPk4D0rHza8MZrcb06IkipufKkOWdV70ldXWZ0wiZC0zM72g5jGQhyn0G4keXTYi/P7yhExvsWodh+izuy8u7INaYvpIWh8C1HiP2io44/8TJRjzn8FaBZkhanUgCyMjMJgfnV8KY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761947078; c=relaxed/simple;
	bh=jw8sB1dGsGLCqBXKyYN5LZ1D+tRXFyTSp3BbVXl2NCE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EtF47YpAPz8vKamteZkmuGmNNZC/4KneHjwBcmZxH5S7bttpseZooJo9u9LKE224Rwc9TKm3ZWBV21PP5YCoFwfY2d4400pPLxFdsu5Q27xVXVFM9TFLK1F24NbPIP9z2BaX2HJ9wEF7aUxFxi1y7N/3qRkz4cO0L27C0WNdskk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kw/1nTQd; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-29523ed27e0so13047785ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 14:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761947076; x=1762551876; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=aVpObC5F5atiCE6aYuSSFmcLirUy//gQjE/Dnsmr+1U=;
        b=kw/1nTQdoRv/MPupzpEQqgZFVapW+d1XrJ3GTFevl/Ndv/mUecxnuCf1sTHANlKJyO
         OAvh46Rlx8yv13LsVggtmE2um3bAGnOPbI8qjErgVQwszFrY5ARFNZzOVyUUAkzn9BjT
         cLXHihCUQWQ46K9+NUtYv1QIdOQ+LT0Pk0DAyvVJhDQajUCj+LBu77ycmjA4wUP/cX4N
         gDvp9UmRSQQcCpTdWpuyWBXdsySAxwEeFqpnQszW3DxWvHDGyTpIn0WMqw8uXNLcLu8I
         QFVY2+90fDqHoc+v7/8PRs3q7GOQ02vu/yp/kRu/d/cWXywe5jc0oSIcgNMbv+cKGf67
         cDvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761947076; x=1762551876;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aVpObC5F5atiCE6aYuSSFmcLirUy//gQjE/Dnsmr+1U=;
        b=PYXvLr5gic1Kvhio0YIyF7v+6CGOg8I/hCcHb1l5Nq+yZuPt+yNFIgTLwrhbbkekNY
         eF72juPJj8h0PHZh7owEvie0+nWEs5te48loG3G5rp6B5QlSPjjHgvlQfofOAsdB7gyt
         v9XrLX5Z55foJN9PE6d5MA8hMP4/6z7LhjwPLRZdnpkp0wEgjQi/fi9pbk8trKB1aZql
         6b2ikGlGnTPPTu4XJMORmS0rZKjjX4ozzaR41wldE8RomqCrrXTLH0K/TuVWGsRcOhcu
         L4bhdzuc6dehdmuaT31OnXofxTY4h6q7gD/39jM306yRrA7jWVGGRZSJL1XfRnBHSuJO
         FVBw==
X-Forwarded-Encrypted: i=1; AJvYcCU8l7vsjBsg+NKMYEdx0vXRBzkGtIWuV2iAPqqdkSI3kJPvN4EbPJgb7+AXLDSZ/yueL7GBcEsA0WaVfBs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxON+n+f3+tc6WzIh0Ti61WsduyIuJtyHEY9y/aj1tOhinpmULi
	lQnoNrPQk96l2M1MCmDJFkQrRdEae+1ZiF7ZVB2QFLVjxF2+CiYKsILLvNiWnqH055mEqrX17gV
	ACjnMVA==
X-Google-Smtp-Source: AGHT+IEYw4pPZ+SvH2uzeEiKP/YdQbVnHwobIZHDdhdNUfF4DnZFaq2l5BJGO27mDeJolc0Ab4+fL+yW9Go=
X-Received: from plpe11.prod.google.com ([2002:a17:903:3c2b:b0:290:b156:3774])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f644:b0:275:81ca:2c5
 with SMTP id d9443c01a7336-2951a600875mr75782075ad.59.1761947076151; Fri, 31
 Oct 2025 14:44:36 -0700 (PDT)
Date: Fri, 31 Oct 2025 14:44:34 -0700
In-Reply-To: <DDWIDCO0UKMD.2C46H6XQO1NXK@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251031003040.3491385-1-seanjc@google.com> <20251031003040.3491385-5-seanjc@google.com>
 <DDWIDCO0UKMD.2C46H6XQO1NXK@google.com>
Message-ID: <aQUtwsfxEsUi4us0@google.com>
Subject: Re: [PATCH v4 4/8] KVM: VMX: Handle MMIO Stale Data in VM-Enter
 assembly via ALTERNATIVES_2
From: Sean Christopherson <seanjc@google.com>
To: Brendan Jackman <jackmanb@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Borislav Petkov <bp@alien8.de>, Peter Zijlstra <peterz@infradead.org>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"

On Fri, Oct 31, 2025, Brendan Jackman wrote:
> On Fri Oct 31, 2025 at 12:30 AM UTC, Sean Christopherson wrote:
> > Rework the handling of the MMIO Stale Data mitigation to clear CPU buffers
> > immediately prior to VM-Enter, i.e. in the same location that KVM emits a
> > VERW for unconditional (at runtime) clearing.  Co-locating the code and
> > using a single ALTERNATIVES_2 makes it more obvious how VMX mitigates the
> > various vulnerabilities.
> >
> > Deliberately order the alternatives as:
> >
> >  0. Do nothing
> >  1. Clear if vCPU can access MMIO
> >  2. Clear always
> >
> > since the last alternative wins in ALTERNATIVES_2(), i.e. so that KVM will
> > honor the strictest mitigation (always clear CPU buffers) if multiple
> > mitigations are selected.  E.g. even if the kernel chooses to mitigate
> > MMIO Stale Data via X86_FEATURE_CLEAR_CPU_BUF_MMIO, some other mitigation
> > may enable X86_FEATURE_CLEAR_CPU_BUF_VM, and that other thing needs to win.
> >
> > Note, decoupling the MMIO mitigation from the L1TF mitigation also fixes
> > a mostly-benign flaw where KVM wouldn't do any clearing/flushing if the
> > L1TF mitigation is configured to conditionally flush the L1D, and the MMIO
> > mitigation but not any other "clear CPU buffers" mitigation is enabled.
> > For that specific scenario, KVM would skip clearing CPU buffers for the
> > MMIO mitigation even though the kernel requested a clear on every VM-Enter.
> >
> > Note #2, the flaw goes back to the introduction of the MDS mitigation.  The
> > MDS mitigation was inadvertently fixed by commit 43fb862de8f6 ("KVM/VMX:
> > Move VERW closer to VMentry for MDS mitigation"), but previous kernels
> > that flush CPU buffers in vmx_vcpu_enter_exit() are affected (though it's
> > unlikely the flaw is meaningfully exploitable even older kernels).
> >
> > Fixes: 650b68a0622f ("x86/kvm/vmx: Add MDS protection when L1D Flush is not active")
> > Suggested-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
> > Signed-off-by: Sean Christopherson <seanjc@google.com>
> > ---
> >  arch/x86/kvm/vmx/vmenter.S | 14 +++++++++++++-
> >  arch/x86/kvm/vmx/vmx.c     | 13 -------------
> >  2 files changed, 13 insertions(+), 14 deletions(-)
> >
> > diff --git a/arch/x86/kvm/vmx/vmenter.S b/arch/x86/kvm/vmx/vmenter.S
> > index 1f99a98a16a2..61a809790a58 100644
> > --- a/arch/x86/kvm/vmx/vmenter.S
> > +++ b/arch/x86/kvm/vmx/vmenter.S
> > @@ -71,6 +71,7 @@
> >   * @regs:	unsigned long * (to guest registers)
> >   * @flags:	VMX_RUN_VMRESUME:	use VMRESUME instead of VMLAUNCH
> >   *		VMX_RUN_SAVE_SPEC_CTRL: save guest SPEC_CTRL into vmx->spec_ctrl
> > + *		VMX_RUN_CLEAR_CPU_BUFFERS_FOR_MMIO: vCPU can access host MMIO
> >   *
> >   * Returns:
> >   *	0 on VM-Exit, 1 on VM-Fail
> > @@ -137,6 +138,12 @@ SYM_FUNC_START(__vmx_vcpu_run)
> >  	/* Load @regs to RAX. */
> >  	mov (%_ASM_SP), %_ASM_AX
> >  
> > +	/* Stash "clear for MMIO" in EFLAGS.ZF (used below). */
> > +	ALTERNATIVE_2 "",								\
> > +		      __stringify(test $VMX_RUN_CLEAR_CPU_BUFFERS_FOR_MMIO, %ebx), 	\
> > +		      X86_FEATURE_CLEAR_CPU_BUF_MMIO,					\
> > +		      "", X86_FEATURE_CLEAR_CPU_BUF_VM
> 
> Ah, so this ALTERNATIVE_2 (instead of just an ALTERNATIVE that checks
> CLEAR_CPU_BUF_MMIO) is really about avoiding the flags needing to be
> mutually exclusive?

Yeah, more or less.  More specifically, I want to keep the X vs. Y logic in one
place (well, two if you count both ALTERNATIVE_2 flows), so that in generaly,
from KVM's perspective, the mitigations are handled as independent things.  E.g.
even if CLEAR_CPU_BUF_VM and CLEAR_CPU_BUF_MMIO are mutually exclusive within
the kernel (and it's not clear to me that that's 100% guaranteed), I want to
limit how much of KVM assumes they are exclusive.  Partly to avoid "oops, we
forgot to mitigate that thing you care about", partly so that reading code like
the setting of VMX_RUN_CLEAR_CPU_BUFFERS_FOR_MMIO doesn't require understanding
the relationship between CLEAR_CPU_BUF_VM and CLEAR_CPU_BUF_MMIO.

> if (cpu_feature_enabled(X86_FEATURE_CLEAR_CPU_BUF_MMIO) && 
>     !cpu_feature_enabled(X86_FEATURE_CLEAR_CPU_BUF_VM))
> 	test $VMX_RUN_CLEAR_CPU_BUFFERS_FOR_MMIO, %ebx
> 
> ... right? This is a good idea but I think it warrants a comment to
> capture the intent, without having the commit message in short-term
> memory I'd have struggled with this code, I think.
> 
> >  	/* Check if vmlaunch or vmresume is needed */
> >  	bt   $VMX_RUN_VMRESUME_SHIFT, %ebx
> >  
> > @@ -161,7 +168,12 @@ SYM_FUNC_START(__vmx_vcpu_run)
> >  	mov VCPU_RAX(%_ASM_AX), %_ASM_AX
> >  
> >  	/* Clobbers EFLAGS.ZF */
> > -	VM_CLEAR_CPU_BUFFERS
> > +	ALTERNATIVE_2 "",							\
> > +		      __stringify(jz .Lskip_clear_cpu_buffers;			\
> 
> Maybe I'm just an asm noob 

Nah, all of this is definitely playing on hard mode.  I'm just thankful we don't
have to deal with the horrors of KVM doing all of this in inline asm.  :-D

> I was very impressed by this trick of using CF and ZF together like this!)
> but I think it's helpful to have the comment like the jnc has below, and
> Pawan had in his version, to really make the test->jz dependency obvious,
> since the two instructions are quite far apart.
> 
> 
> > +				  CLEAR_CPU_BUFFERS_SEQ;			\
> > +				  .Lskip_clear_cpu_buffers:),			\
> > +		      X86_FEATURE_CLEAR_CPU_BUF_MMIO,				\
> > +		      __CLEAR_CPU_BUFFERS, X86_FEATURE_CLEAR_CPU_BUF_VM
> 
> Sorry I'm really nitpicking but I think it's justified for asm
> readability...
> 
> It's a bit unfortunate that one branch says
> CLEAR_CPU_BUFFERS_SEQ and the other says __CLEAR_CPU_BUFFERS. With the
> current code I think it would be more readable to jut have
> __stringify(CLEAR_CPU_BUFFERS_SEQ) in the CLEAR_CPU_BUF_VM case, then
> you don't have to mentally expand the macro to see how the two branches
> actually differ.

No preference here (assuming I understand what you're asking).

Is this better?

	/*
	 * Note, this sequence consumes *and* clobbers EFLAGS.ZF.  The MMIO
	 * mitigations uses ZF to track whether or not the vCPU has access to
	 * host MMIO (see above), and VERW (the instruction microcode hijacks
	 * to clear CPU buffers) writes ZF.
	 */
	ALTERNATIVE_2 "",							\
		      __stringify(jz .Lskip_clear_cpu_buffers;			\
				  CLEAR_CPU_BUFFERS_SEQ;			\
				  .Lskip_clear_cpu_buffers:),			\
		      X86_FEATURE_CLEAR_CPU_BUF_MMIO,				\
		      __stringify(CLEAR_CPU_BUFFERS_SEQ), X86_FEATURE_CLEAR_CPU_BUF_VM

