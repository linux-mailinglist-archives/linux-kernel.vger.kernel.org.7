Return-Path: <linux-kernel+bounces-777275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D828B2D7AB
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 11:13:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2309F188405C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 09:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9626B2E091D;
	Wed, 20 Aug 2025 09:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="XGp0a9JD"
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF6E92DE70D
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 09:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755680872; cv=none; b=uPXqrJb9Vvgu8sITfiS31md9fpaiXkebuDzXQVOn3NCzZP6VnSrNQNBTr4qVMz/Mlt5kn8dUv0XgM3j5J57vZKPDJMoyIYil7+Visai8PZk69M/RjD0lj+4b88ugbsSJo2he2zNYP09d6RaLXNK4jtyWlz5oerXdpR0lNrfAcFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755680872; c=relaxed/simple;
	bh=7l8anJGrjxDBUklI/KzcjKZdDZDb3d1t+jxFRw1pc8U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hchbTeCFuc14og7HdgnoHdXt5OHTnMcbtcWy9WLBfcf7HAXumC9owHHiZI66JARq1wWczR3wiEj8gRj5T1po8wnJwKpCnUefPWcBFnPXoPBn1ee58mH7cGCTBj9umaAlj5Ggx/QqfZK0bDXS3zzYLrhEQ51M0Lkl1nUPATq3IGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=XGp0a9JD; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1755680865; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=JXLebxa72w6she1oq4EUJPJVyU6GJQQByANwGkThcak=;
	b=XGp0a9JDx4SR+Bvw+ctlP+hNP6yB+kWFYE8GTUF3Vxs75I6svJdCeGR++WH8UGZM3UX28Inybhsl6gLrSr8oKRZgUptaZ8KC9DdCB5qEM986S5DkRlGqt/pBRx9bzezo4pE8audDkgkNVPdKxQ4Gc5V4h8oNEAYHpXWDJxE2UGI=
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WmBXj7x_1755680863 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 20 Aug 2025 17:07:44 +0800
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
Subject: [RFC PATCH 08/11] selftests:mm: extend the check_huge() to support mTHP check
Date: Wed, 20 Aug 2025 17:07:19 +0800
Message-ID: <54919436962dc50b77e89ec142cf114f1186fa2a.1755677674.git.baolin.wang@linux.alibaba.com>
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

To support checking for various sized mTHPs during mTHP collapse, it is
necessary to extend the check_huge() function prototype in preparation
for the following patches.

No functional changes.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 tools/testing/selftests/mm/khugepaged.c       | 66 ++++++++++---------
 .../selftests/mm/split_huge_page_test.c       | 10 +--
 tools/testing/selftests/mm/uffd-common.c      |  4 +-
 tools/testing/selftests/mm/vm_util.c          |  4 +-
 tools/testing/selftests/mm/vm_util.h          |  4 +-
 5 files changed, 48 insertions(+), 40 deletions(-)

diff --git a/tools/testing/selftests/mm/khugepaged.c b/tools/testing/selftests/mm/khugepaged.c
index a18c50d51141..e529074a1fdf 100644
--- a/tools/testing/selftests/mm/khugepaged.c
+++ b/tools/testing/selftests/mm/khugepaged.c
@@ -45,7 +45,7 @@ struct mem_ops {
 	void *(*setup_area)(int nr_hpages);
 	void (*cleanup_area)(void *p, unsigned long size);
 	void (*fault)(void *p, unsigned long start, unsigned long end);
-	bool (*check_huge)(void *addr, int nr_hpages);
+	bool (*check_huge)(void *addr, unsigned long size, int nr_hpages, unsigned long hpage_size);
 	const char *name;
 };
 
@@ -319,7 +319,7 @@ static void *alloc_hpage(struct mem_ops *ops)
 		perror("madvise(MADV_COLLAPSE)");
 		exit(EXIT_FAILURE);
 	}
-	if (!ops->check_huge(p, 1)) {
+	if (!ops->check_huge(p, hpage_pmd_size, 1, hpage_pmd_size)) {
 		perror("madvise(MADV_COLLAPSE)");
 		exit(EXIT_FAILURE);
 	}
@@ -359,9 +359,10 @@ static void anon_fault(void *p, unsigned long start, unsigned long end)
 	fill_memory(p, start, end);
 }
 
-static bool anon_check_huge(void *addr, int nr_hpages)
+static bool anon_check_huge(void *addr, unsigned long size,
+			int nr_hpages, unsigned long hpage_size)
 {
-	return check_huge_anon(addr, nr_hpages, hpage_pmd_size);
+	return check_huge_anon(addr, size, nr_hpages, hpage_size);
 }
 
 static void *file_setup_area(int nr_hpages)
