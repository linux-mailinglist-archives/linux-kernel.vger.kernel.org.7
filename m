Return-Path: <linux-kernel+bounces-733513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ACB7B075AC
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 14:31:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA50F3AD304
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 12:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AC2B2459D2;
	Wed, 16 Jul 2025 12:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LAEygI24"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28ED32E36EE
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 12:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752669104; cv=none; b=AFm8izgyHm9TaAQzD4w0ConmQnCw+Z7x/9tZqHEmvgbyWdmMz4i6gxtRZJbCEGdny2jDHqiSUvcnnTLghTVtkj6p17xKtsolXP57y2Uao4k8KZT8hDVxyUbNUyeuKZQLoi6uAR22jJz7713y5CUQmMikHLF0UNa1QgokU3NymFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752669104; c=relaxed/simple;
	bh=AHYwoda0yODK6u1Y1BxqFJfaJHtJCOWgwjMytu4rCRE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uuJJp1s6nH7fzQ4JQuPdfdhDQXbWLxor+GpXvYr+EaL5aSEDiIQNRaVj+s2O0nW3scMfXQyOC7R/xYz1rZ/WvFnvuQOoK8SmZQZgHx2Jrgl7ESK1BxF/8TxYOgtgifDA+IwsPP1yB0K1cPE0BRG6Wjvi5Oewcjfj3Ssd5tW+jZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LAEygI24; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-237311f5a54so55866195ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 05:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752669101; x=1753273901; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BGI0YgYPPw3TwBjMrstcYcCGleC1yncKTJwSRIuwNNw=;
        b=LAEygI24Cs5t6ukyUzD9Uk9X4m8NEhQuewpTjcy/yQ9Phks0k7729dlRzCUU5q2JP6
         QRyczuIc2Ut+weEoo8dWhNmt5auOK3QfjHPtoqFSubdSVfKQq7cJhdTVM3VQTqn/izCu
         GixmIxksXRtyB316Dyj3RqJEknfBhPghO4j/qar3wXQoZATyzvlRcRKJy0vz9fgsQACc
         W/YNmOrNZCqxVU+W0xjMiX2sLTjlvRGlZqrwmVqap08y1sQLcPkGMsDG0L/jWAtJwsk3
         p+/0g9fxH+xdrKZXLv9arBVNAq1F0u61G6lKrZWCoeCaVOx6dFGbdhKHbkn5ngqIXynz
         M9uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752669101; x=1753273901;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BGI0YgYPPw3TwBjMrstcYcCGleC1yncKTJwSRIuwNNw=;
        b=v6jASuX7cTgRLSkc5jtlQtCGfQfgd3uEAN4Sl0CloyL1E+72Nm/wffOf4KX/cHRc4D
         1NNBRGjb+wj8HvrvovI0as25hqfxEQ5WEkT2HI2KbkAbOLdn1cOccuPlI5FamG7k4nBP
         x0Y2GutHDlJuFUXOJldybL7wIa6GcFVKTovT6LuoqlwrqX+b4UVxdJMyv9oA1YO14WAD
         pi/KDZP1TkTZJVZZDMYOy3fBMen/q2aD5Q5QjR8g6AeRFpTyBgNZDGtGI8EmwO5/SZXF
         ivr0fxgSdkhSOENY2+4L8TCgHiCb3UgUHI4xRPNGpCllDfHKlFa1hJqEOu5oCtu1+KYq
         +PXw==
X-Forwarded-Encrypted: i=1; AJvYcCXilyMF+rEUgAy1/RtMSPHiSrAr8SjK/ET5hwOEhrMxLsA0hWkyoaRBQ4KdxoftDVbOYH9uVhxCL+jc1AU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpEA6/abTBqGeMY48R/NCyzJBT3Khari0S6U8ux9djAXTULUPx
	AWvnqVoqksdwbHehW6pdtKXFXaJO1ny1hXQVCTtGpmHSeIVLf2XeIY18
X-Gm-Gg: ASbGncsx9tyZLlqAL0tbYwpJDbN+3CW8OkvrOF2UQTHJ8ksxriVyM4bi0hVJuMnWJmC
	vHARqRYgVrzMmao2VXZ/Ahnb37tv7sFpZrOag+/f5+3UQzVCQwn+VstsvGcrRIrXe5q4OcgYtxN
	bgEGSAct7WR3P1dpEckFMS0Nfn2LA0/7hkJ8+pToxCERLLE7/iGmKMOhySO5j0enQPfLRA/91Vy
	cFpUtzIyGDQ51BHbN/6RqJL0yLye9fsB910xjD2CgJXMy3I6bZRLywJWsNlseTsSR8T/UZI0oeL
	XwNyzZUakMtF6wmKGF4+61cW8v4jNPVDMN9lRI6jZpsYFw3gtRqC1+WTNdBFNkCSB0W+ib11hRs
	ovK+W3VeRGLLAR5tzpNmZTWfZnJeYVi7OovOXlH/ZTYrVaVdQ
X-Google-Smtp-Source: AGHT+IFa2LRx8DcK/+V1xn9zjwHCMMLFhQo06pNvTMCmjN4AKVuTXzEHZRBjSeXfYuB4u3FODAOsXA==
X-Received: by 2002:a17:903:1a85:b0:234:b41e:378f with SMTP id d9443c01a7336-23e256b5f80mr39080795ad.15.1752669101103;
        Wed, 16 Jul 2025 05:31:41 -0700 (PDT)
Received: from DESKTOP-GIED850.localdomain ([114.247.113.178])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c9f1d3133sm1428607a91.4.2025.07.16.05.31.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 05:31:40 -0700 (PDT)
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
	jannh@google.com,
	Liam.Howlett@oracle.com,
	shuah@kernel.org,
	vbabka@suse.cz,
	ludovico.zy.wu@gmail.com,
	gkwang@linx-info.com,
	p1ucky0923@gmail.com,
	ryncsn@gmail.com,
	zijing.zhang@proton.me,
	lianux.mm@gmail.com
Subject: [PATCH] selftests/mm: reuse FORCE_READ to replace "asm volatile("" : "+r" (XXX));"
Date: Wed, 16 Jul 2025 20:31:26 +0800
Message-ID: <20250716123126.3851-1-lianux.mm@gmail.com>
X-Mailer: git-send-email 2.43.0
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


