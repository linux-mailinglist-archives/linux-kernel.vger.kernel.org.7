Return-Path: <linux-kernel+bounces-668679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2A50AC95D9
	for <lists+linux-kernel@lfdr.de>; Fri, 30 May 2025 20:53:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98D6A7B2CB5
	for <lists+linux-kernel@lfdr.de>; Fri, 30 May 2025 18:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91A4B27AC35;
	Fri, 30 May 2025 18:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f8bJmUl3"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 006BA2798FF
	for <linux-kernel@vger.kernel.org>; Fri, 30 May 2025 18:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748631175; cv=none; b=SXhjSilPISuHy6ANMBbD364ql02l6AnA6pfKB2vfBisr+4suNwnzM+7WOuCl6EEKYbzdZBF5taBdldFg7UXq8OwDpeHVpMvRSDsV7z/ehbVjPk4U9+JQlJcO2wT+stWISANTrQbnJOsOpj8jmWXCgCBhQxE/FffsVfT1s4W4AnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748631175; c=relaxed/simple;
	bh=owdTS74EU1iQeElXtTJ/YqsWhDDXy2y3x5d7V3H/BOM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ADFX01gVIG/afzMzw5mZyZo0tw6xx9vU/UdkbKzpMt9l1W0CLEKsR9BXr1Yt0/QhsKoD6fbRokQWRAiYiQHNOiTKDzOkWFVKcbz9D0MpKFForGT6exwzEWwf4AfHP3NQ6DrejHCzeloq4iLSQQLnJlElz2XjDtj61lyzXglLO5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=f8bJmUl3; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-311ef4fb5fdso2299354a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 30 May 2025 11:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748631173; x=1749235973; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=F+YcHodUCp8IigRxJS1lODQv+5MeXLvP57RmcEYQpWM=;
        b=f8bJmUl3JeuvAvhnlyWqB3G+2lLlKedMLKPoJuFtwZlq5OpW399ytoX0vfMW04xsVx
         KLyA7V41mt0NbvKzTzdNhPDI+OiH4H0ClwJRR1TRpIMEEi+mtseTzdF9nKXsOOq2f94g
         TVXbmrLJeOSshoyRNCi+TELgNbWp9vCUWOa+qBNZleY9uGAuMJVckYA/CJ2Vdwof5kEn
         lvUsJHr5IqW9igVJPDUCQmJJa4/Z5AdXMhJJAZyF3ewMAsrbF7GZxyyYM9bV2/IaI9lA
         fjrVuc+SviWDsALFqOXYCngd7ArQal1ABBkRCvaJQGtgvZvkHqUjB3kgdh/OG1n5bLcM
         fScQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748631173; x=1749235973;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F+YcHodUCp8IigRxJS1lODQv+5MeXLvP57RmcEYQpWM=;
        b=w+jbVPTta3L77lpaDaO2hLtUWGK93s8XZ81a47EeNHnWSuC/VYM5/4hjcV041dX7HX
         r1GqEQwmWV8+aYoJdB/CBF/5RkG+HR3S7sqEwzhketpYOnnS2rs759sEqT2H7pYAgH/6
         qwv0NgCzAdlRvBkLYov2cmp9Gyb4kpKpnSQAjKE2Z56fMAhJ2aBzJCWewnrO2giEQr5w
         2uYA9zw+08EOJNcBvjth4N3MrOoUX5FdT3DIH125i/9oWZ1E0JDyOy8tlWfNrJmvVDco
         BzobAT945s1wjzAJ0BPURPnTm2BhUgNFjEqkHrPUeZMqK4GK89p6wuHKN8sAWzGGEF34
         Zjvg==
X-Gm-Message-State: AOJu0YyWYi9fVKrKZQlBMPg4xzynUIbhDeTPAC5pZzHPqKFb/v6ytkop
	ojz9a2vJKJAp6ofJfF1hV2w2wAu1RQip54X8YtQGGvuCwSs+XLS/DIEp2pYlCXidaM1kiSxTpJO
	fgm6k4IKb2NEveyJuSmmq248O81ie21CsC3F+bAWVgeYROTetaKH478xK44XttHkmqcLEqyOKZ0
	9tpTywFLwK+Q1MUfTd5vOutqykU+DdNmBkxuJpd+0GGYUIodt7xvjXmsM=
