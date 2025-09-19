Return-Path: <linux-kernel+bounces-825279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1C10B8B7C3
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 00:35:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB4BD3B48F4
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 22:35:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EECF92E0902;
	Fri, 19 Sep 2025 22:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FskW+/5M"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C9282DF6F7
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 22:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758321199; cv=none; b=afUlJS52HFbN0qPBIu9MUV6N+wLk3qtBfpPrr4GijuI4M6yueuFy9NIrfcIpO9GCFIFV7qgB5Y9SqeYdp2ZUjNfvGhPlDy6PaMgp8fLy0uZCf31AlOrqK9vwpbjJ9+fhmYFRmDwDlzdXFusWTVeXgDuUbbWT+o2+UCaKpAa1v8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758321199; c=relaxed/simple;
	bh=SUbk9rvQ5iSbOyrSbqe2IoTOG4vNnWYJ/8YngPPf7Nw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JBjWZr8zl7gIJtv4t30+tmhNcZ4OszVoyyHI6B2ei+koZW9Q7jRAJKPoJg806LjkbUCCpnl5Xi7I2Fsu+eHPTBA4dJ1cPqMKZ4zCsEywA/1j6S89BhfYdsO8xoAsHKqrnMnEh7tvvumkjN46ZpEAwnGy3g1Z6Nfw8kFOLp1RZ3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FskW+/5M; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-32e8c800a79so3173101a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 15:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758321197; x=1758925997; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=+JcaMt2ydOaiLW5D8ASKub/1/NSATOOQH1xnCAbO6Bg=;
        b=FskW+/5Mathq1U3ycsGVUUc5Pt1uD2k8V9Q3buttgrSsab1LkxU2D2Y1dd4iHeC6lu
         OTMcIVk//xsFndJqskC3DIo1LDU3s/vUo//aNGnoKCC4HFvFJDQvDABTAhgtn8j2dYeN
         jkXuDKKg1vtUCiV1Wk7yz7Vr5Z6QgUDOfGMpdrG0S1akrpfuuappuDoe/ZbSmnGRg3pN
         ARyYnHOmqD0hcRRigd0UosGeaV9mOnrRUOWfY68omfT2CHaPFqxRakxqjHCClLnF+Lc9
         e05QwdYakgRmLZpmZN2DTt0/IFE/4N3IlEHDFz21tSCddOiMJlQbKVzgDEF+2X7sp6cx
         XE0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758321197; x=1758925997;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+JcaMt2ydOaiLW5D8ASKub/1/NSATOOQH1xnCAbO6Bg=;
        b=d85g4utlu3m+VOcL2wzsD76Fnh50ARL4YuD6J9M8Gg0QFlCWUecVvXSaKoTaKzUmMo
         YjP5gTH/0citWehSinqhDqFIm6OTDwZtG90jEP7ypcBSnvTPa/Auj64y3oBBctJ67z1h
         PNkUnhSLCV19h3xk6HAEQpLRGVNrpsHfDzm9Xm1/iSsm21dlPf3C67w0yiPq+aPCRhGi
         1JHlqd1JAWMDZtrmgcE2N3Na+z7LRe1oLYBuCQiP2ezm9c4MmwvNSsVMR2hezb3m4dZI
         suiX8EVi0VVpcRBWeos/onG2w3cD5MOI55oJdhG7UvcVVcoLIvGywjagcLzg2amn/StK
         tOZg==
X-Forwarded-Encrypted: i=1; AJvYcCVYe+UfWhiq1FeswfTClhFfHJ+XpJXMST8oXeMnsuEJFf76zEC8sFA3nSp+VQrc/+NH78Iu459VGJEWMFQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpRpR3yigX/QX1jg1xJjWezu7g+2fw7Jv5ljDLCK5vBp4BMpij
	qULQwq+rMOwwvUhwYv3tbr/3OE/wRQGdNasm8WmQG0li38YL5azVQZHumU2hBoko6O3EHergEo8
	6A+vW3Q==
X-Google-Smtp-Source: AGHT+IFcB1z7KUVsuS7swIC4I2jvCN0WHziOqZKe6uLi8biGmkCTogAah3rUQYFyuFlbCrcLz4kefzfXt5w=
X-Received: from pjp3.prod.google.com ([2002:a17:90b:55c3:b0:327:dc48:1406])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:50:b0:32e:749d:fcb6
 with SMTP id 98e67ed59e1d1-33097ff646dmr6029665a91.12.1758321197100; Fri, 19
 Sep 2025 15:33:17 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 19 Sep 2025 15:32:15 -0700
