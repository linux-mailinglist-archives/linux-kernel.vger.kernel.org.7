Return-Path: <linux-kernel+bounces-769772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BBD1BB2738A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 02:17:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 376331CE1531
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 00:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8620420B7F4;
	Fri, 15 Aug 2025 00:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u7zuo4Ts"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4BAA1FF5EC
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 00:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755216760; cv=none; b=tc+/gQEIF10L+z6zQGM9PjhZwhj20Jz2LL8mbll8c19Yb7ZepJOW3iP0bDZrF7qTe/osLR97sHt832NKHkptLzq13OBnWDwifRXUbgc2ZPVke/m+10/AoTt/0WxnZzNyHIXRYkEZt15YvAJMVFwQz1WD/5jwB/1pSBzBCo69B5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755216760; c=relaxed/simple;
	bh=yTUz+qG+cU6V8xwnekCabgy0vngZnFqvIXMxd1Gydqk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=g4HNATk8X16v6TiWdCxJdXNWMn3Sd6gtdpAxECQGyFpv41eCBd+1NI6hoJG3qlgXxdpEWOKbkDeDpJbTEXnRK0z4xHCwB+Mi5FLmf5rCOojcjGHDOGN6qRBtsddxJ0y6+N6K/pDr9cdbACRAy/Kv+0CVDtVgIUU0fniHRjlfLoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=u7zuo4Ts; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-76e2eb787f2so1437561b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 17:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755216757; x=1755821557; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=jPuQ+cNG6Ky3AiODPwKfwN4pIduvIz2auWyqIQ/IVDc=;
        b=u7zuo4Ts9CRAFLBGTYOHv+T9LI33EIUalKWvC7MFMTQtH76MLOegfvJItkV0z2qWzA
         DjFtunlcMmjZZm07/5wO6KnrrfmAkFAJ8KKhqE4x7mwLpBsJaZPnWW330bvfeb+WAAEf
         fLb+QlyEA4xFla/xz7yhVniEvSpO2vr5TCyhJud9taGAESPDKJG8MPGC6F16DCi6Fuba
         9WSc8TWPkj+mEjom9Y0yogJgGC6Ndiw5iK9wp97iUVKs6Ipc2lAf2hltpi4pq9LQRAyB
         a5qNdB/GnCpEbveOdphpPr32IyF74aKr+U4HUIS/o+yNQugY5EzLPQdAfTjofPZkpQSE
         VQLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755216757; x=1755821557;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jPuQ+cNG6Ky3AiODPwKfwN4pIduvIz2auWyqIQ/IVDc=;
        b=VRKH0ORkUcrAS8Ppofp3IFqrtZVChMoXRcX1EqYlaFGB/4NUZUnvK0zdOuJe5/Aqdw
         OB/uzxPX1Mba0+/UnPol9Nk112doovH6o0Tu2z3QCmzD9e4QX2m1sLmWAqRFGISBIqz/
         xPmvZZPusflc0304iFgsX4ftOB+/Beh+XwKkKLiju2aAeAwo4c40uyt+s6Zfyt7/+EHK
         Tk0sw1WksAxNLuTuZIEp8L/EEhD1wYQiQr4dLf814NqkoygRCF2STtSrNNuTqzV96KrF
         DSdOApp0mcbxEOmP9SCRTif1XgWdqTnAD9OE/IsHLT9sWIP7Q5DZq+AxU+XJMLWwBAcM
         cfjA==
X-Forwarded-Encrypted: i=1; AJvYcCWwtpI8FdzReIuyk5N9KRSZdMDY7CXdpRgJuKL2LInDAfVuP4wD+HWf/FEUD0nyBPigROd7hyJHDp09FAU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPVUCygTu19Ig4VzRBvkNJzaJq/Op2dZebFFTnAAEtb6gqIMmh
	gsLnEd+JS1R1Ugr9uCufupWUUgCrGy+3iTOTWCVWKabfdRuBGuwByHJWAleILrRExxHj2S1ocjx
	JTCwsdw==