@@ -422,13 +423,14 @@ static void file_fault(void *p, unsigned long start, unsigned long end)
 	}
 }
 
-static bool file_check_huge(void *addr, int nr_hpages)
+static bool file_check_huge(void *addr, unsigned long size,
+			int nr_hpages, unsigned long hpage_size)
 {
 	switch (finfo.type) {
 	case VMA_FILE:
-		return check_huge_file(addr, nr_hpages, hpage_pmd_size);
+		return check_huge_file(addr, nr_hpages, hpage_size);
 	case VMA_SHMEM:
-		return check_huge_shmem(addr, nr_hpages, hpage_pmd_size);
+		return check_huge_shmem(addr, size, nr_hpages, hpage_size);
 	default:
 		exit(EXIT_FAILURE);
 		return false;
@@ -464,9 +466,10 @@ static void shmem_cleanup_area(void *p, unsigned long size)
 	close(finfo.fd);
 }
 
-static bool shmem_check_huge(void *addr, int nr_hpages)
+static bool shmem_check_huge(void *addr, unsigned long size,
+			int nr_hpages, unsigned long hpage_size)
 {
-	return check_huge_shmem(addr, nr_hpages, hpage_pmd_size);
+	return check_huge_shmem(addr, size, nr_hpages, hpage_size);
 }
 
 static struct mem_ops __anon_ops = {
@@ -514,7 +517,7 @@ static void __madvise_collapse(const char *msg, char *p, int nr_hpages,
 	ret = madvise_collapse_retry(p, nr_hpages * hpage_pmd_size);
 	if (((bool)ret) == expect)
 		fail("Fail: Bad return value");
-	else if (!ops->check_huge(p, expect ? nr_hpages : 0))
+	else if (!ops->check_huge(p, nr_hpages * hpage_pmd_size, expect ? nr_hpages : 0, hpage_pmd_size))
 		fail("Fail: check_huge()");
 	else
 		success("OK");
@@ -526,7 +529,7 @@ static void madvise_collapse(const char *msg, char *p, int nr_hpages,
 			     struct mem_ops *ops, bool expect)
 {
 	/* Sanity check */
-	if (!ops->check_huge(p, 0)) {
+	if (!ops->check_huge(p, nr_hpages * hpage_pmd_size, 0, hpage_pmd_size)) {
 		printf("Unexpected huge page\n");
 		exit(EXIT_FAILURE);
 	}
@@ -537,11 +540,12 @@ static void madvise_collapse(const char *msg, char *p, int nr_hpages,
 static bool wait_for_scan(const char *msg, char *p, int nr_hpages,
 			  struct mem_ops *ops)
 {
+	unsigned long size = nr_hpages * hpage_pmd_size;
 	int full_scans;
 	int timeout = 6; /* 3 seconds */
 
 	/* Sanity check */
-	if (!ops->check_huge(p, 0)) {
+	if (!ops->check_huge(p, size, 0, hpage_pmd_size)) {
 		printf("Unexpected huge page\n");
 		exit(EXIT_FAILURE);
 	}
@@ -553,7 +557,7 @@ static bool wait_for_scan(const char *msg, char *p, int nr_hpages,
 
 	printf("%s...", msg);
 	while (timeout--) {
-		if (ops->check_huge(p, nr_hpages))
+		if (ops->check_huge(p, size, nr_hpages, hpage_pmd_size))
 			break;
 		if (thp_read_num("khugepaged/full_scans") >= full_scans)
 			break;
@@ -567,6 +571,8 @@ static bool wait_for_scan(const char *msg, char *p, int nr_hpages,
 static void khugepaged_collapse(const char *msg, char *p, int nr_hpages,
 				struct mem_ops *ops, bool expect)
 {
+	unsigned long size = nr_hpages * hpage_pmd_size;
+
 	if (wait_for_scan(msg, p, nr_hpages, ops)) {
 		if (expect)
 			fail("Timeout");
@@ -583,7 +589,7 @@ static void khugepaged_collapse(const char *msg, char *p, int nr_hpages,
 	if (ops != &__anon_ops)
 		ops->fault(p, 0, nr_hpages * hpage_pmd_size);
 
-	if (ops->check_huge(p, expect ? nr_hpages : 0))
+	if (ops->check_huge(p, size, expect ? nr_hpages : 0, hpage_pmd_size))
 		success("OK");
 	else
 		fail("Fail");
@@ -622,7 +628,7 @@ static void alloc_at_fault(void)
 	p = alloc_mapping(1);
 	*p = 1;
 	printf("Allocate huge page on fault...");
-	if (check_huge_anon(p, 1, hpage_pmd_size))
+	if (check_huge_anon(p, hpage_pmd_size, 1, hpage_pmd_size))
 		success("OK");
 	else
 		fail("Fail");
@@ -631,7 +637,7 @@ static void alloc_at_fault(void)
 
 	madvise(p, page_size, MADV_DONTNEED);
 	printf("Split huge PMD on MADV_DONTNEED...");
-	if (check_huge_anon(p, 0, hpage_pmd_size))
+	if (check_huge_anon(p, hpage_pmd_size, 0, hpage_pmd_size))
 		success("OK");
 	else
 		fail("Fail");
@@ -797,7 +803,7 @@ static void collapse_single_pte_entry_compound(struct collapse_context *c, struc
 	madvise(p, hpage_pmd_size, MADV_NOHUGEPAGE);
 	printf("Split huge page leaving single PTE mapping compound page...");
 	madvise(p + page_size, hpage_pmd_size - page_size, MADV_DONTNEED);
-	if (ops->check_huge(p, 0))
+	if (ops->check_huge(p, hpage_pmd_size, 0, hpage_pmd_size))
 		success("OK");
 	else
 		fail("Fail");
@@ -817,7 +823,7 @@ static void collapse_full_of_compound(struct collapse_context *c, struct mem_ops
 	printf("Split huge page leaving single PTE page table full of compound pages...");
 	madvise(p, page_size, MADV_NOHUGEPAGE);
 	madvise(p, hpage_pmd_size, MADV_NOHUGEPAGE);
-	if (ops->check_huge(p, 0))
+	if (ops->check_huge(p, hpage_pmd_size, 0, hpage_pmd_size))
 		success("OK");
 	else
 		fail("Fail");
@@ -840,7 +846,7 @@ static void collapse_compound_extreme(struct collapse_context *c, struct mem_ops
 
 		madvise(BASE_ADDR, hpage_pmd_size, MADV_HUGEPAGE);
 		ops->fault(BASE_ADDR, 0, hpage_pmd_size);
-		if (!ops->check_huge(BASE_ADDR, 1)) {
+		if (!ops->check_huge(BASE_ADDR, hpage_pmd_size, 1, hpage_pmd_size)) {
 			printf("Failed to allocate huge page\n");
 			exit(EXIT_FAILURE);
 		}
@@ -869,7 +875,7 @@ static void collapse_compound_extreme(struct collapse_context *c, struct mem_ops
 
 	ops->cleanup_area(BASE_ADDR, hpage_pmd_size);
 	ops->fault(p, 0, hpage_pmd_size);
-	if (!ops->check_huge(p, 1))
+	if (!ops->check_huge(p, hpage_pmd_size, 1, hpage_pmd_size))
 		success("OK");
 	else
 		fail("Fail");
@@ -890,7 +896,7 @@ static void collapse_fork(struct collapse_context *c, struct mem_ops *ops)
 
 	printf("Allocate small page...");
 	ops->fault(p, 0, page_size);
-	if (ops->check_huge(p, 0))
+	if (ops->check_huge(p, hpage_pmd_size, 0, hpage_pmd_size))
 		success("OK");
 	else
 		fail("Fail");
@@ -901,7 +907,7 @@ static void collapse_fork(struct collapse_context *c, struct mem_ops *ops)
 		skip_settings_restore = true;
 		exit_status = 0;
 
-		if (ops->check_huge(p, 0))
+		if (ops->check_huge(p, hpage_pmd_size, 0, hpage_pmd_size))
 			success("OK");
 		else
 			fail("Fail");
@@ -919,7 +925,7 @@ static void collapse_fork(struct collapse_context *c, struct mem_ops *ops)
 	exit_status += WEXITSTATUS(wstatus);
 
 	printf("Check if parent still has small page...");
-	if (ops->check_huge(p, 0))
+	if (ops->check_huge(p, hpage_pmd_size, 0, hpage_pmd_size))
 		success("OK");
 	else
 		fail("Fail");
@@ -939,7 +945,7 @@ static void collapse_fork_compound(struct collapse_context *c, struct mem_ops *o
 		skip_settings_restore = true;
 		exit_status = 0;
 
-		if (ops->check_huge(p, 1))
+		if (ops->check_huge(p, hpage_pmd_size, 1, hpage_pmd_size))
 			success("OK");
 		else
 			fail("Fail");
@@ -947,7 +953,7 @@ static void collapse_fork_compound(struct collapse_context *c, struct mem_ops *o
 		printf("Split huge page PMD in child process...");
 		madvise(p, page_size, MADV_NOHUGEPAGE);
 		madvise(p, hpage_pmd_size, MADV_NOHUGEPAGE);
-		if (ops->check_huge(p, 0))
+		if (ops->check_huge(p, hpage_pmd_size, 0, hpage_pmd_size))
 			success("OK");
 		else
 			fail("Fail");
@@ -968,7 +974,7 @@ static void collapse_fork_compound(struct collapse_context *c, struct mem_ops *o
 	exit_status += WEXITSTATUS(wstatus);
 
 	printf("Check if parent still has huge page...");
-	if (ops->check_huge(p, 1))
+	if (ops->check_huge(p, hpage_pmd_size, 1, hpage_pmd_size))
 		success("OK");
 	else
 		fail("Fail");
@@ -989,7 +995,7 @@ static void collapse_max_ptes_shared(struct collapse_context *c, struct mem_ops
 		skip_settings_restore = true;
 		exit_status = 0;
 
-		if (ops->check_huge(p, 1))
+		if (ops->check_huge(p, hpage_pmd_size, 1, hpage_pmd_size))
 			success("OK");
 		else
 			fail("Fail");
@@ -997,7 +1003,7 @@ static void collapse_max_ptes_shared(struct collapse_context *c, struct mem_ops
 		printf("Trigger CoW on page %d of %d...",
 				hpage_pmd_nr - max_ptes_shared - 1, hpage_pmd_nr);
 		ops->fault(p, 0, (hpage_pmd_nr - max_ptes_shared - 1) * page_size);
-		if (ops->check_huge(p, 0))
+		if (ops->check_huge(p, hpage_pmd_size, 0, hpage_pmd_size))
 			success("OK");
 		else
 			fail("Fail");
@@ -1010,7 +1016,7 @@ static void collapse_max_ptes_shared(struct collapse_context *c, struct mem_ops
 			       hpage_pmd_nr - max_ptes_shared, hpage_pmd_nr);
 			ops->fault(p, 0, (hpage_pmd_nr - max_ptes_shared) *
 				    page_size);
-			if (ops->check_huge(p, 0))
+			if (ops->check_huge(p, hpage_pmd_size, 0, hpage_pmd_size))
 				success("OK");
 			else
 				fail("Fail");
@@ -1028,7 +1034,7 @@ static void collapse_max_ptes_shared(struct collapse_context *c, struct mem_ops
 	exit_status += WEXITSTATUS(wstatus);
 
 	printf("Check if parent still has huge page...");
-	if (ops->check_huge(p, 1))
+	if (ops->check_huge(p, hpage_pmd_size, 1, hpage_pmd_size))
 		success("OK");
 	else
 		fail("Fail");
diff --git a/tools/testing/selftests/mm/split_huge_page_test.c b/tools/testing/selftests/mm/split_huge_page_test.c
index 80eb1f91261e..cbf190598988 100644
--- a/tools/testing/selftests/mm/split_huge_page_test.c
+++ b/tools/testing/selftests/mm/split_huge_page_test.c
@@ -311,7 +311,7 @@ static void verify_rss_anon_split_huge_page_all_zeroes(char *one_page, int nr_hp
 	unsigned long rss_anon_before, rss_anon_after;
 	size_t i;
 
-	if (!check_huge_anon(one_page, nr_hpages, pmd_pagesize))
+	if (!check_huge_anon(one_page, nr_hpages * pmd_pagesize, nr_hpages, pmd_pagesize))
 		ksft_exit_fail_msg("No THP is allocated\n");
 
 	rss_anon_before = rss_anon();
@@ -326,7 +326,7 @@ static void verify_rss_anon_split_huge_page_all_zeroes(char *one_page, int nr_hp
 		if (one_page[i] != (char)0)
 			ksft_exit_fail_msg("%ld byte corrupted\n", i);
 
-	if (!check_huge_anon(one_page, 0, pmd_pagesize))
+	if (!check_huge_anon(one_page, nr_hpages * pmd_pagesize, 0, pmd_pagesize))
 		ksft_exit_fail_msg("Still AnonHugePages not split\n");
 
 	rss_anon_after = rss_anon();
@@ -362,7 +362,7 @@ static void split_pmd_thp_to_order(int order)
 	for (i = 0; i < len; i++)
 		one_page[i] = (char)i;
 
-	if (!check_huge_anon(one_page, 4, pmd_pagesize))
+	if (!check_huge_anon(one_page, 4 * pmd_pagesize, 4, pmd_pagesize))
 		ksft_exit_fail_msg("No THP is allocated\n");
 
 	/* split all THPs */
@@ -381,7 +381,7 @@ static void split_pmd_thp_to_order(int order)
 					   (pmd_order + 1)))
 		ksft_exit_fail_msg("Unexpected THP split\n");
 
-	if (!check_huge_anon(one_page, 0, pmd_pagesize))
+	if (!check_huge_anon(one_page, 4 * pmd_pagesize, 0, pmd_pagesize))
 		ksft_exit_fail_msg("Still AnonHugePages not split\n");
 
 	ksft_test_result_pass("Split huge pages to order %d successful\n", order);
@@ -405,7 +405,7 @@ static void split_pte_mapped_thp(void)
 	for (i = 0; i < len; i++)
 		one_page[i] = (char)i;
 
-	if (!check_huge_anon(one_page, 4, pmd_pagesize))
+	if (!check_huge_anon(one_page, 4 * pmd_pagesize, 4, pmd_pagesize))
 		ksft_exit_fail_msg("No THP is allocated\n");
 
 	/* remap the first pagesize of first THP */
diff --git a/tools/testing/selftests/mm/uffd-common.c b/tools/testing/selftests/mm/uffd-common.c
index f4e9a5f43e24..b6cfcc6950e1 100644
--- a/tools/testing/selftests/mm/uffd-common.c
+++ b/tools/testing/selftests/mm/uffd-common.c
@@ -191,7 +191,9 @@ static void shmem_alias_mapping(uffd_global_test_opts_t *gopts, __u64 *start,
 static void shmem_check_pmd_mapping(uffd_global_test_opts_t *gopts, void __unused *p,
 				    int expect_nr_hpages)
 {
-	if (!check_huge_shmem(gopts->area_dst_alias, expect_nr_hpages,
+	unsigned long size = expect_nr_hpages * read_pmd_pagesize();
+
+	if (!check_huge_shmem(gopts->area_dst_alias, size, expect_nr_hpages,
 			      read_pmd_pagesize()))
 		err("Did not find expected %d number of hugepages",
 		    expect_nr_hpages);
diff --git a/tools/testing/selftests/mm/vm_util.c b/tools/testing/selftests/mm/vm_util.c
index 56e9bd541edd..6058d80c63ef 100644
--- a/tools/testing/selftests/mm/vm_util.c
+++ b/tools/testing/selftests/mm/vm_util.c
@@ -248,7 +248,7 @@ bool __check_huge(void *addr, char *pattern, int nr_hpages,
 	return thp == (nr_hpages * (hpage_size >> 10));
 }
 
-bool check_huge_anon(void *addr, int nr_hpages, uint64_t hpage_size)
+bool check_huge_anon(void *addr, unsigned long size, int nr_hpages, uint64_t hpage_size)
 {
 	return __check_huge(addr, "AnonHugePages: ", nr_hpages, hpage_size);
 }
@@ -258,7 +258,7 @@ bool check_huge_file(void *addr, int nr_hpages, uint64_t hpage_size)
 	return __check_huge(addr, "FilePmdMapped:", nr_hpages, hpage_size);
 }
 
-bool check_huge_shmem(void *addr, int nr_hpages, uint64_t hpage_size)
+bool check_huge_shmem(void *addr, unsigned long size, int nr_hpages, uint64_t hpage_size)
 {
 	return __check_huge(addr, "ShmemPmdMapped:", nr_hpages, hpage_size);
 }
diff --git a/tools/testing/selftests/mm/vm_util.h b/tools/testing/selftests/mm/vm_util.h
index 07c4acfd84b6..a1cd446e5140 100644
--- a/tools/testing/selftests/mm/vm_util.h
+++ b/tools/testing/selftests/mm/vm_util.h
@@ -82,9 +82,9 @@ void clear_softdirty(void);
 bool check_for_pattern(FILE *fp, const char *pattern, char *buf, size_t len);
 uint64_t read_pmd_pagesize(void);
 unsigned long rss_anon(void);
-bool check_huge_anon(void *addr, int nr_hpages, uint64_t hpage_size);
+bool check_huge_anon(void *addr, unsigned long size, int nr_hpages, uint64_t hpage_size);
 bool check_huge_file(void *addr, int nr_hpages, uint64_t hpage_size);
-bool check_huge_shmem(void *addr, int nr_hpages, uint64_t hpage_size);
+bool check_huge_shmem(void *addr, unsigned long size, int nr_hpages, uint64_t hpage_size);
 int64_t allocate_transhuge(void *ptr, int pagemap_fd);
 unsigned long default_huge_page_size(void);
 int detect_hugetlb_page_sizes(size_t sizes[], int max);
-- 
2.43.5


