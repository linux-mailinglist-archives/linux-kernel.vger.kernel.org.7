Return-Path: <linux-kernel+bounces-588183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A37A4A7B589
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Apr 2025 03:42:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC4381893C2E
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Apr 2025 01:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6E17139566;
	Fri,  4 Apr 2025 01:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KPfX6ZHI"
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0242E1C68F
	for <linux-kernel@vger.kernel.org>; Fri,  4 Apr 2025 01:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743730817; cv=none; b=KuanHcjdZ0yPqdrONgGLWWsS+XYG4hgU9kIRpurVxs/bTg5z9yKyOVGYr3eYKXNji9TkGfdo+jflZbR/1ehdklafO948qvyqHkh6nia1s3cp0AaYilfxuM4qDIQDdHyM1RAw3ue+5H+SvdKOIq2N0bRbZ99uIzrxXyAx3dEaw+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743730817; c=relaxed/simple;
	bh=64ozTxNy9/NL2y4BP7GPrE/FG/Mi0eKug5/IuaJS+oA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yd1PgTzZhr1Qm3XUL+/z92+CRW05i7KxnvDdr9vHUE2L8fqUxZS/u7Y7ywMZDh5s0slPVHHqT4f5Qz3NGOhYxqkbMPE5MZ11HpwlM4OKTAz0+u1vRlH7bjfnB7yWzs2ZAq+j0JWpO8Ds5WRFHI6YKgrCnyJEYJifnASV+YHDCX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KPfX6ZHI; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1743730811;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LinbyHoyL8uDgkz9AbaMIU/FLYmhkY77RaZleKlI73I=;
	b=KPfX6ZHIo7QLJYz3cLSaUbA9qUfdz6+B466oIXkRVPsjNMHLcENHjHfJsbZm+4sbWA5td8
	1lLF2cpN8C2iPDJDTYMBpMF5OXvKXUAyN91ExOYDInH31LiE00A4zfzwBlcq1lPGB7Uyte
	VvydzWMFlqbGHQkrfNiqQ6U8NBAcNrc=
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Vlastimil Babka <vbabka@suse.cz>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>
Subject: [PATCH v2 8/9] memcg: combine slab obj stock charging and accounting
Date: Thu,  3 Apr 2025 18:39:12 -0700
Message-ID: <20250404013913.1663035-9-shakeel.butt@linux.dev>
In-Reply-To: <20250404013913.1663035-1-shakeel.butt@linux.dev>
References: <20250404013913.1663035-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Vlastimil Babka <vbabka@suse.cz>

When handing slab objects, we use obj_cgroup_[un]charge() for
(un)charging and mod_objcg_state() to account NR_SLAB_[UN]RECLAIMABLE_B.
All these operations use the percpu stock for performance. However with
the calls being separate, the stock_lock is taken twice in each case.

By refactoring the code, we can turn mod_objcg_state() into
__account_obj_stock() which is called on a stock that's already locked
and validated. On the charging side we can call this function from
consume_obj_stock() when it succeeds, and refill_obj_stock() in the
fallback. We just expand parameters of these functions as necessary.
The uncharge side from __memcg_slab_free_hook() is just the call to
refill_obj_stock().

Other callers of obj_cgroup_[un]charge() (i.e. not slab) simply pass the
extra parameters as NULL/zeroes to skip the __account_obj_stock()
operation.

In __memcg_slab_post_alloc_hook() we now charge each object separately,
but that's not a problem as we did call mod_objcg_state() for each
object separately, and most allocations are non-bulk anyway. This
could be improved by batching all operations until slab_pgdat(slab)
changes.

Some preliminary benchmarking with a kfree(kmalloc()) loop of 10M
iterations with/without __GFP_ACCOUNT:

Before the patch:
kmalloc/kfree !memcg:    581390144 cycles
kmalloc/kfree memcg:     783689984 cycles

After the patch:
kmalloc/kfree memcg:     658723808 cycles

