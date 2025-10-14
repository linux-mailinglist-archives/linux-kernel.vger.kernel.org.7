Return-Path: <linux-kernel+bounces-852880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CCE5BDA273
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 16:52:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CC78188702A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 14:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71CF22FF17A;
	Tue, 14 Oct 2025 14:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GpqmWF6I"
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F51D2FDC21
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 14:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760453416; cv=none; b=ex//QlARxBiwkIARL5zCEWLSSvfVVLA5Qm4v9L9Smdox8O+egcTi3iDr2CxOY/xxfk82JwersscF+meTOixW+Mkbhvq+NLimewTJ+HS1h6lJf7XlFNydPw9zdO5or5Z6iApvtxB0kWUX3TVC5VyGMavWKtDMBrCQLqAIiK0PQYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760453416; c=relaxed/simple;
	bh=bCS44l/LvBBitJnnk4ob4XEeLl5p3PQtQuAfvJHhxEs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nAiw+pNrKJ9rnB5V4JBoXKtCpmrOQ0q92HNwnXGzk6sCf1fYYYL5+GGu27YmbiM3SYyX3YGWdnnLm082qWPhVLQ/80r9gkNgkG3lT/gIcxlfT9hr4hz6eBXeCuzE1l1fiHLLrg3GhpDnKJQxLXl2NsdG5KkaSeBW306uMR3xSIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GpqmWF6I; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-77f9fb2d9c5so48427387b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 07:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760453414; x=1761058214; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DaKsUlhHVYzGr/qaa9OrQYufYtYEbalh3sXBUEUgogU=;
        b=GpqmWF6IH8FpV7onafHxL4+ZwpY9CDLtKqWINfOgYYwlZVfmMOM4sBh4E3ZI42qWR0
         QdbFv3JuhZbIQvoFyGNiYXbVRcN0XzBQJivB0/lsFBdkKTM7DmIc0oOiKNuw9yPHkpdW
         UEwyGeeBpEZ7eZMT8VqkxMbq+aryAiDJgFmoII3EfnK77rCagLMYwNnVA+85/WX42oS8
         VHjID2/el8g2DUOxoG7NEwwXIS+n5dx4ewfuFKkQPMBJ9FvN/84qlTw/Ne3tdSSzqIJ3
         /k9stFMznMWxeDVvez6Vw1GoLrHNs6jdHnCkPORF3c/z7uNIEg6jcLsPZxeX4b3uHFMR
         AVDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760453414; x=1761058214;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DaKsUlhHVYzGr/qaa9OrQYufYtYEbalh3sXBUEUgogU=;
        b=b3nsitWkiE9ATl4Ss9kQ4J0MHVpNHxXIESMFyayCWe3/cLRc8t519CV69SUpIqDEnB
         lP0duiBLoj0X3VvndSFrmWevyYhJXA28GgeVBF0BTSCq15jFgEWhzgoH6Rvdzyk8Jb0B
         RedbnUyPxwHSZZ28d945foS3NG+qqTcapUSS7JPhUg9VSM1eXZ/Al+X4EOE9UUOsBFjV
         Bw4WN6bFgIvcGUhUdvzKwBK9vtqA3uELXqDIzjdtuoEdFjakZqBakR2TDWLn1GXLU2W8
         b3o8n+HWBtcBxKIeEfdDhbCRufHS8/BGud2gaEzGGOw7m0xH0PAUg8Wiz9QuSHyjZ9eF
         JIvg==
X-Forwarded-Encrypted: i=1; AJvYcCUEQCdaN6XhAJoZl0mNKxWdhieWP6bCv3cv/USEI8SMwU4JxBXfJa8z2Ry8wuOfY8gu9jJF3zg96D60Ieg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNUFsZYYBGxiVDPpv59HFWOXIG6chtZ9yiDjiEHbm8kDQTwkQ+
	dqZ7JONuK2RYStMOANmLJ47PrIjRmarefQJ8B8BS2eC72vtFO+pnUg1p
