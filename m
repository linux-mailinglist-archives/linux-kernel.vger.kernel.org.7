Return-Path: <linux-kernel+bounces-735166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42B8DB08BAE
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 13:25:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E40565862D3
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 11:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FD2329AB18;
	Thu, 17 Jul 2025 11:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iiv8cC7l"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 556F129A9FE
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 11:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752751501; cv=none; b=ICqDuET7LcYXC5jlzn9xV7FHhx+tzgX9nserVu9p/1LYjjcKkSbNc7xaqBmHUv4Gn+z/izqcP9ykS1OdU+XV/fLa+72p41OSkXmx54r0+E5/kiOYIvmL+B9+OxJyXZpNJEvCHCE64KXW9loWHJBhyMnZ5JkPMQw8qTpFemh91xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752751501; c=relaxed/simple;
	bh=NcuMIBr28IEKe2VGN4CmNGGesyze/U85o1QGN09TjGo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NLBIVH0GHbh+OoAuUBis9FIjSm9Jd0x1zxPxUnxcW63zp8qw+FVBA3qRZqTUToMqy58GXKvllojxn9ZhSVa4twUOhecdizJWIOchJ/0Twmhxl5RPN4HqV8iIGIDKgVwW/j/k4eKc/As1OJjjtzVA2ORZS+eKZs60kGCxcq3VhqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iiv8cC7l; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-315f6b20cf9so905105a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 04:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752751500; x=1753356300; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZMT6fE/DNbQkiKqemNDiWNAX9JwNMC9DrX8cJvHr54A=;
        b=iiv8cC7lucK6b1v1qsuSlp98gt07VzZATUrtXDiHkVn3qyIeztHkOepG6gq1qsBPmg
         umI4xSQdnhhv5ft0+6Wub2MnmtjQ8yd4+fM2XDni2KTbdTDt0VMPJMrdqa1tI8S0UkhG
         m4gfmAVNN30Llxsdh2XNj1xzCwFLY+nKqZIQrkhPnqFKnkKA6BGOXMxBzQArs9NUF6wI
         b21m5EPRxpRBCSASu8n8Uw0OqUtlH1KCFbdRfg2y8MFeiyDDbifu5vCbs0QUlqBWTRr8
         tq7bFGqgz2vLD4FTHCjhHeqtNbT2X37ze9/2GwsjvoMd7wbm7011octEU+1cPQw9xMtU
         Tm1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752751500; x=1753356300;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZMT6fE/DNbQkiKqemNDiWNAX9JwNMC9DrX8cJvHr54A=;
        b=VFvUok4UAojfaxbJT42oF1Pn6x5rEpxMAvbhmMNkOSo7kXfdokAFXuCQwsUVi8pDtQ
         ts0YqK3Ih5OcmRu0dfKj3hHjfyMY54OVVDs5oDp9mWqBdfFyZC5jr9RLFOEX7Yj4uPy1
         Mkff7jOeMGCbEp/BVylLBrL5JO3feHvd1yRPaSkf6UjNIM/GarO9IHBzXaJ4RXaWEASa
         2mC8txdrJ20uXT1ALN/mhHF3bEm6/+2O/ZjzLqqeoaA0Bv4V5S8e7BTAjqwQPNr2V3Cj
         W1PyyulnRv7PAUKzAIDUrT1poNbJP76QSx6xJeSHKcaNxDrtmm8nHzkLEXHtuPyD8LXi
         hOMw==
X-Forwarded-Encrypted: i=1; AJvYcCU849ufwOec95vqx2bYx5ZLo7879crmNG/oqVHy48hqCehANVI7WnS1H3Zo7WV0dEolfbbnso07mxy1JE8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1x9fW+nbPkba7Qj+LgrViQ+Me8CNrzF5YytGSDIo8M1tmj2dX
	Xame42QcRt756/IUf0HdBA5OSA94f4JR5seE330SytK7kNNu2ULfLmT39/F7BRX2
