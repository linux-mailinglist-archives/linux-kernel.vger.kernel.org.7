Return-Path: <linux-kernel+bounces-814907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D7E92B55A42
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 01:34:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76ED41703C3
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 23:34:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50E322E6CBE;
	Fri, 12 Sep 2025 23:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4yhqENgK"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 137932E6112
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 23:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757719471; cv=none; b=fxTxF+GJRFmB4pktvO32PsBfK/CAbgHPf8mFi45kL0Zbe7NuQKoT908c0aSkJ5R6rXD/YsQH5UOgRXfWlYgjO4XrkEK5LvFoyTv2cPGNbmM/cEXJNuOIW5XVbsyryQnKs58bjvhithQd4mswrKvEokMZ7XXo5cBSAK7Cp27Ip5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757719471; c=relaxed/simple;
	bh=xvVG/b8p4jYJS4exfr9jgNhrzgeq/9Q9GtHal5fWR3M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mJhxcqeQihJIamtxOvTj7qIo6HJfSC7DLkw4LTxJozQH4LmsZhHv6NbQv8M+iIz3dM/tT6mK1qGnvjd3IMtjVskJv0XIc6QMcOJ88DV17C5J0KTWOlf6qXgJPTVPKCb1GPQ6NRvN+tkMSxM2j90/VBDYAl0IheYPTNvZd/3UiuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4yhqENgK; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b47630f9aa7so1721490a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 16:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757719469; x=1758324269; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=+Cp6gX199ZlnKIcOfZLsEBmM2Loedfz6S2rbDk9pgzs=;
        b=4yhqENgKgOd4NJM2xRRcENsI9JhhsBY6AjGvS5+ddHy9VumOn8g0k9NiYdujeFi4Iz
         PPffFq/opQfXKxJkBjdU0yKTlMdU7k+i2Wofu3+k+V0aaLe08tGicUrPNqUafqVcOVRh
         rIcZNtjqZUamJx32ixt7YTiZhpUWBEqOWeDZbWxmSGMwfqXm0IRMKScx/qR5+wXlJpa4
         KUzGZm9oLebaywyMzJx5Ja17IyR8YTMvX/pK4dqcSu1sVtoyg7B28KnBzB6q/5FkHNgg
         dTFuAz6JfZK3QtfU2cjJ4KKJhjd8uBMNLvEiwspkUUgrMvw2A2Sy83vaYOaF/A88WXlz
         tO7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757719469; x=1758324269;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+Cp6gX199ZlnKIcOfZLsEBmM2Loedfz6S2rbDk9pgzs=;
        b=iXfFVbirhNHW9wU7THZFGB66XNPb1cNK7ybmgFsPnzjmYgG+4qfLGPDu2j+2ycLmRy
         vxToCrEtPIUY6Qa5KY97ueG1jZrzi6bwWQP2nEufq+5wGg+u/41WY9MMNskUgApS5yJH
         ++DccULTXV7K21ZzX/VVG9Oo6v+F6BNQ8hyiBkha24v7Ob1DRoEcnXrv62tTjhVk9fPo
         h6hb65JnRbI/FuLm7eK+rcaEypF9PGdU8FcuIfw3rYZvLNNSdP3Z9+jn7m/OpdeRzi2F
         x12jYT0f5uphuISO1xV6Tk4abu2TPqENu+sI2spO+iDpz3hb8UJNuWv2Cwv2ax9ngh9T
         41SA==
X-Forwarded-Encrypted: i=1; AJvYcCV49WSSWB7KacXPENKmH3hugFyP7Lqd9tlnknamLdxHfdwCitYaL+wKNOAHQIi2qKVX4+JOpnlGV2tSf8Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLAw+tb2k5sKL28tSOOXFvJVeHVmKVSJwWHpB2kXIyrJwrODCD
	GoW4BMD1fJc6ExGZbow/nlKBCR5YYASYcjHPXEYpuE7LraJaRq1QdnL68Q67rbx7BbM50++k8bq
	FnTsO8w==
X-Google-Smtp-Source: AGHT+IHs6e7cWzDgsyk/0CjS8WitIQWmIeUJDUgD9RPqnppQ8alYn6o4bKfWriRoJDxWwsY9SJCM1pVycGs=
X-Received: from pglu24.prod.google.com ([2002:a63:1418:0:b0:b42:da4:ef4])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:6a0e:b0:251:c33d:2793
 with SMTP id adf61e73a8af0-2602c04fba4mr5705820637.44.1757719469478; Fri, 12
 Sep 2025 16:24:29 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 12 Sep 2025 16:23:14 -0700
