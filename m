Return-Path: <linux-kernel+bounces-864186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D614BFA1FC
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 07:52:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 796333B4925
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 05:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 492FF23AB9C;
	Wed, 22 Oct 2025 05:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="EiZaeGwM"
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB0A11E32A2
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 05:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761112340; cv=none; b=AonQCWjmSHHDrl0U7adsKDeqYWJXcYp6dBAdvb7OwpM/TOmcqhu7n+EizIlWJl59+moLrOeBnoeCOSFyGEqxKdEFmHxTyI6ImqgIbhI93UbA3n9YeORT8Hy4/rVRdVOUfxKP6NToG6s3JlHZQW9Nk650wrhcO+OK5mpzBuyfKcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761112340; c=relaxed/simple;
	bh=z4LJ+saDognmGUEsy3LaSC2i7+YeWVc3VhlwvvbgSkg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Fpdqt0v+4KiSQEBgQnnoItQG6EZAFPdo4JfaEZIBy/G3//Fmt+yoe0hZsy1v2SoLUJL9QOxxQNe95C6ubOJeQTJNI+mFp3bmESHr03n2yIOj5rxXEVyhg1xanz43ST0uOjS1vFObAo001wIZIjIls0HxxrATmzOZ/pzzuHF4AWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=EiZaeGwM; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761112325;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=/qxx1k5IYLmQZumkvBGkcglkCRUo8y4lQwXOlsBbvoQ=;
	b=EiZaeGwM0IaQbYj3RL0f+9OQnELa6Cz8Qt3JwAgQs/8//eTvERyrPNoPhMUfo3MIssIRs2
	SJ057rN9lPNxmnqwGbeG8+5T4HlW5meSdvXrJiDqOS7t7eodyPjHfBk7s2bdt8yzlFRtSp
	Etvfrkd3MKIst4K5QgeCwdTa4TKULG0=
From: Leon Hwang <leon.hwang@linux.dev>
To: stable@vger.kernel.org
Cc: akpm@linux-foundation.org,
	david@redhat.com,
	lorenzo.stoakes@oracle.com,
	shuah@kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Leon Hwang <leon.hwang@linux.dev>,
	Lance Yang <lance.yang@linux.dev>
Subject: [PATCH 6.1.y] selftests/mm: Move default_huge_page_size to vm_util.c
Date: Wed, 22 Oct 2025 13:51:38 +0800
Message-ID: <20251022055138.375042-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Fix the build error:

map_hugetlb.c: In function 'main':
map_hugetlb.c:79:25: warning: implicit declaration of function 'default_huge_page_size' [-Wimplicit-function-declaration]
   79 |         hugepage_size = default_huge_page_size();
      |                         ^~~~~~~~~~~~~~~~~~~~~~
/usr/bin/ld: /tmp/ccYOogvJ.o: in function 'main':
map_hugetlb.c:(.text+0x114): undefined reference to 'default_huge_page_size'

According to the latest selftests, 'default_huge_page_size' has been
moved to 'vm_util.c'. So fix the error by the same way.

Reviewed-by: Lance Yang <lance.yang@linux.dev>
Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 tools/testing/selftests/vm/Makefile      |  1 +
 tools/testing/selftests/vm/userfaultfd.c | 24 ------------------------
 tools/testing/selftests/vm/vm_util.c     | 21 +++++++++++++++++++++
 tools/testing/selftests/vm/vm_util.h     |  1 +
 4 files changed, 23 insertions(+), 24 deletions(-)

diff --git a/tools/testing/selftests/vm/Makefile b/tools/testing/selftests/vm/Makefile
index 192ea3725c5c..ed90deebef0d 100644
--- a/tools/testing/selftests/vm/Makefile
+++ b/tools/testing/selftests/vm/Makefile
@@ -100,6 +100,7 @@ $(OUTPUT)/madv_populate: vm_util.c
 $(OUTPUT)/soft-dirty: vm_util.c
 $(OUTPUT)/split_huge_page_test: vm_util.c
 $(OUTPUT)/userfaultfd: vm_util.c
+$(OUTPUT)/map_hugetlb: vm_util.c
 
 ifeq ($(MACHINE),x86_64)
 BINARIES_32 := $(patsubst %,$(OUTPUT)/%,$(BINARIES_32))
diff --git a/tools/testing/selftests/vm/userfaultfd.c b/tools/testing/selftests/vm/userfaultfd.c
index 297f250c1d95..4751b28eba18 100644
--- a/tools/testing/selftests/vm/userfaultfd.c
+++ b/tools/testing/selftests/vm/userfaultfd.c
@@ -1674,30 +1674,6 @@ static int userfaultfd_stress(void)
 		|| userfaultfd_events_test() || userfaultfd_minor_test();
 }
 
-/*
- * Copied from mlock2-tests.c
- */
-unsigned long default_huge_page_size(void)
-{
-	unsigned long hps = 0;
-	char *line = NULL;
-	size_t linelen = 0;
-	FILE *f = fopen("/proc/meminfo", "r");
-
-	if (!f)
-		return 0;
-	while (getline(&line, &linelen, f) > 0) {
-		if (sscanf(line, "Hugepagesize:       %lu kB", &hps) == 1) {
-			hps <<= 10;
-			break;
-		}
-	}
-
-	free(line);
-	fclose(f);
-	return hps;
-}
-
 static void set_test_type(const char *type)
 {
 	if (!strcmp(type, "anon")) {
diff --git a/tools/testing/selftests/vm/vm_util.c b/tools/testing/selftests/vm/vm_util.c
index fc5743bc1283..613cc61602c9 100644
--- a/tools/testing/selftests/vm/vm_util.c
+++ b/tools/testing/selftests/vm/vm_util.c
@@ -161,6 +161,27 @@ bool check_huge_shmem(void *addr, int nr_hpages, uint64_t hpage_size)
 	return __check_huge(addr, "ShmemPmdMapped:", nr_hpages, hpage_size);
 }
 
+unsigned long default_huge_page_size(void)
+{
+	unsigned long hps = 0;
+	char *line = NULL;
+	size_t linelen = 0;
+	FILE *f = fopen("/proc/meminfo", "r");
+
+	if (!f)
+		return 0;
+	while (getline(&line, &linelen, f) > 0) {
+		if (sscanf(line, "Hugepagesize:       %lu kB", &hps) == 1) {
+			hps <<= 10;
+			break;
+		}
+	}
+
+	free(line);
+	fclose(f);
+	return hps;
+}
+
 static bool check_vmflag(void *addr, const char *flag)
 {
 	char buffer[MAX_LINE_LENGTH];
diff --git a/tools/testing/selftests/vm/vm_util.h b/tools/testing/selftests/vm/vm_util.h
index 470f85fe9594..a4439db0d6f8 100644
--- a/tools/testing/selftests/vm/vm_util.h
+++ b/tools/testing/selftests/vm/vm_util.h
@@ -11,4 +11,5 @@ uint64_t read_pmd_pagesize(void);
 bool check_huge_anon(void *addr, int nr_hpages, uint64_t hpage_size);
 bool check_huge_file(void *addr, int nr_hpages, uint64_t hpage_size);
 bool check_huge_shmem(void *addr, int nr_hpages, uint64_t hpage_size);
+unsigned long default_huge_page_size(void);
 bool softdirty_supported(void);
-- 
2.43.0


