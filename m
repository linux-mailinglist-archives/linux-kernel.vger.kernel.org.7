Return-Path: <linux-kernel+bounces-743730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CFCBB10296
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 10:01:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DE693A5259
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 08:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EF0C25D55D;
	Thu, 24 Jul 2025 08:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="BcSedB6t"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE00F1FF7BC
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 08:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753344069; cv=none; b=R5NvFOK1jv0uQ0FCuDjgWZ+Af23zCqjteLKgaKQ2SsGXAofNlfE21+kh67ciRBeZItR2C+yO0Zs6UiwHIWWszU5MSm0wcsj3p9i4m8rMQqna1YqEngeNhSAPr6Hyuoo4ErPm88wsfOQju0PiXlNCTNv1Q7FvDu7G0ZUktYaGT/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753344069; c=relaxed/simple;
	bh=H248F3FfVjqTs2r/oSTQWUXgzgAo3ltf9tDHyAegPRc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LAUmmWWzHjSlOen+U80OmlgMIxPbJ40Yye6Fl8SUayAu81oB3zU0dWjUP9raCGU2dwmufOhILjPdpLjievt/glYyxdy7SM7bquqdVt45rB0r2f63aMfpOEat0hUHsaRBZmARCk6R7kPY0ESL4eg7vydhwcZwOQiJHWa5Q3oaCUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=BcSedB6t; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 56805290686411f08b7dc59d57013e23-20250724
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=QDGF9T5dTNs+C/JVlj3oE/CVOJhjvBeXRBAQW6usNB8=;
	b=BcSedB6tSKn2tEMmMJiplfjWBmFTmQfxrVosTXKr0KBap5GJJRZzvu0pojphUTFp53ANjPzwIpjF+Ov9BvqqVabpEE7gRROMpVy7Fe7j6VPFoGh90DBNw2Qf4Th9nnOzwZGmEBAKyIz3Srui3jNL6vpfiyOQCTPvd8KNztz7rFs=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.2,REQID:be4002af-0cf9-46b7-8535-38013e8fd5c7,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:9eb4ff7,CLOUDID:af32200f-6968-429c-a74d-a1cce2b698bd,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|50,EDM:-3,IP:ni
	l,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 56805290686411f08b7dc59d57013e23-20250724
Received: from mtkmbs09n1.mediatek.inc [(172.21.101.35)] by mailgw01.mediatek.com
	(envelope-from <akash.tyagi@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 788337271; Thu, 24 Jul 2025 16:01:00 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Thu, 24 Jul 2025 16:00:57 +0800
Received: from mtisdccf01.mediatek.inc (10.18.1.155) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Thu, 24 Jul 2025 16:00:55 +0800
From: akash.tyagi <akash.tyagi@mediatek.com>
To: <akpm@linux-foundation.org>, <vbabka@suse.cz>, <matthias.bgg@gmail.com>,
	<angelogioacchino.delregno@collabora.com>
CC: <surenb@google.com>, <mhocko@suse.com>, <jackmanb@google.com>,
	<hannes@cmpxchg.org>, <ziy@nvidia.com>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>, <wsd_upstream@mediatek.com>,
	<akash.tyagi@mediatek.com>
Subject: [RFC PATCH] mm/page_alloc: Add PCP list for THP CMA
Date: Thu, 24 Jul 2025 13:23:01 +0530
Message-ID: <20250724075301.1151817-1-akash.tyagi@mediatek.com>
X-Mailer: git-send-email 2.18.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Currently, THP CMA pages share PCP lists with UNMOVABLE and RECLAIMABLE
pages. This may result in CMA THP pages being allocated from the PCP
list for other migratetypes. When this occurs, these pages may fail to
be isolated, leading to CMA allocation failures when drivers request
them.

This patch introduces a dedicated PCP list for the THP CMA migratetype,
ensuring that CMA THP pages are not mixed with other migratetypes and
remain available for CMA allocations as intended.

Signed-off-by: akash.tyagi <akash.tyagi@mediatek.com>
---
 include/linux/mmzone.h | 10 ++++++++--
 mm/page_alloc.c        |  5 +++++
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 283913d42d7b..dd93088ce851 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -696,11 +696,17 @@ enum zone_watermarks {
 
 /*
  * One per migratetype for each PAGE_ALLOC_COSTLY_ORDER. Two additional lists
- * are added for THP. One PCP list is used by GPF_MOVABLE, and the other PCP list
- * is used by GFP_UNMOVABLE and GFP_RECLAIMABLE.
+ * are added for THP: one for GFP_MOVABLE, and one for GFP_UNMOVABLE and
+ * GFP_RECLAIMABLE. With CMA enabled, an extra THP PCP list is added for
+ * MIGRATE_CMA, allowing further distinction between MIGRATE_MOVABLE and
+ * MIGRATE_CMA for THP allocations.
  */
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
+#ifdef CONFIG_CMA
+#define NR_PCP_THP 3
+#else
 #define NR_PCP_THP 2
+#endif
 #else
 #define NR_PCP_THP 0
 #endif
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 2ef3c07266b3..35f8041afbcc 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -519,6 +519,11 @@ static inline unsigned int order_to_pindex(int migratetype, int order)
 	if (order > PAGE_ALLOC_COSTLY_ORDER) {
 		VM_BUG_ON(order != HPAGE_PMD_ORDER);
 
+#ifdef CONFIG_CMA
+		if (migratetype == MIGRATE_CMA)
+			return NR_LOWORDER_PCP_LISTS + 2;
+#endif
+
 		movable = migratetype == MIGRATE_MOVABLE;
 
 		return NR_LOWORDER_PCP_LISTS + movable;
-- 
2.18.0


