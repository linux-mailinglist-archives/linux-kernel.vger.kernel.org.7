Return-Path: <linux-kernel+bounces-825320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30EE4B8B8C6
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 00:47:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBCE0A80DC3
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 22:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32379328596;
	Fri, 19 Sep 2025 22:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YLCqfCok"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DCDD327A33
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 22:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758321274; cv=none; b=hSlvBCjnK39LTdeqI5nCoPINcD817CE3pjGvJQ8Gp64w+mhl3xybHxrAbE5i/Gy220A28D+UCFnvOtlG60FD+p0bGYio95t2woyL1ogC6hUBm0UOUs3pF4a4Il119vfkJLEHNGGWmun+iJMn1KXkVz/8ueJfmRocit2u2jbaUTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758321274; c=relaxed/simple;
	bh=zXUCflLvKluP1zF9WIp817wuaYNkbYuD/HRi92+09So=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BRru4G1d7ABwmpR0t8liwOrJZW1dg/dkfkHq+O0B8GJrKNgp62jOCNuwrb2P0As0TLBwS646zEhFLxDfiZempvArJyEuWW8sNemI6yeB1BdWJhIOroGFKnoAHVxh2LgDgB8+lqS1Y9YRyCAQ1/WAk4PRc7EmLMM3Z8Otx2aykQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YLCqfCok; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-77e7d9ed351so1045544b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 15:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758321272; x=1758926072; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=H3KhwAXGCg9rKxJxoAW+12RZeBY1x3h4wsMtr8e6qdQ=;
        b=YLCqfCok5zDiQV/BiJ8hTCZutyAlmBaybg5aq5HZT12B1fqW80wyzaLt9/kCsnfvTA
         wD/ypFNkMHBN36FJWLMypX0xiqWGI84cG4Nvi0DqvMu+HvorkKsbSX/rKpGmrT4NuPRR
         0UgtPqDHhpmsH4/6ZcfehTUAysUm4SHP4KNMTt2fTXtaBs4No3uYGjIXRj2AhMGJYGXO
         wCisQjWnFvkOGRFSVSNcqWRk+1AwtSyN5qFVvMp9SdErKG9Jdkc7PT8OzaX6I1t4pNL6
         p3AlnNvza8QTZOOxFl5X5ZvuAMJAQbXSRigS7Krkj2x83nEVrOscjBb1eYxg+WI/2vbQ
         Ak9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758321272; x=1758926072;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H3KhwAXGCg9rKxJxoAW+12RZeBY1x3h4wsMtr8e6qdQ=;
        b=ERNvIRm+UNhd2ji+vVUieL/z/JoJWht8PdFCSC7me/x0yRy7minhT8+YunuD2t/706
         0Zj/L7z3zkaB3xCkkqwPyc4jWPW/+2EGfSvQSqYI1FRH1RoK+sdYWQORKucGLLRja6S5
         jDgnDl/3AN72a+N+cSuD3JMf6I0KXsJJbGKojznZvT2LqhsJNyehm7wImq96ZZAB41rz
         5U0gw2HIVzusMtMnTl8+S+Bp/bxjRwsmWGKhnqvBtwX6p8dZPxhXULvVJPZSrTGRYqXj
         ikFOws2AvTaTW+msFUw6WK2Kh12YhcDrDOlF5NzmW0XPm7Okojqsx9GRK8dAylYeMskG
         oAdw==
X-Forwarded-Encrypted: i=1; AJvYcCV9h5H0kP0VXvNpRBjb6LMO/NTGhwqRL1skamp5fXIwBApO5/SvyQiFyWHZrw8p/AFmNyuaGMMnCk447KE=@vger.kernel.org
X-Gm-Message-State: AOJu0YweaWkxJGKytNN4Gy3RDovrf7KS+ATM7eJoX5AvLFdYyLKStre0
	QAZujspBxV+A6WeaXOJHgZiMIFbpbfDSPBvIOohwKVnPqh+PjksP2A/raMKQxhaB3Jnzl8v2dF4
	a6Ew9gQ==
X-Google-Smtp-Source: AGHT+IHohAotE94JIjhFtq/fDdBAuAd0XmX8bdDaDDk/cKRcWFEXbXoMj3aSKmcC+wF2XVwlXIo7arLeWJI=
X-Received: from pjbmf16.prod.google.com ([2002:a17:90b:1850:b0:32b:95bb:dbc])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:4323:b0:262:4378:9dfb
 with SMTP id adf61e73a8af0-292588a2fa7mr7007753637.7.1758321271830; Fri, 19
 Sep 2025 15:34:31 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 19 Sep 2025 15:32:56 -0700
