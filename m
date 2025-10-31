Return-Path: <linux-kernel+bounces-880943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AFE3CC26F36
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 21:52:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 521CE1A25288
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 20:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB003329C62;
	Fri, 31 Oct 2025 20:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EPjtSrDD"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7720B3161B2
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 20:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761943956; cv=none; b=UhpLdl6ZN1QIa+eTmm8jX3mC+NFQ8s5scbKVCBt9uK+1rJkcjLfSMPN6WkKBIntktpIAD1eHcNXjAhDyVGgBuDtcx0O7/tJqtiuw6Grr7kreejoxmaJQx8qZtqDSNwD4OmDuXdokgy14fmJrXf7htm1Kb1oFzzVj6DTm3Q7DMxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761943956; c=relaxed/simple;
	bh=LWCqojpgWbzRp9Bu1i7qiob5sDOmb/6ufqSP0jRfcKI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JiBIDBJHab5U1VLZBB1kDA7ZPpMDSvNJvBJgTT1apTdFdaaXBN8+YVziS4UA9iwCAYZy7LgS5if2zz4QfQau76COwQ61pMr1lAfhGyufy9y7FWxf6gKVNPSUMlS3c7fD9akn+R2fZ1dN9CLRt50b9178lC3ne5a3yHr3JvE7lOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EPjtSrDD; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b969f3f5c13so103294a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 13:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761943954; x=1762548754; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wLvDB63UmdVuSSj4JE9pOXK1lFNof2Z5hUnTW2O2vkY=;
        b=EPjtSrDDxxzVK0hb5hYvAldCYLGUxx/BEjIMnSbpWhleKSjcqb/iF5altTZLtRW9T7
         065WivxkOMTGNvGvW7A5jWCsKTRZTLbJzF3earGRVPmkg3WU9X8dGuP1Rzkz5QuBO+Lr
         tB12Zf2OhgLjcbicqbuw1XjjXZTnfH9JbYYCPOyVcKfF93+piowwSvJO4U/uA9sufeut
         CgGPUUfbBiue81gscEc6NboRAU8uwFrN1NNeAQBC1nAiFHpSfUwhwmudzsjxyiyH1RhR
         NpCsVsr5kAahe6pTmLOU2SaCfMW0vqIXbi+ihK1Cv7DXNw+1BM3WYagv8iXuBUomhny7
         F5Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761943954; x=1762548754;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wLvDB63UmdVuSSj4JE9pOXK1lFNof2Z5hUnTW2O2vkY=;
        b=E3bHwOKYlpWTX0cDlb9/UHBwGY6ymIWXRLb5Wmh/PVgF84BzQv6X2SrP2LFYRQv574
         6wZOl6yJKEzB4N83R3qOKl7gv8GkXt4kIZWBStpQ6AnSt50Q1mXiuK1rel+4tpTuNM3Z
         kZ2cMptSHqUaNYUC710pM4BwrQl/PXsGal0rRn1TVUTKDY0jPsddiwWrajRyvXLO57G8
         hNQcM5ioDEWkFhV5JRmTkVp+u3kDpk4sGuaSc1XZWdhdnqBqUShhRkuBoIJdDlPMtng0
         dSaSbJMi/QqSnnubt2/P4hTnCwdRZl8rffgjDDvu+Dp5odJpOn6SCrUouQDtdIFRnLbo
         P9aw==
X-Forwarded-Encrypted: i=1; AJvYcCULC9Y417F+HmDJUAropPuhnCZLohjA7wNHPOyYN+x3wCfX5jNP6lPDhClPaCZWQZ+xhRLsFKBqwtmCMeQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMu/J7C33E6JEU4h+esoW7AMoS84iHm1d2aIdnUzzzK/ptzLD5
	qpqvtq3Su5ZsHOusz9dec722qzYqGev9UYoMk0Ri8Bp16CSG6nebVOU6WhWATgxceu3eRG5ZnO5
	nEAKMdQ==
