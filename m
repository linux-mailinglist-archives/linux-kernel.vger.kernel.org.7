Return-Path: <linux-kernel+bounces-777278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A331B2D7B1
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 11:14:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57DD5188997D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 09:11:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B632D2DAFC0;
	Wed, 20 Aug 2025 09:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="dRby7plr"
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB132E041D
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 09:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755680875; cv=none; b=gLLS3M3AiCih3tF4jRxxjwQqLXwDXUObw6JfEX/n1qyTvWPmchW9PtpbudRuQ7jvTGwewgOMRRE5vnw2nZ5mFlx8rl+1hiPavL4h1EPfZzLwUT2A5nVD7/vuMuO8EhjsYxawJbEixCBTonned8aiZSKruQYHAxt0nwb086yr37Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755680875; c=relaxed/simple;
	bh=aTMxy3Xrqz4tk/drzT/gt7H8OVCROcA5+hi4Rqj/Rbw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LDPh5vYqjiy8dB29PCQxY3SlmvzPbuQnWxQfQXhkHDPQh25GnZSmzFX3KgNLKmEWO9CkGbOwBq+FwIaIQMDrIskQjTz2K3ZIa5OaACeqBcDuBphOTGefwfAl5+/ir07RG3u/3KV8SMdbrSi+0DiwpNHKhY+SHgpebB7RxrvoY5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=dRby7plr; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1755680869; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=lvI4x2iIQB1VP2FwvPVI+Ftp5i1v0UQgsUVTdBGrP/g=;
	b=dRby7plrMJPfhpilHGUKLliIM5LYudrd6fvBN5tezFpwZucv0j1gY57gwJ0pqIwYdHr4IbhlEatOF5+NbPzWwxUmttq84bRg3xD2b/GQM+OFmmItNoetydEADhFzshZv1xEVoY3Y1vwOeHJtdaaIpqBYxARIAQv+17xbFS/SiDE=
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WmBICwN_1755680868 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 20 Aug 2025 17:07:48 +0800
From: Baolin Wang <baolin.wang@linux.alibaba.com>
To: akpm@linux-foundation.org,
	hughd@google.com,
	david@redhat.com,
	lorenzo.stoakes@oracle.com
Cc: ziy@nvidia.com,
	Liam.Howlett@oracle.com,
	npache@redhat.com,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	baohua@kernel.org,
	baolin.wang@linux.alibaba.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 11/11] selftests: mm: add mTHP collapse test cases
Date: Wed, 20 Aug 2025 17:07:22 +0800
Message-ID: <e364feceb95917f569d5c0b36289788fcab45e24.1755677674.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <cover.1755677674.git.baolin.wang@linux.alibaba.com>
References: <cover.1755677674.git.baolin.wang@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add mTHP collapse test cases.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 tools/testing/selftests/mm/khugepaged.c   | 102 +++++++++++++++++++---
 tools/testing/selftests/mm/run_vmtests.sh |   4 +
 2 files changed, 92 insertions(+), 14 deletions(-)

diff --git a/tools/testing/selftests/mm/khugepaged.c b/tools/testing/selftests/mm/khugepaged.c
index e529074a1fdf..f7081e9e20ec 100644
--- a/tools/testing/selftests/mm/khugepaged.c
+++ b/tools/testing/selftests/mm/khugepaged.c
@@ -26,9 +26,11 @@
 
 #define BASE_ADDR ((void *)(1UL << 30))
 static unsigned long hpage_pmd_size;
+static int hpage_pmd_order;
 static unsigned long page_size;
 static int hpage_pmd_nr;
 static int anon_order;
+static int collapse_order;
 
 #define PID_SMAPS "/proc/self/smaps"
 #define TEST_FILE "collapse_test_file"
@@ -61,6 +63,7 @@ struct collapse_context {
 };
 
 static struct collapse_context *khugepaged_context;
