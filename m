Return-Path: <linux-kernel+bounces-879302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AD18C22C91
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 01:32:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12C7A18860F9
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 00:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CE4120E704;
	Fri, 31 Oct 2025 00:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mnhPmY0V"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D03871EEA31
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 00:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761870653; cv=none; b=sUxMDM0ClkEan4Veq0aqcaqNqFaOixRE5so555yeMbt63+6NjUfOhPJhqIXuzHMOPlw8nz21HPsbzZffmY9gA+wC/kKwKgz5GHfJV9cVsDksbpkEi+mUuCVUOOPWGeF5QfnmMIRjtFm79iQZAnp+DE8ki2DT75ekopQAfjvt+sY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761870653; c=relaxed/simple;
	bh=204kvc9Sh64+E5don3tZqDdX3H79XbbcG9Pj9ZXTPaA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EV0Jr33hiUoIBH2QdhaXiRSnUIBp8lTPbHlskPEOVxD6yhyWtrzf8774dgfi2KRu7Vc1IMj4HQj042dvisVIeDa4pNdzAcwadqm4aRJxAxiM9FPTGqmDNlBQtF6KeH7YXp+Zh0nwdi4G3nLlFBXh/3uPSQ38ns+VJLlze1Ia7Sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mnhPmY0V; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-3407734d9a2so709272a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 17:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761870651; x=1762475451; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=+Ni/Sag5alXumMH5JEH8v/XUc2VFZKFCdXeaB2UWRR0=;
        b=mnhPmY0VTopZrw7FdgaWBjBzGu2v5KW1YuRuu+NzZoejr/vGWivtn5Zi/2D1EDE+JO
         toC5GkTtWnMzxEEi2hRXfA/U5XpuUue/8xatu7kpR5tw5QjjGB9snOzBjqsJsf1ZP++p
         Gx8jBRez92WAJYMHCWhMKA70qJBZ2FkayILKDC34Wyb1DMs3DvkSBIuGukEXdgsnhXFm
         y6SPCPLQSb71V1gOWAABoe4DKqfoTnNUx8UQRCCe99C5TEgcZMSGNBA+mg+pBMaTQ0NJ
         6w2utDLVuNZNfk3QBsk54P1U8a8pfSOe21hHNw0JvSd+jAmhehn0oNETt3HQaNYCDHLR
         NJFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761870651; x=1762475451;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+Ni/Sag5alXumMH5JEH8v/XUc2VFZKFCdXeaB2UWRR0=;
        b=R75LWkejI8IpW+DABU0w5izmNML7sZB0jmy8idpaABFgQYhrJWuW2KxytVsTCgKAo7
         8pFBbeFt/q7WtUMYngTzYM2bQTNQqwL69DiDqvlnIoXmH6WEUfYex6Cvi931dCaogB3B
         dkhEQa50hkkIc7XDI8h8orfQQ2rnRhSal1kCZ6IrPLOp9sirYMsCvlK8way23OLeW97O
         R8vE3WUFvXaSUsKSEDthZPYY5WX1pcd8731l82mohHkVgHmkK6wpk3FoL93NpDucqbK+
         Ox1L5Ok2YSAYS4GKq9ylfSnxokWhtGp030qI/HnMcdoMBFQs0Lq2upiEdHqObPN7HpxO
         TXow==
X-Forwarded-Encrypted: i=1; AJvYcCXPFlERbIlo345t9wek9XZnhiEgj6YC969Vm+2rGJxcKEv86UM0dEWQsaF/RDZ7obBGODnVAJo0OoE3wEY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTBNAIVwxpZdqGXCxNeGWvmRi5xP8BSMc2Z4JJ5CDTFtb8psMg
	DZ28mcAYurzi2dRUkq6Fi5FEfquALMUKZ/uQQxCA5y3dAr2OVycb79a9oMMT1FMsYKk7jyZttcd
	FJUd2ew==
X-Google-Smtp-Source: AGHT+IHAbp7NeoWbQWeIYNfOpGSHL72rool/Rd8q9eUo8nRattwseg6De/78cGSxrzhplvoG0mpBkjEtkFA=
X-Received: from pjbgi3.prod.google.com ([2002:a17:90b:1103:b0:33b:ba58:40a6])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2584:b0:32c:2cd:4d67
 with SMTP id 98e67ed59e1d1-34082fdf30bmr2092781a91.13.1761870651098; Thu, 30
 Oct 2025 17:30:51 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 30 Oct 2025 17:30:35 -0700
In-Reply-To: <20251031003040.3491385-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251031003040.3491385-1-seanjc@google.com>
X-Mailer: git-send-email 2.51.1.930.gacf6e81ea2-goog
Message-ID: <20251031003040.3491385-4-seanjc@google.com>
Subject: [PATCH v4 3/8] x86/bugs: Use an X86_FEATURE_xxx flag for the MMIO
 Stale Data mitigation
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, Peter Zijlstra <peterz@infradead.org>, 
	Josh Poimboeuf <jpoimboe@kernel.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Brendan Jackman <jackmanb@google.com>
Content-Type: text/plain; charset="UTF-8"