X-Google-Smtp-Source: AGHT+IHJ7XeWcEMUSG1jDAsSbG5DOzoVCeXpHBp7b8baQtDYYKASKeMj0hM/4Tl94qbNbHjH0SF36wjcd4I=
X-Received: from pfbik4.prod.google.com ([2002:a05:6a00:8d04:b0:76b:d1ee:d06c])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1492:b0:74d:3a57:81d9
 with SMTP id d2e1a72fcca58-76e446de7a4mr75086b3a.8.1755216756957; Thu, 14 Aug
 2025 17:12:36 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 14 Aug 2025 17:11:58 -0700
In-Reply-To: <20250815001205.2370711-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250815001205.2370711-1-seanjc@google.com>
X-Mailer: git-send-email 2.51.0.rc1.163.g2494970778-goog
Message-ID: <20250815001205.2370711-15-seanjc@google.com>
Subject: [PATCH 6.1.y 14/21] KVM: x86: Fully defer to vendor code to decide
 how to force immediate exit
From: Sean Christopherson <seanjc@google.com>
To: stable@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Sasha Levin <sashal@kernel.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"

[ Upstream commit 0ec3d6d1f169baa7fc512ae4b78d17e7c94b7763 ]

Now that vmx->req_immediate_exit is used only in the scope of
vmx_vcpu_run(), use force_immediate_exit to detect that KVM should usurp
the VMX preemption to force a VM-Exit and let vendor code fully handle
forcing a VM-Exit.

Opportunsitically drop __kvm_request_immediate_exit() and just have
vendor code call smp_send_reschedule() directly.  SVM already does this
when injecting an event while also trying to single-step an IRET, i.e.
it's not exactly secret knowledge that KVM uses a reschedule IPI to force
an exit.

Link: https://lore.kernel.org/r/20240110012705.506918-7-seanjc@google.com
Signed-off-by: Sean Christopherson <seanjc@google.com>
[sean: resolve absurd conflict due to funky kvm_x86_ops.sched_in prototype]
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/kvm-x86-ops.h |  1 -
 arch/x86/include/asm/kvm_host.h    |  3 ---
 arch/x86/kvm/svm/svm.c             |  7 ++++---
 arch/x86/kvm/vmx/vmx.c             | 32 +++++++++++++-----------------
 arch/x86/kvm/vmx/vmx.h             |  2 --
 arch/x86/kvm/x86.c                 | 10 +---------
 6 files changed, 19 insertions(+), 36 deletions(-)

diff --git a/arch/x86/include/asm/kvm-x86-ops.h b/arch/x86/include/asm/kvm-x86-ops.h
index 29bef25ac77c..0e5ae3b0c867 100644
--- a/arch/x86/include/asm/kvm-x86-ops.h
+++ b/arch/x86/include/asm/kvm-x86-ops.h
@@ -100,7 +100,6 @@ KVM_X86_OP(write_tsc_multiplier)
 KVM_X86_OP(get_exit_info)
 KVM_X86_OP(check_intercept)
 KVM_X86_OP(handle_exit_irqoff)
-KVM_X86_OP(request_immediate_exit)
 KVM_X86_OP(sched_in)
 KVM_X86_OP_OPTIONAL(update_cpu_dirty_logging)
 KVM_X86_OP_OPTIONAL(vcpu_blocking)
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 93f523762854..86f3bd6601e7 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1590,8 +1590,6 @@ struct kvm_x86_ops {
 			       struct x86_exception *exception);
 	void (*handle_exit_irqoff)(struct kvm_vcpu *vcpu);
 
-	void (*request_immediate_exit)(struct kvm_vcpu *vcpu);
-
 	void (*sched_in)(struct kvm_vcpu *kvm, int cpu);
 
 	/*
@@ -2059,7 +2057,6 @@ extern bool kvm_find_async_pf_gfn(struct kvm_vcpu *vcpu, gfn_t gfn);
 
 int kvm_skip_emulated_instruction(struct kvm_vcpu *vcpu);
 int kvm_complete_insn_gp(struct kvm_vcpu *vcpu, int err);
-void __kvm_request_immediate_exit(struct kvm_vcpu *vcpu);
 
 void __user *__x86_set_memory_region(struct kvm *kvm, int id, gpa_t gpa,
 				     u32 size);
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 337a304d211b..12de50db401f 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -4033,8 +4033,11 @@ static __no_kcsan fastpath_t svm_vcpu_run(struct kvm_vcpu *vcpu,
 		 * is enough to force an immediate vmexit.
 		 */
 		disable_nmi_singlestep(svm);
