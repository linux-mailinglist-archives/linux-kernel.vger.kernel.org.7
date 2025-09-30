Return-Path: <linux-kernel+bounces-837410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE676BAC42D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 11:22:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77C49321947
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 09:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44E562F5333;
	Tue, 30 Sep 2025 09:22:23 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B5C72617
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 09:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759224142; cv=none; b=WxNROy6xvDi/zLOUEclqlfKtM+A3m94FQohauDtm8GZuNcOqwXzIV3/G/iNrqhV+a5wPhB4OX5zC0i2hx57SX1goiYa42+veOqWlhFIzgTkix2uc6j32/3474jBs1OF06iUD14ddHOjPKQL7q6GY1CUB1qXWFt1B543NY72FYbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759224142; c=relaxed/simple;
	bh=IaABg5Lt+qz1nkla5UgY9HlQPxu+tNKuuYV4V0Lm6aU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ng6QJF8fJ2SMMoyAkll4s+eEcu7vfSkihOkXyhg+fH4Joubg0yxAfSWEcckOuLQUg5U2lVFvH91Zv0YJp2m63t9YWE/qyVOM+1PEfFwK6bxGRbWFfouRw6+3sOAS36A1dN229+wjlFITjwIdZtSkStGtOhbyZbFeN6EeC9CJDCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: ec5771ae9dde11f08b9f7d2eb6caa7cf-20250930
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_EXISTED
	SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:59d1ce55-b7b6-483e-b503-62d061f3287b,IP:10,
	URL:0,TC:0,Content:0,EDM:25,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:30
X-CID-INFO: VERSION:1.1.45,REQID:59d1ce55-b7b6-483e-b503-62d061f3287b,IP:10,UR
	L:0,TC:0,Content:0,EDM:25,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:30
X-CID-META: VersionHash:6493067,CLOUDID:c6ed15d43f0769bedf10a25675148f30,BulkI
	D:250930172204C4MEKGXS,BulkQuantity:0,Recheck:0,SF:19|24|38|44|66|72|78|81
	|82|102|850,TC:nil,Content:0|50,EDM:5,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil
	,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:
	0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: ec5771ae9dde11f08b9f7d2eb6caa7cf-20250930
X-User: husong@kylinos.cn
Received: from localhost.localdomain [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <husong@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 912808686; Tue, 30 Sep 2025 17:22:02 +0800
From: Hu Song <husong@kylinos.cn>
To: Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@suse.cz>
Cc: Song Hu <husong@kylinos.cn>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Brendan Jackman <jackmanb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Zi Yan <ziy@nvidia.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] mm/page_owner: simplify zone iteration logic in init_early_allocated_pages()
Date: Tue, 30 Sep 2025 17:21:52 +0800
Message-Id: <20250930092153.843109-2-husong@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250930092153.843109-1-husong@kylinos.cn>
References: <20250930092153.843109-1-husong@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Song Hu <husong@kylinos.cn>

The current implementation uses nested loops: first iterating over all
online nodes, then over zones within each node. This can be simplified
by using the for_each_populated_zone() macro which directly iterates
through all populated zones.

This change:
1. Removes the intermediate init_zones_in_node() function
2. Simplifies init_early_allocated_pages() to use direct zone iteration
3. Updates init_pages_in_zone() to take only zone parameter and access
   node_id via zone->zone_pgdat

The functionality remains identical, but the code is cleaner and more
maintainable.

Signed-off-by: Song Hu <husong@kylinos.cn>
---
 mm/page_owner.c | 23 +++++------------------
 1 file changed, 5 insertions(+), 18 deletions(-)

diff --git a/mm/page_owner.c b/mm/page_owner.c
index bb88b72b6062..b170b27d87a1 100644
--- a/mm/page_owner.c
+++ b/mm/page_owner.c
@@ -757,7 +757,7 @@ static loff_t lseek_page_owner(struct file *file, loff_t offset, int orig)
 	return file->f_pos;
 }
 
-static void init_pages_in_zone(pg_data_t *pgdat, struct zone *zone)
+static void init_pages_in_zone(struct zone *zone)
 {
 	unsigned long pfn = zone->zone_start_pfn;
 	unsigned long end_pfn = zone_end_pfn(zone);
@@ -824,28 +824,15 @@ static void init_pages_in_zone(pg_data_t *pgdat, struct zone *zone)
 	}
 
 	pr_info("Node %d, zone %8s: page owner found early allocated %lu pages\n",
-		pgdat->node_id, zone->name, count);
-}
-
-static void init_zones_in_node(pg_data_t *pgdat)
-{
-	struct zone *zone;
-	struct zone *node_zones = pgdat->node_zones;
-
-	for (zone = node_zones; zone - node_zones < MAX_NR_ZONES; ++zone) {
-		if (!populated_zone(zone))
-			continue;
-
-		init_pages_in_zone(pgdat, zone);
-	}
+		zone->zone_pgdat->node_id, zone->name, count);
 }
 
 static void init_early_allocated_pages(void)
 {
-	pg_data_t *pgdat;
+	struct zone *zone;
 
-	for_each_online_pgdat(pgdat)
-		init_zones_in_node(pgdat);
+	for_each_populated_zone(zone)
+		init_pages_in_zone(zone);
 }
 
 static const struct file_operations page_owner_fops = {
-- 
2.25.1


