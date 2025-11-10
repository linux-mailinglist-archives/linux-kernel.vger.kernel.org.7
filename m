Return-Path: <linux-kernel+bounces-894308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A43BC49B9D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 00:20:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 833F234ADE7
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 23:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D54D30101B;
	Mon, 10 Nov 2025 23:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BgAStWnG"
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7DA01B0413
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 23:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762816834; cv=none; b=rgBDNaQ8zgYIluDNskp0PXzV+MGRFbQVq5vGX0OImReJx9iBJ4r5zAzpGVAOZ5/gTrCX/IABNYtoPg+ZgJ/PrLMLL7u7Hzzv32SNbOLwx0GbBBRyraDUWk0f3P8zMesyNnyVNAoEb0chC0rnIn7XSFqGp4IPkUZptZCg/h4r0mU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762816834; c=relaxed/simple;
	bh=Jv5n1HUnW+ynjpRt1C/uf4EPEqjigyQEXbnueX0w5Rc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QdaH8MlZ+jKNWIh8px4gVfWryuJZ+b62he4SbU3MuiWg2rB0MFoU72/1gs42J4vSS35X4me29+1dYnPVdC3/RLiTlxKSC7lOdtlFHcCqLt9X5ofNxOdiYnX21syMS8f2LsebGJR9+h21UP2BCrikKatWrb7ZocaMRoiE1tg1A3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BgAStWnG; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762816831;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9otsU5sTTsv5iDT1hLkwZC6VR8+kvlYsVUkWcUV3yUw=;
	b=BgAStWnGWu+R++HQPUGOOHPlqRzdxWNJ0t59sVFAJf0Bbvv09PqCZGD04X5NPEYjczxOVu
	jskKx8vaHfikcuEhDCvFDPEaIM+ICUbyL8lklWpFjP8EoEknW3w+mRhSTi2/WREjj1BfDY
	LLQmumQ5TKsmYPQqq7ZVuNy/GmrDuvk=
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Harry Yoo <harry.yoo@oracle.com>,
	Qi Zheng <qi.zheng@linux.dev>,
	Vlastimil Babka <vbabka@suse.cz>,
	linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>
Subject: [PATCH 1/4] memcg: use mod_node_page_state to update stats
Date: Mon, 10 Nov 2025 15:20:05 -0800
Message-ID: <20251110232008.1352063-2-shakeel.butt@linux.dev>
In-Reply-To: <20251110232008.1352063-1-shakeel.butt@linux.dev>
References: <20251110232008.1352063-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The memcg stats are safe against irq (and nmi) context and thus does not
require disabling irqs. However some code paths for memcg stats also
update the node level stats and use irq unsafe interface and thus
require the users to disable irqs. However node level stats, on
architectures with HAVE_CMPXCHG_LOCAL (all major ones), has interface
which does not require irq disabling. Let's move memcg stats code to
start using that interface for node level stats.

Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
---
 include/linux/memcontrol.h | 2 +-
 include/linux/vmstat.h     | 4 ++--
 mm/memcontrol.c            | 6 +++---
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 8c0f15e5978f..f82fac2fd988 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1408,7 +1408,7 @@ static inline void __mod_lruvec_kmem_state(void *p, enum node_stat_item idx,
 {
 	struct page *page = virt_to_head_page(p);
 
-	__mod_node_page_state(page_pgdat(page), idx, val);
+	mod_node_page_state(page_pgdat(page), idx, val);
 }
 
 static inline void mod_lruvec_kmem_state(void *p, enum node_stat_item idx,
diff --git a/include/linux/vmstat.h b/include/linux/vmstat.h
index c287998908bf..11a37aaa4dd9 100644
--- a/include/linux/vmstat.h
+++ b/include/linux/vmstat.h
@@ -557,7 +557,7 @@ static inline void mod_lruvec_page_state(struct page *page,
 static inline void __mod_lruvec_state(struct lruvec *lruvec,
 				      enum node_stat_item idx, int val)
 {
-	__mod_node_page_state(lruvec_pgdat(lruvec), idx, val);
+	mod_node_page_state(lruvec_pgdat(lruvec), idx, val);
 }
 
 static inline void mod_lruvec_state(struct lruvec *lruvec,
@@ -569,7 +569,7 @@ static inline void mod_lruvec_state(struct lruvec *lruvec,
 static inline void __lruvec_stat_mod_folio(struct folio *folio,
 					 enum node_stat_item idx, int val)
 {
-	__mod_node_page_state(folio_pgdat(folio), idx, val);
+	mod_node_page_state(folio_pgdat(folio), idx, val);
 }
 
 static inline void lruvec_stat_mod_folio(struct folio *folio,
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 025da46d9959..f4b8a6414ed3 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -770,7 +770,7 @@ void __mod_lruvec_state(struct lruvec *lruvec, enum node_stat_item idx,
 			int val)
 {
 	/* Update node */
-	__mod_node_page_state(lruvec_pgdat(lruvec), idx, val);
+	mod_node_page_state(lruvec_pgdat(lruvec), idx, val);
 
 	/* Update memcg and lruvec */
 	if (!mem_cgroup_disabled())
@@ -789,7 +789,7 @@ void __lruvec_stat_mod_folio(struct folio *folio, enum node_stat_item idx,
 	/* Untracked pages have no memcg, no lruvec. Update only the node */
 	if (!memcg) {
 		rcu_read_unlock();
-		__mod_node_page_state(pgdat, idx, val);
+		mod_node_page_state(pgdat, idx, val);
 		return;
 	}
 
@@ -815,7 +815,7 @@ void __mod_lruvec_kmem_state(void *p, enum node_stat_item idx, int val)
 	 * vmstats to keep it correct for the root memcg.
 	 */
 	if (!memcg) {
-		__mod_node_page_state(pgdat, idx, val);
+		mod_node_page_state(pgdat, idx, val);
 	} else {
 		lruvec = mem_cgroup_lruvec(memcg, pgdat);
 		__mod_lruvec_state(lruvec, idx, val);
-- 
2.47.3