More than half of the overhead of __GFP_ACCOUNT relative to
non-accounted case seems eliminated.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
Reviewed-by: Roman Gushchin <roman.gushchin@linux.dev>
Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
---
 mm/memcontrol.c | 77 +++++++++++++++++++++++++++++--------------------
 1 file changed, 46 insertions(+), 31 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 33aeddfff0ba..3bb02f672e39 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2774,25 +2774,17 @@ static void replace_stock_objcg(struct memcg_stock_pcp *stock,
 	WRITE_ONCE(stock->cached_objcg, objcg);
 }
 
-static void mod_objcg_state(struct obj_cgroup *objcg, struct pglist_data *pgdat,
-		     enum node_stat_item idx, int nr)
+static void __account_obj_stock(struct obj_cgroup *objcg,
+				struct memcg_stock_pcp *stock, int nr,
+				struct pglist_data *pgdat, enum node_stat_item idx)
 {
-	struct memcg_stock_pcp *stock;
-	unsigned long flags;
 	int *bytes;
 
-	local_lock_irqsave(&memcg_stock.stock_lock, flags);
-	stock = this_cpu_ptr(&memcg_stock);
-
 	/*
 	 * Save vmstat data in stock and skip vmstat array update unless
-	 * accumulating over a page of vmstat data or when pgdat or idx
-	 * changes.
+	 * accumulating over a page of vmstat data or when pgdat changes.
 	 */
-	if (READ_ONCE(stock->cached_objcg) != objcg) {
-		replace_stock_objcg(stock, objcg);
-		stock->cached_pgdat = pgdat;
-	} else if (stock->cached_pgdat != pgdat) {
+	if (stock->cached_pgdat != pgdat) {
 		/* Flush the existing cached vmstat data */
 		struct pglist_data *oldpg = stock->cached_pgdat;
 
@@ -2829,11 +2821,10 @@ static void mod_objcg_state(struct obj_cgroup *objcg, struct pglist_data *pgdat,
 	}
 	if (nr)
 		__mod_objcg_mlstate(objcg, pgdat, idx, nr);
-
-	local_unlock_irqrestore(&memcg_stock.stock_lock, flags);
 }
 
-static bool consume_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes)
+static bool consume_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes,
+			      struct pglist_data *pgdat, enum node_stat_item idx)
 {
 	struct memcg_stock_pcp *stock;
 	unsigned long flags;
@@ -2845,6 +2836,9 @@ static bool consume_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes)
 	if (objcg == READ_ONCE(stock->cached_objcg) && stock->nr_bytes >= nr_bytes) {
 		stock->nr_bytes -= nr_bytes;
 		ret = true;
+
+		if (pgdat)
+			__account_obj_stock(objcg, stock, nr_bytes, pgdat, idx);
 	}
 
 	local_unlock_irqrestore(&memcg_stock.stock_lock, flags);
@@ -2929,7 +2923,8 @@ static bool obj_stock_flush_required(struct memcg_stock_pcp *stock,
 }
 
 static void refill_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes,
-			     bool allow_uncharge)
+		bool allow_uncharge, int nr_acct, struct pglist_data *pgdat,
+		enum node_stat_item idx)
 {
 	struct memcg_stock_pcp *stock;
 	unsigned long flags;
@@ -2944,6 +2939,9 @@ static void refill_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes,
 	}
 	stock->nr_bytes += nr_bytes;
 
+	if (pgdat)
+		__account_obj_stock(objcg, stock, nr_acct, pgdat, idx);
+
 	if (allow_uncharge && (stock->nr_bytes > PAGE_SIZE)) {
 		nr_pages = stock->nr_bytes >> PAGE_SHIFT;
 		stock->nr_bytes &= (PAGE_SIZE - 1);
@@ -2955,12 +2953,13 @@ static void refill_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes,
 		obj_cgroup_uncharge_pages(objcg, nr_pages);
 }
 
