Return-Path: <linux-kernel+bounces-814879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C459B55A09
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 01:26:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2872AAE0413
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 23:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 793CF2D238A;
	Fri, 12 Sep 2025 23:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ax2aCT+n"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D462C326A
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 23:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757719422; cv=none; b=XPZ8EjVHOtwukAPpsjRLh3FCF7LAQxif1wSHDtic2FGSG8POYaH4cFeJcV+58KFOdTlijcc9jc6c2X7Flkl3ETP7p5HrrP2jpoqhtweZ5ZVZtnvD37PplST1l5vM1hIbDK9t7LJh95yUN2W6pzrw5Y9Jtq5OECRlZ/2EHqyDtPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757719422; c=relaxed/simple;
	bh=Q4sWENnZ2Fn2hft2ldlC0V7CW+RA9ysgaxIOsYeJde4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Wks2gU/kwyJEyzPbF7HW5lEcbXY1JlWfAgd7nUFwRjqSNS9Uxn2jNEf9MlUCiTjs8ObTEYFzdcVCr0OhbvwHDLN8LIbCA8dnDSEb6YpMJSVNMtw7fmm6GAP220SvX0xUkdMj9glcnZJ25MAxO8XNhxRmEijc+l3CkVCfDTThGYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ax2aCT+n; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-329ee69e7deso2264455a91.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 16:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757719420; x=1758324220; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=DBr/44b6lYswEVM0M6nY82+diPPzhiEHpmKTJKrfvSM=;
        b=ax2aCT+nuXrc9TPPK3LFtRG+f5epSJhpU9Bwaeg9QNjQOWg+fnPJxzE4YOXjAP/39c
         Ij9eLhtuZZECtisKq2ngDAgF56pj7D9fmzqh1kdevWVWQwlhp05AKRKivyeXKz6O0kym
         cxLLLr+N3pSMvxv+TkfpoKQ0iUnR0RRNzweCFPYK1mXwy9Dk2J3/ob8F9xjsVumk0+vy
         WmXpwYSZxZybgDs+0vLZ4qMOhvGADL4WV6ghgWr66WoVqMwZ4fr8UzFOBtug7XrpHQ6Z
         FEOi+jkGmF0iElcP3bPOQz8LP/EFIRR/L3W+HosLkMYSI/rEeSDR9DfK9rRUkd4kS0B/
         kA3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757719420; x=1758324220;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DBr/44b6lYswEVM0M6nY82+diPPzhiEHpmKTJKrfvSM=;
        b=dBjQJK1UCIfUSoGtSmyaHsb9mT+kc7wVMY60tpJMRzGnADoSa11KI6V2Mj55ehrmVp
         t2uTLWZRMct0gpgzfBsv9ZebwovhzW62YpccDMh7wew5IDZaO8KFRDYKw2IK6EdIfNAO
         mPdpw0q5YQ/wv4ykBe83M6aAs3hBnoEcm7rGqdwkpdABNkZlvvf+QNhVb8+zV/J5aX3T
         QitD3HItKt7PPo79YW3Cu38i6X3YqWLHnwBxzn6ouOSLGzDsHGGM8EHHQmQpvVC8r2m+
         xY5d6op7mN+TPrW4n/lZV7rsCRprd0gpUiL7A6I/DLSfs1bpUxLoxPbMCAGyfuzLdzHw
         KeJA==
X-Forwarded-Encrypted: i=1; AJvYcCWdPSR8WLkIy4T2/VaELAae9pyieUkw1Wbbs1ETc9tUFqDV1/zwTYm/qPONhCkB3+1NmhqGShnO7GkyTWI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzt0SEYXMio8SuZICVuwv52ddX0XUivtzuJQ2D54Eva0vHoGt39
	pIqSN0xHzkNWlz0Fj8RDldMpeMC0jPuJr44JG2LdRsaCRjkcGSRVPUaUxz/iMyxYSzGm0A7utqT
	Z0vSqNg==
X-Google-Smtp-Source: AGHT+IFGRdeIU34eluX7zZwNW8zkRo9xwQ8fp81G0HUaPPTK777520E0YhVr9W2GJDoawOPN3rWjDXwweog=
X-Received: from pjee6.prod.google.com ([2002:a17:90b:5786:b0:32d:e264:a78e])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3c88:b0:327:ced1:26e2
 with SMTP id 98e67ed59e1d1-32de4f85704mr4726196a91.18.1757719420434; Fri, 12
 Sep 2025 16:23:40 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 12 Sep 2025 16:22:47 -0700
