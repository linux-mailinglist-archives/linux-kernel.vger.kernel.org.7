Return-Path: <linux-kernel+bounces-814887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 52D2FB55A1D
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 01:28:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1656817DB58
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 23:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 277B928643F;
	Fri, 12 Sep 2025 23:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="a/mfwBDh"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF7E2D73B8
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 23:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757719436; cv=none; b=BPkIPOXulzidvuVlx1vcxeHvD2uS5hpsPE+CtTZXqaI/BuBT5lzlSVGQgiu7r3EWrdGElxQZ67TTdnty9E05o0//zX8CILq/tFt6S4lILLwW8NfHGMI7xgMP3nH4t1pCs0T9OYUHItPsLxtToSe/D5mah8MwUVD3cQMHaDDGg+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757719436; c=relaxed/simple;
	bh=tG3ovMwAMHbfeh5vSjhWEPZM8u9oO+88uWP+MXoRHk0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qJ2toA6H73zGVaKZMr8pATtC/I2+r7HzxPFMS5lZHJiB7LSxnjWyKRGzOOpqnoq+Q5bxaBP8H+2rlj6Q4BbRAPMmkm4/8hRmK7PKuX2BNsuDTwvY8JZPjKwNiYlz1o2BO4BpDYCbWzEAZhHbNtKtWuiRrV0+GwV+CoooDk+gJkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=a/mfwBDh; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-24458274406so43758165ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 16:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757719433; x=1758324233; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=l+XAFKOcKNHNNNkiV3oGUHueNV9uJIbVnDYwxKtJwHg=;
        b=a/mfwBDhct2C0hSUky4cLJAOkgieuUEf0E4fYMtGe3HdxQOK8qTQo32+rFviNRFhAl
         OGkJ141bQT4JUli4jkDb6bNo/gzr77Esg19yxZewDzp4PxTPGxZ7LwfBNRAOaOFsr383
         1O8/NbyBVuXsZ7JmzrOF5BdStSxLKP4JLHMpa+KZbl/1+VycHgNKkOrp/K+msPTAaCc/
         o8Q3zTdUjmLAcvPBmMia0V7RHM7JuupWBvdsnSW3GeWHuhr50tw5Nrur1ic08wZhJA4s
         ksN1eF76pevU2xEd+7vkSKbOK47Xruw2eBoN5vPs/uZMIw9eHebmY6yPSxgnOcb62x1e
         SPmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757719433; x=1758324233;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l+XAFKOcKNHNNNkiV3oGUHueNV9uJIbVnDYwxKtJwHg=;
        b=qMo0HDDaC8hnW5fs/0munWrogR/Kgte7Ehr7yYNVU3rzV1/xpCaJM7mZr92JWi2Y7F
         UbpbqMD8EVIXn9SWVWmoZp3BVWWdBilD4NjTE+AwjEJmSBh2Auci62oXrmJsyNEAhXSm
         oht4aoXTAhnsVv6de4rGvyJiapZHSAwKTb+ebfNLV4p72GaYEOjrijRMRvR5+dI78fnD
         SY9Il/+D1PlQX/chDitZ4Uz8WY1g5ZwfMRpTBdCvpfQ8nfSb4vo/3Kx+a9TZS2PLr6wf
         Th485PdW6u07Aasqx+y+8lqTW6D0bQ6s1xKBE0yLxDlvm6vXnP3F6mRFKXSWx7paSfby
         9oXQ==
X-Forwarded-Encrypted: i=1; AJvYcCVAq7Hj2Zrx2PY/qH4CMC+jIHfPxQYpl9nFGCfDwqxDxRojEW+sbdqCjDghfcE5Ig1xW+xJZyD4oQDGHLo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyh8lPjDzTBnyzMU6TmUxxCSmhD5LWe0m9IIZARBYusQzeB6lSO
	e1ukbF4t2aOW8FfcLfKgxOfy+oNZrzNQj4v/GXD0sXSD6wy7G7fC+OmkIsbQY6673xUeplTZP11
	FbuV9mw==
