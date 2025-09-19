Return-Path: <linux-kernel+bounces-825288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A557B8B7F9
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 00:38:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AA2FA01F20
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 22:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 985312ECD39;
	Fri, 19 Sep 2025 22:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gjNZ85FR"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E7202EB866
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 22:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758321218; cv=none; b=G7r0uRvuIUaH0eLYAqXeQhQMVgbcE/k+MoXN4kc0ecnT8+uc+lAwz4A4CpW4MvsL8GXA/APQQYvpLO904boc073+plcsE8pqeKnkyDhrPfTgVwmHmTXFnDrs6fNfacFiXzVkZqIGw2Wj0n8A/jodXZDNqOBs5YEtbiIVHezEzZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758321218; c=relaxed/simple;
	bh=Q70/k7kT3C/xIAA2GvN8tKo5xDe3waYj/eHHxlJ71QE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=aTqrUHVldOX0UEFT52kALn4fF8mTPTLNnrK0R/PRHX2FzslVFLEeZIBiupOj3B7EV4p0GkGxoM0qt7+Oey72T0z9KRmBeCuIWATyhzarGLnFJ6RoXY3m+Hh8W1Eqq1VvSmpxDVYSDnz/QPR6BIdrs7xMkjvAo1Oiw6EWlxbvYi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gjNZ85FR; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2445806b18aso30840475ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 15:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758321216; x=1758926016; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=AtRSpHI34hOTr14h2nQSWbxYtSYTs8P2X4VzmIFoGGY=;
        b=gjNZ85FRJFJfrKtZ7gHqJpWSzn1oIhKHWOyowPLv/xHxFgIXCeOOL7FiuZCx7ut50P
         W1VAa3ewiOYfFQuDA51Lj2wYeA6TjnvRR7pvhk94jS7ocPL1mX95PB02kod9BkJEhUlA
         N3MRzjKQuwswx1TVRDqgoFaiE2xA5L9TxfmT0Lr+lHKq/j00CARK8B1joJXcyJZQQ2JE
         P2FqPPUGbJ+ajU6KxWNC6zU9RZm7xOotu3zPmm3K8gRycovfe7ZaLohC35r7F503nHbb
         VpvGqfmO7uSiwSsYYaObVQ4BbH5FlEnXe5T3Flzw5tcSMtv+PUiZMjdgnbSKplW2ciiA
         AaDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758321216; x=1758926016;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AtRSpHI34hOTr14h2nQSWbxYtSYTs8P2X4VzmIFoGGY=;
        b=je2ZbaOqH1CsJdDIU4lWHNIIdgwB8SoOs1Z98xqUKnQkH3NOrQngL2qrfj99Qf0pGW
         ZMeaigzmTtU2AiDVwAGFXKSZgRe08HlYaH2a2QSZl8tIfvvLdqsgpmXMWn/iwOJcWIjz
         +o4KNIgPcigleHe/J0L2gGSJiy/WLe/VGouGCiV1lEJqaFAPPH5vZNeHbSGVcUghkl89
         XuFeXBCdMYZcra5RZSe+XsAikoXx2CNAU7JamZrLhGIuTzCQnFHy4Niyx4E6vPvGALxs
         51U6/stlfMGAyIkY/8Scp6iWo6ekaKyfXM+2OfOZNiQLOL8ZzXHEQCYRfJ1334xsnGY+
         Lzeg==
X-Forwarded-Encrypted: i=1; AJvYcCV9P3wE4AFFbwg+SNjQdGchWwgX0Ikow+4fJt0ELQC1JvJKz2uU1+UFdETY/jXb9vwGhUp5WzblafpwMoA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiwzoH4j33QseDTqvoly600lphatdiQd8CHI7HX/9THpJ7Bufs
	6ZV9+ZBIutVWkDagBwdLVs11mPSUu89EfNiVcsYVQzmWKIDCfP8afOsx2wpMQxYcyPVWI5xTD2B
	yA+rcbQ==
X-Google-Smtp-Source: AGHT+IFXLtgMEwJfJvCkz3ezqcjpkSQU3hEfExnTcdinaUlwRHSERdOcM8Vkmlk4Ob3hgkUERHIIWXSRSy0=
X-Received: from pjbqx3.prod.google.com ([2002:a17:90b:3e43:b0:330:793a:2e77])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5585:b0:330:84dc:d129
 with SMTP id 98e67ed59e1d1-33098387b2bmr5494044a91.36.1758321216510; Fri, 19
 Sep 2025 15:33:36 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 19 Sep 2025 15:32:24 -0700
In-Reply-To: <20250919223258.1604852-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250919223258.1604852-1-seanjc@google.com>
X-Mailer: git-send-email 2.51.0.470.ga7dc726c21-goog
Message-ID: <20250919223258.1604852-18-seanjc@google.com>
Subject: [PATCH v16 17/51] KVM: VMX: Set host constant supervisor states to
 VMCS fields
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

Save constant values to HOST_{S_CET,SSP,INTR_SSP_TABLE} field explicitly.
Kernel IBT is supported and the setting in MSR_IA32_S_CET is static after
post-boot(The exception is BIOS call case but vCPU thread never across it)
and KVM doesn't need to refresh HOST_S_CET field before every VM-Enter/
VM-Exit sequence.

