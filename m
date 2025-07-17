Return-Path: <linux-kernel+bounces-735342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 79CE7B08DFE
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 15:19:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFCED1A671AE
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 13:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2C262E49AA;
	Thu, 17 Jul 2025 13:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A+Y+E8Rm"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58D042D8DBD
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 13:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752758394; cv=none; b=jVlld+D3tbJIg7unmn+5nxd3/PRh1NQCwCn+csg9MrQqrD2ogZZYcx60zBk+6zgW9UVHys+Ra7V3JOFls1jIZocM4/1aE6XHzlGkf/yKNbsSzA2MSmyHbmUBtcnuhzMfwbRr8h4JuemzY1Dj2XLsKQQWIV9kIa5BYDqJ3Uja3vI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752758394; c=relaxed/simple;
	bh=2Lmza6lVP/m0i/zH8gYQyhI/IUgEfBDltLTfcQxMga0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=amxunW9VFYCuc7OQ8Y4yhMcDKWpoUli+05DjCwJpRNvsJrSeM8xfSXePsKeyyOVdusI4L4JnNRbKCD9kOgdC8UMukDlflAad4jTO7EFJge0zFpIn0XGJZQ0h0W212mDAnGArfamKP48n1IdvcmydOLYkXthvdaNMLWZwdDDWBb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A+Y+E8Rm; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-23e210ebd5dso14646865ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 06:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752758391; x=1753363191; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1786UljR40Ey8hUhV8xAFjRTVHePO6Fj+ZWLSNdNrEA=;
        b=A+Y+E8RmvtDDCrPLJaLC3Y03ryBWuE6FXq9Bgln+wq2jz1ZZ0Cd1e/f7FlgbhdvK9O
         hQbyzajXOjcd1ZMwPctk2i3WjGDcqhaQGc4SirP2YcsIA4+NffhWhqIDDX6XPx7EOwUY
         9rav9zlN5opf9VN3kipOF5K0UQlhwf09bcJ9/hDft3LiB+nYoJHswq9Blcs1Zi8aMl7J
         7car4VTCCtmwrQBFSv77amu4aZ+uNdgTRa2rdJZvbwVGNUYRl8aAkmAq2M4jUO/b0PLE
         HXQa2H5+BNh+Fkfmeaj7TGn5DFaCkxrT8P3RmF45LNYHniVcUT1qJoVWdSuwdxZf6xKR
         MGmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752758391; x=1753363191;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1786UljR40Ey8hUhV8xAFjRTVHePO6Fj+ZWLSNdNrEA=;
        b=X18wQ3JtBVG8kReGhBI5NsNmdQmyj2g6E3SdsYDL6w+FJpfkS/A6jh/iGCQBoinpzw
         WrhRCTZiDwp1qMLpj8HcoPtA9IyusqtTrH0DRXHteZDE5V4Udcy0AK//mzwWmr282Gvt
         IJ6o9Ht+eqcUfjbPVsH6xLouyfM+f9rAMFTjmXpIoebLgi23AjWn0qkPPBdwwDndVFIn
         UGfSNEfuq0VdfN61R/bnH7eL63EBvGaeA66d/OzLb7rWApvujZ0pJcOYO5Vczu5KjuWO
         hGbTz/BmO4Gsn7A0ls/wttNNQMOLI4vUt0zLsDydjIYDo9zNn0UH5rpk9p6IDPI630Af
         DT+Q==
X-Forwarded-Encrypted: i=1; AJvYcCUdr5XHT137YI5p0YcF4qwrBi9TLL9dj9N+ZQFMa1NGaKRfQiHv6adHA4kkIOhVzcOEzl9rGqLm4pzvEwg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuAuC/Q6HZIIIEDLpXvw1zKBKRhfa03mwq7R5Dc3SCFGONgwr6
	byq1X79Ke9j1Z1x3LGYQBT2+wC4ZyVfXH1721SbsrpX0uGNv1nKBbhXR
