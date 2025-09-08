Return-Path: <linux-kernel+bounces-805515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC87BB4898A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 12:06:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F16373C266C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 10:06:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C75F82FD7B9;
	Mon,  8 Sep 2025 10:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kaxMWrVE"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D4A22FC024
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 10:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757325858; cv=none; b=f4JSK+bYPKGJAkddjVSyyBd0N6QiukwMxA686ypHkiSJJ005gYVErunHzzYBHlSZMyNBL1N0j5mrJWcDYYA5vXEiu9SWegbdtz3ls7RLsTP2DBDewfmDVaatNa08IB7fqUib0c7HRAKPjAC2shB5FZd+cuvd26S6Ag/r/VCIBHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757325858; c=relaxed/simple;
	bh=DtR8SDDCly6r1G6ayYYEPEjUZxb3ilDJJeU/YL6BMsk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=OtuFb3qAQFhOLqLzPgWvNKcV1lUQph+R58DYCvRWTY9ynx6hNpg5Yiz5jCsvTubq4JKTTro7Ia9hihvUTY7+uuZFVEByz7D/COfla7vjqn3WMSHhy/R6UZjUD56j/x9kZ1XYNLL9+hDvwOIU2aeoOHyvLRl0Q0YnhxmqSYuSgOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kaxMWrVE; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-76e2ea21430so273791b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 03:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757325855; x=1757930655; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JspKwq6xlMOVT2wn/868+r3JLwxN6lzk7a1hKsFzoaU=;
        b=kaxMWrVEh8NEcxPSWJudCZLP6n/XQ/uNgwHcLhciUutku+yb4LuI7dQdtVVDI/7k11
         dozcKoEHY4zWbSnqz6WJmkZ6L7RD+Fo3U2PJp9FMkekSqcJtKdrS4ZZ33TR1XZoo3sTb
         t6+wyIPJWbq0O9VXoS5Is/5AJjpCRu5KXOfYTbYHbQEfxyT9aDbNfpD//9kiPGmKfE+F
         5UNzmAC30VZ1VmS0nxm2/itOznqOsQ8phAomcYFuWvhel2qBMIbDnwhwHRTb8oxeAJVg
         gLRHk70IuDsjTI+jwNDOdcbFihtPtCqHnM9vPClwPY/gNxP0mzQSp50fyZxUpnrxWytn
         VAAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757325855; x=1757930655;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JspKwq6xlMOVT2wn/868+r3JLwxN6lzk7a1hKsFzoaU=;
        b=YGiavAbw3MZL63bxbVEz+gU8OQSdcnbOnaWVUG8Vyh97I2cAI4jLR61nt+HtVY6V4q
         WIHk1iQ87siDfNv7NHEcn0t8OGUe68F0eAi0V1Yqqc7iiueHhKKtXEYWSm4YshqIGE1M
         vu/0Gnw/VqG6J10MT3O74AwVXzzVvYNyNXXPDkbj5jnP3eV+28CoFBvRgZj6/UhlBAdn
         ZteI/vKN93tr0JKWGxsCfjE4FQh1wXSrtXwwhNeuQFGBqsUYyiY3ik/yR3Sj51ADo+BR
         RvOP0WmBDzH8el85EYXSmmfbZmroSae/PtWyklf3MTTvCGrDtZ2xaVtdE+vpfBQ3Qbs5
         gCnQ==
X-Forwarded-Encrypted: i=1; AJvYcCUu/B9fzWhURULCiTk15bOK38ki0JLhZfLBDU9SoBAx5u9EmKWlv+wUin2O2dWATqClidFPvWGj8k1RCRs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz88/l3cpXzt+O2AqaZj37RAOxkglANNSt/b9DPo4Bf/qKHE73w
	oRt2gakNBn3pmg2Y89KxCi/w16FDOVuvqvpiuFdsqQDo+4qcNeSYIg2T