Host supervisor shadow stack is not enabled now and SSP is not accessible
to kernel mode, thus it's safe to set host IA32_INT_SSP_TAB/SSP VMCS field
to 0s. When shadow stack is enabled for CPL3, SSP is reloaded from PL3_SSP
before it exits to userspace. Check SDM Vol 2A/B Chapter 3/4 for SYSCALL/
SYSRET/SYSENTER SYSEXIT/RDSSP/CALL etc.

Prevent KVM module loading if host supervisor shadow stack SHSTK_EN is set
in MSR_IA32_S_CET as KVM cannot co-exit with it correctly.

Suggested-by: Sean Christopherson <seanjc@google.com>
Suggested-by: Chao Gao <chao.gao@intel.com>
Signed-off-by: Yang Weijiang <weijiang.yang@intel.com>
Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
Reviewed-by: Chao Gao <chao.gao@intel.com>
Tested-by: Mathias Krause <minipli@grsecurity.net>
Tested-by: John Allen <john.allen@amd.com>
Tested-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Chao Gao <chao.gao@intel.com>
[sean: snapshot host S_CET if SHSTK *or* IBT is supported]
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/capabilities.h |  4 ++++
 arch/x86/kvm/vmx/vmx.c          | 15 +++++++++++++++
 arch/x86/kvm/x86.c              | 12 ++++++++++++
 arch/x86/kvm/x86.h              |  1 +
 4 files changed, 32 insertions(+)

diff --git a/arch/x86/kvm/vmx/capabilities.h b/arch/x86/kvm/vmx/capabilities.h
index f614428dbeda..59c83888bdc0 100644
--- a/arch/x86/kvm/vmx/capabilities.h
+++ b/arch/x86/kvm/vmx/capabilities.h
@@ -100,6 +100,10 @@ static inline bool cpu_has_load_perf_global_ctrl(void)
 	return vmcs_config.vmentry_ctrl & VM_ENTRY_LOAD_IA32_PERF_GLOBAL_CTRL;
 }
 
+static inline bool cpu_has_load_cet_ctrl(void)
+{
+	return (vmcs_config.vmentry_ctrl & VM_ENTRY_LOAD_CET_STATE);
+}
 static inline bool cpu_has_vmx_mpx(void)
 {
 	return vmcs_config.vmentry_ctrl & VM_ENTRY_LOAD_BNDCFGS;
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 5fe4a4b8efb1..a7d9e60b2771 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -4325,6 +4325,21 @@ void vmx_set_constant_host_state(struct vcpu_vmx *vmx)
 
 	if (cpu_has_load_ia32_efer())
 		vmcs_write64(HOST_IA32_EFER, kvm_host.efer);
+
+	/*
+	 * Supervisor shadow stack is not enabled on host side, i.e.,
+	 * host IA32_S_CET.SHSTK_EN bit is guaranteed to 0 now, per SDM
+	 * description(RDSSP instruction), SSP is not readable in CPL0,
+	 * so resetting the two registers to 0s at VM-Exit does no harm
+	 * to kernel execution. When execution flow exits to userspace,
+	 * SSP is reloaded from IA32_PL3_SSP. Check SDM Vol.2A/B Chapter
+	 * 3 and 4 for details.
+	 */
+	if (cpu_has_load_cet_ctrl()) {
+		vmcs_writel(HOST_S_CET, kvm_host.s_cet);
+		vmcs_writel(HOST_SSP, 0);
+		vmcs_writel(HOST_INTR_SSP_TABLE, 0);
+	}
 }
 
 void set_cr4_guest_host_mask(struct vcpu_vmx *vmx)
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index fee90388a861..d2cccc7594d4 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -9997,6 +9997,18 @@ int kvm_x86_vendor_init(struct kvm_x86_init_ops *ops)
 		return -EIO;
 	}
 
+	if (boot_cpu_has(X86_FEATURE_SHSTK) || boot_cpu_has(X86_FEATURE_IBT)) {
+		rdmsrq(MSR_IA32_S_CET, kvm_host.s_cet);
+		/*
+		 * Linux doesn't yet support supervisor shadow stacks (SSS), so
+		 * KVM doesn't save/restore the associated MSRs, i.e. KVM may
+		 * clobber the host values.  Yell and refuse to load if SSS is
+		 * unexpectedly enabled, e.g. to avoid crashing the host.
+		 */
+		if (WARN_ON_ONCE(kvm_host.s_cet & CET_SHSTK_EN))
+			return -EIO;
+	}
+
 	memset(&kvm_caps, 0, sizeof(kvm_caps));
 
 	x86_emulator_cache = kvm_alloc_emulator_cache();
diff --git a/arch/x86/kvm/x86.h b/arch/x86/kvm/x86.h
index 076eccba0f7e..65cbd454c4f1 100644
--- a/arch/x86/kvm/x86.h
+++ b/arch/x86/kvm/x86.h
@@ -50,6 +50,7 @@ struct kvm_host_values {
 	u64 efer;
 	u64 xcr0;
 	u64 xss;
+	u64 s_cet;
 	u64 arch_capabilities;
 };
 
-- 
2.51.0.470.ga7dc726c21-goog