Convert the MMIO Stale Data mitigation flag from a static branch into an
X86_FEATURE_xxx so that it can be used via ALTERNATIVE_2 in KVM.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/cpufeatures.h   |  1 +
 arch/x86/include/asm/nospec-branch.h |  2 --
 arch/x86/kernel/cpu/bugs.c           | 11 +----------
 arch/x86/kvm/mmu/spte.c              |  2 +-
 arch/x86/kvm/vmx/vmx.c               |  4 ++--
 5 files changed, 5 insertions(+), 15 deletions(-)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 7129eb44adad..d1d7b5ec6425 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -501,6 +501,7 @@
 #define X86_FEATURE_ABMC		(21*32+15) /* Assignable Bandwidth Monitoring Counters */
 #define X86_FEATURE_MSR_IMM		(21*32+16) /* MSR immediate form instructions */
 #define X86_FEATURE_X2AVIC_EXT		(21*32+17) /* AMD SVM x2AVIC support for 4k vCPUs */
+#define X86_FEATURE_CLEAR_CPU_BUF_MMIO	(21*32+18) /* Clear CPU buffers using VERW before VMRUN, iff the vCPU can access host MMIO*/
 
 /*
  * BUG word(s)
diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index 923ae21cbef1..b29df45b1edb 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -579,8 +579,6 @@ DECLARE_STATIC_KEY_FALSE(cpu_buf_idle_clear);
 
 DECLARE_STATIC_KEY_FALSE(switch_mm_cond_l1d_flush);
 
-DECLARE_STATIC_KEY_FALSE(cpu_buf_vm_clear);
-
 extern u16 x86_verw_sel;
 
 #include <asm/segment.h>
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 723666a1357e..9acf6343b0ac 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -192,14 +192,6 @@ EXPORT_SYMBOL_GPL(cpu_buf_idle_clear);
  */
 DEFINE_STATIC_KEY_FALSE(switch_mm_cond_l1d_flush);
 
-/*
- * Controls CPU Fill buffer clear before VMenter. This is a subset of
- * X86_FEATURE_CLEAR_CPU_BUF_VM, and should only be enabled when KVM-only
- * mitigation is required.
- */
-DEFINE_STATIC_KEY_FALSE(cpu_buf_vm_clear);
-EXPORT_SYMBOL_GPL(cpu_buf_vm_clear);
-
 #undef pr_fmt
 #define pr_fmt(fmt)	"mitigations: " fmt
 
@@ -751,9 +743,8 @@ static void __init mmio_apply_mitigation(void)
 	if (verw_clear_cpu_buf_mitigation_selected) {
 		setup_force_cpu_cap(X86_FEATURE_CLEAR_CPU_BUF);
 		setup_force_cpu_cap(X86_FEATURE_CLEAR_CPU_BUF_VM);
-		static_branch_disable(&cpu_buf_vm_clear);
 	} else {
-		static_branch_enable(&cpu_buf_vm_clear);
+		setup_force_cpu_cap(X86_FEATURE_CLEAR_CPU_BUF_MMIO);
 	}
 
 	/*
diff --git a/arch/x86/kvm/mmu/spte.c b/arch/x86/kvm/mmu/spte.c
index 37647afde7d3..c43dd153d868 100644
--- a/arch/x86/kvm/mmu/spte.c
+++ b/arch/x86/kvm/mmu/spte.c
@@ -292,7 +292,7 @@ bool make_spte(struct kvm_vcpu *vcpu, struct kvm_mmu_page *sp,
 		mark_page_dirty_in_slot(vcpu->kvm, slot, gfn);
 	}
 
-	if (static_branch_unlikely(&cpu_buf_vm_clear) &&
+	if (cpu_feature_enabled(X86_FEATURE_CLEAR_CPU_BUF_MMIO) &&
 	    !kvm_vcpu_can_access_host_mmio(vcpu) &&
 	    kvm_is_mmio_pfn(pfn, &is_host_mmio))
 		kvm_track_host_mmio_mapping(vcpu);
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 1021d3b65ea0..68cde725d1c7 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -903,7 +903,7 @@ unsigned int __vmx_vcpu_run_flags(struct vcpu_vmx *vmx)
 	if (!msr_write_intercepted(vmx, MSR_IA32_SPEC_CTRL))
 		flags |= VMX_RUN_SAVE_SPEC_CTRL;
 
-	if (static_branch_unlikely(&cpu_buf_vm_clear) &&
+	if (cpu_feature_enabled(X86_FEATURE_CLEAR_CPU_BUF_MMIO) &&
 	    kvm_vcpu_can_access_host_mmio(&vmx->vcpu))
 		flags |= VMX_RUN_CLEAR_CPU_BUFFERS_FOR_MMIO;
 
@@ -7351,7 +7351,7 @@ static noinstr void vmx_vcpu_enter_exit(struct kvm_vcpu *vcpu,
 	 */
 	if (static_branch_unlikely(&vmx_l1d_should_flush))
 		vmx_l1d_flush(vcpu);
-	else if (static_branch_unlikely(&cpu_buf_vm_clear) &&
+	else if (cpu_feature_enabled(X86_FEATURE_CLEAR_CPU_BUF_MMIO) &&
 		 (flags & VMX_RUN_CLEAR_CPU_BUFFERS_FOR_MMIO))
 		x86_clear_cpu_buffers();
 
-- 
2.51.1.930.gacf6e81ea2-goog


