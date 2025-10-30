Return-Path: <linux-kernel+bounces-879232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17A59C22983
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 23:46:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF8D81A62AC2
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 22:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7E443451C9;
	Thu, 30 Oct 2025 22:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nShJ65Ur"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66BEE342158
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 22:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761864180; cv=none; b=fckZ83FH9kAeeeEUinKv1Z794yIUgKV4AAawJxtUlX8EP2Cs0Vnod0TPD4ihqlEDuUt+Q1crkMhak0GGwybWSjsxNqbSXXFTR4ruaE1D9hfyPFdBsmwWw1MUYYDYWMDUpk4t2HYSYoTZgaHoc5MBLu92JrxjnNWBa2Dtd/ZdTdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761864180; c=relaxed/simple;
	bh=pnN9mployMBMoTRfIb3auiGgxnEIQ28TLJ5kLq76KJQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VNjXEmCcgfTpaw7BAwpP/RZV992LNEj64AGhS1jUdxVhtA4n0/AZsibsU0bYHJJKHx6iOINF7+/fY/L4d8oOAGANqkUXld5WweTmhNOEZdveksIkNMr1i/juu/WFUPwpV1PylKb8XHeB9e4FwhIWFqEqyc9U53STNw1RhOnpGBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nShJ65Ur; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-32eb18b5659so1173745a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 15:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761864178; x=1762468978; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=JbG+s/sLpThc2/7Wf3lfU0jWrU3IfpW9/OXc8vG/48E=;
        b=nShJ65UrcU/2kLbvHDwppt9VPKT+bSs9K+AyPDGEE7wIfC1C6jUcvSgu5Ipu3Ioc88
         CVN6H1smvfOBYoDy5teLQpIjr0jA7j5mrZWeV/fF2FS6Ep/g3eCspN2Bbe8VHX6T39x0
         BCnjs+RiB27MQby3ELXw7Y3GOJZPrfK+lDrdYxUBGuyywjUiR8RikPQF2XGWxG7jdBTn
         XmAa4GChjzg3fvJFcKTAQK2cUzLWwprxOvDRdl8cy4OhWaJwfKNQw2EqNKR/A1eHk400
         tnUfgsj8MyiYc4BMxAMVQ4frDwuCfr+rWNVEFmxG0xODwQVJNEQkrA7bD6fVOHvoRkKs
         fSCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761864178; x=1762468978;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JbG+s/sLpThc2/7Wf3lfU0jWrU3IfpW9/OXc8vG/48E=;
        b=vSW1fUtrKf4SG3Tp/KY2JG04i0E1p9xwY5KxhPE48AtqnfLqGh6ksxF6FyMCiKropB
         AJGGyb0/7YA86aq6edC/7iJmgYLicc0+Nmf58jEmDWp3k46wc71KgH76NqhcBXLWw5DE
         /KKQ7aXGFQmOfSB2WjQwQnxr+winzh5T0niC/rUF5AhMFynrrSuUZft4ANEMK0b4f8Sp
         XsDBYuXHO9t7xzogUSOlHvfK71JV0k7gdNR3a2TYv2J4GW+n+P0et1hncRkA7/fjgKwV
         Omk6urP4ItzMcoIscRs3oeFwOIkeMwtWQcA+cbSuPsd+z0jOV4gFCcAguhvGjRMFJ3+Q
         7QMw==
X-Forwarded-Encrypted: i=1; AJvYcCWy4xgQkPDuWhcsfB3a51Go5pl0lEE9TgWrzJqVgxzc6k35x+ng80Kiu6Z6u3MMUdjNvZ9NCZbwN8/V+Sc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTH2fEDAudpeWg7oftXt1poTrLtCeFF/K1mcAs8tGxGPKjj1H8
	bsm0DWkL1PlKDa7voOQz0OgHtGNQ1zFV+yzICRg1RZpM7izuFjuyzXgOf2EFRJMBRclOsPPmBgt
	NsUYIGw==
X-Google-Smtp-Source: AGHT+IHLm4f+mWF3cKWxOGvjZ76CQa6Tp0Tcm9iwmBRdzVYSXwqZs5hMFFKgfSepLdoa5h+ksYOCRWY39rk=
X-Received: from pjbkl13.prod.google.com ([2002:a17:90b:498d:b0:33b:a0cd:53ed])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1812:b0:340:299e:dbc
 with SMTP id 98e67ed59e1d1-34082fd608emr2123417a91.16.1761864177764; Thu, 30
 Oct 2025 15:42:57 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 30 Oct 2025 15:42:46 -0700
In-Reply-To: <20251030224246.3456492-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251030224246.3456492-1-seanjc@google.com>
X-Mailer: git-send-email 2.51.1.930.gacf6e81ea2-goog
Message-ID: <20251030224246.3456492-5-seanjc@google.com>
Subject: [PATCH 4/4] KVM: x86: Load guest/host PKRU outside of the fastpath
 run loop
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jon Kohler <jon@nutanix.com>
Content-Type: text/plain; charset="UTF-8"

Move KVM's swapping of PKRU outside of the fastpath loop, as there is no
KVM code anywhere in the fastpath that accesses guest/userspace memory,
i.e. that can consume protection keys.

