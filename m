Return-Path: <linux-kernel+bounces-598845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 925ADA84BBB
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Apr 2025 19:56:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 685F24A4EF4
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Apr 2025 17:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFE6128A408;
	Thu, 10 Apr 2025 17:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="03/q/ban"
Received: from smtp-42ad.mail.infomaniak.ch (smtp-42ad.mail.infomaniak.ch [84.16.66.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D7B1EB18E
	for <linux-kernel@vger.kernel.org>; Thu, 10 Apr 2025 17:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744307717; cv=none; b=ZRSep9lbIgL1/bUv8z9mzl891uUziD1l97iA5BbJEdML/och1PiuBXxjDlLTHsDEZF+5uxej613THw4zGZ7tLU+ynCHZtBliK5qgXVi1lKvGeFZpB/mdsZp9G5gDVmyMzwDbCZ+VbZsZlwSSPNYj8MFsai2v4Yd10vA5n0J15+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744307717; c=relaxed/simple;
	bh=onVm9yz4kkQZKREFFYmq+0gcjgF/q8YWrg7pod93OEE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RKekMqssdq5ABjKJwdWjZuSEhtKqamgm0VNKu60FvkNRT7oFJX0n3JwbSmKr8VvyRY6eGPHU9yUC4EkmqZkEBJLiBHrHRFX1TDwqed2q/OzbR4nXzHxLjk4U+nIAXpmahsD7PlXu6oHnrDbBwQaZ0/lHhjbzkAW2N9uggAsnV9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=03/q/ban; arc=none smtp.client-ip=84.16.66.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0000.mail.infomaniak.ch (unknown [IPv6:2001:1600:7:10:40ca:feff:fe05:0])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4ZYRMj6DSmzVZg;
	Thu, 10 Apr 2025 19:17:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1744305457;
	bh=RMZ4bOXPFc2DoXl+R1z/0s8d433W+UChpwRNcCV/Mxs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=03/q/banW/8XwCrB9Xdc1Mjwk0LyYA808GSuPwZRsNea1iqspVX53dbkYL5rKH0U2
	 9Wbr24szgrPqluQ5IKAJzqpKgyTMdaSyPe1b+hklvRkIO3mlZdKccincj/Z5wp8OEP
	 4ut14ICbeiKcTVtc6dXzIBNwtiCibCMJ2cYmkETI=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4ZYRMj38dYzHBb;
	Thu, 10 Apr 2025 19:17:37 +0200 (CEST)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/3] selftests/landlock: Factor out audit fixture in audit_test
Date: Thu, 10 Apr 2025 19:17:22 +0200
Message-ID: <20250410171725.1265860-2-mic@digikod.net>
In-Reply-To: <20250410171725.1265860-1-mic@digikod.net>
References: <20250410171725.1265860-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

The audit fixture needlessly stores and manages domain_stack.  Move it
to the audit.layers tests.  This will be useful to reuse the audit
fixture with the next patch.

Cc: Günther Noack <gnoack@google.com>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---
 tools/testing/selftests/landlock/audit_test.c | 27 +++++++++----------
 1 file changed, 12 insertions(+), 15 deletions(-)

diff --git a/tools/testing/selftests/landlock/audit_test.c b/tools/testing/selftests/landlock/audit_test.c
index a0643070c403..815c0f03e1fb 100644
--- a/tools/testing/selftests/landlock/audit_test.c
+++ b/tools/testing/selftests/landlock/audit_test.c
@@ -40,7 +40,6 @@ FIXTURE(audit)
 {
 	struct audit_filter audit_filter;
 	int audit_fd;
-	__u64(*domain_stack)[16];
 };
 
 FIXTURE_SETUP(audit)
@@ -60,18 +59,10 @@ FIXTURE_SETUP(audit)
 		TH_LOG("Failed to initialize audit: %s", error_msg);
 	}
 	clear_cap(_metadata, CAP_AUDIT_CONTROL);
