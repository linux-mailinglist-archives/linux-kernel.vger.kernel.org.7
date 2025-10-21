Return-Path: <linux-kernel+bounces-862592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30145BF5B36
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 12:08:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E39633AE8EB
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 10:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27E5E2F1FFB;
	Tue, 21 Oct 2025 10:08:52 +0000 (UTC)
Received: from mta21.hihonor.com (mta21.honor.com [81.70.160.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C977027C866
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 10:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.70.160.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761041331; cv=none; b=qE2Pa5DQhEwx+Dwqv4z1mjJehSABVx3v0M4q+vovsY2ptPcGHRS2zv27qAEwcetXw6XEgwpCSdPLfZdtiz9akbIQQpfT70bg3mVwdio2/4FzPTHa3e+Kv5J5jZJT+YnWMYdbXkLhrWqnT/1sG//d3NQ/NX2n0dzPNOBNChJetMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761041331; c=relaxed/simple;
	bh=ia07eOihL1yqulTo87UwUziS0m5PaMY91zKf1HCvy00=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IiyUuloknGMjf+TXH5Rf9/09MoR6MJWVXM5dFugXqMeX/kkHCmSGOPRM7yRo5tWssXjZ5WcnAM8xXpW7wGpkQkUaCWA57wP86gaQ2LJZojaN5MDTT6lryJXLPsQxk6TAxvaXllifbHCNECEWzD5iGfkAWh4QRQES4MVPpe+C2iY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com; spf=pass smtp.mailfrom=honor.com; arc=none smtp.client-ip=81.70.160.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=honor.com
Received: from w001.hihonor.com (unknown [10.68.25.235])
	by mta21.hihonor.com (SkyGuard) with ESMTPS id 4crSDn73DmzYrxv2;
	Tue, 21 Oct 2025 17:49:13 +0800 (CST)
Received: from a018.hihonor.com (10.68.17.250) by w001.hihonor.com
 (10.68.25.235) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 21 Oct
 2025 17:50:08 +0800
Received: from localhost.localdomain (10.144.20.219) by a018.hihonor.com
 (10.68.17.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 21 Oct
 2025 17:50:08 +0800
From: zhongjinji <zhongjinji@honor.com>
To: <akpm@linux-foundation.org>
CC: <david@redhat.com>, <lorenzo.stoakes@oracle.com>,
	<Liam.Howlett@oracle.com>, <vbabka@suse.cz>, <rppt@kernel.org>,
	<surenb@google.com>, <mhocko@suse.com>, <jackmanb@google.com>,
	<hannes@cmpxchg.org>, <ziy@nvidia.com>, <zhengqi.arch@bytedance.com>,
	<shakeel.butt@linux.dev>, <axelrasmussen@google.com>, <yuanchu@google.com>,
	<weixugc@google.com>, <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
	<liulu.liu@honor.com>, <feng.han@honor.com>, <zhongjinji@honor.com>
Subject: [PATCH] mm/page_alloc: Consider PCP pages as part of pfmemalloc_reserve
Date: Tue, 21 Oct 2025 17:50:04 +0800
Message-ID: <20251021095004.12157-1-zhongjinji@honor.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: w012.hihonor.com (10.68.27.189) To a018.hihonor.com
 (10.68.17.250)

When free_pages becomes critically low, the kernel prevents other tasks
from entering the slow path to ensure that reclaiming tasks can
successfully allocate memory.

This blocking is important to avoid memory contention with reclaiming
tasks. However, in some cases it is unnecessary because the PCP list may
already contain sufficient pages, as freed pages are first placed there
and are not immediately visible to the buddy system.

By accounting PCP pages as part of pfmemalloc_reserve, we can reduce
unnecessary blocking and improve system responsiveness under low-memory
conditions.

Signed-off-by: zhongjinji <zhongjinji@honor.com>
---
 mm/internal.h   |  1 +
 mm/page_alloc.c | 14 ++++++++++++++
 mm/vmscan.c     |  1 +
 3 files changed, 16 insertions(+)

diff --git a/mm/internal.h b/mm/internal.h
index 45b725c3dc03..c8fcee51d662 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -842,6 +842,7 @@ static inline struct page *alloc_frozen_pages_noprof(gfp_t gfp, unsigned int ord
 #define alloc_frozen_pages(...) \
 	alloc_hooks(alloc_frozen_pages_noprof(__VA_ARGS__))
 
+extern int zone_pcp_pages_count(struct zone *zone);
 extern void zone_pcp_reset(struct zone *zone);
 extern void zone_pcp_disable(struct zone *zone);
 extern void zone_pcp_enable(struct zone *zone);
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 1999eb7e7c14..e34031946adb 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -7134,6 +7134,20 @@ void zone_pcp_reset(struct zone *zone)
 	}
 }
 
+int zone_pcp_pages_count(struct zone *zone)
+{
+	struct per_cpu_pages *pcp;
+	int total_pcp_pages = 0;
+	int cpu;
+
+	for_each_online_cpu(cpu) {
+		pcp = per_cpu_ptr(zone->per_cpu_pageset, cpu);
+		total_pcp_pages += pcp->count;
+	}
+
+	return total_pcp_pages;
+}
+
 #ifdef CONFIG_MEMORY_HOTREMOVE
 /*
  * All pages in the range must be in a single zone, must not contain holes,
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 674999999cd0..148f452d9cf5 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -6498,6 +6498,7 @@ static bool allow_direct_reclaim(pg_data_t *pgdat)
 
 		pfmemalloc_reserve += min_wmark_pages(zone);
 		free_pages += zone_page_state_snapshot(zone, NR_FREE_PAGES);
+		free_pages += zone_pcp_pages_count(zone);
 	}
 
 	/* If there are no reserves (unexpected config) then do not throttle */
-- 
2.17.1


