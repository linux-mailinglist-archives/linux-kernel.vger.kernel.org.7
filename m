Return-Path: <linux-kernel+bounces-879307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CF7A4C22CAC
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 01:33:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AEEE84EDE2A
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 00:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 708071DF27F;
	Fri, 31 Oct 2025 00:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TZpi9qhF"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04DCE21ABB9
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 00:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761870662; cv=none; b=aA/MRr+cLKRF7gUkAqGd66qMZU4cb1l0VPq5oMxnKj1WIeGA6BbiWNS6YSYKDX7Doq8U9HVqcyxSHI5ZqLbih2nRa9z9Y+dN0A10u7V88syfW7++Ir+GWn0YWuR3VpkSpgPXa3hIOFt6CFZ6PS7OsQAt0QFBmqYNpOz8bUNtwsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761870662; c=relaxed/simple;
	bh=RT/sHTj0KzhQejEjxZna5Y25pQzofKvau2oAC0XFLaw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YApKlL5QsjWMLsZhMSxWHwA2xG/vhhPzRE8Fy1LjcWzDAn/jC6VRRw0KydeJW/FaLG15PVyf16R7lwi4MGSz4iZw55SqghE2aH8Bb7dhRN3PMeSmV6B1mEnuRbEwkzgWKG7F/rbM31pI2Hv8wREHS5O5FwKxqOjSKqy7bID3xLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TZpi9qhF; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-294880e7ca4so33217445ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 17:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761870660; x=1762475460; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=LbTsWO94j2FTsRt3NBHviHWz1y0m9u2EeuxD0YgFUA4=;
        b=TZpi9qhFK+2O1C3GQijopQgJMlMLtGga7+AqwSHkJvMxQPN724rnyE+PlzRQ+NsVBf
         adB0KdVoHD8ANTKbvCMcKcBmFNApJPZFt7VDoWS49c3CBGzS3rqRf12tAV53FDafb+85
         E6XL1/gKN31qy4p9gcPqR49nWCiwoXFXpziH0Zq+uIK8dUmtbz9RSi3z5LE7xpG01CWl
         LbgpG2v420R/EWNpw+VCT73hfxKYG+XI+tkskoPH5/tzSXwesSECLsR/HfTsN0AEzmMk
         +AviEr025TIbazYPS4ZJmVpV3QwbwVK8DiOHGp0awOZy093QHWlSBCQILceFKbjo95hq
         jtKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761870660; x=1762475460;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LbTsWO94j2FTsRt3NBHviHWz1y0m9u2EeuxD0YgFUA4=;
        b=D9RB3tZETw0G8tm+JtaK1riMIy0+cN7V28x/KE2/Cu4E6Mh8bp9RQxr1simblUs5/0
         Jf5ish3oJSoVSKtkzEh4bmPtHdLViqvOIGAQf7QOSHFWBIFmtPug5qKUNOBIHdKW5hnU
         KAzDSyqF246UvTuErG5T8A01/ED47ApObV4nd9KgJp+sRlZH5TQIqZAV8UEQwcQd91N/
         Gw994igxTFIp7VdVtzejqW3g41LWynQJiUrBBC7k0d/mqYuoHnmLRvOmZhCvWYVcR9gB
         C6mUYHp5pfi+CUivThZ8dmrvxj0CMtai9aCo7gBjRG1o0x+w1HQApUXU1fLwXaQJ1dOQ
         rvtg==
X-Forwarded-Encrypted: i=1; AJvYcCVljTUEnFTFz75v82CTwR1JXtj08xi7rEYxe6R1m7KAf+QSYHuZrIncXzfc9GwvNGmkGzm68vGwsqy38ls=@vger.kernel.org
X-Gm-Message-State: AOJu0YyphhsaJwByH3ctBA6X0MeNrWfvmgYIavTGXJe/t2UcNv0Sgk4r
	ObgOCPq0EVVy3bYa2k9cd2S4k4XnMim8O1EmqNWxq7EzcY/MXo5C0Loz3aG8y8B09TkVwVOVZkk
	Byl6V3g==
