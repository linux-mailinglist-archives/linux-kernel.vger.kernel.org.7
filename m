Return-Path: <linux-kernel+bounces-673300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D242ACDFA4
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jun 2025 15:56:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0277F3A66DF
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jun 2025 13:56:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A8C428FFD8;
	Wed,  4 Jun 2025 13:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KPd/cZ7n"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D97F128F51C
	for <linux-kernel@vger.kernel.org>; Wed,  4 Jun 2025 13:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749045367; cv=none; b=DjbB1lWgjHdx8AhHqahYZK2jfp9/WAIJb/NxX6GLYloR7ZfEELsOJGMEqAZ2DANRUMX8qsjOECbchIUlJPEI0WWqATS3gJ0qCcijK4IkhiKTy1/ACYgiTwzU9gTheg7KehddRfnx4JzfS08JfDbifvWmFQ9VenA5Tk+8G2WjFyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749045367; c=relaxed/simple;
	bh=Jd4bOTdufN+SkQt/Ld5ULZ9ZL5hW/b1y0IEOOcTR0w4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JLnGuFvvyv6rNtppqWsLrMdl9ckMEpbg3Sh+m8mKy97cW1q3jCyYmiiwmRD2oJXaRd4ZpHRKSoGG7fIIfDo3Mv08pEyaHuqomonezg+gAifHmGT3paSo+/g4Y3Ps7jmuWU8w0eb4Zc+NXNLAuDgJbcq9AcGf0wmbS5DNdlSgOzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KPd/cZ7n; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-31218e2d5b0so10505446a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jun 2025 06:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749045364; x=1749650164; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9BF4BQWYCffwCvEcJneONMaK8DNln+FUa3w2saRVlU0=;
        b=KPd/cZ7nryauGsNL/ig4YIq3aAnStFT+gMXWWmH8GF/RAliGoOHzMd6Jve/8+BDor2
         +P3L/1kzMIMvG1XOQKMBcK2WdSPl+op5Osq5ZEaOJ0C3NqzoETvW8qsaoNIdUnY60BLU
         tof2I5/iOMc+q0tNVcx6Db9T1PhG6QD+sJT0zNM7bU4jwtsxNraGBD+KxEuwR+AD/LX6
         cqz1ZI9Ge242Eu7AJgRJhmGjJ4ft4W9RUzi6SqPIF+AkCJZQUCdF2dONA0HhGOg+2wb7
         wSTjMjKw81Jxwz1mBfzjF6qH/+FmTW375DEEAQcK2zfRn6GxUdcznBj7W6KSLqLAAFmq
         W3VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749045364; x=1749650164;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9BF4BQWYCffwCvEcJneONMaK8DNln+FUa3w2saRVlU0=;
        b=ZrqAw8ubK6uohcCa2BMNA0uYSm1m5gB9OrFq0zS1vL8o1jSyvuoMZzuMj9f8VeTOkA
         bVE3VsQ7rZYUPX0lUnPGP+qo7FZNoUkYdL/apBqc1R8Z+JyWgV4DwC01RMKaOuiBwJim
         R5943PK6rsU8XB7jqsgvlB43KXWOKqV7qS6pQ6B44XhN6jVu0xDRsgNdA2rq9tqp+sD4
         ZdFxVELNbJtV3fgTjiozXqnbcO8f629fW+dLI7rv/5AnkfYIlXMNyXIqxlPZauyGgSzj
         +qBSsOsTSYTjO4vNu3+LhUYQTkL2ohoi692G8cZPDlD708V4ETN/NNz25cqaMaLnv9HD
         5zQw==
X-Forwarded-Encrypted: i=1; AJvYcCUZkwfJSy8Nl6RkJwGU6BCXf6xiJ/ibiH7ZisuxqkA4tCivN615JJ7eJj8zZG0FXUKbUvoTtxUNbkX1ujA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwT4loQoImNYuDhou1nl64hg585qnCHjgb/zu70dnj8Okg4+RR/
	odIt9eKGPLE7FL8kV9GKndEq2JPLiXKYcHOR9q1xt1q6djwA4BX1IsDIzrNNl0Nc6JtGABaIqwI
	Mw8GW0g==