+		force_immediate_exit = true;
+	}
+
+	if (force_immediate_exit)
 		smp_send_reschedule(vcpu->cpu);
-	}
 
 	pre_svm_run(vcpu);
 
@@ -4874,8 +4877,6 @@ static struct kvm_x86_ops svm_x86_ops __initdata = {
 	.check_intercept = svm_check_intercept,
 	.handle_exit_irqoff = svm_handle_exit_irqoff,
 
-	.request_immediate_exit = __kvm_request_immediate_exit,
-
 	.sched_in = svm_sched_in,
 
 	.nested_ops = &svm_nested_ops,
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 4db9d41d988c..179747d04edc 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -49,6 +49,8 @@
 #include <asm/virtext.h>
 #include <asm/vmx.h>
 
+#include <trace/events/ipi.h>
+
 #include "capabilities.h"
 #include "cpuid.h"
 #include "evmcs.h"
@@ -1223,8 +1225,6 @@ void vmx_prepare_switch_to_guest(struct kvm_vcpu *vcpu)
 	u16 fs_sel, gs_sel;
 	int i;
 
-	vmx->req_immediate_exit = false;
-
 	/*
 	 * Note that guest MSRs to be saved/restored can also be changed
 	 * when guest state is loaded. This happens when guest transitions
@@ -5929,7 +5929,8 @@ static int handle_pml_full(struct kvm_vcpu *vcpu)
 	return 1;
 }
 
-static fastpath_t handle_fastpath_preemption_timer(struct kvm_vcpu *vcpu)
+static fastpath_t handle_fastpath_preemption_timer(struct kvm_vcpu *vcpu,
+						   bool force_immediate_exit)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 
@@ -5945,7 +5946,7 @@ static fastpath_t handle_fastpath_preemption_timer(struct kvm_vcpu *vcpu)
 	 * If the timer expired because KVM used it to force an immediate exit,
 	 * then mission accomplished.
 	 */
-	if (vmx->req_immediate_exit)
+	if (force_immediate_exit)
 		return EXIT_FASTPATH_EXIT_HANDLED;
 
 	/*
@@ -7090,13 +7091,13 @@ static void atomic_switch_perf_msrs(struct vcpu_vmx *vmx)
 					msrs[i].host, false);
 }
 
-static void vmx_update_hv_timer(struct kvm_vcpu *vcpu)
+static void vmx_update_hv_timer(struct kvm_vcpu *vcpu, bool force_immediate_exit)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 	u64 tscl;
 	u32 delta_tsc;
 
-	if (vmx->req_immediate_exit) {
+	if (force_immediate_exit) {
 		vmcs_write32(VMX_PREEMPTION_TIMER_VALUE, 0);
 		vmx->loaded_vmcs->hv_timer_soft_disabled = false;
 	} else if (vmx->hv_deadline_tsc != -1) {
@@ -7149,7 +7150,8 @@ void noinstr vmx_spec_ctrl_restore_host(struct vcpu_vmx *vmx,
 	barrier_nospec();
 }
 
-static fastpath_t vmx_exit_handlers_fastpath(struct kvm_vcpu *vcpu)
+static fastpath_t vmx_exit_handlers_fastpath(struct kvm_vcpu *vcpu,
+					     bool force_immediate_exit)
 {
 	/*
 	 * If L2 is active, some VMX preemption timer exits can be handled in
@@ -7163,7 +7165,7 @@ static fastpath_t vmx_exit_handlers_fastpath(struct kvm_vcpu *vcpu)
 	case EXIT_REASON_MSR_WRITE:
 		return handle_fastpath_set_msr_irqoff(vcpu);
 	case EXIT_REASON_PREEMPTION_TIMER:
-		return handle_fastpath_preemption_timer(vcpu);
+		return handle_fastpath_preemption_timer(vcpu, force_immediate_exit);
 	default:
 		return EXIT_FASTPATH_NONE;
 	}
@@ -7284,7 +7286,9 @@ static fastpath_t vmx_vcpu_run(struct kvm_vcpu *vcpu, bool force_immediate_exit)
 		vmx_passthrough_lbr_msrs(vcpu);
 
 	if (enable_preemption_timer)
-		vmx_update_hv_timer(vcpu);
+		vmx_update_hv_timer(vcpu, force_immediate_exit);
+	else if (force_immediate_exit)
+		smp_send_reschedule(vcpu->cpu);
 
 	kvm_wait_lapic_expire(vcpu);
 
@@ -7358,7 +7362,7 @@ static fastpath_t vmx_vcpu_run(struct kvm_vcpu *vcpu, bool force_immediate_exit)
 	vmx_recover_nmi_blocking(vmx);
 	vmx_complete_interrupts(vmx);
 
-	return vmx_exit_handlers_fastpath(vcpu);
+	return vmx_exit_handlers_fastpath(vcpu, force_immediate_exit);
 }
 
 static void vmx_vcpu_free(struct kvm_vcpu *vcpu)
@@ -7865,11 +7869,6 @@ static __init void vmx_set_cpu_caps(void)
 		kvm_cpu_cap_check_and_set(X86_FEATURE_WAITPKG);
 }
 
-static void vmx_request_immediate_exit(struct kvm_vcpu *vcpu)
-{
-	to_vmx(vcpu)->req_immediate_exit = true;
-}
-
 static int vmx_check_intercept_io(struct kvm_vcpu *vcpu,
 				  struct x86_instruction_info *info)
 {
@@ -8275,8 +8274,6 @@ static struct kvm_x86_ops vmx_x86_ops __initdata = {
 	.check_intercept = vmx_check_intercept,
 	.handle_exit_irqoff = vmx_handle_exit_irqoff,
 
-	.request_immediate_exit = vmx_request_immediate_exit,
-
 	.sched_in = vmx_sched_in,
 
 	.cpu_dirty_log_size = PML_ENTITY_NUM,
@@ -8533,7 +8530,6 @@ static __init int hardware_setup(void)
 	if (!enable_preemption_timer) {
 		vmx_x86_ops.set_hv_timer = NULL;
 		vmx_x86_ops.cancel_hv_timer = NULL;
-		vmx_x86_ops.request_immediate_exit = __kvm_request_immediate_exit;
 	}
 
 	kvm_caps.supported_mce_cap |= MCG_LMCE_P;
diff --git a/arch/x86/kvm/vmx/vmx.h b/arch/x86/kvm/vmx/vmx.h
index 357819872d80..ddbe73958d7f 100644
--- a/arch/x86/kvm/vmx/vmx.h
+++ b/arch/x86/kvm/vmx/vmx.h
@@ -343,8 +343,6 @@ struct vcpu_vmx {
 	unsigned int ple_window;
 	bool ple_window_dirty;
 
-	bool req_immediate_exit;
-
 	/* Support for PML */
 #define PML_ENTITY_NUM		512
 	struct page *pml_pg;
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 652f90ad7107..bc586a6df6ab 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -10578,12 +10578,6 @@ static void kvm_vcpu_reload_apic_access_page(struct kvm_vcpu *vcpu)
 	static_call_cond(kvm_x86_set_apic_access_page_addr)(vcpu);
 }
 
-void __kvm_request_immediate_exit(struct kvm_vcpu *vcpu)
-{
-	smp_send_reschedule(vcpu->cpu);
-}
-EXPORT_SYMBOL_GPL(__kvm_request_immediate_exit);
-
 /*
  * Called within kvm->srcu read side.
  * Returns 1 to let vcpu_run() continue the guest execution loop without
@@ -10817,10 +10811,8 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 		goto cancel_injection;
 	}
 
-	if (req_immediate_exit) {
+	if (req_immediate_exit)
 		kvm_make_request(KVM_REQ_EVENT, vcpu);
-		static_call(kvm_x86_request_immediate_exit)(vcpu);
-	}
 
 	fpregs_assert_state_consistent();
 	if (test_thread_flag(TIF_NEED_FPU_LOAD))
-- 
2.51.0.rc1.163.g2494970778-goog


