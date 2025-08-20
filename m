Return-Path: <linux-kernel+bounces-777277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C308B2D79D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 11:11:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A39627B7DB2
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 09:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A74B2E1758;
	Wed, 20 Aug 2025 09:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Ue2WAyMS"
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6CCE2E03FE
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 09:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755680875; cv=none; b=PokoFeG5U8iYc3oph9c7eXxrFI/+VRG+z55yjWNMT+6z65azDbmo0Yk67Wl6l/20xJVJ4ak74aeGfmvbNLEazFhZBJ/IRoQKRxBywlzb4k58nrn7sJClFRoUItzPsAb26Roy8SIF4M+nobA2qOOsAFANkFy18zlUsEguIWuprpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755680875; c=relaxed/simple;
	bh=O/EL/GABzezzJnhdCns5+dqaFA0xQGxrWt+V6vBqbzA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H53a63bD+1+syGEApE5OGBRQCsTKbcCzZqFw3JPhkH6CTP1d4G6PEA86aFnzT/sYRgkXreLuXhShCx2J8f6wJKiDjgj3+VUkR4EvCLInJRQV9akYncqscNdqcfV5xlIOSeAP4QceM3LAipBtvj4tZOUyUae+vxAZ7Nh5RMtWgPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Ue2WAyMS; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1755680869; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=k0BMZl4FO1A/3YqzLq6Cu8hUlXulJA4evFI5qXofcb4=;
	b=Ue2WAyMSnWxBSuqN+JfaZ3fR+nRVSxhymHNuwfUPg3Y0xfupfZefzVJp3+u6fo6WWROGqs9/Gix4DR6PvTO73u0X1KB1lfl3jVcUDvyiKZPULh1r18dFJxT/S1u/SqiRNkIZnMWvW/QCkap+S++bgPzC0ykghd8ONFQ1FJ2Gk+s=
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WmBYU.i_1755680866 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 20 Aug 2025 17:07:47 +0800
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
Subject: [RFC PATCH 10/11] selftests: mm: implement the mTHP hugepage check helper
Date: Wed, 20 Aug 2025 17:07:21 +0800
Message-ID: <85ad632e5ac5844a4e8a6266bcd647932e4d0b11.1755677674.git.baolin.wang@linux.alibaba.com>
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

Implement the mTHP hugepage check helper.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 tools/testing/selftests/mm/vm_util.c | 52 +++++++++++++++++++++++++---
 1 file changed, 48 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/mm/vm_util.c b/tools/testing/selftests/mm/vm_util.c
index 853c8a4caa1d..d0f8aa66b988 100644
--- a/tools/testing/selftests/mm/vm_util.c
+++ b/tools/testing/selftests/mm/vm_util.c
@@ -16,6 +16,10 @@
 #define SMAP_FILE_PATH "/proc/self/smaps"
 #define STATUS_FILE_PATH "/proc/self/status"
 #define MAX_LINE_LENGTH 500
+#define PAGEMAP_PATH "/proc/self/pagemap"
+#define KPAGEFLAGS_PATH "/proc/kpageflags"
+#define GET_ORDER(nr_pages)    (31 - __builtin_clz(nr_pages))
+#define NR_ORDERS 20
 
 unsigned int __page_size;
 unsigned int __page_shift;
@@ -353,7 +357,7 @@ char *__get_smap_entry(void *addr, const char *pattern, char *buf, size_t len)
 	return entry;
 }
 
-bool __check_huge(void *addr, char *pattern, int nr_hpages,
+static bool __check_pmd_huge(void *addr, char *pattern, int nr_hpages,
 		  uint64_t hpage_size)
 {
 	char buffer[MAX_LINE_LENGTH];
@@ -371,19 +375,59 @@ bool __check_huge(void *addr, char *pattern, int nr_hpages,
 	return thp == (nr_hpages * (hpage_size >> 10));
 }
 
+static bool check_large_folios(void *addr, unsigned long size, int nr_hpages, uint64_t hpage_size)
+{
+	int pagesize = getpagesize();
+	int order = GET_ORDER(hpage_size / pagesize);
+	int pagemap_fd, kpageflags_fd;
+	int orders[NR_ORDERS], status;
+	bool ret = false;
+
+	memset(orders, 0, sizeof(int) * NR_ORDERS);
+
+	pagemap_fd = open(PAGEMAP_PATH, O_RDONLY);
+	if (pagemap_fd == -1)
+		ksft_exit_fail_msg("read pagemap fail\n");
+
+	kpageflags_fd = open(KPAGEFLAGS_PATH, O_RDONLY);
+	if (kpageflags_fd == -1) {
+		close(pagemap_fd);
+		ksft_exit_fail_msg("read kpageflags fail\n");
+	}
+
+	status = gather_folio_orders(addr, size, pagemap_fd,
+				kpageflags_fd, orders, NR_ORDERS);
+	if (status)
+		goto out;
+
+	if (orders[order] == nr_hpages)
+		ret = true;
+
+out:
+	close(pagemap_fd);
+	close(kpageflags_fd);
+	return ret;
+}
+
 bool check_huge_anon(void *addr, unsigned long size, int nr_hpages, uint64_t hpage_size)
 {
-	return __check_huge(addr, "AnonHugePages: ", nr_hpages, hpage_size);
+	if (hpage_size == read_pmd_pagesize())
+		return __check_pmd_huge(addr, "AnonHugePages: ", nr_hpages, hpage_size);
+
+	return check_large_folios(addr, size, nr_hpages, hpage_size);
 }
 
 bool check_huge_file(void *addr, int nr_hpages, uint64_t hpage_size)
 {
-	return __check_huge(addr, "FilePmdMapped:", nr_hpages, hpage_size);
+	return __check_pmd_huge(addr, "FilePmdMapped:", nr_hpages, hpage_size);
 }
 
 bool check_huge_shmem(void *addr, unsigned long size, int nr_hpages, uint64_t hpage_size)
 {
-	return __check_huge(addr, "ShmemPmdMapped:", nr_hpages, hpage_size);
+	if (hpage_size == read_pmd_pagesize())
+		return __check_pmd_huge(addr, "ShmemPmdMapped:", nr_hpages, hpage_size);
+
+	return check_large_folios(addr, size, nr_hpages, hpage_size);
 }
 
 int64_t allocate_transhuge(void *ptr, int pagemap_fd)
-- 
2.43.5