X-Google-Smtp-Source: AGHT+IHAP92S8i+ghTT8MEtIwBOjslwrWY+WhIQ0oS3JzmmNNOIpAnQkBypJ1PCU0TwOkGVo/klbGRc7Ao8=
X-Received: from pjbee16.prod.google.com ([2002:a17:90a:fc50:b0:321:c441:a0a])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:c410:b0:246:24d:2394
 with SMTP id d9443c01a7336-25d2528bf9fmr44876615ad.8.1757719433341; Fri, 12
 Sep 2025 16:23:53 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 12 Sep 2025 16:22:54 -0700
In-Reply-To: <20250912232319.429659-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250912232319.429659-1-seanjc@google.com>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250912232319.429659-17-seanjc@google.com>
Subject: [PATCH v15 16/41] KVM: VMX: Set up interception for CET MSRs
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Tom Lendacky <thomas.lendacky@amd.com>, Mathias Krause <minipli@grsecurity.net>, 
	John Allen <john.allen@amd.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Chao Gao <chao.gao@intel.com>, Maxim Levitsky <mlevitsk@redhat.com>, 
	Xiaoyao Li <xiaoyao.li@intel.com>, Zhang Yi Z <yi.z.zhang@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"

From: Yang Weijiang <weijiang.yang@intel.com>

Enable/disable CET MSRs interception per associated feature configuration.

Pass through CET MSRs that are managed by XSAVE, as they cannot be
intercepted without also intercepting XSAVE. However, intercepting XSAVE
would likely cause unacceptable performance overhead.
MSR_IA32_INT_SSP_TAB is not managed by XSAVE, so it is intercepted.

Note, this MSR design introduced an architectural limitation of SHSTK and
IBT control for guest, i.e., when SHSTK is exposed, IBT is also available
to guest from architectural perspective since IBT relies on subset of SHSTK
relevant MSRs.

Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Yang Weijiang <weijiang.yang@intel.com>
Tested-by: Mathias Krause <minipli@grsecurity.net>
Tested-by: John Allen <john.allen@amd.com>
Tested-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Chao Gao <chao.gao@intel.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/vmx.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 4fc1dbba2eb0..adf5af30e537 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -4101,6 +4101,8 @@ void pt_update_intercept_for_msr(struct kvm_vcpu *vcpu)
 
 void vmx_recalc_msr_intercepts(struct kvm_vcpu *vcpu)
 {
+	bool intercept;
+
 	if (!cpu_has_vmx_msr_bitmap())
 		return;
 
@@ -4146,6 +4148,23 @@ void vmx_recalc_msr_intercepts(struct kvm_vcpu *vcpu)
 		vmx_set_intercept_for_msr(vcpu, MSR_IA32_FLUSH_CMD, MSR_TYPE_W,
 					  !guest_cpu_cap_has(vcpu, X86_FEATURE_FLUSH_L1D));
 
+	if (kvm_cpu_cap_has(X86_FEATURE_SHSTK)) {
+		intercept = !guest_cpu_cap_has(vcpu, X86_FEATURE_SHSTK);
+
+		vmx_set_intercept_for_msr(vcpu, MSR_IA32_PL0_SSP, MSR_TYPE_RW, intercept);
+		vmx_set_intercept_for_msr(vcpu, MSR_IA32_PL1_SSP, MSR_TYPE_RW, intercept);
+		vmx_set_intercept_for_msr(vcpu, MSR_IA32_PL2_SSP, MSR_TYPE_RW, intercept);
+		vmx_set_intercept_for_msr(vcpu, MSR_IA32_PL3_SSP, MSR_TYPE_RW, intercept);
+	}
+
+	if (kvm_cpu_cap_has(X86_FEATURE_SHSTK) || kvm_cpu_cap_has(X86_FEATURE_IBT)) {
+		intercept = !guest_cpu_cap_has(vcpu, X86_FEATURE_IBT) &&
+			    !guest_cpu_cap_has(vcpu, X86_FEATURE_SHSTK);
+
+		vmx_set_intercept_for_msr(vcpu, MSR_IA32_U_CET, MSR_TYPE_RW, intercept);
+		vmx_set_intercept_for_msr(vcpu, MSR_IA32_S_CET, MSR_TYPE_RW, intercept);
+	}
+
 	/*
 	 * x2APIC and LBR MSR intercepts are modified on-demand and cannot be
 	 * filtered by userspace.
-- 
2.51.0.384.g4c02a37b29-goog


