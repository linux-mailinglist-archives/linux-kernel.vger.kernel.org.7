Return-Path: <linux-kernel+bounces-831244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B1476B9C2DD
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 22:44:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53D0716B1A7
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 20:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 092D632A3DE;
	Wed, 24 Sep 2025 20:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ITlU24+l"
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 814A2329F12
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 20:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758746654; cv=none; b=SZx7mK0TYYzKerVBdKv+hMUbVFpUEnha6Dw5LRxeYR8PzvEXwWREnxoDP7n7Z/55jcoUniOGEAVRy+2DQ00m+M0JZjBZ+NMmpn4f6Uecn23a1TjurSC882pr0CNN58QH/8hPSthiBTT0jPmMcwBODyCZRq64QUsCRoaUYNweGfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758746654; c=relaxed/simple;
	bh=dgs8/FCp3I80HNIj6iXMInXrKCLpOwWYIK2D6ydLQfg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mrk6n/tgXyKy35JsPPcZnYGD2xf7djjytGhII72gFXO5/qMjwgyysg17B9ByX/vtBcB4Wj7+mWTqOlVpIxKyl3440jFyl5P5hvv9ZMqqMTsNBuJuy2sEuCel+qmcnBa6hkOSFOa4HscknBxHU5S3BO3nQ1xQwmYXjeWykYN3rJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ITlU24+l; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-ea5bafdfea3so396112276.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 13:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758746651; x=1759351451; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PNokewsZJe0VctGE28J9Sg6BSEv7Rs3SI9ltzwt8Wv8=;
        b=ITlU24+l/Mjaq1huuGEm3/InxXEBBWFsx3IW1pakBmJbTWGplX3CVvbN2wA70RCvde
         kQUJ8lw6vtWxSur8wFntnlVeOHcyjK8biEZdgZG8dmzunNN/eB6Tx5pjHnpTB5PN1xEp
         SYHOxM0isVE0nxvdW+O1RVUmG3E+Dx84gGzj+3Y59qlATzT3o7qTG5rE3LcJ1CCe8JAw
         4Wv02CLklKckyaL0n53NlTQw9NpL1ALcE7n5e3iq5+7pyypHYEb3MazyNI+NdpH8Fl+R
         3qsQ5J2SrfokuoNoRg7ETJTmvp4A+I5sZAWyf37cHiQE+rhl8s4vjupOmduO7D/lJ+gy
         b5nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758746651; x=1759351451;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PNokewsZJe0VctGE28J9Sg6BSEv7Rs3SI9ltzwt8Wv8=;
        b=eoes+0whtxiu7JpL6tAnjIZK3pc9abBMp33eiq9SQ9Wdc3quDGoGv0vkxKp0FXyr1M
         R/HX8uNEgWKYwNdhEHi0C3Ab9NxjNuDLnioE8rU3Jmrf7A9gmxFjlsaqZvc1dfdigW6O
         JFYr4WSe1S1Odm5CGhWpxmRnFXoNfLXPvDY5qUhQr5X0/DgWIQHiGKnTGkABgU3t1KpD
         t95LBMYtOlG9iQAoOXq3tQsiutfai5llcQ0Y9AmM2hhAuzSx/LQy2/Rc6yY6RGEZwEzu
         qEPyqXBvlJPyg3hPdK4BDFR6QyjEzwQ3/FIcPrmv0AMcK0SrRj4Vu7c4GzDKufpFrVyH
         zgkQ==
X-Forwarded-Encrypted: i=1; AJvYcCXYch17GQviSXoIFhQNE7xbycXO8zzBko1Tnh4Qc1j49pAkMg+KzSmeO55C1mrH1ZM24JItQtf4qCnoQi4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPO/BNofw2iIsr7ylHkn10UrVeiValxYsNMNMWME/Kb1IGHj7Z
	2L9JmIllZBfCmANJXUD2/T4VRTJX1Uwis3Pe1jiFz88iAv9FCHP4lAhP4wiXPA==
X-Gm-Gg: ASbGnctLyxhruVRmqqgX3NfBP+b+tOMrWv+nKiCz3UszL/jZDSSg3BxYYBf6ygXGhXQ
	cbb8W1y/3fofhQwPG56+8ZaagPia1N8FVE4jzNUltIgJzJNeoet6MdaQi0aPqqxJ7FmcC1nyBG8
	RD/hk4BcVgBLXdedFyqf2LZqrF2yYDuBnlMlj38t0j4BcauQWa9VS/cNxgDCdSLQZe2u2He6rGD
	JVgo+wubleGAP7sm2a7cN2/oDwQGInFgVGpJ7Uv30yaUyb4oebt1oV1KvkTRDdNceckjSY2/igN
	Pj5V7ubsi71L8VQvdDUFczA3NxkofTsxkmpJuM1LLZfIJhhJh0NFHorIu482TvhEcXpbSc+Z1eK
	VCEdhFkg3MtVjUli7LQERgKY/tlVb3VhC9pi2yje30y7syNxjQvFrq77by6gTN/SE
X-Google-Smtp-Source: AGHT+IEtnhMrUSu5118Zgn8Uo8thtKK4T5BkpLanD30f6H9lZNNw/jWP4/TLi5rcPqT6btfdPKJlGw==
X-Received: by 2002:a05:6902:4088:b0:ea4:121e:bce5 with SMTP id 3f1490d57ef6-eb37fca9968mr1214255276.35.1758746651438;
        Wed, 24 Sep 2025 13:44:11 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:58::])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-eb38393d51csm8111276.27.2025.09.24.13.44.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 13:44:10 -0700 (PDT)
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
Subject: [PATCH v2 1/4] mm/page_alloc/vmstat: Simplify refresh_cpu_vm_stats change detection
Date: Wed, 24 Sep 2025 13:44:05 -0700
Message-ID: <20250924204409.1706524-2-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250924204409.1706524-1-joshua.hahnjy@gmail.com>
References: <20250924204409.1706524-1-joshua.hahnjy@gmail.com>
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