X-Google-Smtp-Source: AGHT+IHnjDcLBr5/b5vVMhOX9FYYeTjBdgbqUz02Tjf48qTrSCQ4pB6Rh8rX4c6lQeoe9Fsflp0vIM3e6wo=
X-Received: from pjbsb6.prod.google.com ([2002:a17:90b:50c6:b0:312:1dae:6bf0])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4ace:b0:312:f88d:260b
 with SMTP id 98e67ed59e1d1-3130ccd51d5mr4706762a91.14.1749045364124; Wed, 04
 Jun 2025 06:56:04 -0700 (PDT)
Date: Wed, 4 Jun 2025 06:56:02 -0700
In-Reply-To: <aD/c6RZvE7a1KSqk@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250529234013.3826933-1-seanjc@google.com> <20250529234013.3826933-9-seanjc@google.com>
 <aD/c6RZvE7a1KSqk@intel.com>
Message-ID: <aEBQchT0cpCKkmQ6@google.com>
Subject: Re: [PATCH 08/28] KVM: nSVM: Use dedicated array of MSRPM offsets to
 merge L0 and L1 bitmaps
From: Sean Christopherson <seanjc@google.com>
To: Chao Gao <chao.gao@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Borislav Petkov <bp@alien8.de>, Xin Li <xin@zytor.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"

On Wed, Jun 04, 2025, Chao Gao wrote:
> >diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
> >index 89a77f0f1cc8..e53020939e60 100644
> >--- a/arch/x86/kvm/svm/nested.c
> >+++ b/arch/x86/kvm/svm/nested.c
> >@@ -184,6 +184,64 @@ void recalc_intercepts(struct vcpu_svm *svm)
> > 	}
> > }
> > 
> >+static int nested_svm_msrpm_merge_offsets[9] __ro_after_init;
> 
> I understand how the array size (i.e., 9) was determined :). But, adding a
> comment explaining this would be quite helpful 

Yeah, I'll write a comment explaining what all is going on.

