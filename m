Return-Path: <linux-kernel+bounces-874824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 45980C172A4
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 23:18:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1419B1C27814
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 22:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2D1D3596E1;
	Tue, 28 Oct 2025 22:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="v1ZoiGhA"
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF503596F8
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 22:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761689581; cv=none; b=DAd/zrMA/Uwq1OQ9QRMFx2M3wwHC2GpeF7UScz7czjv/dRXsZ5ci3rBGtyMZL9z/MASjuRkZVkfrUrOz6qe6/tmoEMOoZUKnam8IrX0SwlZH0gAYBt97y/r3uK/9/YuB60LHu7J7Zlf4lGcdAf1VA5TlmDA4bdF7+oV/hopYY9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761689581; c=relaxed/simple;
	bh=GHWb51/LZqdZkItu3qtzEt5jNBHLFHrIajzD8Bkh1w8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RU0n1DOVawMwuwTmSteTU03Wgcu2wHgL1rJH62l5F8oB5y4cLjG3Q7pmijhkD7klXAQ7ntj2QKCIqdVKDp5nu4I/ZQKUTt2zilb7PKf03GVr+JhKaiXwqLPU3V0SqcTp+lMMGWfWV2T5mMdyerXr3FirPcxOImIEFkRBK6+QD8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=v1ZoiGhA; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761689573;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CoM4XFkPY77V8Y9t0f2H5TV0K04vGajsPcV+ESHU9TA=;
	b=v1ZoiGhAw8QztEFla2JV00D6qtzXa3QwWvznxxRL20foVPElM9m3bPSn3DGarsFgFGrqr1
	GgA4chizUgF43b5okDTNjuMqWttibBHBXVBfODbGyj9nZX89f5OOFX8sj3L8tMbAPFhXVm
	Y1xBnM9oAsViuIfePMSkv2V2n5seKCU=
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Jim Mattson <jmattson@google.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosry.ahmed@linux.dev>
Subject: [kvm-unit-tests v2 8/8] x86/svm: Add more selective CR0 write and LMSW test cases
Date: Tue, 28 Oct 2025 22:12:13 +0000
Message-ID: <20251028221213.1937120-9-yosry.ahmed@linux.dev>
In-Reply-To: <20251028221213.1937120-1-yosry.ahmed@linux.dev>
References: <20251028221213.1937120-1-yosry.ahmed@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Add more test cases that cover:
- The priority between selective and non-selective CR0 intercepts.
- Writes to CR0 that should not intercept (e.g. CR0.MP).
- Writes to CR0 using LMSW, which should always intercept (even when
  updating CR0.MP).

Emulator variants of all test cases are added as well.

The new tests exercises bugs fixed by:
https://lore.kernel.org/kvm/20251024192918.3191141-1-yosry.ahmed@linux.dev/.

Signed-off-by: Yosry Ahmed <yosry.ahmed@linux.dev>
---
 x86/svm_tests.c | 76 ++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 72 insertions(+), 4 deletions(-)

diff --git a/x86/svm_tests.c b/x86/svm_tests.c
index 71afb38a3928d..2981f459032cb 100644
--- a/x86/svm_tests.c
+++ b/x86/svm_tests.c
@@ -129,20 +129,36 @@ static bool finished_rsm_intercept(struct svm_test *test)
 
 static void prepare_sel_cr0_intercept(struct svm_test *test)
 {
+	/* Clear CR0.MP and CR0.CD as the tests will set either of them */
+	vmcb->save.cr0 &= ~X86_CR0_MP;
 	vmcb->save.cr0 &= ~X86_CR0_CD;
 	vmcb->control.intercept |= (1ULL << INTERCEPT_SELECTIVE_CR0);
 }
 
