Return-Path: <linux-kernel+bounces-851238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94A58BD5E1D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 21:08:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A7403E41DA
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 19:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBAAB2D978A;
	Mon, 13 Oct 2025 19:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y5zI4YP+"
Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B04922C21EA
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 19:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760382499; cv=none; b=UrnBTUvhSk4cyNoJaGwx76Z14peAw0vvdXhWswEY7Oioi8Ih7aXSTd8g34BdIFNYwByv6W7WC5EFzl60nwdAPCUwNe6LL5gu2V3vIHzKX7EiLtzPNIhSsF6Qp9TjKY+Yt1KqKWYFL0bb+sIvwBQeplm5ul2VD6IZRg9R3KBy1B8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760382499; c=relaxed/simple;
	bh=bCS44l/LvBBitJnnk4ob4XEeLl5p3PQtQuAfvJHhxEs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gp3TIV71ng90rGSjUeVjxLe7YsOH9Jefx9sn6JDAp+nuhQp+5hVtg3T+cm9FqQu6M6URUZV+2mHnbaTrYDiqiVyP0NhTTgzwgcnz85WVH1PmSvJhqiXsJ0Yit4DaJm/LUhqPncKPprvJ5IPcS5e67UsEvuGqzuzFVtAPUfqS0y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y5zI4YP+; arc=none smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-6361a421b67so4702260d50.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 12:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760382494; x=1760987294; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DaKsUlhHVYzGr/qaa9OrQYufYtYEbalh3sXBUEUgogU=;
        b=Y5zI4YP+0m4h2ptSPJA4qAoC6Yd2p+vTLVRvOnji6K9RY8NiyxbRnAYb8i4V9DEfL2
         ucI3B6/zf/R0AX4J2D77pVGZyHrn8hEfK2T9Ar2dDsEoG/g9STa1FIaEwVBYIbieBVrM
         +jeiqoXvRdyqoRfdhKz1Sq49t3fcL1FdDHUZ0qua4ev25vialg9afjAk72K3ahVBGFc0
         5M0F+dXzWDI3UJM9SCzAykHyXdRaI10yV/vv/ZYWldXfmLaUsLxODtAp65fwUNMcWhT/
         gJn9IPPV3W7/zWpgMDDcTeFiyqRXeIeaTbE2pXX+/stJ/uC86OK+RcaeftA89AHKGuFy
         9iQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760382494; x=1760987294;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DaKsUlhHVYzGr/qaa9OrQYufYtYEbalh3sXBUEUgogU=;
        b=JvMHUcJFxPbnkquTPnHT5xdLwYZSW8wVLPdzIkPZvs5xLX9pX4BCoF46oxBxvbp7G9
         XaqczXFDziHpK9oG6gEk9oFCGMqvnBu+L5s1XfEEVtQiEv1fZj4/vie+lPJElzmnzA5t
         Dq1YV10NioY2e7fCO7vxGDIVhGJs4JPj2B6AxMFlbYEwUwDIHFjheB5980RqNpYxObb9
         0ZHjJS5GIgMvVq9tifGPubX3OJrLVMwAMExp7yYwsj1jX6OSR1sztwaTN07BdG/1t2k6
         SfSXEjwolhp7vojKSf4kUQdj1S28xAOhNktuWnG3QM0RGvOsKxaHKDpevN7EhtxVrc2m
         sPZA==
X-Forwarded-Encrypted: i=1; AJvYcCXUVcXvArv0MGfpR9ePhCNDKhg/Lsv/9u+Am0HENnJDQek7880/sjlCcU85gU1/jOs+WD5AxhiZ1qi8nOw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEHsX41eR1GZJYcSb05wlydmerSssjtNPAjcxPkpOUlndyZKyP
	dc3zrqLcrYWQOHhRvnomCEAGiNSKN/5zHn+tAM0ngvzsOsUrOY3e8ECc
X-Gm-Gg: ASbGnctHky41LW1T5E5Sihg62aWcbiiDSU5VE8HU+YoxsuZdk2S/ZsvQdk8iuWgGh4i
	BgEujIuDm2dMzAWMF8J7V8PI34/dssRiJ+cjd+zo1i8eJrWXUs9zV02oam1+WbtNXXx6eU6D0Wn
	KL3QwnK3i9gaFgVFKNCUzhj9uFz4tSsc7s0kqine6Uu8ObR7h7VGMf50F5SjqCJNlzLmENYrlTA
	Sw1mPToxs9igW05I3luPlbgjzPi6Ibtc/mMiyMlltZR6+WSdppAJo2Qf5IBU/I9PI3wSse0Vvdw
	2/SXzv6NeQmU7PMlcCotR2WlmBKOHDfPh1hEM6WXi/2/DxtMa+YVLVBGNbH7F7yvPtlbNwaajBq
	MxZ6KmAg93Q/91He6jAdxLH92ebXM6xLUXHJIAd9XNK3H05XlL0tTrVmzYAeFhh/CU2KPF1VrUp
	C9nI/mHXJslqM+Ew3tsSA=
X-Google-Smtp-Source: AGHT+IHCF7ulcRqtzOcwLOSypYkVBjLtTayORGayA5ndYRP3Xnuskyn2V4s/3SPUaOLMHR0F/AXzvA==
X-Received: by 2002:a05:690e:164f:b0:63c:db25:6406 with SMTP id 956f58d0204a3-63cdb2584d8mr10560890d50.42.1760382494512;
        Mon, 13 Oct 2025 12:08:14 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:73::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-63cd9524284sm4219891d50.10.2025.10.13.12.08.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 12:08:14 -0700 (PDT)
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
	linux-mm@kvack.org
Subject: [PATCH v4 1/3] mm/page_alloc/vmstat: Simplify refresh_cpu_vm_stats change detection
Date: Mon, 13 Oct 2025 12:08:09 -0700
Message-ID: <20251013190812.787205-2-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251013190812.787205-1-joshua.hahnjy@gmail.com>
References: <20251013190812.787205-1-joshua.hahnjy@gmail.com>
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