+static struct collapse_context *mthp_khugepaged_context;
 static struct collapse_context *madvise_context;
 
 struct file_info {
@@ -538,26 +541,27 @@ static void madvise_collapse(const char *msg, char *p, int nr_hpages,
 
 #define TICK 500000
 static bool wait_for_scan(const char *msg, char *p, int nr_hpages,
-			  struct mem_ops *ops)
+			  int collap_order, struct mem_ops *ops)
 {
-	unsigned long size = nr_hpages * hpage_pmd_size;
+	unsigned long hpage_size = page_size << collap_order;
+	unsigned long size = nr_hpages * hpage_size;
 	int full_scans;
 	int timeout = 6; /* 3 seconds */
 
 	/* Sanity check */
-	if (!ops->check_huge(p, size, 0, hpage_pmd_size)) {
+	if (!ops->check_huge(p, size, 0, hpage_size)) {
 		printf("Unexpected huge page\n");
 		exit(EXIT_FAILURE);
 	}
 
-	madvise(p, nr_hpages * hpage_pmd_size, MADV_HUGEPAGE);
+	madvise(p, size, MADV_HUGEPAGE);
 
 	/* Wait until the second full_scan completed */
 	full_scans = thp_read_num("khugepaged/full_scans") + 2;
 
 	printf("%s...", msg);
 	while (timeout--) {
-		if (ops->check_huge(p, size, nr_hpages, hpage_pmd_size))
+		if (ops->check_huge(p, size, nr_hpages, hpage_size))
 			break;
 		if (thp_read_num("khugepaged/full_scans") >= full_scans)
 			break;
@@ -573,7 +577,7 @@ static void khugepaged_collapse(const char *msg, char *p, int nr_hpages,
 {
 	unsigned long size = nr_hpages * hpage_pmd_size;
 
-	if (wait_for_scan(msg, p, nr_hpages, ops)) {
+	if (wait_for_scan(msg, p, nr_hpages, hpage_pmd_order, ops)) {
 		if (expect)
 			fail("Timeout");
 		else
@@ -595,12 +599,66 @@ static void khugepaged_collapse(const char *msg, char *p, int nr_hpages,
 		fail("Fail");
 }
 
+static void mthp_khugepaged_collapse(const char *msg, char *p, int nr_hpages,
+				struct mem_ops *ops, bool expect)
+{
+	unsigned long hpage_size = page_size << collapse_order;
+	unsigned long size = nr_hpages * hpage_pmd_size;
+	struct thp_settings settings = *thp_current_settings();
+
+	nr_hpages = size / hpage_size;
+
+	/* Set mTHP setting for mTHP collapse */
+	if (ops == &__anon_ops) {
+		settings.thp_enabled = THP_NEVER;
+		settings.hugepages[collapse_order].enabled = THP_ALWAYS;
+	} else if (ops == &__shmem_ops) {
+		settings.shmem_enabled = SHMEM_NEVER;
+		settings.shmem_hugepages[collapse_order].enabled = SHMEM_ALWAYS;
+	}
+
+	thp_push_settings(&settings);
+
+	if (wait_for_scan(msg, p, nr_hpages, collapse_order, ops)) {
+		if (expect)
+			fail("Timeout");
+		else
+			success("OK");
+
+		/* Restore THP settings for mTHP collapse. */
+		thp_pop_settings();
+		return;
+	}
+
+	/*
+	 * For file and shmem memory, khugepaged only retracts pte entries after
+	 * putting the new hugepage in the page cache. The hugepage must be
+	 * subsequently refaulted to install the pmd mapping for the mm.
+	 */
+	if (ops != &__anon_ops)
+		ops->fault(p, 0, size);
+
+	if (ops->check_huge(p, size, expect ? (size / hpage_size) : 0, hpage_size))
+		success("OK");
+	else
+		fail("Fail");
+
+	/* Restore THP settings for mTHP collapse. */
+	thp_pop_settings();
+}
+
 static struct collapse_context __khugepaged_context = {
 	.collapse = &khugepaged_collapse,
 	.enforce_pte_scan_limits = true,
 	.name = "khugepaged",
 };
 
+static struct collapse_context __mthp_khugepaged_context = {
+	.collapse = &mthp_khugepaged_collapse,
+	.enforce_pte_scan_limits = true,
+	.name = "mthp_khugepaged",
+};
+
 static struct collapse_context __madvise_context = {
 	.collapse = &madvise_collapse,
 	.enforce_pte_scan_limits = false,
@@ -650,6 +708,12 @@ static void collapse_full(struct collapse_context *c, struct mem_ops *ops)
 	int nr_hpages = 4;
 	unsigned long size = nr_hpages * hpage_pmd_size;
 
+	/* Only try 1 PMD sized range for mTHP collapse. */
+	if (c == &__mthp_khugepaged_context) {
+		nr_hpages = 1;
+		size = hpage_pmd_size;
+	}
+
 	p = ops->setup_area(nr_hpages);
 	ops->fault(p, 0, size);
 	c->collapse("Collapse multiple fully populated PTE table", p, nr_hpages,
@@ -1074,7 +1138,7 @@ static void madvise_retracted_page_tables(struct collapse_context *c,
 
 	/* Let khugepaged collapse and leave pmd cleared */
 	if (wait_for_scan("Collapse and leave PMD cleared", p, nr_hpages,
-			  ops)) {
+			  hpage_pmd_order, ops)) {
 		fail("Timeout");
 		return;
 	}
@@ -1089,7 +1153,7 @@ static void usage(void)
 {
 	fprintf(stderr, "\nUsage: ./khugepaged [OPTIONS] <test type> [dir]\n\n");
 	fprintf(stderr, "\t<test type>\t: <context>:<mem_type>\n");
-	fprintf(stderr, "\t<context>\t: [all|khugepaged|madvise]\n");
+	fprintf(stderr, "\t<context>\t: [all|khugepaged|mthp_khugepaged|madvise]\n");
 	fprintf(stderr, "\t<mem_type>\t: [all|anon|file|shmem]\n");
 	fprintf(stderr, "\n\t\"file,all\" mem_type requires [dir] argument\n");
 	fprintf(stderr, "\n\t\"file,all\" mem_type requires kernel built with\n");
@@ -1100,6 +1164,7 @@ static void usage(void)
 	fprintf(stderr,	"\t\t-h: This help message.\n");
 	fprintf(stderr,	"\t\t-s: mTHP size, expressed as page order.\n");
 	fprintf(stderr,	"\t\t    Defaults to 0. Use this size for anon or shmem allocations.\n");
+	fprintf(stderr,	"\t\t-c: collapse order for mTHP collapse, expressed as page order.\n");
 	exit(1);
 }
 
@@ -1109,11 +1174,14 @@ static void parse_test_type(int argc, char **argv)
 	char *buf;
 	const char *token;
 
-	while ((opt = getopt(argc, argv, "s:h")) != -1) {
+	while ((opt = getopt(argc, argv, "s:c:h")) != -1) {
 		switch (opt) {
 		case 's':
 			anon_order = atoi(optarg);
 			break;
+		case 'c':
+			collapse_order = atoi(optarg);
+			break;
 		case 'h':
 		default:
 			usage();
@@ -1139,6 +1207,10 @@ static void parse_test_type(int argc, char **argv)
 		madvise_context =  &__madvise_context;
 	} else if (!strcmp(token, "khugepaged")) {
 		khugepaged_context =  &__khugepaged_context;
+	} else if (!strcmp(token, "mthp_khugepaged")) {
+		mthp_khugepaged_context =  &__mthp_khugepaged_context;
+		if (collapse_order == 0 || collapse_order >= hpage_pmd_order)
+			usage();
 	} else if (!strcmp(token, "madvise")) {
 		madvise_context =  &__madvise_context;
 	} else {
@@ -1173,7 +1245,6 @@ static void parse_test_type(int argc, char **argv)
 
 int main(int argc, char **argv)
 {
-	int hpage_pmd_order;
 	struct thp_settings default_settings = {
 		.thp_enabled = THP_MADVISE,
 		.thp_defrag = THP_DEFRAG_ALWAYS,
@@ -1199,10 +1270,6 @@ int main(int argc, char **argv)
 		return KSFT_SKIP;
 	}
 
-	parse_test_type(argc, argv);
-
-	setbuf(stdout, NULL);
-
 	page_size = getpagesize();
 	hpage_pmd_size = read_pmd_pagesize();
 	if (!hpage_pmd_size) {
@@ -1212,6 +1279,10 @@ int main(int argc, char **argv)
 	hpage_pmd_nr = hpage_pmd_size / page_size;
 	hpage_pmd_order = __builtin_ctz(hpage_pmd_nr);
 
+	parse_test_type(argc, argv);
+
+	setbuf(stdout, NULL);
+
 	default_settings.khugepaged.max_ptes_none = hpage_pmd_nr - 1;
 	default_settings.khugepaged.max_ptes_swap = hpage_pmd_nr / 8;
 	default_settings.khugepaged.max_ptes_shared = hpage_pmd_nr / 2;
@@ -1236,11 +1307,14 @@ int main(int argc, char **argv)
 	TEST(collapse_full, khugepaged_context, anon_ops);
 	TEST(collapse_full, khugepaged_context, file_ops);
 	TEST(collapse_full, khugepaged_context, shmem_ops);
+	TEST(collapse_full, mthp_khugepaged_context, anon_ops);
+	TEST(collapse_full, mthp_khugepaged_context, shmem_ops);
 	TEST(collapse_full, madvise_context, anon_ops);
 	TEST(collapse_full, madvise_context, file_ops);
 	TEST(collapse_full, madvise_context, shmem_ops);
 
 	TEST(collapse_empty, khugepaged_context, anon_ops);
+	TEST(collapse_empty, mthp_khugepaged_context, anon_ops);
 	TEST(collapse_empty, madvise_context, anon_ops);
 
 	TEST(collapse_single_pte_entry, khugepaged_context, anon_ops);
diff --git a/tools/testing/selftests/mm/run_vmtests.sh b/tools/testing/selftests/mm/run_vmtests.sh
index 75b94fdc915f..12d2a4f28ab5 100755
--- a/tools/testing/selftests/mm/run_vmtests.sh
+++ b/tools/testing/selftests/mm/run_vmtests.sh
@@ -496,6 +496,10 @@ CATEGORY="thp" run_test ./khugepaged all:shmem
 
 CATEGORY="thp" run_test ./khugepaged -s 4 all:shmem
 
+CATEGORY="thp" run_test ./khugepaged -c 4 mthp_khugepaged:anon
+
+CATEGORY="thp" run_test ./khugepaged -c 4 mthp_khugepaged:shmem
+
 CATEGORY="thp" run_test ./transhuge-stress -d 20
 
 # Try to create XFS if not provided
-- 
2.43.5


