Return-Path: <linux-kernel+bounces-756947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A068B1BB63
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 22:24:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B443618A78BE
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 20:24:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16C6E29B233;
	Tue,  5 Aug 2025 20:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M2GxXJ5B"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F198F29B775
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 20:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754425361; cv=none; b=ceNx/XdeR8RYFUsbRf2NjsagZIULTo/iNYgDzEcAhkeRLyY76p80SRsz/jnx27CMeFBjvzzRgLONfkV0P3YNpcs8SKs8LS6OvFwa+YqacTEvXwvHU+h4AQ0XELMeQcGs+bqTeSgr6tIboun8pCEHLcBrFdtVu+4f4F7+0S1DnnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754425361; c=relaxed/simple;
	bh=/74tP/uL8VD1igiEhMrK02lCdVn9JNfbzbe9m1VzDeE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HL7J/dXhw/2vtVWgiWrQeRAKPKNAbZlcKRX7zSdRcqt/LGyd0R52SBNHgy+o/sFF7uI4Vf46qwnCnKyv8w4Bzr4GRG90giaGIf1zGQbFSNPqINMFUG7kxj0QEa0xp8Ljxhw24/0QJd2g3KAAAb5AQMhHmGLkWfDvXYo2VyuCmng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=M2GxXJ5B; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b42218e4a59so3996560a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 13:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754425359; x=1755030159; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=1f+f9oC1bVjCd62ipVbDNWs3Q33jM/p7vFWYLjp/MqM=;
        b=M2GxXJ5Bgk3HSyR9FnJ4qJyry6N57mFGMFH4T+oAPL/m97oS88kqB0XC4ENo4DEtNg
         Ht0E8P5Aer7acJ0DwDRaVaKI7M+3Z4+akgsR6uqw3Qe4pPtALS/VZ4c458DmYx6LeLe3
         QHi50Om5W6Xt0zmIDH4Vdilz7DeR6DzhJidDD8R3gzMHi2p91cRPXJcIf/GA4RYaYlZD
         2RhROFJ85sEhvGRN9FCgDiGzZg7XTbrC+ZNiVXIXO8kMn15ApgkhutobA08WYoRJevPC
         iILhtEQJCypodI/kdDm+xy5Ws6JlcYFklrCmM8PuraLD+LolaHx7u70utMRk1nAEHuQO
         U75w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754425359; x=1755030159;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1f+f9oC1bVjCd62ipVbDNWs3Q33jM/p7vFWYLjp/MqM=;
        b=uq9nZ1/hDTWId6/HoBNWRn8Qog92n0whe+1XzsqRuPDVB2pd6sMlyg+VlbL2h4iov5
         jtLl4DiWGIAR3t+1/cvPHuXxAonN1WD1XZplhgY/ML7HlQgL2Qgl2YJkbOSAGbiSQVz2
         0Jbmyo2SSeThaDj7PyRGh/evnM8aCb/TQXIEXXYEyiH5S+sK39mWUo25YPuW+QFtU7p2
         Addyk4KDXkzvQiEJbVAmu4M+oIg5If/OOB5C67Hgt8NF19QD+MT3TB+r3eQVturetuX9
         YXmNaH0oJA+40ZcPlDlNCA9OpIZ+t+c27paHO+j1ckGwDP376g+g1axlCQocTJwiO+go
         a0sA==
X-Forwarded-Encrypted: i=1; AJvYcCWG4Ac7MBwIMZjgtOaWVfyo6BckfrKPn+XfLpKvyMI3yT1O0JrX2OSRDj6yP5P2NnPfw+qDDrfS3RuLR7Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5TzLlEfgNWFUwC9D8pXmv7fa4Am0Wpgc6qsIQkGTBVnAzyhx/
	Zvta4Qsog3gvmufVOcQlgEn2ZcQo4oawlqk2Bkds41DOTgjCTsdiHzeC3veHEUwPHoKk9+S3hII
	vcL28ZQ==
X-Google-Smtp-Source: AGHT+IGSm11toOjPwvtC633w4IWObqyBZzDlcAWaJmjXYtr4+m7SO4dsAZJxrRV/oUi4bYeNSpO/Jtzrkyw=
X-Received: from pjbkl16.prod.google.com ([2002:a17:90b:4990:b0:311:c20d:676d])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4ac1:b0:31e:cb27:9de4
 with SMTP id 98e67ed59e1d1-32166cb2fb2mr191994a91.24.1754425359238; Tue, 05
 Aug 2025 13:22:39 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue,  5 Aug 2025 13:22:24 -0700
In-Reply-To: <20250805202224.1475590-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250805202224.1475590-1-seanjc@google.com>
X-Mailer: git-send-email 2.50.1.565.gc32cd1483b-goog
Message-ID: <20250805202224.1475590-7-seanjc@google.com>
Subject: [PATCH v3 6/6] KVM: x86: Advertise support for the immediate form of
 MSR instructions
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Borislav Petkov <bp@alien8.de>, Xin Li <xin@zytor.com>
Content-Type: text/plain; charset="UTF-8"

From: Xin Li <xin@zytor.com>