X-Gm-Gg: ASbGncsZrp0WW61P+TQ8vjgav1A+7sltfjdYSnrH69CPNcxFozAsvK4CzSilyraN4F8
	WxbxofkE7k2kCATWLU2Ar7YnwDq51W7fgC2wGoTPlCdaMC/2j/X/8k48CdQ89764W3qgVlGKOWw
	FPEN6mUgSzCVGBFneD8Lg6zm8eXMGcN73BrYoAdUam9xFV7jKjoOLxF0s83yEIo7KU+O4S3b2r+
	5l4Gh9myoJ6rsH235KsHWXJZXmoz6F7iQ+p884JygSToChCw5S6lL6gVTEzc2A++2H0NR7/6eBV
	6Gz6/tO0nucfVjSHH+zjQ3IdJawn7/QJDSyNRFTHTPjkWzRCwoTE6FdCUegb05mRe0Ex1z+J0wg
	MwyE8lUTANiotrQxgBqPN7klZHoqEfDl95Wo5a04x6JHS
X-Google-Smtp-Source: AGHT+IEJEKvCJyJnvX4Q2gv2UnxBBrlUnFePWnxT4lcx+hQbAnXYDNB0h2Q2awC+uZJSz+6aHeAtCQ==
X-Received: by 2002:a17:90b:3bcd:b0:313:28f1:fc33 with SMTP id 98e67ed59e1d1-31c9f3c5acamr9151360a91.10.1752751499365;
        Thu, 17 Jul 2025 04:24:59 -0700 (PDT)
Received: from DESKTOP-GIED850.localdomain ([114.247.113.178])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c9153803esm2530794a91.0.2025.07.17.04.24.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 04:24:59 -0700 (PDT)
From: wang lian <lianux.mm@gmail.com>
To: akpm@linux-foundation.org,
	broonie@kernel.org,
	david@redhat.com,
	lorenzo.stoakes@oracle.com,
	sj@kernel.org,
	ziy@nvidia.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: brauner@kernel.org,
	gkwang@linx-info.com,
	jannh@google.com,
	Liam.Howlett@oracle.com,
	lianux.mm@gmail.com,
	ludovico.zy.wu@gmail.com,
	p1ucky0923@gmail.com,
	richard.weiyang@gmail.com,
	ryncsn@gmail.com,
	shuah@kernel.org,
	vbabka@suse.cz,
	zijing.zhang@proton.me
Subject: [PATCH 2/2] selftests/mm: reuse FORCE_READ to replace "asm volatile("" : "+r" (XXX));"
Date: Thu, 17 Jul 2025 19:24:07 +0800
Message-ID: <20250717112407.13507-3-lianux.mm@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250717112407.13507-1-lianux.mm@gmail.com>
References: <20250717112407.13507-1-lianux.mm@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Several mm selftests use the `asm volatile("" : "+r" (variable));`
construct to force a read of a variable, preventing the compiler from
optimizing away the memory access. This idiom is cryptic and duplicated
across multiple test files.

Following a suggestion from David[1], this patch refactors this
common pattern into a FORCE_READ() macro

[1] https://lore.kernel.org/lkml/4a3e0759-caa1-4cfa-bc3f-402593f1eee3@redhat.com/

Signed-off-by: wang lian <lianux.mm@gmail.com>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Acked-by: David Hildenbrand <david@redhat.com>
---
 tools/testing/selftests/mm/cow.c              | 30 +++++++++----------
 tools/testing/selftests/mm/hugetlb-madvise.c  |  5 +---
 tools/testing/selftests/mm/migration.c        | 13 ++++----
 tools/testing/selftests/mm/pagemap_ioctl.c    |  4 +--
 .../selftests/mm/split_huge_page_test.c       |  4 +--
 5 files changed, 24 insertions(+), 32 deletions(-)

diff --git a/tools/testing/selftests/mm/cow.c b/tools/testing/selftests/mm/cow.c
index 788e82b00b75..d30625c18259 100644
--- a/tools/testing/selftests/mm/cow.c
+++ b/tools/testing/selftests/mm/cow.c
@@ -1534,7 +1534,7 @@ static void test_ro_fast_pin(char *mem, const char *smem, size_t size)
 
 static void run_with_zeropage(non_anon_test_fn fn, const char *desc)
 {
-	char *mem, *smem, tmp;
+	char *mem, *smem;
 
 	log_test_start("%s ... with shared zeropage", desc);
 
@@ -1554,8 +1554,8 @@ static void run_with_zeropage(non_anon_test_fn fn, const char *desc)
 	}
 
 	/* Read from the page to populate the shared zeropage. */