X-Google-Smtp-Source: AGHT+IG9niXeqcQKc5xfb5DpFxjBvH7jNOuHlLCtg8NMqPQ9wNkIMDEwIxItwd+jCVHQRiKCwCLg7bs2U5Y=
X-Received: from plblq15.prod.google.com ([2002:a17:903:144f:b0:268:11e:8271])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ea0e:b0:292:39b4:e785
 with SMTP id d9443c01a7336-2951a3e696fmr21856645ad.26.1761870660376; Thu, 30
 Oct 2025 17:31:00 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 30 Oct 2025 17:30:40 -0700
In-Reply-To: <20251031003040.3491385-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251031003040.3491385-1-seanjc@google.com>
X-Mailer: git-send-email 2.51.1.930.gacf6e81ea2-goog
Message-ID: <20251031003040.3491385-9-seanjc@google.com>
Subject: [PATCH v4 8/8] KVM: x86: Unify L1TF flushing under per-CPU variable
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, Peter Zijlstra <peterz@infradead.org>, 
	Josh Poimboeuf <jpoimboe@kernel.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Brendan Jackman <jackmanb@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Brendan Jackman <jackmanb@google.com>

Currently the tracking of the need to flush L1D for L1TF is tracked by
two bits: one per-CPU and one per-vCPU.

The per-vCPU bit is always set when the vCPU shows up on a core, so
there is no interesting state that's truly per-vCPU. Indeed, this is a
requirement, since L1D is a part of the physical CPU.

So simplify this by combining the two bits.

The vCPU bit was being written from preemption-enabled regions.  To play
nice with those cases, wrap all calls from KVM and use a raw write so that
request a flush with preemption enabled doesn't trigger what would
effectively be DEBUG_PREEMPT false positives.  Preemption doesn't need to
be disabled, as kvm_arch_vcpu_load() will mark the new CPU as needing a
flush if the vCPU task is migrated, or if userspace runs the vCPU on a
different task.