X-Google-Smtp-Source: AGHT+IFAq18J2Ixa2zjN7RrO66OgC2tgQ2G3Vlk9994Te36Miwm7RmuxFuRTKldtxWe3pzgIN0SArYyPoXo=
X-Received: from plbjw23.prod.google.com ([2002:a17:903:2797:b0:295:20d0:7120])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:b48e:b0:27e:ef27:1e52
 with SMTP id d9443c01a7336-2951a45459emr45321725ad.35.1761943953634; Fri, 31
 Oct 2025 13:52:33 -0700 (PDT)
Date: Fri, 31 Oct 2025 20:52:32 +0000
In-Reply-To: <0AA5A319-C4FC-4EEB-9317-BDC9E2E2E703@nutanix.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251030224246.3456492-1-seanjc@google.com> <20251030224246.3456492-5-seanjc@google.com>
 <0AA5A319-C4FC-4EEB-9317-BDC9E2E2E703@nutanix.com>
Message-ID: <aQUhkDOkQJJceH4N@google.com>
Subject: Re: [PATCH 4/4] KVM: x86: Load guest/host PKRU outside of the
 fastpath run loop
From: Sean Christopherson <seanjc@google.com>
To: Jon Kohler <jon@nutanix.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 31, 2025, Jon Kohler wrote:
> > On Oct 30, 2025, at 6:42=E2=80=AFPM, Sean Christopherson <seanjc@google=
.com> wrote:
> > + /*
> > + * Swap PKRU with hardware breakpoints disabled to minimize the number
> > + * of flows where non-KVM code can run with guest state loaded.
> > + */
> > + kvm_load_guest_pkru(vcpu);
> > +
>=20
> I was mocking this up after PUCK, and went down a similar-ish path, but w=
as
> thinking it might be interesting to have an x86 op called something to th=
e effect of
> =E2=80=9Cprepare_switch_to_guest_irqoff=E2=80=9D and =E2=80=9Cprepare_swi=
tch_to_host_irqoff=E2=80=9D, which
> might make for a place to nestle any other sort of =E2=80=9Cneeds to be d=
one in atomic
> context but doesn=E2=80=99t need to be done in the fast path=E2=80=9D sor=
t of stuff (if any).

Hmm, I would say I'm flat out opposed to generic hooks of that nature.  For
anything that _needs_ to be modified with IRQs disabled, the ordering will =
matter
greatly.  E.g. we already have kvm_x86_ops.sync_pir_to_irr(), and that _mus=
t_ run
before kvm_vcpu_exit_request() if it triggers a late request.

And I also want to push for as much stuff as possible to be handled in comm=
on x86,
i.e. I want to actively encourage landing things like PKU and CET support i=
n
common x86 instead of implementing support in one vendor and then having to=
 churn
a pile of code to later move it to

> One other one that caught my eye was the cr3 stuff that was moved out a w=
hile
> ago, but then moved back with 1a7158101.
>=20
> I haven=E2=80=99t gone through absolutely everything else in that tight l=
oop code
> (and didn=E2=80=99t get a chance to do the same for SVM code), but figure=
d I=E2=80=99d put
> the idea out there to see what you think.
>=20
> To be clear, I=E2=80=99m totally OK with the series as-is, just thinking =
about
> perhaps future ways to incrementally optimize here?

To some extent, we're going to hit diminishing returns.  E.g. one of the re=
asons
I did a straight revert in commit 1a71581012dd is that were talking about a=
 handful
of cycles difference.  E.g. as measured from the guest, eliding the CR3+CR4=
 checks
shaves 3-5 cycles.  From the host side it _looks_ like more (~20 cycles), b=
ut it's
hard to even measure accurately because just doing RDTSC affects the result=
s.

For SVM, I don't see any obvious candidates.  E.g. pre_sev_run() has some c=
ode that
only needs to be done on the first iteration, but checking a flag or doing =
a static
CALL+RET is going to be just as costly as what's already there.

In short, the only flows that will benefit are relatively slow flows and/or=
 flows
that aren't easily predicted by the CPU.  E.g. __get_current_cr3_fast() and
cr4_read_shadow() require CALL+RET and might not be super predictable?  But=
 even
they are on the cusp of "who cares".

And that needs to be balanced against the probability of introducing bugs. =
 E.g.
this code _could_ be done only on the first iteration:

	if (vmx->ple_window_dirty) {
		vmx->ple_window_dirty =3D false;
		vmcs_write32(PLE_WINDOW, vmx->ple_window);
	}