X-Gm-Gg: ASbGnctpN4bu/CjHrxXmANXeUFzw4XT4DuJxvDF+MPEaHfzntd5CPk6yoG3BrVZzM3o
	Gdyi2uikqFElKU7JF7HXUqFhalR0Csk3yYFjGYhcvcJ3AgmaerGGYjbjameT1OVLV9JEjPBzPbT
	6A2JlO4ctXYxPtpIO9L/3WuPDitDPnUoywdiAimTmg03c5t7yC+F3hZlDBf28/l0KUbqHk/CTC6
	yYcBboXM0fWOlDKENOwAz+Rkcm4igaNkFI5cq70iFi9+HSByWuV6UACr04u15ALPxBzEbuphZkt
	Yid5pS11CAvmjB2N/F8R87QzWFTPmTAf2fS8X52T/e9lnVkNjwKEj+CZ+UihRpDjW2Lu3W+pb6Q
	27f1qnSeWM/8VD4VFAYM0xDgYVEp6mbzMyzAAImrs6ZTCJ2Ps
X-Google-Smtp-Source: AGHT+IGzhSD+w6oECBIJm/zoRA+a8TQX/977OHgFJOsgHWOfj6pcUAeUpMOteR864pPF5VOP/PRPnw==
X-Received: by 2002:a17:902:dac1:b0:23d:dd5b:886a with SMTP id d9443c01a7336-23e2f2308e3mr55707395ad.0.1752758391456;
        Thu, 17 Jul 2025 06:19:51 -0700 (PDT)
Received: from DESKTOP-GIED850.localdomain ([114.247.113.178])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de4322e7fsm148053315ad.93.2025.07.17.06.19.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 06:19:51 -0700 (PDT)
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
Subject: [PATCH 1/2] selftests/mm: reuse FORCE_READ to replace "asm volatile("" : "+r" (XXX));"
Date: Thu, 17 Jul 2025 21:18:56 +0800
Message-ID: <20250717131857.59909-2-lianux.mm@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250717131857.59909-1-lianux.mm@gmail.com>
References: <20250717131857.59909-1-lianux.mm@gmail.com>
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
---
 tools/testing/selftests/mm/cow.c              | 30 +++++++++----------
 tools/testing/selftests/mm/guard-regions.c    |  7 -----
 tools/testing/selftests/mm/hugetlb-madvise.c  |  5 +---
 tools/testing/selftests/mm/migration.c        | 13 ++++----
 tools/testing/selftests/mm/pagemap_ioctl.c    |  4 +--
 .../selftests/mm/split_huge_page_test.c       |  4 +--
 tools/testing/selftests/mm/vm_util.h          |  7 +++++
 7 files changed, 31 insertions(+), 39 deletions(-)
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
diff --git a/tools/testing/selftests/mm/guard-regions.c b/tools/testing/selftests/mm/guard-regions.c
index 93af3d3760f9..4b76e72e7053  100644
--- a/tools/testing/selftests/mm/guard-regions.c
+++ b/tools/testing/selftests/mm/guard-regions.c
@@ -35,13 +35,6 @@
 static volatile sig_atomic_t signal_jump_set;
 static sigjmp_buf signal_jmp_buf;
 
-/*
- * Ignore the checkpatch warning, we must read from x but don't want to do
- * anything with it in order to trigger a read page fault. We therefore must use
- * volatile to stop the compiler from optimising this away.
- */
-#define FORCE_READ(x) (*(volatile typeof(x) *)x)
-
 /*
  * How is the test backing the mapping being tested?
  */
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
diff --git a/tools/testing/selftests/mm/vm_util.h b/tools/testing/selftests/mm/vm_util.h
index 2b154c287591..c20298ae98ea  100644
--- a/tools/testing/selftests/mm/vm_util.h
+++ b/tools/testing/selftests/mm/vm_util.h
@@ -18,6 +18,13 @@
 #define PM_SWAP                       BIT_ULL(62)
 #define PM_PRESENT                    BIT_ULL(63)
 
+/*
+ * Ignore the checkpatch warning, we must read from x but don't want to do
+ * anything with it in order to trigger a read page fault. We therefore must use
+ * volatile to stop the compiler from optimising this away.
+ */
+#define FORCE_READ(x) (*(volatile typeof(x) *)x)
+
 extern unsigned int __page_size;
 extern unsigned int __page_shift;
 
-- 
2.43.0