X-Gm-Gg: ASbGnct7/f5UhD3WpSCj1C6YSlRipq21fK1PDthDf5MHbISpNSVxdOOsh2EFjJuafS9
	D2QG1PQ6fMAgwrzZgsrCedT2HophI7MrRpDLievheVusuxDFfBbK7EEYVpUb/PN7BgYBYUCXbmE
	TkYtMJ5VprJ7DfmCHg7Tysi29TGxtmDtaGzvAjufSo0SWrhKmhY2FUOxUHu/iRP2g4IJc284nxK
	dmkrhbD9WRXJoWEkp+URLMgOW6SoDFPxS88Ee+pX4XbjQGoOzHNWFnR3B9errbiTeoqYcH9bFUT
	Dj0KwP8Js+QtYTkOxzdKVSIqh5wHa1+J28YWXF3auJTaQRvZu7n4ST/IR5v2RbQ7dn5UTGRgqni
	BJV2jkTfDbEKnJjhcVkkL7GI1fy8zkAnccLwC0nblZYs80evQnGDzLTBwoN7lexbp7ypPXPQKaT
	jY8kqZVd05
X-Google-Smtp-Source: AGHT+IF24AJ/mCnHHT8gWUZWqNOL84P3lZeFu7B9AvcqJEw2IIOt8BRDcj1YLWF4MZHoT7gLYf+rwg==
X-Received: by 2002:a05:690c:3687:b0:781:5636:c1fb with SMTP id 00721157ae682-7815636c367mr7065537b3.38.1760453413642;
        Tue, 14 Oct 2025 07:50:13 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:56::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78106e34136sm34138527b3.25.2025.10.14.07.50.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 07:50:13 -0700 (PDT)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Chris Mason <clm@fb.com>,
	Kiryl Shutsemau <kirill@shutemov.name>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Brendan Jackman <jackmanb@google.com>,
	David Hildenbrand <david@redhat.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Zi Yan <ziy@nvidia.com>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	kernel-team@meta.com
Subject: [PATCH v5 1/3] mm/page_alloc/vmstat: Simplify refresh_cpu_vm_stats change detection
Date: Tue, 14 Oct 2025 07:50:08 -0700
Message-ID: <20251014145011.3427205-2-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251014145011.3427205-1-joshua.hahnjy@gmail.com>
References: <20251014145011.3427205-1-joshua.hahnjy@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, refresh_cpu_vm_stats returns an int, indicating how many
changes were made during its updates. Using this information, callers
like vmstat_update can heuristically determine if more work will be done
in the future.

However, all of refresh_cpu_vm_stats's callers either (a) ignore the
result, only caring about performing the updates, or (b) only care about
whether changes were made, but not *how many* changes were made.

Simplify the code by returning a bool instead to indicate if updates
were made.

In addition, simplify fold_diff and decay_pcp_high to return a bool
for the same reason.

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
Reviewed-by: SeongJae Park <sj@kernel.org>
Signed-off-by: Joshua Hahn <joshua.hahnjy@gmail.com>
---
 include/linux/gfp.h |  2 +-
 mm/page_alloc.c     |  8 ++++----
 mm/vmstat.c         | 28 +++++++++++++++-------------
 3 files changed, 20 insertions(+), 18 deletions(-)

diff --git a/include/linux/gfp.h b/include/linux/gfp.h
index 0ceb4e09306c..f46b066c7661 100644
--- a/include/linux/gfp.h
+++ b/include/linux/gfp.h
@@ -386,7 +386,7 @@ extern void free_pages(unsigned long addr, unsigned int order);
 #define free_page(addr) free_pages((addr), 0)
 
 void page_alloc_init_cpuhp(void);