-
-	self->domain_stack = mmap(NULL, sizeof(*self->domain_stack),
-				  PROT_READ | PROT_WRITE,
-				  MAP_SHARED | MAP_ANONYMOUS, -1, 0);
-	ASSERT_NE(MAP_FAILED, self->domain_stack);
-	memset(self->domain_stack, 0, sizeof(*self->domain_stack));
 }
 
 FIXTURE_TEARDOWN(audit)
 {
-	EXPECT_EQ(0, munmap(self->domain_stack, sizeof(*self->domain_stack)));
-
 	set_cap(_metadata, CAP_AUDIT_CONTROL);
 	EXPECT_EQ(0, audit_cleanup(self->audit_fd, &self->audit_filter));
 	clear_cap(_metadata, CAP_AUDIT_CONTROL);
@@ -83,9 +74,15 @@ TEST_F(audit, layers)
 		.scoped = LANDLOCK_SCOPE_SIGNAL,
 	};
 	int status, ruleset_fd, i;
+	__u64(*domain_stack)[16];
 	__u64 prev_dom = 3;
 	pid_t child;
 
+	domain_stack = mmap(NULL, sizeof(*domain_stack), PROT_READ | PROT_WRITE,
+			    MAP_SHARED | MAP_ANONYMOUS, -1, 0);
+	ASSERT_NE(MAP_FAILED, domain_stack);
+	memset(domain_stack, 0, sizeof(*domain_stack));
+
 	ruleset_fd =
 		landlock_create_ruleset(&ruleset_attr, sizeof(ruleset_attr), 0);
 	ASSERT_LE(0, ruleset_fd);
@@ -94,7 +91,7 @@ TEST_F(audit, layers)
 	child = fork();
 	ASSERT_LE(0, child);
 	if (child == 0) {
-		for (i = 0; i < ARRAY_SIZE(*self->domain_stack); i++) {
+		for (i = 0; i < ARRAY_SIZE(*domain_stack); i++) {
 			__u64 denial_dom = 1;
 			__u64 allocated_dom = 2;
 
@@ -115,7 +112,7 @@ TEST_F(audit, layers)
 			/* Checks that the new domain is younger than the previous one. */
 			EXPECT_GT(allocated_dom, prev_dom);
 			prev_dom = allocated_dom;
-			(*self->domain_stack)[i] = allocated_dom;
+			(*domain_stack)[i] = allocated_dom;
 		}
 
 		/* Checks that we reached the maximum number of layers. */
@@ -142,20 +139,20 @@ TEST_F(audit, layers)
 	/* Purges log from deallocated domains. */
 	EXPECT_EQ(0, setsockopt(self->audit_fd, SOL_SOCKET, SO_RCVTIMEO,
 				&audit_tv_dom_drop, sizeof(audit_tv_dom_drop)));
-	for (i = ARRAY_SIZE(*self->domain_stack) - 1; i >= 0; i--) {
+	for (i = ARRAY_SIZE(*domain_stack) - 1; i >= 0; i--) {
 		__u64 deallocated_dom = 2;
 
 		EXPECT_EQ(0, matches_log_domain_deallocated(self->audit_fd, 1,
 							    &deallocated_dom));
-		EXPECT_EQ((*self->domain_stack)[i], deallocated_dom)
+		EXPECT_EQ((*domain_stack)[i], deallocated_dom)
 		{
 			TH_LOG("Failed to match domain %llx (#%d)",
-			       (*self->domain_stack)[i], i);
+			       (*domain_stack)[i], i);
 		}
 	}
+	EXPECT_EQ(0, munmap(domain_stack, sizeof(*domain_stack)));
 	EXPECT_EQ(0, setsockopt(self->audit_fd, SOL_SOCKET, SO_RCVTIMEO,
 				&audit_tv_default, sizeof(audit_tv_default)));
-
 	EXPECT_EQ(0, close(ruleset_fd));
 }
 
-- 
2.49.0