In-Reply-To: <20250912232319.429659-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250912232319.429659-1-seanjc@google.com>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250912232319.429659-10-seanjc@google.com>
Subject: [PATCH v15 09/41] KVM: x86: Load guest FPU state when access
 XSAVE-managed MSRs
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Tom Lendacky <thomas.lendacky@amd.com>, Mathias Krause <minipli@grsecurity.net>, 
	John Allen <john.allen@amd.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Chao Gao <chao.gao@intel.com>, Maxim Levitsky <mlevitsk@redhat.com>, 
	Xiaoyao Li <xiaoyao.li@intel.com>, Zhang Yi Z <yi.z.zhang@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"

Load the guest's FPU state if userspace is accessing MSRs whose values
are managed by XSAVES. Introduce two helpers, kvm_{get,set}_xstate_msr(),
to facilitate access to such kind of MSRs.

If MSRs supported in kvm_caps.supported_xss are passed through to guest,
the guest MSRs are swapped with host's before vCPU exits to userspace and
after it reenters kernel before next VM-entry.

Because the modified code is also used for the KVM_GET_MSRS device ioctl(),
explicitly check @vcpu is non-null before attempting to load guest state.
The XSAVE-managed MSRs cannot be retrieved via the device ioctl() without
loading guest FPU state (which doesn't exist).

Note that guest_cpuid_has() is not queried as host userspace is allowed to
access MSRs that have not been exposed to the guest, e.g. it might do
KVM_SET_MSRS prior to KVM_SET_CPUID2.

The two helpers are put here in order to manifest accessing xsave-managed
MSRs requires special check and handling to guarantee the correctness of
read/write to the MSRs.

Co-developed-by: Yang Weijiang <weijiang.yang@intel.com>
Signed-off-by: Yang Weijiang <weijiang.yang@intel.com>
Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
Tested-by: Mathias Krause <minipli@grsecurity.net>
Tested-by: John Allen <john.allen@amd.com>
Tested-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Chao Gao <chao.gao@intel.com>
[sean: drop S_CET, add big comment, move accessors to x86.c]
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/x86.c | 86 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 85 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index c5e38d6943fe..a95ca2fbd3a9 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -136,6 +136,9 @@ static int __set_sregs2(struct kvm_vcpu *vcpu, struct kvm_sregs2 *sregs2);
 static void __get_sregs2(struct kvm_vcpu *vcpu, struct kvm_sregs2 *sregs2);
 
 static DEFINE_MUTEX(vendor_module_lock);
+static void kvm_load_guest_fpu(struct kvm_vcpu *vcpu);
+static void kvm_put_guest_fpu(struct kvm_vcpu *vcpu);
+
 struct kvm_x86_ops kvm_x86_ops __read_mostly;
 
 #define KVM_X86_OP(func)					     \
@@ -3801,6 +3804,66 @@ static void record_steal_time(struct kvm_vcpu *vcpu)
 	mark_page_dirty_in_slot(vcpu->kvm, ghc->memslot, gpa_to_gfn(ghc->gpa));
 }
 
