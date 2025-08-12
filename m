Return-Path: <linux-kernel+bounces-764160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F30BCB21EB2
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 09:03:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD2BE17237F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 07:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A70682D6E6A;
	Tue, 12 Aug 2025 07:02:54 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22B2F2D47E9
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 07:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754982174; cv=none; b=l9onuRPu0m9mQXIX0iP1UGxu81hyJrGxjeTuoJPJmcfhrDp4cwJeBDs8v2u6uens42PzsPq+jk6x3Ztz89D9/GS+05gTpZKJ01EY95Ru0aySag0JBRoRkVvdc/8pIVTQn7gJ3eiZHS2GQ/gDAlQ5cEtiFrjGqoT3hozvstlTEjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754982174; c=relaxed/simple;
	bh=rJI6GJqjzYFrgsi3ZRJtttpnAlbMsxZuMSC48kWS+OQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uYBHE9tME9L+culfeyyULeqwhBA9jD40d0J+NbNodFNT1Qt9jhcYdz0xRoTz+J0E5mZ48KzONsxCDnux1/CpZ/8A449CH4M/s5mps47bIDF9OdzOgwPnE7XmgLGAiPY2gWOoqT23mP6jG3fqVLthabvz2OwnfaZlK2C2zlRy8gE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 487ef602774a11f0b29709d653e92f7d-20250812
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_SJ_LANG
	HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE, HR_SJ_PHRASE_LEN
	HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME, IP_TRUSTED
	SRC_TRUSTED, DN_TRUSTED, SA_UNTRUSTED, SA_LOWREP, SA_EXISTED
	SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS, CIE_BAD, CIE_GOOD
	CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO, GTI_C_BU, AMN_T1
	AMN_GOOD, AMN_C_TI, AMN_C_BU, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:689d0434-3aae-4dee-8b29-5e7c5f653dfb,IP:10,
	URL:0,TC:0,Content:0,EDM:25,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:30
X-CID-INFO: VERSION:1.1.45,REQID:689d0434-3aae-4dee-8b29-5e7c5f653dfb,IP:10,UR
	L:0,TC:0,Content:0,EDM:25,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:30
X-CID-META: VersionHash:6493067,CLOUDID:1b11dcd03c34d8f7846d53ee1d225875,BulkI
	D:250812150244YJCELPZJ,BulkQuantity:0,Recheck:0,SF:19|24|44|66|72|78|102,T
	C:nil,Content:0|50,EDM:5,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:n
	il,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: 487ef602774a11f0b29709d653e92f7d-20250812
X-User: liuqiqi@kylinos.cn
Received: from localhost.localdomain [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <liuqiqi@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 921748466; Tue, 12 Aug 2025 15:02:17 +0800
From: liuqiqi@kylinos.cn
To: akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	liuqiqi <liuqiqi@kylinos.cn>
Subject: [PATCH] mm:fix duplicate accounting of free pages in should_reclaim_retry()
Date: Tue, 12 Aug 2025 15:02:10 +0800
Message-Id: <20250812070210.1624218-1-liuqiqi@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: liuqiqi <liuqiqi@kylinos.cn>

In the zone_reclaimable_pages() function, if the page counts for
NR_ZONE_INACTIVE_FILE, NR_ZONE_ACTIVE_FILE, NR_ZONE_INACTIVE_ANON,
and NR_ZONE_ACTIVE_ANON are all zero,
the function returns the number of free pages as the result.

In this case, when should_reclaim_retry() calculates reclaimable pages,
it will inadvertently double-count the free pages in its accounting.

static inline bool
should_reclaim_retry(gfp_t gfp_mask, unsigned order,
                     struct alloc_context *ac, int alloc_flags,
                     bool did_some_progress, int *no_progress_loops)
{
        ...
                available = reclaimable = zone_reclaimable_pages(zone);
                available += zone_page_state_snapshot(zone, NR_FREE_PAGES);

Signed-off-by: liuqiqi <liuqiqi@kylinos.cn>
---
 mm/vmscan.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 34410d24dc15..a9aaefdba7a2 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -393,14 +393,7 @@ unsigned long zone_reclaimable_pages(struct zone *zone)
 	if (can_reclaim_anon_pages(NULL, zone_to_nid(zone), NULL))
 		nr += zone_page_state_snapshot(zone, NR_ZONE_INACTIVE_ANON) +
 			zone_page_state_snapshot(zone, NR_ZONE_ACTIVE_ANON);
-	/*
-	 * If there are no reclaimable file-backed or anonymous pages,
-	 * ensure zones with sufficient free pages are not skipped.
-	 * This prevents zones like DMA32 from being ignored in reclaim
-	 * scenarios where they can still help alleviate memory pressure.
-	 */
-	if (nr == 0)
-		nr = zone_page_state_snapshot(zone, NR_FREE_PAGES);
+
 	return nr;
 }
 
@@ -6417,7 +6410,7 @@ static bool allow_direct_reclaim(pg_data_t *pgdat)
 		return true;
 
 	for_each_managed_zone_pgdat(zone, pgdat, i, ZONE_NORMAL) {
-		if (!zone_reclaimable_pages(zone))
+		if (!zone_reclaimable_pages(zone) && zone_page_state_snapshot(zone, NR_FREE_PAGES))
 			continue;
 
 		pfmemalloc_reserve += min_wmark_pages(zone);
-- 
2.25.1