X-Gm-Gg: ASbGnctXqUFjncKH6Gv0YwenrisG9ml2Coa5OQvL+36vdKb2YWwDfTDMnlXysHl7Gk1
	F+UzHIp6ZFSZbReE/JQNz2AgmBeB46essBMLri7BHfOfFq1jTf4FKhDYjIdDMrbX1TsKrUeqgU6
	nid+uTyLtQBFWBPqj/0NTOBXDClgzySooLAUKKU4kh6DRIUelfOtWI5Kedjgvvs8foQVtvTNAmk
	e7mxpov1yg4pkfo/TLhjf2V4bhhxIb7A8OTsaz6loN9UBjiLsum2SVaeEuDJWAGLxUd/61bY4ho
	K9mpBmjjNaUMDyn+sE9KFYiK+lYhncwyvepaXrm6YFwqUax7NQPXeHIqLCupTPZXOtt38mI6Y32
	uDerQyZWI7Zq+L25+a1RNJsi1Z6DT1Q==
X-Google-Smtp-Source: AGHT+IGpbsRm4gpTKuncaeM+adwFbGp9mwK+cNXTZVo6TmiguOksGzlU/8b3HMiz0iYEBD4vLPbV1w==
X-Received: by 2002:a05:6a00:17a7:b0:771:f892:719d with SMTP id d2e1a72fcca58-7742deaeaaamr5109046b3a.7.1757325855349;
        Mon, 08 Sep 2025 03:04:15 -0700 (PDT)
Received: from pcw-MS-7D22 ([115.145.175.37])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-772517906a8sm23110454b3a.96.2025.09.08.03.04.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 03:04:15 -0700 (PDT)
Date: Mon, 8 Sep 2025 19:04:10 +0900
From: Chanwon Park <flyinrm@gmail.com>
To: akpm@linux-foundation.org, vbabka@suse.cz, surenb@google.com,
	mhocko@suse.com, jackmanb@google.com, hannes@cmpxchg.org,
	ziy@nvidia.com, david@redhat.com, zhengqi.arch@bytedance.com,
	shakeel.butt@linux.dev, lorenzo.stoakes@oracle.com
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, flyinrm@gmail.com
Subject: [PATCH] mm: re-enable kswapd when memory pressure subsides or
 demotion is toggled
Message-ID: <aL6qGi69jWXfPc4D@pcw-MS-7D22>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

If kswapd fails to reclaim pages from a node MAX_RECLAIM_RETRIES in a
row, kswapd on that node gets disabled. That is, the system won't wakeup
kswapd for that node until page reclamation is observed at least once.
That reclamation is mostly done by direct reclaim, which in turn enables
kswapd back.

However, on systems with CXL memory nodes, workloads with high anon page
usage can disable kswapd indefinitely, without triggering direct
reclaim. This can be reproduced with following steps:

   numa node 0   (32GB memory, 48 CPUs)
   numa node 2~5 (512GB CXL memory, 128GB each)
   (numa node 1 is disabled)
   swap space 8GB

   1) Set /sys/kernel/mm/demotion_enabled to 0.
   2) Set /proc/sys/kernel/numa_balancing to 0.
   3) Run a process that allocates and random accesses 500GB of anon
      pages.
   4) Let the process exit normally.

During 3), free memory on node 0 gets lower than low watermark, and
kswapd runs and depletes swap space. Then, kswapd fails consecutively
and gets disabled. Allocation afterwards happens on CXL memory, so node
0 never gains more memory pressure to trigger direct reclaim.

After 4), kswapd on node 0 remains disabled, and tasks running on that
node are unable to swap. If you turn on NUMA_BALANCING_MEMORY_TIERING
and demotion now, it won't work properly since kswapd is disabled.

To mitigate this problem, reset kswapd_failures to 0 on following
conditions:

   a) ZONE_BELOW_HIGH bit of a zone in hopeless node with a fallback
      memory node gets cleared.
   b) demotion_enabled is changed from false to true.

Rationale for a):
   ZONE_BELOW_HIGH bit being cleared might be a sign that the node may
   be reclaimable afterwards. This won't help much if the memory-hungry
   process keeps running without freeing anything, but at least the node
   will go back to reclaimable state when the process exits.

