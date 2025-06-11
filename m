Return-Path: <linux-kernel+bounces-681259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21615AD505A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jun 2025 11:43:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44E243A263C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jun 2025 09:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA08B7081D;
	Wed, 11 Jun 2025 09:41:37 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA28F268C51;
	Wed, 11 Jun 2025 09:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749634897; cv=none; b=PoL3HwEY08m8tL5xlzp1tx1ZOdZHiB1Dd/0mASx1FksaDx0jdhW44fvrVsW7fl7B2vbWMk7qfArIH2jBboRSQ4vsmtw5+nySMt7vStW/Cd2mKqODGm29Adf4GBKXnqyPi8hr0FUkFnZJlPBFQeacDRT/xhjg3Y0oSJYNZhqgB04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749634897; c=relaxed/simple;
	bh=+vjLjXnyCFh5/6Oct2A+CqoksUlMz8MkZrajiNgbiw4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZtaJvvZvT7BaOntWOAsLAtIfSLZC96sj6+M3eNhBiQcGBF63iYCKpVr+nXMMCy44P/vE3FuMYHoHcKoWCY1tOZP3Mal+vdyGHn/wJHsz7YesFYVWezXLmhTWN1QIcNhX85azIg99sz7MihoCQygFtp49QZ2K5zIBF1KhCjAULxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EB5491596;
	Wed, 11 Jun 2025 02:41:14 -0700 (PDT)
