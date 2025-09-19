Return-Path: <linux-kernel+bounces-825150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD12BB8B1ED
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 21:52:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 922CA1B28A5A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 19:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD3D8322532;
	Fri, 19 Sep 2025 19:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JlMghjxD"
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4714F2D0267
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 19:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758311550; cv=none; b=uxD9Bj5EZrX2avZzwH18UoUPsUA1QiFnUxWJZ75mhFz7GFBd/Ce+NA4WHqSbK6MNngAwdLx3mr06VQqvaHZVuVhRtgV5FkIV6NA1SMBzXtM2V/40dmH2i1RzDnTmgrDc5jmtsCv9yQBncJEWKCs1oirz09BLpbnbIsSxyE5vhjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758311550; c=relaxed/simple;
	bh=dgs8/FCp3I80HNIj6iXMInXrKCLpOwWYIK2D6ydLQfg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JqzBmjLtudhQNDeaY/3OdJz0VPM2+gAqgJABbnfkhkLq/bLDrXymuF0wXogoAc3QqCemaLhoooKitNpx+76fjp4hdd+DgYwa35nwXx10LF96hK6VtxHTQNVWghWJyMAOws8PqjtP3pfmHh+C2EyL0so2hJ9KxXRfBMT3QdmvKNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JlMghjxD; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e970e624b7cso3378448276.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 12:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758311546; x=1758916346; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PNokewsZJe0VctGE28J9Sg6BSEv7Rs3SI9ltzwt8Wv8=;
        b=JlMghjxDaRyCaj5ecq7gTaxS1k3K5S1ErZPMm7rxSQxaBd2OYcVgonpWavDVYlQPxq
         eMWTdY5bxw18DBida3WS7RAr504EM52fKhaK1ZFoTgXpn9l5LQhIAhIVOgltybZrl2ar
         EJnxTMG+pY3uB9Ifcyj729ooMSKM9JvXDY5cIsPrhP/qz12JXi76q7SCvvDezLSdYV13
         IaJ6RnrtzdyhkRhCkSa85IoUjx0WbS8JFdxZIQiCZf9lyHHxgzZ1eY3mbomHmvRpSC0X
         mq0GvZ01uugrjdhEgJM7JYs+jVSXmZ5juaFVDlPr0c7BouWKUA9ObB+GHbTxIzibHSph
         U0zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758311546; x=1758916346;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PNokewsZJe0VctGE28J9Sg6BSEv7Rs3SI9ltzwt8Wv8=;
        b=GJFgdneZevgLwEuhp24HkGdJs2kUP/qo8MmHtHQigna+BTe0eZpUVoja4d3HYXb19Z
         2ClNw5Rpxlj/T7fz0ehPWDWLmjSNUFeL7BkzGgYEZS58w6zM8GlaW7uRTJhHf6PQ5dLr
         9vRb+zHVOfYMjkTkGhV4VKwc/L+WjXn/Wf80J3Du8v1+Q7jvRbhqE5MOdGXn19msULFj
         f2BxUkNyrahlEnB9XjNh0FMSt9e2okxkW5ugOx7mez2mlpqyZtQPlQoQkS5ucnFY6Pe5
         l9VOn8KZaQXk3RBh0m/4iY8Huiv+tai/gKEdezKnJSQApxNn8QldxF+JaZgEXOkTk9E8
         d8XA==
X-Forwarded-Encrypted: i=1; AJvYcCU/TndgHy4fguVrZAVbSCxf2NLgr++A0nbHU1zaOkoFEqivyT/tGhAYsQ17EvIqL3jR55+Dk+EOT0WM/EU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNPgsqogTiAni36SX+ee1oiQdgEoszIw0XSNO46hsFpAHdjrJr
	1I3/HsCS2PIQ/Bo5GYXBiqtVqtn54H1KqPOtl7XhnIpJIofOuM05fsgo
X-Gm-Gg: ASbGnctaGfYqK1swInsQMnsHqpFltJCRrvFD9llkQbIjhFwolkZXxNmChJOQtXm4QDt
	tBZTgxpy07bT3z1Iiqzyc5iIXAWLKq2QErweWmzzADdBo9bolIYJ6Iq8VK8ojRoNGQFD13zPa0P
	RvRmzkrC4yOWTj9oRHTKyTP99z7ELU1bKP6ZTBMXkkvFYKznqREieZ7EN0gxH+gc3fdMCzqHsJD
	acjBA0lqaDRHWkIFMYhLbqVsJFQaE87aylcL7ods6U/YGeutsMMU/pZEKrHiJhViTtB8A4EGRxA
	kbJqqWOJMIvvl85cjI2QEBYxWlY80LkfXnwONVUSLIeOnUEDGKoMDZVvqv2sHAcruYizbQiCkBz
	bt4kjglknf+CgdzdxUumAZVHpWMcdYbu4fGZg1WDi4hVj53T8WeVM
