Return-Path: <linux-kernel+bounces-751803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C63B5B16DAA
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 10:38:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46E8F1AA7F2F
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 08:38:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CF1829346F;
	Thu, 31 Jul 2025 08:38:23 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DC75C13D
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 08:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753951102; cv=none; b=s1UZbcHzQ/ZTgzDr/wLxzIgb4LaUJM736GW2kxLW4sDPkBiOFBony4YMk/HRrqGg6bwYVoBu+d6gdOvYR6rS7ZqmgfyMiVI8yQccfhyL6XwboU2tA/GSfsHxkzIK4yBP4QsdGp8C7NY4yLlHBgEuf+wE3wAd1oJeNDfFu0AzEi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753951102; c=relaxed/simple;
	bh=hQxwf+6TKN0OY6hguF/NVFS4AxYdy4a8bOOSVFXMso8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fHjN5DYyyPN8CjWh0OvtHA2JGzgAbMSH3SSqGf3yxTLDq86U5ELeHvb3CgQlUGlRJQbla2TfvUxyNmXJHiaZ58My1jC8mDqkwA8p7vzKELUpoze8gc+z/oFtgYwZcM4KtvsLCVzX9/iCLCxb6iuLWDJJHH9YVc73Avdt2l9MTaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4bt2V15H6Gz23jd5;
	Thu, 31 Jul 2025 16:35:53 +0800 (CST)
Received: from dggpemf500012.china.huawei.com (unknown [7.185.36.8])
	by mail.maildlp.com (Postfix) with ESMTPS id C78091A016C;
	Thu, 31 Jul 2025 16:38:16 +0800 (CST)
Received: from huawei.com (10.175.124.71) by dggpemf500012.china.huawei.com
 (7.185.36.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 31 Jul
 2025 16:38:15 +0800
From: Zhang Qilong <zhangqilong3@huawei.com>
To: <arnd@arndb.de>, <gregkh@linuxfoundation.org>, <akpm@linux-foundation.org>
CC: <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
	<lorenzo.stoakes@oracle.com>, <wangkefeng.wang@huawei.com>,
	<sunnanyong@huawei.com>, Zhang Qilong <zhangqilong3@huawei.com>, David
 Hildenbrand <david@redhat.com>
Subject: [PATCH v3] /dev/zero: try to align PMD_SIZE for private mapping
Date: Thu, 31 Jul 2025 16:36:55 +0800
Message-ID: <20250731083655.1558076-1-zhangqilong3@huawei.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 dggpemf500012.china.huawei.com (7.185.36.8)

Attempt to map aligned to huge page size for private mapping which
could achieve performance gains, the mprot_tw4m in libMicro average
execution time on arm64:
  - Test case:        mprot_tw4m
  - Before the patch:   22 us
  - After the patch:    17 us

If THP config is not set, we fall back to system page size mappings.

Acked-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Zhang Qilong <zhangqilong3@huawei.com>
---
v3:
- collect Acked-by
- factor out the #ifdef CONFIG_MMU in get_unmapped_area_zero(), per Lorenzo
- explicitly use #ifdef CONFIG_TRANSPARENT_HUGEPAGE, per Lorenzo and Matthew

v2:
- add comments on code suggested by Lorenzo
- use IS_ENABLED to check THP config

 drivers/char/mem.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/char/mem.c b/drivers/char/mem.c
index 48839958b0b1..b7c4dbe4d2c1 100644
--- a/drivers/char/mem.c
+++ b/drivers/char/mem.c
@@ -510,31 +510,44 @@ static int mmap_zero(struct file *file, struct vm_area_struct *vma)
 		return shmem_zero_setup(vma);
 	vma_set_anonymous(vma);
 	return 0;
 }
 
+#ifndef CONFIG_MMU
+static unsigned long get_unmapped_area_zero(struct file *file,
+				unsigned long addr, unsigned long len,
+				unsigned long pgoff, unsigned long flags)
+{
+	return -ENOSYS;
+}
+#else
 static unsigned long get_unmapped_area_zero(struct file *file,
 				unsigned long addr, unsigned long len,
 				unsigned long pgoff, unsigned long flags)
 {
-#ifdef CONFIG_MMU
 	if (flags & MAP_SHARED) {
 		/*
 		 * mmap_zero() will call shmem_zero_setup() to create a file,
 		 * so use shmem's get_unmapped_area in case it can be huge;
 		 * and pass NULL for file as in mmap.c's get_unmapped_area(),
 		 * so as not to confuse shmem with our handle on "/dev/zero".
 		 */
 		return shmem_get_unmapped_area(NULL, addr, len, pgoff, flags);
 	}
 
-	/* Otherwise flags & MAP_PRIVATE: with no shmem object beneath it */
-	return mm_get_unmapped_area(current->mm, file, addr, len, pgoff, flags);
+	/*
+	 * Otherwise flags & MAP_PRIVATE: with no shmem object beneath it,
+	 * attempt to map aligned to huge page size if possible, otherwise we
+	 * fall back to system page size mappings.
+	 */
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+	return thp_get_unmapped_area(file, addr, len, pgoff, flags);
 #else
-	return -ENOSYS;
+	return mm_get_unmapped_area(current->mm, file, addr, len, pgoff, flags);
 #endif
 }
+#endif
 
 static ssize_t write_full(struct file *file, const char __user *buf,
 			  size_t count, loff_t *ppos)
 {
 	return -ENOSPC;
-- 
2.43.0