In-Reply-To: <20250919223258.1604852-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250919223258.1604852-1-seanjc@google.com>
X-Mailer: git-send-email 2.51.0.470.ga7dc726c21-goog
Message-ID: <20250919223258.1604852-50-seanjc@google.com>
Subject: [PATCH v16 49/51] KVM: selftests: Add coverate for KVM-defined
 registers in MSRs test
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Tom Lendacky <thomas.lendacky@amd.com>, Mathias Krause <minipli@grsecurity.net>, 
	John Allen <john.allen@amd.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Chao Gao <chao.gao@intel.com>, Binbin Wu <binbin.wu@linux.intel.com>, 
	Xiaoyao Li <xiaoyao.li@intel.com>, Maxim Levitsky <mlevitsk@redhat.com>, 
	Zhang Yi Z <yi.z.zhang@linux.intel.com>, Xin Li <xin@zytor.com>
Content-Type: text/plain; charset="UTF-8"

Add test coverage for the KVM-defined GUEST_SSP "register" in the MSRs
test.  While _KVM's_ goal is to not tie the uAPI of KVM-defined registers
to any particular internal implementation, i.e. to not commit in uAPI to
handling GUEST_SSP as an MSR, treating GUEST_SSP as an MSR for testing
purposes is a-ok and is a naturally fit given the semantics of SSP.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/x86/msrs_test.c | 97 ++++++++++++++++++++-
 1 file changed, 94 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86/msrs_test.c b/tools/testing/selftests/kvm/x86/msrs_test.c
index 2dc4017072c6..7c6d846e42dd 100644
--- a/tools/testing/selftests/kvm/x86/msrs_test.c
+++ b/tools/testing/selftests/kvm/x86/msrs_test.c
@@ -17,9 +17,10 @@ struct kvm_msr {
 	const u64 write_val;
 	const u64 rsvd_val;
 	const u32 index;
+	const bool is_kvm_defined;
 };
 
