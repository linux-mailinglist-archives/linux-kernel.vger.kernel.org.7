Return-Path: <linux-kernel+bounces-874821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CF2EC172AA
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 23:18:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88FC43A4B7E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 22:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EB383590A5;
	Tue, 28 Oct 2025 22:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mVZDqsZ0"
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E15853587CA
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 22:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761689571; cv=none; b=KQSef2Coh014M5Xb9aZOUtRds91TqiN3hgPAQBvWB7QApa6piEID4+w9q2UqRN1pmJTe4Ja1ngvBTaX2tEwgLxFDs9na9xg9q1Qv2LUQDAq1UyskIH0x7543Qxr+EYN/ErLUIebXyXRHnnip29IXun1Ypw0tkumMO7Vvgo4Hj3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761689571; c=relaxed/simple;
	bh=9WJOVfUVt6JAy1/UQov7Gl5mNjlNFcOn/orYhjsBu8s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H+9/3FzyLFOgmEqTznsHLBGc1/tLn1BTTBOu8roVhcxkdYnsRwPeEgtY3QCWCRUgzLtnF7N2U8/zgayU5Z35FgbcxG/dRd2A7JWvBWHoBOSVtYqfm0oDaUa6ywPz6RHf2KsxZushouA8bdqabowBfpMUETLTmxmXnYFKxljgGe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mVZDqsZ0; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761689568;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pghCsaBoSG4WPtJyc67VHSNRWgOinnAutbnbmUGrr2A=;
	b=mVZDqsZ0MItI0fecjzUjLd9vzB5MALq7VxBkc+C8PpRZSkxnKgHFLyAgRWOotQcdKkE91J
	IyYYdKZlM536l4jtEIuaAFreIUKffsaP/geDWTJbRvu36EMzWYv/RGIQDLXnaJ6IKtxG5W
	Axv/H7mErzgAdQ7A0npYN7Mkx2OusRs=
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Jim Mattson <jmattson@google.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosry.ahmed@linux.dev>
Subject: [kvm-unit-tests v2 5/8] x86/svm: Report unsupported SVM tests
Date: Tue, 28 Oct 2025 22:12:10 +0000
Message-ID: <20251028221213.1937120-6-yosry.ahmed@linux.dev>
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

Print a message when a test is skipped due to being unsupported for
better visibility.

Signed-off-by: Yosry Ahmed <yosry.ahmed@linux.dev>
---
 x86/svm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/x86/svm.c b/x86/svm.c
index 035367a1e90cf..5015339ddb657 100644
--- a/x86/svm.c
+++ b/x86/svm.c
@@ -403,8 +403,10 @@ int run_svm_tests(int ac, char **av, struct svm_test *svm_tests)
 	for (; svm_tests[i].name != NULL; i++) {
 		if (!test_wanted(svm_tests[i].name, av, ac))
 			continue;
-		if (svm_tests[i].supported && !svm_tests[i].supported())
+		if (svm_tests[i].supported && !svm_tests[i].supported()) {
+			report_skip("%s (not supported)", svm_tests[i].name);
 			continue;
+		}
 		if (svm_tests[i].v2 == NULL) {
 			if (svm_tests[i].on_vcpu) {
 				if (cpu_count() <= svm_tests[i].on_vcpu)
-- 
2.51.1.851.g4ebd6896fd-goog


