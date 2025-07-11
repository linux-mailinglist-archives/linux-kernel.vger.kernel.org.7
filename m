Return-Path: <linux-kernel+bounces-727872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BA04B020E4
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 17:52:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27CA43B5A22
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 15:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 142C82ED844;
	Fri, 11 Jul 2025 15:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DuJCnggh"
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA9C17A2EB
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 15:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752249093; cv=none; b=GJ9wUY3a0NmJ8mhtYnLcbRv0gcujmXXOSFU6+IvRkxNnSi7Lf5VpkmdWxgbl6CCIsi17xBXw942YWFv82VAq7qCwBN6uZzyY2ngMH+iHqf2Pfj9/VjSLKrIq6c5L5dLclFNuXFCPl5coe8gGpzSK3RXEGnq56ZwvgNF6KOqiRRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752249093; c=relaxed/simple;
	bh=Y7tskn+wvwD80B5KsW9O6pt9X9FH85Y6FdSt8e/Ys+Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Kg758TPwEeSoka2s8go6k07UAyMKoTdDtlzLhuTBuSuWndU1Ad1fTIQxZTabj6MeAnBvc2vdCeTCTigazBusV333w2S3vObJQjUkj43ZPFPqrMr/m2Jw1mdtjCTZnhnviSI4A/tf6zxQoR/YkjuHytY+k5aGiX4pM3p3A4MMamM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DuJCnggh; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752249087;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=vPqNoVEMPHsyv6LMrHTUjHJt39CUZ7GoudiGKQX0R+8=;
	b=DuJCngghyOuTGnjJgaqwiJyoGxHbZfB41026zWXq6K8PBseQzUFN9BeVxm8yp+avaiBv64
	tcA+F0irPhBkZYEVlSzxcMXi9aESY6uGfCq/mO6G/iQmdW3vrf4v9WbYZ6Zl+YT8PzqsuC
	vfJmUXSDsqTVMKITXBm7/1nyg2f1TXM=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Michal Hocko <mhocko@kernel.org>,
	David Hildenbrand <david@redhat.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Roman Gushchin <roman.gushchin@linux.dev>
Subject: [PATCH] mm: skip lru_note_cost() when scanning only file or anon
Date: Fri, 11 Jul 2025 08:50:44 -0700
Message-ID: <20250711155044.137652-1-roman.gushchin@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

lru_note_cost() records relative cost of incurring io and cpu spent
on lru rotations, which is used to balance the pressure on file and
anon memory. The applied pressure is inversely proportional to the
recorded cost of reclaiming, but only within 2/3 of the range
(swappiness aside).

This is useful when both anon and file memory is reclaimable, however
in many cases it's not the case: e.g. there might be no swap,
proactive reclaim can target anon memory specifically,
the memory pressure can come from cgroup v1's memsw limit, etc.
In all these cases recording the cost will only bias all following
reclaim, also potentially outside of the scope of the original memcg.

So it's better to not record the cost if it comes from the initially
biased reclaim.

lru_note_cost() is a relatively expensive function, which traverses
the memcg tree up to the root and takes the lruvec lock on each level.
Overall it's responsible for about 50% of cycles spent on lruvec lock,
which might be a non-trivial number overall under heavy memory
pressure. So optimizing out a large number of lru_note_cost() calls
is also beneficial from the performance perspective.

Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
---
 mm/vmscan.c | 34 +++++++++++++++++++++++++---------
 1 file changed, 25 insertions(+), 9 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index c86a2495138a..33fd67eab0c9 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -71,6 +71,13 @@
 #define CREATE_TRACE_POINTS
 #include <trace/events/vmscan.h>
 
+enum scan_balance {
+	SCAN_EQUAL,
+	SCAN_FRACT,
+	SCAN_ANON,
+	SCAN_FILE,
+};
+
 struct scan_control {
 	/* How many pages shrink_list() should reclaim */
 	unsigned long nr_to_reclaim;
@@ -90,6 +97,7 @@ struct scan_control {
 	/*
 	 * Scan pressure balancing between anon and file LRUs
 	 */
+	enum scan_balance scan_balance;
 	unsigned long	anon_cost;
 	unsigned long	file_cost;
 
@@ -1988,6 +1996,17 @@ static int current_may_throttle(void)
 	return !(current->flags & PF_LOCAL_THROTTLE);
 }
 
+static bool scan_balance_biased(struct scan_control *sc)
+{
+	switch (sc->scan_balance) {
+	case SCAN_EQUAL:
+	case SCAN_FRACT:
+		return false;
+	default:
+		return true;
+	}
+}
+
 /*
  * shrink_inactive_list() is a helper for shrink_node().  It returns the number
  * of reclaimed pages
@@ -2054,7 +2073,9 @@ static unsigned long shrink_inactive_list(unsigned long nr_to_scan,
 	__count_vm_events(PGSTEAL_ANON + file, nr_reclaimed);
 	spin_unlock_irq(&lruvec->lru_lock);
 
-	lru_note_cost(lruvec, file, stat.nr_pageout, nr_scanned - nr_reclaimed);
+	if (!scan_balance_biased(&sc))
+		lru_note_cost(lruvec, file, stat.nr_pageout,
+			      nr_scanned - nr_reclaimed);
 
 	/*
 	 * If dirty folios are scanned that are not queued for IO, it
@@ -2202,7 +2223,7 @@ static void shrink_active_list(unsigned long nr_to_scan,
 	__mod_node_page_state(pgdat, NR_ISOLATED_ANON + file, -nr_taken);
 	spin_unlock_irq(&lruvec->lru_lock);
 
-	if (nr_rotated)
+	if (nr_rotated && !scan_balance_biased(&sc))
 		lru_note_cost(lruvec, file, 0, nr_rotated);
 	trace_mm_vmscan_lru_shrink_active(pgdat->node_id, nr_taken, nr_activate,
 			nr_deactivate, nr_rotated, sc->priority, file);
@@ -2327,13 +2348,6 @@ static bool inactive_is_low(struct lruvec *lruvec, enum lru_list inactive_lru)
 	return inactive * inactive_ratio < active;
 }
 
-enum scan_balance {
-	SCAN_EQUAL,
-	SCAN_FRACT,
-	SCAN_ANON,
-	SCAN_FILE,
-};
-
 static void prepare_scan_control(pg_data_t *pgdat, struct scan_control *sc)
 {
 	unsigned long file;
@@ -2613,6 +2627,8 @@ static void get_scan_count(struct lruvec *lruvec, struct scan_control *sc,
 	calculate_pressure_balance(sc, swappiness, fraction, &denominator);
 
 out:
+	sc->scan_balance = scan_balance;
+
 	for_each_evictable_lru(lru) {
 		bool file = is_file_lru(lru);
 		unsigned long lruvec_size;
-- 
2.50.0