-#define ____MSR_TEST(msr, str, val, rsvd, reset, feat, f2)		\
+#define ____MSR_TEST(msr, str, val, rsvd, reset, feat, f2, is_kvm)	\
 {									\
 	.index = msr,							\
 	.name = str,							\
@@ -28,10 +29,11 @@ struct kvm_msr {
 	.reset_val = reset,						\
 	.feature = X86_FEATURE_ ##feat,					\
 	.feature2 = X86_FEATURE_ ##f2,					\
+	.is_kvm_defined = is_kvm,					\
 }
 
 #define __MSR_TEST(msr, str, val, rsvd, reset, feat)			\
-	____MSR_TEST(msr, str, val, rsvd, reset, feat, feat)
+	____MSR_TEST(msr, str, val, rsvd, reset, feat, feat, false)
 
 #define MSR_TEST_NON_ZERO(msr, val, rsvd, reset, feat)			\
 	__MSR_TEST(msr, #msr, val, rsvd, reset, feat)
@@ -40,7 +42,7 @@ struct kvm_msr {
 	__MSR_TEST(msr, #msr, val, rsvd, 0, feat)
 
 #define MSR_TEST2(msr, val, rsvd, feat, f2)				\
-	____MSR_TEST(msr, #msr, val, rsvd, 0, feat, f2)
+	____MSR_TEST(msr, #msr, val, rsvd, 0, feat, f2, false)
 
 /*
  * Note, use a page aligned value for the canonical value so that the value
@@ -51,6 +53,9 @@ static const u64 canonical_val = 0x123456789000ull;
 #define MSR_TEST_CANONICAL(msr, feat)					\
 	__MSR_TEST(msr, #msr, canonical_val, NONCANONICAL, 0, feat)
 
+#define MSR_TEST_KVM(msr, val, rsvd, feat)				\
+	____MSR_TEST(KVM_REG_ ##msr, #msr, val, rsvd, 0, feat, feat, true)
+
 /*
  * The main struct must be scoped to a function due to the use of structures to
  * define features.  For the global structure, allocate enough space for the
@@ -196,6 +201,83 @@ static void guest_main(void)
 static bool has_one_reg;
 static bool use_one_reg;
 
+#define KVM_X86_MAX_NR_REGS	1
+
+static bool vcpu_has_reg(struct kvm_vcpu *vcpu, u64 reg)
+{
+	struct {
+		struct kvm_reg_list list;
+		u64 regs[KVM_X86_MAX_NR_REGS];
+	} regs = {};
+	int r, i;
+
+	/*
+	 * If KVM_GET_REG_LIST succeeds with n=0, i.e. there are no supported
+	 * regs, then the vCPU obviously doesn't support the reg.
+	 */
+	r = __vcpu_ioctl(vcpu, KVM_GET_REG_LIST, &regs.list.n);
+	if (!r)
+		return false;
+
+	TEST_ASSERT_EQ(errno, E2BIG);
+
+	/*
+	 * KVM x86 is expected to support enumerating a relative small number
+	 * of regs.  The majority of registers supported by KVM_{G,S}ET_ONE_REG
+	 * are enumerated via other ioctls, e.g. KVM_GET_MSR_INDEX_LIST.  For
+	 * simplicity, hardcode the maximum number of regs and manually update
+	 * the test as necessary.
+	 */
+	TEST_ASSERT(regs.list.n <= KVM_X86_MAX_NR_REGS,
+		    "KVM reports %llu regs, test expects at most %u regs, stale test?",
+		    regs.list.n, KVM_X86_MAX_NR_REGS);
+
+	vcpu_ioctl(vcpu, KVM_GET_REG_LIST, &regs.list.n);
+	for (i = 0; i < regs.list.n; i++) {
+		if (regs.regs[i] == reg)
+			return true;
+	}
+
+	return false;
+}
+
+static void host_test_kvm_reg(struct kvm_vcpu *vcpu)
+{
+	bool has_reg = vcpu_cpuid_has(vcpu, msrs[idx].feature);
+	u64 reset_val = msrs[idx].reset_val;
+	u64 write_val = msrs[idx].write_val;
+	u64 rsvd_val = msrs[idx].rsvd_val;
+	u32 reg = msrs[idx].index;
+	u64 val;
+	int r;
+
+	if (!use_one_reg)
+		return;
+
+	TEST_ASSERT_EQ(vcpu_has_reg(vcpu, KVM_X86_REG_KVM(reg)), has_reg);
+
+	if (!has_reg) {
+		r = __vcpu_get_reg(vcpu, KVM_X86_REG_KVM(reg), &val);
+		TEST_ASSERT(r && errno == EINVAL,
+			    "Expected failure on get_reg(0x%x)", reg);
+		rsvd_val = 0;
+		goto out;
+	}
+
+	val = vcpu_get_reg(vcpu, KVM_X86_REG_KVM(reg));
+	TEST_ASSERT(val == reset_val, "Wanted 0x%lx from get_reg(0x%x), got 0x%lx",
+		    reset_val, reg, val);
+
+	vcpu_set_reg(vcpu, KVM_X86_REG_KVM(reg), write_val);
+	val = vcpu_get_reg(vcpu, KVM_X86_REG_KVM(reg));
+	TEST_ASSERT(val == write_val, "Wanted 0x%lx from get_reg(0x%x), got 0x%lx",
+		    write_val, reg, val);
+
+out:
+	r = __vcpu_set_reg(vcpu, KVM_X86_REG_KVM(reg), rsvd_val);
+	TEST_ASSERT(r, "Expected failure on set_reg(0x%x, 0x%lx)", reg, rsvd_val);
+}
+
 static void host_test_msr(struct kvm_vcpu *vcpu, u64 guest_val)
 {
 	u64 reset_val = msrs[idx].reset_val;
@@ -307,6 +389,8 @@ static void test_msrs(void)
 		MSR_TEST(MSR_IA32_PL2_SSP, canonical_val, canonical_val | 1, SHSTK),
 		MSR_TEST_CANONICAL(MSR_IA32_PL3_SSP, SHSTK),
 		MSR_TEST(MSR_IA32_PL3_SSP, canonical_val, canonical_val | 1, SHSTK),
+
+		MSR_TEST_KVM(GUEST_SSP, canonical_val, NONCANONICAL, SHSTK),
 	};
 
 	const struct kvm_x86_cpu_feature feat_none = X86_FEATURE_NONE;
@@ -322,6 +406,7 @@ static void test_msrs(void)
 	const int NR_VCPUS = 3;
 	struct kvm_vcpu *vcpus[NR_VCPUS];
 	struct kvm_vm *vm;
+	int i;
 
 	kvm_static_assert(sizeof(__msrs) <= sizeof(msrs));
 	kvm_static_assert(ARRAY_SIZE(__msrs) <= ARRAY_SIZE(msrs));
@@ -352,6 +437,12 @@ static void test_msrs(void)
 	}
 
 	for (idx = 0; idx < ARRAY_SIZE(__msrs); idx++) {
+		if (msrs[idx].is_kvm_defined) {
+			for (i = 0; i < NR_VCPUS; i++)
+				host_test_kvm_reg(vcpus[i]);
+			continue;
+		}
+
 		sync_global_to_guest(vm, idx);
 
 		vcpus_run(vcpus, NR_VCPUS);
-- 
2.51.0.470.ga7dc726c21-goog


