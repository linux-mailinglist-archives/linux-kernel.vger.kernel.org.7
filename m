Return-Path: <linux-kernel+bounces-792974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D36DB3CB11
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 15:08:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6938A1BA2A18
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 13:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AD162253A1;
	Sat, 30 Aug 2025 13:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="jsVT4mLo"
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 189291A2630
	for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 13:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756559279; cv=none; b=TADmt8BU4IVWz5XlX5pmBY/nCteb8DF//ihQqUo3hXDfjH9j3GB8gGlc3CfQiahcA8yrkLKKZpgexmBKEQnzljp6nTAc0CWcV/Du29JXPRyE4wOm9NYJgRxYHdzvzK2oST5j3ySxNZYSvxMNEkxwAzkoNPEqszHvdsNjT9t8aT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756559279; c=relaxed/simple;
	bh=DEKchzH0LMgZ13R/D0kY+t7wVDnufubU1nIcPvhsqf0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jXkH/TajHYAC6o9gtDmT4UB3vZYINGlSc0VzI5avwM5NDnd1TJ95RGrjUMHltLr+fAvNzDmTxTVhDiOUXgNHq3u8E7sflaeWt4u6WxY3mNJHXzOmmJ5SuTjDbukgJQ3JGaDaG5s15CsaSztJh6h+JgIpbCOj9zlvtIYU8e4bjUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=jsVT4mLo; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1756559267; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=ci0oDXmlaFQFSQj8wilCSk/o2gfgpm3mq6AhmC6CDg0=;
	b=jsVT4mLowLyOJ/nD0ggE13M2xS5eKunbTgF8Sx/z8eNmNff1NR1w31gL6h2KD39dDSzDf3+Ocd66k1dgyJwAbLOl1CTufeZM3knE0nYqz1WzdtvCIqX0+jrWI88CcZul1S6cHXMKMlV4YTxFqWXM4bEnjl6VgkU3eWYqSTmmlHM=
Received: from VM20241011-104.tbsite.net(mailfrom:guanghuifeng@linux.alibaba.com fp:SMTPD_---0WmuLZHX_1756559257 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sat, 30 Aug 2025 21:07:47 +0800
From: Guanghui Feng <guanghuifeng@linux.alibaba.com>
To: dwmw2@infradead.org,
	baolu.lu@linux.intel.com,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	alikernel-developer@linux.alibaba.com
Subject: [PATCH] iommu/vt-d: fix iommu pasid memory alloc & max pasid err
Date: Sat, 30 Aug 2025 21:07:37 +0800
Message-ID: <20250830130737.1930726-1-guanghuifeng@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When intel_pasid_alloc_table allocates memory for Scalable Mode PASID
directories, the specified memory page order is incorrect, and an
additional PAGE_SHIFT is added. There is also an error in calculating
the maximum number of supported PASID directories. In the revised
implementation, 1 << (order + PASID_PDE_SHIFT - 3) represents the memory
occupied by the Scalable Mode PASID directory, divided by 8 to represent
the number of PASID directories, and then multiplied by the number of (1
<< PASID_PDE_SHIFT) entries in each PASID directory.

Signed-off-by: Guanghui Feng <guanghuifeng@linux.alibaba.com>
---
 drivers/iommu/intel/pasid.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
index 52f678975da7..9969913b600b 100644
--- a/drivers/iommu/intel/pasid.c
+++ b/drivers/iommu/intel/pasid.c
@@ -61,14 +61,14 @@ int intel_pasid_alloc_table(struct device *dev)
 	size = max_pasid >> (PASID_PDE_SHIFT - 3);
 	order = size ? get_order(size) : 0;
 	dir = iommu_alloc_pages_node_sz(info->iommu->node, GFP_KERNEL,
-					1 << (order + PAGE_SHIFT));
+					1 << order);
 	if (!dir) {
 		kfree(pasid_table);
 		return -ENOMEM;
 	}
 
 	pasid_table->table = dir;
-	pasid_table->max_pasid = 1 << (order + PAGE_SHIFT + 3);
+	pasid_table->max_pasid = 1 << (order + PASID_PDE_SHIFT - 3);
 	info->pasid_table = pasid_table;
 
 	if (!ecap_coherent(info->iommu->ecap))
-- 
2.43.7


