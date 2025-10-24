Return-Path: <linux-kernel+bounces-869466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AB19C07F4F
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 21:49:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D36B13B9791
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 19:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 417D52D1916;
	Fri, 24 Oct 2025 19:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CBJfugn1"
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4BAA2C3242
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 19:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761335384; cv=none; b=WN7HKI6WjeRHGNDT/ZfQ2Z3D2bZ1Dme0WDZTOg+zNCa8Tq5DgMHtC/JRevXbrX8f+YS1pQmdKZXjtCrnpUxFII0rJS1/SAdNxOFAHDQaDh1ertEXphOJV1f+5unYa3t4fiV4Gr5aPL/7yIM+kzUPdreak7l84wAuXILcIBWMVAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761335384; c=relaxed/simple;
	bh=QH29zgZGFcZKWba6DgL9VJdCpR+8hm+YSLE/pZSJuzo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JBcdV85w81xfoEaW+fCQuSwyDiBdwrfux//ysX4sbBIGcq5OpClxUKCb7uxli/L9dhU56o28OpACxXGxhpep03TpqIxuaw3VCQQcSYd9L1iRn5b2lB4PBRbUJhJRDEt7Cllyy21zeFyUfx6R5cb6B//IakMkFvFvgzDwPVRz3K8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CBJfugn1; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761335380;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J1kh3wzJ2IyZ2rSYc2w+/9+gZYIO+ejKEv2FW4QM4RE=;
	b=CBJfugn13F5y49v/bEdH+arwdtiS9mVh8cz7On7jIURPyGIFEpdQpfCrd4+dxDcpMm1Zsy
	cwUXp17YMlJbsZQDJDV0DramZco25CyAVr32ITWAnlkH1pYU0rNGgpTORIrwL0hYAUJ43z
	bA4ji4IndPKBxzxlq2x0XCifPWk+zEM=
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Jim Mattson <jmattson@google.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosryahmed@google.com>
Subject: [kvm-unit-tests 1/7] x86/svm: Cleanup selective cr0 write intercept test
Date: Fri, 24 Oct 2025 19:49:19 +0000
Message-ID: <20251024194925.3201933-2-yosry.ahmed@linux.dev>
In-Reply-To: <20251024194925.3201933-1-yosry.ahmed@linux.dev>
References: <20251024194925.3201933-1-yosry.ahmed@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Yosry Ahmed <yosryahmed@google.com>

Rename the test and functions to more general names describing the test
more accurately. Use X86_CR0_CD instead of hardcoding the bitmask, and
explicitly clear the bit in the prepare() function to make it clearer
that it would only be set by the test.

Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
---
 x86/svm_tests.c | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/x86/svm_tests.c b/x86/svm_tests.c
index 80d5aeb1..e9116591 100644
--- a/x86/svm_tests.c
+++ b/x86/svm_tests.c
@@ -793,23 +793,19 @@ static bool check_asid_zero(struct svm_test *test)
 	return vmcb->control.exit_code == SVM_EXIT_ERR;
 }
 
-static void sel_cr0_bug_prepare(struct svm_test *test)
+static void prepare_sel_cr0_intercept(struct svm_test *test)
 {
+	vmcb->save.cr0 &= ~X86_CR0_CD;
 	vmcb->control.intercept |= (1ULL << INTERCEPT_SELECTIVE_CR0);
 }
 
-static bool sel_cr0_bug_finished(struct svm_test *test)
-{
-	return true;
-}
-
-static void sel_cr0_bug_test(struct svm_test *test)
+static void test_sel_cr0_write_intercept(struct svm_test *test)
 {
 	unsigned long cr0;
 
-	/* read cr0, clear CD, and write back */
+	/* read cr0, set CD, and write back */
 	cr0  = read_cr0();
-	cr0 |= (1UL << 30);
+	cr0 |= X86_CR0_CD;
 	write_cr0(cr0);
 
 	/*
@@ -821,7 +817,7 @@ static void sel_cr0_bug_test(struct svm_test *test)
 	exit(report_summary());
 }
 
-static bool sel_cr0_bug_check(struct svm_test *test)
+static bool check_sel_cr0_intercept(struct svm_test *test)
 {
 	return vmcb->control.exit_code == SVM_EXIT_CR0_SEL_WRITE;
 }
@@ -3486,9 +3482,9 @@ struct svm_test svm_tests[] = {
 	{ "asid_zero", default_supported, prepare_asid_zero,
 	  default_prepare_gif_clear, test_asid_zero,
 	  default_finished, check_asid_zero },
-	{ "sel_cr0_bug", default_supported, sel_cr0_bug_prepare,
-	  default_prepare_gif_clear, sel_cr0_bug_test,
-	  sel_cr0_bug_finished, sel_cr0_bug_check },
+	{ "sel cr0 write intercept", default_supported,
+	  prepare_sel_cr0_intercept, default_prepare_gif_clear,
+	  test_sel_cr0_write_intercept, default_finished, check_sel_cr0_intercept},
 	{ "tsc_adjust", tsc_adjust_supported, tsc_adjust_prepare,
 	  default_prepare_gif_clear, tsc_adjust_test,
 	  default_finished, tsc_adjust_check },
-- 
2.51.1.821.gb6fe4d2222-goog