In-Reply-To: <20250919223258.1604852-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250919223258.1604852-1-seanjc@google.com>
X-Mailer: git-send-email 2.51.0.470.ga7dc726c21-goog
Message-ID: <20250919223258.1604852-9-seanjc@google.com>
Subject: [PATCH v16 08/51] KVM: x86: Initialize kvm_caps.supported_xss
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Tom Lendacky <thomas.lendacky@amd.com>, Mathias Krause <minipli@grsecurity.net>, 
	John Allen <john.allen@amd.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Chao Gao <chao.gao@intel.com>, Binbin Wu <binbin.wu@linux.intel.com>, 
	Xiaoyao Li <xiaoyao.li@intel.com>, Maxim Levitsky <mlevitsk@redhat.com>, 
	Zhang Yi Z <yi.z.zhang@linux.intel.com>, Xin Li <xin@zytor.com>
Content-Type: text/plain; charset="UTF-8"

From: Yang Weijiang <weijiang.yang@intel.com>

Set original kvm_caps.supported_xss to (host_xss & KVM_SUPPORTED_XSS) if
XSAVES is supported. host_xss contains the host supported xstate feature
bits for thread FPU context switch, KVM_SUPPORTED_XSS includes all KVM
enabled XSS feature bits, the resulting value represents the supervisor
xstates that are available to guest and are backed by host FPU framework
for swapping {guest,host} XSAVE-managed registers/MSRs.

[sean: relocate and enhance comment about PT / XSS[8] ]

Signed-off-by: Yang Weijiang <weijiang.yang@intel.com>
Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
Reviewed-by: Chao Gao <chao.gao@intel.com>
Tested-by: Mathias Krause <minipli@grsecurity.net>
Tested-by: John Allen <john.allen@amd.com>
Tested-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Signed-off-by: Chao Gao <chao.gao@intel.com>
Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/x86.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index c87ed216f72a..3e66d8c5000a 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -217,6 +217,14 @@ static struct kvm_user_return_msrs __percpu *user_return_msrs;
 				| XFEATURE_MASK_BNDCSR | XFEATURE_MASK_AVX512 \
 				| XFEATURE_MASK_PKRU | XFEATURE_MASK_XTILE)
 
+/*
+ * Note, KVM supports exposing PT to the guest, but does not support context
+ * switching PT via XSTATE (KVM's PT virtualization relies on perf; swapping
+ * PT via guest XSTATE would clobber perf state), i.e. KVM doesn't support
+ * IA32_XSS[bit 8] (guests can/must use RDMSR/WRMSR to save/restore PT MSRs).
+ */
+#define KVM_SUPPORTED_XSS     0
+
 bool __read_mostly allow_smaller_maxphyaddr = 0;
 EXPORT_SYMBOL_GPL(allow_smaller_maxphyaddr);
 
@@ -3986,11 +3994,7 @@ int kvm_set_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 	case MSR_IA32_XSS:
 		if (!guest_cpuid_has(vcpu, X86_FEATURE_XSAVES))
 			return KVM_MSR_RET_UNSUPPORTED;
-		/*
-		 * KVM supports exposing PT to the guest, but does not support
-		 * IA32_XSS[bit 8]. Guests have to use RDMSR/WRMSR rather than
-		 * XSAVES/XRSTORS to save/restore PT MSRs.
-		 */
+
 		if (data & ~vcpu->arch.guest_supported_xss)
 			return 1;
 		if (vcpu->arch.ia32_xss == data)
@@ -9822,14 +9826,17 @@ int kvm_x86_vendor_init(struct kvm_x86_init_ops *ops)
 		kvm_host.xcr0 = xgetbv(XCR_XFEATURE_ENABLED_MASK);
 		kvm_caps.supported_xcr0 = kvm_host.xcr0 & KVM_SUPPORTED_XCR0;
 	}
+
+	if (boot_cpu_has(X86_FEATURE_XSAVES)) {
+		rdmsrq(MSR_IA32_XSS, kvm_host.xss);
+		kvm_caps.supported_xss = kvm_host.xss & KVM_SUPPORTED_XSS;
+	}
+
 	kvm_caps.supported_quirks = KVM_X86_VALID_QUIRKS;
 	kvm_caps.inapplicable_quirks = KVM_X86_CONDITIONAL_QUIRKS;
 
 	rdmsrq_safe(MSR_EFER, &kvm_host.efer);
 
-	if (boot_cpu_has(X86_FEATURE_XSAVES))
-		rdmsrq(MSR_IA32_XSS, kvm_host.xss);
-
 	kvm_init_pmu_capability(ops->pmu_ops);
 
 	if (boot_cpu_has(X86_FEATURE_ARCH_CAPABILITIES))
-- 
2.51.0.470.ga7dc726c21-goog