Advertise support for the immediate form of MSR instructions to userspace
if the instructions are supported by the underlying CPU, and KVM is using
VMX, i.e. is running on an Intel-compatible CPU.

For SVM, explicitly clear X86_FEATURE_MSR_IMM to ensure KVM doesn't over-
report support if AMD-compatible CPUs ever implement the immediate forms,
as SVM will likely require explicit enablement in KVM.

Signed-off-by: Xin Li (Intel) <xin@zytor.com>
[sean: massage changelog]
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/kvm_host.h | 1 +
 arch/x86/kvm/cpuid.c            | 6 +++++-
 arch/x86/kvm/reverse_cpuid.h    | 5 +++++
 arch/x86/kvm/svm/svm.c          | 6 +++++-
 4 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index dbdec6025fde..735b5d1e62dd 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -774,6 +774,7 @@ enum kvm_only_cpuid_leafs {
 	CPUID_7_2_EDX,
 	CPUID_24_0_EBX,
 	CPUID_8000_0021_ECX,
+	CPUID_7_1_ECX,
 	NR_KVM_CPU_CAPS,
 
 	NKVMCAPINTS = NR_KVM_CPU_CAPS - NCAPINTS,
diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index e2836a255b16..eaaa9203d4d9 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -985,6 +985,10 @@ void kvm_set_cpu_caps(void)
 		F(LAM),
 	);
 
+	kvm_cpu_cap_init(CPUID_7_1_ECX,
+		SCATTERED_F(MSR_IMM),
+	);
+
 	kvm_cpu_cap_init(CPUID_7_1_EDX,
 		F(AVX_VNNI_INT8),
 		F(AVX_NE_CONVERT),
@@ -1411,9 +1415,9 @@ static inline int __do_cpuid_func(struct kvm_cpuid_array *array, u32 function)
 				goto out;
 
 			cpuid_entry_override(entry, CPUID_7_1_EAX);
+			cpuid_entry_override(entry, CPUID_7_1_ECX);
 			cpuid_entry_override(entry, CPUID_7_1_EDX);
 			entry->ebx = 0;
-			entry->ecx = 0;
 		}
 		if (max_idx >= 2) {
 			entry = do_host_cpuid(array, function, 2);
diff --git a/arch/x86/kvm/reverse_cpuid.h b/arch/x86/kvm/reverse_cpuid.h
index c53b92379e6e..743ab25ba787 100644
--- a/arch/x86/kvm/reverse_cpuid.h
+++ b/arch/x86/kvm/reverse_cpuid.h
@@ -25,6 +25,9 @@
 #define KVM_X86_FEATURE_SGX2		KVM_X86_FEATURE(CPUID_12_EAX, 1)
 #define KVM_X86_FEATURE_SGX_EDECCSSA	KVM_X86_FEATURE(CPUID_12_EAX, 11)
 
+/* Intel-defined sub-features, CPUID level 0x00000007:1 (ECX) */
+#define KVM_X86_FEATURE_MSR_IMM		KVM_X86_FEATURE(CPUID_7_1_ECX, 5)
+
 /* Intel-defined sub-features, CPUID level 0x00000007:1 (EDX) */
 #define X86_FEATURE_AVX_VNNI_INT8       KVM_X86_FEATURE(CPUID_7_1_EDX, 4)
 #define X86_FEATURE_AVX_NE_CONVERT      KVM_X86_FEATURE(CPUID_7_1_EDX, 5)
@@ -87,6 +90,7 @@ static const struct cpuid_reg reverse_cpuid[] = {
 	[CPUID_7_2_EDX]       = {         7, 2, CPUID_EDX},
 	[CPUID_24_0_EBX]      = {      0x24, 0, CPUID_EBX},
 	[CPUID_8000_0021_ECX] = {0x80000021, 0, CPUID_ECX},
+	[CPUID_7_1_ECX]       = {         7, 1, CPUID_ECX},
 };
 
 /*
@@ -128,6 +132,7 @@ static __always_inline u32 __feature_translate(int x86_feature)
 	KVM_X86_TRANSLATE_FEATURE(BHI_CTRL);
 	KVM_X86_TRANSLATE_FEATURE(TSA_SQ_NO);
 	KVM_X86_TRANSLATE_FEATURE(TSA_L1_NO);
+	KVM_X86_TRANSLATE_FEATURE(MSR_IMM);
 	default:
 		return x86_feature;
 	}
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index ca550c4fa174..7e7821ee8ee1 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -5311,8 +5311,12 @@ static __init void svm_set_cpu_caps(void)
 	/* CPUID 0x8000001F (SME/SEV features) */
 	sev_set_cpu_caps();
 
-	/* Don't advertise Bus Lock Detect to guest if SVM support is absent */
+	/*
+	 * Clear capabilities that are automatically configured by common code,
+	 * but that require explicit SVM support (that isn't yet implemented).
+	 */
 	kvm_cpu_cap_clear(X86_FEATURE_BUS_LOCK_DETECT);
+	kvm_cpu_cap_clear(X86_FEATURE_MSR_IMM);
 }
 
 static __init int svm_hardware_setup(void)
-- 
2.50.1.565.gc32cd1483b-goog