Received: from e129823.cambridge.arm.com (e129823.arm.com [10.1.197.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 4A0593F59E;
	Wed, 11 Jun 2025 02:41:32 -0700 (PDT)
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
Subject: [PATCH v6 9/9] kselftest/arm64/mte: add mtefar tests on check_mmap_options
Date: Wed, 11 Jun 2025 10:41:07 +0100
Message-Id: <20250611094107.928457-10-yeoreum.yun@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250611094107.928457-1-yeoreum.yun@arm.com>
References: <20250611094107.928457-1-yeoreum.yun@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If FEAT_MTE_TAGGED_FAR (Armv8.9) is supported, bits 63:60 of the fault address
are preserved in response to synchronous tag check faults (SEGV_MTESERR).

This patch adds new test cases using address tags (bits 63:60),
corresponding to each existing test in check_mmap_option.

Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
---
 .../selftests/arm64/mte/check_mmap_options.c  | 186 ++++++++++++++++--
 1 file changed, 167 insertions(+), 19 deletions(-)

diff --git a/tools/testing/selftests/arm64/mte/check_mmap_options.c b/tools/testing/selftests/arm64/mte/check_mmap_options.c
index 0df7ce532465..046fa909de86 100644
--- a/tools/testing/selftests/arm64/mte/check_mmap_options.c
+++ b/tools/testing/selftests/arm64/mte/check_mmap_options.c
@@ -24,6 +24,8 @@
 #define OVERFLOW		MT_GRANULE_SIZE
 #define TAG_CHECK_ON		0
 #define TAG_CHECK_OFF		1
+#define ATAG_CHECK_ON		1
+#define ATAG_CHECK_OFF		0
 
 #define TEST_NAME_MAX		256
 
@@ -39,6 +41,7 @@ struct check_mmap_testcase {
 	int mte_sync;
 	int mapping;
 	int tag_check;
+	int atag_check;
 	bool enable_tco;
 };
 
@@ -48,8 +51,14 @@ static int sizes[] = {
 	/* page size - 1*/ 0, /* page_size */ 0, /* page size + 1 */ 0
 };
 
-static int check_mte_memory(char *ptr, int size, int mode, int tag_check)
+static int check_mte_memory(char *ptr, int size, int mode, int tag_check, int atag_check)
 {
+	if (!mtefar_support && atag_check == ATAG_CHECK_ON)
+		return KSFT_SKIP;
+
+	if (atag_check == ATAG_CHECK_ON)
+		ptr = mte_insert_atag(ptr);
+
 	mte_initialize_current_context(mode, (uintptr_t)ptr, size);
 	memset(ptr, '1', size);
 	mte_wait_after_trig();
@@ -75,7 +84,7 @@ static int check_mte_memory(char *ptr, int size, int mode, int tag_check)
 	return KSFT_PASS;
 }
 
-static int check_anonymous_memory_mapping(int mem_type, int mode, int mapping, int tag_check)
+static int check_anonymous_memory_mapping(int mem_type, int mode, int mapping, int tag_check, int atag_check)
 {
 	char *ptr, *map_ptr;
 	int run, result, map_size;
@@ -97,16 +106,16 @@ static int check_anonymous_memory_mapping(int mem_type, int mode, int mapping, i
 			munmap((void *)map_ptr, map_size);
 			return KSFT_FAIL;
 		}
-		result = check_mte_memory(ptr, sizes[run], mode, tag_check);
+		result = check_mte_memory(ptr, sizes[run], mode, tag_check, atag_check);
 		mte_clear_tags((void *)ptr, sizes[run]);
 		mte_free_memory((void *)map_ptr, map_size, mem_type, false);
-		if (result == KSFT_FAIL)
-			return KSFT_FAIL;
+		if (result != KSFT_SKIP)
+			return result;
 	}
 	return KSFT_PASS;
 }
 
-static int check_file_memory_mapping(int mem_type, int mode, int mapping, int tag_check)
+static int check_file_memory_mapping(int mem_type, int mode, int mapping, int tag_check, int atag_check)
 {
 	char *ptr, *map_ptr;
 	int run, fd, map_size;
@@ -135,7 +144,7 @@ static int check_file_memory_mapping(int mem_type, int mode, int mapping, int ta
 			close(fd);
 			return KSFT_FAIL;
 		}
-		result = check_mte_memory(ptr, sizes[run], mode, tag_check);
+		result = check_mte_memory(ptr, sizes[run], mode, tag_check, atag_check);
 		mte_clear_tags((void *)ptr, sizes[run]);
 		munmap((void *)map_ptr, map_size);
 		close(fd);
@@ -145,7 +154,7 @@ static int check_file_memory_mapping(int mem_type, int mode, int mapping, int ta
 	return result;
 }
 
-static int check_clear_prot_mte_flag(int mem_type, int mode, int mapping)
+static int check_clear_prot_mte_flag(int mem_type, int mode, int mapping, int atag_check)
 {
 	char *ptr, *map_ptr;
 	int run, prot_flag, result, fd, map_size;
@@ -168,7 +177,7 @@ static int check_clear_prot_mte_flag(int mem_type, int mode, int mapping)
 			ksft_print_msg("FAIL: mprotect not ignoring clear PROT_MTE property\n");
 			return KSFT_FAIL;
 		}
-		result = check_mte_memory(ptr, sizes[run], mode, TAG_CHECK_ON);
+		result = check_mte_memory(ptr, sizes[run], mode, TAG_CHECK_ON, atag_check);
 		mte_free_memory_tag_range((void *)ptr, sizes[run], mem_type, UNDERFLOW, OVERFLOW);
 		if (result != KSFT_PASS)
 			return KSFT_FAIL;
@@ -192,7 +201,7 @@ static int check_clear_prot_mte_flag(int mem_type, int mode, int mapping)
 			close(fd);
 			return KSFT_FAIL;
 		}
-		result = check_mte_memory(ptr, sizes[run], mode, TAG_CHECK_ON);
+		result = check_mte_memory(ptr, sizes[run], mode, TAG_CHECK_ON, atag_check);
 		mte_free_memory_tag_range((void *)ptr, sizes[run], mem_type, UNDERFLOW, OVERFLOW);
 		close(fd);
 		if (result != KSFT_PASS)
@@ -209,6 +218,7 @@ const char *format_test_name(struct check_mmap_testcase *tc)
 	const char *sync_str;
 	const char *mapping_str;
 	const char *tag_check_str;
+	const char *atag_check_str;
 
 	switch (tc->check_type) {
 	case CHECK_ANON_MEM:
@@ -276,10 +286,22 @@ const char *format_test_name(struct check_mmap_testcase *tc)
 		break;
 	}
 
+	switch (tc->atag_check) {
+	case ATAG_CHECK_ON:
+		atag_check_str = "with address tag [63:60]";
+		break;
+	case ATAG_CHECK_OFF:
+		atag_check_str = "without address tag [63:60]";
+		break;
+	default:
+		assert(0);
+		break;
+	}
+
 	snprintf(test_name, sizeof(test_name),
-	         "Check %s with %s mapping, %s mode, %s memory and %s\n",
+	         "Check %s with %s mapping, %s mode, %s memory and %s (%s)\n",
 	         check_type_str, mapping_str, sync_str, mem_type_str,
-	         tag_check_str);
+	         tag_check_str, atag_check_str);
 
 	return test_name;
 }
@@ -295,6 +317,7 @@ int main(int argc, char *argv[])
 			.mte_sync = MTE_SYNC_ERR,
 			.mapping = MAP_PRIVATE,
 			.tag_check = TAG_CHECK_OFF,
