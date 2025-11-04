Return-Path: <linux-kernel+bounces-885403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 77964C32D13
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 20:35:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D1C7B4FA174
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 19:32:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8ED8299AAB;
	Tue,  4 Nov 2025 19:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JMwYmvBO"
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6819F2E6CC0
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 19:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762284684; cv=none; b=MwSO6cThhSN9ipYmkJxTQPLyxzHZ2IJlUjq931kRgJfYOBU05y1/KFdcEHPyCgS/UyZErSw0FbU0UcOyJLRcz/U+8GI75VbL8CcpWVIsqVgKptYiOgFlyWvEG4Dk9Hg4lkCqJ1Wrx2+6beUL5G2dhJ1Y+YpKDB5JDesKIw4416g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762284684; c=relaxed/simple;
	bh=+ZJA6Q75MIRb7BPwJQxYYkjbOwsjL+1qbka9doCeMbA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q7JGntK26mFGpmiLFW4M2hUC4GJt2PZzumHoWr/iAc3DK4YsIgmDNNyi2i8yO2lHH1LLiLj0IVDoE+/Eye9ZMQVr4uZ8fPLvSypuJv5ZSEcMLsUmD7jRrM5Ie5CpvLVUbw+JQvZ06AVQCg2Ajp/UMp3wuf7zaonGG0J8NdhJvXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JMwYmvBO; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762284680;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=givJI//PiAABh+/f+gBvpZ0lroLLWSUedcKqAHccxGg=;
	b=JMwYmvBOMhpEjCwRCpCXCEUnynnZCC36OZL1GruFCVBVHW6+CLEIPl1+ZWyjQUhagROsBD
	JaScDP0pzUaLU1yohIV7iNXFG0lQZwEl0EkFsHdxUv7YQhGMf54KjZ2onkBGmXI5GBEAi7
	QJb7krxIBAYJF+vcb7qwaPwh1lAPAR0=
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Jim Mattson <jmattson@google.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosry.ahmed@linux.dev>
Subject: [kvm-unit-tests 4/4] x86/svm: Deflake svm_tsc_scale_test
Date: Tue,  4 Nov 2025 19:30:16 +0000
Message-ID: <20251104193016.3408754-5-yosry.ahmed@linux.dev>
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

On an AMT Turin (EPYC Zen 5), svm_tsc_scale_test flakes on the last test
case with 0.0001 TSC scaling ratio, even with the 24-bit shift for
stability. On failure, the actual value is 49 instead of the expected
50.

Use a higher scaling ratio, 0.001, which makes the test pass
consistently.

Signed-off-by: Yosry Ahmed <yosry.ahmed@linux.dev>
---
 x86/svm_tests.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/x86/svm_tests.c b/x86/svm_tests.c
index 8d309860e76e5..29c899762b7a4 100644
--- a/x86/svm_tests.c
+++ b/x86/svm_tests.c
@@ -1002,7 +1002,7 @@ static void svm_tsc_scale_test(void)
 	}
 
 	svm_tsc_scale_run_testcase(50, 255, rdrand());
-	svm_tsc_scale_run_testcase(50, 0.0001, rdrand());
+	svm_tsc_scale_run_testcase(50, 0.001, rdrand());
 }
 
 static void latency_prepare(struct svm_test *test)
-- 
2.51.2.1026.g39e6a42477-goog


