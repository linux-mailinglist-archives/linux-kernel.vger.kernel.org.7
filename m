Return-Path: <linux-kernel+bounces-840752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E6D7BBB5258
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 22:46:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A14AA4E547A
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 20:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 548581E1A3B;
	Thu,  2 Oct 2025 20:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WKZcpUuI"
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E140B7261E
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 20:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759438002; cv=none; b=iFH3JgIeMty3BJqg/alThvm2tKjX1DqOmUZ4X9ac1hZoho8SlozKBJD4qHMgpNMNhF0ZvNFrENMzbr1E9bw6yYlWLrXD01PTmOgtjtHhL5K9s4do37o76rc4ntFXmtYejdeWtyrHmGoRxp7d52mfDnkf+tj33y3wVL7XvR1Xeig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759438002; c=relaxed/simple;
	bh=W9YCvKP7YXSdEluBH6DcHRoGcPV0kHwJhzHayQHvHbc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ttyt/sbCMp49mqp8N1Q8LcVYqO/jrML6yeo5HXvbenvRZ00+B63T5J6ln12NYLSUAixBL/Cw5dCiScq7aqbwaspcEued1GTCotcvRjYzA/GSuqcL2MCJOY7yJcyjY6fOh7qLsj4S820xjJHcFe4kEDzXD2E0Ai9e04L8v968H1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WKZcpUuI; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-71d60110772so16013747b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 13:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759438000; x=1760042800; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2jwps1lz6jxYNn7Dnn5Z09tOaOeYs2HTQuW80UbgHqQ=;
        b=WKZcpUuIPT7AZBoCpxHltcYUL3w80yVQZBNSshyJS2OZgpZVrX7V/kLX7ZXEj61f5e
         L/fV/EgGjF8UQRAkfJF1dVgJuOVRMYj9Q9KROjsaikAimE7jgQm+8leEpxgeQidN8Hfb
         HQPZrYJRsVplBe6c6Eeo0Hih1EoFgG+o9tFGsvewjHDGFqWoqqqSNv3LWEYh93qqV9Nz
         iQzcMxDwRcVMoLt3JJf0vthwy+bKZq5HqPbs4f6m7hNvzftMtMFQJUa2YzjXxuF0MiOs
         u8jyZc+nChDTcm4LirtXltWHghQuub9ZS7k2q1oOh4k1rmR5xJb4+5et188dr+HkYBwa
         ikNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759438000; x=1760042800;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2jwps1lz6jxYNn7Dnn5Z09tOaOeYs2HTQuW80UbgHqQ=;
        b=khYgaBfRX4KqboSYE4Ex0fOMIh60Ul/NpwENvyTugTr05bU2NloRKVxxpy/fLicrZ9
         8ucYKnS9hX/mXRxpBp++O2lieuxKg36SCfT9vg5T1XI6XE/vHVfZRUkTpPni4aCDBicO
         l7rDiPoASYlXakXmYpwEEG+jlWsjLGpbk7KrKsYMZdcGDRsBn19C2S8+ZQcNM+19IJbI
         Cxy1Ua2ujovuTwmGQhycSoiuJTf8S80rsfdEbFZmOMoBudksfLoTFzP6d+bkNYTh783c
         INXC4ivAalLeCfFdil8K8fbZnme0KeoEXDFY8XU8sNnPPVMawQdckvI1LWd9G78ABs1I
         ndIg==
X-Forwarded-Encrypted: i=1; AJvYcCVCU6UwKINTSEqz6nxJyvXQsvzE1YqOOlmF8zceq/eEgflMxDU42z4wyi5ubWOm5WIEpSpAZ+iLadthLq0=@vger.kernel.org
X-Gm-Message-State: AOJu0YytInoCnz8kgkgzfTG5FkGdTEy9sjvQsU1lLLKXnN+uW4YLZB8B
	E5h1TRFPIODOQKqqN188PX914JFpOmj5gPT7jJsNe1oq7UMYpk4Te8hH
X-Gm-Gg: ASbGncs82xLwNjt9zh4cJqOn1P+7a2sMGC4VX6Ddc8Kxeivm7PNUY7OW0/QRmzT63lQ
	JW5Y2IjYOGQjYD94IRpmY59obCe7RF0bMM0MAzohHdHDaom40SGINiUjFbG99Mbzhu7jUdCBeQq
	wews23uXHyJ/am8XevVifq9aIkvr5fWkwPEIQ4I4ApzxaxJ0fU2eXYPyf2sWTKXRHvQG8c41jbA
	16xhx8iSa6FookYcrtpv93nXYSYPQJZ1PetrjmduIbhm663AhJPCfaa/5BNE8WsiARRYq2EWqma
	2FSXLw2NDr0/996lLIr+pnvOWJLjXuOdlQQEIHhq3aWaspxzMgUiPiXiKKetGEodXOmOY4pXv18
	GUCu5DswqoUKL+D/phUU4c29/GxlA68RyU6ZS4wpwYFqKO5i6mGH+F8RpQOErwShFCfPQpuZuv7
	8lBw==
X-Google-Smtp-Source: AGHT+IHzWFTSbAUSJS7YF3yHmxIfnxGDKF6Uqmg2CyEoFyCqQ6BTPK8MNk89Gdh1FJmam2OVjyxg6Q==
X-Received: by 2002:a05:690c:6e8e:b0:772:3578:2ec5 with SMTP id 00721157ae682-77f942c2c16mr14178777b3.0.1759437999539;
        Thu, 02 Oct 2025 13:46:39 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:5b::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-77f81e370c7sm11291757b3.55.2025.10.02.13.46.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 13:46:39 -0700 (PDT)
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
Subject: [PATCH v3 1/3] mm/page_alloc/vmstat: Simplify refresh_cpu_vm_stats change detection
Date: Thu,  2 Oct 2025 13:46:31 -0700
Message-ID: <20251002204636.4016712-2-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251002204636.4016712-1-joshua.hahnjy@gmail.com>
References: <20251002204636.4016712-1-joshua.hahnjy@gmail.com>
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
 mm/vmstat.c         | 28 +++++++++++++++-------------
 3 files changed, 20 insertions(+), 18 deletions(-)

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
index 304e12bf2e4e..b9fc357d2d48 100644
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

