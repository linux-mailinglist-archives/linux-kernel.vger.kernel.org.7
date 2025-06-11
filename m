Return-Path: <linux-kernel+bounces-681829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E08F5AD57D2
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jun 2025 16:01:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4814E1E09E4
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jun 2025 14:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BCA72BEC2A;
	Wed, 11 Jun 2025 13:58:37 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DD502BE7D6;
	Wed, 11 Jun 2025 13:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749650317; cv=none; b=VpQDxjn0FIjZwfB1svHNla6ha/894r9AFv+5mtWIjMNDNs74JiB4ARFyQSDB6/EkCAYKlFHKClFlLwOzQ7xVex2Iybjf3BATCvGKl3bVDqmXANvWOAEdtFTj6MExkh9//+8bFQ9pLRzm22nJAeJkWvtsBFBawC4fgloCEhCsHSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749650317; c=relaxed/simple;
	bh=2k+/Ki0NTtqVgGnbH15IcLWubCSrgd5KKXBaHhocAUg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ECNNL2SNIIvWxBGCmx2qS/Fp4J3NaUBxOg6DHlxb9VjKMcfgLlh0avNFq9+v6dM+vN4L+oHi6IPTdUfwCEYWsY1cqFK9F7PoYRIJ4O7njnC39tG7I1boUt1dp+/ITdgt5Usj2BGnxceMbsK5B+ofa2xnf23TK21TyY8zVj6WXmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EE4B51688;
	Wed, 11 Jun 2025 06:58:14 -0700 (PDT)