-int obj_cgroup_charge(struct obj_cgroup *objcg, gfp_t gfp, size_t size)
+static int obj_cgroup_charge_account(struct obj_cgroup *objcg, gfp_t gfp, size_t size,
+				     struct pglist_data *pgdat, enum node_stat_item idx)
 {
 	unsigned int nr_pages, nr_bytes;
 	int ret;
 
-	if (consume_obj_stock(objcg, size))
+	if (likely(consume_obj_stock(objcg, size, pgdat, idx)))
 		return 0;
 
 	/*
@@ -2993,15 +2992,21 @@ int obj_cgroup_charge(struct obj_cgroup *objcg, gfp_t gfp, size_t size)
 		nr_pages += 1;
 
 	ret = obj_cgroup_charge_pages(objcg, gfp, nr_pages);
-	if (!ret && nr_bytes)
-		refill_obj_stock(objcg, PAGE_SIZE - nr_bytes, false);
+	if (!ret && (nr_bytes || pgdat))
+		refill_obj_stock(objcg, nr_bytes ? PAGE_SIZE - nr_bytes : 0,
+					 false, size, pgdat, idx);
 
 	return ret;
 }
 
+int obj_cgroup_charge(struct obj_cgroup *objcg, gfp_t gfp, size_t size)
+{
+	return obj_cgroup_charge_account(objcg, gfp, size, NULL, 0);
+}
+
 void obj_cgroup_uncharge(struct obj_cgroup *objcg, size_t size)
 {
-	refill_obj_stock(objcg, size, true);
+	refill_obj_stock(objcg, size, true, 0, NULL, 0);
 }
 
 static inline size_t obj_full_size(struct kmem_cache *s)
@@ -3053,23 +3058,32 @@ bool __memcg_slab_post_alloc_hook(struct kmem_cache *s, struct list_lru *lru,
 			return false;
 	}
 
-	if (obj_cgroup_charge(objcg, flags, size * obj_full_size(s)))
-		return false;
-
 	for (i = 0; i < size; i++) {
 		slab = virt_to_slab(p[i]);
 
 		if (!slab_obj_exts(slab) &&
 		    alloc_slab_obj_exts(slab, s, flags, false)) {
-			obj_cgroup_uncharge(objcg, obj_full_size(s));
 			continue;
 		}
 
+		/*
+		 * if we fail and size is 1, memcg_alloc_abort_single() will
+		 * just free the object, which is ok as we have not assigned
+		 * objcg to its obj_ext yet
+		 *
+		 * for larger sizes, kmem_cache_free_bulk() will uncharge
+		 * any objects that were already charged and obj_ext assigned
+		 *
+		 * TODO: we could batch this until slab_pgdat(slab) changes
+		 * between iterations, with a more complicated undo
+		 */
+		if (obj_cgroup_charge_account(objcg, flags, obj_full_size(s),
+					slab_pgdat(slab), cache_vmstat_idx(s)))
+			return false;
+
 		off = obj_to_index(s, slab, p[i]);
 		obj_cgroup_get(objcg);
 		slab_obj_exts(slab)[off].objcg = objcg;
-		mod_objcg_state(objcg, slab_pgdat(slab),
-				cache_vmstat_idx(s), obj_full_size(s));
 	}
 
 	return true;
@@ -3078,6 +3092,8 @@ bool __memcg_slab_post_alloc_hook(struct kmem_cache *s, struct list_lru *lru,
 void __memcg_slab_free_hook(struct kmem_cache *s, struct slab *slab,
 			    void **p, int objects, struct slabobj_ext *obj_exts)
 {
+	size_t obj_size = obj_full_size(s);
+
 	for (int i = 0; i < objects; i++) {
 		struct obj_cgroup *objcg;
 		unsigned int off;
@@ -3088,9 +3104,8 @@ void __memcg_slab_free_hook(struct kmem_cache *s, struct slab *slab,
 			continue;
 
 		obj_exts[off].objcg = NULL;
-		obj_cgroup_uncharge(objcg, obj_full_size(s));
-		mod_objcg_state(objcg, slab_pgdat(slab), cache_vmstat_idx(s),
-				-obj_full_size(s));
+		refill_obj_stock(objcg, obj_size, true, -obj_size,
+				 slab_pgdat(slab), cache_vmstat_idx(s));
 		obj_cgroup_put(objcg);
 	}
 }
-- 
2.47.1


