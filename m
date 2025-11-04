Return-Path: <linux-kernel+bounces-885401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3625CC32CFB
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 20:34:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E6A2B4F6FD0
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 19:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FA652DF6E6;
	Tue,  4 Nov 2025 19:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TSO5Zpvl"
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 822A52D8DDF
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 19:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762284680; cv=none; b=D9HOgJ0gXR/VaI9gLb0ESTZMpTlWxXkSzQzmSmJOwYSfhi0u9LQJR3RSPJNj6IQe8w6P4LqqOuyVtocr4x/cUmkjAi7qIGhb3dePh7B+2DX7IagAAcO3Rqw96bng6GKTo/aUPYMtQgEN2uR9iSIqdCRmR9a+0pFz2y6dMo/kCHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762284680; c=relaxed/simple;
	bh=wqUNVKL8v768YOHBTWNTvZgtQ4Ct5tATq9NbNTdlpU8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QJ2B/xhRR0tcIe2/OpNT4TrMtJTBxQHHRU9GzuHvulkupLd1nVr7P8ddMs/cAH4r/zSQzpkpapVrCTmfuEh+abVj8P3shfiiVPcWe9Jvkc/St1ahNZBb7BPUY/6fV5UtuxyQYEG+BZ+w3OLtYw9uD4DttgCOBT8S05cN7x0qny0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TSO5Zpvl; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762284676;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5yeVlMAcS+nPhQGjM8V6lNyq9Vi8yJTliVlIvK4CNPY=;
	b=TSO5ZpvlEa0Jnz4DHG5kBK8jHyWxYqLVTD5khYb6YNnAtyei0ID/rtIzELnGJhrKdTPEWh
	JQ8C5pQZH9wDAAr4sqIHNvCUfAv9YPV4hDlOdVB2oOdc9I1UHo1LG0/LFHwa5spFeVT3WQ
	9oPVBHAdJuxWyr3A9e8NVYq0clPFoaI=
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Jim Mattson <jmattson@google.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosry.ahmed@linux.dev>
Subject: [kvm-unit-tests 2/4] x86/svm: Print SVM test names before running tests
Date: Tue,  4 Nov 2025 19:30:14 +0000
Message-ID: <20251104193016.3408754-3-yosry.ahmed@linux.dev>
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

When SVM tests are run, the log is a see of PASS/FAIL/SKIPs that are not
clearly separated by test. Sometimes it's hard to attribute a failure to
a specific test (e.g. if the same helper is reused by multiple tests).

Print the test name before running each test.

Signed-off-by: Yosry Ahmed <yosry.ahmed@linux.dev>
---
 x86/svm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/x86/svm.c b/x86/svm.c
index 5015339ddb657..de9eb19443caa 100644
--- a/x86/svm.c
+++ b/x86/svm.c
@@ -407,6 +407,7 @@ int run_svm_tests(int ac, char **av, struct svm_test *svm_tests)
 			report_skip("%s (not supported)", svm_tests[i].name);
 			continue;
 		}
+		printf("SVM test: %s\n", svm_tests[i].name);
 		if (svm_tests[i].v2 == NULL) {
 			if (svm_tests[i].on_vcpu) {
 				if (cpu_count() <= svm_tests[i].on_vcpu)
-- 
2.51.2.1026.g39e6a42477-goog