Received: from e129823.cambridge.arm.com (e129823.arm.com [10.1.197.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 5498D3F673;
	Wed, 11 Jun 2025 06:58:32 -0700 (PDT)
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: catalin.marinas@arm.com,
	pcc@google.com,
	will@kernel.org,
	broonie@kernel.org,
	anshuman.khandual@arm.com,
	joey.gouly@arm.com,
	yury.khrustalev@arm.com,
	maz@kernel.org,
	oliver.upton@linux.dev,
	frederic@kernel.org,
	akpm@linux-foundation.org,
	surenb@google.com
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Yeoreum Yun <yeoreum.yun@arm.com>
Subject: [PATCH v7 4/9] kselftest/arm64/mte: register mte signal handler with SA_EXPOSE_TAGBITS
Date: Wed, 11 Jun 2025 14:58:13 +0100
Message-Id: <20250611135818.31070-5-yeoreum.yun@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250611135818.31070-1-yeoreum.yun@arm.com>
References: <20250611135818.31070-1-yeoreum.yun@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To test address tag[63:60] and memory tag[59:56] is preserved
when memory tag fault happen, Let mte_register_signal() to register
signal handler with SA_EXPOSE_TAGBITS.

Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
Reviewed-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/arm64/mte/check_buffer_fill.c |  2 +-
 .../testing/selftests/arm64/mte/check_child_memory.c  |  4 ++--
 .../selftests/arm64/mte/check_hugetlb_options.c       |  4 ++--
 tools/testing/selftests/arm64/mte/check_ksm_options.c |  4 ++--
 .../testing/selftests/arm64/mte/check_mmap_options.c  |  4 ++--
 .../selftests/arm64/mte/check_tags_inclusion.c        |  2 +-
 tools/testing/selftests/arm64/mte/check_user_mem.c    |  2 +-
 tools/testing/selftests/arm64/mte/mte_common_util.c   | 11 ++++++++++-
 tools/testing/selftests/arm64/mte/mte_common_util.h   |  3 ++-
 9 files changed, 23 insertions(+), 13 deletions(-)

diff --git a/tools/testing/selftests/arm64/mte/check_buffer_fill.c b/tools/testing/selftests/arm64/mte/check_buffer_fill.c
index 2ee7f114d7fa..5248b5265aa4 100644
--- a/tools/testing/selftests/arm64/mte/check_buffer_fill.c
+++ b/tools/testing/selftests/arm64/mte/check_buffer_fill.c
@@ -415,7 +415,7 @@ int main(int argc, char *argv[])
 		return err;
 
 	/* Register SIGSEGV handler */
-	mte_register_signal(SIGSEGV, mte_default_handler);
+	mte_register_signal(SIGSEGV, mte_default_handler, false);
 
 	/* Set test plan */
 	ksft_set_plan(20);
diff --git a/tools/testing/selftests/arm64/mte/check_child_memory.c b/tools/testing/selftests/arm64/mte/check_child_memory.c
index 7597fc632cad..b97ea3981c21 100644
--- a/tools/testing/selftests/arm64/mte/check_child_memory.c
+++ b/tools/testing/selftests/arm64/mte/check_child_memory.c
@@ -160,8 +160,8 @@ int main(int argc, char *argv[])
 		return err;
 
 	/* Register SIGSEGV handler */
-	mte_register_signal(SIGSEGV, mte_default_handler);
-	mte_register_signal(SIGBUS, mte_default_handler);
+	mte_register_signal(SIGSEGV, mte_default_handler, false);
+	mte_register_signal(SIGBUS, mte_default_handler, false);
 
 	/* Set test plan */
 	ksft_set_plan(12);
diff --git a/tools/testing/selftests/arm64/mte/check_hugetlb_options.c b/tools/testing/selftests/arm64/mte/check_hugetlb_options.c
index 3bfcd3848432..4e644a606394 100644
--- a/tools/testing/selftests/arm64/mte/check_hugetlb_options.c
+++ b/tools/testing/selftests/arm64/mte/check_hugetlb_options.c
@@ -235,8 +235,8 @@ int main(int argc, char *argv[])
 		return err;
 
 	/* Register signal handlers */
-	mte_register_signal(SIGBUS, mte_default_handler);
-	mte_register_signal(SIGSEGV, mte_default_handler);
+	mte_register_signal(SIGBUS, mte_default_handler, false);
+	mte_register_signal(SIGSEGV, mte_default_handler, false);
 
 	allocate_hugetlb();
 
diff --git a/tools/testing/selftests/arm64/mte/check_ksm_options.c b/tools/testing/selftests/arm64/mte/check_ksm_options.c
index 88c74bc46d4f..afea4e381862 100644
--- a/tools/testing/selftests/arm64/mte/check_ksm_options.c
+++ b/tools/testing/selftests/arm64/mte/check_ksm_options.c
@@ -141,8 +141,8 @@ int main(int argc, char *argv[])
 		return KSFT_FAIL;
 	}
 	/* Register signal handlers */
-	mte_register_signal(SIGBUS, mte_default_handler);
-	mte_register_signal(SIGSEGV, mte_default_handler);
+	mte_register_signal(SIGBUS, mte_default_handler, false);
+	mte_register_signal(SIGSEGV, mte_default_handler, false);
 
 	/* Set test plan */
 	ksft_set_plan(4);
diff --git a/tools/testing/selftests/arm64/mte/check_mmap_options.c b/tools/testing/selftests/arm64/mte/check_mmap_options.c
index 17694caaff53..b37bf481c9f9 100644
--- a/tools/testing/selftests/arm64/mte/check_mmap_options.c
+++ b/tools/testing/selftests/arm64/mte/check_mmap_options.c
@@ -201,8 +201,8 @@ int main(int argc, char *argv[])
 	sizes[item - 1] = page_size + 1;
 
 	/* Register signal handlers */
-	mte_register_signal(SIGBUS, mte_default_handler);
-	mte_register_signal(SIGSEGV, mte_default_handler);
+	mte_register_signal(SIGBUS, mte_default_handler, false);
+	mte_register_signal(SIGSEGV, mte_default_handler, false);
 
 	/* Set test plan */
 	ksft_set_plan(22);
diff --git a/tools/testing/selftests/arm64/mte/check_tags_inclusion.c b/tools/testing/selftests/arm64/mte/check_tags_inclusion.c
index a3d1e23fe02a..b96296ab9870 100644
--- a/tools/testing/selftests/arm64/mte/check_tags_inclusion.c
+++ b/tools/testing/selftests/arm64/mte/check_tags_inclusion.c
@@ -180,7 +180,7 @@ int main(int argc, char *argv[])
 		return err;
 
 	/* Register SIGSEGV handler */
-	mte_register_signal(SIGSEGV, mte_default_handler);
+	mte_register_signal(SIGSEGV, mte_default_handler, false);
 
 	/* Set test plan */
 	ksft_set_plan(4);
diff --git a/tools/testing/selftests/arm64/mte/check_user_mem.c b/tools/testing/selftests/arm64/mte/check_user_mem.c
index f4ae5f87a3b7..d1d14aaaba16 100644
--- a/tools/testing/selftests/arm64/mte/check_user_mem.c
+++ b/tools/testing/selftests/arm64/mte/check_user_mem.c
@@ -211,7 +211,7 @@ int main(int argc, char *argv[])
 		return err;
 
 	/* Register signal handlers */
-	mte_register_signal(SIGSEGV, mte_default_handler);
+	mte_register_signal(SIGSEGV, mte_default_handler, false);
 
 	/* Set test plan */
 	ksft_set_plan(64);
diff --git a/tools/testing/selftests/arm64/mte/mte_common_util.c b/tools/testing/selftests/arm64/mte/mte_common_util.c
index a1dc2fe5285b..83240b980f9c 100644
--- a/tools/testing/selftests/arm64/mte/mte_common_util.c
+++ b/tools/testing/selftests/arm64/mte/mte_common_util.c
@@ -19,6 +19,10 @@
 #include "mte_common_util.h"
 #include "mte_def.h"
 
+#ifndef SA_EXPOSE_TAGBITS
+#define SA_EXPOSE_TAGBITS 0x00000800
+#endif
+
 #define INIT_BUFFER_SIZE       256
 
 struct mte_fault_cxt cur_mte_cxt;
@@ -79,12 +83,17 @@ void mte_default_handler(int signum, siginfo_t *si, void *uc)
 	}
 }
 
