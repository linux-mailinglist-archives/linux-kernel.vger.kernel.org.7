Return-Path: <linux-kernel+bounces-750120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 07257B15781
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 04:23:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 149F54E0DA5
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 02:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7703185E7F;
	Wed, 30 Jul 2025 02:23:39 +0000 (UTC)
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDAE717BBF
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 02:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753842219; cv=none; b=c+DeGIZSbmTZOC83NQ9Eq9iRTpFaMnb1sjcob67uPy9Xcp+nc5KgZub7alm8NvQag2GEM9mbAwdRwWgxVNk+cFWKOGxqaR2Hw+5BSxdGDVo6B/1kfmhkZdu8D6Txe1v2jpb2vdRlKqfShSS+sqde4QVO42g4GelgEOTaRsOJhVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753842219; c=relaxed/simple;
	bh=WT9jXiKICMBwYJJ8VqCRuGTbcsh5xCQdpQ7WpVDO4NQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sQuAQfvWxwJ9ft3AyEmO1+BhBBVmH5JvhvzDgaExzJzSGKI1CLaEWVk5rmyx4z7c88Twyffe9ZClTu3BjuP4XLt3O2RfbiRs+2JtewY4rt28GXxBQBD6MSCxqGF4HNv1eaW2cPi0VuWjjPO/F7c5XLrdcpW2RlvLeq3YiVWhcRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4bsGHv3N4wz27j6G;
	Wed, 30 Jul 2025 10:24:27 +0800 (CST)
Received: from dggpemf500012.china.huawei.com (unknown [7.185.36.8])
	by mail.maildlp.com (Postfix) with ESMTPS id 0A3B51401F1;
	Wed, 30 Jul 2025 10:23:26 +0800 (CST)
Received: from huawei.com (10.175.124.71) by dggpemf500012.china.huawei.com
 (7.185.36.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 30 Jul
 2025 10:23:25 +0800
From: Zhang Qilong <zhangqilong3@huawei.com>
To: <arnd@arndb.de>, <gregkh@linuxfoundation.org>
CC: <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
	<lorenzo.stoakes@oracle.com>, <wangkefeng.wang@huawei.com>,
	<zhangqilong3@huawei.com>, <sunnanyong@huawei.com>
Subject: [PATCH v2] /dev/zero: try to align PMD_SIZE for private mapping
Date: Wed, 30 Jul 2025 10:22:06 +0800
Message-ID: <20250730022206.1349706-1-zhangqilong3@huawei.com>
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

If THP is enable, mapping /dev/zero with a size larger than 2MB could
achieve performance gains by allocating aligned address. The mprot_tw4m
in libMicro average execution time on arm64:
  - Test case:        mprot_tw4m
  - Before the patch:   22 us
  - After the patch:    17 us

Signed-off-by: Zhang Qilong <zhangqilong3@huawei.com>
---
 drivers/char/mem.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/char/mem.c b/drivers/char/mem.c
index 48839958b0b1..3699e716b84e 100644
--- a/drivers/char/mem.c
+++ b/drivers/char/mem.c
@@ -525,12 +525,20 @@ static unsigned long get_unmapped_area_zero(struct file *file,
 		 * so as not to confuse shmem with our handle on "/dev/zero".
 		 */
 		return shmem_get_unmapped_area(NULL, addr, len, pgoff, flags);
 	}
 
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+	/*
+	 * Attempt to map aligned to huge page size if possible, otherwise we
+	 * fall back to system page size mappings in thp_get_unmapped_area.
+	 */
+	return thp_get_unmapped_area(file, addr, len, pgoff, flags);
+#else
 	/* Otherwise flags & MAP_PRIVATE: with no shmem object beneath it */
 	return mm_get_unmapped_area(current->mm, file, addr, len, pgoff, flags);
+#endif
 #else
 	return -ENOSYS;
 #endif
 }
 
-- 
2.43.0