> >+static int nested_svm_nr_msrpm_merge_offsets __ro_after_init;
> >+
> >+int __init nested_svm_init_msrpm_merge_offsets(void)
> >+{
> >+	const u32 merge_msrs[] = {
> >+		MSR_STAR,
> >+		MSR_IA32_SYSENTER_CS,
> >+		MSR_IA32_SYSENTER_EIP,
> >+		MSR_IA32_SYSENTER_ESP,
> >+	#ifdef CONFIG_X86_64
> >+		MSR_GS_BASE,
> >+		MSR_FS_BASE,
> >+		MSR_KERNEL_GS_BASE,
> >+		MSR_LSTAR,
> >+		MSR_CSTAR,
> >+		MSR_SYSCALL_MASK,
> >+	#endif
> >+		MSR_IA32_SPEC_CTRL,
> >+		MSR_IA32_PRED_CMD,
> >+		MSR_IA32_FLUSH_CMD,
> 
> MSR_IA32_DEBUGCTLMSR is missing, but it's benign since it shares the same
> offset as MSR_IA32_LAST* below.

Gah.  Once all is said and done, it's not supposed to be in this list because its
only passed through for SEV-ES guests, but my intent was to keep it in this patch,
and then removeit along with XSS, EFER, PAT, GHCB, and TSC_AUX in the next.

This made me realize that merging in chunks has a novel flaw: if there is an MSR
that KVM *doesn't* want to give L2 access to, then KVM needs to ensure its offset
isn't processed, i.e. that there isn't a "collision" with another MSR.  I don't
think it's a major concern, because the x2APIC MSRs are nicely isolated, and off
the top of my head I can't think of any MSRs that fall into that bucket.  But it's
something worth calling out in a comment, at least.

> I'm a bit concerned that we might overlook adding new MSRs to this array in the
> future, which could lead to tricky bugs. But I have no idea how to avoid this.

Me either.  One option would be to use wrapper macros for the interception helpers
to fill an array at compile time (similar to how kernel exception fixup works),
but (a) it requires modifications to the linker scripts to generate the arrays,
(b) is quite confusing/complex, and (c) it doesn't actually solve the problem,
it just inverts the problem.  Because as above, there are MSRs we *don't* want
to expose to L2, and so we'd need to add yet more code to filter those out.

And the failure mode for the inverted case would be worse, because if we missed
an MSR, KVM would incorrectly give L2 access to an MSR.  Whereas with the current
approach, a missed MSR simply means L2 gets a slower path; but functionally, it's
fine (and it has to be fine, because KVM can't force L1 to disable interception).

> Removing this array and iterating over direct_access_msrs[] directly is an
> option but it contradicts this series as one of its purposes is to remove
> direct_access_msrs[].

Using direct_access_msrs[] wouldn't solve the problem either, because nothing
ensures _that_ array is up-to-date either.

The best idea I have is to add a test that verifies the MSRs that are supposed
to be passed through actually are passed through.  It's still effectively manual
checking, but it would require us to screw up twice, i.e. forget to update both
the array and the test.  The problem is that there's no easy and foolproof way to
verify that an MSR is passed through in a selftest.

E.g. it would be possible to precisely detect L2 => L0 MSR exits via a BPF program,
but incorporating a BPF program into a KVM selftest just to detect exits isn't
something I'm keen on doing (or maintaining).

Using the "exits" stat isn't foolproof due to NMIs (IRQs can be accounted for via
"irq_exits", and to a lesser extent page faults (especially if shadow paging is
in use).

If KVM provided an "msr_exits" stats, it would be trivial to verify interception
via a selftest, but I can't quite convince myself that MSR exits are interesting
enough to warrant their own stat.

> >+		MSR_IA32_LASTBRANCHFROMIP,
> >+		MSR_IA32_LASTBRANCHTOIP,
> >+		MSR_IA32_LASTINTFROMIP,
> >+		MSR_IA32_LASTINTTOIP,
> >+
> >+		MSR_IA32_XSS,
> >+		MSR_EFER,
> >+		MSR_IA32_CR_PAT,
> >+		MSR_AMD64_SEV_ES_GHCB,
> >+		MSR_TSC_AUX,
> >+	};
> 
> 
> > 
> > 		if (kvm_vcpu_read_guest(vcpu, offset, &value, 4))
> >diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> >index 1c70293400bc..84dd1f220986 100644
> >--- a/arch/x86/kvm/svm/svm.c
> >+++ b/arch/x86/kvm/svm/svm.c
> >@@ -5689,6 +5689,10 @@ static int __init svm_init(void)
> > 	if (!kvm_is_svm_supported())
> > 		return -EOPNOTSUPP;
> > 
> >+	r = nested_svm_init_msrpm_merge_offsets();
> >+	if (r)
> >+		return r;
> >+
> 
> If the offset array is used for nested virtualization only, how about guarding
> this with nested virtualization? For example, in svm_hardware_setup():

Good idea, I'll do that in the next version.

> 	if (nested) {
> 		r = nested_svm_init_msrpm_merge_offsets();
> 		if (r)
> 			goto err;
> 
> 		pr_info("Nested Virtualization enabled\n");
> 		kvm_enable_efer_bits(EFER_SVME | EFER_LMSLE);
> 	}
> 
> 
> > 	r = kvm_x86_vendor_init(&svm_init_ops);
> > 	if (r)
> > 		return r;
> >diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
> >index 909b9af6b3c1..0a8041d70994 100644
> >--- a/arch/x86/kvm/svm/svm.h
> >+++ b/arch/x86/kvm/svm/svm.h
> >@@ -686,6 +686,8 @@ static inline bool nested_exit_on_nmi(struct vcpu_svm *svm)
> > 	return vmcb12_is_intercept(&svm->nested.ctl, INTERCEPT_NMI);
> > }
> > 
> >+int __init nested_svm_init_msrpm_merge_offsets(void);
> >+
> > int enter_svm_guest_mode(struct kvm_vcpu *vcpu,
> > 			 u64 vmcb_gpa, struct vmcb *vmcb12, bool from_vmrun);
> > void svm_leave_nested(struct kvm_vcpu *vcpu);
> >-- 
> >2.49.0.1204.g71687c7c1d-goog
> >