As documented by commit 1be0e61c1f25 ("KVM, pkeys: save/restore PKRU when
guest/host switches"), KVM just needs to ensure the host's PKRU is loaded
when KVM (or the kernel at-large) may access userspace memory.  And at the
time of commit 1be0e61c1f25, KVM didn't have a fastpath, and PKU was
strictly contained to VMX, i.e. there was no reason to swap PKRU outside
of vmx_vcpu_run().

Over time, the "need" to swap PKRU close to VM-Enter was likely falsely
solidified by the association with XFEATUREs in commit 37486135d3a7
("KVM: x86: Fix pkru save/restore when guest CR4.PKE=0, move it to x86.c"),
and XFEATURE swapping was in turn moved close to VM-Enter/VM-Exit as a
KVM hack-a-fix ution for an #MC handler bug by commit 1811d979c716
("x86/kvm: move kvm_load/put_guest_xcr0 into atomic context").

Deferring the PKRU loads shaves ~40 cycles off the fastpath for Intel,
and ~60 cycles for AMD.  E.g. using INVD in KVM-Unit-Test's vmexit.c,
with extra hacks to enable CR4.PKE and PKRU=(-1u & ~0x3), latency numbers
for AMD Turin go from ~1560 => ~1500, and for Intel Emerald Rapids, go
from ~810 => ~770.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/svm.c |  2 --
 arch/x86/kvm/vmx/vmx.c |  4 ----
 arch/x86/kvm/x86.c     | 14 ++++++++++----
 arch/x86/kvm/x86.h     |  2 --
 4 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index e8b158f73c79..e1fb853c263c 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -4260,7 +4260,6 @@ static __no_kcsan fastpath_t svm_vcpu_run(struct kvm_vcpu *vcpu, u64 run_flags)
 		svm_set_dr6(vcpu, DR6_ACTIVE_LOW);
 
 	clgi();
-	kvm_load_guest_xsave_state(vcpu);
 
 	/*
 	 * Hardware only context switches DEBUGCTL if LBR virtualization is
@@ -4303,7 +4302,6 @@ static __no_kcsan fastpath_t svm_vcpu_run(struct kvm_vcpu *vcpu, u64 run_flags)
 	    vcpu->arch.host_debugctl != svm->vmcb->save.dbgctl)
 		update_debugctlmsr(vcpu->arch.host_debugctl);
 
-	kvm_load_host_xsave_state(vcpu);
 	stgi();
 
 	/* Any pending NMI will happen here */
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 123dae8cf46b..55d637cea84a 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -7465,8 +7465,6 @@ fastpath_t vmx_vcpu_run(struct kvm_vcpu *vcpu, u64 run_flags)
 	if (vcpu->guest_debug & KVM_GUESTDBG_SINGLESTEP)
 		vmx_set_interrupt_shadow(vcpu, 0);
 
-	kvm_load_guest_xsave_state(vcpu);
-
 	pt_guest_enter(vmx);
 
 	atomic_switch_perf_msrs(vmx);
@@ -7510,8 +7508,6 @@ fastpath_t vmx_vcpu_run(struct kvm_vcpu *vcpu, u64 run_flags)
 
 	pt_guest_exit(vmx);
 
-	kvm_load_host_xsave_state(vcpu);
-
 	if (is_guest_mode(vcpu)) {
 		/*
 		 * Track VMLAUNCH/VMRESUME that have made past guest state
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index b5c2879e3330..6924006f0796 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -1233,7 +1233,7 @@ static void kvm_load_host_xfeatures(struct kvm_vcpu *vcpu)
 	}
 }
 
-void kvm_load_guest_xsave_state(struct kvm_vcpu *vcpu)
+static void kvm_load_guest_pkru(struct kvm_vcpu *vcpu)
 {
 	if (vcpu->arch.guest_state_protected)
 		return;
@@ -1244,9 +1244,8 @@ void kvm_load_guest_xsave_state(struct kvm_vcpu *vcpu)
 	     kvm_is_cr4_bit_set(vcpu, X86_CR4_PKE)))
 		wrpkru(vcpu->arch.pkru);
 }
-EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_load_guest_xsave_state);
 
-void kvm_load_host_xsave_state(struct kvm_vcpu *vcpu)
+static void kvm_load_host_pkru(struct kvm_vcpu *vcpu)
 {
 	if (vcpu->arch.guest_state_protected)
 		return;
@@ -1259,7 +1258,6 @@ void kvm_load_host_xsave_state(struct kvm_vcpu *vcpu)
 			wrpkru(vcpu->arch.host_pkru);
 	}
 }
-EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_load_host_xsave_state);
 
 #ifdef CONFIG_X86_64
 static inline u64 kvm_guest_supported_xfd(struct kvm_vcpu *vcpu)
@@ -11331,6 +11329,12 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 
 	guest_timing_enter_irqoff();
 
+	/*
+	 * Swap PKRU with hardware breakpoints disabled to minimize the number
+	 * of flows where non-KVM code can run with guest state loaded.
+	 */
+	kvm_load_guest_pkru(vcpu);
+
 	for (;;) {
 		/*
 		 * Assert that vCPU vs. VM APICv state is consistent.  An APICv
@@ -11359,6 +11363,8 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 		++vcpu->stat.exits;
 	}
 
+	kvm_load_host_pkru(vcpu);
+
 	/*
 	 * Do this here before restoring debug registers on the host.  And
 	 * since we do this before handling the vmexit, a DR access vmexit
diff --git a/arch/x86/kvm/x86.h b/arch/x86/kvm/x86.h
index f3dc77f006f9..24c754b0db2e 100644
--- a/arch/x86/kvm/x86.h
+++ b/arch/x86/kvm/x86.h
@@ -622,8 +622,6 @@ static inline void kvm_machine_check(void)
 #endif
 }
 
-void kvm_load_guest_xsave_state(struct kvm_vcpu *vcpu);
-void kvm_load_host_xsave_state(struct kvm_vcpu *vcpu);
 int kvm_spec_ctrl_test_value(u64 value);
 int kvm_handle_memory_failure(struct kvm_vcpu *vcpu, int r,
 			      struct x86_exception *e);
-- 
2.51.1.930.gacf6e81ea2-goog


