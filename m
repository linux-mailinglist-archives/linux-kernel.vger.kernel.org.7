Return-Path: <linux-kernel+bounces-894325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC259C49C0F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 00:30:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2C8C188D516
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 23:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0879C33EB01;
	Mon, 10 Nov 2025 23:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lPdUVE+M"
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80FDD333740
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 23:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762817236; cv=none; b=u6vnJ2iZddOSO79Tr1h0K+TnTuqp7dPcVlV5Gw0myhyao4TPRwfNFMRlQW5Ye2Z3z591baU8SQrGbScoLL46H0/uN4RGvWUzcgaW1mO65u2MP8DNXlHVvh9eV4QYVCxNheTiuxOTqjPPndtQ/90a5r0BdAQH9gPptIF5oG7DaYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762817236; c=relaxed/simple;
	bh=qYNpbiWtScHM2zedsmkE9xtTzE1sycYpDCXv2oxicaE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hML2BpsFCast2I+IfXBIjqOAx8gLltoLtbC8u+7vPTkEg/LMnEyOM5tUc12WzOb3mBVp+x/Ryse66eeMwt8DJ6pzRRwWHHHVJEG++qj5pdHa909q9ovWZzoe2HyJSR4luWWvSOk0dKFZDK3EJ4ZbvRedkcKwUWIDOMkvqetE9LM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lPdUVE+M; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762817231;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4STebxdlf1RD+u4wrdJG/8su7c7ySF1xDdKsPn6nKEU=;
	b=lPdUVE+M8lbOzx3683Ck9oOUnV6omxo/ilDaQhWFbq4Z+V88PynukYc0uWqUU49F+Xr0Uy
	MhnlRPYTyDm2JdZB0cmrkgIhZbS+joCgj69EzhR+VnpVC4XZieoj3lOmlUI6pTwSmsCK4z
	yqcwyO9HrlvuhIDl2vk1PmMAJSQbXPo=
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Kevin Cheng <chengkev@google.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosry.ahmed@linux.dev>
Subject: [PATCH v3 06/14] x86/svm: Report unsupported SVM tests
Date: Mon, 10 Nov 2025 23:26:34 +0000
Message-ID: <20251110232642.633672-7-yosry.ahmed@linux.dev>
In-Reply-To: <20251110232642.633672-1-yosry.ahmed@linux.dev>
References: <20251110232642.633672-1-yosry.ahmed@linux.dev>
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
2.51.2.1041.gc1ab5b90ca-goog


