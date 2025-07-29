Return-Path: <linux-kernel+bounces-749469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A7898B14EC2
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 15:51:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6DC187A457D
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 13:49:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A492519D8A2;
	Tue, 29 Jul 2025 13:51:18 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2826714C588
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 13:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753797078; cv=none; b=pPbYupADq1+SXoHTQ1Vl4kFBXAF8woeRIc/mp4YOf9JKSL0y5TkAcWjOk6sKwhImhOxqUGAx8V/ytMjEgRL7S9ZvJIt5Wjbp3Kl7WLAGG5IiwbzIdIkc/7oGVJsfhB+4EkGDumMrG0MQyMf9Z1QrZLwcDZqbSVYQpN7otunObDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753797078; c=relaxed/simple;
	bh=+57F15aLBaalKE+XctSDfEtEf6goucZpK/er4s0Lvpk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=W2MCjhuoKXMHggmv9Fgb/DigFyUIJYNJ0UhZ2C1p3/78kO4L/y9a6SKs/cw1SPqGHCO6jEhaXDx1moYbPy59nOt5LtxfeHlyk0VArMnbMsoljho8eBWR7FerI/ItiHfZdU7Sp7Smtongh7+yZtR4jVMP+5kEwF/H2u/yB7rLSaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4brxWc1rH3z1R8qK;
	Tue, 29 Jul 2025 21:48:28 +0800 (CST)
Received: from dggpemf500012.china.huawei.com (unknown [7.185.36.8])
	by mail.maildlp.com (Postfix) with ESMTPS id 88B371400D2;
	Tue, 29 Jul 2025 21:51:11 +0800 (CST)
Received: from huawei.com (10.175.124.71) by dggpemf500012.china.huawei.com
 (7.185.36.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 29 Jul
 2025 21:51:10 +0800
From: Zhang Qilong <zhangqilong3@huawei.com>
To: <arnd@arndb.de>, <gregkh@linuxfoundation.org>
CC: <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
	<wangkefeng.wang@huawei.com>, <zhangqilong3@huawei.com>,
	<sunnanyong@huawei.com>
Subject: [PATCH] /dev/zero: try to align PMD_SIZE for private mapping
Date: Tue, 29 Jul 2025 21:49:41 +0800
Message-ID: <20250729134942.900517-1-zhangqilong3@huawei.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 dggpemf500012.china.huawei.com (7.185.36.8)

By default, THP are usually enabled. Mapping /dev/zero with a size
larger than 2MB could achieve performance gains by allocating aligned
address. The mprot_tw4m in libMicro average execution time on arm64:
  - Test case:        mprot_tw4m
  - Before the patch:   22 us
  - After the patch:    17 us

Signed-off-by: Zhang Qilong <zhangqilong3@huawei.com>
---
 drivers/char/mem.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/char/mem.c b/drivers/char/mem.c
index 48839958b0b1..c57327ca9dd6 100644
--- a/drivers/char/mem.c
+++ b/drivers/char/mem.c
@@ -515,10 +515,12 @@ static int mmap_zero(struct file *file, struct vm_area_struct *vma)
 static unsigned long get_unmapped_area_zero(struct file *file,
 				unsigned long addr, unsigned long len,
 				unsigned long pgoff, unsigned long flags)
 {
 #ifdef CONFIG_MMU
+	unsigned long ret;
+
 	if (flags & MAP_SHARED) {
 		/*
 		 * mmap_zero() will call shmem_zero_setup() to create a file,
 		 * so use shmem's get_unmapped_area in case it can be huge;
 		 * and pass NULL for file as in mmap.c's get_unmapped_area(),
@@ -526,10 +528,13 @@ static unsigned long get_unmapped_area_zero(struct file *file,
 		 */
 		return shmem_get_unmapped_area(NULL, addr, len, pgoff, flags);
 	}
 
 	/* Otherwise flags & MAP_PRIVATE: with no shmem object beneath it */
+	ret = thp_get_unmapped_area(file, addr, len, pgoff, flags);
+	if (ret)
+		return ret;
 	return mm_get_unmapped_area(current->mm, file, addr, len, pgoff, flags);
 #else
 	return -ENOSYS;
 #endif
 }
-- 
2.43.0