-	tmp = *mem + *smem;
-	asm volatile("" : "+r" (tmp));
+	FORCE_READ(mem);
+	FORCE_READ(smem);
 
 	fn(mem, smem, pagesize);
 munmap:
@@ -1566,7 +1566,7 @@ static void run_with_zeropage(non_anon_test_fn fn, const char *desc)
 
 static void run_with_huge_zeropage(non_anon_test_fn fn, const char *desc)
 {
-	char *mem, *smem, *mmap_mem, *mmap_smem, tmp;
+	char *mem, *smem, *mmap_mem, *mmap_smem;
 	size_t mmap_size;
 	int ret;
 
@@ -1617,8 +1617,8 @@ static void run_with_huge_zeropage(non_anon_test_fn fn, const char *desc)
 	 * the first sub-page and test if we get another sub-page populated
 	 * automatically.
 	 */
-	tmp = *mem + *smem;
-	asm volatile("" : "+r" (tmp));
+	FORCE_READ(mem);
+	FORCE_READ(smem);
 	if (!pagemap_is_populated(pagemap_fd, mem + pagesize) ||
 	    !pagemap_is_populated(pagemap_fd, smem + pagesize)) {
 		ksft_test_result_skip("Did not get THPs populated\n");
@@ -1634,7 +1634,7 @@ static void run_with_huge_zeropage(non_anon_test_fn fn, const char *desc)
 
 static void run_with_memfd(non_anon_test_fn fn, const char *desc)
 {
-	char *mem, *smem, tmp;
+	char *mem, *smem;
 	int fd;
 
 	log_test_start("%s ... with memfd", desc);
@@ -1668,8 +1668,8 @@ static void run_with_memfd(non_anon_test_fn fn, const char *desc)
 	}
 
 	/* Fault the page in. */
-	tmp = *mem + *smem;
-	asm volatile("" : "+r" (tmp));
+	FORCE_READ(mem);
+	FORCE_READ(smem);
 
 	fn(mem, smem, pagesize);
 munmap:
@@ -1682,7 +1682,7 @@ static void run_with_memfd(non_anon_test_fn fn, const char *desc)
 
 static void run_with_tmpfile(non_anon_test_fn fn, const char *desc)
 {
-	char *mem, *smem, tmp;
+	char *mem, *smem;
 	FILE *file;
 	int fd;
 
@@ -1724,8 +1724,8 @@ static void run_with_tmpfile(non_anon_test_fn fn, const char *desc)
 	}
 
 	/* Fault the page in. */
-	tmp = *mem + *smem;
-	asm volatile("" : "+r" (tmp));
+	FORCE_READ(mem);
+	FORCE_READ(smem);
 
 	fn(mem, smem, pagesize);
 munmap:
@@ -1740,7 +1740,7 @@ static void run_with_memfd_hugetlb(non_anon_test_fn fn, const char *desc,
 				   size_t hugetlbsize)
 {
 	int flags = MFD_HUGETLB;
-	char *mem, *smem, tmp;
+	char *mem, *smem;
 	int fd;
 
 	log_test_start("%s ... with memfd hugetlb (%zu kB)", desc,
@@ -1778,8 +1778,8 @@ static void run_with_memfd_hugetlb(non_anon_test_fn fn, const char *desc,
 	}
 
 	/* Fault the page in. */
-	tmp = *mem + *smem;
-	asm volatile("" : "+r" (tmp));
+	FORCE_READ(mem);
+	FORCE_READ(smem);
 
 	fn(mem, smem, hugetlbsize);
 munmap:
diff --git a/tools/testing/selftests/mm/hugetlb-madvise.c b/tools/testing/selftests/mm/hugetlb-madvise.c
index e74107185324..1afe14b9dc0c 100644
--- a/tools/testing/selftests/mm/hugetlb-madvise.c
+++ b/tools/testing/selftests/mm/hugetlb-madvise.c
@@ -47,14 +47,11 @@ void write_fault_pages(void *addr, unsigned long nr_pages)
 
 void read_fault_pages(void *addr, unsigned long nr_pages)
 {
-	volatile unsigned long dummy = 0;
 	unsigned long i;
 
 	for (i = 0; i < nr_pages; i++) {
-		dummy += *((unsigned long *)(addr + (i * huge_page_size)));
-
 		/* Prevent the compiler from optimizing out the entire loop: */
-		asm volatile("" : "+r" (dummy));
+		FORCE_READ(((unsigned long *)(addr + (i * huge_page_size))));
 	}
 }
 
diff --git a/tools/testing/selftests/mm/migration.c b/tools/testing/selftests/mm/migration.c
index a306f8bab087..c5a73617796a 100644
--- a/tools/testing/selftests/mm/migration.c
+++ b/tools/testing/selftests/mm/migration.c
@@ -16,6 +16,7 @@
 #include <sys/types.h>
 #include <signal.h>
 #include <time.h>
+#include "vm_util.h"
 
 #define TWOMEG		(2<<20)
 #define RUNTIME		(20)
@@ -103,15 +104,13 @@ int migrate(uint64_t *ptr, int n1, int n2)
 
 void *access_mem(void *ptr)
 {
-	volatile uint64_t y = 0;
-	volatile uint64_t *x = ptr;
-
 	while (1) {
 		pthread_testcancel();
-		y += *x;
-
-		/* Prevent the compiler from optimizing out the writes to y: */
-		asm volatile("" : "+r" (y));
+		/* Force a read from the memory pointed to by ptr. This ensures
+		 * the memory access actually happens and prevents the compiler
+		 * from optimizing away this entire loop.
+		 */
+		FORCE_READ((uint64_t *)ptr);
 	}
 
 	return NULL;
diff --git a/tools/testing/selftests/mm/pagemap_ioctl.c b/tools/testing/selftests/mm/pagemap_ioctl.c
index c2dcda78ad31..0d4209eef0c3 100644
--- a/tools/testing/selftests/mm/pagemap_ioctl.c
+++ b/tools/testing/selftests/mm/pagemap_ioctl.c
@@ -1525,9 +1525,7 @@ void zeropfn_tests(void)
 
 	ret = madvise(mem, hpage_size, MADV_HUGEPAGE);
 	if (!ret) {
-		char tmp = *mem;
-
-		asm volatile("" : "+r" (tmp));
+		FORCE_READ(mem);
 
 		ret = pagemap_ioctl(mem, hpage_size, &vec, 1, 0,
 				    0, PAGE_IS_PFNZERO, 0, 0, PAGE_IS_PFNZERO);
diff --git a/tools/testing/selftests/mm/split_huge_page_test.c b/tools/testing/selftests/mm/split_huge_page_test.c
index f0d9c035641d..05de1fc0005b 100644
--- a/tools/testing/selftests/mm/split_huge_page_test.c
+++ b/tools/testing/selftests/mm/split_huge_page_test.c
@@ -399,7 +399,6 @@ int create_pagecache_thp_and_fd(const char *testfile, size_t fd_size, int *fd,
 		char **addr)
 {
 	size_t i;
-	int dummy = 0;
 	unsigned char buf[1024];
 
 	srand(time(NULL));
@@ -441,8 +440,7 @@ int create_pagecache_thp_and_fd(const char *testfile, size_t fd_size, int *fd,
 	madvise(*addr, fd_size, MADV_HUGEPAGE);
 
 	for (size_t i = 0; i < fd_size; i++)
-		dummy += *(*addr + i);
-	asm volatile("" : "+r" (dummy));
+		FORCE_READ((*addr + i));
 
 	if (!check_huge_file(*addr, fd_size / pmd_pagesize, pmd_pagesize)) {
 		ksft_print_msg("No large pagecache folio generated, please provide a filesystem supporting large folio\n");
-- 
2.43.0


