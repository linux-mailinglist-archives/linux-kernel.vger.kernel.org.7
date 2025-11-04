Return-Path: <linux-kernel+bounces-885400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E4355C32CD8
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 20:34:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C44FC4F2E95
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 19:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2F3122689C;
	Tue,  4 Nov 2025 19:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ggdAo1GA"
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F0DA184540
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 19:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762284679; cv=none; b=Sa3R5Y5wblQqDaWZGphXGyFYGHp4Z5/t22uB69iXnsnU9PlD26W2QY6/PalMIMK6t8PQqpKh8nwH87Zh4B/C4Q3DZ3vloB/XYeDmoOLZSPR5zcEDs9lIuMfaNXZ8j7fbUQiGxsy9mcdvyr2DrYO3JlEUOaqJRcpM5KSS6rLucTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762284679; c=relaxed/simple;
	bh=pnJdLRml59KM/6R8I9/bLJImximiLfRJIf5qVWtTj+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sZN3k1pIQ2j0ZOYvDTQDivVWrkMdy0dNw7b+5Nge7i8PV4cAc+lsRryluIQlQiv0Oi/qphn2X0ti9gKU8nzdoNsMMOyCsb5MgY+GOtcmtTkwTqrxJz5/XcE9cYvINh89+EPJNTydk2CTbA8fSPxJyAbjfCDVbkDodJJ2R5dj1Sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ggdAo1GA; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762284674;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vCypeWKlDM3/Kf44AfQNFN9PYKjkYPOvRvn07TDQo3Q=;
	b=ggdAo1GAjo/ZABS4Ne9MW14hmNxS7R6haNS6fgUH274wOGEMr/5Z/Xliz8Ox2TYQ/h2srI
	fEkCgdXI3I0H+udhbVOtaNes4gzMhv07oqTrhK+TbH2UZcvUKG/zWHxqyvNFU+sp5ZqVfc
	VxRweMZs4lq6YP8r0XBgtbKTlaZyt0I=
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Jim Mattson <jmattson@google.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosry.ahmed@linux.dev>
Subject: [kvm-unit-tests 1/4] x86/vmx: Skip vmx_pf_exception_test_fep early if FEP is not available
Date: Tue,  4 Nov 2025 19:30:13 +0000
Message-ID: <20251104193016.3408754-2-yosry.ahmed@linux.dev>
In-Reply-To: <20251104193016.3408754-1-yosry.ahmed@linux.dev>
References: <20251104193016.3408754-1-yosry.ahmed@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The check to skip the test is currently performed in the guest code.
There a few TEST_ASSERTs that happen before the guest is run, which
internally call report_passed(). The latter increases the number of
passed tests.

Hence, when vmx_pf_exception_test_fep is run, report_summary() does not
return a "skip" error code because the total number of tests is larger
than the number of skipped tests.

Skip early if FEP is not available, before any assertions, such that
report_summary() finds exactly 1 skipped test and returns the
appropriate error code.

Signed-off-by: Yosry Ahmed <yosry.ahmed@linux.dev>
---
 x86/vmx_tests.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/x86/vmx_tests.c b/x86/vmx_tests.c
index 0b3cfe50c6142..4f214ebdbe1d9 100644
--- a/x86/vmx_tests.c
+++ b/x86/vmx_tests.c
@@ -10644,7 +10644,10 @@ static void vmx_pf_exception_test(void)
 
 static void vmx_pf_exception_forced_emulation_test(void)
 {
-	__vmx_pf_exception_test(NULL, NULL, vmx_pf_exception_forced_emulation_test_guest);
+	if (is_fep_available)
+		__vmx_pf_exception_test(NULL, NULL, vmx_pf_exception_forced_emulation_test_guest);
+	else
+		report_skip("Forced emulation prefix (FEP) not available\n");
 }
 
 static void invalidate_tlb_no_vpid(void *data)
-- 
2.51.2.1026.g39e6a42477-goog