X-Google-Smtp-Source: AGHT+IEdT9HM1Egq7Xa07sA2xlBX+zsEJb+0ELTWGP/0Etqs0eKejJyyHanp0C7roqcndqLPF//3CuuesU8nsg==
X-Received: from pjbsi18.prod.google.com ([2002:a17:90b:5292:b0:312:1175:a9e0])
 (user=jmattson job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:2fd0:b0:311:ad7f:3299 with SMTP id 98e67ed59e1d1-3124187b6ccmr6144557a91.25.1748631173476;
 Fri, 30 May 2025 11:52:53 -0700 (PDT)
Date: Fri, 30 May 2025 11:52:24 -0700
In-Reply-To: <20250530185239.2335185-1-jmattson@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250530185239.2335185-1-jmattson@google.com>
X-Mailer: git-send-email 2.49.0.1204.g71687c7c1d-goog
Message-ID: <20250530185239.2335185-3-jmattson@google.com>
Subject: [PATCH v4 2/3] KVM: x86: Provide a capability to disable APERF/MPERF
 read intercepts
From: Jim Mattson <jmattson@google.com>
To: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="UTF-8"

Allow a guest to read the physical IA32_APERF and IA32_MPERF MSRs
without interception.

The IA32_APERF and IA32_MPERF MSRs are not virtualized. Writes are not
handled at all. The MSR values are not zeroed on vCPU creation, saved
on suspend, or restored on resume. No accommodation is made for
processor migration or for sharing a logical processor with other
tasks. No adjustments are made for non-unit TSC multipliers. The MSRs
do not account for time the same way as the comparable PMU events,
whether the PMU is virtualized by the traditional emulation method or
the new mediated pass-through approach.

Nonetheless, in a properly constrained environment, this capability
can be combined with a guest CPUID table that advertises support for
CPUID.6:ECX.APERFMPERF[bit 0] to induce a Linux guest to report the
effective physical CPU frequency in /proc/cpuinfo. Moreover, there is
no performance cost for this capability.

Signed-off-by: Jim Mattson <jmattson@google.com>
---
 Documentation/virt/kvm/api.rst | 23 +++++++++++++++++++++++
 arch/x86/kvm/svm/svm.c         |  7 +++++++
 arch/x86/kvm/svm/svm.h         |  2 +-
 arch/x86/kvm/vmx/vmx.c         |  6 ++++++
 arch/x86/kvm/vmx/vmx.h         |  2 +-
 arch/x86/kvm/x86.c             |  8 +++++++-
 arch/x86/kvm/x86.h             |  5 +++++
 include/uapi/linux/kvm.h       |  1 +
 tools/include/uapi/linux/kvm.h |  1 +
 9 files changed, 52 insertions(+), 3 deletions(-)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index 6fb1870f0999..5849a14a6712 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -7780,6 +7780,7 @@ Valid bits in args[0] are::
   #define KVM_X86_DISABLE_EXITS_HLT              (1 << 1)
   #define KVM_X86_DISABLE_EXITS_PAUSE            (1 << 2)
   #define KVM_X86_DISABLE_EXITS_CSTATE           (1 << 3)
+  #define KVM_X86_DISABLE_EXITS_APERFMPERF       (1 << 4)
 
 Enabling this capability on a VM provides userspace with a way to no
 longer intercept some instructions for improved latency in some
@@ -7790,6 +7791,28 @@ all such vmexits.
 
 Do not enable KVM_FEATURE_PV_UNHALT if you disable HLT exits.
 
+Virtualizing the ``IA32_APERF`` and ``IA32_MPERF`` MSRs requires more
+than just disabling APERF/MPERF exits. While both Intel and AMD
+document strict usage conditions for these MSRs--emphasizing that only
+the ratio of their deltas over a time interval (T0 to T1) is
+architecturally defined--simply passing through the MSRs can still
+produce an incorrect ratio.
+
+This erroneous ratio can occur if, between T0 and T1:
+
+1. The vCPU thread migrates between logical processors.
+2. Live migration or suspend/resume operations take place.
+3. Another task shares the vCPU's logical processor.
+4. C-states lower thean C0 are emulated (e.g., via HLT interception).
+5. The guest TSC frequency doesn't match the host TSC frequency.
+
+Due to these complexities, KVM does not automatically associate this
+passthrough capability with the guest CPUID bit,
+``CPUID.6:ECX.APERFMPERF[bit 0]``. Userspace VMMs that deem this
+mechanism adequate for virtualizing the ``IA32_APERF`` and
+``IA32_MPERF`` MSRs must set the guest CPUID bit explicitly.
+
+
 7.14 KVM_CAP_S390_HPAGE_1M
 --------------------------
 
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 6d2d97fd967a..12468d228bb8 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -112,6 +112,8 @@ static const struct svm_direct_access_msrs {
 	{ .index = MSR_IA32_CR_PAT,			.always = false },
 	{ .index = MSR_AMD64_SEV_ES_GHCB,		.always = true  },
 	{ .index = MSR_TSC_AUX,				.always = false },
+	{ .index = MSR_IA32_APERF,			.always = false },
+	{ .index = MSR_IA32_MPERF,			.always = false },
 	{ .index = X2APIC_MSR(APIC_ID),			.always = false },
 	{ .index = X2APIC_MSR(APIC_LVR),		.always = false },
 	{ .index = X2APIC_MSR(APIC_TASKPRI),		.always = false },
@@ -1357,6 +1359,11 @@ static void init_vmcb(struct kvm_vcpu *vcpu)
 	if (boot_cpu_has(X86_FEATURE_V_SPEC_CTRL))
 		set_msr_interception(vcpu, svm->msrpm, MSR_IA32_SPEC_CTRL, 1, 1);
 
+	if (kvm_aperfmperf_in_guest(vcpu->kvm)) {
+		set_msr_interception(vcpu, svm->msrpm, MSR_IA32_APERF, 1, 0);
+		set_msr_interception(vcpu, svm->msrpm, MSR_IA32_MPERF, 1, 0);
+	}
+
 	if (kvm_vcpu_apicv_active(vcpu))
 		avic_init_vmcb(svm, vmcb);
 
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index f16b068c4228..ef10122ef590 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -44,7 +44,7 @@ static inline struct page *__sme_pa_to_page(unsigned long pa)
 #define	IOPM_SIZE PAGE_SIZE * 3
 #define	MSRPM_SIZE PAGE_SIZE * 2
 
-#define MAX_DIRECT_ACCESS_MSRS	48
+#define MAX_DIRECT_ACCESS_MSRS	50
 #define MSRPM_OFFSETS	32
 extern u32 msrpm_offsets[MSRPM_OFFSETS] __read_mostly;
 extern bool npt_enabled;
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 136be14e6db0..e8eeafd813e5 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -188,6 +188,8 @@ static u32 vmx_possible_passthrough_msrs[MAX_POSSIBLE_PASSTHROUGH_MSRS] = {
 	MSR_CORE_C3_RESIDENCY,
 	MSR_CORE_C6_RESIDENCY,
 	MSR_CORE_C7_RESIDENCY,
+	MSR_IA32_APERF,
+	MSR_IA32_MPERF,
 };
 
 /*
@@ -7569,6 +7571,10 @@ int vmx_vcpu_create(struct kvm_vcpu *vcpu)
 		vmx_disable_intercept_for_msr(vcpu, MSR_CORE_C6_RESIDENCY, MSR_TYPE_R);
 		vmx_disable_intercept_for_msr(vcpu, MSR_CORE_C7_RESIDENCY, MSR_TYPE_R);
 	}
+	if (kvm_aperfmperf_in_guest(vcpu->kvm)) {
+		vmx_disable_intercept_for_msr(vcpu, MSR_IA32_APERF, MSR_TYPE_R);
+		vmx_disable_intercept_for_msr(vcpu, MSR_IA32_MPERF, MSR_TYPE_R);
+	}
 
 	vmx->loaded_vmcs = &vmx->vmcs01;
 
diff --git a/arch/x86/kvm/vmx/vmx.h b/arch/x86/kvm/vmx/vmx.h
index 6d1e40ecc024..24c0bd2ff5e9 100644
--- a/arch/x86/kvm/vmx/vmx.h
+++ b/arch/x86/kvm/vmx/vmx.h
@@ -297,7 +297,7 @@ struct vcpu_vmx {
 	struct lbr_desc lbr_desc;
 
 	/* Save desired MSR intercept (read: pass-through) state */
-#define MAX_POSSIBLE_PASSTHROUGH_MSRS	16
+#define MAX_POSSIBLE_PASSTHROUGH_MSRS	18
 	struct {
 		DECLARE_BITMAP(read, MAX_POSSIBLE_PASSTHROUGH_MSRS);
 		DECLARE_BITMAP(write, MAX_POSSIBLE_PASSTHROUGH_MSRS);
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 8c20afda4398..4e53e555f6cf 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -4574,6 +4574,9 @@ static u64 kvm_get_allowed_disable_exits(void)
 {
 	u64 r = KVM_X86_DISABLE_EXITS_PAUSE;
 
+	if (boot_cpu_has(X86_FEATURE_APERFMPERF))
+		r |= KVM_X86_DISABLE_EXITS_APERFMPERF;
+
 	if (!mitigate_smt_rsb) {
 		r |= KVM_X86_DISABLE_EXITS_HLT |
 			KVM_X86_DISABLE_EXITS_CSTATE;
@@ -6601,7 +6604,8 @@ int kvm_vm_ioctl_enable_cap(struct kvm *kvm,
 
 		if (!mitigate_smt_rsb && boot_cpu_has_bug(X86_BUG_SMT_RSB) &&
 		    cpu_smt_possible() &&
-		    (cap->args[0] & ~KVM_X86_DISABLE_EXITS_PAUSE))
+		    (cap->args[0] & ~(KVM_X86_DISABLE_EXITS_PAUSE |
+				      KVM_X86_DISABLE_EXITS_APERFMPERF)))
 			pr_warn_once(SMT_RSB_MSG);
 
 		if (cap->args[0] & KVM_X86_DISABLE_EXITS_PAUSE)
@@ -6612,6 +6616,8 @@ int kvm_vm_ioctl_enable_cap(struct kvm *kvm,
 			kvm_disable_exits(kvm, KVM_X86_DISABLE_EXITS_HLT);
 		if (cap->args[0] & KVM_X86_DISABLE_EXITS_CSTATE)
 			kvm_disable_exits(kvm, KVM_X86_DISABLE_EXITS_CSTATE);
+		if (cap->args[0] & KVM_X86_DISABLE_EXITS_APERFMPERF)
+			kvm_disable_exits(kvm, KVM_X86_DISABLE_EXITS_APERFMPERF);
 		r = 0;
 disable_exits_unlock:
 		mutex_unlock(&kvm->lock);
diff --git a/arch/x86/kvm/x86.h b/arch/x86/kvm/x86.h
index 0ad36851df4c..f6334201014a 100644
--- a/arch/x86/kvm/x86.h
+++ b/arch/x86/kvm/x86.h
@@ -506,6 +506,11 @@ static inline bool kvm_cstate_in_guest(struct kvm *kvm)
 	return kvm->arch.disabled_exits & KVM_X86_DISABLE_EXITS_CSTATE;
 }
 
+static inline bool kvm_aperfmperf_in_guest(struct kvm *kvm)
+{
+	return kvm->arch.disabled_exits & KVM_X86_DISABLE_EXITS_APERFMPERF;
+}
+
 static inline bool kvm_notify_vmexit_enabled(struct kvm *kvm)
 {
 	return kvm->arch.notify_vmexit_flags & KVM_X86_NOTIFY_VMEXIT_ENABLED;
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index d00b85cb168c..7415a3863891 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -618,6 +618,7 @@ struct kvm_ioeventfd {
 #define KVM_X86_DISABLE_EXITS_HLT            (1 << 1)
 #define KVM_X86_DISABLE_EXITS_PAUSE          (1 << 2)
 #define KVM_X86_DISABLE_EXITS_CSTATE         (1 << 3)
+#define KVM_X86_DISABLE_EXITS_APERFMPERF     (1 << 4)
 
 /* for KVM_ENABLE_CAP */
 struct kvm_enable_cap {
diff --git a/tools/include/uapi/linux/kvm.h b/tools/include/uapi/linux/kvm.h
index b6ae8ad8934b..eef57c117140 100644
--- a/tools/include/uapi/linux/kvm.h
+++ b/tools/include/uapi/linux/kvm.h
@@ -617,6 +617,7 @@ struct kvm_ioeventfd {
 #define KVM_X86_DISABLE_EXITS_HLT            (1 << 1)
 #define KVM_X86_DISABLE_EXITS_PAUSE          (1 << 2)
 #define KVM_X86_DISABLE_EXITS_CSTATE         (1 << 3)
+#define KVM_X86_DISABLE_EXITS_APERFMPERF     (1 << 4)
 
 /* for KVM_ENABLE_CAP */
 struct kvm_enable_cap {
-- 
2.49.0.1204.g71687c7c1d-goog