+static void prepare_sel_nonsel_cr0_intercepts(struct svm_test *test)
+{
+	/* Clear CR0.MP and CR0.CD as the tests will set either of them */
+	vmcb->save.cr0 &= ~X86_CR0_MP;
+	vmcb->save.cr0 &= ~X86_CR0_CD;
+	vmcb->control.intercept_cr_write |= (1ULL << 0);
+	vmcb->control.intercept |= (1ULL << INTERCEPT_SELECTIVE_CR0);
+}
+
 static void __test_cr0_write_bit(struct svm_test *test, unsigned long bit,
-				 bool intercept, bool fep)
+				 bool is_lmsw, bool intercept, bool fep)
 {
+	unsigned short msw;
 	unsigned long cr0;
 
 	cr0 = read_cr0();
 	cr0 |= bit;
+	msw = cr0 & 0xfUL;
 	test->scratch = cr0;
 
-	asm_conditional_fep_safe(fep, "mov %0,%%cr0", "r"(cr0));
+	if (is_lmsw)
+		asm_conditional_fep_safe(fep, "lmsw %0", "r"(msw));
+	else
+		asm_conditional_fep_safe(fep, "mov %0,%%cr0", "r"(cr0));
 
 	/* This code should be unreachable when an intercept is expected */
 	report_svm_guest(!intercept, test, "Expected intercept on CR0 write");
@@ -151,12 +167,34 @@ static void __test_cr0_write_bit(struct svm_test *test, unsigned long bit,
 /* MOV-to-CR0 updating CR0.CD is intercepted by the selective intercept */
 static void test_sel_cr0_write_intercept(struct svm_test *test)
 {
-	__test_cr0_write_bit(test, X86_CR0_CD, true, false);
+	__test_cr0_write_bit(test, X86_CR0_CD, false, true, false);
 }
 
 static void test_sel_cr0_write_intercept_emul(struct svm_test *test)
 {
-	__test_cr0_write_bit(test, X86_CR0_CD, true, true);
+	__test_cr0_write_bit(test, X86_CR0_CD, false, true, true);
+}
+
+/* MOV-to-CR0 updating CR0.MP is NOT intercepted by the selective intercept */
+static void test_sel_cr0_write_nointercept(struct svm_test *test)
+{
+	__test_cr0_write_bit(test, X86_CR0_MP, false, false, false);
+}
+
+static void test_sel_cr0_write_nointercept_emul(struct svm_test *test)
+{
+	__test_cr0_write_bit(test, X86_CR0_MP, false, false, true);
+}
+
+/* LMSW updating CR0.MP is intercepted by the selective intercept */
+static void test_sel_cr0_lmsw_intercept(struct svm_test *test)
+{
+	__test_cr0_write_bit(test, X86_CR0_MP, true, false, false);
+}
+
+static void test_sel_cr0_lmsw_intercept_emul(struct svm_test *test)
+{
+	__test_cr0_write_bit(test, X86_CR0_MP, true, false, true);
 }
 
 static bool check_sel_cr0_intercept(struct svm_test *test)
@@ -165,6 +203,18 @@ static bool check_sel_cr0_intercept(struct svm_test *test)
 		vmcb->save.cr0 != test->scratch;
 }
 
+static bool check_nonsel_cr0_intercept(struct svm_test *test)
+{
+	return vmcb->control.exit_code == SVM_EXIT_WRITE_CR0 &&
+		vmcb->save.cr0 != test->scratch;
+}
+
+static bool check_cr0_nointercept(struct svm_test *test)
+{
+	return vmcb->control.exit_code == SVM_EXIT_VMMCALL &&
+		vmcb->save.cr0 == test->scratch;
+}
+
 static void prepare_cr3_intercept(struct svm_test *test)
 {
 	default_prepare(test);
@@ -3473,6 +3523,24 @@ struct svm_test svm_tests[] = {
 	{ "sel cr0 write intercept emulate", fep_supported,
 	  prepare_sel_cr0_intercept, default_prepare_gif_clear,
 	  test_sel_cr0_write_intercept_emul, default_finished, check_sel_cr0_intercept},
+	{ "sel cr0 write intercept priority", default_supported,
+	  prepare_sel_nonsel_cr0_intercepts, default_prepare_gif_clear,
+	  test_sel_cr0_write_intercept, default_finished, check_nonsel_cr0_intercept},
+	{ "sel cr0 write intercept priority emulate", fep_supported,
+	  prepare_sel_nonsel_cr0_intercepts, default_prepare_gif_clear,
+	  test_sel_cr0_write_intercept_emul, default_finished, check_nonsel_cr0_intercept},
+	{ "sel cr0 write nointercept", default_supported,
+	  prepare_sel_cr0_intercept, default_prepare_gif_clear,
+	  test_sel_cr0_write_nointercept, default_finished, check_cr0_nointercept},
+	{ "sel cr0 write nointercept emulate", fep_supported,
+	  prepare_sel_cr0_intercept, default_prepare_gif_clear,
+	  test_sel_cr0_write_nointercept_emul, default_finished, check_cr0_nointercept},
+	{ "sel cr0 lmsw intercept", default_supported,
+	  prepare_sel_cr0_intercept, default_prepare_gif_clear,
+	  test_sel_cr0_lmsw_intercept, default_finished, check_sel_cr0_intercept},
+	{ "sel cr0 lmsw intercept emulate", fep_supported,
+	  prepare_sel_cr0_intercept, default_prepare_gif_clear,
+	  test_sel_cr0_lmsw_intercept_emul, default_finished, check_sel_cr0_intercept},
 	{ "cr3 read intercept", default_supported,
 	  prepare_cr3_intercept, default_prepare_gif_clear,
 	  test_cr3_intercept, default_finished, check_cr3_intercept },
-- 
2.51.1.851.g4ebd6896fd-goog