Signed-off-by: Brendan Jackman <jackmanb@google.com>
[sean: put raw write in KVM instead of in a hardirq.h variant]
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/kvm_host.h |  3 ---
 arch/x86/kvm/mmu/mmu.c          |  2 +-
 arch/x86/kvm/vmx/nested.c       |  2 +-
 arch/x86/kvm/vmx/vmx.c          | 20 +++++---------------
 arch/x86/kvm/x86.c              |  6 +++---
 arch/x86/kvm/x86.h              | 14 ++++++++++++++
 6 files changed, 24 insertions(+), 23 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 48598d017d6f..fcdc65ab13d8 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1055,9 +1055,6 @@ struct kvm_vcpu_arch {
 	/* be preempted when it's in kernel-mode(cpl=0) */
 	bool preempted_in_kernel;
 
-	/* Flush the L1 Data cache for L1TF mitigation on VMENTER */
-	bool l1tf_flush_l1d;
-
 	/* Host CPU on which VM-entry was most recently attempted */
 	int last_vmentry_cpu;
 
diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 18d69d48bc55..4e016582adc7 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -4859,7 +4859,7 @@ int kvm_handle_page_fault(struct kvm_vcpu *vcpu, u64 error_code,
 	 */
 	BUILD_BUG_ON(lower_32_bits(PFERR_SYNTHETIC_MASK));
 
-	vcpu->arch.l1tf_flush_l1d = true;
+	kvm_request_l1tf_flush_l1d();
 	if (!flags) {
 		trace_kvm_page_fault(vcpu, fault_address, error_code);
 
diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index b0cd745518b4..6f2f969d19f9 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -3828,7 +3828,7 @@ static int nested_vmx_run(struct kvm_vcpu *vcpu, bool launch)
 		goto vmentry_failed;
 
 	/* Hide L1D cache contents from the nested guest.  */
-	vcpu->arch.l1tf_flush_l1d = true;
+	kvm_request_l1tf_flush_l1d();
 
 	/*
 	 * Must happen outside of nested_vmx_enter_non_root_mode() as it will
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 1b5540105e4b..f87af1836ea1 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -395,26 +395,16 @@ static noinstr void vmx_l1d_flush(struct kvm_vcpu *vcpu)
 	 * 'always'
 	 */
 	if (static_branch_likely(&vmx_l1d_flush_cond)) {
-		bool flush_l1d;
-
 		/*
-		 * Clear the per-vcpu flush bit, it gets set again if the vCPU
+		 * Clear the per-cpu flush bit, it gets set again if the vCPU
 		 * is reloaded, i.e. if the vCPU is scheduled out or if KVM
 		 * exits to userspace, or if KVM reaches one of the unsafe
-		 * VMEXIT handlers, e.g. if KVM calls into the emulator.
+		 * VMEXIT handlers, e.g. if KVM calls into the emulator,
+		 * or from the interrupt handlers.
 		 */
-		flush_l1d = vcpu->arch.l1tf_flush_l1d;
-		vcpu->arch.l1tf_flush_l1d = false;
-
-		/*
-		 * Clear the per-cpu flush bit, it gets set again from
-		 * the interrupt handlers.
-		 */
-		flush_l1d |= kvm_get_cpu_l1tf_flush_l1d();
+		if (!kvm_get_cpu_l1tf_flush_l1d())
+			return;
 		kvm_clear_cpu_l1tf_flush_l1d();
-
-		if (!flush_l1d)
-			return;
 	}
 
 	vcpu->stat.l1d_flush++;
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index b4b5d2d09634..851f078cd5ca 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -5189,7 +5189,7 @@ void kvm_arch_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 {
 	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
 
-	vcpu->arch.l1tf_flush_l1d = true;
+	kvm_request_l1tf_flush_l1d();
 
 	if (vcpu->scheduled_out && pmu->version && pmu->event_count) {
 		pmu->need_cleanup = true;
@@ -7999,7 +7999,7 @@ int kvm_write_guest_virt_system(struct kvm_vcpu *vcpu, gva_t addr, void *val,
 				unsigned int bytes, struct x86_exception *exception)
 {
 	/* kvm_write_guest_virt_system can pull in tons of pages. */
-	vcpu->arch.l1tf_flush_l1d = true;
+	kvm_request_l1tf_flush_l1d();
 
 	return kvm_write_guest_virt_helper(addr, val, bytes, vcpu,
 					   PFERR_WRITE_MASK, exception);
@@ -9395,7 +9395,7 @@ int x86_emulate_instruction(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa,
 		return handle_emulation_failure(vcpu, emulation_type);
 	}
 
-	vcpu->arch.l1tf_flush_l1d = true;
+	kvm_request_l1tf_flush_l1d();
 
 	if (!(emulation_type & EMULTYPE_NO_DECODE)) {
 		kvm_clear_exception_queue(vcpu);
diff --git a/arch/x86/kvm/x86.h b/arch/x86/kvm/x86.h
index f3dc77f006f9..cd67ccbb747f 100644
--- a/arch/x86/kvm/x86.h
+++ b/arch/x86/kvm/x86.h
@@ -420,6 +420,20 @@ static inline bool kvm_check_has_quirk(struct kvm *kvm, u64 quirk)
 	return !(kvm->arch.disabled_quirks & quirk);
 }
 
+static __always_inline void kvm_request_l1tf_flush_l1d(void)
+{
+#if IS_ENABLED(CONFIG_CPU_MITIGATIONS) && IS_ENABLED(CONFIG_KVM_INTEL)
+	/*
+	 * Use a raw write to set the per-CPU flag, as KVM will ensure a flush
+	 * even if preemption is currently enabled..  If the current vCPU task
+	 * is migrated to a different CPU (or userspace runs the vCPU on a
+	 * different task) before the next VM-Entry, then kvm_arch_vcpu_load()
+	 * will request a flush on the new CPU.
+	 */
+	raw_cpu_write(irq_stat.kvm_cpu_l1tf_flush_l1d, 1);
+#endif
+}
+
 void kvm_inject_realmode_interrupt(struct kvm_vcpu *vcpu, int irq, int inc_eip);
 
 u64 get_kvmclock_ns(struct kvm *kvm);
-- 
2.51.1.930.gacf6e81ea2-goog