-int decay_pcp_high(struct zone *zone, struct per_cpu_pages *pcp);
+bool decay_pcp_high(struct zone *zone, struct per_cpu_pages *pcp);
 void drain_zone_pages(struct zone *zone, struct per_cpu_pages *pcp);
 void drain_all_pages(struct zone *zone);
 void drain_local_pages(struct zone *zone);
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 600d9e981c23..bbc3282fdffc 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -2557,10 +2557,10 @@ static int rmqueue_bulk(struct zone *zone, unsigned int order,
  * Called from the vmstat counter updater to decay the PCP high.
  * Return whether there are addition works to do.
  */
-int decay_pcp_high(struct zone *zone, struct per_cpu_pages *pcp)
+bool decay_pcp_high(struct zone *zone, struct per_cpu_pages *pcp)
 {
 	int high_min, to_drain, batch;
-	int todo = 0;
+	bool todo = false;
 
 	high_min = READ_ONCE(pcp->high_min);
 	batch = READ_ONCE(pcp->batch);
@@ -2573,7 +2573,7 @@ int decay_pcp_high(struct zone *zone, struct per_cpu_pages *pcp)
 		pcp->high = max3(pcp->count - (batch << CONFIG_PCP_BATCH_SCALE_MAX),
 				 pcp->high - (pcp->high >> 3), high_min);
 		if (pcp->high > high_min)
-			todo++;
+			todo = true;
 	}
 
 	to_drain = pcp->count - pcp->high;
@@ -2581,7 +2581,7 @@ int decay_pcp_high(struct zone *zone, struct per_cpu_pages *pcp)
 		spin_lock(&pcp->lock);
 		free_pcppages_bulk(zone, to_drain, pcp, 0);
 		spin_unlock(&pcp->lock);
-		todo++;
+		todo = true;
 	}
 
 	return todo;
diff --git a/mm/vmstat.c b/mm/vmstat.c
index bb09c032eecf..98855f31294d 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -771,25 +771,25 @@ EXPORT_SYMBOL(dec_node_page_state);
 
 /*
  * Fold a differential into the global counters.
- * Returns the number of counters updated.
+ * Returns whether counters were updated.
  */
 static int fold_diff(int *zone_diff, int *node_diff)
 {
 	int i;
-	int changes = 0;
+	bool changed = false;
 
 	for (i = 0; i < NR_VM_ZONE_STAT_ITEMS; i++)
 		if (zone_diff[i]) {
 			atomic_long_add(zone_diff[i], &vm_zone_stat[i]);
-			changes++;
+			changed = true;
 	}
 
 	for (i = 0; i < NR_VM_NODE_STAT_ITEMS; i++)
 		if (node_diff[i]) {
 			atomic_long_add(node_diff[i], &vm_node_stat[i]);
-			changes++;
+			changed = true;
 	}
-	return changes;
+	return changed;
 }
 
 /*
@@ -806,16 +806,16 @@ static int fold_diff(int *zone_diff, int *node_diff)
  * with the global counters. These could cause remote node cache line
  * bouncing and will have to be only done when necessary.
  *
- * The function returns the number of global counters updated.
+ * The function returns whether global counters were updated.
  */
-static int refresh_cpu_vm_stats(bool do_pagesets)
+static bool refresh_cpu_vm_stats(bool do_pagesets)
 {
 	struct pglist_data *pgdat;
 	struct zone *zone;
 	int i;
 	int global_zone_diff[NR_VM_ZONE_STAT_ITEMS] = { 0, };
 	int global_node_diff[NR_VM_NODE_STAT_ITEMS] = { 0, };
-	int changes = 0;
+	bool changed = false;
 
 	for_each_populated_zone(zone) {
 		struct per_cpu_zonestat __percpu *pzstats = zone->per_cpu_zonestats;
@@ -839,7 +839,8 @@ static int refresh_cpu_vm_stats(bool do_pagesets)
 		if (do_pagesets) {
 			cond_resched();
 
-			changes += decay_pcp_high(zone, this_cpu_ptr(pcp));
+			if (decay_pcp_high(zone, this_cpu_ptr(pcp)))
+				changed = true;
 #ifdef CONFIG_NUMA
 			/*
 			 * Deal with draining the remote pageset of this
@@ -861,13 +862,13 @@ static int refresh_cpu_vm_stats(bool do_pagesets)
 			}
 
 			if (__this_cpu_dec_return(pcp->expire)) {
-				changes++;
+				changed = true;
 				continue;
 			}
 
 			if (__this_cpu_read(pcp->count)) {
 				drain_zone_pages(zone, this_cpu_ptr(pcp));
-				changes++;
+				changed = true;
 			}
 #endif
 		}
@@ -887,8 +888,9 @@ static int refresh_cpu_vm_stats(bool do_pagesets)
 		}
 	}
 
-	changes += fold_diff(global_zone_diff, global_node_diff);
-	return changes;
+	if (fold_diff(global_zone_diff, global_node_diff))
+		changed = true;
+	return changed;
 }
 
 /*
-- 
2.47.3