X-Google-Smtp-Source: AGHT+IGiHhqEEGk8maRWdeb2WQIByD25ZoDI5E5e1pECrjiWUHQigM38gM3n9qWST+GwllEBBEo01w==
X-Received: by 2002:a05:690c:9506:b0:733:aa00:3860 with SMTP id 00721157ae682-739708ca5b2mr60891147b3.23.1758311545864;
        Fri, 19 Sep 2025 12:52:25 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:6::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-744a3110618sm1682767b3.13.2025.09.19.12.52.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 12:52:25 -0700 (PDT)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>
Cc: Chris Mason <clm@fb.com>,
	Kiryl Shutsemau <kirill@shutemov.name>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Brendan Jackman <jackmanb@google.com>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Zi Yan <ziy@nvidia.com>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	kernel-team@meta.com
Subject: [PATCH 1/4] mm/page_alloc/vmstat: Simplify refresh_cpu_vm_stats change detection
Date: Fri, 19 Sep 2025 12:52:19 -0700
Message-ID: <20250919195223.1560636-2-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250919195223.1560636-1-joshua.hahnjy@gmail.com>
References: <20250919195223.1560636-1-joshua.hahnjy@gmail.com>
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

Signed-off-by: Joshua Hahn <joshua.hahnjy@gmail.com>
---
 include/linux/gfp.h |  2 +-
 mm/page_alloc.c     |  8 ++++----
 mm/vmstat.c         | 26 +++++++++++++-------------
 3 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/include/linux/gfp.h b/include/linux/gfp.h
index 5ebf26fcdcfa..63c72cb1d117 100644
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
index d1d037f97c5f..77e7d9a5f149 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -2561,10 +2561,10 @@ static int rmqueue_bulk(struct zone *zone, unsigned int order,
  * Called from the vmstat counter updater to decay the PCP high.
  * Return whether there are addition works to do.
  */
-int decay_pcp_high(struct zone *zone, struct per_cpu_pages *pcp)
+bool decay_pcp_high(struct zone *zone, struct per_cpu_pages *pcp)
 {
 	int high_min, to_drain, batch;
-	int todo = 0;
+	bool todo;
 
 	high_min = READ_ONCE(pcp->high_min);
 	batch = READ_ONCE(pcp->batch);
@@ -2577,7 +2577,7 @@ int decay_pcp_high(struct zone *zone, struct per_cpu_pages *pcp)
 		pcp->high = max3(pcp->count - (batch << CONFIG_PCP_BATCH_SCALE_MAX),
 				 pcp->high - (pcp->high >> 3), high_min);
 		if (pcp->high > high_min)
-			todo++;
+			todo = true;
 	}
 
 	to_drain = pcp->count - pcp->high;
@@ -2585,7 +2585,7 @@ int decay_pcp_high(struct zone *zone, struct per_cpu_pages *pcp)
 		spin_lock(&pcp->lock);
 		free_pcppages_bulk(zone, to_drain, pcp, 0);
 		spin_unlock(&pcp->lock);
-		todo++;
+		todo = true;
 	}
 
 	return todo;
diff --git a/mm/vmstat.c b/mm/vmstat.c
index 71cd1ceba191..1f74a3517ab2 100644
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
@@ -839,7 +839,7 @@ static int refresh_cpu_vm_stats(bool do_pagesets)
 		if (do_pagesets) {
 			cond_resched();
 
-			changes += decay_pcp_high(zone, this_cpu_ptr(pcp));
+			changed |= decay_pcp_high(zone, this_cpu_ptr(pcp));
 #ifdef CONFIG_NUMA
 			/*
 			 * Deal with draining the remote pageset of this
@@ -861,13 +861,13 @@ static int refresh_cpu_vm_stats(bool do_pagesets)
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
@@ -887,8 +887,8 @@ static int refresh_cpu_vm_stats(bool do_pagesets)
 		}
 	}
 
-	changes += fold_diff(global_zone_diff, global_node_diff);
-	return changes;
+	changed |= fold_diff(global_zone_diff, global_node_diff);
+	return changed;
 }
 
 /*
-- 
2.47.3