-void mte_register_signal(int signal, void (*handler)(int, siginfo_t *, void *))
+void mte_register_signal(int signal, void (*handler)(int, siginfo_t *, void *),
+			 bool export_tags)
 {
 	struct sigaction sa;
 
 	sa.sa_sigaction = handler;
 	sa.sa_flags = SA_SIGINFO;
+
+	if (export_tags && signal == SIGSEGV)
+		sa.sa_flags |= SA_EXPOSE_TAGBITS;
+
 	sigemptyset(&sa.sa_mask);
 	sigaction(signal, &sa, NULL);
 }
diff --git a/tools/testing/selftests/arm64/mte/mte_common_util.h b/tools/testing/selftests/arm64/mte/mte_common_util.h
index a0017a303beb..6b109e84fa39 100644
--- a/tools/testing/selftests/arm64/mte/mte_common_util.h
+++ b/tools/testing/selftests/arm64/mte/mte_common_util.h
@@ -40,7 +40,8 @@ extern struct mte_fault_cxt cur_mte_cxt;
 
 /* MTE utility functions */
 void mte_default_handler(int signum, siginfo_t *si, void *uc);
-void mte_register_signal(int signal, void (*handler)(int, siginfo_t *, void *));
+void mte_register_signal(int signal, void (*handler)(int, siginfo_t *, void *),
+			 bool export_tags);
 void mte_wait_after_trig(void);
 void *mte_allocate_memory(size_t size, int mem_type, int mapping, bool tags);
 void *mte_allocate_memory_tag_range(size_t size, int mem_type, int mapping,
-- 
LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}