In-Reply-To: <20250912232319.429659-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250912232319.429659-1-seanjc@google.com>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250912232319.429659-37-seanjc@google.com>
Subject: [PATCH v15 36/41] KVM: selftests: Add support for MSR_IA32_{S,U}_CET
 to MSRs test
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Tom Lendacky <thomas.lendacky@amd.com>, Mathias Krause <minipli@grsecurity.net>, 
	John Allen <john.allen@amd.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Chao Gao <chao.gao@intel.com>, Maxim Levitsky <mlevitsk@redhat.com>, 
	Xiaoyao Li <xiaoyao.li@intel.com>, Zhang Yi Z <yi.z.zhang@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"

Extend the MSRs test to support {S,U}_CET, which are a bit of a pain to
handled due to the MSRs existing if IBT *or* SHSTK is supported.  To deal
with Intel's wonderful decision to bundle IBT and SHSTK under CET, track
the "second" feature and skip RDMSR #GP tests to avoid false failures when
running on a CPU with only one of IBT or SHSTK.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/x86/msrs_test.c | 22 ++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/x86/msrs_test.c b/tools/testing/selftests/kvm/x86/msrs_test.c
index dcb429cf1440..095d49d07235 100644
--- a/tools/testing/selftests/kvm/x86/msrs_test.c
+++ b/tools/testing/selftests/kvm/x86/msrs_test.c
@@ -11,6 +11,7 @@
 
 struct kvm_msr {
 	const struct kvm_x86_cpu_feature feature;
+	const struct kvm_x86_cpu_feature feature2;
 	const char *name;
 	const u64 reset_val;
 	const u64 write_val;
@@ -18,7 +19,7 @@ struct kvm_msr {
 	const u32 index;
 };
 
-#define __MSR_TEST(msr, str, val, rsvd, reset, feat)			\
+#define ____MSR_TEST(msr, str, val, rsvd, reset, feat, f2)		\
 {									\
 	.index = msr,							\
 	.name = str,							\
@@ -26,14 +27,21 @@ struct kvm_msr {
 	.rsvd_val = rsvd,						\
 	.reset_val = reset,						\
 	.feature = X86_FEATURE_ ##feat,					\
+	.feature2 = X86_FEATURE_ ##f2,					\
 }
 
+#define __MSR_TEST(msr, str, val, rsvd, reset, feat)			\
+	____MSR_TEST(msr, str, val, rsvd, reset, feat, feat)
+
 #define MSR_TEST_NON_ZERO(msr, val, rsvd, reset, feat)			\
 	__MSR_TEST(msr, #msr, val, rsvd, reset, feat)
 
 #define MSR_TEST(msr, val, rsvd, feat)					\
 	__MSR_TEST(msr, #msr, val, rsvd, 0, feat)
 
+#define MSR_TEST2(msr, val, rsvd, feat, f2)				\
+	____MSR_TEST(msr, #msr, val, rsvd, 0, feat, f2)
+
 /*
  * Note, use a page aligned value for the canonical value so that the value
  * is compatible with MSRs that use bits 11:0 for things other than addresses.
@@ -98,10 +106,18 @@ static void guest_test_unsupported_msr(const struct kvm_msr *msr)
 	u64 val;
 	u8 vec;
 
+	/*
+	 * Skip the RDMSR #GP test if the secondary feature is supported, as
+	 * only the to-be-written value depends on the primary feature.
+	 */
+	if (this_cpu_has(msr->feature2))
+		goto skip_rdmsr_gp;
+
 	vec = rdmsr_safe(msr->index, &val);
 	__GUEST_ASSERT(vec == GP_VECTOR, "Wanted #GP on RDMSR(0x%x), got %s",
 		       msr->index, ex_str(vec));
 
+skip_rdmsr_gp:
 	vec = wrmsr_safe(msr->index, msr->write_val);
 	__GUEST_ASSERT(vec == GP_VECTOR, "Wanted #GP on WRMSR(0x%x, 0x%lx), got %s",
 		       msr->index, msr->write_val, ex_str(vec));
@@ -224,6 +240,10 @@ static void test_msrs(void)
 		MSR_TEST_CANONICAL(MSR_CSTAR, LM),
 		MSR_TEST(MSR_SYSCALL_MASK, 0xffffffff, 0, LM),
 
+		MSR_TEST2(MSR_IA32_S_CET, CET_SHSTK_EN, CET_RESERVED, SHSTK, IBT),
+		MSR_TEST2(MSR_IA32_S_CET, CET_ENDBR_EN, CET_RESERVED, IBT, SHSTK),
+		MSR_TEST2(MSR_IA32_U_CET, CET_SHSTK_EN, CET_RESERVED, SHSTK, IBT),
+		MSR_TEST2(MSR_IA32_U_CET, CET_ENDBR_EN, CET_RESERVED, IBT, SHSTK),
 		MSR_TEST_CANONICAL(MSR_IA32_PL0_SSP, SHSTK),
 		MSR_TEST(MSR_IA32_PL0_SSP, canonical_val, canonical_val | 1, SHSTK),
 		MSR_TEST_CANONICAL(MSR_IA32_PL1_SSP, SHSTK),
-- 
2.51.0.384.g4c02a37b29-goog