but (a) checking vmx->ple_window_dirty is going to be super predictable aft=
er the
first iteration, (b) handling PLE exits in the fastpath would break things,=
 and
(c) _if_ we want to optimize that code, it can/should be simply moved to
vmx_prepare_switch_to_guest() (but outside of the guest_state_loaded check)=
.

All that said, I'm not totally opposed to shaving cycles.  Now that @run_fl=
ags
is a thing, it's actually trivially easy to optimize the CR3/CR4 checks (fa=
mous
last words):

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_hos=
t.h
index 48598d017d6f..5cc1f0168b8a 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1709,6 +1709,7 @@ enum kvm_x86_run_flags {
        KVM_RUN_FORCE_IMMEDIATE_EXIT    =3D BIT(0),
        KVM_RUN_LOAD_GUEST_DR6          =3D BIT(1),
        KVM_RUN_LOAD_DEBUGCTL           =3D BIT(2),
+       KVM_RUN_IS_FIRST_ITERATION      =3D BIT(3),
 };
=20
 struct kvm_x86_ops {
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 55d637cea84a..3deb20b8d0c5 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -7439,22 +7439,28 @@ fastpath_t vmx_vcpu_run(struct kvm_vcpu *vcpu, u64 =
run_flags)
                vmx_reload_guest_debugctl(vcpu);
=20
        /*
-        * Refresh vmcs.HOST_CR3 if necessary.  This must be done immediate=
ly
-        * prior to VM-Enter, as the kernel may load a new ASID (PCID) any =
time
-        * it switches back to the current->mm, which can occur in KVM cont=
ext
-        * when switching to a temporary mm to patch kernel code, e.g. if K=
VM
-        * toggles a static key while handling a VM-Exit.
+        * Refresh vmcs.HOST_CR3 if necessary.  This must be done after IRQ=
s
+        * are disabled, i.e. not when preparing to switch to the guest, as=
 the
+        * the kernel may load a new ASID (PCID) any time it switches back =
to
+        * the current->mm, which can occur in KVM context when switching t=
o a
+        * temporary mm to patch kernel code, e.g. if KVM toggles a static =
key
+        * while handling a VM-Exit.
+        *
+        * Refresh host CR3 and CR4 only on the first iteration of the inne=
r
+        * loop, as modifying CR3 or CR4 from NMI context is not allowed.
         */
-       cr3 =3D __get_current_cr3_fast();
-       if (unlikely(cr3 !=3D vmx->loaded_vmcs->host_state.cr3)) {
-               vmcs_writel(HOST_CR3, cr3);
-               vmx->loaded_vmcs->host_state.cr3 =3D cr3;
-       }
+       if (run_flags & KVM_RUN_IS_FIRST_ITERATION) {
+               cr3 =3D __get_current_cr3_fast();
+               if (unlikely(cr3 !=3D vmx->loaded_vmcs->host_state.cr3)) {
+                       vmcs_writel(HOST_CR3, cr3);
+                       vmx->loaded_vmcs->host_state.cr3 =3D cr3;
+               }
=20
-       cr4 =3D cr4_read_shadow();
-       if (unlikely(cr4 !=3D vmx->loaded_vmcs->host_state.cr4)) {
-               vmcs_writel(HOST_CR4, cr4);
-               vmx->loaded_vmcs->host_state.cr4 =3D cr4;
+               cr4 =3D cr4_read_shadow();
+               if (unlikely(cr4 !=3D vmx->loaded_vmcs->host_state.cr4)) {
+                       vmcs_writel(HOST_CR4, cr4);
+                       vmx->loaded_vmcs->host_state.cr4 =3D cr4;
+               }
        }
=20
        /* When single-stepping over STI and MOV SS, we must clear the
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 6924006f0796..bff08f58c29a 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -11286,7 +11286,7 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
                goto cancel_injection;
        }
=20
-       run_flags =3D 0;
+       run_flags =3D KVM_RUN_IS_FIRST_ITERATION;
        if (req_immediate_exit) {
                run_flags |=3D KVM_RUN_FORCE_IMMEDIATE_EXIT;
                kvm_make_request(KVM_REQ_EVENT, vcpu);