+/*
+ * Returns true if the MSR in question is managed via XSTATE, i.e. is context
+ * switched with the rest of guest FPU state.  Note!  S_CET is _not_ context
+ * switched via XSTATE even though it _is_ saved/restored via XSAVES/XRSTORS.
+ * Because S_CET is loaded on VM-Enter and VM-Exit via dedicated VMCS fields,
+ * the value saved/restored via XSTATE is always the host's value.  That detail
+ * is _extremely_ important, as the guest's S_CET must _never_ be resident in
+ * hardware while executing in the host.  Loading guest values for U_CET and
+ * PL[0-3]_SSP while executing in the kernel is safe, as U_CET is specific to
+ * userspace, and PL[0-3]_SSP are only consumed when transitioning to lower
+ * privilegel levels, i.e. are effectively only consumed by userspace as well.
+ */
+static bool is_xstate_managed_msr(struct kvm_vcpu *vcpu, u32 msr)
+{
+	if (!vcpu)
+		return false;
+
+	switch (msr) {
+	case MSR_IA32_U_CET:
+		return guest_cpu_cap_has(vcpu, X86_FEATURE_SHSTK) ||
+		       guest_cpu_cap_has(vcpu, X86_FEATURE_IBT);
+	case MSR_IA32_PL0_SSP ... MSR_IA32_PL3_SSP:
+		return guest_cpu_cap_has(vcpu, X86_FEATURE_SHSTK);
+	default:
+		return false;
+	}
+}
+
+/*
+ * Lock and/or reload guest FPU and access xstate MSRs. For accesses initiated
+ * by host, guest FPU is loaded in __msr_io(). For accesses initiated by guest,
+ * guest FPU should have been loaded already.
+ */
+static __always_inline void kvm_access_xstate_msr(struct kvm_vcpu *vcpu,
+						  struct msr_data *msr_info,
+						  int access)
+{
+	BUILD_BUG_ON(access != MSR_TYPE_R && access != MSR_TYPE_W);
+
+	KVM_BUG_ON(!is_xstate_managed_msr(vcpu, msr_info->index), vcpu->kvm);
+	KVM_BUG_ON(!vcpu->arch.guest_fpu.fpstate->in_use, vcpu->kvm);
+
+	kvm_fpu_get();
+	if (access == MSR_TYPE_R)
+		rdmsrq(msr_info->index, msr_info->data);
+	else
+		wrmsrq(msr_info->index, msr_info->data);
+	kvm_fpu_put();
+}
+
+static __maybe_unused void kvm_set_xstate_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
+{
+	kvm_access_xstate_msr(vcpu, msr_info, MSR_TYPE_W);
+}
+
+static __maybe_unused void kvm_get_xstate_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
+{
+	kvm_access_xstate_msr(vcpu, msr_info, MSR_TYPE_R);
+}
+
 int kvm_set_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 {
 	u32 msr = msr_info->index;
@@ -4551,11 +4614,25 @@ static int __msr_io(struct kvm_vcpu *vcpu, struct kvm_msrs *msrs,
 		    int (*do_msr)(struct kvm_vcpu *vcpu,
 				  unsigned index, u64 *data))
 {
+	bool fpu_loaded = false;
 	int i;
 
-	for (i = 0; i < msrs->nmsrs; ++i)
+	for (i = 0; i < msrs->nmsrs; ++i) {
+		/*
+		 * If userspace is accessing one or more XSTATE-managed MSRs,
+		 * temporarily load the guest's FPU state so that the guest's
+		 * MSR value(s) is resident in hardware, i.e. so that KVM can
+		 * get/set the MSR via RDMSR/WRMSR.
+		 */
+		if (!fpu_loaded && is_xstate_managed_msr(vcpu, entries[i].index)) {
+			kvm_load_guest_fpu(vcpu);
+			fpu_loaded = true;
+		}
 		if (do_msr(vcpu, entries[i].index, &entries[i].data))
 			break;
+	}
+	if (fpu_loaded)
+		kvm_put_guest_fpu(vcpu);
 
 	return i;
 }
@@ -5965,6 +6042,7 @@ static int kvm_get_set_one_reg(struct kvm_vcpu *vcpu, unsigned int ioctl,
 	struct kvm_one_reg one_reg;
 	struct kvm_x86_reg_id *reg;
 	u64 __user *user_val;
+	bool load_fpu;
 	int r;
 
 	if (copy_from_user(&one_reg, argp, sizeof(one_reg)))
@@ -5991,12 +6069,18 @@ static int kvm_get_set_one_reg(struct kvm_vcpu *vcpu, unsigned int ioctl,
 
 	guard(srcu)(&vcpu->kvm->srcu);
 
+	load_fpu = is_xstate_managed_msr(vcpu, reg->index);
+	if (load_fpu)
+		kvm_load_guest_fpu(vcpu);
+
 	user_val = u64_to_user_ptr(one_reg.addr);
 	if (ioctl == KVM_GET_ONE_REG)
 		r = kvm_get_one_msr(vcpu, reg->index, user_val);
 	else
 		r = kvm_set_one_msr(vcpu, reg->index, user_val);
 
+	if (load_fpu)
+		kvm_put_guest_fpu(vcpu);
 	return r;
 }
 
-- 
2.51.0.384.g4c02a37b29-goog