Rationale for b):
   When demotion_enabled is false, kswapd can only reclaim anon pages by
   swapping them out to swap space. If demotion_enabled is turned on,
   kswapd can demote anon pages to another node for reclaiming. So, the
   original failure count for determining reclaimability is no longer
   valid.

Since kswapd_failures resets may be missed by ++ operation, it is
changed from int to atomic_t.

Signed-off-by: Chanwon Park <flyinrm@gmail.com>
---
 include/linux/mmzone.h |  2 +-
 mm/memory-tiers.c      | 12 ++++++++++++
 mm/page_alloc.c        | 17 ++++++++++++++++-
 mm/show_mem.c          |  3 ++-
 mm/vmscan.c            | 14 +++++++-------
 mm/vmstat.c            |  2 +-
 6 files changed, 39 insertions(+), 11 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 283913d42d7b..68db1dbf375d 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -1411,7 +1411,7 @@ typedef struct pglist_data {
 	int kswapd_order;
 	enum zone_type kswapd_highest_zoneidx;
 
-	int kswapd_failures;		/* Number of 'reclaimed == 0' runs */
+	atomic_t kswapd_failures;	/* Number of 'reclaimed == 0' runs */
 
 #ifdef CONFIG_COMPACTION
 	int kcompactd_max_order;
diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
index fc14fe53e9b7..f8f8f66fc4c0 100644
--- a/mm/memory-tiers.c
+++ b/mm/memory-tiers.c
@@ -949,11 +949,23 @@ static ssize_t demotion_enabled_store(struct kobject *kobj,
 				      const char *buf, size_t count)
 {
 	ssize_t ret;
+	bool before = numa_demotion_enabled;
 
 	ret = kstrtobool(buf, &numa_demotion_enabled);
 	if (ret)
 		return ret;
 
+	/*
+	 * Reset kswapd_failures statistics. They may no longer be
+	 * valid since the policy for kswapd has changed.
+	 */
+	if (before == false && numa_demotion_enabled == true) {
+		struct pglist_data *pgdat;
+
+		for_each_online_pgdat(pgdat)
+			atomic_set(&pgdat->kswapd_failures, 0);
+	}
+
 	return count;
 }
 
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 2ef3c07266b3..827c9a949987 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -2681,8 +2681,23 @@ static void free_frozen_page_commit(struct zone *zone,
 				   pcp, pindex);
 		if (test_bit(ZONE_BELOW_HIGH, &zone->flags) &&
 		    zone_watermark_ok(zone, 0, high_wmark_pages(zone),
-				      ZONE_MOVABLE, 0))
+				      ZONE_MOVABLE, 0)) {
+			struct pglist_data *pgdat = zone->zone_pgdat;
 			clear_bit(ZONE_BELOW_HIGH, &zone->flags);
+
+			/*
+			 * Assume that memory pressure on this node is gone
+			 * and may be in a reclaimable state. If a memory
+			 * fallback node exists, direct reclaim may not have
+			 * been triggered, leaving 'hopeless node' stay in
+			 * that state for a while. Let kswapd work again by
+			 * resetting kswapd_failures.
+			 */
+			if (atomic_read(&pgdat->kswapd_failures)
+			    >= MAX_RECLAIM_RETRIES &&
+			    next_memory_node(pgdat->node_id) < MAX_NUMNODES)
+				atomic_set(&pgdat->kswapd_failures, 0);
+		}
 	}
 }
 
diff --git a/mm/show_mem.c b/mm/show_mem.c
index 0cf8bf5d832d..18b3b32a9ccf 100644
--- a/mm/show_mem.c
+++ b/mm/show_mem.c
@@ -280,7 +280,8 @@ static void show_free_areas(unsigned int filter, nodemask_t *nodemask, int max_z
 #endif
 			K(node_page_state(pgdat, NR_PAGETABLE)),
 			K(node_page_state(pgdat, NR_SECONDARY_PAGETABLE)),
-			str_yes_no(pgdat->kswapd_failures >= MAX_RECLAIM_RETRIES),
+			str_yes_no(atomic_read(&pgdat->kswapd_failures)
+				   >= MAX_RECLAIM_RETRIES),
 			K(node_page_state(pgdat, NR_BALLOON_PAGES)));
 	}
 
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 424412680cfc..e09d69b1f873 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -526,7 +526,7 @@ static bool skip_throttle_noprogress(pg_data_t *pgdat)
 	 * If kswapd is disabled, reschedule if necessary but do not
 	 * throttle as the system is likely near OOM.
 	 */
