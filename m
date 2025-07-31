Return-Path: <linux-kernel+bounces-752096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87435B17128
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 14:27:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D08B3B17D6
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 12:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DFE02C3258;
	Thu, 31 Jul 2025 12:25:20 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84A9F8F66
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 12:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753964720; cv=none; b=qfMVPv4twQHTFchBgH/Zanqmj33dAtQGIHSp8JeYi8OlNXVgVMkUFiML0zv2c4XtYFfKYQ97hx9fGaFQgJmyWgHWwct08ac68MXcmTwbJuDECu8O+CWdcvF/E11odkA6AdbNE6QaIJA+IxRgUQG5tUTmDDhSQJurk5H3KmZvWpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753964720; c=relaxed/simple;
	bh=ne/wEhm2SsX3GajukXHa6Bh4mXJyWnemx4jMRZuVa00=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NYoHul6EzvmUFmGvo5nYQdHbr2gaDJ7TLPBthrde4PV9y8qxnZVSasQ2UVUk3KyN94RZY4vh1eNzZX1jTTskytNTk26pGzYExIPikDli0PLgzOR9+HgwzIByvtx7j8OJd2d+fSHTgKhB++Wi2qU05mgP8yDeirc6xniGvTV5m7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4bt7Td12hlzPtBZ;
	Thu, 31 Jul 2025 20:20:53 +0800 (CST)
Received: from dggpemf500012.china.huawei.com (unknown [7.185.36.8])
	by mail.maildlp.com (Postfix) with ESMTPS id 3400918007F;
	Thu, 31 Jul 2025 20:25:07 +0800 (CST)
Received: from huawei.com (10.175.124.71) by dggpemf500012.china.huawei.com
 (7.185.36.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 31 Jul
 2025 20:25:06 +0800
From: Zhang Qilong <zhangqilong3@huawei.com>
To: <arnd@arndb.de>, <gregkh@linuxfoundation.org>, <akpm@linux-foundation.org>
CC: <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
	<lorenzo.stoakes@oracle.com>, <wangkefeng.wang@huawei.com>,
	<sunnanyong@huawei.com>, Zhang Qilong <zhangqilong3@huawei.com>, David
 Hildenbrand <david@redhat.com>
Subject: [PATCH v4] /dev/zero: try to align PMD_SIZE for private mapping
Date: Thu, 31 Jul 2025 20:23:05 +0800
Message-ID: <20250731122305.2669090-1-zhangqilong3@huawei.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 dggpemf500012.china.huawei.com (7.185.36.8)

Attempt to map aligned to huge page size for private mapping which
could achieve performance gains, the mprot_tw4m in libMicro average
execution time on arm64:
  - Test case:        mprot_tw4m
  - Before the patch:   22 us
  - After the patch:    17 us

If THP config is not set, we fall back to system page size mappings.

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Tested-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Acked-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Zhang Qilong <zhangqilong3@huawei.com>
---
v4:
- collect Tested-by and Reviewed-by
- add comment for CONFIG_MMU #endif

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
index 48839958b0b1..34b815901b20 100644
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
+#endif /* CONFIG_MMU */
 
 static ssize_t write_full(struct file *file, const char __user *buf,
 			  size_t count, loff_t *ppos)
 {
 	return -ENOSPC;
-- 
2.43.0


