Return-Path: <linux-kernel+bounces-750439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E4128B15B5C
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 11:20:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C99F7A71F8
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 09:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FD6D26CE08;
	Wed, 30 Jul 2025 09:20:44 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB6AA635
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 09:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753867244; cv=none; b=eOS/mMjX42g2IZmfM8/E1/9q36Mn4fqds60ydqiz2fWP1W0VsMPOqzRsbC0vUQv4uL8uHeaBHgDdYH7wzp3Qw1czo0aMtltdkk1FTnSId7DYywcviquEc36I22F4wv53hFVGccbhw+KggrBj0eui4Xi2cL9R85PySX3xYyuyzYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753867244; c=relaxed/simple;
	bh=58QFvsk52yymtHAcL08UPhhWdeUkb9614x0+E6nSf5w=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=h2FxFTMsnp2S5nYVAOOXwy12VS/SYmddXoPnMrJj+AqMR8vbaIHmMPWhtAYORYRnSHM230g9O5eGZXiUP9PvNbwUt3ypHUb+BnEU2oFIWDSCnlKmtdj2JoTnnmTkjarLo1gQadd/8cynn/OLENB1QVt0rO6MrsfhS06tnfCG1Xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4bsRRC75LvzdcBV;
	Wed, 30 Jul 2025 17:16:23 +0800 (CST)
Received: from dggpemf500012.china.huawei.com (unknown [7.185.36.8])
	by mail.maildlp.com (Postfix) with ESMTPS id 87E8E1402CC;
	Wed, 30 Jul 2025 17:20:37 +0800 (CST)
Received: from huawei.com (10.175.124.71) by dggpemf500012.china.huawei.com
 (7.185.36.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 30 Jul
 2025 17:20:36 +0800
From: Zhang Qilong <zhangqilong3@huawei.com>
To: <arnd@arndb.de>, <gregkh@linuxfoundation.org>
CC: <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
	<lorenzo.stoakes@oracle.com>, <david@redhat.com>,
	<wangkefeng.wang@huawei.com>, <sunnanyong@huawei.com>, Zhang Qilong
	<zhangqilong3@huawei.com>
Subject: [PATCH resend v2] /dev/zero: try to align PMD_SIZE for private mapping
Date: Wed, 30 Jul 2025 17:19:05 +0800
Message-ID: <20250730091905.383353-1-zhangqilong3@huawei.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 dggpemf500012.china.huawei.com (7.185.36.8)

Attempt to map aligned to huge page size for private mapping which
could achieve performance gains, the mprot_tw4m in libMicro average
execution time on arm64:
  - Test case:        mprot_tw4m
  - Before the patch:   22 us
  - After the patch:    17 us

Signed-off-by: Zhang Qilong <zhangqilong3@huawei.com>
---
v2:
- Add comments on code suggested by Lorenzo
- Use IS_ENABLED to check THP config

 drivers/char/mem.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/char/mem.c b/drivers/char/mem.c
index 48839958b0b1..c27cc89bd02d 100644
--- a/drivers/char/mem.c
+++ b/drivers/char/mem.c
@@ -525,11 +525,18 @@ static unsigned long get_unmapped_area_zero(struct file *file,
 		 * so as not to confuse shmem with our handle on "/dev/zero".
 		 */
 		return shmem_get_unmapped_area(NULL, addr, len, pgoff, flags);
 	}
 
-	/* Otherwise flags & MAP_PRIVATE: with no shmem object beneath it */
+	/*
+	 * Otherwise flags & MAP_PRIVATE: with no shmem object beneath it,
+	 * attempt to map aligned to huge page size if possible, otherwise we
+	 * fall back to system page size mappings.
+	 */
+	if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE))
+		return thp_get_unmapped_area(file, addr, len, pgoff, flags);
+
 	return mm_get_unmapped_area(current->mm, file, addr, len, pgoff, flags);
 #else
 	return -ENOSYS;
 #endif
 }
-- 
2.43.0