-	if (pgdat->kswapd_failures >= MAX_RECLAIM_RETRIES)
+	if (atomic_read(&pgdat->kswapd_failures) >= MAX_RECLAIM_RETRIES)
 		return true;
 
 	/*
@@ -5093,7 +5093,7 @@ static void lru_gen_shrink_node(struct pglist_data *pgdat, struct scan_control *
 	blk_finish_plug(&plug);
 done:
 	if (sc->nr_reclaimed > reclaimed)
-		pgdat->kswapd_failures = 0;
+		atomic_set(&pgdat->kswapd_failures, 0);
 }
 
 /******************************************************************************
@@ -6167,7 +6167,7 @@ static void shrink_node(pg_data_t *pgdat, struct scan_control *sc)
 	 * successful direct reclaim run will revive a dormant kswapd.
 	 */
 	if (reclaimable)
-		pgdat->kswapd_failures = 0;
+		atomic_set(&pgdat->kswapd_failures, 0);
 	else if (sc->cache_trim_mode)
 		sc->cache_trim_mode_failed = 1;
 }
@@ -6479,7 +6479,7 @@ static bool allow_direct_reclaim(pg_data_t *pgdat)
 	int i;
 	bool wmark_ok;
 
-	if (pgdat->kswapd_failures >= MAX_RECLAIM_RETRIES)
+	if (atomic_read(&pgdat->kswapd_failures) >= MAX_RECLAIM_RETRIES)
 		return true;
 
 	for_each_managed_zone_pgdat(zone, pgdat, i, ZONE_NORMAL) {
@@ -6880,7 +6880,7 @@ static bool prepare_kswapd_sleep(pg_data_t *pgdat, int order,
 		wake_up_all(&pgdat->pfmemalloc_wait);
 
 	/* Hopeless node, leave it to direct reclaim */
-	if (pgdat->kswapd_failures >= MAX_RECLAIM_RETRIES)
+	if (atomic_read(&pgdat->kswapd_failures) >= MAX_RECLAIM_RETRIES)
 		return true;
 
 	if (pgdat_balanced(pgdat, order, highest_zoneidx)) {
@@ -7148,7 +7148,7 @@ static int balance_pgdat(pg_data_t *pgdat, int order, int highest_zoneidx)
 	}
 
 	if (!sc.nr_reclaimed)
-		pgdat->kswapd_failures++;
+		atomic_inc(&pgdat->kswapd_failures);
 
 out:
 	clear_reclaim_active(pgdat, highest_zoneidx);
@@ -7407,7 +7407,7 @@ void wakeup_kswapd(struct zone *zone, gfp_t gfp_flags, int order,
 		return;
 
 	/* Hopeless node, leave it to direct reclaim if possible */
-	if (pgdat->kswapd_failures >= MAX_RECLAIM_RETRIES ||
+	if (atomic_read(&pgdat->kswapd_failures) >= MAX_RECLAIM_RETRIES ||
 	    (pgdat_balanced(pgdat, order, highest_zoneidx) &&
 	     !pgdat_watermark_boosted(pgdat, highest_zoneidx))) {
 		/*
diff --git a/mm/vmstat.c b/mm/vmstat.c
index a78d70ddeacd..3c0ea637ed85 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1826,7 +1826,7 @@ static void zoneinfo_show_print(struct seq_file *m, pg_data_t *pgdat,
 	seq_printf(m,
 		   "\n  node_unreclaimable:  %u"
 		   "\n  start_pfn:           %lu",
-		   pgdat->kswapd_failures >= MAX_RECLAIM_RETRIES,
+		   atomic_read(&pgdat->kswapd_failures) >= MAX_RECLAIM_RETRIES,
 		   zone->zone_start_pfn);
 	seq_putc(m, '\n');
 }
-- 
2.34.1