+			.atag_check = ATAG_CHECK_OFF,
 			.enable_tco = true,
 		},
 		{
@@ -303,6 +326,7 @@ int main(int argc, char *argv[])
 			.mte_sync = MTE_SYNC_ERR,
 			.mapping = MAP_PRIVATE,
 			.tag_check = TAG_CHECK_OFF,
+			.atag_check = ATAG_CHECK_OFF,
 			.enable_tco = true,
 		},
 		{
@@ -311,6 +335,7 @@ int main(int argc, char *argv[])
 			.mte_sync = MTE_NONE_ERR,
 			.mapping = MAP_PRIVATE,
 			.tag_check = TAG_CHECK_OFF,
+			.atag_check = ATAG_CHECK_OFF,
 			.enable_tco = false,
 		},
 		{
@@ -319,6 +344,7 @@ int main(int argc, char *argv[])
 			.mte_sync = MTE_NONE_ERR,
 			.mapping = MAP_PRIVATE,
 			.tag_check = TAG_CHECK_OFF,
+			.atag_check = ATAG_CHECK_OFF,
 			.enable_tco = false,
 		},
 		{
@@ -327,6 +353,7 @@ int main(int argc, char *argv[])
 			.mte_sync = MTE_SYNC_ERR,
 			.mapping = MAP_PRIVATE,
 			.tag_check = TAG_CHECK_ON,
+			.atag_check = ATAG_CHECK_OFF,
 			.enable_tco = false,
 		},
 		{
@@ -335,6 +362,7 @@ int main(int argc, char *argv[])
 			.mte_sync = MTE_SYNC_ERR,
 			.mapping = MAP_PRIVATE,
 			.tag_check = TAG_CHECK_ON,
+			.atag_check = ATAG_CHECK_OFF,
 			.enable_tco = false,
 		},
 		{
@@ -343,6 +371,7 @@ int main(int argc, char *argv[])
 			.mte_sync = MTE_SYNC_ERR,
 			.mapping = MAP_SHARED,
 			.tag_check = TAG_CHECK_ON,
+			.atag_check = ATAG_CHECK_OFF,
 			.enable_tco = false,
 		},
 		{
@@ -351,6 +380,7 @@ int main(int argc, char *argv[])
 			.mte_sync = MTE_SYNC_ERR,
 			.mapping = MAP_SHARED,
 			.tag_check = TAG_CHECK_ON,
+			.atag_check = ATAG_CHECK_OFF,
 			.enable_tco = false,
 		},
 		{
@@ -359,6 +389,7 @@ int main(int argc, char *argv[])
 			.mte_sync = MTE_ASYNC_ERR,
 			.mapping = MAP_PRIVATE,
 			.tag_check = TAG_CHECK_ON,
+			.atag_check = ATAG_CHECK_OFF,
 			.enable_tco = false,
 		},
 		{
@@ -367,6 +398,7 @@ int main(int argc, char *argv[])
 			.mte_sync = MTE_ASYNC_ERR,
 			.mapping = MAP_PRIVATE,
 			.tag_check = TAG_CHECK_ON,
+			.atag_check = ATAG_CHECK_OFF,
 			.enable_tco = false,
 		},
 		{
@@ -375,6 +407,7 @@ int main(int argc, char *argv[])
 			.mte_sync = MTE_ASYNC_ERR,
 			.mapping = MAP_SHARED,
 			.tag_check = TAG_CHECK_ON,
+			.atag_check = ATAG_CHECK_OFF,
 			.enable_tco = false,
 		},
 		{
@@ -383,6 +416,7 @@ int main(int argc, char *argv[])
 			.mte_sync = MTE_ASYNC_ERR,
 			.mapping = MAP_SHARED,
 			.tag_check = TAG_CHECK_ON,
+			.atag_check = ATAG_CHECK_OFF,
 			.enable_tco = false,
 		},
 		{
@@ -391,6 +425,7 @@ int main(int argc, char *argv[])
 			.mte_sync = MTE_SYNC_ERR,
 			.mapping = MAP_PRIVATE,
 			.tag_check = TAG_CHECK_ON,
+			.atag_check = ATAG_CHECK_OFF,
 			.enable_tco = false,
 		},
 		{
@@ -399,6 +434,7 @@ int main(int argc, char *argv[])
 			.mte_sync = MTE_SYNC_ERR,
 			.mapping = MAP_PRIVATE,
 			.tag_check = TAG_CHECK_ON,
+			.atag_check = ATAG_CHECK_OFF,
 			.enable_tco = false,
 		},
 		{
@@ -407,6 +443,7 @@ int main(int argc, char *argv[])
 			.mte_sync = MTE_SYNC_ERR,
 			.mapping = MAP_SHARED,
 			.tag_check = TAG_CHECK_ON,
+			.atag_check = ATAG_CHECK_OFF,
 			.enable_tco = false,
 		},
 		{
@@ -415,6 +452,7 @@ int main(int argc, char *argv[])
 			.mte_sync = MTE_SYNC_ERR,
 			.mapping = MAP_SHARED,
 			.tag_check = TAG_CHECK_ON,
+			.atag_check = ATAG_CHECK_OFF,
 			.enable_tco = false,
 		},
 		{
@@ -423,6 +461,7 @@ int main(int argc, char *argv[])
 			.mte_sync = MTE_ASYNC_ERR,
 			.mapping = MAP_PRIVATE,
 			.tag_check = TAG_CHECK_ON,
+			.atag_check = ATAG_CHECK_OFF,
 			.enable_tco = false,
 		},
 		{
@@ -431,6 +470,7 @@ int main(int argc, char *argv[])
 			.mte_sync = MTE_ASYNC_ERR,
 			.mapping = MAP_PRIVATE,
 			.tag_check = TAG_CHECK_ON,
+			.atag_check = ATAG_CHECK_OFF,
 			.enable_tco = false,
 		},
 		{
@@ -439,6 +479,7 @@ int main(int argc, char *argv[])
 			.mte_sync = MTE_ASYNC_ERR,
 			.mapping = MAP_SHARED,
 			.tag_check = TAG_CHECK_ON,
+			.atag_check = ATAG_CHECK_OFF,
 			.enable_tco = false,
 		},
 		{
@@ -447,6 +488,106 @@ int main(int argc, char *argv[])
 			.mte_sync = MTE_ASYNC_ERR,
 			.mapping = MAP_SHARED,
 			.tag_check = TAG_CHECK_ON,
+			.atag_check = ATAG_CHECK_OFF,
+			.enable_tco = false,
+		},
+		{
+			.check_type = CHECK_CLEAR_PROT_MTE,
+			.mem_type = USE_MMAP,
+			.mte_sync = MTE_SYNC_ERR,
+			.mapping = MAP_PRIVATE,
+			.tag_check = TAG_CHECK_ON,
+			.atag_check = ATAG_CHECK_OFF,
+			.enable_tco = false,
+		},
+		{
+			.check_type = CHECK_CLEAR_PROT_MTE,
+			.mem_type = USE_MPROTECT,
+			.mte_sync = MTE_SYNC_ERR,
+			.mapping = MAP_PRIVATE,
+			.tag_check = TAG_CHECK_ON,
+			.atag_check = ATAG_CHECK_OFF,
+			.enable_tco = false,
+		},
+		{
+			.check_type = CHECK_ANON_MEM,
+			.mem_type = USE_MMAP,
+			.mte_sync = MTE_SYNC_ERR,
+			.mapping = MAP_PRIVATE,
+			.tag_check = TAG_CHECK_ON,
+			.atag_check = ATAG_CHECK_ON,
+			.enable_tco = false,
+		},
+		{
+			.check_type = CHECK_ANON_MEM,
+			.mem_type = USE_MPROTECT,
+			.mte_sync = MTE_SYNC_ERR,
+			.mapping = MAP_PRIVATE,
+			.tag_check = TAG_CHECK_ON,
+			.atag_check = ATAG_CHECK_ON,
+			.enable_tco = false,
+		},
+		{
+			.check_type = CHECK_ANON_MEM,
+			.mem_type = USE_MMAP,
+			.mte_sync = MTE_SYNC_ERR,
+			.mapping = MAP_SHARED,
+			.tag_check = TAG_CHECK_ON,
+			.atag_check = ATAG_CHECK_ON,
+			.enable_tco = false,
+		},
+		{
+			.check_type = CHECK_ANON_MEM,
+			.mem_type = USE_MPROTECT,
+			.mte_sync = MTE_SYNC_ERR,
+			.mapping = MAP_SHARED,
+			.tag_check = TAG_CHECK_ON,
+			.atag_check = ATAG_CHECK_ON,
+			.enable_tco = false,
+		},
+		{
+			.check_type = CHECK_FILE_MEM,
+			.mem_type = USE_MMAP,
+			.mte_sync = MTE_SYNC_ERR,
+			.mapping = MAP_PRIVATE,
+			.tag_check = TAG_CHECK_ON,
+			.atag_check = ATAG_CHECK_ON,
+			.enable_tco = false,
+		},
+		{
+			.check_type = CHECK_FILE_MEM,
+			.mem_type = USE_MPROTECT,
+			.mte_sync = MTE_SYNC_ERR,
+			.mapping = MAP_PRIVATE,
+			.tag_check = TAG_CHECK_ON,
+			.atag_check = ATAG_CHECK_ON,
+			.enable_tco = false,
+		},
+		{
+			.check_type = CHECK_FILE_MEM,
+			.mem_type = USE_MMAP,
+			.mte_sync = MTE_SYNC_ERR,
+			.mapping = MAP_SHARED,
+			.tag_check = TAG_CHECK_ON,
+			.atag_check = ATAG_CHECK_ON,
+			.enable_tco = false,
+		},
+		{
+			.check_type = CHECK_FILE_MEM,
+			.mem_type = USE_MPROTECT,
+			.mte_sync = MTE_SYNC_ERR,
+			.mapping = MAP_SHARED,
+			.tag_check = TAG_CHECK_ON,
+			.atag_check = ATAG_CHECK_ON,
+			.enable_tco = false,
+		},
+		{
+			.check_type = CHECK_FILE_MEM,
+			.mem_type = USE_MMAP,
+			.mte_sync = MTE_ASYNC_ERR,
+			.mapping = MAP_PRIVATE,
+			.tag_check = TAG_CHECK_ON,
+			.atag_check = ATAG_CHECK_ON,
 			.enable_tco = false,
 		},
 		{
@@ -455,6 +596,7 @@ int main(int argc, char *argv[])
 			.mte_sync = MTE_SYNC_ERR,
 			.mapping = MAP_PRIVATE,
 			.tag_check = TAG_CHECK_ON,
+			.atag_check = ATAG_CHECK_ON,
 			.enable_tco = false,
 		},
 		{
@@ -463,6 +605,7 @@ int main(int argc, char *argv[])
 			.mte_sync = MTE_SYNC_ERR,
 			.mapping = MAP_PRIVATE,
 			.tag_check = TAG_CHECK_ON,
+			.atag_check = ATAG_CHECK_ON,
 			.enable_tco = false,
 		},
 	};
@@ -479,14 +622,16 @@ int main(int argc, char *argv[])
 	sizes[item - 2] = page_size;
 	sizes[item - 1] = page_size + 1;
 
-	/* Register signal handlers */
-	mte_register_signal(SIGBUS, mte_default_handler, false);
-	mte_register_signal(SIGSEGV, mte_default_handler, false);
-
 	/* Set test plan */
 	ksft_set_plan(ARRAY_SIZE(test_cases));
 
 	for (i = 0 ; i < ARRAY_SIZE(test_cases); i++) {
+		/* Register signal handlers */
+		mte_register_signal(SIGBUS, mte_default_handler,
+				    test_cases[i].atag_check == ATAG_CHECK_ON);
+		mte_register_signal(SIGSEGV, mte_default_handler,
+				    test_cases[i].atag_check == ATAG_CHECK_ON);
+
 		if (test_cases[i].enable_tco)
 			mte_enable_pstate_tco();
 		else
@@ -497,20 +642,23 @@ int main(int argc, char *argv[])
 			evaluate_test(check_anonymous_memory_mapping(test_cases[i].mem_type,
 								     test_cases[i].mte_sync,
 								     test_cases[i].mapping,
-								     test_cases[i].tag_check),
+								     test_cases[i].tag_check,
+								     test_cases[i].atag_check),
 				      format_test_name(&test_cases[i]));
 			break;
 		case CHECK_FILE_MEM:
 			evaluate_test(check_file_memory_mapping(test_cases[i].mem_type,
 							        test_cases[i].mte_sync,
 							        test_cases[i].mapping,
-							        test_cases[i].tag_check),
+							        test_cases[i].tag_check,
+							        test_cases[i].atag_check),
 				      format_test_name(&test_cases[i]));
 			break;
 		case CHECK_CLEAR_PROT_MTE:
 			evaluate_test(check_clear_prot_mte_flag(test_cases[i].mem_type,
 							        test_cases[i].mte_sync,
-							        test_cases[i].mapping),
+							        test_cases[i].mapping,
+							        test_cases[i].atag_check),
 				      format_test_name(&test_cases[i]));
 			break;
 		default:
-- 
LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}


